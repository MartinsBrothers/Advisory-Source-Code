//+------------------------------------------------------------------+
//|                               45.ASSAR V8 decomp by sharkfxo.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                        was decompiled by sharkfxo|
//|                                                                  |
//|           http://forum.worldwide-invest.org/member-sharkfxo.html |
//+------------------------------------------------------------------+


//#include <stdlib.mqh>
#import "stdlib.ex4"
   string ErrorDescription(int a0); 
#import

extern string Contact = "www.fxmillionea.com";
extern string Important1 = "Use default setting with leverage 1:500!";
extern string Important2 = "Use on any time frame. But do NOT move between time frames.";
extern string Currency = "Any currency pair.";
extern bool mm = TRUE;
extern double risk = 1;
extern double default_lot = 0.01;
extern double MaxSpread = 4.0;
extern double StopLoss = 20.0;
extern double TakeProfit = 5.0;
extern double TrailingStart = 1.0;


int Zi_396;
int Zi_400;
int Zi_404;
int Zi_408;
int Zi_412;
int Zi_416;
int Zi_420;
int Zi_424;
int Z_count_428 = 0;
int Zi_432 = 0;
double Zda_436[30];
double Z_lots_440;
double Zd_448;
double Zd_456;
double Zd_464;
double Zd_472;
double Z_lotstep_480;
double Z_marginrequired_488;
double Zd_496 = 0.0;
bool ECN_Mode = FALSE;
bool Debug = FALSE;
bool Verbose = FALSE;
int MaxExecution = 0;
int MaxExecutionMinutes = 1;
double AddPriceGap = 0.0;
double Commission = 0.0;
int Slippage = 3;
double MinimumUseStopLevel = 10.0;
double VolatilityMultiplier = 125.0;
double VolatilityLimit = 325.0;
bool UseVolatilityPercentage = TRUE;
int f;
double VolatilityPercentageLimit = 125.0;
int UseIndicatorSwitch = 3;
double BBDeviation = 1.5;
string COMMENT = "";
bool AUTOMM;
double EnvelopesDeviation = 0.07;
int OrderExpireSeconds = 3600;
double MinLots = 0.01;
double MaxLots = 100.0;
bool TakeShots = FALSE;
int DelayTicks = 1;
int ShotsPerBar = 1;
string Zs_320 = "";
int Z_period_328 = 3;
int Z_digits_332 = 0;
int Zi_336 = 0;
datetime Z_time_340 = 0;
int Z_count_344 = 0;
int Zi_348 = 0;
int Zi_352 = -1;
int Zi_356 = 0;
int Zi_360 = 0;
enum lottype
  {
   Fixed_lot=0,   
   Risk_per_trade=1, 
   Margin_percent_use=2,   
  };
enum trailingmode
  {
   Adaptive_by_Time=0,  
   Adaptive_by_Volatility=1,     
   Adaptive_by_Volume=2,
  };
enum gmt
  {
   Auto_GMT_not_for_tester=0,   
   Manual_GMT=1,   
  };

 int Expert_Id = 8888;
 string Expert_Comment = "";

 lottype Lot_Type = 1;
 double Lot_Risk = 1.0;
 double Lot_Max = 0.0;
 bool TrailingStop_CorrectSL = TRUE;
 bool TrailingStop_UseRealOPAndSL = TRUE;
 trailingmode TrailingStop_TrailingMode = 0;




int Z_datetime_364;
int Z_leverage_368;
int Zi_372;
int Zi_376;
int Zi_380;
int Zi_384;
int Zi_388;
int Zi_392;

int Zi_504;
int Zi_508 = -1;
int Zi_512 = 3000000;
int Zi_516 = 0;


int init() {
   Print("====== Initialization of ", Zs_320, " ======");
   Z_datetime_364 = TimeLocal();
   Zi_336 = -1;
   Z_digits_332 = Digits;
   Z_leverage_368 = AccountLeverage();
   Zd_464 = MathMax(MarketInfo(Symbol(), MODE_FREEZELEVEL), MarketInfo(Symbol(), MODE_STOPLEVEL));
   Zd_472 = AccountStopoutLevel();
   Z_lotstep_480 = MarketInfo(Symbol(), MODE_LOTSTEP);
   if (UseIndicatorSwitch < 1 || UseIndicatorSwitch > 4) UseIndicatorSwitch = 1;
   if (UseIndicatorSwitch == 4) UseVolatilityPercentage = FALSE;
   if (Zd_464 == 0.0 && AddPriceGap == 0.0) Zd_464 = MinimumUseStopLevel;
   StopLoss = MathMax(StopLoss, Zd_464);
   TakeProfit = MathMax(TakeProfit, Zd_464);
   VolatilityPercentageLimit = VolatilityPercentageLimit / 100.0 + 1.0;
   VolatilityMultiplier /= 10.0;
   ArrayInitialize(Zda_436, 0);
   VolatilityLimit *= Point;
   Commission = f0_12(Commission * Point);
   TrailingStart *= Point;
   Zd_464 *= Point;
   AddPriceGap *= Point;
   if (MinLots < MarketInfo(Symbol(), MODE_MINLOT)) MinLots = MarketInfo(Symbol(), MODE_MINLOT);
   if (MaxLots > MarketInfo(Symbol(), MODE_MAXLOT)) MaxLots = MarketInfo(Symbol(), MODE_MAXLOT);
   if (MaxLots < MinLots) MaxLots = MinLots;
   Z_marginrequired_488 = MarketInfo(Symbol(), MODE_MARGINREQUIRED);
   Zi_372 = MarketInfo(Symbol(), MODE_LOTSIZE);
   f0_4();
   Z_lots_440 = f0_11();
   if (Expert_Id < 0) f0_13();
   if (MaxExecution > 0) MaxExecutionMinutes = 60 * MaxExecution;
   f0_14();
   Print("========== Initialization complete! ===========\n");
   start();
   return (0);
}


int deinit() {
   string Ms_0 = "";
   if (IsTesting() && MaxExecution > 0) {
      Ms_0 = Ms_0 + "During backtesting " + Z_count_428 + " number of ticks was ";
      Ms_0 = Ms_0 + "skipped to simulate latency of up to " + MaxExecution + " ms";
      f0_3(Ms_0);
   }
   f0_5();
   Print(Zs_320, " has been deinitialized!");
   return (0);
}


int start() {
if ((Lot_Type == 1) || (Lot_Type == 2))
{
AUTOMM = TRUE;
}
if (Lot_Type == 0)
{
AUTOMM = FALSE;

}


   f0_9();
   return (0);
}


void f0_9() {
   string Ms_unused_8;
   bool bool_24;
   int Mi_32;
   int Mi_36;
   int Mi_40;
   int ticket_52;
   int Mi_88;
   int Mi_92;
   double Md_128;
   double price_144;
   double order_stoploss_152;
   double order_takeprofit_160;
   double Md_184;
   double Md_192;
   double Md_200;
   double Md_208;
   double Md_216;
   double Md_224;
   double Md_232;
   double Md_240;
   double Md_248;
   double price_312;
   double Md_344;
   if (Z_time_340 < Time[0]) {
      if (Zi_432 < 10) Zi_432++;
      Zd_496 += (Z_count_344 - Zd_496) / Zi_432;
      Z_time_340 = Time[0];
      Z_count_344 = 0;
   } else Z_count_344++;
   if (IsTesting() && MaxExecution != 0 && Zi_352 != -1) {
      Md_344 = MathRound(Zd_496 * MaxExecution / 60000.0);
      if (Z_count_428 >= Md_344) {
         Zi_352 = -1;
         Z_count_428 = 0;
      } else {
         Z_count_428++;
         return;
      }
   }
   double ask_96 = MarketInfo(Symbol(), MODE_ASK);
   double bid_104 = MarketInfo(Symbol(), MODE_BID);
   double ihigh_168 = iHigh(Symbol(), PERIOD_M1, 0);
   double ilow_176 = iLow(Symbol(), PERIOD_M1, 0);
   double Md_280 = ihigh_168 - ilow_176;
   string Ms_16 = "";
   if (UseIndicatorSwitch == 1 || UseIndicatorSwitch == 4) {
      Md_184 = iMA(Symbol(), PERIOD_M1, Z_period_328, 0, MODE_LWMA, PRICE_LOW, 0);
      Md_192 = iMA(Symbol(), PERIOD_M1, Z_period_328, 0, MODE_LWMA, PRICE_HIGH, 0);
      Md_200 = Md_192 - Md_184;
      Mi_32 = bid_104 >= Md_184 + Md_200 / 2.0;
      Ms_16 = "iMA_low: " + f0_6(Md_184) + ", iMA_high: " + f0_6(Md_192) + ", iMA_diff: " + f0_6(Md_200);
   }
   if (UseIndicatorSwitch == 2) {
      Md_208 = iBands(Symbol(), PERIOD_M1, Z_period_328, BBDeviation, 0, PRICE_OPEN, MODE_UPPER, 0);
      Md_216 = iBands(Symbol(), PERIOD_M1, Z_period_328, BBDeviation, 0, PRICE_OPEN, MODE_LOWER, 0);
      Md_224 = Md_208 - Md_216;
      Mi_36 = bid_104 >= Md_216 + Md_224 / 2.0;
      Ms_16 = "iBands_upper: " + f0_6(Md_216) + ", iBands_lower: " + f0_6(Md_216) + ", iBands_diff: " + f0_6(Md_224);
   }
   if (UseIndicatorSwitch == 3) {
      Md_232 = iEnvelopes(Symbol(), PERIOD_M1, Z_period_328, MODE_LWMA, 0, PRICE_OPEN, EnvelopesDeviation, MODE_UPPER, 0);
      Md_240 = iEnvelopes(Symbol(), PERIOD_M1, Z_period_328, MODE_LWMA, 0, PRICE_OPEN, EnvelopesDeviation, MODE_LOWER, 0);
      Md_248 = Md_232 - Md_240;
      Mi_40 = bid_104 >= Md_240 + Md_248 / 2.0;
      Ms_16 = "iEnvelopes_upper: " + f0_6(Md_232) + ", iEnvelopes_lower: " + f0_6(Md_240) + ", iEnvelopes_diff: " + f0_6(Md_248);
   }
   bool Mi_48 = FALSE;
   int Mi_72 = 0;
   if (UseIndicatorSwitch == 1 && Mi_32 == 1) {
      Mi_48 = TRUE;
      Zd_448 = Md_192;
      Zd_456 = Md_184;
   } else {
      if (UseIndicatorSwitch == 2 && Mi_36 == 1) {
         Mi_48 = TRUE;
         Zd_448 = Md_208;
         Zd_456 = Md_216;
      } else {
         if (UseIndicatorSwitch == 3 && Mi_40 == 1) {
            Mi_48 = TRUE;
            Zd_448 = Md_232;
            Zd_456 = Md_240;
         }
      }
   }
   double Md_288 = ask_96 - bid_104;
   int datetime_56 = TimeCurrent() + OrderExpireSeconds;
   Z_lots_440 = f0_11();
   ArrayCopy(Zda_436, Zda_436, 0, 1, 29);
   Zda_436[29] = Md_288;
   if (Zi_348 < 30) Zi_348++;
   double Md_320 = 0;
   int pos_64 = 29;
   for (int count_68 = 0; count_68 < Zi_348; count_68++) {
      Md_320 += Zda_436[pos_64];
      pos_64--;
   }
   double Md_296 = Md_320 / Zi_348;
   double Md_328 = f0_12(ask_96 + Commission);
   double Md_336 = f0_12(bid_104 - Commission);
   double Md_304 = Md_296 + Commission;
   if (mm == TRUE) VolatilityLimit = Md_304 * VolatilityMultiplier;
   if (Md_280 && VolatilityLimit && Zd_456 && Zd_448 && UseIndicatorSwitch != 4) {
      if (Md_280 > VolatilityLimit) {
         Md_128 = Md_280 / VolatilityLimit;
         if (UseVolatilityPercentage == FALSE || (UseVolatilityPercentage == TRUE && Md_128 > VolatilityPercentageLimit)) {
            if (bid_104 < Zd_456) Mi_72 = -1;
            else
               if (bid_104 > Zd_448) Mi_72 = 1;
         }
      } else Md_128 = 0;
   }
   if (AccountBalance() <= 0.0) {
      Comment("ERROR -- Account Balance is " + DoubleToStr(MathRound(AccountBalance()), 0));
      return;
   }
   Zi_352 = -1;
   int count_76 = 0;
   int count_80 = 0;
   for (pos_64 = 0; pos_64 < OrdersTotal(); pos_64++) {
     f = OrderSelect(pos_64, SELECT_BY_POS, MODE_TRADES);
      if (OrderMagicNumber() == Expert_Id && OrderCloseTime() == 0) {
         if (OrderSymbol() != Symbol()) {
            count_80++;
            continue;
         }
         switch (OrderType()) {
         case OP_BUY:
            RefreshRates();
            order_stoploss_152 = OrderStopLoss();
            order_takeprofit_160 = OrderTakeProfit();
            if (order_takeprofit_160 < f0_12(Md_328 + TakeProfit * Point + AddPriceGap) && Md_328 + TakeProfit * Point + AddPriceGap - order_takeprofit_160 > TrailingStart) {
               order_stoploss_152 = f0_12(bid_104 - StopLoss * Point - AddPriceGap);
               order_takeprofit_160 = f0_12(Md_328 + TakeProfit * Point + AddPriceGap);
               if (order_stoploss_152 != OrderStopLoss() && order_takeprofit_160 != OrderTakeProfit()) {
                  Zi_352 = GetTickCount();
                  bool_24 = OrderModify(OrderTicket(), 0, order_stoploss_152, order_takeprofit_160, datetime_56, Lime);
               }
               if (bool_24 == TRUE) {
                  Zi_352 = GetTickCount() - Zi_352;
                  if (TakeShots && (!IsTesting())) f0_8();
               } else {
                  Zi_352 = -1;
                  f0_0();
                  if (Debug || Verbose) Print("Order could not be modified because of ", ErrorDescription(GetLastError()));
                  if (order_stoploss_152 == 0.0) bool_24 = OrderModify(OrderTicket(), 0, NormalizeDouble(Bid - 30.0, Z_digits_332), 0, 0, Red);
               }
            }
            count_76++;
            break;
         case OP_SELL:
            RefreshRates();
            order_stoploss_152 = OrderStopLoss();
            order_takeprofit_160 = OrderTakeProfit();
            if (order_takeprofit_160 > f0_12(Md_336 - TakeProfit * Point - AddPriceGap) && order_takeprofit_160 - Md_336 + TakeProfit * Point - AddPriceGap > TrailingStart) {
               order_stoploss_152 = f0_12(ask_96 + StopLoss * Point + AddPriceGap);
               order_takeprofit_160 = f0_12(Md_336 - TakeProfit * Point - AddPriceGap);
               if (order_stoploss_152 != OrderStopLoss() && order_takeprofit_160 != OrderTakeProfit()) {
                  Zi_352 = GetTickCount();
                  bool_24 = OrderModify(OrderTicket(), 0, order_stoploss_152, order_takeprofit_160, datetime_56, Orange);
               }
               if (bool_24 == TRUE) {
                  Zi_352 = GetTickCount() - Zi_352;
                  if (TakeShots && (!IsTesting())) f0_8();
               } else {
                  Zi_352 = -1;
                  f0_0();
                  if (Debug || Verbose) Print("Order could not be modified because of ", ErrorDescription(GetLastError()));
                  Sleep(1000);
                  if (order_stoploss_152 == 0.0) bool_24 = OrderModify(OrderTicket(), 0, NormalizeDouble(Ask + 30.0, Z_digits_332), 0, 0, Red);
               }
            }
            count_76++;
            break;
         case OP_BUYSTOP:
            if (Mi_48 == FALSE) {
               price_144 = f0_12(ask_96 + Zd_464 + AddPriceGap);
               order_stoploss_152 = f0_12(price_144 - Md_288 - StopLoss * Point - AddPriceGap);
               order_takeprofit_160 = f0_12(price_144 + Commission + TakeProfit * Point + AddPriceGap);
               if (price_144 < OrderOpenPrice() && OrderOpenPrice() - price_144 > TrailingStart) {
                  if (order_stoploss_152 != OrderStopLoss() && order_takeprofit_160 != OrderTakeProfit()) {
                     RefreshRates();
                     Zi_352 = GetTickCount();
                     bool_24 = OrderModify(OrderTicket(), price_144, order_stoploss_152, order_takeprofit_160, 0, Lime);
                  }
                  if (bool_24 == TRUE) {
                     Zi_352 = GetTickCount() - Zi_352;
                     if (Debug || Verbose) Print("Order executed in " + Zi_352 + " ms");
                  } else {
                     Zi_352 = -1;
                     f0_0();
                  }
               }
               count_76++;
            } else 
            f = OrderDelete(OrderTicket());
            break;
         case OP_SELLSTOP:
            if (Mi_48 == TRUE) {
               price_144 = f0_12(bid_104 - Zd_464 - AddPriceGap);
               order_stoploss_152 = f0_12(price_144 + Md_288 + StopLoss * Point + AddPriceGap);
               order_takeprofit_160 = f0_12(price_144 - Commission - TakeProfit * Point - AddPriceGap);
               if (price_144 > OrderOpenPrice() && price_144 - OrderOpenPrice() > TrailingStart) {
                  if (order_stoploss_152 != OrderStopLoss() && order_takeprofit_160 != OrderTakeProfit()) {
                     RefreshRates();
                     Zi_352 = GetTickCount();
                     bool_24 = OrderModify(OrderTicket(), price_144, order_stoploss_152, order_takeprofit_160, 0, Orange);
                  }
                  if (bool_24 == TRUE) {
                     Zi_352 = GetTickCount() - Zi_352;
                     if (Debug || Verbose) Print("Order executed in " + Zi_352 + " ms");
                  } else {
                     Zi_352 = -1;
                     f0_0();
                  }
               }
               count_76++;
            } else 
            f = OrderDelete(OrderTicket());
         }
      }
   }
   if (Zi_336 >= 0 || Zi_336 == -2) {
      Mi_92 = NormalizeDouble(bid_104 / Point, 0);
      Mi_88 = NormalizeDouble(ask_96 / Point, 0);
      if (Mi_92 % 10 != 0 || Mi_88 % 10 != 0) Zi_336 = -1;
      else {
         if (Zi_336 >= 0 && Zi_336 < 10) Zi_336++;
         else Zi_336 = -2;
      }
   }
   int Mi_unused_28 = 0;
   if (Mi_72 != 0 && MaxExecution > 0 && Zi_356 > MaxExecution) {
      Mi_72 = 0;
      if (Debug || Verbose) Print("Server is too Slow. Average Execution: " + Zi_356);
   }
   double Md_112 = ask_96 + Zd_464;
   double Md_120 = bid_104 - Zd_464;
   if (count_76 == 0 && Mi_72 != 0 && f0_12(Md_304) <= f0_12(MaxSpread * Point) && Zi_336 == -1) {
      if (Mi_72 == -1 || Mi_72 == 2) {
         price_144 = ask_96 + Zd_464;
         if (ECN_Mode == TRUE) {
            price_144 = Md_112;
            order_stoploss_152 = 0;
            order_takeprofit_160 = 0;
            Zi_352 = GetTickCount();
            ticket_52 = OrderSend(Symbol(), OP_BUYSTOP, Z_lots_440, price_144, Slippage, order_stoploss_152, order_takeprofit_160, COMMENT, Expert_Id, 0, Lime);
            if (ticket_52 > 0) {
               Zi_352 = GetTickCount() - Zi_352;
               if (Debug || Verbose) Print("Order executed in " + Zi_352 + " ms");
               if (TakeShots && (!IsTesting())) f0_8();
            } else {
               Mi_unused_28 = 1;
               Zi_352 = -1;
               f0_0();
            }
            if (OrderSelect(ticket_52, SELECT_BY_TICKET)) {
               RefreshRates();
               price_144 = OrderOpenPrice();
               order_stoploss_152 = f0_12(price_144 - Md_288 - StopLoss * Point - AddPriceGap);
               order_takeprofit_160 = f0_12(price_144 + TakeProfit * Point + AddPriceGap);
               Zi_352 = GetTickCount();
               bool_24 = OrderModify(OrderTicket(), price_144, order_stoploss_152, order_takeprofit_160, datetime_56, Lime);
               if (bool_24 == TRUE) {
                  Zi_352 = GetTickCount() - Zi_352;
                  if (Debug || Verbose) Print("Order executed in " + Zi_352 + " ms");
                  if (TakeShots && (!IsTesting())) f0_8();
               } else {
                  Mi_unused_28 = 1;
                  Zi_352 = -1;
                  f0_0();
               }
            }
         } else {
            RefreshRates();
            price_144 = Md_112;
            order_stoploss_152 = f0_12(price_144 - Md_288 - StopLoss * Point - AddPriceGap);
            order_takeprofit_160 = f0_12(price_144 + TakeProfit * Point + AddPriceGap);
            Zi_352 = GetTickCount();
            ticket_52 = OrderSend(Symbol(), OP_BUYSTOP, Z_lots_440, price_144, Slippage, order_stoploss_152, order_takeprofit_160, COMMENT, Expert_Id, datetime_56, Lime);
            if (ticket_52 > 0) {
               Zi_352 = GetTickCount() - Zi_352;
               if (Debug || Verbose) Print("Order executed in " + Zi_352 + " ms");
               if (TakeShots && (!IsTesting())) f0_8();
            } else {
               Mi_unused_28 = 1;
               Zi_352 = -1;
               f0_0();
            }
         }
      }
      if (Mi_72 == 1 || Mi_72 == 2) {
         price_144 = Md_120;
         order_stoploss_152 = 0;
         order_takeprofit_160 = 0;
         if (ECN_Mode) {
            Zi_352 = GetTickCount();
            ticket_52 = OrderSend(Symbol(), OP_SELLSTOP, Z_lots_440, price_144, Slippage, order_stoploss_152, order_takeprofit_160, COMMENT, Expert_Id, 0, Orange);
            if (ticket_52 > 0) {
               Zi_352 = GetTickCount() - Zi_352;
               if (Debug || Verbose) Print("Order executed in " + Zi_352 + " ms");
               if (TakeShots && (!IsTesting())) f0_8();
            } else {
               Mi_unused_28 = 1;
               Zi_352 = -1;
               f0_0();
            }
            if (OrderSelect(ticket_52, SELECT_BY_TICKET)) {
               RefreshRates();
               price_144 = OrderOpenPrice();
               order_stoploss_152 = f0_12(price_144 + Md_288 + StopLoss * Point + AddPriceGap);
               order_takeprofit_160 = f0_12(price_144 - TakeProfit * Point - AddPriceGap);
               Zi_352 = GetTickCount();
               bool_24 = OrderModify(OrderTicket(), OrderOpenPrice(), order_stoploss_152, order_takeprofit_160, datetime_56, Orange);
            }
            if (bool_24 == TRUE) {
               Zi_352 = GetTickCount() - Zi_352;
               if (Debug || Verbose) Print("Order executed in " + Zi_352 + " ms");
               if (TakeShots && (!IsTesting())) f0_8();
            } else {
               Mi_unused_28 = 1;
               Zi_352 = -1;
               f0_0();
            }
         } else {
            RefreshRates();
            price_144 = Md_120;
            order_stoploss_152 = f0_12(price_144 + Md_288 + StopLoss * Point + AddPriceGap);
            order_takeprofit_160 = f0_12(price_144 - TakeProfit * Point - AddPriceGap);
            Zi_352 = GetTickCount();
            ticket_52 = OrderSend(Symbol(), OP_SELLSTOP, Z_lots_440, price_144, Slippage, order_stoploss_152, order_takeprofit_160, COMMENT, Expert_Id, datetime_56, Orange);
            if (ticket_52 > 0) {
               Zi_352 = GetTickCount() - Zi_352;
               if (Debug || Verbose) Print("Order executed in " + Zi_352 + " ms");
               if (TakeShots && (!IsTesting())) f0_8();
            } else {
               Mi_unused_28 = 1;
               Zi_352 = 0;
               f0_0();
            }
         }
      }
   }
   if (MaxExecution && Zi_352 == -1 && (TimeLocal() - Z_datetime_364) % MaxExecutionMinutes == 0) {
      if (IsTesting() && MaxExecution) {
         MathSrand(TimeLocal());
         Zi_352 = MathRand() / (32767 / MaxExecution);
      } else {
        
            price_312 = 2.0 * ask_96;
            ticket_52 = OrderSend(Symbol(), OP_BUYSTOP, Z_lots_440, price_312, Slippage, 0, 0, COMMENT, Expert_Id, 0, Lime);
            Zi_352 = GetTickCount();
            bool_24 = OrderModify(ticket_52, price_312 + 10.0 * Point, 0, 0, 0, Lime);
            Zi_352 = GetTickCount() - Zi_352;
           
           f = OrderDelete(ticket_52);
         
      }
   }
   if (Zi_352 >= 0) {
      if (Zi_360 < 10) Zi_360++;
      Zi_356 += (Zi_352 - Zi_356) / Zi_360;
   }
   if (Zi_336 >= 0) {
      Comment("Robot is initializing...");
      return;
   }
   if (Zi_336 == -2) {
      Comment("ERROR -- Instrument " + Symbol() + " prices should have " + Z_digits_332 + " fraction digits on broker account");
      return;
   }
   string Ms_0 = TimeToStr(TimeCurrent()) + " Tick: " + f0_10(Z_count_344);
   if (Debug || Verbose) {
      Ms_0 = Ms_0 
      + "\n*** DEBUG MODE *** \nCurrency pair: " + Symbol() + ", Volatility: " + f0_6(Md_280) + ", VolatilityLimit: " + f0_6(VolatilityLimit) + ", VolatilityPercentage: " + f0_6(Md_128);
      Ms_0 = Ms_0 
      + "\nPriceDirection: " + StringSubstr("BUY NULLSELLBOTH", Mi_72 * 4 + 4, 4) + ", Expire: " + TimeToStr(datetime_56, TIME_MINUTES) + ", Open orders: " + count_76;
      Ms_0 = Ms_0 
      + "\nBid: " + f0_6(bid_104) + ", Ask: " + f0_6(ask_96) + ", " + Ms_16;
      Ms_0 = Ms_0 
      + "\nAvgSpread: " + f0_6(Md_296) + ", RealAvgSpread: " + f0_6(Md_304) + ", Commission: " + f0_6(Commission) + ", Lots: " + DoubleToStr(Z_lots_440, 2) + ", Execution: " + Zi_352 + " ms";
      if (f0_12(Md_304) > f0_12(MaxSpread * Point)) {
         Ms_0 = Ms_0 
            + "\n" 
         + "The current spread (" + f0_6(Md_304) + ") is higher than what has been set as MaxSpread (" + f0_6(MaxSpread * Point) + ") so no trading is allowed right now on this currency pair!";
      }
      if (MaxExecution > 0 && Zi_356 > MaxExecution) {
         Ms_0 = Ms_0 
            + "\n" 
         + "The current Avg Execution (" + Zi_356 + ") is higher than what has been set as MaxExecution (" + MaxExecution + " ms), so no trading is allowed right now on this currency pair!";
      }
      Comment(Ms_0);
      if (count_76 != 0 || Mi_72 != 0) f0_2(Ms_0);
   }
}


string f0_6(double Od_0) {
   return (DoubleToStr(Od_0, Z_digits_332));
}


double f0_12(double Od_0) {
   return (NormalizeDouble(Od_0, Z_digits_332));
}


string f0_10(int Oi_0) {
   if (Oi_0 < 10) return ("00" + Oi_0);
   if (Oi_0 < 100) return ("0" + Oi_0);
   return ("" + Oi_0);
}


void f0_2(string Os_0) {
   int Mi_8;
   int Mi_12 = -1;
   while (Mi_12 < StringLen(Os_0)) {
      Mi_8 = Mi_12 + 1;
      Mi_12 = StringFind(Os_0, 
      "\n", Mi_8);
      if (Mi_12 == -1) {
         Print(StringSubstr(Os_0, Mi_8));
         return;
      }
      Print(StringSubstr(Os_0, Mi_8, Mi_12 - Mi_8));
   }
}


int f0_13() {
   string Ms_0 = Symbol();
   int str_len_8 = StringLen(Ms_0);
   int Mi_12 = 0;
   for (int Mi_16 = 0; Mi_16 < str_len_8 - 1; Mi_16++) Mi_12 += StringGetChar(Ms_0, Mi_16);
   Expert_Id = AccountNumber() + Mi_12;
   return (0);
}


void f0_8() {
   int Mi_0;
   if (ShotsPerBar > 0) Mi_0 = MathRound(60 * Period() / ShotsPerBar);
   else Mi_0 = 60 * Period();
   int Mi_4 = MathFloor((TimeCurrent() - Time[0]) / Mi_0);
   if (Time[0] != Zi_504) {
      Zi_504 = Time[0];
      Zi_508 = DelayTicks;
   } else
      if (Mi_4 > Zi_512) f0_1("i");
   Zi_512 = Mi_4;
   if (Zi_508 == 0) f0_1("");
   if (Zi_508 >= 0) Zi_508--;
}


string f0_7(int Oi_0, int Oi_4) {
   for (string dbl2str_8 = DoubleToStr(Oi_0, 0); StringLen(dbl2str_8) < Oi_4; dbl2str_8 = "0" + dbl2str_8) {
   }
   return (dbl2str_8);
}


void f0_1(string Os_0 = "") {
   Zi_516++;
   string Ms_8 = "SnapShot" + Symbol() + Period() + "\\" + Year() + "-" + f0_7(Month(), 2) + "-" + f0_7(Day(), 2) + " " + f0_7(Hour(), 2) + "_" + f0_7(Minute(), 2) + "_" + f0_7(Seconds(),
      2) + " " + Zi_516 + Os_0 + ".gif";
   if (!WindowScreenShot(Ms_8, 640, 480)) Print("ScreenShot error: ", ErrorDescription(GetLastError()));
}


double f0_11() {
   int Mi_40;
   if (Z_lotstep_480 == 1.0) Mi_40 = 0;
   if (Z_lotstep_480 == 0.1) Mi_40 = 1;
   if (Z_lotstep_480 == 0.01) Mi_40 = 2;
   double Md_8 = AccountEquity();
   double Md_24 = MathMin(MathFloor(0.98 * Md_8 / Z_marginrequired_488 / Z_lotstep_480) * Z_lotstep_480, MaxLots);
   double Md_32 = MinLots;
   double Md_ret_16 = MathMin(MathFloor(risk / 102.0 * Md_8 / (StopLoss + AddPriceGap) / Z_lotstep_480) * Z_lotstep_480, MaxLots);
   Md_ret_16 = NormalizeDouble(Md_ret_16, Mi_40);
   string Ms_0 = "";
   if (AUTOMM == FALSE) {
      Md_ret_16 = default_lot;
      if (default_lot > Md_24) {
         Md_ret_16 = Md_24;
         Ms_0 = "Note: Manual lotsize is too high. It has been recalculated to maximum allowed " + DoubleToStr(Md_24, 2);
         Print(Ms_0);
         Comment(Ms_0);
         default_lot = Md_24;
      } else
         if (default_lot < Md_32) Md_ret_16 = Md_32;
   }
   return (Md_ret_16);
}


double f0_4() {
   double Md_8 = AccountEquity();
   double Md_16 = MathFloor(Md_8 / Z_marginrequired_488 / Z_lotstep_480) * Z_lotstep_480;
   double Md_40 = MathFloor(100.0 * (Md_16 * (Zd_464 + StopLoss) / Md_8) / 0.1) / 10.0;
   double Md_24 = MinLots;
   double Md_48 = MathRound(100.0 * (Md_24 * StopLoss / Md_8) / 0.1) / 10.0;
   string Ms_0 = "";
   if (AUTOMM == TRUE) {
      if (risk > Md_40) {
         Ms_0 = Ms_0 + "Note: risk has manually been set to " + DoubleToStr(risk, 1) + " but cannot be higher than " + DoubleToStr(Md_40, 1) + " according to ";
         Ms_0 = Ms_0 + "the broker, StopLoss and Equity. It has now been adjusted accordingly to " + DoubleToStr(Md_40, 1) + "%";
         risk = Md_40;
         f0_3(Ms_0);
      }
      if (risk < Md_48) {
         Ms_0 = Ms_0 + "Note: risk has manually been set to " + DoubleToStr(risk, 1) + " but cannot be lower than " + DoubleToStr(Md_48, 1) + " according to ";
         Ms_0 = Ms_0 + "the broker, StopLoss, AddPriceGap and Equity. It has now been adjusted accordingly to " + DoubleToStr(Md_48, 1) + "%";
         risk = Md_48;
         f0_3(Ms_0);
      }
   } else {
      if (default_lot < MinLots) {
         Ms_0 = "Manual lotsize " + DoubleToStr(default_lot, 2) + " cannot be less than " + DoubleToStr(MinLots, 2) + ". It has now been adjusted to " + DoubleToStr(MinLots,
            2);
         default_lot = MinLots;
         f0_3(Ms_0);
      }
      if (default_lot > MaxLots) {
         Ms_0 = "Manual lotsize " + DoubleToStr(default_lot, 2) + " cannot be greater than " + DoubleToStr(MaxLots, 2) + ". It has now been adjusted to " + DoubleToStr(MinLots,
            2);
         default_lot = MaxLots;
         f0_3(Ms_0);
      }
      if (default_lot > Md_16) {
         Ms_0 = "Manual lotsize " + DoubleToStr(default_lot, 2) + " cannot be greater than maximum allowed lotsize. It has now been adjusted to " + DoubleToStr(Md_16, 2);
         default_lot = Md_16;
         f0_3(Ms_0);
      }
   }
   return (0.0);
}


void f0_14() {
   string Ms_0;
   string Ms_8;
   string Ms_16;
   int Mi_24 = IsDemo() + IsTesting();
   int Mi_28 = AccountFreeMarginMode();
   int Mi_32 = AccountStopoutMode();
   if (Mi_28 == 0) Ms_0 = "that floating profit/loss is not used for calculation.";
   else {
      if (Mi_28 == 1) Ms_0 = "both floating profit and loss on open positions.";
      else {
         if (Mi_28 == 2) Ms_0 = "only profitable values, where current loss on open positions are not included.";
         else
            if (Mi_28 == 3) Ms_0 = "only loss values are used for calculation, where current profitable open positions are not included.";
      }
   }
   if (Mi_32 == 0) Ms_8 = "percentage ratio between margin and equity.";
   else
      if (Mi_32 == 1) Ms_8 = "comparison of the free margin level to the absolute value.";
   if (AUTOMM == TRUE) Ms_16 = " (automatically calculated lots).";
   if (AUTOMM == FALSE) Ms_16 = " (fixed manual lots).";
   Print("Broker name: ", AccountCompany());
   Print("Broker server: ", AccountServer());
   Print("Account type: ", StringSubstr("RealDemoTest", Mi_24 * 4, 4));
   Print("Initial account balance: ", AccountBalance(), " ", AccountCurrency());
   Print("Broker digits: ", Z_digits_332);
   Print("Broker stoplevel / freezelevel (max): ", Zd_464, " points.");
   Print("Broker stopout level: ", Zd_472, "%");
   Print("Broker Point: ", DoubleToStr(Point, Z_digits_332), " on ", AccountCurrency());
   Print("Broker account leverage in percentage: ", Z_leverage_368);
   Print("Broker credit value on the account: ", AccountCredit());
   Print("Broker account margin: ", AccountMargin());
   Print("Broker calculation of free margin allowed to open positions considers " + Ms_0);
   Print("Broker calculates stopout level as " + Ms_8);
   Print("Broker requires at least ", Z_marginrequired_488, " ", AccountCurrency(), " in margin for 1 lot.");
   Print("Broker set 1 lot to trade ", Zi_372, " ", AccountCurrency());
   Print("Broker minimum allowed lotsize: ", MinLots);
   Print("Broker maximum allowed lotsize: ", MaxLots);
   Print("Broker allow lots to be resized in ", Z_lotstep_480, " steps.");
   Print("risk: ", risk, "%");
   Print("risk adjusted lotsize: ", DoubleToStr(Z_lots_440, 2) + Ms_16);
}

void f0_3(string Os_0) {
   Print(Os_0);
   Comment(Os_0);
}


void f0_0() {
   int error_0 = GetLastError();
   switch (error_0) {
   case 1/* NO_RESULT */:
      Zi_376++;
      return;
   case 4/* SERVER_BUSY */:
      Zi_380++;
      return;
   case 6/* NO_CONNECTION */:
      Zi_384++;
      return;
   case 8/* TOO_FREQUENT_REQUESTS */:
      Zi_388++;
      return;
   case 129/* INVALID_PRICE */:
      Zi_392++;
      return;
   case 130/* INVALID_STOPS */:
      Zi_396++;
      return;
   case 131/* INVALID_TRADE_VOLUME */:
      Zi_400++;
      return;
   case 135/* PRICE_CHANGED */:
      Zi_404++;
      return;
   case 137/* BROKER_BUSY */:
      Zi_408++;
      return;
   case 138/* REQUOTE */:
      Zi_412++;
      return;
   case 141/* TOO_MANY_REQUESTS */:
      Zi_416++;
      return;
   case 145/* TRADE_MODIFY_DENIED */:
      Zi_420++;
      return;
   case 146/* TRADE_CONTEXT_BUSY */:
      Zi_424++;
      return;
      return;
   }
}


void f0_5() {
   string Ms_0 = "Number of times the brokers server reported that ";
   if (Zi_376 > 0) f0_3(Ms_0 + "SL and TP was modified to existing values: " + DoubleToStr(Zi_376, 0));
   if (Zi_380 > 0) f0_3(Ms_0 + "it is buzy: " + DoubleToStr(Zi_380, 0));
   if (Zi_384 > 0) f0_3(Ms_0 + "the connection is lost: " + DoubleToStr(Zi_384, 0));
   if (Zi_388 > 0) f0_3(Ms_0 + "there was too many requests: " + DoubleToStr(Zi_388, 0));
   if (Zi_392 > 0) f0_3(Ms_0 + "the price was invalid: " + DoubleToStr(Zi_392, 0));
   if (Zi_396 > 0) f0_3(Ms_0 + "invalid SL and/or TP: " + DoubleToStr(Zi_396, 0));
   if (Zi_400 > 0) f0_3(Ms_0 + "invalid lot size: " + DoubleToStr(Zi_400, 0));
   if (Zi_404 > 0) f0_3(Ms_0 + "the price has changed: " + DoubleToStr(Zi_404, 0));
   if (Zi_408 > 0) f0_3(Ms_0 + "the broker is buzy: " + DoubleToStr(Zi_408, 0));
   if (Zi_412 > 0) f0_3(Ms_0 + "requotes " + DoubleToStr(Zi_412, 0));
   if (Zi_416 > 0) f0_3(Ms_0 + "too many requests " + DoubleToStr(Zi_416, 0));
   if (Zi_420 > 0) f0_3(Ms_0 + "modifying orders is denied " + DoubleToStr(Zi_420, 0));
   if (Zi_424 > 0) f0_3(Ms_0 + "trade context is buzy: " + DoubleToStr(Zi_424, 0));
}

        
