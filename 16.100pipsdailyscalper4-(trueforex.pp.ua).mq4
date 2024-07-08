//+------------------------------------------------------------------+
//|                    16.100pipsdailyscalper4-(trueforex.pp.ua).mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
/*
   G e n e r a t e d  by ex4-to-mq4 decompiler FREEWARE 4.0.509.5
   Website: ht T p:/ /WW w.mEt aqUoT eS . N eT
   E-mail : S upPo r T @ me tA Q U otEs. n eT
*/

#property indicator_chart_window
#property indicator_buffers 6
#property indicator_color1 DodgerBlue
#property indicator_color2 Red
#property indicator_color3 DodgerBlue
#property indicator_color4 Red
#property indicator_color5 DodgerBlue
#property indicator_color6 Red

extern int Signal = 1;
int Gi_80 = 1;
int G_shift_84 = 989;
extern int SL_pips = 20;
double G_ibuf_92[];
double G_ibuf_96[];
double G_ibuf_100[];
double G_ibuf_104[];
double G_ibuf_108[];
int G_period_112 = 21;
int Gi_116 = 1;
int Gi_120 = 1;
double G_ibuf_124[];
extern bool AlertON = TRUE;
extern bool Email = TRUE;
bool Gi_136 = FALSE;
bool Gi_140 = FALSE;
datetime G_time_144;

void displayAlert(string As_0, double Ad_8, double Ad_16, double Ad_24) {
   string Ls_32;
   string Ls_40;
   string Ls_48;
   string Ls_56;
   string Ls_64;
   if (Time[0] != G_time_144) {
      G_time_144 = Time[0];
      if (Ad_24 != 0.0) Ls_48 = " at price " + DoubleToStr(Ad_24, 4);
      else Ls_48 = "";
      if (Ad_8 != 0.0) Ls_40 = ", TakeProfit on " + DoubleToStr(Ad_8, 4);
      else Ls_40 = "";
      if (Ad_16 != 0.0) Ls_32 = ", StopLoss on " + DoubleToStr(Ad_16, 4);
      else Ls_32 = "";
      Alert("100pipsdailyscalper " + As_0 + Ls_48 + Ls_40 + Ls_32 + " ", Symbol(), ", ", Period(), " minutes chart");
      Ls_56 = "100pipsdailyscalper " + As_0 + Ls_48;
      Ls_64 = "100pipsdailyscalper " + As_0 + Ls_48 + Ls_40 + Ls_32 + " " + Symbol() + ", " + Period() + " minutes chart";
      if (Email) SendMail(Ls_56, Ls_64);
   }
}

int init() {
   SetIndexBuffer(0, G_ibuf_92);
   SetIndexBuffer(1, G_ibuf_96);
   SetIndexBuffer(2, G_ibuf_100);
   SetIndexBuffer(3, G_ibuf_104);
   SetIndexBuffer(4, G_ibuf_108);
   SetIndexBuffer(5, G_ibuf_124);
   SetIndexStyle(0, DRAW_NONE, STYLE_DASHDOT, 1);
   SetIndexStyle(1, DRAW_NONE, STYLE_DASHDOT, 1);
   SetIndexStyle(2, DRAW_ARROW, STYLE_DASHDOT, 1);
   SetIndexStyle(3, DRAW_ARROW, STYLE_DASHDOT, 1);
   SetIndexStyle(4, DRAW_LINE, STYLE_DASHDOT, 1);
   SetIndexStyle(5, DRAW_LINE, STYLE_DASHDOT, 1);
   SetIndexArrow(0, 158);
   SetIndexArrow(1, 158);
   SetIndexArrow(2, 158);
   SetIndexArrow(3, 158);
   IndicatorDigits(MarketInfo(Symbol(), MODE_DIGITS));
   string Ls_0 = "100pipsdailyscalper(" + AlertON + "," + Gi_116 + ")";
   IndicatorShortName(Ls_0);
   SetIndexLabel(0, "");
   SetIndexLabel(1, "");
   SetIndexLabel(2, "");
   SetIndexLabel(3, "");
   SetIndexLabel(4, "");
   SetIndexLabel(5, "");
   SetIndexDrawBegin(0, G_period_112);
   SetIndexDrawBegin(1, G_period_112);
   SetIndexDrawBegin(2, G_period_112);
   SetIndexDrawBegin(3, G_period_112);
   SetIndexDrawBegin(4, G_period_112);
   SetIndexDrawBegin(5, G_period_112);
   return (0);
}

int start() {
   int Li_0;
   double Lda_4[25000];
   double Lda_8[25000];
   double Lda_12[25000];
   double Lda_16[25000];
   double Ld_20;
   double close_28;
   for (int shift_36 = G_shift_84; shift_36 > 0; shift_36--) {
      G_ibuf_92[shift_36] = 0;
      G_ibuf_96[shift_36] = 0;
      G_ibuf_100[shift_36] = 0;
      G_ibuf_104[shift_36] = 0;
      G_ibuf_108[shift_36] = EMPTY_VALUE;
      G_ibuf_124[shift_36] = EMPTY_VALUE;
   }
   for (shift_36 = G_shift_84 - G_period_112 - 1; shift_36 > 0; shift_36--) {
      Lda_4[shift_36] = iBands(NULL, 0, G_period_112, Gi_116, 0, PRICE_CLOSE, MODE_UPPER, shift_36);
      Lda_8[shift_36] = iBands(NULL, 0, G_period_112, Gi_116, 0, PRICE_CLOSE, MODE_LOWER, shift_36);
      if (Close[shift_36] > Lda_4[shift_36 + 1]) Li_0 = 1;
      if (Close[shift_36] < Lda_8[shift_36 + 1]) Li_0 = -1;
      if (Li_0 > 0 && Lda_8[shift_36] < Lda_8[shift_36 + 1]) Lda_8[shift_36] = Lda_8[shift_36 + 1];
      if (Li_0 < 0 && Lda_4[shift_36] > Lda_4[shift_36 + 1]) Lda_4[shift_36] = Lda_4[shift_36 + 1];
      Lda_12[shift_36] = Lda_4[shift_36] + (Gi_120 - 1) / 2.0 * (Lda_4[shift_36] - Lda_8[shift_36]);
      Lda_16[shift_36] = Lda_8[shift_36] - (-0.5 * (Lda_4[shift_36] - Lda_8[shift_36]));
      if (Li_0 > 0 && Lda_16[shift_36] < Lda_16[shift_36 + 1]) Lda_16[shift_36] = Lda_16[shift_36 + 1];
      if (Li_0 < 0 && Lda_12[shift_36] > Lda_12[shift_36 + 1]) Lda_12[shift_36] = Lda_12[shift_36 + 1];
      if (Li_0 > 0) {
         if (Signal > 0 && G_ibuf_92[shift_36 + 1] == -1.0) {
            G_ibuf_100[shift_36] = Lda_16[shift_36];
            G_ibuf_92[shift_36] = Lda_16[shift_36];
            if (Gi_80 > 0) G_ibuf_108[shift_36] = Lda_16[shift_36];
            if (AlertON == TRUE && shift_36 == 1 && (!Gi_136)) {
               Ld_20 = Low[1];
               if (Low[2] < Ld_20) Ld_20 = Low[2];
               if (Low[3] < Ld_20) Ld_20 = Low[3];
               if (Low[4] < Ld_20) Ld_20 = Low[4];
               Ld_20 -= SL_pips * Point;
               close_28 = Close[1];
               displayAlert("Buy signal", 0, Ld_20, close_28);
               Gi_136 = TRUE;
               Gi_140 = FALSE;
            }
         } else {
            G_ibuf_92[shift_36] = Lda_16[shift_36];
            if (Gi_80 > 0) G_ibuf_108[shift_36] = Lda_16[shift_36];
            G_ibuf_100[shift_36] = -1;
         }
         if (Signal == 2) G_ibuf_92[shift_36] = 0;
         G_ibuf_104[shift_36] = -1;
         G_ibuf_96[shift_36] = -1.0;
         G_ibuf_124[shift_36] = EMPTY_VALUE;
      }
      if (Li_0 < 0) {
         if (Signal > 0 && G_ibuf_96[shift_36 + 1] == -1.0) {
            G_ibuf_104[shift_36] = Lda_12[shift_36];
            G_ibuf_96[shift_36] = Lda_12[shift_36];
            if (Gi_80 > 0) G_ibuf_124[shift_36] = Lda_12[shift_36];
            if (AlertON == TRUE && shift_36 == 1 && (!Gi_140)) {
               Ld_20 = High[1];
               if (High[2] > Ld_20) Ld_20 = High[2];
               if (High[3] > Ld_20) Ld_20 = High[3];
               if (High[4] > Ld_20) Ld_20 = High[4];
               Ld_20 += SL_pips * Point;
               close_28 = Close[1];
               displayAlert("Sell signal", 0, Ld_20, close_28);
               Gi_140 = TRUE;
               Gi_136 = FALSE;
            }
         } else {
            G_ibuf_96[shift_36] = Lda_12[shift_36];
            if (Gi_80 > 0) G_ibuf_124[shift_36] = Lda_12[shift_36];
            G_ibuf_104[shift_36] = -1;
         }
         if (Signal == 2) G_ibuf_96[shift_36] = 0;
         G_ibuf_100[shift_36] = -1;
         G_ibuf_92[shift_36] = -1.0;
         G_ibuf_108[shift_36] = EMPTY_VALUE;
      }
   }
   return (0);
}

        
