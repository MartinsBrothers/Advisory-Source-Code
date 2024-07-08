//+------------------------------------------------------------------+
//| Equity Monitor                                                   |
//| Monitoring balance, equity, margin, profitability and drawdown   |
//+------------------------------------------------------------------+
//| Original idea and code by Xupypr (Igor Korepin)                  |
//| Remake by transcendreamer                                        |
//+------------------------------------------------------------------+
#property copyright "Equity Monitor - original by Xupypr - remake by transcendreamer"
#property description "Monitoring balance, equity, margin, profitability and drawdown"
#property strict

#property indicator_separate_window
#property indicator_buffers 5
#property indicator_color1 SteelBlue
#property indicator_color2 OrangeRed
#property indicator_color3 SlateGray
#property indicator_color4 ForestGreen
#property indicator_color5 Gray
#property indicator_width1 1
#property indicator_width2 1
#property indicator_width3 1
#property indicator_width4 1
#property indicator_width5 1

extern string           ______FILTERS______="______FILTERS______";
extern bool             Only_Trading=false;
extern bool             Only_Current=false;
extern bool             Only_Buys=false;
extern bool             Only_Sells=false;
extern bool             Only_Magics=false;
extern int              Magic_From=0;
extern int              Magic_To=0;
extern string           Only_Symbols="";
extern string           Only_Comment="";
extern string           ______PERIOD______="______PERIOD______";
extern datetime         Draw_Begin=D'2012.01.01 00:00';
extern datetime         Draw_End=D'2035.01.01 00:00';
enum   reporting        {day,month,year,history};
extern reporting        Report_Period=history;
extern string           ______ALERTS______="______ALERTS______";
extern double           Equity_Min_Alert=0;
extern double           Equity_Max_Alert=0;
extern bool             Push_Alerts=false;
extern string           ______LINES______="______LINES______";
extern bool             Show_Balance=true;
extern bool             Show_Margin=false;
extern bool             Show_Free=false;
extern bool             Show_Zero=false;
extern bool             Show_Info=true;
extern bool             Show_Verticals=true;
extern string           ______OTHER______="______OTHER______";
extern ENUM_BASE_CORNER Text_Corner=CORNER_LEFT_UPPER;
extern color            Text_Color=Magenta;
extern string           Text_Font="Tahoma";
extern int              Text_Size=12;
extern bool             File_Write=false;
extern string           FX_prefix="";
extern string           FX_postfix="";

string   ShortName,Unique;
int      DrawBeginBar,DrawEndBar,Window;
double   Equity[],Balance[],Margin[],Free[],Zero[];
double   ResultBalance,ResultProfit,GrowthRatio;
double   ProfitLoss,Spread,SumMargin,LotValue;
double   PeakProfit,PeakEquity,MaxDrawdown,RelDrawdown;
double   SumProfit,SumLoss,NetProfit;
double   RecoveryFactor,ProfitFactor,Profitability;
string   Instrument[];
datetime OpenTime_Ticket[][2],CloseTime[];
int      OpenBar[],CloseBar[],Type[];
double   Lots[],OpenPrice[],ClosePrice[],Commission[],Swap[],CumSwap[],DaySwap[],Profit[];
datetime start_time,finish_time;
int      Total,HistoryTotal,OpenTotal;
string   missing_symbols;
bool     alert_upper_active,alert_lower_active;
bool     using_filters;
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
   using_filters=false;
   if(Only_Symbols!="")    using_filters=true;
   if(Only_Comment!="")    using_filters=true;
   if(Only_Current)        using_filters=true;
   if(Only_Buys)           using_filters=true;
   if(Only_Sells)          using_filters=true;
   if(Only_Magics)         using_filters=true;

   if(!using_filters)
      ShortName="Total"; else ShortName="";
   if(Only_Symbols!="")
      ShortName=StringConcatenate(ShortName," ",Only_Symbols);
   else if(Only_Current)
      ShortName=StringConcatenate(ShortName," ",Symbol());
   if(Only_Magics)
      ShortName=StringConcatenate(ShortName," #",Magic_From,":",Magic_To);
   if(Only_Comment!="")
      ShortName=StringConcatenate(ShortName," [",Only_Comment,"]");
   if(Only_Buys && !Only_Sells)
      ShortName=StringConcatenate(ShortName," Buys");
   if(Only_Sells && !Only_Buys)
      ShortName=StringConcatenate(ShortName," Sells");
   if(Only_Trading)
      ShortName=StringConcatenate(ShortName," Trading");

   SetIndexBuffer(0,Equity);
   SetIndexBuffer(1,Balance);
   SetIndexBuffer(2,Margin);
   SetIndexBuffer(3,Free);
   SetIndexBuffer(4,Zero);
   SetIndexLabel(0,"Equity");
   SetIndexLabel(1,"Balance");
   SetIndexLabel(2,"Margin");
   SetIndexLabel(3,"Free");
   SetIndexLabel(4,"Zero");
   SetIndexStyle(0,DRAW_LINE);
   SetIndexStyle(1,DRAW_LINE);
   SetIndexStyle(2,DRAW_HISTOGRAM);
   SetIndexStyle(3,DRAW_LINE);
   SetIndexStyle(4,DRAW_LINE);

   ShortName                 =StringConcatenate(ShortName," Equity");
   if(Show_Balance) ShortName=StringConcatenate(ShortName," Balance");
   if(Show_Margin)  ShortName=StringConcatenate(ShortName," Margin");
   if(Show_Free)    ShortName=StringConcatenate(ShortName," Free");

   Unique=(string)ChartID()+(string)ChartWindowFind();
   DrawBeginBar=iBarShift(NULL,0,Draw_Begin);
   DrawEndBar=iBarShift(NULL,0,Draw_End);

   if(Equity_Max_Alert!=0) alert_upper_active=true; else alert_upper_active=false;
   if(Equity_Min_Alert!=0) alert_lower_active=true; else alert_lower_active=false;

   IndicatorDigits(2);
   return(0);
  }
//+------------------------------------------------------------------+
//| Custom indicator deinitialization function                       |
//+------------------------------------------------------------------+
int deinit()
  {
   DeleteAll();
   return(0);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int start()
  {
   if(!CheckConditions()) return(0);
   bool restart=false;
   if(CheckNewBar()) restart=true;
   if(CheckNewOrder()) restart=true;
   if(CheckNewAccount()) restart=true;
   if(restart) CalculateHistoryBars();
   CalculateLastBar();
   if(Show_Info) ShowStatistics();
   AlertMonitoring();
   return(0);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CheckConditions()
  {
   if(!OrderSelect(0,SELECT_BY_POS,MODE_HISTORY)) { return(false); }
   if(Period()>PERIOD_D1) { Alert("Period must be D1 or lower."); return(false); }
   return(true);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CalculateHistoryBars()
  {

   PrepareData();

   if(Type[0]<6 && !Only_Trading)
     { Alert("Trading history is not fully loaded."); return; }

   int handle=PrepareFile();

   ResultBalance=0;
   ResultProfit=0;
   PeakProfit=0;
   PeakEquity=0;
   MaxDrawdown=0;
   RelDrawdown=0;
   start_time=0;
   finish_time=0;

   int bar_seconds=PeriodSeconds(PERIOD_CURRENT);
   int start_from=0;

   for(int i=OpenBar[0]; i>=DrawEndBar; i--)
     {
      ProfitLoss=0;
      SumMargin=0;

      for(int j=start_from; j<Total; j++)
        {
         if(OpenBar[j]<i) break;
         if(CloseBar[start_from]>i) start_from++;

         if(CloseBar[j]==i && ClosePrice[j]!=0)
           {
            double result=Swap[j]+Commission[j]+Profit[j];
            ResultProfit+=result;
            ResultBalance+=result;
            if(CloseTime[j]>finish_time) finish_time=CloseTime[j];
           }

         else if(OpenBar[j]>=i && CloseBar[j]<=i)
           {

            if(Type[j]>5)
              {
               ResultBalance+=Profit[j];
               if(i>DrawBeginBar) continue;
               if(!Show_Verticals) continue;
               string text=StringConcatenate(Instrument[j],": ",DoubleToStr(Profit[j],2)," ",AccountCurrency());
               CreateLine("Balance "+TimeToStr(OpenTime_Ticket[j][0]),OBJ_VLINE,1,OrangeRed,STYLE_DOT,false,text,Time[i],0);
               continue;
              }

            if(i>DrawBeginBar) continue;
            if(!CheckSymbol(j)) continue;

            if(start_time==0) start_time=MathMax(OpenTime_Ticket[j][0],Time[i]);

            int bar=iBarShift(Instrument[j],0,Time[i]);
            int day_bar=TimeDayOfWeek(iTime(Instrument[j],0,bar));
            int day_next_bar=TimeDayOfWeek(iTime(Instrument[j],0,bar+1));
            if(day_bar!=day_next_bar && OpenBar[j]!=bar)
              {
               int mode=(int)MarketInfo(Instrument[j],MODE_PROFITCALCMODE);
               if(mode==0)
                 {
                  if(TimeDayOfWeek(iTime(Instrument[j],0,bar))==4) CumSwap[j]+=3*DaySwap[j];
                  else CumSwap[j]+=DaySwap[j];
                 }
               else
                 {
                  if(TimeDayOfWeek(iTime(Instrument[j],0,bar))==1) CumSwap[j]+=3*DaySwap[j];
                  else CumSwap[j]+=DaySwap[j];
                 }
              }

            if(Type[j]==OP_BUY)
              {
               LotValue=ContractValue(Instrument[j],Time[i],Period());
               ProfitLoss+=Commission[j]+CumSwap[j]+(iClose(Instrument[j],0,bar)-OpenPrice[j])*Lots[j]*LotValue;
               SumMargin+=Lots[j]*MarketInfo(Instrument[j],MODE_MARGINREQUIRED);
              }
            if(Type[j]==OP_SELL)
              {
               LotValue=ContractValue(Instrument[j],Time[i],Period());
               Spread=MarketInfo(Instrument[j],MODE_POINT)*MarketInfo(Instrument[j],MODE_SPREAD);
               ProfitLoss+=Commission[j]+CumSwap[j]+(OpenPrice[j]-iClose(Instrument[j],0,bar)-Spread)*Lots[j]*LotValue;
               SumMargin+=Lots[j]*MarketInfo(Instrument[j],MODE_MARGINREQUIRED);
              }

           }
        }

      if(i>DrawBeginBar) continue;

      if(Only_Trading)  {Equity[i]=NormalizeDouble(ResultProfit+ProfitLoss,2);}
      else              {Equity[i]=NormalizeDouble(ResultBalance+ProfitLoss,2);}
      if(Show_Balance)  {Balance[i]=NormalizeDouble(Only_Trading?ResultProfit:ResultBalance,2);}
      if(Show_Margin)   {Margin[i]=NormalizeDouble(SumMargin,2);}
      if(Show_Free)     {Free[i]=NormalizeDouble(ResultBalance+ProfitLoss-SumMargin,2);}
      if(Show_Zero)     {Zero[i]=0;}
      if(Show_Info)     {Drawdown();}

      if(ProfitLoss!=0) finish_time=Time[i]+PeriodSeconds(PERIOD_CURRENT);

      WriteData(handle,i);

     }

   Profitability();

   if(File_Write && handle>0) FileClose(handle);

   ArrayResize(OpenTime_Ticket,OpenTotal);
   if(OpenTotal>0)
      for(int i=0; i<OpenTotal; i++)
         if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
            OpenTime_Ticket[i][1]=OrderTicket();

   if(Equity_Min_Alert!=0)
      CreateLine("Alert-Min",OBJ_HLINE,1,Silver,STYLE_DOT,false,"Min equity alert",0,Equity_Min_Alert);
   if(Equity_Max_Alert!=0)
      CreateLine("Alert-Max",OBJ_HLINE,1,Silver,STYLE_DOT,false,"Max equity alert",0,Equity_Max_Alert);

  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CalculateLastBar()
  {

   if(DrawEndBar>0) return;

   if(OpenTotal>0)
      for(int i=0; i<OpenTotal; i++)
        {
         if(!OrderSelect((int)OpenTime_Ticket[i][1],SELECT_BY_TICKET)) continue;
         if(OrderCloseTime()==0) continue;
         if(!FilterOrder()) continue;
         double result=OrderProfit()+OrderSwap()+OrderCommission();
         ResultBalance+=result;
         ResultProfit+=result;
        }

   if(!using_filters)
     {
      ProfitLoss=AccountProfit();
      ResultBalance=AccountBalance();
      if(Only_Trading)  {Equity[0]=ResultProfit+ProfitLoss;}
      else              {Equity[0]=AccountEquity();}
      if(Show_Balance)  {Balance[0]=Only_Trading?ResultProfit:ResultBalance;}
      if(Show_Margin)   {Margin[0]=AccountMargin();}
      if(Show_Free)     {Free[0]=AccountFreeMargin();}
      if(Show_Zero)     {Zero[0]=0;}
      if(Show_Info)     {Drawdown();}
     }

   else
     {
      ProfitLoss=0;
      SumMargin=0;
      OpenTotal=OrdersTotal();

      if(OpenTotal>0)
         for(int i=0; i<OpenTotal; i++)
           {
            if(!OrderSelect(i,SELECT_BY_POS,MODE_TRADES)) continue;
            if(!FilterOrder()) continue;
            SumMargin+=OrderLots()*MarketInfo(OrderSymbol(),MODE_MARGINREQUIRED);
            ProfitLoss+=OrderProfit()+OrderSwap()+OrderCommission();
           }

      if(Only_Trading)  {Equity[0]=NormalizeDouble(ResultProfit+ProfitLoss,2);}
      else              {Equity[0]=NormalizeDouble(ResultBalance+ProfitLoss,2);}
      if(Show_Balance)  {Balance[0]=NormalizeDouble(Only_Trading?ResultProfit:ResultBalance,2);}
      if(Show_Margin)   {Margin[0]=NormalizeDouble(SumMargin,2);}
      if(Show_Free)     {Free[0]=NormalizeDouble(ResultBalance+ProfitLoss-SumMargin,2);}
      if(Show_Zero)     {Zero[0]=0;}
      if(Show_Info)     {Drawdown();}

      ArrayResize(OpenTime_Ticket,OpenTotal);
      if(OpenTotal>0)
         for(int i=0; i<OpenTotal;i++)
            if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
               OpenTime_Ticket[i][1]=OrderTicket();
     }

   CreateLine("Equity Level",OBJ_HLINE,1,SteelBlue,STYLE_DOT,false,"",0,Equity[0]);
   CreateLine("Balance Level",OBJ_HLINE,1,Crimson,STYLE_DOT,false,"",0,Balance[0]);

  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void ShowStatistics()
  {

   double                     periods=double(finish_time-start_time);
   if(Report_Period==day)     periods=periods/24/60/60;
   if(Report_Period==month)   periods=periods/30/24/60/60;
   if(Report_Period==year)    periods=periods/365/24/60/60;
   if(Report_Period==history) periods=1;
   if(      periods==0)       periods=1;

   NetProfit=(SumProfit+SumLoss)/periods;
   Profitability=100*(GrowthRatio-1)/periods;
   string text=StringConcatenate(": ",DoubleToStr(NetProfit,2)," ",AccountCurrency()," (",DoubleToStr(Profitability,2),"%)");

   if(Report_Period==day)     CreateLabel("Net Profit / Day",text,20);
   if(Report_Period==month)   CreateLabel("Net Profit / Month",text,20);
   if(Report_Period==year)    CreateLabel("Net Profit / Year",text,20);
   if(Report_Period==history) CreateLabel("Total Net Profit",text,20);

   text=StringConcatenate(": ",DoubleToStr(MaxDrawdown,2)," "+AccountCurrency()," (",DoubleToStr(RelDrawdown*100,2),"%)");
   CreateLabel("Max Drawdown",text,40);

   if(MaxDrawdown!=0) RecoveryFactor=NetProfit/MaxDrawdown;
   text=StringConcatenate(": ",DoubleToStr(RecoveryFactor,2));
   CreateLabel("Recovery Factor",text,60);

   if(SumLoss!=0) ProfitFactor=-SumProfit/SumLoss;
   text=StringConcatenate(": ",DoubleToStr(ProfitFactor,2));
   CreateLabel("Profit Factor",text,80);

   if(StringLen(missing_symbols)>0)
      CreateLabel("Missing symbols:",missing_symbols,100);

  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void AlertMonitoring()
  {
   if(alert_upper_active)
      if(Equity[0]!=EMPTY_VALUE)
         if(Equity[0]>=Equity_Max_Alert)
           {
            string message=StringConcatenate("Account #",AccountNumber()," equity alert: ",Equity[0]," ",AccountCurrency());
            Alert(message);
            if(Push_Alerts) SendNotification(message);
            alert_upper_active=false;
           }
   if(alert_lower_active)
      if(Equity[0]!=EMPTY_VALUE)
         if(Equity[0]<=Equity_Min_Alert)
           {
            string message=StringConcatenate("Account #",AccountNumber()," equity alert: ",Equity[0]," ",AccountCurrency());
            Alert(message);
            if(Push_Alerts) SendNotification(message);
            alert_lower_active=false;
           }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Profitability()
  {
   int Count=OrdersHistoryTotal();
   datetime CloseTime_Ticket[][2];
   ArrayResize(CloseTime_Ticket,Count);

   for(int i=0; i<Count; i++)
      if(OrderSelect(i,SELECT_BY_POS,MODE_HISTORY))
        {
         if(FilterOrder())
           {
            CloseTime_Ticket[i][0]=OrderOpenTime();
            CloseTime_Ticket[i][1]=OrderTicket();
           }
         else
           {
            CloseTime_Ticket[i][0]=EMPTY_VALUE;
            Count--;
           }
        }

   ArraySort(CloseTime_Ticket);
   ArrayResize(CloseTime_Ticket,Count);

   SumProfit=0;
   SumLoss=0;
   GrowthRatio=1;
   double IntervalProfit=0;
   double BalanceValue=0;

   for(int i=0; i<Count; i++)
      if(OrderSelect((int)CloseTime_Ticket[i][1],SELECT_BY_TICKET))
         if(FilterOrder())
           {
            if(OrderType()>5)
              {
               if(BalanceValue!=0) GrowthRatio*=(1+IntervalProfit/BalanceValue);
               BalanceValue+=IntervalProfit;
               IntervalProfit=0;
               BalanceValue+=OrderProfit();
              }
            if(OrderType()<=1)
               if(OrderCloseTime()>=Draw_Begin && OrderCloseTime()<=Draw_End)
                 {
                  double result=OrderProfit()+OrderSwap()+OrderCommission();
                  IntervalProfit+=result;
                  if(result>0) SumProfit+=result; else SumLoss+=result;
                 }
           }

   if(IntervalProfit!=0)
      if(BalanceValue!=0)
         GrowthRatio*=(1+IntervalProfit/BalanceValue);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void PrepareData()
  {

   HistoryTotal=OrdersHistoryTotal();
   OpenTotal=OrdersTotal();
   Total=HistoryTotal+OpenTotal;
   ArrayResize(OpenTime_Ticket,Total);

   for(int i=0; i<HistoryTotal; i++)
      if(OrderSelect(i,SELECT_BY_POS,MODE_HISTORY))
        {
         if(FilterOrder())
           {
            OpenTime_Ticket[i][0]=OrderOpenTime();
            OpenTime_Ticket[i][1]=OrderTicket();
           }
         else
           {
            OpenTime_Ticket[i][0]=EMPTY_VALUE;
            Total--;
           }
        }

   for(int i=0; i<OpenTotal; i++)
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
        {
         if(FilterOrder())
           {
            OpenTime_Ticket[HistoryTotal+i][0]=OrderOpenTime();
            OpenTime_Ticket[HistoryTotal+i][1]=OrderTicket();
           }
         else
           {
            OpenTime_Ticket[HistoryTotal+i][0]=EMPTY_VALUE;
            Total--;
           }
        }

   ArraySort(OpenTime_Ticket);
   ArrayResize(OpenTime_Ticket,Total);
   ArrayResize(CloseTime,Total);
   ArrayResize(OpenBar,Total);
   ArrayResize(CloseBar,Total);
   ArrayResize(Type,Total);
   ArrayResize(Lots,Total);
   ArrayResize(Instrument,Total);
   ArrayResize(OpenPrice,Total);
   ArrayResize(ClosePrice,Total);
   ArrayResize(Commission,Total);
   ArrayResize(Swap,Total);
   ArrayResize(CumSwap,Total);
   ArrayResize(DaySwap,Total);
   ArrayResize(Profit,Total);

   for(int i=0; i<Total; i++)
      if(OrderSelect((int)OpenTime_Ticket[i][1],SELECT_BY_TICKET))
         ReadOrder(i);

  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void ReadOrder(int n)
  {

   OpenBar[n]=iBarShift(NULL,0,OrderOpenTime());
   Type[n]=OrderType();
   if(OrderType()>5) Instrument[n]=OrderComment(); else Instrument[n]=OrderSymbol();
   Lots[n]=OrderLots();
   OpenPrice[n]=OrderOpenPrice();

   if(OrderCloseTime()!=0)
     {
      CloseTime[n]=OrderCloseTime();
      CloseBar[n]=iBarShift(NULL,0,OrderCloseTime());
      ClosePrice[n]=OrderClosePrice();
     }
   else
     {
      CloseTime[n]=0;
      CloseBar[n]=0;
      ClosePrice[n]=0;
     }

   Commission[n]=OrderCommission();
   Swap[n]=OrderSwap();
   Profit[n]=OrderProfit();

   CumSwap[n]=0;
   int swapdays=0;

   for(int bar=OpenBar[n]-1; bar>=CloseBar[n]; bar--)
     {
      if(TimeDayOfWeek(iTime(NULL,0,bar))!=TimeDayOfWeek(iTime(NULL,0,bar+1)))
        {
         int mode=(int)MarketInfo(Instrument[n],MODE_PROFITCALCMODE);
         if(mode==0)
           {
            if(TimeDayOfWeek(iTime(NULL,0,bar))==4) swapdays+=3;
            else swapdays++;
           }
         else
           {
            if(TimeDayOfWeek(iTime(NULL,0,bar))==1) swapdays+=3;
            else swapdays++;
           }
        }
     }

   if(swapdays>0) DaySwap[n]=Swap[n]/swapdays; else DaySwap[n]=0.0;

   if(Lots[n]==0)
     {
      string ticket=StringSubstr(OrderComment(),StringFind(OrderComment(),"#")+1);
      if(OrderSelect(StrToInteger(ticket),SELECT_BY_TICKET,MODE_HISTORY)) Lots[n]=OrderLots();
     }

  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool FilterOrder()
  {
   if(OrderType()>5) return(true);
   if(OrderType()>1) return(false);
   if(Only_Magics) if(OrderMagicNumber()<Magic_From) return(false);
   if(Only_Magics) if(OrderMagicNumber()>Magic_To)   return(false);
   if(Only_Comment!="") if(StringFind(OrderComment(),Only_Comment)==-1) return(false);
   if(Only_Symbols!="") if(StringFind(Only_Symbols,OrderSymbol())==-1)  return(false);
   if(Only_Symbols=="") if(Only_Current) if(OrderSymbol()!=Symbol())    return(false);
   if(Only_Buys  && OrderType()!=OP_BUY)  return(false);
   if(Only_Sells && OrderType()!=OP_SELL) return(false);
   return(true);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Drawdown()
  {
   if(ResultProfit+ProfitLoss>=PeakProfit)
     {
      PeakProfit=ResultProfit+ProfitLoss;
      PeakEquity=ResultBalance+ProfitLoss;
     }
   double current_drawdown=PeakProfit-ResultProfit-ProfitLoss;
   if(current_drawdown>MaxDrawdown)
     {
      MaxDrawdown=current_drawdown;
      if(PeakEquity==0) PeakEquity=DBL_MAX;
      RelDrawdown=current_drawdown/PeakEquity;
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double ContractValue(string symbol,datetime time,int period)
  {
   double value=MarketInfo(symbol,MODE_LOTSIZE);
   string quote=SymbolInfoString(symbol,SYMBOL_CURRENCY_PROFIT);

   if(quote!="USD")
     {
      string direct=FX_prefix+quote+"USD"+FX_postfix;
      if(MarketInfo(direct,MODE_POINT)!=0)
        {
         int shift=iBarShift(direct,period,time);
         double price=iClose(direct,period,shift);
         if(price>0) value*=price;
        }
      else
        {
         string indirect=FX_prefix+"USD"+quote+FX_postfix;
         int shift=iBarShift(indirect,period,time);
         double price=iClose(indirect,period,shift);
         if(price>0) value/=price;
        }
     }

   if(AccountCurrency()!="USD")
     {
      string direct=FX_prefix+AccountCurrency()+"USD"+FX_postfix;
      if(MarketInfo(direct,MODE_POINT)!=0)
        {
         int shift=iBarShift(direct,period,time);
         double price=iClose(direct,period,shift);
         if(price>0) value/=price;
        }
      else
        {
         string indirect=FX_prefix+"USD"+AccountCurrency()+FX_postfix;
         int shift=iBarShift(indirect,period,time);
         double price=iClose(indirect,period,shift);
         if(price>0) value*=price;
        }
     }

   return(value);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CreateLabel(string name,string str,int y)
  {
   string objectname=StringConcatenate(name," ",Unique);
   if(ObjectFind(objectname)==-1)
     {
      ObjectCreate(objectname,OBJ_LABEL,Window,0,0);
      ObjectSet(objectname,OBJPROP_XDISTANCE,10);
      ObjectSet(objectname,OBJPROP_YDISTANCE,y);
      ObjectSet(objectname,OBJPROP_COLOR,indicator_color1);
      ObjectSet(objectname,OBJPROP_CORNER,Text_Corner);
      ObjectSet(objectname,OBJPROP_COLOR,Text_Color);
     }
   ObjectSetText(objectname,name+str,Text_Size,Text_Font);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CreateLine(string name,int type,int width,color clr,int style,bool ray,string str,
                datetime time1,double price1,datetime time2=0,double price2=0)
  {
   string objectname=StringConcatenate(name," ",Unique);
   if(ObjectFind(objectname)==-1)
     {
      ObjectCreate(objectname,type,Window,time1,price1,time2,price2);
      ObjectSet(objectname,OBJPROP_WIDTH,width);
      ObjectSet(objectname,OBJPROP_RAY,ray);
     }
   ObjectSetText(objectname,str);
   ObjectSet(objectname,OBJPROP_COLOR,clr);
   ObjectSet(objectname,OBJPROP_TIME1,time1);
   ObjectSet(objectname,OBJPROP_PRICE1,price1);
   ObjectSet(objectname,OBJPROP_TIME2,time2);
   ObjectSet(objectname,OBJPROP_PRICE2,price2);
   ObjectSet(objectname,OBJPROP_STYLE,style);
   ObjectSet(objectname,OBJPROP_SELECTABLE,false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void DeleteAll()
  {
   int objects=ObjectsTotal()-1;
   for(int i=objects;i>=0;i--)
     {
      string name=ObjectName(i);
      if(StringFind(name,Unique)!=-1) ObjectDelete(name);
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int PrepareFile()
  {
   if(!File_Write) return(-1);
   string filename=StringConcatenate(AccountNumber(),"_",Period(),".csv");
   int handle=FileOpen(filename,FILE_CSV|FILE_WRITE);
   if(handle<0) { Alert("Error #",GetLastError()," while opening data file."); return(handle); }
   uint bytes=FileWrite(handle,"Date","Time","Equity","Balance");
   if(bytes<=0) Print("Error #",GetLastError()," while writing data file.");
   return(handle);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void WriteData(int handle,int i)
  {
   if(!File_Write) return;
   if(handle<=0) return;
   string date=TimeToStr(Time[i],TIME_DATE);
   string time=TimeToStr(Time[i],TIME_MINUTES);
   uint bytes=FileWrite(handle,date,time,ResultBalance+ProfitLoss,ResultBalance);
   if(bytes<=0) Print("Error #",GetLastError()," while writing data file.");
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CheckSymbol(int j)
  {
   if(MarketInfo(Instrument[j],MODE_POINT)!=0) return(true);
   if(StringFind(missing_symbols,Instrument[j])==-1)
     {
      missing_symbols=StringConcatenate(missing_symbols," ",Instrument[j]);
      Print("Missing symbols in Market Watch: "+Instrument[j]);
     }
   return(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CheckNewAccount()
  {
   static int number=-1;
   if(number!=AccountNumber())
     {
      DeleteAll();
      IndicatorShortName(Unique);
      Window=WindowFind(Unique);
      IndicatorShortName(ShortName);
      ArrayInitialize(Balance,EMPTY_VALUE);
      ArrayInitialize(Equity,EMPTY_VALUE);
      ArrayInitialize(Margin,EMPTY_VALUE);
      ArrayInitialize(Free,EMPTY_VALUE);
      ArrayInitialize(Zero,EMPTY_VALUE);
      number=AccountNumber();
      missing_symbols="";
      return(true);
     }
   else return(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CheckNewBar()
  {
   static datetime saved_time;
   if(Time[0]==saved_time) return(false);
   saved_time=Time[0];
   return(true);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CheckNewOrder()
  {
   static int orders;
   if(OrdersTotal()==orders) return(false);
   orders=OrdersTotal();
   return(true);
  }
//+------------------------------------------------------------------+
