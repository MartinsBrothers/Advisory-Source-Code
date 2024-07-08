//+------------------------------------------------------------------+
//|                                            35.allin5_Plus_TS.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                       Magix Trigger on Grid .mq4 |
//|                                                totom sukopratomo |
//|                                                    Variant OF SWB|
//+------------------------------------------------------------------+


//This is a remake of the original SWB by Totom Sukopratomo.

//There is always risk in trading market through the use of automated 
//traders, so use should always be monitored for account safety and 
//use only if you have funds that you can afford to lose.

//This is a trade strategy automated trader and was meant for others
//to use the same selected indicators used in this EA for educational
//puroses.  Use as a live trading robot may prove to be profitable
//but may also drain your account.

//Have fun with this tool, and Happy Pips!

//Magix


#property copyright "Trigger on Grid"
#define buy -2
#define sell 2
//---- input parameters
extern string    Comments = "Trigger on Grid";
extern bool      stealth_mode=true;
extern bool      use_daily_target=false;
extern double           daily_target=10000;
extern bool             EachTickMode = True;
extern bool      trade_in_fri=true;
extern int       magic=1122;

extern string    Trade_Lot_Settings = "Money Management Settings";
extern bool      AutoLots=false;
extern double    RiskPercent=1;
extern double    start_lot=0.3;
extern double    range=15;
extern int       level=5;
extern bool      lot_multiplier=true;
extern double    multiplier=2;
extern double    increament=0.01;
extern bool      use_sl_and_tp=false;
extern double    sl=60;
extern double    tp=30;
extern bool AutoProfit = true;
extern double tp_factor = 1;
extern double    tp_in_money=3;
extern int    trailStop_std = 13;  

//Indicator settings
extern string    MACD_Settings= "MACD Settings";
extern bool      use_macd=false;
extern int       Fast=12.;
extern int       Slow=26.;
extern int       Signal=9.;

extern string   OsMa_Settings= "OsMA Settings";
extern bool     use_osma=true;
extern int      fast_ema = 12;
extern int      slow_ema = 26;
extern int      signal_period = 9;

extern string  CCI_Settings = "CCI Settings";
extern bool    use_cci=false;
extern int     cci_period = 60;
extern int     cci_cross_level = 100;

// Indicator
extern string  Stochastic_Settings = "Stochastic Settings";
extern bool    use_stochs=false;
extern int     k_period = 110;
extern int     d_period = 3;
extern int     slowing = 3;

//hedge settings removed <-could not verify in live trade scenario
extern bool      hedge=false;
extern int       hedge_start=4;
extern double    h_lot_factor=0.5;
extern double    h_tp_factor=1.0;
extern double    lot_multiplier_2=1.5;
extern int       lot_multi_2_level=3;

double pt;
double minlot;
double stoplevel;
int prec=0;
int a=0;
int ticket=0;

//----
double s_lot,s_lot2,hf,h_tp,lm_1,lm_2,lm_2_level,O_equity;
bool Close_All; // Part of Close_All Inhibit ...
int O_rst=0;
string opt="NULL";


int BarCount;
int Current;
bool TickCheck = False;







//+------------------------------------------------------------------+
//| expert initialization function                                   |
//+------------------------------------------------------------------+
int init()
  {
//----


BarCount = Bars;
   if (EachTickMode) Current = 0; else Current = 1;

   if(Digits==3 || Digits==5) pt=10*Point;
   else                          pt=Point;
   minlot   =   MarketInfo(Symbol(),MODE_MINLOT);
   stoplevel=MarketInfo(Symbol(),MODE_STOPLEVEL);
   if(start_lot<minlot)      Print("lotsize is to small.");
   if(sl<stoplevel)   Print("stoploss is to tight.");
   if(tp<stoplevel) Print("takeprofit is to tight.");
   if(minlot==0.01) prec=2;
   if(minlot==0.1)  prec=1;
//----
   s_lot=start_lot; if(hedge==false){ hedge_start=0; } hf=h_lot_factor; h_tp=h_tp_factor*range*pt;
   lm_1=multiplier; lm_2=lot_multiplier_2; lm_2_level=lot_multi_2_level; O_equity=AccountEquity();
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| expert deinitialization function                                 |
//+------------------------------------------------------------------+
int deinit()
  {
//----
   
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| expert start function                                            |
//+------------------------------------------------------------------+
int start()
  {
   if (AutoLots) {start_lot=AccountFreeMargin()/100000*RiskPercent;  if (start_lot<0.01) start_lot=0.01;} else{ s_lot=start_lot;}
  if (AutoProfit) {tp_in_money=AccountEquity()/100*tp_factor;}
   if(use_daily_target && dailyprofit()>=daily_target)
   {
     Comment("\ndaily target achieved.");
     return(0);
   }
   if(!trade_in_fri && DayOfWeek()==5 && total()==0)
   {
     Comment("\nstop trading in Friday.");
     return(0);
   }
//+------------------------------------------------------------------+
   int T_cnt=0,b_cnt=0,s_cnt=0,h_cnt,O_cnt=0,OOT,FOOT; // Close_All Inhibit ...
   bool s_hedge=false,b_hedge=false; string FOT="0";
   for(int cnt=0; cnt<=OrdersTotal(); cnt++)
   {
      OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES);
      if(OrderSymbol()==Symbol() && OrderMagicNumber()==magic && OrderType()<2)
      {
         T_cnt+=1; OOT=OrderOpenTime();
         if(OrderType()==0){ b_cnt+=1; } if(OrderType()==1){ s_cnt+=1; }
         if(T_cnt==1 || OOT<FOOT){ FOOT=OOT; FOT="B"; if(OrderType()==1){ FOT="S"; } }
      }
   }
//----
   if(FOT=="B")
   {
      O_cnt=b_cnt; h_cnt=s_cnt; opt="BUY";  if(hedge==true && b_cnt>=hedge_start-1){ s_hedge=true; }
   }
   if(FOT=="S")
   {
      O_cnt=s_cnt; h_cnt=b_cnt; opt="SELL"; if(hedge==true && s_cnt>=hedge_start-1){ b_hedge=true; }
   }
//----
   multiplier=lm_1; if(lm_2>0 && O_cnt>=lm_2_level-1){ multiplier=lm_2; }
//----
   if(T_cnt==0){ Close_All=false; }
//+------------------------------------------------------------------+
   if(O_cnt==0 && a==0 && h_cnt==0) // substituted total() with O_cnt ...
   {
     if(signal()==buy && Close_All==false) // added close_all and hedge
     {
        if(stealth_mode)
        {
          if(use_sl_and_tp){ s_lot=start_lot;
           ticket=OrderSend(Symbol(),0,s_lot,Ask,3,0,Ask+tp*pt,Comments,magic,0,Blue); }
          else             { s_lot=start_lot;
           ticket=OrderSend(Symbol(),0,s_lot,Ask,3,        0,        0,Comments,magic,0,Blue); }
        }
        else
        {
          if(use_sl_and_tp) 
          {
             s_lot=start_lot;
             if(OrderSend(Symbol(),0,start_lot,Ask,3,0,Ask+tp*pt,Comments,magic,0,Blue)>0)
             {
                for(int i=1; i<level; i++)
                {
                    if(lot_multiplier){ s_lot=NormalizeDouble(start_lot*MathPow(multiplier,i),prec); ticket=OrderSend(Symbol(),2,s_lot,Ask-(range*i)*pt,3,0,(Ask-(range*i)*pt)+tp*pt,Comments,magic,0,Blue); }
                    else              { s_lot=NormalizeDouble(start_lot+increament*i,prec);          ticket=OrderSend(Symbol(),2,s_lot,Ask-(range*i)*pt,3,0,(Ask-(range*i)*pt)+tp*pt,Comments,magic,0,Blue); }
                }
             }
          }
          else
          {
             s_lot=start_lot;
             if(OrderSend(Symbol(),0,start_lot,Ask,3,0,0,Comments,magic,0,Blue)>0)
             {
                for(i=1; i<level; i++)
                {
                    if(lot_multiplier){ s_lot=NormalizeDouble(start_lot*MathPow(multiplier,i),prec); ticket=OrderSend(Symbol(),2,s_lot,Ask-(range*i)*pt,3,0,0,Comments,magic,0,Blue); }
                    else              { s_lot=NormalizeDouble(start_lot+increament*i,prec);          ticket=OrderSend(Symbol(),2,s_lot,Ask-(range*i)*pt,3,0,0,Comments,magic,0,Blue); }
                }
             }
          }
        }
        if(s_hedge==true){ ticket=OrderSend(Symbol(),1,s_lot*hf,Bid,3,0,Bid-h_tp,"Hedge",magic,0,Red); }
     }
//+------------------------------------------------------------------+
     if(signal()==sell && Close_All==false) // added close_all and hedge
     {
        if(stealth_mode)
        {
          if(use_sl_and_tp){ s_lot=start_lot; 
          ticket=OrderSend(Symbol(),1,s_lot,Bid,3,0,Bid-tp*pt,Comments,magic,0,Red); }
          else             { s_lot=start_lot; 
          ticket=OrderSend(Symbol(),1,s_lot,Bid,3,        0,        0,Comments,magic,0,Red); }
        }
        else
        {
          if(use_sl_and_tp) 
          {
             s_lot=start_lot;
             if(OrderSend(Symbol(),1,start_lot,Bid,3,0,Bid-tp*pt,Comments,magic,0,Red)>0)
             {
                for(i=1; i<level; i++)
                {
                    if(lot_multiplier){ s_lot=NormalizeDouble(start_lot*MathPow(multiplier,i),prec); ticket=OrderSend(Symbol(),3,s_lot,Bid+(range*i)*pt,3,0,(Bid+(range*i)*pt)-tp*pt,Comments,magic,0,Red); }
                    else              { s_lot=NormalizeDouble(start_lot+increament*i,prec);          ticket=OrderSend(Symbol(),3,s_lot,Bid+(range*i)*pt,3,0,(Bid+(range*i)*pt)-tp*pt,Comments,magic,0,Red); }
                }
             }
          }
          else
          {
             s_lot=start_lot;
             if(OrderSend(Symbol(),1,start_lot,Bid,3,0,0,Comments,magic,0,Red)>0)
             {
                for(i=1; i<level; i++)
                {
                    if(lot_multiplier){ s_lot=NormalizeDouble(start_lot*MathPow(multiplier,i),prec); ticket=OrderSend(Symbol(),3,s_lot,Bid+(range*i)*pt,3,0,0,Comments,magic,0,Red); }
                    else              { s_lot=NormalizeDouble(start_lot+increament*i,prec);          ticket=OrderSend(Symbol(),3,s_lot,Bid+(range*i)*pt,3,0,0,Comments,magic,0,Red); }
                }
             }
          }
        }
        if(b_hedge==true){ ticket=OrderSend(Symbol(),0,s_lot*hf,Ask,3,0,Ask+h_tp,"Hedge",magic,0,Blue); }
     } 
   }
//+------------------------------------------------------------------+
   if(stealth_mode && O_cnt>0 && O_cnt<level && h_cnt==0) // substituted total() with O_cnt ...
   {
     int type; double op, lastlot; 
     for(i=0; i<OrdersTotal(); i++)
     {
         OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
         if(OrderSymbol()!=Symbol() || OrderMagicNumber()!=magic) continue;
         type=OrderType();
         op=OrderOpenPrice();
         lastlot=OrderLots();
     }
     if(type==0 && (signal()==buy) && Ask<=op-range*pt && Close_All==false) // added close_all and hedge
     {
        if(use_sl_and_tp)
        {
           if(lot_multiplier){ s_lot=NormalizeDouble(lastlot*multiplier,prec); ticket=OrderSend(Symbol(),0,s_lot,Ask,3,0,Ask+tp*pt,Comments,magic,0,Blue); }
           else              { s_lot=NormalizeDouble(lastlot+increament,prec); ticket=OrderSend(Symbol(),0,s_lot,Ask,3,0,Ask+tp*pt,Comments,magic,0,Blue); }
        }
        else
        {
           if(lot_multiplier){ s_lot=NormalizeDouble(lastlot*multiplier,prec); ticket=OrderSend(Symbol(),0,s_lot,Ask,3,0,0,Comments,magic,0,Blue); }
           else              { s_lot=NormalizeDouble(lastlot+increament,prec); ticket=OrderSend(Symbol(),0,s_lot,Ask,3,0,0,Comments,magic,0,Blue); }
        }
        if(s_hedge==true){ ticket=OrderSend(Symbol(),1,s_lot*hf,Bid,3,0,Bid-h_tp,"Hedge",magic,0,Red); }
     }
     if(type==1 && (signal()==sell) && Bid>=op+range*pt && Close_All==false) // added close_all and hedge
     {
        if(use_sl_and_tp)
        {
           if(lot_multiplier){ s_lot=NormalizeDouble(lastlot*multiplier,prec); ticket=OrderSend(Symbol(),1,s_lot,Bid,3,0,Bid-tp*pt,Comments,magic,0,Red); }
           else              { s_lot=NormalizeDouble(lastlot+increament,prec); ticket=OrderSend(Symbol(),1,s_lot,Bid,3,0,Bid-tp*pt,Comments,magic,0,Red); }
        }
        else
        {
           if(lot_multiplier){ s_lot=NormalizeDouble(lastlot*multiplier,prec); ticket=OrderSend(Symbol(),1,s_lot,Bid,3,0,0,Comments,magic,0,Red); }
           else              { s_lot=NormalizeDouble(lastlot+increament,prec); ticket=OrderSend(Symbol(),1,s_lot,Bid,3,0,0,Comments,magic,0,Red); }
        }
        if(b_hedge==true){ ticket=OrderSend(Symbol(),0,s_lot*hf,Ask,3,0,Ask+h_tp,"Hedge",magic,0,Blue); }
     }
   }
//+------------------------------------------------------------------+
   double st_lots=0,h_lots,t_lots,n_lots; cnt=0; // Close_All Inhibit ...
   for(cnt=0; cnt<=OrdersTotal(); cnt++)
   {
      OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES);
      if(OrderSymbol()==Symbol() && OrderMagicNumber()==magic && OrderType()<2)
      {
         if((FOT=="B" && OrderType()==1) || (FOT=="S" && OrderType()==0)){ h_lots+=OrderLots(); }
         t_lots+=OrderLots(); st_lots=t_lots-h_lots; n_lots=st_lots-h_lots;
      }
   }
//+------------------------------------------------------------------+
   double AE=AccountEquity(),a_profit=AE-O_equity,b_profit; if(a_profit>b_profit){ b_profit=a_profit; }
   Comment("OPT = ",opt,"  /  LEVEL = ",O_cnt,"  /  Hedge Start = ",hedge_start,"  |  Standard Lots = ",DoubleToStr(st_lots,2),
   "  /  Hedge Lots = ",DoubleToStr(h_lots,2),"  /  Net Lots = ",DoubleToStr(n_lots,2),"\n","Account Equity = ",DoubleToStr(AE,2),"  /  Account Profit = ",DoubleToStr(a_profit,2));
//+------------------------------------------------------------------+
   if(use_sl_and_tp && total()>1)
   {
     double s_l, t_p;
     for(i=0; i<OrdersTotal(); i++)
     {
         OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
         if(OrderSymbol()!=Symbol() || OrderMagicNumber()!=magic || OrderType()>1) continue;
         type=OrderType();
         s_l=OrderStopLoss();
         t_p=OrderTakeProfit();
     }
     for(i=OrdersTotal()-1; i>=0; i--)
     {
       OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
       if(OrderSymbol()!=Symbol() || OrderMagicNumber()!=magic || OrderType()>1) continue;
       if(OrderType()==type)
       {
          if(OrderStopLoss()!=s_l || OrderTakeProfit()!=t_p)
          {
             OrderModify(OrderTicket(),OrderOpenPrice(),s_l,t_p,0,CLR_NONE);
          }
       }
     }
   }
   double profit=0;
   for(i=0; i<OrdersTotal(); i++)
   {
      OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
      if(OrderSymbol()!=Symbol() || OrderMagicNumber()!=magic || OrderType()>1) continue;
      profit+=OrderProfit();
   }
   if(profit>=tp_in_money || a>0) 
   {
      closeall();
      closeall();
      closeall();
      a++;
      if(total()==0) a=0;
   }
   if(!stealth_mode && use_sl_and_tp && total()<level) closeall();
//----
   if (trailStop_std >0) TrailIt(trailStop_std);
//----
   return(0);
  }
//+------------------------------------------------------------------+
double dailyprofit()
{
  int day=Day(); double res=0;
  for(int i=0; i<OrdersHistoryTotal(); i++)
  {
      OrderSelect(i,SELECT_BY_POS,MODE_HISTORY);
      if(OrderSymbol()!=Symbol() || OrderMagicNumber()!=magic) continue;
      if(TimeDay(OrderOpenTime())==day) res+=OrderProfit();
  }
  return(res);
}
//+------------------------------------------------------------------+
int total()
{
  int total=0;
  for(int i=0; i<OrdersTotal(); i++)
  {
      OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
      if(OrderSymbol()!=Symbol() || OrderMagicNumber()!=magic) continue;
      total++;
  }
  return(total);
}
//+------------------------------------------------------------------+
int signal()
{
  
/*bool MABUY=false;bool MASELL=false;
  bool MACDB=false;bool MACDS=false;
  bool OSMAB=false;bool OSMAS=false;
  bool CCIB=false;bool CCIS=false;*/ 
  
 double sto1 = iStochastic(Symbol(),0,k_period,d_period,slowing,1,0,MODE_MAIN,0);
 double sto2 = iStochastic(Symbol(),0,k_period,d_period,slowing,1,0,MODE_MAIN,+1);
 double sig1 = iStochastic(Symbol(),0,k_period,d_period,slowing,1,0,MODE_SIGNAL,0);
 double sig2 = iStochastic(Symbol(),0,k_period,d_period,slowing,1,0,MODE_SIGNAL,+1); 
 
 double Buy1_1 = iMACD(NULL, 0, Fast, Slow, Signal, PRICE_OPEN, MODE_MAIN, Current + 0);
 double Buy1_2 = 0;
 double Buy2_1 = iMACD(NULL, 0, Fast, Slow, Signal, PRICE_CLOSE, MODE_MAIN, Current + 2);
 double Buy2_2 = iMACD(NULL, 0, Fast, Slow, Signal, PRICE_CLOSE, MODE_SIGNAL, Current + 2);
 double Buy3_1 = iMACD(NULL, 0, Fast, Slow, Signal, PRICE_CLOSE, MODE_MAIN, Current + 1);
 double Buy3_2 = iMACD(NULL, 0, Fast, Slow, Signal, PRICE_CLOSE, MODE_SIGNAL, Current + 1);

 double Sell1_1 = iMACD(NULL, 0, Fast, Slow, Signal, PRICE_OPEN, MODE_MAIN, Current + 0);
 double Sell1_2 = 0;
 double Sell2_1 = iMACD(NULL, 0, Fast, Slow, Signal, PRICE_CLOSE, MODE_MAIN, Current + 2);
 double Sell2_2 = iMACD(NULL, 0, Fast, Slow, Signal, PRICE_CLOSE, MODE_SIGNAL, Current + 2);
 double Sell3_1 = iMACD(NULL, 0, Fast, Slow, Signal, PRICE_CLOSE, MODE_MAIN, Current + 1);
 double Sell3_2 = iMACD(NULL, 0, Fast, Slow, Signal, PRICE_CLOSE, MODE_SIGNAL, Current + 1);
 
 double osma0 = iOsMA(NULL, 0, fast_ema,slow_ema,signal_period,PRICE_CLOSE, Current + 0);
 double osma1 = iOsMA(NULL, 0, fast_ema,slow_ema,signal_period,PRICE_CLOSE, Current + 1);
 
 double cci1 = iCCI(Symbol(),0,cci_period,PRICE_TYPICAL,Current+0);
 double cci2 = iCCI(Symbol(),0,cci_period,PRICE_TYPICAL,Current+1);



/* if (Buy1_1 < Buy1_2 && Buy2_1 < Buy2_2 && Buy3_1 > Buy3_2) MACDB=true;
   if (Sell1_1 > Sell1_2 && Sell2_1 > Sell2_2 && Sell3_1 < Sell3_2) MACDS=true;
   
   if (osma1 < 0 && osma0 > 0 ) OSMAB=true;
   if (osma1 > 0 && osma0 < 0 ) OSMAB=true;
   
   if (cci1>-1*cci_cross_level && cci2<-1*cci_cross_level) CCIB=true;
   if (cci1<cci_cross_level && cci2>cci_cross_level) CCIS=true; 
   
    */
 
   if (use_stochs) {//stochs
   if (sto1>sig1 && sto2<sig2) return (buy);
   if (sto1<sig1 && sto2>sig2) return (sell);
} 
   if(use_macd){//macd
   if (Buy1_1 < Buy1_2 && Buy2_1 < Buy2_2 && Buy3_1 > Buy3_2) return (buy);
   if (Sell1_1 > Sell1_2 && Sell2_1 > Sell2_2 && Sell3_1 < Sell3_2) return (sell);
}
   if (use_osma){//osma
   if (osma1 < 0 && osma0 > 0) return (buy);
   if (osma1 > 0 && osma0 < 0) return (sell);
}
   if (use_cci){//cci
   if (cci1>-1*cci_cross_level && cci2<-1*cci_cross_level) return (buy);
   if (cci1<cci_cross_level && cci2>cci_cross_level) return (sell);
}
   if (use_macd && use_cci /*&& use_osma && use_stochs*/){//macd cci
   if (Buy1_1 < Buy1_2 && Buy2_1 < Buy2_2 && Buy3_1 > Buy3_2 && /*osma1 < 0 && osma0 > 0 &&*/ cci1>-1*cci_cross_level && cci2<-1*cci_cross_level/* && sto1>sig1 && sto2<sig2*/) return (buy);
   if (Sell1_1 > Sell1_2 && Sell2_1 > Sell2_2 && Sell3_1 < Sell3_2 && /*osma1 > 0 && osma0 < 0 &&*/ cci1<cci_cross_level && cci2>cci_cross_level/* && sto1<sig1 && sto2>sig2*/) return (sell);
}  
   if (use_macd && use_cci && use_osma /*&& use_stochs*/){//macd cci osma
   if (Buy1_1 < Buy1_2 && Buy2_1 < Buy2_2 && Buy3_1 > Buy3_2 && osma1 < 0 && osma0 > 0 && cci1>-1*cci_cross_level && cci2<-1*cci_cross_level/* && sto1>sig1 && sto2<sig2*/) return (buy);
   if (Sell1_1 > Sell1_2 && Sell2_1 > Sell2_2 && Sell3_1 < Sell3_2 && osma1 > 0 && osma0 < 0 && cci1<cci_cross_level && cci2>cci_cross_level/* && sto1<sig1 && sto2>sig2*/) return (sell);
}  
   if (use_macd && use_cci && use_osma && use_stochs){//macd cci osma stochs
   if (Buy1_1 < Buy1_2 && Buy2_1 < Buy2_2 && Buy3_1 > Buy3_2 && osma1 < 0 && osma0 > 0 && cci1>-1*cci_cross_level && cci2<-1*cci_cross_level && sto1>sig1 && sto2<sig2) return (buy);
   if (Sell1_1 > Sell1_2 && Sell2_1 > Sell2_2 && Sell3_1 < Sell3_2 && osma1 > 0 && osma0 < 0 && cci1<cci_cross_level && cci2>cci_cross_level && osma1 > 0 && osma0 < 0 && sto1<sig1 && sto2>sig2) return (sell);
}  
   if (!use_macd && use_cci && use_osma && use_stochs){//cci osma stochs   
   if (/*Buy1_1 < Buy1_2 && Buy2_1 < Buy2_2 && Buy3_1 > Buy3_2 && */osma1 < 0 && osma0 > 0 && cci1>-1*cci_cross_level && cci2<-1*cci_cross_level && sto1>sig1 && sto2<sig2) return (buy);
   if (/*Sell1_1 > Sell1_2 && Sell2_1 > Sell2_2 && Sell3_1 < Sell3_2 &&*/ osma1 > 0 && osma0 < 0 && cci1<cci_cross_level && cci2>cci_cross_level && sto1<sig1 && sto2>sig2) return (sell);
}  
   if (use_osma && use_stochs){//osma stochs
   if (/*Buy1_1 < Buy1_2 && Buy2_1 < Buy2_2 && Buy3_1 > Buy3_2 && */osma1 < 0 && osma0 > 0 && /*cci1>-1*cci_cross_level && cci2<-1*cci_cross_level &&*/ sto1>sig1 && sto2<sig2) return (buy);
   if (/*Sell1_1 > Sell1_2 && Sell2_1 > Sell2_2 && Sell3_1 < Sell3_2 && */osma1 > 0 && osma0 < 0 && /*cci1<cci_cross_level && cci2>cci_cross_level &&*/ sto1<sig1 && sto2>sig2) return (sell);
}  
   if (use_macd && use_stochs){//macd stochs
   if (Buy1_1 < Buy1_2 && Buy2_1 < Buy2_2 && Buy3_1 > Buy3_2 && /*osma1 < 0 && osma0 > 0 && cci1>-1*cci_cross_level && cci2<-1*cci_cross_level &&*/ sto1>sig1 && sto2<sig2) return (buy);
   if (Sell1_1 > Sell1_2 && Sell2_1 > Sell2_2 && Sell3_1 < Sell3_2 && /*osma1 > 0 && osma0 < 0 && cci1<cci_cross_level && cci2>cci_cross_level &&*/ sto1<sig1 && sto2>sig2) return (sell);
}  
   if (use_macd && !use_cci && use_osma /*&& use_stochs*/){//macd osma// 
   if (Buy1_1 < Buy1_2 && Buy2_1 < Buy2_2 && Buy3_1 > Buy3_2 && osma1 < 0 && osma0 > 0 /*&& cci1>-1*cci_cross_level && cci2<-1*cci_cross_level && sto1>sig1 && sto2<sig2*/) return (buy);
   if (Sell1_1 > Sell1_2 && Sell2_1 > Sell2_2 && Sell3_1 < Sell3_2 && osma1 > 0 && osma0 < 0 /*&& cci1<cci_cross_level && cci2>cci_cross_level && sto1<sig1 && sto2>sig2*/) return (sell);
}  
   if (use_macd /*&& !use_cci*/ && use_osma /*&& use_stochs*/){//macd osma stochs
   if (Buy1_1 < Buy1_2 && Buy2_1 < Buy2_2 && Buy3_1 > Buy3_2 && osma1 < 0 && osma0 > 0 && /*cci1>-1*cci_cross_level && cci2<-1*cci_cross_level &&*/ sto1>sig1 && sto2<sig2) return (buy);
   if (Sell1_1 > Sell1_2 && Sell2_1 > Sell2_2 && Sell3_1 < Sell3_2 && osma1 > 0 && osma0 < 0 &&/* cci1<cci_cross_level && cci2>cci_cross_level &&*/ sto1<sig1 && sto2>sig2) return (sell);
}  
   if (/*use_macd &&*/ use_cci && use_osma /*&& use_stochs*/){//osma cci
   if (/*Buy1_1 < Buy1_2 && Buy2_1 < Buy2_2 && Buy3_1 > Buy3_2 &&*/ osma1 < 0 && osma0 > 0 && cci1>-1*cci_cross_level && cci2<-1*cci_cross_level/* && sto1>sig1 && sto2<sig2*/) return (buy);
   if (/*Sell1_1 > Sell1_2 && Sell2_1 > Sell2_2 && Sell3_1 < Sell3_2 &&*/ osma1 > 0 && osma0 < 0 && cci1<cci_cross_level && cci2>cci_cross_level/* && sto1<sig1 && sto2>sig2*/) return (sell);
}  
   if (/*use_macd && */use_cci /*&& use_osma*/ && use_stochs){//cci stochs
   if (/*Buy1_1 < Buy1_2 && Buy2_1 < Buy2_2 && Buy3_1 > Buy3_2 && osma1 < 0 && osma0 > 0 &&*/ cci1>-1*cci_cross_level && cci2<-1*cci_cross_level && sto1>sig1 && sto2<sig2) return (buy);
   if (/*Sell1_1 > Sell1_2 && Sell2_1 > Sell2_2 && Sell3_1 < Sell3_2 && osma1 > 0 && osma0 < 0 &&*/ cci1<cci_cross_level && cci2>cci_cross_level && sto1<sig1 && sto2>sig2) return (sell);
}  
 
  }
return(0);

//+------------------------------------------------------------------+
void closeall()
{
  for(int i=OrdersTotal()-1; i>=0; i--)
  {
      OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
      if(OrderSymbol()!=Symbol() || OrderMagicNumber()!=magic) continue; Close_All=true; // Close_All Inhibit ...
      if(OrderType()>1) OrderDelete(OrderTicket());
      else
      {
        if(OrderType()==0) OrderClose(OrderTicket(),OrderLots(),Bid,3,CLR_NONE);
        else               OrderClose(OrderTicket(),OrderLots(),Ask,3,CLR_NONE);
      }
  }
} 
 //+------------------------------------------------------------------+
//| Trailing stop procedure                                          |
//+------------------------------------------------------------------+
void TrailIt( int byPips )                   // based on trailing stop code from MT site... thanks MT!
  {
  if (byPips >=5)
  {
   for (int i = 0; i < OrdersTotal(); i++) {
     OrderSelect(i, SELECT_BY_POS, MODE_TRADES);
     if ( OrderSymbol()==Symbol() && ( (OrderMagicNumber() == magic) ) )  // only look if mygrid and symbol...
        {
            if (OrderType() == OP_BUY) {
               //if (Bid > (OrderValue(cnt,VAL_OPENPRICE) + TrailingStop * Point)) {
               //   OrderClose(OrderTicket(), OrderLots(), Bid, 3, Violet);
               //   break;
               //}
               if (Bid - OrderOpenPrice() > byPips * pt) {
                  if (OrderStopLoss() < Bid - byPips * pt) {
                     OrderModify(OrderTicket(), OrderOpenPrice(), Bid - byPips * pt, OrderTakeProfit(), Red);
                  }
               }
            } else if (OrderType() == OP_SELL) {
               if (OrderOpenPrice() - Ask > byPips * pt) {
                  if ((OrderStopLoss() > Ask + byPips * pt) || 
                        (OrderStopLoss() == 0)) {
                     OrderModify(OrderTicket(), OrderOpenPrice(),
                        Ask + byPips * pt, OrderTakeProfit(), Red);
                  }
               }
            }
        }
	  }
	  }

  } // proc TrailIt()
        
