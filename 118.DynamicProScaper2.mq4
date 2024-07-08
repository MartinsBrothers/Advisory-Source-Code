//+------------------------------------------------------------------+
//|                                        118.DynamicProScaper2.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

#property copyright "Copyright 2013, www.forex-monitor.com"
#property link      "www.forex-monitor.com"

#import "Kernel32.dll"
   void GetLocalTime(int& a0[]);
   void GetSystemTime(int& a0[]);
   int GetTimeZoneInformation(int& a0[]);
#import "wininet.dll"
   int InternetOpenA(string a0, int a1, string a2, string a3, int a4);
   int InternetOpenUrlA(int a0, string a1, string a2, int a3, int a4, int a5);
   int InternetReadFile(int a0, string a1, int a2, int& a3[]);
   int InternetCloseHandle(int a0);
#import

string var_g_s__76 = "http://www.forex-monitor.com/authenticate/";
bool var_g_i__84 = FALSE;
string var_g_s__88 = "2.1";
string var_g_s__dps_96 = "DPS";
//extern string Your_Email = "your@email.com";
extern int MagicNumber = 654654;
extern bool Auto_GMT = TRUE;
extern bool Calculate_DST = TRUE;
extern int Manual_GMT_Offset = -3;
extern double Auto_Risk = 75.0;
extern double Lots = 0.25;
extern int Slipage = 1;
extern int Max_Spread = 20;
extern int Stop_Loss = 40;
extern int Take_Profit = 75;
extern int Channel_Period = 20;
extern int Exit_Distance = -5;
extern int Entry_Break = 1;
extern int Min_Volatility = 20;
extern int Start_Trade_Hour = 20;
extern int End_Trade_Hour = 23;
extern int Exit_Profit_Pips = -5;
int var_g___period_188 = 2;
extern int Reverse_Profit = 30;
extern int Exit_Minutes = 30;
extern int Time_Profit_Pips = 2;

extern bool Trade_in_Monday  =true; 
extern bool Trade_in_Tuesday =false; 
extern bool Trade_in_Wednesday=true;
extern bool Trade_in_Thursday=true; 
extern bool Trade_in_Friday  =false;

extern color   background_color = Blue;
//extern string  Comment_2 = "signalStoch";
//extern bool    SignalStoch = true;
//extern int     Stoch_k = 10;
//extern int     Stoch_d = 3;
//extern int     Stoch_slowing = 3;
//extern int     Stoch_pricefield = 0;//Price field parameter. Can be one of this values: 0 - Low/High or 1 - Close/Close.
//extern int     Stoch_shift = 0;// Index of the value taken from the indicator buffer (shift relative to the current bar the given amount of periods ago).
//extern int     Stoch_lo = 30 ;
//extern int     Stoch_up = 70 ;



extern string  Comment_3 = "SignalMegaFX";
extern bool    SignalMegaFX = true;
extern int     PeriodMegaFX = 1 ;
int  mper[10]={0,1,5,15,30,60,240,1440,10080,43200};

bool var_g_i__212 = TRUE;
int var_g_i__unused_216 = 0;
double var_g_d__unused_220 = 0.01;
double var_g___maxlot_228 = 0.01;
double var_g___lotstep_236 = 0.01;
int var_g_i__unused_244 = 100000;
double var_g___marginrequired_248 = 1000.0;
double var_g_d__256 = 0.0001;
bool var_g_i__264 = FALSE;
double var_g___minlot_268 = 0.0;
double var_g_d__unused_276 = 0.0;
int var_g_i__unused_284 = 0;
int var_g___lotsize_288 = 0;
int var_g___stoplevel_292 = 0;
int var_g_i__296 = 0;
int var_g_i__300 = 1;
string var_g_s__304 = "";
int var_g_i__312;
int var_g_i__316;
int var_g_i__320 = 0;
int var_g_i__324 = 1;
int td_unused_0 = 3;
int var_g_i__332 = 13;
int cmd_148,count_124;

void init() {
   MathSrand(TimeLocal());
   var_g_i__212 = TRUE;
   var_g_i__84 = FALSE;
   Comment("");
   var_g_i__264 = TRUE;
}

int deinit() {
   Comment("");
   return (0);
}

void start() {
   string var_l_s__8;
   int var_l_i__16;
   int var_l_i__20;
   string var_l_s__24;
   double lots_36;
   string var_l_s__44;
   string var_l_s__52;
   int var_l_i__unused_56;
   int slippage_60;
   int slippage_64;
   int var_l_i__68;
   int var_l_i__72;
   double var_l_d__76;
   double var_l_d__84;
   double ima_92;
   double ima_100;
   double var_l_d__108;
   int ticket_116;
   int count_120;
   double price_132;
   double price_140;
   string var_l_s__152;
   color color_160;
   double price_164;
   string var_l_s__0 = "";
   
   double max = NormalizeDouble(iHigh(Symbol(),1440,0),Digits);
   double min = NormalizeDouble(iLow (Symbol(),1440,0),Digits);
   double opp=NormalizeDouble(iOpen(Symbol(),1440,0),Digits);
   double cl=NormalizeDouble(iClose(Symbol(),1440,0),Digits);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
  // double dis   =NormalizeDouble(Distanciya*Point,Digits);
   double spred =NormalizeDouble(MarketInfo(Symbol(),MODE_SPREAD)*Point,Digits);
   //double  CORR=NormalizeDouble(Plus            *Point,Digits);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~// 
int sigup=0;
int sigdw=0;
 if(cl>min) { double x=NormalizeDouble(cl*100/min-100,2); }
   if(cl<max) { double y=NormalizeDouble(cl*100/max-100,2); }
   double  Procent    =1.3;
if (Procent*(-1)<=y&&Close[1]>Open[1]){ sigup=1; sigdw=0; }
if (Procent     >=x&&Close[1]<Open[1]){ sigup=0; sigdw=1; }  

   if (var_g_i__212) {
      var_g_i__212 = FALSE;
      var_g___stoplevel_292 = MarketInfo(Symbol(), MODE_STOPLEVEL);
      var_g___minlot_268 = MarketInfo(Symbol(), MODE_MINLOT);
      var_g___maxlot_228 = MarketInfo(Symbol(), MODE_MAXLOT);
      var_g___lotsize_288 = MarketInfo(Symbol(), MODE_LOTSIZE);
      var_g___lotstep_236 = MarketInfo(Symbol(), MODE_LOTSTEP);
      var_g___marginrequired_248 = MarketInfo(Symbol(), MODE_MARGINREQUIRED);
      if (Digits <= 3) var_g_d__256 = 0.01;
      else var_g_d__256 = 0.0001;
      var_g_i__296 = f0_4();
      var_g_i__300 = NormalizeDouble(59.0 * (MathRand() / 32767.0), 0) + 1.0;
      if (IsTesting()) Calculate_DST = FALSE;
      if (IsTesting() || Auto_GMT == FALSE) var_g_i__296 = Manual_GMT_Offset;
      if (!IsTesting() && Auto_GMT == TRUE && Calculate_DST == TRUE && (Month() > 3 && Month() < 11)) var_g_i__296--;
      if (!IsTesting() && Auto_GMT == TRUE && Calculate_DST == TRUE && Month() <= 3 || Month() >= 11) {
      }
      if (!IsTesting() && Auto_GMT == TRUE && Calculate_DST == FALSE) {
      }
   }
   
     if(!TimeFilter()) return (0);
    
     
   if (!IsTesting() && IsDllsAllowed() == FALSE) {
      Comment("Warning: Set Parameter **AllowDLL Imports** ON in menu Tools -> Options -> ExpertAdvisors.");
      Print("Warning: Set Parameter **AllowDLL Imports** ON in menu Tools -> Options -> ExpertAdvisors.");
      Sleep(30000);
      return;
   }
   /*if ((!var_g_i__84) && !IsTesting()) {
      if (f0_3(var_g_s__76 + "?email=" + Your_Email + "&robot=" + var_g_s__dps_96 + "&version=" + var_g_s__88, var_l_s__8)) {
         if (StringTrimRight(StringTrimLeft(f0_2(var_l_s__8, 0, "<result>", "</result>", var_l_i__16))) == "OK") var_g_i__84 = TRUE;
         else {
            Comment("\n Authentication failure! Visit WWW.FOREX-MONITOR.COM and subscribe to activate your free copy!");
            Alert("Authentication failure! Visit WWW.FOREX-MONITOR.COM and subscribe to activate your free copy!");
            Sleep(30000);
            return;
         }
      } else {
         Comment("\n Authentication failed (error number " + DoubleToStr(GetLastError(), 0) + "). Contsct us: support@forex-monitor.com");
         Alert("Authentication failed (error number " + DoubleToStr(GetLastError(), 0) + "). Contsct us: support@forex-monitor.com");
         Sleep(30000);
         return;
      }
   }*/
   /*if ((Hour() == 0 || Hour() == 3 || Hour() == 6 || Hour() == 9 || Hour() == 12 || Hour() == 15 || Hour() == 18 || Hour() == 21 && Minute() == var_g_i__300) || var_g_i__264 && (!IsTesting()) &&
      iVolume(NULL, PERIOD_M1, 0) <= 1.0) {
      if (f0_3(var_g_s__76 + "?email=" + Your_Email + "&info=1&robot=" + var_g_s__dps_96 + "&version=" + var_g_s__88, var_l_s__8)) {
         var_g_s__304 = StringTrimRight(StringTrimLeft(f0_2(var_l_s__8, 0, "<result>", "</result>", var_l_i__16)));
         var_l_i__20 = f0_1(var_g_s__304, "#");
         if (var_l_i__20 > 0) {
            var_l_s__24 = "";
            for (int count_32 = 0; count_32 < var_l_i__20 + 1; count_32++) {
               var_l_s__24 = var_l_s__24 
               + "\n  " + f0_5(var_g_s__304, "#", count_32);
            }
            var_g_s__304 = var_l_s__24;
         }
      }
      var_g_i__264 = FALSE;
   }*/
   if (Auto_Risk > 0.0) lots_36 = MathMax(var_g___minlot_268, MathMin(var_g___maxlot_228, MathCeil(MathMin(100, Auto_Risk) / 100.0 * AccountFreeMargin() / var_g___lotstep_236 / (var_g___lotsize_288 / 100)) * var_g___lotstep_236));
   if (Auto_Risk == 0.0) lots_36 = Lots;
   if (Auto_GMT) var_l_s__44 = "Auto GMT - ON";
   else var_l_s__44 = "Auto GMT - OFF !!!";
   if (IsTesting()) Calculate_DST = FALSE;
   if (Calculate_DST == TRUE) var_l_s__52 = "YES";
   if (Calculate_DST == FALSE) var_l_s__52 = "NO";
   if (!IsTesting() && !IsOptimization())
   {
   var_l_s__0 = var_l_s__0 
      + "\n ------------------------------------------" 
      + "\n  ROBO SCALPER X" 
      + "\n ------------------------------------------" 
      + "\n ------------------------------------------" 
      + "\n  USE ON M1 CHART" 
      + "\n ------------------------------------------" 
      + "\n  " + var_l_s__44 
      + "\n  Calculate DST - " + var_l_s__52 
      + "\n  Broker GMT = " + var_g_i__296 
      + "\n  Stop Loss = " + Stop_Loss + " pips" 
      + "\n  Take Profit = " + Take_Profit + " pips" 
   + "\n  Spread = " + DoubleToStr((Ask - Bid) / var_g_d__256, 1) + " pips";
   
   if (Ask - Bid > Max_Spread * var_g_d__256) var_l_s__0 = var_l_s__0 + " - HIGH !!!";
   else var_l_s__0 = var_l_s__0 + " - In Norm";
   if (Auto_Risk > 0.0) {
      var_l_s__0 = var_l_s__0 
         + "\n  AutoRisk - Activated" 
      + "\n  Risk = " + DoubleToStr(Auto_Risk, 1) + "%";
   }
   var_l_s__0 = var_l_s__0 
   + "\n  Trading Lots = " + DoubleToStr(lots_36, 2);
   var_l_s__0 = var_l_s__0 
   + "\n  ------------------------------------------";
   var_l_s__0 = var_l_s__0 
   + "\n  REALTIME INFO & MARKET ADVISES:";
   var_l_s__0 = var_l_s__0 
   + "\n  ...";
   var_l_s__0 = var_l_s__0 + var_g_s__304;
   bool Gi_596 = true;
    int Li_84 = 11;
   if (Gi_596 || Seconds() % 5 == 0) {
         Gi_596 = FALSE;
         for (int count_88 = 0; count_88 < 9; count_88++) {
            for (int count_92 = 0; count_92 < Li_84; count_92++) {
               ObjectDelete("background" + count_88 + count_92);
               ObjectDelete("background" + count_88 + ((count_92 + 1)));
               ObjectDelete("background" + count_88 + ((count_92 + 2)));
               ObjectCreate("background" + count_88 + count_92, OBJ_LABEL, 0, 0, 0);
               ObjectSetText("background" + count_88 + count_92, "n", 30, "Wingdings", background_color);
               ObjectSet("background" + count_88 + count_92, OBJPROP_XDISTANCE, 20 * count_88);
               ObjectSet("background" + count_88 + count_92, OBJPROP_YDISTANCE, 23 * count_92 + 9);
            }
         }
      }
   Comment(var_l_s__0);
   }
   if (IsTradeAllowed()) {
      if (IsTradeContextBusy() == FALSE) {
         slippage_60 = Slipage * var_g_d__256;
         slippage_64 = Slipage * var_g_d__256;
         if (Take_Profit < var_g___stoplevel_292 * Point / var_g_d__256) Take_Profit = var_g___stoplevel_292 * Point / var_g_d__256;
         if (Stop_Loss < var_g___stoplevel_292 * Point / var_g_d__256) Stop_Loss = var_g___stoplevel_292 * Point / var_g_d__256;
         var_l_i__68 = Start_Trade_Hour + var_g_i__296;
         var_l_i__72 = End_Trade_Hour + var_g_i__296;
         if (var_l_i__68 > 23) var_l_i__68 -= 24;
         if (var_l_i__68 < 0) var_l_i__68 += 24;
         if (var_l_i__72 > 23) var_l_i__72 -= 24;
         if (var_l_i__72 < 0) var_l_i__72 += 24;
         HideTestIndicators(TRUE);
         var_l_d__76 = iMA(NULL, PERIOD_M15, Channel_Period, 0, MODE_SMA, PRICE_CLOSE, 1) + 2.0 * iStdDev(NULL, PERIOD_M15, Channel_Period, 0, MODE_SMA, PRICE_CLOSE, 1);
         var_l_d__84 = iMA(NULL, PERIOD_M15, Channel_Period, 0, MODE_SMA, PRICE_CLOSE, 1) - 2.0 * iStdDev(NULL, PERIOD_M15, Channel_Period, 0, MODE_SMA, PRICE_CLOSE, 1);
         ima_92 = iMA(NULL, PERIOD_M1, var_g___period_188, 0, MODE_SMA, PRICE_CLOSE, 1);
         ima_100 = iMA(NULL, PERIOD_M1, var_g___period_188, 0, MODE_SMA, PRICE_CLOSE, 2);
         HideTestIndicators(FALSE);
         var_l_d__108 = var_l_d__76 - var_l_d__84;
         count_120 = 0;
         count_124 = 0;
         for (int pos_128 = OrdersTotal() - 1; pos_128 >= 0; pos_128--) {
            if (!OrderSelect(pos_128, SELECT_BY_POS, MODE_TRADES)) Print("Error in OrderSelect! Position:", pos_128);
            else {
               if (OrderType() <= OP_SELL && OrderSymbol() == Symbol() && OrderMagicNumber() == MagicNumber) {
                  RefreshRates();
                  if (OrderType() == OP_BUY) {
                     count_120++;
                     if (OrderStopLoss() == 0.0) {
                        price_132 = NormalizeDouble(Ask - Stop_Loss * var_g_d__256, Digits);
                        price_140 = NormalizeDouble(Ask + Take_Profit * var_g_d__256, Digits);
                        OrderModify(OrderTicket(), OrderOpenPrice(), price_132, price_140, 0, Green);
                        continue;
                     }
                     if (iVolume(NULL, PERIOD_M1, 0) <= 1.0 && (TimeCurrent() - OrderOpenTime() > 60 * Exit_Minutes && Bid - OrderOpenPrice() > Time_Profit_Pips * var_g_d__256) || (Bid >= var_l_d__76 +
                        Exit_Distance * var_g_d__256 && Bid - OrderOpenPrice() > Exit_Profit_Pips * var_g_d__256) || (ima_92 < ima_100 && Bid - OrderOpenPrice() > Reverse_Profit * var_g_d__256)) {
                        OrderClose(OrderTicket(), OrderLots(), NormalizeDouble(Bid, Digits), slippage_64, Violet);
                        Sleep(5000);
                        continue;
                     }
                     count_120++;
                     continue;
                  }
                  count_124++;
                  if (OrderStopLoss() == 0.0) {
                     price_132 = NormalizeDouble(Bid + Stop_Loss * var_g_d__256, Digits);
                     price_140 = NormalizeDouble(Bid - Take_Profit * var_g_d__256, Digits);
                     OrderModify(OrderTicket(), OrderOpenPrice(), price_132, price_140, 0, Green);
                     continue;
                  }
                  if (iVolume(NULL, PERIOD_M1, 0) <= 1.0 && (TimeCurrent() - OrderOpenTime() > 60 * Exit_Minutes && OrderOpenPrice() - Ask > Time_Profit_Pips * var_g_d__256) || (Bid <= var_l_d__84 - Exit_Distance * var_g_d__256 &&
                     OrderOpenPrice() - Ask > Exit_Profit_Pips * var_g_d__256) || (ima_92 > ima_100 && OrderOpenPrice() - Ask > Reverse_Profit * var_g_d__256)) {
                     OrderClose(OrderTicket(), OrderLots(), NormalizeDouble(Ask, Digits), slippage_64, Violet);
                     Sleep(5000);
                     continue;
                  }
                  count_124++;
               }
            }
         }
         if (iVolume(NULL, PERIOD_M1, 0) <= 1.0) {
            cmd_148 = -1;
            if (((var_l_i__68 <= var_l_i__72 && TimeHour(TimeCurrent()) >= var_l_i__68 && TimeHour(TimeCurrent()) <= var_l_i__72) || (var_l_i__68 > var_l_i__72 && TimeHour(TimeCurrent()) >= var_l_i__68 || TimeHour(TimeCurrent()) <= var_l_i__72)) &&
               count_120 < 1 && Bid < var_l_d__84 - Entry_Break * var_g_d__256 && var_l_d__108 >= Min_Volatility * var_g_d__256  && SignalMega() == 1 && sigup == 1) {
               var_l_s__152 = "BUY";
               cmd_148 = 0;
               color_160 = Aqua;
               RefreshRates();
               price_164 = NormalizeDouble(Ask, Digits);
            }
            if (((var_l_i__68 <= var_l_i__72 && TimeHour(TimeCurrent()) >= var_l_i__68 && TimeHour(TimeCurrent()) <= var_l_i__72) || (var_l_i__68 > var_l_i__72 && TimeHour(TimeCurrent()) >= var_l_i__68 || TimeHour(TimeCurrent()) <= var_l_i__72)) &&
               count_124 < 1 && Bid > var_l_d__76 + Entry_Break * var_g_d__256 && var_l_d__108 >= Min_Volatility * var_g_d__256  && SignalMega() == -1 && sigdw == 1) {
               var_l_s__152 = "SELL";
               cmd_148 = 1;
               color_160 = Red;
               RefreshRates();
               price_164 = NormalizeDouble(Bid, Digits);
            }
            if (cmd_148 >= OP_BUY) {
               ticket_116 = OrderSend(Symbol(), cmd_148, lots_36, price_164, slippage_60, 0, 0, "DPScalper", MagicNumber, 0, color_160);
               Sleep(5000);
               if (ticket_116 > 0) {
                  if (OrderSelect(ticket_116, SELECT_BY_TICKET, MODE_TRADES)) Print("Order " + var_l_s__152 + " opened!: ", OrderOpenPrice());
               } else Print("Error opening " + var_l_s__152 + " order!: ", GetLastError());
            }
         }
         
      }
   }
}

int f0_4() {
   int var_l_i_a_0[4];
   int var_l_i_a_4[43];
   GetSystemTime(var_l_i_a_0);
   int var_l_i__8 = var_l_i_a_0[0] & 65535;
   int var_l_i__12 = var_l_i_a_0[0] >> 16;
   int var_l_i__16 = var_l_i_a_0[1] >> 16;
   int var_l_i__20 = var_l_i_a_0[2] & 65535;
   int var_l_i__24 = var_l_i_a_0[2] >> 16;
   int var_l_i__28 = var_l_i_a_0[3] & 65535;
   string var_l_s__32 = f0_6(var_l_i__8, var_l_i__12, var_l_i__16, var_l_i__24, var_l_i__24, var_l_i__28);
   GetLocalTime(var_l_i_a_0);
   var_l_i__8 = var_l_i_a_0[0] & 65535;
   var_l_i__12 = var_l_i_a_0[0] >> 16;
   var_l_i__16 = var_l_i_a_0[1] >> 16;
   var_l_i__20 = var_l_i_a_0[2] & 65535;
   var_l_i__24 = var_l_i_a_0[2] >> 16;
   var_l_i__28 = var_l_i_a_0[3] & 65535;
   int var_l_i__40 = var_l_i_a_0[3] >> 16;
   string var_l_s__44 = var_l_i__40 + 1000;
   var_l_s__44 = StringSubstr(var_l_s__44, 1);
   var_l_s__32 = f0_6(var_l_i__8, var_l_i__12, var_l_i__16, var_l_i__20, var_l_i__24, var_l_i__28);
   int var_l_i__52 = 0;
   int var_l_i__56 = GetTimeZoneInformation(var_l_i_a_4);
   if (var_l_i__56 != 0) var_l_i__52 = var_l_i_a_4[0];
   if (var_l_i__56 == 2) var_l_i__52 += var_l_i_a_4[42];
   int str2time_60 = StrToTime(var_l_s__32);
   int var_l_i__64 = TimeCurrent() - (str2time_60 + 60 * var_l_i__52);
   double var_l_d__68 = MathRound(var_l_i__64 / 360);
   int var_l_i__ret_76 = MathRound(var_l_d__68 / 10.0);
   return (var_l_i__ret_76);
}

string f0_6(int var_a_i__0, int var_a_i__4, int var_a_i__8, int var_a_i__12, int var_a_i__16, int var_a_i__20) {
   string var_l_s__24 = var_a_i__4 + 100;
   var_l_s__24 = StringSubstr(var_l_s__24, 1);
   string var_l_s__32 = var_a_i__8 + 100;
   var_l_s__32 = StringSubstr(var_l_s__32, 1);
   string var_l_s__40 = var_a_i__12 + 100;
   var_l_s__40 = StringSubstr(var_l_s__40, 1);
   string var_l_s__48 = var_a_i__16 + 100;
   var_l_s__48 = StringSubstr(var_l_s__48, 1);
   string var_l_s__56 = var_a_i__20 + 100;
   var_l_s__56 = StringSubstr(var_l_s__56, 1);
   return (StringConcatenate(var_a_i__0, ".", var_l_s__24, ".", var_l_s__32, " ", var_l_s__40, ":", var_l_s__48, ":", var_l_s__56));
}

bool TimeFilter(){

 bool _res = false;
   datetime _time_curent = TimeCurrent();
   datetime _time_start = StrToTime(DoubleToStr(Year(),0)+"."+DoubleToStr(Month(),0)+"."+DoubleToStr(Day(),0)+" "+Start_Trade_Hour);
   datetime _time_stop = StrToTime(DoubleToStr(Year(),0)+"."+DoubleToStr(Month(),0)+"."+DoubleToStr(Day(),0)+" "+End_Trade_Hour);
   if(((Trade_in_Monday==true) && (TimeDayOfWeek(Time[0]) == 1)) ||
   ((Trade_in_Tuesday==true) && (TimeDayOfWeek(Time[0]) == 2)) ||
   ((Trade_in_Wednesday==true) && (TimeDayOfWeek(Time[0]) == 3)) ||
   ((Trade_in_Thursday==true) && (TimeDayOfWeek(Time[0]) == 4)) ||
   ((Trade_in_Friday==true) && (TimeDayOfWeek(Time[0]) == 5)))
   _res = true;
   
   //if(_time_start > _time_stop){
   //   if(_time_curent >= _time_start || _time_curent <= _time_stop) _res = true;
   //}else   
   //   if(_time_curent >= _time_start && _time_curent <= _time_stop) _res = true;
      
      return(_res); 
  
 }        
 
// int Sinalstochastic() {
//
//   double istochastic_0 = iStochastic(Symbol(), 0, Stoch_k, Stoch_d, Stoch_slowing, MODE_SMA, Stoch_pricefield, MODE_SIGNAL, Stoch_shift);
//   int vret = 0;
//     if (istochastic_0 > Stoch_up) vret= -1;
//      if (istochastic_0 < Stoch_lo) vret= 1;
// 
//   return (vret);
//}

int SignalMega()
{
  int   MegaFX = iCustom(Symbol(),mper[PeriodMegaFX],"mega_fx",6,0);

  return(MegaFX);      
}
        
