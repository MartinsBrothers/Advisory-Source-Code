//+------------------------------------------------------------------+
//|            117.DynamicProScalper_2.1_eduFIX(trueforex.pp.ua).mq4 |
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

string gs_76 = "http://www.forex-monitor.com/authenticate/";
bool gi_84 = FALSE;
string gs_88 = "2.1";
string gs_dps_96 = "DPS";
//extern string Your_Email = "your@email.com";
extern int MagicNumber = 654654;
extern bool Auto_GMT = TRUE;
extern bool Calculate_DST = TRUE;
extern int Manual_GMT_Offset = 2;
extern double Auto_Risk = 0.0;
extern double Lots = 0.1;
extern int Slipage = 1;
extern int Max_Spread = 3;
extern int Stop_Loss = 38;
extern int Take_Profit = 35;
extern int Channel_Period = 20;
extern int Exit_Distance = -13;
extern int Entry_Break = 1;
extern int Min_Volatility = 20;
extern int Start_Trade_Hour = 20;
extern int End_Trade_Hour = 23;
extern int Exit_Profit_Pips = -12;
int g_period_188 = 2;
extern int Reverse_Profit = 20;
extern int Exit_Minutes = 140;
extern int Time_Profit_Pips = 0;
bool gi_212 = TRUE;
int gi_unused_216 = 0;
double gd_unused_220 = 0.01;
double g_maxlot_228 = 0.01;
double g_lotstep_236 = 0.01;
int gi_unused_244 = 100000;
double g_marginrequired_248 = 1000.0;
double gd_256 = 0.0001;
bool gi_264 = FALSE;
double g_minlot_268 = 0.0;
double gd_unused_276 = 0.0;
int gi_unused_284 = 0;
int g_lotsize_288 = 0;
int g_stoplevel_292 = 0;
int gi_296 = 0;
int gi_300 = 1;
string gs_304 = "";
int gi_312;
int gi_316;
int gi_320 = 0;
int gi_324 = 1;
int td_unused_0 = 3;
int gi_332 = 13;
int cmd_148,count_124;

void init() {
   MathSrand(TimeLocal());
   gi_212 = TRUE;
   gi_84 = FALSE;
   Comment("");
   gi_264 = TRUE;
}

int deinit() {
   Comment("");
   return (0);
}

void start() {
   string ls_8;
   int li_16;
   int li_20;
   string ls_24;
   double lots_36;
   string ls_44;
   string ls_52;
   int li_unused_56;
   int slippage_60;
   int slippage_64;
   int li_68;
   int li_72;
   double ld_76;
   double ld_84;
   double ima_92;
   double ima_100;
   double ld_108;
   int ticket_116;
   int count_120;
   double price_132;
   double price_140;
   string ls_152;
   color color_160;
   double price_164;
   string ls_0 = "";
   if (gi_212) {
      gi_212 = FALSE;
      g_stoplevel_292 = MarketInfo(Symbol(), MODE_STOPLEVEL);
      g_minlot_268 = MarketInfo(Symbol(), MODE_MINLOT);
      g_maxlot_228 = MarketInfo(Symbol(), MODE_MAXLOT);
      g_lotsize_288 = MarketInfo(Symbol(), MODE_LOTSIZE);
      g_lotstep_236 = MarketInfo(Symbol(), MODE_LOTSTEP);
      g_marginrequired_248 = MarketInfo(Symbol(), MODE_MARGINREQUIRED);
      if (Digits <= 3) gd_256 = 0.01;
      else gd_256 = 0.0001;
      gi_296 = f0_4();
      gi_300 = NormalizeDouble(59.0 * (MathRand() / 32767.0), 0) + 1.0;
      if (IsTesting()) Calculate_DST = FALSE;
      if (IsTesting() || Auto_GMT == FALSE) gi_296 = Manual_GMT_Offset;
      if (!IsTesting() && Auto_GMT == TRUE && Calculate_DST == TRUE && (Month() > 3 && Month() < 11)) gi_296--;
      if (!IsTesting() && Auto_GMT == TRUE && Calculate_DST == TRUE && Month() <= 3 || Month() >= 11) {
      }
      if (!IsTesting() && Auto_GMT == TRUE && Calculate_DST == FALSE) {
      }
   }
   if (!IsTesting() && IsDllsAllowed() == FALSE) {
      Comment("Warning: Set Parameter **AllowDLL Imports** ON in menu Tools -> Options -> ExpertAdvisors.");
      Print("Warning: Set Parameter **AllowDLL Imports** ON in menu Tools -> Options -> ExpertAdvisors.");
      Sleep(30000);
      return;
   }
   /*if ((!gi_84) && !IsTesting()) {
      if (f0_3(gs_76 + "?email=" + Your_Email + "&robot=" + gs_dps_96 + "&version=" + gs_88, ls_8)) {
         if (StringTrimRight(StringTrimLeft(f0_2(ls_8, 0, "<result>", "</result>", li_16))) == "OK") gi_84 = TRUE;
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
   /*if ((Hour() == 0 || Hour() == 3 || Hour() == 6 || Hour() == 9 || Hour() == 12 || Hour() == 15 || Hour() == 18 || Hour() == 21 && Minute() == gi_300) || gi_264 && (!IsTesting()) &&
      iVolume(NULL, PERIOD_M1, 0) <= 1.0) {
      if (f0_3(gs_76 + "?email=" + Your_Email + "&info=1&robot=" + gs_dps_96 + "&version=" + gs_88, ls_8)) {
         gs_304 = StringTrimRight(StringTrimLeft(f0_2(ls_8, 0, "<result>", "</result>", li_16)));
         li_20 = f0_1(gs_304, "#");
         if (li_20 > 0) {
            ls_24 = "";
            for (int count_32 = 0; count_32 < li_20 + 1; count_32++) {
               ls_24 = ls_24 
               + "\n  " + f0_5(gs_304, "#", count_32);
            }
            gs_304 = ls_24;
         }
      }
      gi_264 = FALSE;
   }*/
   if (Auto_Risk > 0.0) lots_36 = MathMax(g_minlot_268, MathMin(g_maxlot_228, MathCeil(MathMin(100, Auto_Risk) / 100.0 * AccountFreeMargin() / g_lotstep_236 / (g_lotsize_288 / 100)) * g_lotstep_236));
   if (Auto_Risk == 0.0) lots_36 = Lots;
   if (Auto_GMT) ls_44 = "Auto GMT - ON";
   else ls_44 = "Auto GMT - OFF !!!";
   if (IsTesting()) Calculate_DST = FALSE;
   if (Calculate_DST == TRUE) ls_52 = "YES";
   if (Calculate_DST == FALSE) ls_52 = "NO";
   if (!IsTesting() && !IsOptimization())
   {
   ls_0 = ls_0 
      + "\n ------------------------------------------" 
      + "\n  DYNAMIC PRO SCALPER" 
      + "\n ------------------------------------------" 
      + "\n  A FREE PRODUCT POWERED" 
      + "\n                    BY" 
      + "\n  www.FOREX-MONITOR.com" 
      + "\n ------------------------------------------" 
      + "\n  USE ON M15 CHART" 
      + "\n ------------------------------------------" 
      + "\n  " + ls_44 
      + "\n  Calculate DST - " + ls_52 
      + "\n  Broker GMT = " + gi_296 
      + "\n  Stop Loss = " + Stop_Loss + " pips" 
      + "\n  Take Profit = " + Take_Profit + " pips" 
   + "\n  Spread = " + DoubleToStr((Ask - Bid) / gd_256, 1) + " pips";
   
   if (Ask - Bid > Max_Spread * gd_256) ls_0 = ls_0 + " - HIGH !!!";
   else ls_0 = ls_0 + " - In Norm";
   if (Auto_Risk > 0.0) {
      ls_0 = ls_0 
         + "\n  AutoRisk - Activated" 
      + "\n  Risk = " + DoubleToStr(Auto_Risk, 1) + "%";
   }
   ls_0 = ls_0 
   + "\n  Trading Lots = " + DoubleToStr(lots_36, 2);
   ls_0 = ls_0 
   + "\n  ------------------------------------------";
   ls_0 = ls_0 
   + "\n  REALTIME INFO & MARKET ADVISES:";
   ls_0 = ls_0 
   + "\n  ...";
   ls_0 = ls_0 + gs_304;
   Comment(ls_0);
   }
   if (IsTradeAllowed()) {
      if (IsTradeContextBusy() == FALSE) {
         slippage_60 = Slipage * gd_256;
         slippage_64 = Slipage * gd_256;
         if (Take_Profit < g_stoplevel_292 * Point / gd_256) Take_Profit = g_stoplevel_292 * Point / gd_256;
         if (Stop_Loss < g_stoplevel_292 * Point / gd_256) Stop_Loss = g_stoplevel_292 * Point / gd_256;
         li_68 = Start_Trade_Hour + gi_296;
         li_72 = End_Trade_Hour + gi_296;
         if (li_68 > 23) li_68 -= 24;
         if (li_68 < 0) li_68 += 24;
         if (li_72 > 23) li_72 -= 24;
         if (li_72 < 0) li_72 += 24;
         HideTestIndicators(TRUE);
         ld_76 = iMA(NULL, PERIOD_M15, Channel_Period, 0, MODE_SMA, PRICE_CLOSE, 1) + 2.0 * iStdDev(NULL, PERIOD_M15, Channel_Period, 0, MODE_SMA, PRICE_CLOSE, 1);
         ld_84 = iMA(NULL, PERIOD_M15, Channel_Period, 0, MODE_SMA, PRICE_CLOSE, 1) - 2.0 * iStdDev(NULL, PERIOD_M15, Channel_Period, 0, MODE_SMA, PRICE_CLOSE, 1);
         ima_92 = iMA(NULL, PERIOD_M1, g_period_188, 0, MODE_SMA, PRICE_CLOSE, 1);
         ima_100 = iMA(NULL, PERIOD_M1, g_period_188, 0, MODE_SMA, PRICE_CLOSE, 2);
         HideTestIndicators(FALSE);
         ld_108 = ld_76 - ld_84;
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
                        price_132 = NormalizeDouble(Ask - Stop_Loss * gd_256, Digits);
                        price_140 = NormalizeDouble(Ask + Take_Profit * gd_256, Digits);
                        OrderModify(OrderTicket(), OrderOpenPrice(), price_132, price_140, 0, Green);
                        continue;
                     }
                     if (iVolume(NULL, PERIOD_M1, 0) <= 1.0 && (TimeCurrent() - OrderOpenTime() > 60 * Exit_Minutes && Bid - OrderOpenPrice() > Time_Profit_Pips * gd_256) || (Bid >= ld_76 +
                        Exit_Distance * gd_256 && Bid - OrderOpenPrice() > Exit_Profit_Pips * gd_256) || (ima_92 < ima_100 && Bid - OrderOpenPrice() > Reverse_Profit * gd_256)) {
                        OrderClose(OrderTicket(), OrderLots(), NormalizeDouble(Bid, Digits), slippage_64, Violet);
                        Sleep(5000);
                        continue;
                     }
                     count_120++;
                     continue;
                  }
                  count_124++;
                  if (OrderStopLoss() == 0.0) {
                     price_132 = NormalizeDouble(Bid + Stop_Loss * gd_256, Digits);
                     price_140 = NormalizeDouble(Bid - Take_Profit * gd_256, Digits);
                     OrderModify(OrderTicket(), OrderOpenPrice(), price_132, price_140, 0, Green);
                     continue;
                  }
                  if (iVolume(NULL, PERIOD_M1, 0) <= 1.0 && (TimeCurrent() - OrderOpenTime() > 60 * Exit_Minutes && OrderOpenPrice() - Ask > Time_Profit_Pips * gd_256) || (Bid <= ld_84 - Exit_Distance * gd_256 &&
                     OrderOpenPrice() - Ask > Exit_Profit_Pips * gd_256) || (ima_92 > ima_100 && OrderOpenPrice() - Ask > Reverse_Profit * gd_256)) {
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
            if (((li_68 <= li_72 && TimeHour(TimeCurrent()) >= li_68 && TimeHour(TimeCurrent()) <= li_72) || (li_68 > li_72 && TimeHour(TimeCurrent()) >= li_68 || TimeHour(TimeCurrent()) <= li_72)) &&
               count_120 < 1 && Bid < ld_84 - Entry_Break * gd_256 && ld_108 >= Min_Volatility * gd_256) {
               ls_152 = "BUY";
               cmd_148 = 0;
               color_160 = Aqua;
               RefreshRates();
               price_164 = NormalizeDouble(Ask, Digits);
            }
            if (((li_68 <= li_72 && TimeHour(TimeCurrent()) >= li_68 && TimeHour(TimeCurrent()) <= li_72) || (li_68 > li_72 && TimeHour(TimeCurrent()) >= li_68 || TimeHour(TimeCurrent()) <= li_72)) &&
               count_124 < 1 && Bid > ld_76 + Entry_Break * gd_256 && ld_108 >= Min_Volatility * gd_256) {
               ls_152 = "SELL";
               cmd_148 = 1;
               color_160 = Red;
               RefreshRates();
               price_164 = NormalizeDouble(Bid, Digits);
            }
            if (cmd_148 >= OP_BUY) {
               ticket_116 = OrderSend(Symbol(), cmd_148, lots_36, price_164, slippage_60, 0, 0, "DPScalper", MagicNumber, 0, color_160);
               Sleep(5000);
               if (ticket_116 > 0) {
                  if (OrderSelect(ticket_116, SELECT_BY_TICKET, MODE_TRADES)) Print("Order " + ls_152 + " opened!: ", OrderOpenPrice());
               } else Print("Error opening " + ls_152 + " order!: ", GetLastError());
            }
         }
      }
   }
}

int f0_4() {
   int lia_0[4];
   int lia_4[43];
   GetSystemTime(lia_0);
   int li_8 = lia_0[0] & 65535;
   int li_12 = lia_0[0] >> 16;
   int li_16 = lia_0[1] >> 16;
   int li_20 = lia_0[2] & 65535;
   int li_24 = lia_0[2] >> 16;
   int li_28 = lia_0[3] & 65535;
   string ls_32 = f0_6(li_8, li_12, li_16, li_24, li_24, li_28);
   GetLocalTime(lia_0);
   li_8 = lia_0[0] & 65535;
   li_12 = lia_0[0] >> 16;
   li_16 = lia_0[1] >> 16;
   li_20 = lia_0[2] & 65535;
   li_24 = lia_0[2] >> 16;
   li_28 = lia_0[3] & 65535;
   int li_40 = lia_0[3] >> 16;
   string ls_44 = li_40 + 1000;
   ls_44 = StringSubstr(ls_44, 1);
   ls_32 = f0_6(li_8, li_12, li_16, li_20, li_24, li_28);
   int li_52 = 0;
   int li_56 = GetTimeZoneInformation(lia_4);
   if (li_56 != 0) li_52 = lia_4[0];
   if (li_56 == 2) li_52 += lia_4[42];
   int str2time_60 = StrToTime(ls_32);
   int li_64 = TimeCurrent() - (str2time_60 + 60 * li_52);
   double ld_68 = MathRound(li_64 / 360);
   int li_ret_76 = MathRound(ld_68 / 10.0);
   return (li_ret_76);
}

string f0_6(int ai_0, int ai_4, int ai_8, int ai_12, int ai_16, int ai_20) {
   string ls_24 = ai_4 + 100;
   ls_24 = StringSubstr(ls_24, 1);
   string ls_32 = ai_8 + 100;
   ls_32 = StringSubstr(ls_32, 1);
   string ls_40 = ai_12 + 100;
   ls_40 = StringSubstr(ls_40, 1);
   string ls_48 = ai_16 + 100;
   ls_48 = StringSubstr(ls_48, 1);
   string ls_56 = ai_20 + 100;
   ls_56 = StringSubstr(ls_56, 1);
   return (StringConcatenate(ai_0, ".", ls_24, ".", ls_32, " ", ls_40, ":", ls_48, ":", ls_56));
}

int f0_0(bool ai_0) {
   string ls_4;
   if (gi_312 == 0) {
      ls_4 = "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; Q312461)";
      gi_312 = InternetOpenA(ls_4, gi_320, "0", "0", 0);
      gi_316 = InternetOpenA(ls_4, gi_324, "0", "0", 0);
   }
   if (ai_0) return (gi_316);
   return (gi_312);
}

int f0_3(string as_0, string &as_8) {
   int lia_24[] = {1};
   string ls_28 = "x";
   int li_16 = InternetOpenUrlA(f0_0(0), as_0, "0", 0, -2080374528, 0);
   if (li_16 == 0) return (0);
   int li_20 = InternetReadFile(li_16, ls_28, gi_332, lia_24);
   if (li_20 == 0) return (0);
   int li_36 = lia_24[0];
   for (as_8 = StringSubstr(ls_28, 0, lia_24[0]); lia_24[0] != 0; as_8 = as_8 + StringSubstr(ls_28, 0, lia_24[0])) {
      li_20 = InternetReadFile(li_16, ls_28, gi_332, lia_24);
      if (lia_24[0] == 0) break;
      li_36 += lia_24[0];
   }
   li_20 = InternetCloseHandle(li_16);
   if (li_20 == 0) return (0);
   return (1);
}

string f0_2(string as_0, int ai_8, string as_12, string as_20, int &ai_28) {
   int li_40;
   string ls_ret_32 = "";
   ai_28 = StringFind(as_0, as_12, ai_8);
   if (ai_28 != -1) {
      ai_28 += StringLen(as_12);
      li_40 = StringFind(as_0, as_20, ai_28 + 1);
      ls_ret_32 = StringTrimLeft(StringTrimRight(StringSubstr(as_0, ai_28, li_40 - ai_28)));
   }
   return (ls_ret_32);
}

int f0_1(string as_0, string as_8) {
   string ls_20;
   if (StringLen(as_0) == 0) return (0);
   int count_16 = 0;
   for (int li_28 = 0; li_28 < StringLen(as_0); li_28++) {
      ls_20 = StringSubstr(as_0, li_28, 1);
      if (ls_20 == as_8) count_16++;
   }
   return (count_16);
}

string f0_5(string as_0, string as_8, int ai_16) {
   int count_20 = 0;
   int li_24 = 0;
   int li_28 = StringFind(as_0, as_8, 0);
   while (li_28 >= 0 && count_20 <= ai_16) {
      if (count_20 == ai_16) {
         if (li_28 == li_24) return ("");
         return (StringSubstr(as_0, li_24, li_28 - li_24));
      }
      li_24 = li_28 + StringLen(as_8);
      li_28 = StringFind(as_0, as_8, li_24);
      count_20++;
   }
   if (count_20 == ai_16) return (StringSubstr(as_0, li_24));
   return ("");
}
        
