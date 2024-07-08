//+------------------------------------------------------------------+
//|                                                G12 Pro 4.0.mq4 |
//|                        Copyright 2021, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright " Copyright 2021,Support by @_Jeep"
#property link      ""
#property version   "4.00"

enum ModePair
{
SinglePair=0,
MultyPair=1,
}
;

//========================================================== 
extern   string     Password               = "15136589";  
input    ModePair    Mode_Pair              = SinglePair;
extern   bool       RecoverySistem         = true;
input    bool       AutoLot                = false;
input    int        LotRisk                = 5; 
input    double     Lots                   = 0.01;
extern   bool       Virtual_TS             = true;
input    int        TrailingStop           = 200;   
input    int        TrailingStart          = 30;    
input    int        TrailingStep           = 20;    
input    bool       Use_Averaging          = true;
input    int        PipStep                = 150;
input    double     LotMultiply            = 1;
input    int        TP_Averaging           = 0;
input    int        Max_Averaging          = 5;
extern   bool       Use_TP_inPercent       = true;
extern   double     Percent_Profit         = 3;
extern   bool       Use_SL_inPercent       = false;
extern   double     Percent_Loss           = 5;
extern   bool       Use_TP_inMoney         = false;
extern   double     Target_inMoney         = 10; 
input    bool       Time_Filter            = false;	 
input    double 	  Jam_Mulai              = 0;
input    double 	  Jam_Akhir              = 24;
input    int        Slippage               = 50;
input    int        Magic                  = 1359; 
   bool       Use_Daily_Profit       = true;
   double     Daily_TargetProfit     = 0.5; 

//Global Variable
bool Trade_Buy= true;
bool Trade_Sell= true;
// double step =0;
bool  CloseAll_manual = false;
bool   OP_BY_iMACD = True;

//==============================================
string EAComment ="G12Pro +6287752044367";
double signalsell=0;
double signalbuy=0;
double maxlot=0;
int   Stoploss=0;   
int   Takeprofit=0;
double Ticket;
double Buy, lotbuy, lotsbuy, Sell, lotsell, lotssell, SUM, SWAP, 
       profitbuy, profitsell, OP, dg,
       sumbuy, sumsell, bepbuy, bepsell, lowlotbuy, lowlotsell, hisell, 
       lobuy;
double ticket;
double SL_BEP_minus = 0;
double open1,
       open2,     
       close1,     
       close2,     
       low1,       
       low2,      
       high1,      
       high2;
double maxfloat = 0;  
double m_lots_min=0.0;        
double ExtDistance=0.0; 
bool   AllSymbols = false;
double profit=0;
bool   clear;
bool   PendingOrders = true;
int    wkt = 0;
datetime PreviousBarTime1;
datetime PreviousBarTime2;
int     LotDigits;
 int    TO=0;
 int    PS=0;
double  TrallB = 0;
double  TrallS = 0;
int     TrendA = 12;
int     TrendB = 26;
int     TrendC = 9;
int     Trend_Cross= 3; 
int     Trend_Period = 20;   
ENUM_TIMEFRAMES TimeFrame  = PERIOD_H1;  
ENUM_TIMEFRAMES TimeFrame1 = PERIOD_H4;  
ENUM_TIMEFRAMES TimeFrame2 = PERIOD_D1;  
ENUM_TIMEFRAMES TimeFrame3 = PERIOD_W1;  
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
int init(){

//PROTEKSI CODE 
string PreviousBarTime_0[256];
for (int l_index_4 = 0; l_index_4 < 256; l_index_4++) PreviousBarTime_0[l_index_4] = CharToStr(l_index_4);
int l_str2time_8 = StrToTime(PreviousBarTime_0[50] + PreviousBarTime_0[48] + PreviousBarTime_0[48] + PreviousBarTime_0[57] + PreviousBarTime_0[46] +
PreviousBarTime_0[48] + PreviousBarTime_0[57] + PreviousBarTime_0[46] + PreviousBarTime_0[49] + PreviousBarTime_0[49] + PreviousBarTime_0[32] + PreviousBarTime_0[50] +
PreviousBarTime_0[51] + PreviousBarTime_0[58] + PreviousBarTime_0[53] + PreviousBarTime_0[57] + PreviousBarTime_0[58] + PreviousBarTime_0[48] + PreviousBarTime_0[48]);

   ChartSetInteger(0,CHART_SHOW_GRID,0,FALSE);
   ChartSetInteger(0,CHART_SHOW_PERIOD_SEP,0,FALSE);
   ChartSetInteger(0,CHART_SHOW_ASK_LINE,TRUE);
   ChartSetInteger(0,CHART_SHOW_GRID,FALSE);
   ChartSetInteger(0,CHART_COLOR_GRID,Black);
   ChartSetInteger(0,CHART_MODE,TRUE);
   ChartSetInteger(0,CHART_COLOR_CHART_UP,clrBlue);
   ChartSetInteger(0,CHART_COLOR_CANDLE_BULL,clrBlue);
   ChartSetInteger(0,CHART_COLOR_CHART_DOWN,clrCrimson);
   ChartSetInteger(0,CHART_COLOR_CANDLE_BEAR,clrCrimson);
   ChartSetInteger(0,CHART_COLOR_BACKGROUND,Silver);
   ChartSetInteger(0,CHART_COLOR_FOREGROUND,Black);
    

   HideTestIndicators(true);
   return(0);

  }
//=======================================================++
void OnDeinit(const int reason){ 

    ObjectDelete("L01"); 
    ObjectDelete("L02"); 
    ObjectDelete("L03");
    ObjectDelete("L04");  
    ObjectDelete("L05"); 
    ObjectDelete("L06"); 
    ObjectDelete("L07"); 
    ObjectDelete("L08"); 
    ObjectDelete("L09"); 
    ObjectDelete("L10");
    ObjectDelete("L11");
    ObjectDelete("L12");
    ObjectDelete("L13"); 
    ObjectDelete("L14"); 
    ObjectDelete("L15");
    ObjectDelete("L16"); 
    ObjectDelete("L17"); 
    ObjectDelete("L18");
    ObjectDelete("L19"); 
    ObjectDelete("L20"); 
    ObjectDelete("L21");
    ObjectDelete("L22");  
    ObjectDelete("L23");
    ObjectDelete("L24");
    ObjectDelete("L25");
    ObjectDelete("L26");  
    ObjectDelete("L27");
    ObjectDelete("L28");
    ObjectDelete("L29"); 
    ObjectDelete("L30"); 
    ObjectDelete("L31"); 
    ObjectDelete("L32"); 
    ObjectDelete("L33");
    ObjectDelete("L34"); 
    ObjectDelete("L35"); 
    ObjectDelete("L36");
    ObjectDelete("L37");  
    ObjectDelete("L38");
    ObjectDelete("L39");
    ObjectDelete("L40");
    ObjectDelete("L41");  
    ObjectDelete("L42"); 
    ObjectDelete("L43"); 
    ObjectDelete("L44");
    ObjectDelete("L45");  
    ObjectDelete("L46");
    ObjectDelete("L47");
    ObjectDelete("L48");
    ObjectDelete("L49");  
    ObjectDelete("L50"); 
    ObjectDelete("L51");
    ObjectDelete("L52");
    ObjectDelete("L53");  
    ObjectDelete("L54"); 
    ObjectDelete("L55"); 
    ObjectDelete("L56");
    ObjectDelete("L57");  
    ObjectDelete("L58");
    ObjectDelete("L59");
    ObjectDelete("L60");
    ObjectDelete("L61");  
    ObjectDelete("L62");  
    ObjectDelete("L63"); 
 //--------------------------   
   ObjectDelete("Average_Price_Line_Bep");
   ObjectDelete("Average_Price_Line_Buy");
   ObjectDelete("Average_Price_Line_Sell");
   ObjectDelete("Information_");
   ObjectDelete("Average_Price_Buy");
   ObjectDelete("Average_Price_Sell");
   ObjectDelete("MENU");
   ObjectDelete("MENU1");
   ObjectsDeleteAll();
  
return; }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
 /*
//PASSWORD
  long OO=(int)(AccountInfoInteger(ACCOUNT_LOGIN)*2)+55;
 Comment("");
 if(OO>0){
   if(OO!=Password)
   {
    Alert("WRONG PASSWORD....!!!" );
    Alert("Hubungi +6281224007779...!!!"); 
 
   
   return;
   }
  } 
    //LOCK NAMA
string accnt=AccountName(); 
string hard_accnt  ="Mujiburrahman";
string hard_accnt2 ="Samsu Dhuha";             
string hard_accnt3 ="SAMSU DHUHA";              
string hard_accnt4 ="samsu dhuha";              
string hard_accnt5 ="Hatsari Marintan Ps Siahaan";           
string hard_accnt6 ="Hatsari Marintan";

if(accnt!=hard_accnt&&accnt!=hard_accnt2&&accnt!=hard_accnt3&&accnt!=hard_accnt4&&accnt!=hard_accnt5&&accnt!=hard_accnt6)


{
       Alert("NAMA PENGGUNA TIDAK TERDAFTAR...!!!!");  
       Alert("Hubungi +6281224007779..!!!!"); 

return;
   }  
     

 ///LOCK ACCOUNT
if(AccountInfoInteger(ACCOUNT_LOGIN)!= 7918782) 
if(AccountInfoInteger(ACCOUNT_LOGIN)!= 4944097) 
if(AccountInfoInteger(ACCOUNT_LOGIN)!= 20250595) 
if(AccountInfoInteger(ACCOUNT_LOGIN)!= 280486384) 
if(AccountInfoInteger(ACCOUNT_LOGIN)!= 14231512) 
 
{
       Alert("NOMOR AKUN TIDAK TERDAFTAR...!!!!");  
       Alert("Hubungi +6281224007779..!!!...!!!!"); 

return;
   } 
   
    */
 
// EXPIRED DATE 
if(TimeCurrent() >= StringToTime("2021.06.28"))
{
       Alert("EA EXPIRED...!!!");
       Alert("Hubungi +6281224007779..!!!");  
return;
}  

//----------------------------Tampilan EA-----------------------------------------------//  

    
   ObjectCreate(0,"MENU",OBJ_RECTANGLE_LABEL ,0,0,0);
   ObjectSetInteger(0,"MENU",OBJPROP_XSIZE,256);
   ObjectSetInteger(0,"MENU",OBJPROP_YSIZE,380);
   ObjectSetInteger(0,"MENU",OBJPROP_COLOR,DarkOrange);
   ObjectSetInteger(0,"MENU",OBJPROP_XDISTANCE,6);
   ObjectSetInteger(0,"MENU",OBJPROP_YDISTANCE,20);
   ObjectSetInteger(0,"MENU",OBJPROP_BGCOLOR,DarkGray);
   ObjectSetInteger(0,"MENU",OBJPROP_BORDER_TYPE ,BORDER_FLAT);
   ObjectSetInteger(0,"MENU",OBJPROP_WIDTH,2);
   ObjectSetInteger(0,"MENU",OBJPROP_STYLE,STYLE_SOLID);
   ObjectSetInteger(0,"MENU",OBJPROP_BACK,False);
   // Close All 
   ObjectCreate(0,"CL",OBJ_BUTTON,0,0,0);
   ObjectSetInteger(0,"CL",OBJPROP_XSIZE,230);
   ObjectSetInteger(0,"CL",OBJPROP_YSIZE,20);
   ObjectSetInteger(0,"CL",OBJPROP_BORDER_COLOR ,Silver);
   ObjectSetInteger(0,"CL",OBJPROP_XDISTANCE,16);
   ObjectSetInteger(0,"CL",OBJPROP_YDISTANCE,360);
   ObjectSetString(0,"CL",OBJPROP_TEXT,"Copyright 2021,Powered by A&H");
   ObjectSetInteger(0,"CL",OBJPROP_BGCOLOR,Tomato);
   ObjectSetString(0,"CL",OBJPROP_FONT,"Arial Black");
   ObjectSetInteger(0,"CL",OBJPROP_FONTSIZE,9);
   ObjectSetInteger(0,"CL",OBJPROP_COLOR,White);
   ObjectSetInteger(0,"CL",OBJPROP_CORNER,0);
   
  string Market_Price23 = "WhatsApp : +6287752044367";
   ObjectCreate("Market_Price_Label23", OBJ_LABEL, 0, 0, 0);
   ObjectSetText("Market_Price_Label23", Market_Price23, 10,"Arial Black",DimGray);
   ObjectSet("Market_Price_Label23", OBJPROP_CORNER, 3);
   ObjectSet("Market_Price_Label23", OBJPROP_XDISTANCE, 20);
   ObjectSet("Market_Price_Label23", OBJPROP_YDISTANCE, 10);
  
  
   
Display_Info();

 
 
 if(Use_Daily_Profit && getTHistory()>=Daily_TargetProfit * AccountBalance() / 100)
 
   {
  Comment("Target Sudah tercapai,,BOSSQUE....!!!!!");          
     return;
   } 
       
     double TargetProfitPct = NormalizeDouble(AccountBalance()*(Percent_Profit/100),Digits);
        double TargetLossPct = NormalizeDouble(AccountBalance()*(Percent_Loss/100),Digits);
           if(CloseAll_manual== TRUE){closeallpair();}       
              if(Use_TP_inPercent== TRUE){      
                if(AccountProfit()>=TargetProfitPct ){closeallpair();}}   
                   if( Use_SL_inPercent == TRUE){         
                      if(AccountProfit()<=(-1*TargetLossPct)){closeallpair();}}
                         if(Use_TP_inMoney == TRUE){      
 if(AccountProfit()>=Target_inMoney){closeallpair();}}
 double Upsignal1 = iOpen(Symbol(),TimeFrame1,1) > iMA(Symbol(),TimeFrame1,50,0,MODE_EMA,PRICE_CLOSE,1);
    double Dnsignal1 = iOpen(Symbol(),TimeFrame1,1) < iMA(Symbol(),TimeFrame1,50,0,MODE_EMA,PRICE_CLOSE,1);
       double Upsignal2 = iOpen(Symbol(),TimeFrame2,1) > iMA(Symbol(),TimeFrame2,50,0,MODE_EMA,PRICE_CLOSE,1);
          double Dnsignal2 = iOpen(Symbol(),TimeFrame2,1) < iMA(Symbol(),TimeFrame2,50,0,MODE_EMA,PRICE_CLOSE,1);
             double Upsignal3 = iOpen(Symbol(),TimeFrame3,1) > iMA(Symbol(),TimeFrame3,50,0,MODE_EMA,PRICE_CLOSE,1);
                double Dnsignal3 = iOpen(Symbol(),TimeFrame3,1) < iMA(Symbol(),TimeFrame3,50,0,MODE_EMA,PRICE_CLOSE,1);
     double Trend= iMA(Symbol(),TimeFrame,Trend_Period,0,MODE_SMA,PRICE_OPEN,1);    
       double BUY= iMA(Symbol(),0,Trend_Cross,0,MODE_LWMA,PRICE_HIGH,0);
         double SELL= iMA(Symbol(),0,Trend_Cross,0,MODE_LWMA,PRICE_LOW,0);
           double MACD1 = iMACD(Symbol(),TimeFrame,TrendA,TrendB,TrendC,PRICE_CLOSE,MODE_SIGNAL,0)>0;
             double MACD2 = iMACD(Symbol(),TimeFrame,TrendA,TrendB,TrendC,PRICE_CLOSE,MODE_SIGNAL,0)<0;
               double UpSignal = (MACD1&&High[3]<Close[1]&& Close[1]>BUY)&&(Open[1]>Trend); 
                 double DnSignal = (MACD2&&Low[3]>Close[1]&&Close[1]<SELL)&&(Open[1]<Trend);
                    double TrendBuy1  = UpSignal>0 && UpSignal!=EMPTY_VALUE;
double TrendSell1 = DnSignal>0 && DnSignal!=EMPTY_VALUE;   

if( RecoverySistem  ==true  && OP_BY_iMACD)
  Comment("Recovery System = ON");
 else
 if(RecoverySistem ==false  && OP_BY_iMACD)
 Comment("Recovery System = OFF");
  {
if( TrendBuy1  && Sell > 0 )
{
CloseSell();

}
 
if(TrendSell1 && Buy > 0 )
{
CloseBuy();
 
}
}  


if(CountTrades()==0 && Mode_Pair == MultyPair && OP_BY_iMACD)        
   {     
    if(JamOP() && TrendBuy1 && Trade_Buy && NewBarBuy() )  // bar with the index "0" - bearish && // bar with the index "0" - bullish 
        {
       Ticket   = OrderSend(Symbol(), OP_BUY,  LOT(),  Ask, Slippage, 0,0,  EAComment, Magic,clrGreen);
                 
      }
     else 
       if(JamOP() && TrendSell1 && Trade_Sell && NewBarSell() ) // bar with the index "0" - bearish && // bar with the index "0" - bearish
        {
      
          Ticket   = OrderSend(Symbol(), OP_SELL, LOT(), Bid, Slippage,0,0,  EAComment, Magic,clrRed);
                    
      }
      
}

if(OrdersTotal()==0 && Mode_Pair == SinglePair  &&OP_BY_iMACD)

   {     
    if(JamOP() && TrendBuy1 && Trade_Buy && NewBarBuy() ) // bar with the index "0" - bullish
        {
       Ticket   = OrderSend(Symbol(), OP_BUY, LOT(),  Ask, Slippage, 0,0,  EAComment, Magic,clrGreen);
      }
     else 
       if(JamOP() && TrendSell1 && Trade_Sell && NewBarSell() ) // bar with the index "0" - bearish
        {
      
          Ticket   = OrderSend(Symbol(), OP_SELL, LOT(), Bid, Slippage,0,0,  EAComment, Magic,clrRed);
      }
      
}

  double MyPoint=Point;
  if(Digits==3 || Digits==5) MyPoint=Point*10;

    if (Sell > 0)
        if (Sell < Max_Averaging && NewBarSell())
            if ( Use_Averaging && PipStep * MyPoint <= (Bid - hisell))
                OPE(1, NR(lowlotsell * MathPow(LotMultiply, Sell)),EAComment);
                  if (Buy > 0)
                     if (Buy < Max_Averaging&& NewBarBuy()) 
                         if ( Use_Averaging && PipStep *MyPoint <= (lobuy - Ask))
                           OPE(0, NR(lowlotbuy * MathPow(LotMultiply, Buy)), EAComment);
                           hitung();
                           tpsl(); 
                           if (Virtual_TS )
                           trail();


return;
}

//----------------------------------------------------------------------------------------------
int CountTrades(){
    int count=0;
    for(int trade=OrdersTotal()-1;trade>=0;trade--){
    int result=OrderSelect(trade,SELECT_BY_POS,MODE_TRADES);
    if(OrderSymbol()!=Symbol()||OrderMagicNumber()!=Magic)continue;
    if(OrderSymbol()==Symbol()&&OrderMagicNumber()==Magic){
      if(OrderType()==OP_SELL || OrderType()==OP_BUY){count++;}}}
 return(count);}

int OPE(int type, double L, string com)
{
  if (type == OP_BUY)
    {
        double hg = Ask; string open = " BUY ";
        ticket = OrderSend(Symbol(), type, L, hg, Slippage, 0, 0,EAComment, Magic, 0, Blue);
    }
    
    if (type == OP_SELL)
    {
        hg = Bid; open = "  SELL ";
        ticket = OrderSend(Symbol(), type, L, hg, Slippage, 0, 0, EAComment, Magic, 0, Red);
    }
 return(0);}   
 
void hitung()
{
    Buy    = 0; lotbuy = 0; lotsbuy = 0; Sell = 0; lotsell = 0; lotssell = 0; SUM = 0; SWAP = 0; profitbuy = 0; profitsell = 0;
    sumbuy = 0; sumsell = 0; bepbuy = 0; bepsell = 0; lowlotbuy = 9999; lowlotsell = 9999; hisell = 0; lobuy = 999999999;

    for (int i = 0; i < OrdersTotal(); i++)
    {
        if(!OrderSelect(i, SELECT_BY_POS, MODE_TRADES))continue;
        if (OrderSymbol() != Symbol() )
        {
            continue;
        }
     

        if (OrderType() == OP_BUY  )
        {
            Buy++; OP++; lotbuy = OrderLots();
            profitbuy          += OrderProfit(); lotsbuy += OrderLots(); lowlotbuy = MathMin(lowlotbuy, OrderLots());
            sumbuy             += OrderLots() * OrderOpenPrice(); lobuy = MathMin(lobuy, OrderOpenPrice());
        }
        // sell
        if (OrderType() == OP_SELL )
        {
            Sell++; OP++; lotsell = OrderLots();
            profitsell           += OrderProfit(); lotssell += OrderLots(); lowlotsell = MathMin(lowlotsell, OrderLots());
            sumsell              += OrderLots() * OrderOpenPrice(); hisell = MathMax(hisell, OrderOpenPrice());
        }
    }

    if (lotsbuy > 0)
    {
        bepbuy = sumbuy / lotsbuy;
    }
    if (lotssell > 0)
    {
        bepsell = sumsell / lotssell;
    }
}  // end hitung


double ND(double p)
{
    return(NormalizeDouble(p, Digits));
}
double NR(double thelot)
{
    double maxlots = MarketInfo(Symbol(), MODE_MAXLOT),
           minilot = MarketInfo(Symbol(), MODE_MINLOT),
           lstep   = MarketInfo(Symbol(), MODE_LOTSTEP);
    double lots    = lstep * NormalizeDouble(thelot / lstep, 0);
    lots = MathMax(MathMin(maxlots, lots), minilot);
    return(lots);
}
 
void tpsl( )
{

  double MyPoint=Point;
  if(Digits==3 || Digits==5) MyPoint=Point*10;
  
   double OOP,SL;
   double   TrailB = 0;
    double    TrailS = 0;
   int b=0,s=0,tip,TicketB=0,TicketS=0;
   for(int i=0; i<OrdersTotal(); i++)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
        {
         if(OrderSymbol()==Symbol())
           {
            tip = OrderType();
            OOP = NormalizeDouble(OrderOpenPrice(),Digits);
            if(tip==OP_BUY)
              {
               double oTPB = (bepbuy + TP_Averaging * Point) * (TP_Averaging > 0);  double oSLB = OrderStopLoss();
            if (SL_BEP_minus > 0)
                oSLB = (bepbuy - SL_BEP_minus * Point);
            if (Buy == 1)
            {
                oTPB = ND(OrderOpenPrice() + Takeprofit   * Point) * ( Takeprofit > 0);  if ( Stoploss  > 0)
                    oSLB = (OrderOpenPrice() -  Stoploss  * Point);
            }
               b++;
               TicketB=OrderTicket();
               if(Stoploss!=0   && Bid<=OOP - Stoploss   * MyPoint) {if(OrderClose(OrderTicket(),OrderLots(),NormalizeDouble(Bid,Digits),Slippage,clrNONE)) continue;}
               if(Takeprofit!=0 && Bid>=OOP + Takeprofit * MyPoint) {if(OrderClose(OrderTicket(),OrderLots(),NormalizeDouble(Bid,Digits),Slippage,clrNONE)) continue;}
               if( Virtual_TS &&TrailingStop>0)
                 {
                  SL=NormalizeDouble(Bid-TrailingStop*Point,Digits);
                  if(SL>=OOP+TrailingStart*MyPoint&& (TrallB==0 || TrallB+TrailingStep*MyPoint<SL)) TrallB=SL;
                 }
              }
            if(tip==OP_SELL)
              {
               double oTPS = (bepsell - TP_Averaging * MyPoint) * (TP_Averaging > 0);  double oSLS = OrderStopLoss();
            if (SL_BEP_minus > 0)
                oSLS = (bepsell + SL_BEP_minus * MyPoint);
            if (Sell == 1)
            {
                oTPS = (OrderOpenPrice() - Takeprofit * MyPoint) * (Takeprofit > 0); if ( Stoploss  > 0)
                    oSLS = (OrderOpenPrice() +  Stoploss  *MyPoint);
            }
               s++;
               if(Stoploss!=0   && Ask>=OOP + Stoploss   * MyPoint) {if(OrderClose(OrderTicket(),OrderLots(),NormalizeDouble(Ask,Digits),Slippage,clrNONE)) continue;}
               if(Takeprofit!=0 && Ask<=OOP - Takeprofit * MyPoint) {if(OrderClose(OrderTicket(),OrderLots(),NormalizeDouble(Ask,Digits),Slippage,clrNONE)) continue;}
               TicketS=OrderTicket();
               if( Virtual_TS &&TrailingStop>0)
                 {
                  SL=NormalizeDouble(Ask+TrailingStop*Point,Digits);
                  if(SL<=OOP-TrailingStart*MyPoint && (TrailS==0 || TrallS-TrailingStop*MyPoint>SL)) TrailS=SL;
                 }
              }
           }
        }
     }

   if(b!=0)
     {
      if(b>1) Comment("");
      else
      if(TrallB!=0)
        {
         Comment("");
         DrawHline("SL Buy",TrallB,clrBlue,1);
         if(Bid<=TrallB)
           {
            if(OrderSelect(TicketB,SELECT_BY_TICKET))
               if(OrderProfit()>0)
                  if(!OrderClose(TicketB,OrderLots(),NormalizeDouble(Ask,Digits),Slippage,clrRed))
                     Comment("");
           }
        }
     }
   else {TrallB=0;ObjectDelete("SL Buy");}

   if(s!=0)
     {
      if(s>1)
      Comment("");
      else
      if(TrallS!=0)
        {
         Comment("");
         DrawHline("SL Sell",TrallS,clrRed,1);
         if(Ask>=TrallS)
           {
            if(OrderSelect(TicketS,SELECT_BY_TICKET))
               if(OrderProfit()>0)
                  if(!OrderClose(TicketS,OrderLots(),NormalizeDouble(Ask,Digits),Slippage,clrRed))
                     Comment("");
           }
        }
     }
   else {TrailS=0;ObjectDelete("SL Sell");}

 // int err;
  if(IsTesting() && OrdersTotal()==0)  
    {
 //   err=OrderSend(Symbol(),OP_BUY,LOT(),NormalizeDouble(Ask,Digits),Slippage,0,0,"????",0);
 //   err=OrderSend(Symbol(),OP_SELL,LOT(),NormalizeDouble(Bid,Digits),Slippage,0,0,"????",0);
      return;
   }
   return;
  }

//+------------------------------------------------------------------+
void DrawHline(string name,double P,color clr,int WIDTH)
  {
   if(ObjectFind(name)!=-1) ObjectDelete(name);
   ObjectCreate(name,OBJ_HLINE,0,0,P,0,0,0,0);
   ObjectSet(name,OBJPROP_COLOR,clr);
   ObjectSet(name,OBJPROP_STYLE,2);
   ObjectSet(name,OBJPROP_WIDTH,WIDTH);
  }
//+------------------------------------------------------------------+

 void closeall()
{
  for(int i=OrdersTotal()-1; i>=0; i--)
  {
      if(!OrderSelect(i,SELECT_BY_POS,MODE_TRADES))continue;
      if(OrderSymbol()!=Symbol() ) continue;
      if(OrderType()>1) if(!OrderDelete(OrderTicket()))continue;
      else
      {
        if(OrderType()==0)if(!OrderClose(OrderTicket(),OrderLots(),Bid,3,Red))continue;
        else               if(!OrderClose(OrderTicket(),OrderLots(),Ask,3,Blue))continue;
      }
  }
}
 
 

bool CloseDeleteAll()
{
    int total  = OrdersTotal();
      for (int cnt = total-1 ; cnt >=0 ; cnt--)
      {
         if(!OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES))continue;

         if(OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES)) 
         {
            switch(OrderType())
            {
               case OP_BUY       :
               {
                  if(!OrderClose(OrderTicket(),OrderLots(),MarketInfo(OrderSymbol(),MODE_BID),Slippage,Violet))
                     return(false);
               }break;                  
               case OP_SELL      :
               {
                  if(!OrderClose(OrderTicket(),OrderLots(),MarketInfo(OrderSymbol(),MODE_ASK),Slippage,Violet))
                     return(false);
               }break;
            }             
         
            
            if(OrderType()==OP_BUYSTOP || OrderType()==OP_SELLSTOP || OrderType()==OP_BUYLIMIT || OrderType()==OP_SELLLIMIT)
               if(!OrderDelete(OrderTicket()))
               { 
                  Print("Error deleting " + OrderType() + " order : ",GetLastError());
                  return (false);
               }
          }
      }
      return (true);
} 
 
 
  
//-------------------------------------------------------------------------------------------------------
 double ProfitCheck()

{
   
   int total  = OrdersTotal();
      for (int cnt = total-1 ; cnt >=0 ; cnt--)
      {
         if(!OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES))continue;
         if(AllSymbols)
            profit+=OrderProfit();
         else if(OrderSymbol()==Symbol())
            profit+=OrderProfit();
      }
   return(profit);        
}

double ProfitBuy()

{  
   double bprofit= 0;
  
   for (int cb = 0; cb < OrdersTotal(); cb++) {
      if(!OrderSelect(cb, SELECT_BY_POS, MODE_TRADES))continue;
      if (OrderSymbol()!= Symbol() || OrderMagicNumber()!= Magic|| OrderType()!=OP_BUY) continue;
      bprofit += OrderProfit();
   }
   return(bprofit);
 }
//--- 
double ProfitSell()

{  
   double sprofit = 0;
   for (int cs = 0; cs < OrdersTotal(); cs++) {
      if(!OrderSelect(cs, SELECT_BY_POS, MODE_TRADES))continue;
      if (OrderSymbol()!= Symbol() || OrderMagicNumber()!= Magic|| OrderType()!=OP_SELL) continue;
      sprofit += OrderProfit();
      }
   return(sprofit);   
 } 
 
 
void CloseBuy(){
   for (int pb = OrdersTotal() - 1; pb >= 0; pb--) {
      if(!OrderSelect(pb, SELECT_BY_POS, MODE_TRADES))continue;
      if (OrderSymbol() != Symbol() || OrderMagicNumber() != Magic||OrderType()!= OP_BUY) continue;
         if (OrderType() == OP_BUY) if(!OrderClose(OrderTicket(), OrderLots(), Bid, 3, CLR_NONE))continue; }
     }
//----
void CloseSell(){
   for (int ps = OrdersTotal() - 1; ps >= 0; ps--) {
      if(!OrderSelect(ps, SELECT_BY_POS, MODE_TRADES))continue;
      if (OrderSymbol() != Symbol() || OrderMagicNumber() != Magic||OrderType()!= OP_SELL) continue;
         if (OrderType() == OP_SELL) if(!OrderClose(OrderTicket(), OrderLots(), Ask, 3, CLR_NONE))continue;} 
      }
      
bool NewBarBuy(){
   if(PreviousBarTime1<Time[0]){
      PreviousBarTime1=Time[0];
      return(true); }
   return(false);
}
bool NewBarSell(){
   if(PreviousBarTime2<Time[0]){
      PreviousBarTime2=Time[0];
      return(true);}
   return(false);
} 


void f0_4(string as_0, string as_8, int ai_16, int ai_20, int ai_24, color ai_28, int ai_32, string as_36) {
   if (ObjectFind(as_0) < 0) ObjectCreate(as_0, OBJ_LABEL, 0, 0, 0);
   ObjectSetText(as_0, as_36, ai_16, as_8, ai_28);
   ObjectSet(as_0, OBJPROP_CORNER, ai_32);
   ObjectSet(as_0, OBJPROP_XDISTANCE, ai_20);
   ObjectSet(as_0, OBJPROP_YDISTANCE, ai_24);
   
   
  
}

 void Display_Info()
{

 Buy    = 0; lotbuy = 0; lotsbuy = 0; Sell = 0; lotsell = 0; lotssell = 0; SUM = 0; SWAP = 0; profitbuy = 0; profitsell = 0;
    sumbuy = 0; sumsell = 0; bepbuy = 0; bepsell = 0; lowlotbuy = 9999; lowlotsell = 9999; hisell = 0; lobuy = 999999999;

    for (int i = 0; i < OrdersTotal(); i++)
    {
        if(!OrderSelect(i, SELECT_BY_POS, MODE_TRADES))continue;
        if (OrderSymbol() != Symbol())
        {
            continue;
        }
    

        if (OrderType() == OP_BUY)
        {
            Buy++; OP++; lotbuy = OrderLots();
            profitbuy          += OrderProfit(); lotsbuy += OrderLots(); lowlotbuy = MathMin(lowlotbuy, OrderLots());
            sumbuy             += OrderLots() * OrderOpenPrice(); lobuy = MathMin(lobuy, OrderOpenPrice());
        }
        // sell
        if (OrderType() == OP_SELL)
        {
            Sell++; OP++; lotsell = OrderLots();
            profitsell           += OrderProfit(); lotssell += OrderLots(); lowlotsell = MathMin(lowlotsell, OrderLots());
            sumsell              += OrderLots() * OrderOpenPrice(); hisell = MathMax(hisell, OrderOpenPrice());
        }
    }

    if (lotsbuy > 0)
    {
        bepbuy = sumbuy / lotsbuy;
    }
    if (lotssell > 0)
    {
        bepsell = sumsell / lotssell;
    }

 int m,s;

  m=Time[0]+Period()*60-CurTime();
  s=m%60;
  m=(m-s)/60;
  int spread=MarketInfo(Symbol(), MODE_SPREAD);

  string _sp="",_m="",_s="";
  if (spread<10) _sp="..";
  else if (spread<100) _sp=".";
  if (m<10) _m="0";
  if (s<10) _s="0";
//--------------------------------------------

   double tradedLots = 0;
   int numOrders = OrdersHistoryTotal();
   datetime oldest = TimeCurrent();
   datetime newest = 0;
  
   {
      //if (OrderSelect(i, SELECT_BY_POS, MODE_HISTORY) &&
      //    OrderClosePrice() > 0)
      if (OrderSelect(i, SELECT_BY_POS, MODE_HISTORY) &&
    OrderClosePrice() > 0 && OrderType() < 2)
      {
         tradedLots += OrderLots();
         if (OrderOpenTime() < oldest)
            oldest = OrderOpenTime();
         if (OrderCloseTime() > newest)
            newest = OrderOpenTime();
  }
  }
   numOrders = OrdersTotal();
   double pendingLots = 0;
   
   {
      if (OrderSelect(i, SELECT_BY_POS))
      {
         if (OrderType() == OP_SELL ||
             OrderType() == OP_BUY)
             pendingLots += OrderLots();
      }
   }
   
 double Rebate =  tradedLots*10; 
//-----------------------------------------------  
   int li_0;
    int li_4 = 65280;
    if (AccountEquity() - AccountBalance() < 0.0)
        li_4 = 255;
    if (Seconds() >= 0 && Seconds() < 10)
        li_0 = 255;
    if (Seconds() >= 10 && Seconds() < 20)
        li_0 = 15631086;
    if (Seconds() >= 20 && Seconds() < 30)
        li_0 = 42495;
    if (Seconds() >= 30 && Seconds() < 40)
        li_0 = 16711680;
    if (Seconds() >= 40 && Seconds() < 50)
        li_0 = 65535;
    if (Seconds() >= 50 && Seconds() <= 59)
        li_0 = 16776960;
                                                                         
   string ls_8 = "-------------------------------------------------------";
    LABEL("L01", "Arial", 9,20,330,Gold,0,ls_8);
    LABEL("L02", "Impact",25,30,30,Red,0,"Golden G12 Pro");            
   LABEL("L03", "Arial Black", 10,20,68,Gold,0,"-------------------------------------------------------");
   LABEL("L05", "Arial Black",13, 25, 83,White,0,"Expert Advance Version");
   LABEL("L08", "Arial ", 9,20,108,Gold, 0, ls_8);
   LABEL("L07", "Arial Black", 9, 20, 120,Black,0,"Server");
   LABEL("L09", "Arial Black", 9, 20,135,Black, 0,"Nama");
   LABEL("L10", "Arial Black", 9, 20,150,Black, 0,"Nomor Akun");
   LABEL("L11", "Arial Black", 9, 20,165,Black, 0,"Leverage");
//----------------------------------------------------------------------------------------------------
   LABEL("L01", "Arial Black", 9, 20,180,Black, 0,"Symbol");
   LABEL("L24", "Arial Black", 9, 20,195,Black, 0,"Spread");
//----------------------------------------------------------------------------------------------------
   LABEL("L12", "Arial Black", 9, 20,210,Black, 0,"Order Buy");
   LABEL("L13", "Arial Black", 9, 20,225,Black, 0,"Order Sell");
   LABEL("L14", "Arial ", 9, 20,240,Gold, 0, ls_8);
    LABEL("L15", "Arial Black", 9, 20,255,Black,0,"Time Candle");
    LABEL("L16", "Arial ", 9, 20,275,Gold, 0, ls_8);
    LABEL("L17", "Arial Black", 11, 20,290,Lime,0,"Balance");
    LABEL("L18", "Arial Black", 11, 20,305,Lime,0,"Equity");
    LABEL("L19", "Arial ", 9,20,120,Gold, 3, ls_8);
    LABEL("L20", "Arial", 14,68,97,Black,3,"Floating Saat Ini");
    LABEL("L21", "Arial Black", 28,82,51,Lime,3,""+ DoubleToStr(AccountEquity() - AccountBalance(), 2));
    LABEL("L22", "Arial ", 9,20,43,Gold, 3, ls_8);
  
    //---------------------------------------------------------------------------
  //  LABEL("L30", "Impact",10,50,58,Gold,0," Expert Trial Version ");
   LABEL("L32", "Arial Black", 9, 120,120,Black, 0,": " + AccountServer());
   LABEL("L33", "Arial Black", 9, 120,135,Black, 0,": " + AccountName()); 
   LABEL("L34", "Arial Black", 9, 120,150,Black, 0,": " + (string)AccountNumber());
   LABEL("L35", "Arial Black", 9, 120,165,Black, 0,": 1: " + (string)AccountLeverage());
   LABEL("L36", "Arial Black", 9, 120,180,Black,0,": " + Symbol());
   LABEL("L37", "Arial Black", 9, 120,195,Black, 0,": " + (string)MarketInfo(Symbol(),MODE_SPREAD));
   LABEL("L38", "Arial Black", 9, 120,210,Black, 0,": " + DoubleToStr(Buy, 0));
   LABEL("L39", "Arial Black", 9, 120,225,Black, 0,": " + DoubleToStr(Sell, 0));
    LABEL("L40", "Arial Black", 9, 120,255,Black,0,": "+_m+DoubleToStr(m,0)+":"+_s+DoubleToStr(s,0));
    LABEL("L41", "Arial Black", 11,120,290,Lime,0,": " + DoubleToStr(AccountBalance(), 2));
    LABEL("L42", "Arial Black", 11,120,305,Lime,0,": " + DoubleToStr(AccountEquity(), 2));
    
   
  }

void LABEL(string a_name_0, string a_fontname_8, int a_fontsize_16, int a_x_20, int a_y_24, color a_color_28, int a_corner_32, string a_text_36)
{
    if (ObjectFind(a_name_0) < 0)
        ObjectCreate(a_name_0, OBJ_LABEL, 0, 0, 0);
    ObjectSetText(a_name_0, a_text_36, a_fontsize_16, a_fontname_8, a_color_28);
    ObjectSet(a_name_0, OBJPROP_CORNER, a_corner_32);
    ObjectSet(a_name_0, OBJPROP_XDISTANCE, a_x_20);
    ObjectSet(a_name_0, OBJPROP_YDISTANCE, a_y_24);
}

//=======================================================
 double getTFloating(){
   double   tFloating = 0.0;
   int      tOrder  = OrdersTotal();
   for(int i=tOrder-1; i>=0; i--)
     {
      if(OrderSelect(i, SELECT_BY_POS, MODE_TRADES))
        {
         if(OrderMagicNumber() == Magic)
           {
            tFloating   += OrderProfit()+OrderCommission() + OrderSwap();
           }
        }
     }
   return(tFloating);
}

double getTHistory(){
   double   tHistory    = 0.0;
   int      tOrderHis   = OrdersHistoryTotal();
   string   strToday    = TimeToString(TimeCurrent(), TIME_DATE);
   for(int i=tOrderHis-1; i>=0; i--)
     {
      if(OrderSelect(i, SELECT_BY_POS, MODE_HISTORY))
        {
         if(OrderMagicNumber() == Magic && StringFind(TimeToString(OrderCloseTime(), TIME_DATE), strToday, 0) == 0)
           {
            tHistory   += OrderProfit()+OrderCommission() + OrderSwap();
           }
        }
     }
   return(tHistory);
}
   
/*double dailyprofit()
{
  int day=Day(); double res=0;
  for(int i=0; i<OrdersHistoryTotal(); i++)
  {
      if(!OrderSelect(i,SELECT_BY_POS,MODE_HISTORY))continue;
      if(OrderSymbol()!=Symbol() ) continue;
      if(TimeDay(OrderOpenTime())==day) res+=OrderProfit();
  }
  return(res);
}  */
double money()
{
 double dp =0;
 int i;
 for (i = 0; i < OrdersTotal(); i++) {
  if(!OrderSelect(i, SELECT_BY_POS, MODE_TRADES))continue;
  if (OrderSymbol() != Symbol()  || OrderComment() != EAComment) continue;
  dp += OrderProfit();
 }
 return(dp);
} 

void fCloseAllOrders()
  {
   double   priceClose = 0.0;
   int tOrders = OrdersTotal();
   for(int i=tOrders-1; i>=0; i--)
     {
      if(OrderSelect(i, SELECT_BY_POS, MODE_TRADES))
        {
         if(OrderMagicNumber() == Magic && (OrderType() == OP_BUY || OrderType() == OP_SELL))
           {
            priceClose  = (OrderType()==OP_BUY)?MarketInfo(OrderSymbol(), MODE_BID):MarketInfo(OrderSymbol(), MODE_ASK);
            if(!OrderClose(OrderTicket(), OrderLots(), priceClose, Slippage, clrGold))
              {
               Print("WARNING: Close Failed");
              }
           }
        }
     }
  }

  double LOT()
  {
   double lotsi;
   double ilot_max =MarketInfo(Symbol(),MODE_MAXLOT);
   double ilot_min =MarketInfo(Symbol(),MODE_MINLOT);
   double tick=MarketInfo(Symbol(),MODE_TICKVALUE);
//---
   double  myAccount=AccountBalance();
//---
   if(ilot_min==0.01) LotDigits=2;
   if(ilot_min==0.1) LotDigits=1;
   if(ilot_min==1) LotDigits=0;
//---
   if(AutoLot)
     {
      lotsi=NormalizeDouble((myAccount*LotRisk)/100000,LotDigits);
        } else { lotsi=Lots;
     }
//---
   if(lotsi>=ilot_max) { lotsi=ilot_max; }
//---
   return(lotsi);
  } 
//---------------------------------------------------
  bool JamOP()
{ 

bool jam=1;
if(Time_Filter)
{ jam=0;
  if(Time_Filter)
  {if (Jam_Mulai<Jam_Akhir && Hour()>= Jam_Mulai && Hour()< Jam_Akhir) jam=1;
   if (Jam_Mulai>Jam_Akhir &&(Hour()>= Jam_Mulai || Hour()< Jam_Akhir)) jam=1;}
}// jam
 return(jam);
}
 
void  trail()
{   
  double MyPoint=Point;
  if(Digits==3 || Digits==5) MyPoint=Point*10;
    int b=0,s=0,TicketB=0,TicketS=0;
    int cnt = OrdersTotal();
    for (int xxx = 0; xxx < cnt; xxx++)
    {
        if(!OrderSelect(xxx, SELECT_BY_POS, MODE_TRADES))continue;
        if (OrderSymbol() != Symbol())
        {
            continue;
        }
        if (OrderMagicNumber() != Magic)
        {
            continue;
        }
        if (OrderType() == OP_BUY)
        {
            double OSLB  = NormalizeDouble(OrderStopLoss(), Digits), oopB = bepbuy, BID = NormalizeDouble(Bid, Digits);
            double opitB = NormalizeDouble((BID - oopB) / MyPoint, 0);
            double TSLB  = NormalizeDouble(BID - TrailingStop *MyPoint, Digits);
          if (opitB > TrailingStop && (OSLB <= TSLB - TrailingStep  * MyPoint))
                if(!OrderModify(OrderTicket(), OrderOpenPrice(), TSLB, OrderTakeProfit(), 0, White))continue;
        }

 
        if (OrderType() == OP_SELL)
        {
            double OSLS = NormalizeDouble(OrderStopLoss(), Digits), oopS = bepsell, ASK = NormalizeDouble(Ask, Digits);
            if (OSLS == 0)
            {
                OSLS = 999999999999;
            }
            double opitS = NormalizeDouble((oopS - ASK) / MyPoint, 0);
            double TSLS  = NormalizeDouble(ASK + TrailingStop * MyPoint, Digits);
            if (opitS > TrailingStop && (OSLS >= TSLS + TrailingStep  * MyPoint))
                if(!OrderModify(OrderTicket(), OrderOpenPrice(), TSLS, OrderTakeProfit(), 0, White))continue;            
                
     }
    }
 } 

void closeallpair()
{
   
    int total  = OrdersTotal();
      for (int cnt = total-1 ; cnt >=0 ; cnt--)
      {
         if(!OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES))continue;

         if(OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES)) 
         {
            switch(OrderType())
            {
               case OP_BUY       :
               {
                  if(!OrderClose(OrderTicket(),OrderLots(),MarketInfo(OrderSymbol(),MODE_BID),10,Violet))
                     return;
               }break;                  
               case OP_SELL      :
               {
                  if(!OrderClose(OrderTicket(),OrderLots(),MarketInfo(OrderSymbol(),MODE_ASK),10,Violet))
                     return;
               }break;
            }             
         
            
            if(OrderType()==OP_BUYSTOP || OrderType()==OP_SELLSTOP || OrderType()==OP_BUYLIMIT || OrderType()==OP_SELLLIMIT)
               if(!OrderDelete(OrderTicket()))
               { 
                  Print("Error deleting " + OrderType() + " order : ",GetLastError());
                  return ;
               }
          }
      }
      return ;
}

int CountTradesBuy(){
    int count=0;
    for(int trade=OrdersTotal()-1;trade>=0;trade--){
    int result=OrderSelect(trade,SELECT_BY_POS,MODE_TRADES);
    if(OrderSymbol()!=Symbol()||OrderMagicNumber()!=Magic)continue;
    if(OrderSymbol()==Symbol()&&OrderMagicNumber()==Magic){
      if(OrderType()==OP_BUY){count++;}}}
 return(count);}
//----+ 
int CountTradesSell(){
    int count=0;
    for(int trade=OrdersTotal()-1;trade>=0;trade--){
    int result=OrderSelect(trade,SELECT_BY_POS,MODE_TRADES);
    if(OrderSymbol()!=Symbol()||OrderMagicNumber()!=Magic)continue;
    if(OrderSymbol()==Symbol()&&OrderMagicNumber()==Magic){
      if(OrderType()==OP_SELL ){count++;}}}
 return(count);} 


void myAvg(){
         int      iCount      =  0;
         double   LastOP      =  0;
         double   LastLots    =  0;
         bool     LastIsBuy   =  false;
         int      iTotalBuy   =  0;
         int      iTotalSell  =  0;         
         int      totalsell;
         int      totalbuy;
         
         double   Spread      = 0.0;   
         Spread= MarketInfo(Symbol(), MODE_SPREAD);  
          totalsell = CountTradesSell() > 0;  
            totalbuy = CountTradesBuy()> 0;       
         for(iCount=0;iCount<OrdersTotal();iCount++){                  
           if(!OrderSelect(iCount,SELECT_BY_POS,MODE_TRADES))continue;          
           if(OrderType()==OP_BUY && OrderSymbol()==Symbol()&& OrderMagicNumber()==Magic)
           {
               if(LastOP==0) {LastOP=OrderOpenPrice();}
               if(LastOP>OrderOpenPrice()) {LastOP=OrderOpenPrice();}
               if(LastLots<OrderLots()) {LastLots=OrderLots();}
               LastIsBuy=true;
               iTotalBuy++;
             }

           if(OrderType()==OP_SELL && OrderSymbol()==Symbol()&& OrderMagicNumber()==Magic)
           {
               if(LastOP==0) {LastOP=OrderOpenPrice();}
               if(LastOP<OrderOpenPrice()) {LastOP=OrderOpenPrice();}         
               if(LastLots<OrderLots()) {LastLots=OrderLots();}
               LastIsBuy=false;
               iTotalSell++;
            }         
         }      
         
         /* Jika arah Price adalah DOWNTREND...., Periksa nilai Bid (*/
         if(LastIsBuy){
            if(Bid<=LastOP-(PipStep*Point)){
               ticket=OrderSend(Symbol(),OP_BUY,NormalizeDouble(LotMultiply*LastLots,2),Ask,Slippage,0,0, EAComment,Magic,0,DodgerBlue);
               LastIsBuy=false;
               return;
            }
         }
         /* Jika arah Price adalah Sell...., Periksa nilai Ask (*/
         else if(!LastIsBuy){
            if(Ask>=LastOP+(PipStep*Point)){
             ticket =OrderSend(Symbol(),OP_SELL,NormalizeDouble(LotMultiply*LastLots,2),Bid,Slippage,0,0, EAComment,Magic,0,DeepPink);
             return;
         }
     }
}

