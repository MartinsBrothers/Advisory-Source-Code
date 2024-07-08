//+------------------------------------------------------------------+
//|          113.Dukascopy2FXT_RangeBarsMod_edu(trueforex.pp.ua).mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

#property copyright "birt [RangeBars MOD by NiX]"
#property link      "http://eareview.net/"
#property show_inputs

#import "RangeBars2.dll"
   int initDLL(int a0, int a1, string a2);
   string getDLLVer();
   int updateT1(int a0, int a1);
   int processHistoryBar4Range(double a0, double& a1[], double& a2[], double& a3[], int a4);
#import "kernel32.dll"
   int SetFileAttributesA(string a0, int a1);
#import

int gi_unused_76 = 0;
double gd_80 = 0.0;
double gd_88 = 0.0;
double gd_96 = 0.0;
double gd_104 = 0.0;
double gd_112 = 0.0;
string gs_120 = "";
bool gi_128 = FALSE;
double gd_132 = 0.0;
int gi_140 = 0;
double gd_144 = 0.0;
int gi_152 = 405;
string gs_156 = "(C)opyright 2005-2007, MetaQuotes Software Corp.";
string gs_164;
string gs_172;
int gi_180;
int gi_184 = 0;
int gi_188 = 0;
int gi_192 = 0;
int gi_196 = 0;
double gd_200 = 99.0;
string gs_208;
int g_spread_216;
int g_digits_220;
double g_point_224;
int gi_232;
int gi_236;
int gi_240;
int g_stoplevel_244;
bool gi_248 = FALSE;
double g_lotsize_252;
double g_tickvalue_260;
double g_ticksize_268;
int g_profitcalcmode_276 = 0;
bool gi_280 = TRUE;
int g_swaptype_284 = 0;
double g_swaplong_288;
double g_swapshort_296;
int gi_304 = 3;
int gi_308 = 100;
int gi_312 = 1;
int g_margincalcmode_316 = 0;
int gi_320 = 30;
int gi_324 = 0;
double g_margininit_328 = 0.0;
double g_marginmaintenance_336 = 0.0;
double g_marginhedged_344 = 0.0;
double gd_352 = 1.0;
string gs_360;
double gd_368 = 0.0;
int gi_376 = 1;
int gi_380 = 0;
int gi_384 = 0;
int gi_388 = 0;
int gia_392[6];
int gi_396 = 0;
int gi_400 = 0;
int g_freezelevel_404 = 0;
int gia_408[61];
extern string CsvFile = "";
bool gi_420 = TRUE;
extern double PipRange = 10.0;
extern string ValueInfo = "All spreads & commissions are in pips regardless of the number of digits.";
extern double Spread = 0.0;
extern string DateInfo1 = "Use YYYY.MM.DD as date format for start/end date.";
extern string DateInfo2 = "Leave the fields empty to use the whole CSV file.";
extern string StartDate = "";
extern string EndDate = "";
extern string RealSpreadInfo1 = "The real spread will only work if you enable the patch option.";
extern bool UseRealSpread = FALSE;
extern double SpreadPadding = 0.0;
extern double PipsCommission = 0.0;
extern int Leverage = 100;
extern string GMTOffsetInfo1 = "Specify the target GMT Offset.";
extern int GMTOffset = 0;
extern string DSTInfo1 = "0 - no DST, 1 - US DST, 2 - Europe DST";
extern int DST = 0;
bool gi_536 = FALSE;
string gs_540 = ",";
int gi_548 = 1;
int gi_552;
int g_file_556;
int g_str2time_560 = 0;
int g_str2time_564 = 0;
int g_count_568;
int gi_572;
int g_file_576 = -1;
int g_file_580 = -1;
string g_name_584;
int gi_592;
int gi_596;
int gi_unused_600;
double gd_604;
double gd_612;
double gd_620;
double gd_628;
double gd_636;
double gd_644;
int gi_unused_652 = 0;
int gi_656 = 0;
int gi_660 = 0;
int g_year_664 = 0;
bool gi_668 = TRUE;
int g_minute_672 = -1;
double gd_676 = 0.0;
double gd_684 = 0.0;
bool gi_692 = TRUE;

string getKey() {
   //int l_file_0 = FileOpen("RangeBar.key", FILE_BIN|FILE_READ);
   //if (l_file_0 < 0) return (gs_120);
   string ls_ret_4 = "supadupa"; //FileReadString(l_file_0, 1024);
   //if (l_file_0 >= 0) FileClose(l_file_0);
   return (ls_ret_4);
}

void memoryBar(double ad_0, double ad_8, double ad_16, double ad_24, double ad_32) {
   gd_80 = ad_0;
   gd_88 = ad_8;
   gd_96 = ad_16;
   gd_104 = ad_24;
   gd_112 = ad_32;
}

void memoryBarClear() {
   gd_80 = 0;
   gd_88 = 0;
   gd_96 = 0;
   gd_104 = 0;
   gd_112 = 0;
}

void WriteHeader(int a_file_0, string as_4, int ai_12, int ai_16, int ai_20, double ad_24 = 0.0, int ai_32 = 100) {
   gs_164 = AccountServer();
   gd_368 = ad_24;
   gi_308 = ai_32;
   gs_172 = as_4;
   gi_180 = ai_12;
   gi_188 = 0;
   gs_208 = StringSubstr(gs_172, 0, 3);
   if (ai_20 > 0) g_spread_216 = ai_20;
   else g_spread_216 = MarketInfo(gs_172, MODE_SPREAD);
   g_digits_220 = Digits;
   g_point_224 = Point;
   gi_232 = 100.0 * MarketInfo(gs_172, MODE_MINLOT);
   gi_236 = 100.0 * MarketInfo(gs_172, MODE_MAXLOT);
   gi_240 = 100.0 * MarketInfo(gs_172, MODE_LOTSTEP);
   g_stoplevel_244 = MarketInfo(gs_172, MODE_STOPLEVEL);
   g_lotsize_252 = MarketInfo(gs_172, MODE_LOTSIZE);
   g_tickvalue_260 = MarketInfo(gs_172, MODE_TICKVALUE);
   g_ticksize_268 = MarketInfo(gs_172, MODE_TICKSIZE);
   g_profitcalcmode_276 = MarketInfo(gs_172, MODE_PROFITCALCMODE);
   g_swaptype_284 = MarketInfo(gs_172, MODE_SWAPTYPE);
   g_swaplong_288 = MarketInfo(gs_172, MODE_SWAPLONG);
   g_swapshort_296 = MarketInfo(gs_172, MODE_SWAPSHORT);
   gi_312 = AccountFreeMarginMode();
   g_margincalcmode_316 = MarketInfo(gs_172, MODE_MARGINCALCMODE);
   gi_320 = AccountStopoutLevel();
   gi_324 = AccountStopoutMode();
   g_margininit_328 = MarketInfo(gs_172, MODE_MARGININIT);
   g_marginmaintenance_336 = MarketInfo(gs_172, MODE_MARGINMAINTENANCE);
   g_marginhedged_344 = MarketInfo(gs_172, MODE_MARGINHEDGED);
   gs_360 = AccountCurrency();
   gi_384 = ai_16;
   gia_392[0] = ai_16;
   g_freezelevel_404 = MarketInfo(gs_172, MODE_FREEZELEVEL);
   FileWriteInteger(a_file_0, gi_152, LONG_VALUE);
   FileWriteString(a_file_0, gs_156, 64);
   FileWriteString(a_file_0, gs_164, 128);
   FileWriteString(a_file_0, gs_172, 12);
   FileWriteInteger(a_file_0, gi_180, LONG_VALUE);
   FileWriteInteger(a_file_0, gi_184, LONG_VALUE);
   FileWriteInteger(a_file_0, gi_188, LONG_VALUE);
   FileWriteInteger(a_file_0, gi_192, LONG_VALUE);
   FileWriteInteger(a_file_0, gi_196, LONG_VALUE);
   FileWriteInteger(a_file_0, 0, LONG_VALUE);
   FileWriteDouble(a_file_0, gd_200, DOUBLE_VALUE);
   FileWriteString(a_file_0, gs_208, 12);
   FileWriteInteger(a_file_0, g_spread_216, LONG_VALUE);
   FileWriteInteger(a_file_0, g_digits_220, LONG_VALUE);
   FileWriteInteger(a_file_0, 0, LONG_VALUE);
   FileWriteDouble(a_file_0, g_point_224, DOUBLE_VALUE);
   FileWriteInteger(a_file_0, gi_232, LONG_VALUE);
   FileWriteInteger(a_file_0, gi_236, LONG_VALUE);
   FileWriteInteger(a_file_0, gi_240, LONG_VALUE);
   FileWriteInteger(a_file_0, g_stoplevel_244, LONG_VALUE);
   FileWriteInteger(a_file_0, gi_248, LONG_VALUE);
   FileWriteInteger(a_file_0, 0, LONG_VALUE);
   FileWriteDouble(a_file_0, g_lotsize_252, DOUBLE_VALUE);
   FileWriteDouble(a_file_0, g_tickvalue_260, DOUBLE_VALUE);
   FileWriteDouble(a_file_0, g_ticksize_268, DOUBLE_VALUE);
   FileWriteInteger(a_file_0, g_profitcalcmode_276, LONG_VALUE);
   FileWriteInteger(a_file_0, gi_280, LONG_VALUE);
   FileWriteInteger(a_file_0, g_swaptype_284, LONG_VALUE);
   FileWriteInteger(a_file_0, 0, LONG_VALUE);
   FileWriteDouble(a_file_0, g_swaplong_288, DOUBLE_VALUE);
   FileWriteDouble(a_file_0, g_swapshort_296, DOUBLE_VALUE);
   FileWriteInteger(a_file_0, gi_304, LONG_VALUE);
   FileWriteInteger(a_file_0, gi_308, LONG_VALUE);
   FileWriteInteger(a_file_0, gi_312, LONG_VALUE);
   FileWriteInteger(a_file_0, g_margincalcmode_316, LONG_VALUE);
   FileWriteInteger(a_file_0, gi_320, LONG_VALUE);
   FileWriteInteger(a_file_0, gi_324, LONG_VALUE);
   FileWriteDouble(a_file_0, g_margininit_328, DOUBLE_VALUE);
   FileWriteDouble(a_file_0, g_marginmaintenance_336, DOUBLE_VALUE);
   FileWriteDouble(a_file_0, g_marginhedged_344, DOUBLE_VALUE);
   FileWriteDouble(a_file_0, gd_352, DOUBLE_VALUE);
   FileWriteString(a_file_0, gs_360, 12);
   FileWriteInteger(a_file_0, 0, LONG_VALUE);
   FileWriteDouble(a_file_0, gd_368, DOUBLE_VALUE);
   FileWriteInteger(a_file_0, gi_376, LONG_VALUE);
   FileWriteInteger(a_file_0, gi_380, LONG_VALUE);
   FileWriteInteger(a_file_0, gi_384, LONG_VALUE);
   FileWriteInteger(a_file_0, gi_388, LONG_VALUE);
   FileWriteArray(a_file_0, gia_392, 0, 6);
   FileWriteInteger(a_file_0, gi_396, LONG_VALUE);
   FileWriteInteger(a_file_0, gi_400, LONG_VALUE);
   FileWriteInteger(a_file_0, g_freezelevel_404, LONG_VALUE);
   FileWriteArray(a_file_0, gia_408, 0, 61);
}

int init() {
   string ls_4;
   gs_120 = getKey();
   if (gs_120 == "") {
      gi_128 = TRUE;
      Alert("Please run the RangeBarsUnlock script first.\nIt is located in your Navigator window (Scripts branch)");
      Comment("Dukascopy2FXT_RangeBarsMod script has been DISABLED.\nPlease REMOVE the script from this chart and unlock first.\nRangeBars Plug-In can be downloaded from http://www.the-forex-strategy.com");
      return (0);
   }
   if (Period() != PERIOD_M1) {
      Alert("Please apply the script to an M1 chart! Exiting.");
      gi_128 = TRUE;
      return (-1);
   }
   int li_ret_0 = initDLL(0, WindowHandle(Symbol(), Period()), gs_120);
   if (li_ret_0 == 1) {
      ls_4 = getDLLVer();
      if (ls_4 == "20110620.1") Alert("RangeBar Plug-in [" + getDLLVer() + "] OK, processing...");
      else {
         Alert("RangeBar Plug-in error: Incorrect DLL Version!");
         gi_128 = TRUE;
         return (-1);
      }
   }
   gi_128 = FALSE;
   memoryBarClear();
   return (li_ret_0);
}

int start() {
   int li_4;
   double ld_8;
   double ld_16;
   if (gi_128) return (0);
   for (int l_count_0 = 0; l_count_0 < 5; l_count_0++) {
      if (IsConnected()) break;
      Sleep(3000);
   }
   if (!IsConnected()) {
      Alert("This script requires a connection to the broker.");
      return;
   }
   if (Digits % 2 == 1) {
      Spread = 10.0 * Spread;
      SpreadPadding = 10.0 * SpreadPadding;
      PipRange = 10.0 * PipRange;
   } else {
      Spread = NormalizeDouble(Spread, 0);
      SpreadPadding = NormalizeDouble(SpreadPadding, 0);
   }
   if (UseRealSpread) gi_536 = FALSE;
   if (digits2ticksize() != MarketInfo(Symbol(), MODE_TICKSIZE)) PipRange /= MarketInfo(Symbol(), MODE_TICKSIZE);
   gd_144 = NormalizeDouble(PipRange * Point, Digits);
   if (CsvFile == "") CsvFile = StringSubstr(Symbol(), 0, 6) + ".csv";
   if (StringLen(StartDate) > 0) g_str2time_560 = StrToTime(StartDate);
   if (StringLen(EndDate) > 0) g_str2time_564 = StrToTime(EndDate);
   int li_24 = 59;
   g_count_568 = 0;
   gi_592 = 0;
   if (StringLen(gs_540) > 0) li_24 = StringGetChar(gs_540, 0);
   if (li_24 == ' ') li_24 = 59;
   if (li_24 == '\') li_24 = 9;
   g_file_576 = FileOpen(CsvFile, FILE_CSV|FILE_READ, li_24);
   if (g_file_576 < 0) {
      Alert("Can\'t open input file");
      return (-1);
   }
   g_name_584 = Symbol() + Period() + "_0.fxt";
   g_file_580 = FileOpen(g_name_584, FILE_BIN|FILE_WRITE);
   if (g_file_580 < 0) return (-1);
   gi_552 = 60 * gi_548;
   gi_596 = 0;
   gi_572 = 0;
   if (Digits % 2 == 1) PipsCommission = 10.0 * PipsCommission;
   WriteHeader(g_file_580, Symbol(), Period(), 0, Spread, PipsCommission, Leverage);
   if (gi_420) WriteHstHeaders();
   while (!IsStopped()) {
      if (!(ReadNextTick(li_4, ld_8, ld_16))) break;
      if (TimeYear(li_4) != g_year_664) {
         g_year_664 = TimeYear(li_4);
         Print("Starting to process " + Symbol() + " " + g_year_664 + ".");
      }
      if (gi_668) {
         gi_596 = li_4;
         gi_unused_600 = gi_596;
         gi_668 = FALSE;
      }
      gd_132 += ld_16;
      processRangeBar(li_4, ld_8, ld_8, ld_8, ld_8, gd_132, 1);
      if (g_str2time_560 > 0 && li_4 < g_str2time_560) continue;
      if (g_str2time_564 > 0 && li_4 >= g_str2time_564) {
         if (!(gi_420)) break;
         continue;
      }
      if (gi_656 == 0) gi_656 = li_4;
      gi_660 = li_4;
      WriteTick();
   }
   if (g_file_556 > 0) FileClose(g_file_556);
   FileClose(g_file_576);
   FileFlush(g_file_580);
   FileSeek(g_file_580, 216, SEEK_SET);
   FileWriteInteger(g_file_580, gi_572, LONG_VALUE);
   FileWriteInteger(g_file_580, gi_656, LONG_VALUE);
   FileWriteInteger(g_file_580, gi_660, LONG_VALUE);
   FileClose(g_file_580);
   Print(g_count_568, " ticks added. ", gi_572, " bars finalized in the header");
   Alert("Processing for " + Symbol() + " has finished.");
   SetFileAttributesA("experts/files/" + g_name_584, 1);
   return (0);
}

bool ReadNextTick(int &ai_0, double &ad_4, double &ad_12) {
   string ls_20;
   double ld_28;
   ad_12 = 0;
   while (!IsStopped()) {
      ls_20 = FileReadString(g_file_576);
      if (FileIsEnding(g_file_576)) return (FALSE);
      ai_0 = StrToTime(ls_20) + 3600 * GMTOffset;
      ai_0 += DSTOffset(ai_0);
      ad_4 = NormalizeDouble(FileReadNumber(g_file_576), Digits);
      ld_28 = NormalizeDouble(FileReadNumber(g_file_576), Digits);
      if (UseRealSpread) gd_644 = ld_28 - ad_4 + SpreadPadding * Point;
      ad_12 += MathAbs(FileReadNumber(g_file_576) / 100000.0);
      ad_12 += MathAbs(FileReadNumber(g_file_576) / 100000.0);
      if (ad_12 <= 0.0) ad_12 = 1;
      if (!gi_536) ad_12 = 1;
      if (FileIsEnding(g_file_576)) return (FALSE);
      if (TimeMinute(ai_0) == g_minute_672 && ld_28 == gd_684 && ad_4 == gd_676) continue;
      g_minute_672 = TimeMinute(ai_0);
      gd_684 = ld_28;
      gd_676 = ad_4;
      if (ai_0 >= gi_592) break;
   }
   gi_592 = ai_0;
   return (TRUE);
}

void WriteTick() {
   FileWriteInteger(g_file_580, gi_596, LONG_VALUE);
   FileWriteDouble(g_file_580, gd_604, DOUBLE_VALUE);
   FileWriteDouble(g_file_580, gd_612, DOUBLE_VALUE);
   FileWriteDouble(g_file_580, gd_620, DOUBLE_VALUE);
   FileWriteDouble(g_file_580, gd_628, DOUBLE_VALUE);
   if (UseRealSpread) FileWriteDouble(g_file_580, gd_644, DOUBLE_VALUE);
   else FileWriteDouble(g_file_580, gd_636, DOUBLE_VALUE);
   FileWriteInteger(g_file_580, gi_592, LONG_VALUE);
   FileWriteInteger(g_file_580, 4, LONG_VALUE);
   g_count_568++;
}

void WriteHstHeaders() {
   int lia_28[15];
   int li_0 = 400;
   string ls_12 = Symbol();
   int li_20 = gi_548;
   int l_digits_24 = Digits;
   g_file_556 = FileOpen(ls_12 + li_20 + ".hst", FILE_BIN|FILE_WRITE);
   if (g_file_556 < 0) Print("Error opening " + ls_12 + li_20);
   string ls_4 = "(C)opyright 2003, MetaQuotes Software Corp.";
   FileWriteInteger(g_file_556, li_0, LONG_VALUE);
   FileWriteString(g_file_556, ls_4, 64);
   FileWriteString(g_file_556, ls_12, 12);
   FileWriteInteger(g_file_556, li_20, LONG_VALUE);
   FileWriteInteger(g_file_556, l_digits_24, LONG_VALUE);
   FileWriteArray(g_file_556, lia_28, 0, 15);
}

int DSTOffset(int ai_0) {
   if (isDST(ai_0, DST)) return (3600);
   return (0);
}

bool isDST(int ai_0, int ai_4 = 0) {
   int l_count_16;
   if (ai_4 == 2) {
      for (int li_8 = StrToTime(TimeYear(ai_0) + ".03.31 01:00"); TimeDayOfWeek(li_8) != 0; li_8 -= 86400) {
      }
      for (int li_12 = StrToTime(TimeYear(ai_0) + ".10.31 01:00"); TimeDayOfWeek(li_12) != 0; li_12 -= 86400) {
      }
      if (ai_0 >= li_8 && ai_0 < li_12) return (TRUE);
      return (FALSE);
   }
   if (ai_4 == 1) {
      li_8 = StrToTime(TimeYear(ai_0) + ".03.01 00:00");
      l_count_16 = 0;
      while (true) {
         if (TimeDayOfWeek(li_8) == 0) {
            l_count_16++;
            if (l_count_16 == 2) break;
         }
         li_8 += 86400;
      }
      for (li_12 = StrToTime(TimeYear(ai_0) + ".11.01 00:00"); TimeDayOfWeek(li_12) != 0; li_12 += 86400) {
      }
      if (ai_0 >= li_8 && ai_0 < li_12) return (TRUE);
      return (FALSE);
   }
   return (FALSE);
}

int processRangeBar(int ai_0, double ad_4, double ad_12, double ad_20, double ad_28, double ad_36, int ai_44) {
   double lda_48[5] = {0, 0, 0, 0, 0};
   double lda_52[5] = {0, 0, 0, 0, 0};
   double lda_56[5] = {0, 0, 0, 0, 0};
   lda_52[0] = ad_4;
   lda_52[1] = ad_12;
   lda_52[2] = ad_20;
   lda_52[3] = ad_28;
   lda_52[4] = ad_36;
   lda_56[0] = gd_80;
   lda_56[1] = gd_88;
   lda_56[2] = gd_96;
   lda_56[3] = gd_104;
   lda_56[4] = gd_112;
   int li_60 = processHistoryBar4Range(gd_144, lda_52, lda_56, lda_48, ai_44);
   while (true) {
      if (!((li_60 >= 1 && li_60 <= 4) || (li_60 >= 6 && li_60 <= 9))) break;
      writeHistory(ai_0, lda_48[0], lda_48[1], lda_48[2], lda_48[3], lda_48[4], 0);
      memoryBar(lda_56[0], lda_56[1], lda_56[2], lda_56[3], lda_56[4]);
      writeHistory(ai_0, lda_56[0], lda_56[1], lda_56[2], lda_56[3], lda_56[4], 1);
      gd_604 = ad_4;
      gd_612 = ad_4;
      gd_620 = ad_4;
      gd_628 = ad_4;
      if (ad_36 > 0.0) gd_636 = ad_36;
      else gd_636 = 1;
      gi_572++;
      lda_52[0] = gd_80;
      lda_52[1] = gd_88;
      lda_52[2] = gd_96;
      lda_52[3] = gd_104;
      lda_52[4] = 1;
      li_60 = processHistoryBar4Range(gd_144, lda_52, lda_56, lda_48, 0);
   }
   if (li_60 == 5 || li_60 == 10) {
      memoryBar(lda_56[0], lda_56[1], lda_56[2], lda_56[3], lda_56[4]);
      if (gi_692) {
         gi_596 = ai_0;
         gd_604 = ad_4;
         gd_612 = ad_4;
         gd_620 = ad_4;
         gd_628 = ad_4;
         if (ad_36 > 0.0) gd_636 = ad_36;
         else gd_636 = 1;
         gi_572++;
         writeHistory(ai_0, lda_56[0], lda_56[1], lda_56[2], lda_56[3], lda_56[4], 1);
         gi_692 = FALSE;
      } else {
         if (gd_612 > ad_4) gd_612 = ad_4;
         if (gd_620 < ad_4) gd_620 = ad_4;
         gd_628 = ad_4;
         gd_636 += ad_36;
      }
      gd_132 = lda_56[4];
      return (1);
   }
   if (li_60 == 100 || li_60 == 101) {
      memoryBarClear();
      return (0);
   }
   return (1);
}

void writeHistory(int ai_0, double ad_4, double ad_12, double ad_20, double ad_28, double ad_36, int ai_44) {
   int li_48;
   if (g_file_580 >= 0) {
      if (ai_44 == 1) {
         li_48 = updateT1(ai_0, gi_140);
         FileSeek(g_file_556, 0, SEEK_END);
         FileWriteInteger(g_file_556, li_48, LONG_VALUE);
         gi_596 = li_48;
         gi_140 = li_48;
      } else FileSeek(g_file_556, -40, SEEK_END);
      if (ad_36 == 0.0) ad_36++;
      FileWriteDouble(g_file_556, ad_4, DOUBLE_VALUE);
      FileWriteDouble(g_file_556, ad_12, DOUBLE_VALUE);
      FileWriteDouble(g_file_556, ad_20, DOUBLE_VALUE);
      FileWriteDouble(g_file_556, ad_28, DOUBLE_VALUE);
      FileWriteDouble(g_file_556, ad_36, DOUBLE_VALUE);
   }
}

double digits2ticksize() {
   double lda_0[6] = {1, 10, 100, 1000, 10000, 100000};
   if (Digits > 0) return (0.1 / (lda_0[Digits - 1]));
   if (Digits == 0) return (1);
   return (0.0);
}
        
