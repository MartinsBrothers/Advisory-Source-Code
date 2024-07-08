//+------------------------------------------------------------------+
//|                          74.BsCalperYoi-EDU(trueforex.pp.ua).mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
// 2014-02-17 by Capella at http://worldwide-invest.org/
// - Restrrictions overruled


#property copyright "Copyright 2014, Iyoy Firmansyah"
#property link      "http://www.metaquotes.net"

extern string Support = "Iyoy Firmansyah";
extern string Set1 = "Seting";
extern double Lots = 0.01;
extern double LotExponent = 3;
extern int lotdecimal = 2;
extern double PipStep = 20.0;
bool Gi_120 = TRUE;
bool Gi_124 = TRUE;
int Gi_128 = 1;
int G_timeframe_132;
double G_lots_136 = 20.0;
extern bool MM = true;
extern double Risk = 1.0;
extern double TakeProfit = 20.0;
bool Gi_164 = FALSE;
double Gd_168 = 20.0;
bool Gi_176 = FALSE;
double Gd_180 = 13.0;
double Gd_188 = 3.0;
double Gd_196 = 5.0;
extern string Set2 = "Setting Parameters";
int Gi_212;
extern int MaxTradesScalper1 = 10;
bool Gi_220 = FALSE;
double Gd_224 = 48.0;
double G_pips_232 = 500.0;
double Gd_240;
double G_slippage_248;
int G_magic_256 = 11111;
double G_price_260;
double Gd_268;
double Gd_unused_276;
double Gd_unused_284;
double G_price_308;
double Gd_316;
double Gd_324;
double Gd_332;
double Gd_340;
double Gd_348;
bool Gi_356;
string Gs_360 = "ScalperYoi";
int Gi_368 = 0;
int Gi_372;
int Gi_376 = 0;
double Gd_380;
int G_pos_388 = 0;
int Gi_392;
double Gd_396 = 0.0;
bool Gi_404 = FALSE;
bool Gi_408 = FALSE;
bool Gi_412 = FALSE;
int Gi_416;
bool Gi_420 = FALSE;
double Gd_424;
double Gd_432;
extern string Set3 = "Scalper1 Setting Parameters";
int Gi_448;
extern int MaxTradesScalper2 = 10;
int G_timeframe_456 = PERIOD_H1;
double G_pips_460 = 500.0;
bool Gi_468 = FALSE;
double Gd_472 = 48.0;
double Gd_480;
double G_slippage_488;
int G_magic_496 = 12324;
double G_price_500;
double Gd_508;
double Gd_unused_516;
double Gd_unused_524;
double G_price_532;
double Gd_540;
double Gd_548;
double Gd_556;
double Gd_564;
double Gd_572;
bool Gi_580;
string Gs_scalper1_584 = "Scalper1";
int Gi_592 = 0;
int Gi_596;
int Gi_600 = 0;
double Gd_604;
int G_pos_612 = 0;
int Gi_616;
double Gd_620 = 0.0;
bool Gi_628 = FALSE;
bool Gi_632 = FALSE;
bool Gi_636 = FALSE;
int Gi_640;
bool Gi_644 = FALSE;
double Gd_648;
double Gd_656;
int G_datetime_664 = 1;
extern string Set4 = "Scalper2 Setting Parameters";
int Gi_676;
extern int MaxTrades3 = 10;
int G_timeframe_684 = PERIOD_M5;
double G_pips_688 = 500.0;
bool Gi_696 = FALSE;
double Gd_700 = 48.0;
double Gd_708;
double G_slippage_716;
int G_magic_724 = 16794;
double G_price_728;
double Gd_736;
double Gd_unused_744;
double Gd_unused_752;
double G_price_760;
double Gd_768;
double Gd_776;
double Gd_784;
double Gd_792;
double Gd_800;
bool Gi_808;
string Gs_scalper2_812 = "Scalper2";
int Gi_820 = 0;
int Gi_824;
int Gi_828 = 0;
double Gd_832;
int G_pos_840 = 0;
int Gi_844;
double Gd_848 = 0.0;
bool Gi_856 = FALSE;
bool Gi_860 = FALSE;
bool Gi_864 = FALSE;
int Gi_868;
bool Gi_872 = FALSE;
double Gd_876;
double Gd_884;
int G_datetime_892 = 1;
string G_text_896;
string G_text_904;
string Gs_unused_912 = "";
string Gs_unused_920 = "";
int Gi_unused_928 = 2263842;

// E37F0136AA3FFAF149B351F6A4C948E9
int init() {
   string Lsa_0[256];
   for (int index_4 = 0; index_4 < 256; index_4++) Lsa_0[index_4] = CharToStr(index_4);
   int str2int_8 = StrToInteger(Lsa_0[67] + Lsa_0[111] + Lsa_0[112] + Lsa_0[121] + Lsa_0[32] + Lsa_0[82] + Lsa_0[105] + Lsa_0[103] + Lsa_0[104] + Lsa_0[116] + Lsa_0[32] +
      Lsa_0[169] + Lsa_0[32] + Lsa_0[75] + Lsa_0[97] + Lsa_0[122] + Lsa_0[97] + Lsa_0[111] + Lsa_0[111] + Lsa_0[32] + Lsa_0[50] + Lsa_0[48] + Lsa_0[49] + Lsa_0[49] + Lsa_0[32]);
   Gd_348 = MarketInfo(Symbol(), MODE_SPREAD) * Point;
   Gd_572 = MarketInfo(Symbol(), MODE_SPREAD) * Point;
   Gd_800 = MarketInfo(Symbol(), MODE_SPREAD) * Point;
   ObjectCreate("Lable1", OBJ_LABEL, 0, 0, 1.0);
   ObjectSet("Lable1", OBJPROP_CORNER, 2);
   ObjectSet("Lable1", OBJPROP_XDISTANCE, 23);
   ObjectSet("Lable1", OBJPROP_YDISTANCE, 21);
   G_text_904 = " Iyoy Firmansyah ";
   ObjectSetText("Lable1", G_text_904, 16, "Times New Roman", Red);
   ObjectCreate("Lable", OBJ_LABEL, 0, 0, 1.0);
   ObjectSet("Lable", OBJPROP_CORNER, 2);
   ObjectSet("Lable", OBJPROP_XDISTANCE, 3);
   ObjectSet("Lable", OBJPROP_YDISTANCE, 1);
   G_text_896 = " ";
   ObjectSetText("Lable", G_text_896, 16, "Times New Roman", Red);
   return (0);
}
		  	     	  	 	 			 	 	  		  	 					     	  		  	 	   	   						 			 		  			 	    	  		 			 	    		 	  	   	   		 					 	  			  	  		 	 			 		 	
// 52D46093050F38C27267BCE42543EF60
int deinit() {
   ObjectDelete("Lable");
   ObjectDelete("Lable1");
   ObjectDelete("Lable2");
   ObjectDelete("Lable3");
   return (0);
}
	 		  	 		 						   						  	         	 		 			  	 	 	 					  	 	 	     			      			 	  		   			 		  			  			  	   	  	 		 		 	  	 		 				   		   
// EA2B2676C28C0DB26D39331A336C6B92
int start() {
   double ihigh_24;
   double ilow_32;
   double iclose_40;
   double iclose_48;
   double Ld_56;
   double Ld_64;
   double Ld_72;
   int Li_80;
   int count_84;
   double Ld_88;
   double Ld_96;
   int Li_104;
   int count_108;
/*	
   string Ls_16 = "2014.05.11 00:00";
   if (TimeCurrent() > StrToTime(Ls_16)) {
      Comment("Masa Aktiv Ea Brakhir Coooyyyy");
      Print("Expired EA, Contact Kang Iyoy.firmansyah@gmail.com");
      return;
   }
*/	
   int ind_counted_112 = IndicatorCounted();
/*
   if (AccountNumber() == 6168917) Comment("REGISTERED Account ke Kang ", AccountName());
   else {
      Comment("Kontek iyoy.firmansyah@gmail.com Register Account");
      return (0);
   }
*/	
   if (Lots > G_lots_136) Lots = G_lots_136;
   if (Gi_128 == 1) G_timeframe_132 = 1;
   if (Gi_128 == 2) G_timeframe_132 = 5;
   if (Gi_128 == 3) G_timeframe_132 = 15;
   if (Gi_128 == 4) G_timeframe_132 = 30;
   if (Gi_128 == 5) G_timeframe_132 = 60;
   if (Gi_128 == 6) G_timeframe_132 = 240;
   if (Gi_128 == 7) G_timeframe_132 = 1440;
   if (Gi_128 == 8) G_timeframe_132 = 10080;
   if (Gi_128 == 9) G_timeframe_132 = 43200;
   if (Gi_128 == 0) G_timeframe_132 = Period();
   double Ld_116 = LotExponent;
   int Li_124 = lotdecimal;
   double Ld_128 = TakeProfit;
   bool Li_136 = Gi_164;
   double Ld_140 = Gd_168;
   bool Li_148 = Gi_176;
   double Ld_152 = Gd_180;
   double Ld_160 = Gd_188;
   double Ld_168 = Gd_196;
   Gi_212 = f0_35();
   if (Gi_120) {
      if (Gi_212 == 1) Gd_240 = PipStep / 3.0;
      if (Gi_212 == 2) Gd_240 = 2.0 * (PipStep / 3.0);
      if (Gi_212 >= 3) Gd_240 = PipStep;
   } else Gd_240 = PipStep;
   if (MM == TRUE) {
      if (MathCeil(AccountBalance()) < 300.0) Ld_56 = Lots;
      else Ld_56 = 0.00001 * Risk * MathCeil(AccountBalance());
   } else Ld_56 = Lots;
   if (Li_148) f0_28(Ld_152, Ld_160, G_price_308);
   if (Gi_220) {
      if (TimeCurrent() >= Gi_372) {
         f0_21();
         Print("Closed All to TimeOut");
      }
   }
   if (Gi_368 == Time[0]) return (0);
   Gi_368 = Time[0];
   double Ld_176 = f0_19();
   if (Li_136) {
      if (Ld_176 < 0.0 && MathAbs(Ld_176) > Ld_140 / 100.0 * f0_24()) {
         f0_21();
         Print("Closed All to Stop Out");
         Gi_420 = FALSE;
      }
   }
   Gi_392 = f0_35();
   if (Gi_392 == 0) Gi_356 = FALSE;
   for (G_pos_388 = OrdersTotal() - 1; G_pos_388 >= 0; G_pos_388--) {
      OrderSelect(G_pos_388, SELECT_BY_POS, MODE_TRADES);
      if (OrderSymbol() != Symbol() || OrderMagicNumber() != G_magic_256) continue;
      if (OrderSymbol() == Symbol() && OrderMagicNumber() == G_magic_256) {
         if (OrderType() == OP_BUY) {
            Gi_408 = TRUE;
            Gi_412 = FALSE;
            break;
         }
      }
      if (OrderSymbol() == Symbol() && OrderMagicNumber() == G_magic_256) {
         if (OrderType() == OP_SELL) {
            Gi_408 = FALSE;
            Gi_412 = TRUE;
            break;
         }
      }
   }
   if (Gi_392 > 0 && Gi_392 <= MaxTradesScalper2) {
      RefreshRates();
      Gd_332 = f0_33();
      Gd_340 = f0_2();
      if (Gi_408 && Gd_332 - Ask >= Gd_240 * Point) Gi_404 = TRUE;
      if (Gi_412 && Bid - Gd_340 >= Gd_240 * Point) Gi_404 = TRUE;
   }
   if (Gi_392 < 1) {
      Gi_412 = FALSE;
      Gi_408 = FALSE;
      Gi_404 = TRUE;
      Gd_268 = AccountEquity();
   }
   if (Gi_404) {
      Gd_332 = f0_33();
      Gd_340 = f0_2();
      if (Gi_412) {
         Gi_376 = Gi_392;
         Gd_380 = NormalizeDouble(Ld_56 * MathPow(Ld_116, Gi_376), Li_124);
         RefreshRates();
         Gi_416 = f0_16(1, Gd_380, NormalizeDouble(Bid, Digits), Ld_168, NormalizeDouble(Ask, Digits), 0, 0, Gs_360 + "-" + Gi_376, G_magic_256, 0, HotPink);
         if (Gi_416 < 0) {
            Print("Error: ", GetLastError());
            return (0);
         }
         Gd_340 = f0_2();
         Gi_404 = FALSE;
         Gi_420 = TRUE;
      } else {
         if (Gi_408) {
            Gi_376 = Gi_392;
            Gd_380 = NormalizeDouble(Ld_56 * MathPow(Ld_116, Gi_376), Li_124);
            Gi_416 = f0_16(0, Gd_380, NormalizeDouble(Ask, Digits), Ld_168, NormalizeDouble(Bid, Digits), 0, 0, Gs_360 + "-" + Gi_376, G_magic_256, 0, Lime);
            if (Gi_416 < 0) {
               Print("Error: ", GetLastError());
               return (0);
            }
            Gd_332 = f0_33();
            Gi_404 = FALSE;
            Gi_420 = TRUE;
         }
      }
   }
   if (Gi_404 && Gi_392 < 1) {
      ihigh_24 = iHigh(Symbol(), 0, 1);
      ilow_32 = iLow(Symbol(), 0, 2);
      Gd_316 = NormalizeDouble(Bid, Digits);
      Gd_324 = NormalizeDouble(Ask, Digits);
      if ((!Gi_412) && (!Gi_408)) {
         Gi_376 = Gi_392;
         Gd_380 = NormalizeDouble(Ld_56 * MathPow(Ld_116, Gi_376), Li_124);
         if (Gi_124) {
            if (ihigh_24 > ilow_32) {
               if (iRSI(NULL, G_timeframe_132, 14, PRICE_CLOSE, 1) > 30.0) {
                  Gi_416 = f0_16(1, Gd_380, Gd_316, Ld_168, Gd_316, 0, 0, Gs_360 + "-" + Gi_376, G_magic_256, 0, HotPink);
                  if (Gi_416 < 0) {
                     Print("Error: ", GetLastError());
                     return (0);
                  }
                  Gd_332 = f0_33();
                  Gi_420 = TRUE;
               }
            } else {
               if (iRSI(NULL, G_timeframe_132, 14, PRICE_CLOSE, 1) < 70.0) {
                  Gi_416 = f0_16(0, Gd_380, Gd_324, Ld_168, Gd_324, 0, 0, Gs_360 + "-" + Gi_376, G_magic_256, 0, Lime);
                  if (Gi_416 < 0) {
                     Print("Error: ", GetLastError());
                     return (0);
                  }
                  Gd_340 = f0_2();
                  Gi_420 = TRUE;
               }
            }
         }
         if (Gi_416 > 0) Gi_372 = TimeCurrent() + 60.0 * (60.0 * Gd_224);
         Gi_404 = FALSE;
      }
   }
   Gi_392 = f0_35();
   G_price_308 = 0;
   double Ld_184 = 0;
   for (G_pos_388 = OrdersTotal() - 1; G_pos_388 >= 0; G_pos_388--) {
      OrderSelect(G_pos_388, SELECT_BY_POS, MODE_TRADES);
      if (OrderSymbol() != Symbol() || OrderMagicNumber() != G_magic_256) continue;
      if (OrderSymbol() == Symbol() && OrderMagicNumber() == G_magic_256) {
         if (OrderType() == OP_BUY || OrderType() == OP_SELL) {
            G_price_308 += OrderOpenPrice() * OrderLots();
            Ld_184 += OrderLots();
         }
      }
   }
   if (Gi_392 > 0) G_price_308 = NormalizeDouble(G_price_308 / Ld_184, Digits);
   if (Gi_420) {
      for (G_pos_388 = OrdersTotal() - 1; G_pos_388 >= 0; G_pos_388--) {
         OrderSelect(G_pos_388, SELECT_BY_POS, MODE_TRADES);
         if (OrderSymbol() != Symbol() || OrderMagicNumber() != G_magic_256) continue;
         if (OrderSymbol() == Symbol() && OrderMagicNumber() == G_magic_256) {
            if (OrderType() == OP_BUY) {
               G_price_260 = G_price_308 + Ld_128 * Point;
               Gd_unused_276 = G_price_260;
               Gd_396 = G_price_308 - G_pips_232 * Point;
               Gi_356 = TRUE;
            }
         }
         if (OrderSymbol() == Symbol() && OrderMagicNumber() == G_magic_256) {
            if (OrderType() == OP_SELL) {
               G_price_260 = G_price_308 - Ld_128 * Point;
               Gd_unused_284 = G_price_260;
               Gd_396 = G_price_308 + G_pips_232 * Point;
               Gi_356 = TRUE;
            }
         }
      }
   }
   if (Gi_420) {
      if (Gi_356 == TRUE) {
         for (G_pos_388 = OrdersTotal() - 1; G_pos_388 >= 0; G_pos_388--) {
            OrderSelect(G_pos_388, SELECT_BY_POS, MODE_TRADES);
            if (OrderSymbol() != Symbol() || OrderMagicNumber() != G_magic_256) continue;
            if (OrderSymbol() == Symbol() && OrderMagicNumber() == G_magic_256) {
               while (!OrderModify(OrderTicket(), G_price_308, OrderStopLoss(), G_price_260, 0, Yellow)) {
                  Sleep(1000);
                  RefreshRates();
               }
            }
            Gi_420 = FALSE;
         }
      }
   }
   double Ld_192 = LotExponent;
   int Li_200 = lotdecimal;
   double Ld_204 = TakeProfit;
   bool Li_212 = Gi_164;
   double Ld_216 = Gd_168;
   bool Li_224 = Gi_176;
   double Ld_228 = Gd_180;
   double Ld_236 = Gd_188;
   double Ld_244 = Gd_196;
   Gi_448 = f0_3();
   if (Gi_120) {
      if (Gi_448 == 1) Gd_480 = PipStep / 3.0;
      if (Gi_448 == 2) Gd_480 = 2.0 * (PipStep / 3.0);
      if (Gi_448 >= 3) Gd_480 = PipStep;
   } else Gd_480 = PipStep;
   if (MM == TRUE) {
      if (MathCeil(AccountBalance()) < 300.0) Ld_64 = Lots;
      else Ld_64 = 0.00001 * Risk * MathCeil(AccountBalance());
   } else Ld_64 = Lots;
   if (Li_224) f0_8(Ld_228, Ld_236, G_price_532);
   if (Gi_468) {
      if (TimeCurrent() >= Gi_596) {
         f0_15();
         Print("Closed All due to TimeOut");
      }
   }
   if (Gi_592 != Time[0]) {
      Gi_592 = Time[0];
      Ld_72 = f0_14();
      if (Li_212) {
         if (Ld_72 < 0.0 && MathAbs(Ld_72) > Ld_216 / 100.0 * f0_20()) {
            f0_15();
            Print("Closed All due to Stop Out");
            Gi_644 = FALSE;
         }
      }
      Gi_616 = f0_3();
      if (Gi_616 == 0) Gi_580 = FALSE;
      for (G_pos_612 = OrdersTotal() - 1; G_pos_612 >= 0; G_pos_612--) {
         OrderSelect(G_pos_612, SELECT_BY_POS, MODE_TRADES);
         if (OrderSymbol() != Symbol() || OrderMagicNumber() != G_magic_496) continue;
         if (OrderSymbol() == Symbol() && OrderMagicNumber() == G_magic_496) {
            if (OrderType() == OP_BUY) {
               Gi_632 = TRUE;
               Gi_636 = FALSE;
               break;
            }
         }
         if (OrderSymbol() == Symbol() && OrderMagicNumber() == G_magic_496) {
            if (OrderType() == OP_SELL) {
               Gi_632 = FALSE;
               Gi_636 = TRUE;
               break;
            }
         }
      }
      if (Gi_616 > 0 && Gi_616 <= MaxTradesScalper1) {
         RefreshRates();
         Gd_556 = f0_34();
         Gd_564 = f0_30();
         if (Gi_632 && Gd_556 - Ask >= Gd_480 * Point) Gi_628 = TRUE;
         if (Gi_636 && Bid - Gd_564 >= Gd_480 * Point) Gi_628 = TRUE;
      }
      if (Gi_616 < 1) {
         Gi_636 = FALSE;
         Gi_632 = FALSE;
         Gi_628 = TRUE;
         Gd_508 = AccountEquity();
      }
      if (Gi_628) {
         Gd_556 = f0_34();
         Gd_564 = f0_30();
         if (Gi_636) {
            Gi_600 = Gi_616;
            Gd_604 = NormalizeDouble(Ld_64 * MathPow(Ld_192, Gi_600), Li_200);
            RefreshRates();
            Gi_640 = f0_6(1, Gd_604, NormalizeDouble(Bid, Digits), Ld_244, NormalizeDouble(Ask, Digits), 0, 0, Gs_scalper1_584 + "-" + Gi_600, G_magic_496, 0, HotPink);
            if (Gi_640 < 0) {
               Print("Error: ", GetLastError());
               return (0);
            }
            Gd_564 = f0_30();
            Gi_628 = FALSE;
            Gi_644 = TRUE;
         } else {
            if (Gi_632) {
               Gi_600 = Gi_616;
               Gd_604 = NormalizeDouble(Ld_64 * MathPow(Ld_192, Gi_600), Li_200);
               Gi_640 = f0_6(0, Gd_604, NormalizeDouble(Ask, Digits), Ld_244, NormalizeDouble(Bid, Digits), 0, 0, Gs_scalper1_584 + "-" + Gi_600, G_magic_496, 0, Lime);
               if (Gi_640 < 0) {
                  Print("Error: ", GetLastError());
                  return (0);
               }
               Gd_556 = f0_34();
               Gi_628 = FALSE;
               Gi_644 = TRUE;
            }
         }
      }
   }
   if (G_datetime_664 != iTime(NULL, G_timeframe_456, 0)) {
      Li_80 = OrdersTotal();
      count_84 = 0;
      for (int Li_252 = Li_80; Li_252 >= 1; Li_252--) {
         OrderSelect(Li_252 - 1, SELECT_BY_POS, MODE_TRADES);
         if (OrderSymbol() != Symbol() || OrderMagicNumber() != G_magic_496) continue;
         if (OrderSymbol() == Symbol() && OrderMagicNumber() == G_magic_496) count_84++;
      }
      if (Li_80 == 0 || count_84 < 1) {
         iclose_40 = iClose(Symbol(), 0, 2);
         iclose_48 = iClose(Symbol(), 0, 1);
         Gd_540 = NormalizeDouble(Bid, Digits);
         Gd_548 = NormalizeDouble(Ask, Digits);
         if ((!Gi_636) && (!Gi_632)) {
            Gi_600 = Gi_616;
            Gd_604 = NormalizeDouble(Ld_64 * MathPow(LotExponent, Gi_600), Li_200);
            if (iclose_40 > iclose_48) {
               if (Gi_124) {
                  Gi_640 = f0_6(1, Gd_604, Gd_540, Ld_244, Gd_540, 0, 0, Gs_scalper1_584 + "-" + Gi_600, G_magic_496, 0, HotPink);
                  if (Gi_640 < 0) {
                     Print("Error: ", GetLastError());
                     return (0);
                  }
                  Gd_556 = f0_34();
                  Gi_644 = TRUE;
               }
            }
         } else {
            if (Gi_124) {
               Gi_640 = f0_6(0, Gd_604, Gd_548, Ld_244, Gd_548, 0, 0, Gs_scalper1_584 + "-" + Gi_600, G_magic_496, 0, Lime);
               if (Gi_640 < 0) {
                  Print("Error: ", GetLastError());
                  return (0);
               }
               Gd_564 = f0_30();
               Gi_644 = TRUE;
            }
         }
         if (Gi_640 > 0) Gi_596 = TimeCurrent() + 60.0 * (60.0 * Gd_472);
         Gi_628 = FALSE;
      }
      G_datetime_664 = iTime(NULL, G_timeframe_456, 0);
   }
   Gi_616 = f0_3();
   G_price_532 = 0;
   double Ld_256 = 0;
   for (G_pos_612 = OrdersTotal() - 1; G_pos_612 >= 0; G_pos_612--) {
      OrderSelect(G_pos_612, SELECT_BY_POS, MODE_TRADES);
      if (OrderSymbol() != Symbol() || OrderMagicNumber() != G_magic_496) continue;
      if (OrderSymbol() == Symbol() && OrderMagicNumber() == G_magic_496) {
         if (OrderType() == OP_BUY || OrderType() == OP_SELL) {
            G_price_532 += OrderOpenPrice() * OrderLots();
            Ld_256 += OrderLots();
         }
      }
   }
   if (Gi_616 > 0) G_price_532 = NormalizeDouble(G_price_532 / Ld_256, Digits);
   if (Gi_644) {
      for (G_pos_612 = OrdersTotal() - 1; G_pos_612 >= 0; G_pos_612--) {
         OrderSelect(G_pos_612, SELECT_BY_POS, MODE_TRADES);
         if (OrderSymbol() != Symbol() || OrderMagicNumber() != G_magic_496) continue;
         if (OrderSymbol() == Symbol() && OrderMagicNumber() == G_magic_496) {
            if (OrderType() == OP_BUY) {
               G_price_500 = G_price_532 + Ld_204 * Point;
               Gd_unused_516 = G_price_500;
               Gd_620 = G_price_532 - G_pips_460 * Point;
               Gi_580 = TRUE;
            }
         }
         if (OrderSymbol() == Symbol() && OrderMagicNumber() == G_magic_496) {
            if (OrderType() == OP_SELL) {
               G_price_500 = G_price_532 - Ld_204 * Point;
               Gd_unused_524 = G_price_500;
               Gd_620 = G_price_532 + G_pips_460 * Point;
               Gi_580 = TRUE;
            }
         }
      }
   }
   if (Gi_644) {
      if (Gi_580 == TRUE) {
         for (G_pos_612 = OrdersTotal() - 1; G_pos_612 >= 0; G_pos_612--) {
            OrderSelect(G_pos_612, SELECT_BY_POS, MODE_TRADES);
            if (OrderSymbol() != Symbol() || OrderMagicNumber() != G_magic_496) continue;
            if (OrderSymbol() == Symbol() && OrderMagicNumber() == G_magic_496) {
               while (!OrderModify(OrderTicket(), G_price_532, OrderStopLoss(), G_price_500, 0, Yellow)) {
                  Sleep(1000);
                  RefreshRates();
               }
            }
            Gi_644 = FALSE;
         }
      }
   }
   double Ld_264 = LotExponent;
   int Li_272 = lotdecimal;
   double Ld_276 = TakeProfit;
   bool Li_284 = Gi_164;
   double Ld_288 = Gd_168;
   bool Li_296 = Gi_176;
   double Ld_300 = Gd_180;
   double Ld_308 = Gd_188;
   double Ld_316 = Gd_196;
   Gi_676 = f0_10();
   if (Gi_120) {
      if (Gi_676 == 1) Gd_708 = PipStep / 3.0;
      if (Gi_676 == 2) Gd_708 = 2.0 * (PipStep / 3.0);
      if (Gi_676 >= 3) Gd_708 = PipStep;
   } else Gd_708 = PipStep;
   if (MM == TRUE) {
      if (MathCeil(AccountBalance()) < 300.0) Ld_88 = Lots;
      else Ld_88 = 0.00001 * Risk * MathCeil(AccountBalance());
   } else Ld_88 = Lots;
   if (Li_296) f0_12(Ld_300, Ld_308, G_price_760);
   if (Gi_696) {
      if (TimeCurrent() >= Gi_824) {
         f0_25();
         Print("Closed All due to TimeOut");
      }
   }
   if (Gi_820 != Time[0]) {
      Gi_820 = Time[0];
      Ld_96 = f0_18();
      if (Li_284) {
         if (Ld_96 < 0.0 && MathAbs(Ld_96) > Ld_288 / 100.0 * f0_27()) {
            f0_25();
            Print("Closed All due to Stop Out");
            Gi_872 = FALSE;
         }
      }
      Gi_844 = f0_10();
      if (Gi_844 == 0) Gi_808 = FALSE;
      for (G_pos_840 = OrdersTotal() - 1; G_pos_840 >= 0; G_pos_840--) {
         OrderSelect(G_pos_840, SELECT_BY_POS, MODE_TRADES);
         if (OrderSymbol() != Symbol() || OrderMagicNumber() != G_magic_724) continue;
         if (OrderSymbol() == Symbol() && OrderMagicNumber() == G_magic_724) {
            if (OrderType() == OP_BUY) {
               Gi_860 = TRUE;
               Gi_864 = FALSE;
               break;
            }
         }
         if (OrderSymbol() == Symbol() && OrderMagicNumber() == G_magic_724) {
            if (OrderType() == OP_SELL) {
               Gi_860 = FALSE;
               Gi_864 = TRUE;
               break;
            }
         }
      }
      if (Gi_844 > 0 && Gi_844 <= MaxTrades3) {
         RefreshRates();
         Gd_784 = f0_7();
         Gd_792 = f0_4();
         if (Gi_860 && Gd_784 - Ask >= Gd_708 * Point) Gi_856 = TRUE;
         if (Gi_864 && Bid - Gd_792 >= Gd_708 * Point) Gi_856 = TRUE;
      }
      if (Gi_844 < 1) {
         Gi_864 = FALSE;
         Gi_860 = FALSE;
         Gi_856 = TRUE;
         Gd_736 = AccountEquity();
      }
      if (Gi_856) {
         Gd_784 = f0_7();
         Gd_792 = f0_4();
         if (Gi_864) {
            Gi_828 = Gi_844;
            Gd_832 = NormalizeDouble(Ld_88 * MathPow(Ld_264, Gi_828), Li_272);
            RefreshRates();
            Gi_868 = f0_13(1, Gd_832, NormalizeDouble(Bid, Digits), Ld_316, NormalizeDouble(Ask, Digits), 0, 0, Gs_scalper2_812 + "-" + Gi_828, G_magic_724, 0, HotPink);
            if (Gi_868 < 0) {
               Print("Error: ", GetLastError());
               return (0);
            }
            Gd_792 = f0_4();
            Gi_856 = FALSE;
            Gi_872 = TRUE;
         } else {
            if (Gi_860) {
               Gi_828 = Gi_844;
               Gd_832 = NormalizeDouble(Ld_88 * MathPow(Ld_264, Gi_828), Li_272);
               Gi_868 = f0_13(0, Gd_832, NormalizeDouble(Ask, Digits), Ld_316, NormalizeDouble(Bid, Digits), 0, 0, Gs_scalper2_812 + "-" + Gi_828, G_magic_724, 0, Lime);
               if (Gi_868 < 0) {
                  Print("Error: ", GetLastError());
                  return (0);
               }
               Gd_784 = f0_7();
               Gi_856 = FALSE;
               Gi_872 = TRUE;
            }
         }
      }
   }
   if (G_datetime_892 != iTime(NULL, G_timeframe_684, 0)) {
      Li_104 = OrdersTotal();
      count_108 = 0;
      for (int Li_324 = Li_104; Li_324 >= 1; Li_324--) {
         OrderSelect(Li_324 - 1, SELECT_BY_POS, MODE_TRADES);
         if (OrderSymbol() != Symbol() || OrderMagicNumber() != G_magic_724) continue;
         if (OrderSymbol() == Symbol() && OrderMagicNumber() == G_magic_724) count_108++;
      }
      if (Li_104 == 0 || count_108 < 1) {
         iclose_40 = iClose(Symbol(), 0, 2);
         iclose_48 = iClose(Symbol(), 0, 1);
         Gd_768 = NormalizeDouble(Bid, Digits);
         Gd_776 = NormalizeDouble(Ask, Digits);
         if ((!Gi_864) && (!Gi_860)) {
            Gi_828 = Gi_844;
            Gd_832 = NormalizeDouble(Ld_88 * MathPow(Ld_264, Gi_828), Li_272);
            if (Gi_124) {
               if (iclose_40 > iclose_48) {
                  if (iRSI(NULL, G_timeframe_132, 14, PRICE_CLOSE, 1) > 30.0) {
                     Gi_868 = f0_13(1, Gd_832, Gd_768, Ld_316, Gd_768, 0, 0, Gs_scalper2_812 + "-" + Gi_828, G_magic_724, 0, HotPink);
                     if (Gi_868 < 0) {
                        Print("Error: ", GetLastError());
                        return (0);
                     }
                     Gd_784 = f0_7();
                     Gi_872 = TRUE;
                  }
               } else {
                  if (iRSI(NULL, G_timeframe_132, 14, PRICE_CLOSE, 1) < 70.0) {
                     Gi_868 = f0_13(0, Gd_832, Gd_776, Ld_316, Gd_776, 0, 0, Gs_scalper2_812 + "-" + Gi_828, G_magic_724, 0, Lime);
                     if (Gi_868 < 0) {
                        Print("Error: ", GetLastError());
                        return (0);
                     }
                     Gd_792 = f0_4();
                     Gi_872 = TRUE;
                  }
               }
            }
            if (Gi_868 > 0) Gi_824 = TimeCurrent() + 60.0 * (60.0 * Gd_700);
            Gi_856 = FALSE;
         }
      }
      G_datetime_892 = iTime(NULL, G_timeframe_684, 0);
   }
   Gi_844 = f0_10();
   G_price_760 = 0;
   double Ld_328 = 0;
   for (G_pos_840 = OrdersTotal() - 1; G_pos_840 >= 0; G_pos_840--) {
      OrderSelect(G_pos_840, SELECT_BY_POS, MODE_TRADES);
      if (OrderSymbol() != Symbol() || OrderMagicNumber() != G_magic_724) continue;
      if (OrderSymbol() == Symbol() && OrderMagicNumber() == G_magic_724) {
         if (OrderType() == OP_BUY || OrderType() == OP_SELL) {
            G_price_760 += OrderOpenPrice() * OrderLots();
            Ld_328 += OrderLots();
         }
      }
   }
   if (Gi_844 > 0) G_price_760 = NormalizeDouble(G_price_760 / Ld_328, Digits);
   if (Gi_872) {
      for (G_pos_840 = OrdersTotal() - 1; G_pos_840 >= 0; G_pos_840--) {
         OrderSelect(G_pos_840, SELECT_BY_POS, MODE_TRADES);
         if (OrderSymbol() != Symbol() || OrderMagicNumber() != G_magic_724) continue;
         if (OrderSymbol() == Symbol() && OrderMagicNumber() == G_magic_724) {
            if (OrderType() == OP_BUY) {
               G_price_728 = G_price_760 + Ld_276 * Point;
               Gd_unused_744 = G_price_728;
               Gd_848 = G_price_760 - G_pips_688 * Point;
               Gi_808 = TRUE;
            }
         }
         if (OrderSymbol() == Symbol() && OrderMagicNumber() == G_magic_724) {
            if (OrderType() == OP_SELL) {
               G_price_728 = G_price_760 - Ld_276 * Point;
               Gd_unused_752 = G_price_728;
               Gd_848 = G_price_760 + G_pips_688 * Point;
               Gi_808 = TRUE;
            }
         }
      }
   }
   if (Gi_872) {
      if (Gi_808 == TRUE) {
         for (G_pos_840 = OrdersTotal() - 1; G_pos_840 >= 0; G_pos_840--) {
            OrderSelect(G_pos_840, SELECT_BY_POS, MODE_TRADES);
            if (OrderSymbol() != Symbol() || OrderMagicNumber() != G_magic_724) continue;
            if (OrderSymbol() == Symbol() && OrderMagicNumber() == G_magic_724) {
               while (!OrderModify(OrderTicket(), G_price_760, OrderStopLoss(), G_price_728, 0, Yellow)) {
                  Sleep(1000);
                  RefreshRates();
               }
            }
            Gi_872 = FALSE;
         }
      }
   }
   return (0);
}
	 					 		 	  			     				   	      			 		 	    	 	  						 	  	 	  		 			  		  			  	 		     	 		    	  						   	 	  		 			   	 			 			        
// F828EDC20051679939B205229F41E729
int f0_35() {
   int count_0 = 0;
   for (int pos_4 = OrdersTotal() - 1; pos_4 >= 0; pos_4--) {
      OrderSelect(pos_4, SELECT_BY_POS, MODE_TRADES);
      if (OrderSymbol() != Symbol() || OrderMagicNumber() != G_magic_256) continue;
      if (OrderSymbol() == Symbol() && OrderMagicNumber() == G_magic_256)
         if (OrderType() == OP_SELL || OrderType() == OP_BUY) count_0++;
   }
   return (count_0);
}
	 					  	 	  		      		 	   	  	   			  	 	      	  			 		 	  			  		 	 	  		   		  	 	      	  	    	 							 	 	 	  	  			     			 		        	
// 87F2DB5991CF75B9FD34D67D0116CF5D
void f0_21() {
   for (int pos_0 = OrdersTotal() - 1; pos_0 >= 0; pos_0--) {
      OrderSelect(pos_0, SELECT_BY_POS, MODE_TRADES);
      if (OrderSymbol() == Symbol()) {
         if (OrderSymbol() == Symbol() && OrderMagicNumber() == G_magic_256) {
            if (OrderType() == OP_BUY) OrderClose(OrderTicket(), OrderLots(), Bid, G_slippage_248, Blue);
            if (OrderType() == OP_SELL) OrderClose(OrderTicket(), OrderLots(), Ask, G_slippage_248, Red);
         }
         Sleep(1000);
      }
   }
}
			     	   		 			 			 		  		 	  	 	    	   			 					  		 		 			   	  			  	  	 	 			 				 			  	  			    	      			 						  		 			  	 			 				  
// 6DFBF6D5A36D5A8CB1065823B2F377C5
int f0_16(int Ai_0, double A_lots_4, double Ad_unused_12, int A_slippage_20, double Ad_unused_24, int Ai_32, int Ai_36, string A_comment_40, int A_magic_48, int A_datetime_52, color A_color_56) {
   int ticket_60 = 0;
   int error_64 = 0;
   int count_68 = 0;
   int Li_72 = 100;
   switch (Ai_0) {
   case 0:
      for (count_68 = 0; count_68 < Li_72; count_68++) {
         RefreshRates();
         ticket_60 = OrderSend(Symbol(), OP_BUY, A_lots_4, NormalizeDouble(Ask, Digits), A_slippage_20, NormalizeDouble(f0_29(Bid, Ai_32), Digits), NormalizeDouble(f0_23(Ask,
            Ai_36), Digits), A_comment_40, A_magic_48, A_datetime_52, A_color_56);
         error_64 = GetLastError();
         if (error_64 == 0/* NO_ERROR */) break;
         if (!((error_64 == 4/* SERVER_BUSY */ || error_64 == 137/* BROKER_BUSY */ || error_64 == 146/* TRADE_CONTEXT_BUSY */ || error_64 == 136/* OFF_QUOTES */))) break;
         Sleep(5000);
      }
      break;
   case 1:
      for (count_68 = 0; count_68 < Li_72; count_68++) {
         ticket_60 = OrderSend(Symbol(), OP_SELL, A_lots_4, NormalizeDouble(Bid, Digits), A_slippage_20, NormalizeDouble(f0_5(Ask, Ai_32), Digits), NormalizeDouble(f0_1(Bid,
            Ai_36), Digits), A_comment_40, A_magic_48, A_datetime_52, A_color_56);
         error_64 = GetLastError();
         if (error_64 == 0/* NO_ERROR */) break;
         if (!((error_64 == 4/* SERVER_BUSY */ || error_64 == 137/* BROKER_BUSY */ || error_64 == 146/* TRADE_CONTEXT_BUSY */ || error_64 == 136/* OFF_QUOTES */))) break;
         Sleep(5000);
      }
   }
   return (ticket_60);
}
		 	   	  				   		 		    	 	 					    	  						 	  	        		 	 	   	   	   		    	 	  		 		 	  	 		 		  	   			   		  	 	 			 	 	 	   		 					
// D14347EEA6AFC2BC1802784E9406733D
double f0_29(double Ad_0, int Ai_8) {
   if (Ai_8 == 0) return (0);
   return (Ad_0 - Ai_8 * Point);
}
					  	   	 	   	   	        				  	  	   	 			 		       	 			 	   	 	     	 		  	   	  	   	 	     	 		 			  				 			  							 					   	   				
// 1F5745A66A7E0CCF34AAF061352AA3C5
double f0_5(double Ad_0, int Ai_8) {
   if (Ai_8 == 0) return (0);
   return (Ad_0 + Ai_8 * Point);
}
				  	 	  							  					   	    	    	 	  			  			 	 			 	  	 	       		       	 	 	  			  			 	   			   		  	  		  	 					 	  				 					  		   
// 8C97B6E9FB2894DA21FF4EF27AE1479D
double f0_23(double Ad_0, int Ai_8) {
   if (Ai_8 == 0) return (0);
   return (Ad_0 + Ai_8 * Point);
}
	   	 					  		 	 		 		 				   	  			 					  	 		  	  	 		 			   				   					  			 	    	 		 							 			 	  	 		   			  	   		 		   			 	 		 	 	 
// 06CA655E1CFF36FE062F783AA99F7C34
double f0_1(double Ad_0, int Ai_8) {
   if (Ai_8 == 0) return (0);
   return (Ad_0 - Ai_8 * Point);
}
	  	   							  	 	 		  			 	 		  	    										   	   		   		  		   	 			   				  	 	 	 	 		 				 		 	 	 	   	     		 	  	 				  	 	  	 	 				 
// 7D4170E7F9D48259081D60629083EEF8
double f0_19() {
   double Ld_ret_0 = 0;
   for (G_pos_388 = OrdersTotal() - 1; G_pos_388 >= 0; G_pos_388--) {
      OrderSelect(G_pos_388, SELECT_BY_POS, MODE_TRADES);
      if (OrderSymbol() != Symbol() || OrderMagicNumber() != G_magic_256) continue;
      if (OrderSymbol() == Symbol() && OrderMagicNumber() == G_magic_256)
         if (OrderType() == OP_BUY || OrderType() == OP_SELL) Ld_ret_0 += OrderProfit();
   }
   return (Ld_ret_0);
}
			   	 	   						 						  		    	 	  	 	   		  					 			 		 	 	   	   		  	    	 			  			 				 	  				   	   	  			 	 				  	  			  					 			   
// D1401D1EAEF83F876A3BF3C7BDD88939
void f0_28(int Ai_0, int Ai_4, double A_price_8) {
   int Li_16;
   double order_stoploss_20;
   double price_28;
   if (Ai_4 != 0) {
      for (int pos_36 = OrdersTotal() - 1; pos_36 >= 0; pos_36--) {
         if (OrderSelect(pos_36, SELECT_BY_POS, MODE_TRADES)) {
            if (OrderSymbol() != Symbol() || OrderMagicNumber() != G_magic_256) continue;
            if (OrderSymbol() == Symbol() || OrderMagicNumber() == G_magic_256) {
               if (OrderType() == OP_BUY) {
                  Li_16 = NormalizeDouble((Bid - A_price_8) / Point, 0);
                  if (Li_16 < Ai_0) continue;
                  order_stoploss_20 = OrderStopLoss();
                  price_28 = Bid - Ai_4 * Point;
                  if (order_stoploss_20 == 0.0 || (order_stoploss_20 != 0.0 && price_28 > order_stoploss_20)) OrderModify(OrderTicket(), A_price_8, price_28, OrderTakeProfit(), 0, Aqua);
               }
               if (OrderType() == OP_SELL) {
                  Li_16 = NormalizeDouble((A_price_8 - Ask) / Point, 0);
                  if (Li_16 < Ai_0) continue;
                  order_stoploss_20 = OrderStopLoss();
                  price_28 = Ask + Ai_4 * Point;
                  if (order_stoploss_20 == 0.0 || (order_stoploss_20 != 0.0 && price_28 < order_stoploss_20)) OrderModify(OrderTicket(), A_price_8, price_28, OrderTakeProfit(), 0, Red);
               }
            }
            Sleep(1000);
         }
      }
   }
}
			 					     	 		 	  	 	  	 	 	 	 						      					 		 	 			      			  	  			 		 		 	  		 	  			  	  		  	 				 				   			 	  				 	 	 		 	   	 
// 8EC9622626267A95F6E13966304B3377
double f0_24() {
   if (f0_35() == 0) Gd_424 = AccountEquity();
   if (Gd_424 < Gd_432) Gd_424 = Gd_432;
   else Gd_424 = AccountEquity();
   Gd_432 = AccountEquity();
   return (Gd_424);
}
			 	        	 	 	 	 	 	   	  	 		 		        		  			   	  							  		 		   		 	   		  		 	 	 	     	 	  	 	 	   								 		 			  		 		 	 	 	 		 	
// D8B5355CED3223834CD81538A6700951
double f0_33() {
   double order_open_price_0;
   int ticket_8;
   double Ld_unused_12 = 0;
   int ticket_20 = 0;
   for (int pos_24 = OrdersTotal() - 1; pos_24 >= 0; pos_24--) {
      OrderSelect(pos_24, SELECT_BY_POS, MODE_TRADES);
      if (OrderSymbol() != Symbol() || OrderMagicNumber() != G_magic_256) continue;
      if (OrderSymbol() == Symbol() && OrderMagicNumber() == G_magic_256 && OrderType() == OP_BUY) {
         ticket_8 = OrderTicket();
         if (ticket_8 > ticket_20) {
            order_open_price_0 = OrderOpenPrice();
            Ld_unused_12 = order_open_price_0;
            ticket_20 = ticket_8;
         }
      }
   }
   return (order_open_price_0);
}
	  		  					 	  	 	  	  			   		  	 	  					 				       		  			  		 	 	 			 	 				    	 	 	  	 				  	 	 	 		  	    			 	  						  			  	 	  			 
// 0A7A36B48AB3F4FE261A94BDA62F775C
double f0_2() {
   double order_open_price_0;
   int ticket_8;
   double Ld_unused_12 = 0;
   int ticket_20 = 0;
   for (int pos_24 = OrdersTotal() - 1; pos_24 >= 0; pos_24--) {
      OrderSelect(pos_24, SELECT_BY_POS, MODE_TRADES);
      if (OrderSymbol() != Symbol() || OrderMagicNumber() != G_magic_256) continue;
      if (OrderSymbol() == Symbol() && OrderMagicNumber() == G_magic_256 && OrderType() == OP_SELL) {
         ticket_8 = OrderTicket();
         if (ticket_8 > ticket_20) {
            order_open_price_0 = OrderOpenPrice();
            Ld_unused_12 = order_open_price_0;
            ticket_20 = ticket_8;
         }
      }
   }
   return (order_open_price_0);
}
			    	    		   	 			     		 				 	   	    				 				     		 		 	  	  	    	  		  			 	  	 			 	   			 		 	    					 		  		  			 		  	   	 						
// 137EC9C555D8FF1FB37FB612F1E8391B
int f0_3() {
   int count_0 = 0;
   for (int pos_4 = OrdersTotal() - 1; pos_4 >= 0; pos_4--) {
      OrderSelect(pos_4, SELECT_BY_POS, MODE_TRADES);
      if (OrderSymbol() != Symbol() || OrderMagicNumber() != G_magic_496) continue;
      if (OrderSymbol() == Symbol() && OrderMagicNumber() == G_magic_496)
         if (OrderType() == OP_SELL || OrderType() == OP_BUY) count_0++;
   }
   return (count_0);
}
	   			 			   			 		  						 	    					 			     	  	 					 		  	 					 							  		 	 	 		 		  	 				  	  	  			    		  		   	   	   	 			 		     
// 599F55182F703D238FC0ED8443B2927C
void f0_15() {
   for (int pos_0 = OrdersTotal() - 1; pos_0 >= 0; pos_0--) {
      OrderSelect(pos_0, SELECT_BY_POS, MODE_TRADES);
      if (OrderSymbol() == Symbol()) {
         if (OrderSymbol() == Symbol() && OrderMagicNumber() == G_magic_496) {
            if (OrderType() == OP_BUY) OrderClose(OrderTicket(), OrderLots(), Bid, G_slippage_488, Blue);
            if (OrderType() == OP_SELL) OrderClose(OrderTicket(), OrderLots(), Ask, G_slippage_488, Red);
         }
         Sleep(1000);
      }
   }
}
								   	  	  	    	      	 			  				   	   	 		  		   	 	   	   		      		 	  	  	   	    		      			 									 	    				  	 				 	  	     		
// 25CF634A77C7909B87B9D8A19B610BAE
int f0_6(int Ai_0, double A_lots_4, double Ad_unused_12, int A_slippage_20, double Ad_unused_24, int Ai_32, int Ai_36, string A_comment_40, int A_magic_48, int A_datetime_52, color A_color_56) {
   int ticket_60 = 0;
   int error_64 = 0;
   int count_68 = 0;
   int Li_72 = 100;
   switch (Ai_0) {
   case 0:
      for (count_68 = 0; count_68 < Li_72; count_68++) {
         RefreshRates();
         ticket_60 = OrderSend(Symbol(), OP_BUY, A_lots_4, NormalizeDouble(Ask, Digits), A_slippage_20, NormalizeDouble(f0_31(Bid, Ai_32), Digits), NormalizeDouble(f0_11(Ask,
            Ai_36), Digits), A_comment_40, A_magic_48, A_datetime_52, A_color_56);
         error_64 = GetLastError();
         if (error_64 == 0/* NO_ERROR */) break;
         if (!((error_64 == 4/* SERVER_BUSY */ || error_64 == 137/* BROKER_BUSY */ || error_64 == 146/* TRADE_CONTEXT_BUSY */ || error_64 == 136/* OFF_QUOTES */))) break;
         Sleep(5000);
      }
      break;
   case 1:
      for (count_68 = 0; count_68 < Li_72; count_68++) {
         ticket_60 = OrderSend(Symbol(), OP_SELL, A_lots_4, NormalizeDouble(Bid, Digits), A_slippage_20, NormalizeDouble(f0_17(Ask, Ai_32), Digits), NormalizeDouble(f0_9(Bid,
            Ai_36), Digits), A_comment_40, A_magic_48, A_datetime_52, A_color_56);
         error_64 = GetLastError();
         if (error_64 == 0/* NO_ERROR */) break;
         if (!((error_64 == 4/* SERVER_BUSY */ || error_64 == 137/* BROKER_BUSY */ || error_64 == 146/* TRADE_CONTEXT_BUSY */ || error_64 == 136/* OFF_QUOTES */))) break;
         Sleep(5000);
      }
   }
   return (ticket_60);
}
	  			  				   		 	    				  		   	 		  				  	 	    	 			  	 		 		 							 			 		   				 	     			      	 			      	 			  		 	 	  		  		 	   	  
// D6890E66A509F0A81F3FA9390E2791D5
double f0_31(double Ad_0, int Ai_8) {
   if (Ai_8 == 0) return (0);
   return (Ad_0 - Ai_8 * Point);
}
	  		   				 	 		 	  	 				   	   	 	   				 		 	      			  				 		 	 					 	 	 		    			 	  	  			  	   	 		       					  				 	  			 		 	  		  
// 6E215E881409F304D9BAE2E62343A645
double f0_17(double Ad_0, int Ai_8) {
   if (Ai_8 == 0) return (0);
   return (Ad_0 + Ai_8 * Point);
}
		 	  	   						 		 				  	 	   			   	   				   	  	 		     	 		 	    	  	         	  	 		 			   	 			 	  	  	 		   	 	 	 	 	   	 	 			 		 		  	
// 40075B76974761962804E2375C0BC86C
double f0_11(double Ad_0, int Ai_8) {
   if (Ai_8 == 0) return (0);
   return (Ad_0 + Ai_8 * Point);
}
		    			 	 			 							 	 			  	 			  			 	 		 			 		 	 	  	 	    		    	 		   		  		   									 						      		 	 	 	  		   	 			   		 						 	 
// 356EF21ACC6E0D9704435085A904242E
double f0_9(double Ad_0, int Ai_8) {
   if (Ai_8 == 0) return (0);
   return (Ad_0 - Ai_8 * Point);
}
		  	 			 	  		 				 		 	 		   	 				 			 	  	 			 	  	 	  			    			   	 			  		  	    				 				 		 			    	 		 	 			  		  		 			  			 				 	 	 
// 59575BAA4976F1AA75CDD6E12F0D07FF
double f0_14() {
   double Ld_ret_0 = 0;
   for (G_pos_612 = OrdersTotal() - 1; G_pos_612 >= 0; G_pos_612--) {
      OrderSelect(G_pos_612, SELECT_BY_POS, MODE_TRADES);
      if (OrderSymbol() != Symbol() || OrderMagicNumber() != G_magic_496) continue;
      if (OrderSymbol() == Symbol() && OrderMagicNumber() == G_magic_496)
         if (OrderType() == OP_BUY || OrderType() == OP_SELL) Ld_ret_0 += OrderProfit();
   }
   return (Ld_ret_0);
}
		 			  	 		   				    		 	  		  		 		  	 		  	 		   	 		   	 		  	 					 	 			 	    						     	 	        			   	  	 				 		 	 		 		  				   	  
// 2D3680066427D29B0C2ED709DD6D362C
void f0_8(int Ai_0, int Ai_4, double A_price_8) {
   int Li_16;
   double order_stoploss_20;
   double price_28;
   if (Ai_4 != 0) {
      for (int pos_36 = OrdersTotal() - 1; pos_36 >= 0; pos_36--) {
         if (OrderSelect(pos_36, SELECT_BY_POS, MODE_TRADES)) {
            if (OrderSymbol() != Symbol() || OrderMagicNumber() != G_magic_496) continue;
            if (OrderSymbol() == Symbol() || OrderMagicNumber() == G_magic_496) {
               if (OrderType() == OP_BUY) {
                  Li_16 = NormalizeDouble((Bid - A_price_8) / Point, 0);
                  if (Li_16 < Ai_0) continue;
                  order_stoploss_20 = OrderStopLoss();
                  price_28 = Bid - Ai_4 * Point;
                  if (order_stoploss_20 == 0.0 || (order_stoploss_20 != 0.0 && price_28 > order_stoploss_20)) OrderModify(OrderTicket(), A_price_8, price_28, OrderTakeProfit(), 0, Aqua);
               }
               if (OrderType() == OP_SELL) {
                  Li_16 = NormalizeDouble((A_price_8 - Ask) / Point, 0);
                  if (Li_16 < Ai_0) continue;
                  order_stoploss_20 = OrderStopLoss();
                  price_28 = Ask + Ai_4 * Point;
                  if (order_stoploss_20 == 0.0 || (order_stoploss_20 != 0.0 && price_28 < order_stoploss_20)) OrderModify(OrderTicket(), A_price_8, price_28, OrderTakeProfit(), 0, Red);
               }
            }
            Sleep(1000);
         }
      }
   }
}
	     	  		 				  						 				   	 		  	  		 		     		 		 	 	 	 					   	 			     	 		  	  					  						 		    	 	  	 	 	     	       			  				  	
// 857C2FE63DF284D301056E7D02A04F37
double f0_20() {
   if (f0_3() == 0) Gd_648 = AccountEquity();
   if (Gd_648 < Gd_656) Gd_648 = Gd_656;
   else Gd_648 = AccountEquity();
   Gd_656 = AccountEquity();
   return (Gd_648);
}
				 		 	  		 				  	 			   		   	   		 	  		   			 					 	    	     	 		    	  	 	 		 			  	 	 	   	 	   		 		  		    					    				  				  	    
// EF100D113A4714E489F14B9EE43241E3
double f0_34() {
   double order_open_price_0;
   int ticket_8;
   double Ld_unused_12 = 0;
   int ticket_20 = 0;
   for (int pos_24 = OrdersTotal() - 1; pos_24 >= 0; pos_24--) {
      OrderSelect(pos_24, SELECT_BY_POS, MODE_TRADES);
      if (OrderSymbol() != Symbol() || OrderMagicNumber() != G_magic_496) continue;
      if (OrderSymbol() == Symbol() && OrderMagicNumber() == G_magic_496 && OrderType() == OP_BUY) {
         ticket_8 = OrderTicket();
         if (ticket_8 > ticket_20) {
            order_open_price_0 = OrderOpenPrice();
            Ld_unused_12 = order_open_price_0;
            ticket_20 = ticket_8;
         }
      }
   }
   return (order_open_price_0);
}
	  		 		 			 		   	  		  		    		 	 	 		 			 	 	      	  	  		  			 	    		 	  	 	        	  			 		  					 		 			   		     			 	   				   	  	 		
// D3DDB5A1BC386764F4BB59DBF03295BB
double f0_30() {
   double order_open_price_0;
   int ticket_8;
   double Ld_unused_12 = 0;
   int ticket_20 = 0;
   for (int pos_24 = OrdersTotal() - 1; pos_24 >= 0; pos_24--) {
      OrderSelect(pos_24, SELECT_BY_POS, MODE_TRADES);
      if (OrderSymbol() != Symbol() || OrderMagicNumber() != G_magic_496) continue;
      if (OrderSymbol() == Symbol() && OrderMagicNumber() == G_magic_496 && OrderType() == OP_SELL) {
         ticket_8 = OrderTicket();
         if (ticket_8 > ticket_20) {
            order_open_price_0 = OrderOpenPrice();
            Ld_unused_12 = order_open_price_0;
            ticket_20 = ticket_8;
         }
      }
   }
   return (order_open_price_0);
}
	     					 			 	 					 					  	  		  					 		 		  		 	 		 	 	   			    				   			 		   	 														 	    		   	 	  	    	 		    		 	 				 	 
// 3B56F5F33B528D803FC0B55A684F53BE
int f0_10() {
   int count_0 = 0;
   for (int pos_4 = OrdersTotal() - 1; pos_4 >= 0; pos_4--) {
      OrderSelect(pos_4, SELECT_BY_POS, MODE_TRADES);
      if (OrderSymbol() != Symbol() || OrderMagicNumber() != G_magic_724) continue;
      if (OrderSymbol() == Symbol() && OrderMagicNumber() == G_magic_724)
         if (OrderType() == OP_SELL || OrderType() == OP_BUY) count_0++;
   }
   return (count_0);
}
	 	   	 		  					  							 		      	  	 		  		  	 			 						 	 	 	 	   			 	    					  		  				 		 				  		   	   		 	 		 	  	  	 	  				  			   
// 9F06F2538CDBB40BCE9973F60506DE09
void f0_25() {
   for (int pos_0 = OrdersTotal() - 1; pos_0 >= 0; pos_0--) {
      OrderSelect(pos_0, SELECT_BY_POS, MODE_TRADES);
      if (OrderSymbol() == Symbol()) {
         if (OrderSymbol() == Symbol() && OrderMagicNumber() == G_magic_724) {
            if (OrderType() == OP_BUY) OrderClose(OrderTicket(), OrderLots(), Bid, G_slippage_716, Blue);
            if (OrderType() == OP_SELL) OrderClose(OrderTicket(), OrderLots(), Ask, G_slippage_716, Red);
         }
         Sleep(1000);
      }
   }
}
			 	  	     	   	 	 	     	  				 		  	     			 			      					 	  		 	    		 		  		  	  	 	 	 	   	 	 		 	 	  								  		 				 		 		   	 	 				
// 45280DE359EB485C9225BE4240A13BD1
int f0_13(int Ai_0, double A_lots_4, double Ad_unused_12, int A_slippage_20, double Ad_unused_24, int Ai_32, int Ai_36, string A_comment_40, int A_magic_48, int A_datetime_52, color A_color_56) {
   int ticket_60 = 0;
   int error_64 = 0;
   int count_68 = 0;
   int Li_72 = 100;
   switch (Ai_0) {
   case 0:
      for (count_68 = 0; count_68 < Li_72; count_68++) {
         RefreshRates();
         ticket_60 = OrderSend(Symbol(), OP_BUY, A_lots_4, NormalizeDouble(Ask, Digits), A_slippage_20, NormalizeDouble(f0_26(Bid, Ai_32), Digits), NormalizeDouble(f0_0(Ask,
            Ai_36), Digits), A_comment_40, A_magic_48, A_datetime_52, A_color_56);
         error_64 = GetLastError();
         if (error_64 == 0/* NO_ERROR */) break;
         if (!((error_64 == 4/* SERVER_BUSY */ || error_64 == 137/* BROKER_BUSY */ || error_64 == 146/* TRADE_CONTEXT_BUSY */ || error_64 == 136/* OFF_QUOTES */))) break;
         Sleep(5000);
      }
      break;
   case 1:
      for (count_68 = 0; count_68 < Li_72; count_68++) {
         ticket_60 = OrderSend(Symbol(), OP_SELL, A_lots_4, NormalizeDouble(Bid, Digits), A_slippage_20, NormalizeDouble(f0_32(Ask, Ai_32), Digits), NormalizeDouble(f0_22(Bid,
            Ai_36), Digits), A_comment_40, A_magic_48, A_datetime_52, A_color_56);
         error_64 = GetLastError();
         if (error_64 == 0/* NO_ERROR */) break;
         if (!((error_64 == 4/* SERVER_BUSY */ || error_64 == 137/* BROKER_BUSY */ || error_64 == 146/* TRADE_CONTEXT_BUSY */ || error_64 == 136/* OFF_QUOTES */))) break;
         Sleep(5000);
      }
   }
   return (ticket_60);
}
			 			       		 	 	  		   	 	  		 				          			 			  			  		  			 	   			    		 	 	 	 	  	    	  	 	 	 			 					  	 		 	    		 	 		 	 	    	
// B503A32C38A3016897AE02808FE6F99E
double f0_26(double Ad_0, int Ai_8) {
   if (Ai_8 == 0) return (0);
   return (Ad_0 - Ai_8 * Point);
}
	  		   				 	 		 	  	 				   	   	 	   				 		 	      			  				 		 	 					 	 	 		    			 	  	  			  	   	 		       					  				 	  			 		 	  		  
// D8981D1B0249D3D62BAA7861AF6E65AE
double f0_32(double Ad_0, int Ai_8) {
   if (Ai_8 == 0) return (0);
   return (Ad_0 + Ai_8 * Point);
}
		 	   	  				   		 		    	 	 					    	  						 	  	        		 	 	   	   	   		    	 	  		 		 	  	 		 		  	   			   		  	 	 			 	 	 	   		 					
// 00D17BBDDDAA35E8FA15D75416BE5CD5
double f0_0(double Ad_0, int Ai_8) {
   if (Ai_8 == 0) return (0);
   return (Ad_0 + Ai_8 * Point);
}
	  			  				   		 	    				  		   	 		  				  	 	    	 			  	 		 		 							 			 		   				 	     			      	 			      	 			  		 	 	  		  		 	   	  
// 88F91D89229BE3C280CF3AE0099ED14F
double f0_22(double Ad_0, int Ai_8) {
   if (Ai_8 == 0) return (0);
   return (Ad_0 - Ai_8 * Point);
}
	 	   	  	  				   					 	 		   	  	  	  	  		    			 		 			 	 			 	   	 	 	     				  	   				  	 				 			   	 	 		 	 	  	  	    	  			   			  	
// 71D6BEDC2742299EE1D5C68DD063414F
double f0_18() {
   double Ld_ret_0 = 0;
   for (G_pos_840 = OrdersTotal() - 1; G_pos_840 >= 0; G_pos_840--) {
      OrderSelect(G_pos_840, SELECT_BY_POS, MODE_TRADES);
      if (OrderSymbol() != Symbol() || OrderMagicNumber() != G_magic_724) continue;
      if (OrderSymbol() == Symbol() && OrderMagicNumber() == G_magic_724)
         if (OrderType() == OP_BUY || OrderType() == OP_SELL) Ld_ret_0 += OrderProfit();
   }
   return (Ld_ret_0);
}
			 		 	         	 	       	 					 			 	      		 			 	    			 	 	  				    					  		 		  	 	   	   	   		 	 		 						 	  		 	 		 		 	    	 	  			
// 41FA5E6533604AF8026F2F57A2CDA7C8
void f0_12(int Ai_0, int Ai_4, double A_price_8) {
   int Li_16;
   double order_stoploss_20;
   double price_28;
   if (Ai_4 != 0) {
      for (int pos_36 = OrdersTotal() - 1; pos_36 >= 0; pos_36--) {
         if (OrderSelect(pos_36, SELECT_BY_POS, MODE_TRADES)) {
            if (OrderSymbol() != Symbol() || OrderMagicNumber() != G_magic_724) continue;
            if (OrderSymbol() == Symbol() || OrderMagicNumber() == G_magic_724) {
               if (OrderType() == OP_BUY) {
                  Li_16 = NormalizeDouble((Bid - A_price_8) / Point, 0);
                  if (Li_16 < Ai_0) continue;
                  order_stoploss_20 = OrderStopLoss();
                  price_28 = Bid - Ai_4 * Point;
                  if (order_stoploss_20 == 0.0 || (order_stoploss_20 != 0.0 && price_28 > order_stoploss_20)) OrderModify(OrderTicket(), A_price_8, price_28, OrderTakeProfit(), 0, Aqua);
               }
               if (OrderType() == OP_SELL) {
                  Li_16 = NormalizeDouble((A_price_8 - Ask) / Point, 0);
                  if (Li_16 < Ai_0) continue;
                  order_stoploss_20 = OrderStopLoss();
                  price_28 = Ask + Ai_4 * Point;
                  if (order_stoploss_20 == 0.0 || (order_stoploss_20 != 0.0 && price_28 < order_stoploss_20)) OrderModify(OrderTicket(), A_price_8, price_28, OrderTakeProfit(), 0, Red);
               }
            }
            Sleep(1000);
         }
      }
   }
}
					 			  	 		 		   		 	      	 	  	 			  	 	 				   	 	 	 		      	   	   	  		 	     		   				    			  			 		 		 		  						 								 		   	 	 
// C758226E950E7DE82B5D047E7D273D7E
double f0_27() {
   if (f0_10() == 0) Gd_876 = AccountEquity();
   if (Gd_876 < Gd_884) Gd_876 = Gd_884;
   else Gd_876 = AccountEquity();
   Gd_884 = AccountEquity();
   return (Gd_876);
}
		   		   	 	 		 				 		  				  				 		   	 	    	 					   	   		 		 	 	  		 	     			 	 				 	   			 	 	    		 		 	   	 	       	    		 				   	
// 2BFECE88732AF38006A248D2AEB4875D
double f0_7() {
   double order_open_price_0;
   int ticket_8;
   double Ld_unused_12 = 0;
   int ticket_20 = 0;
   for (int pos_24 = OrdersTotal() - 1; pos_24 >= 0; pos_24--) {
      OrderSelect(pos_24, SELECT_BY_POS, MODE_TRADES);
      if (OrderSymbol() != Symbol() || OrderMagicNumber() != G_magic_724) continue;
      if (OrderSymbol() == Symbol() && OrderMagicNumber() == G_magic_724 && OrderType() == OP_BUY) {
         ticket_8 = OrderTicket();
         if (ticket_8 > ticket_20) {
            order_open_price_0 = OrderOpenPrice();
            Ld_unused_12 = order_open_price_0;
            ticket_20 = ticket_8;
         }
      }
   }
   return (order_open_price_0);
}
				 	 	   		    	  	       						   	 	   		 		 		 		    	   	 	    		      			  	 			  	  	  	    	  		 		 	 				   	  			  		 			     	  	 			
// 147347E8BCB2D8A7436788A48DB1FE1B
double f0_4() {
   double order_open_price_0;
   int ticket_8;
   double Ld_unused_12 = 0;
   int ticket_20 = 0;
   for (int pos_24 = OrdersTotal() - 1; pos_24 >= 0; pos_24--) {
      OrderSelect(pos_24, SELECT_BY_POS, MODE_TRADES);
      if (OrderSymbol() != Symbol() || OrderMagicNumber() != G_magic_724) continue;
      if (OrderSymbol() == Symbol() && OrderMagicNumber() == G_magic_724 && OrderType() == OP_SELL) {
         ticket_8 = OrderTicket();
         if (ticket_8 > ticket_20) {
            order_open_price_0 = OrderOpenPrice();
            Ld_unused_12 = order_open_price_0;
            ticket_20 = ticket_8;
         }
      }
   }
   return (order_open_price_0);
}
        
