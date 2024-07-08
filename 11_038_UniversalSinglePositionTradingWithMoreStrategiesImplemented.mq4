//+------------------------------------------------------------------+
//| 11.038_UniversalSinglePositionTradingWithMoreStrategiesImplemented_old.mq4
//| Copyright Copyright 2020, MetaQuotes Software Corp.
//| https://www.mql5.com
//+------------------------------------------------------------------+
#property copyright "slacktrader"
#property link      "slacktrader"

#define     _MAGICNUMBER               123456


//------------------------------------------------------------------
//------------------------------------------------------------------
//------------------------------------------------------------------
// main variables                                                         
//------------------------------------------------------------------
//------------------------------------------------------------------
//------------------------------------------------------------------
int   _STRATEGY_NUMBER              = 14;

// 1 - PERIOD_M1
// 2 - PERIOD_M5
// 3 - PERIOD_M15
// 4 - PERIOD_M30
// 5 - PERIOD_H1
// 6 - PERIOD_H4
// 7 - PERIOD_D1
// 8 - PERIOD_W1
// 9 - PERIOD_MN1

// _STRATEGY_TIMEFRAME_CHOICE
//extern string poznamka1 = "0 - vyber timeframe podla dropdown menu - premenna _STRATEGY_TIMEFRAME sa ignoruje";
//extern string poznamka2 = "1 - vyber timeframe podla kodu timeframe 1 - 9";
int   _STRATEGY_TIMEFRAME_CHOICE    = 0;
extern int   _STRATEGY_TIMEFRAME           = 1;

//string poznamka1 = "0 - vyber timeframe podla dropdown menu - premenna _STRATEGY_TIMEFRAME sa ignoruje";
//string poznamka2 = "1 - vyber timeframe podla kodu timeframe 1 - 9";
//int   _STRATEGY_TIMEFRAME_CHOICE    = 1;
//int   _STRATEGY_TIMEFRAME           = 1;

//------------------------------------------------------------------
//------------------------------------------------------------------
//------------------------------------------------------------------
// MM Modul                                                         
//------------------------------------------------------------------
//------------------------------------------------------------------
//------------------------------------------------------------------
#define     _MM_FIX_LOT                         1
#define     _MM_FIX_PERC                        2
#define     _MM_FIX_PERC_AVG_LAST_PROFIT        3
#define     _MM_FIX_PERC_CNT_MAX_DD             4

#define     _MINLOTS                            0.1
#define     _MAXLOTS                            5
//------------------------------------------------------------------
//------------------------------------------------------------------
//------------------------------------------------------------------
// Signal Modul                                                     
//------------------------------------------------------------------
//------------------------------------------------------------------
//------------------------------------------------------------------
#define     _CLOSE_LONG                   1
#define     _CLOSE_SHORT                  2
#define     _OPEN_LONG                    3
#define     _OPEN_SHORT                   4
#define     _GET_LONG_STOPLOSS_PRICE      5
#define     _GET_SHORT_STOPLOSS_PRICE     6
#define     _GET_LONG_TAKEPROFIT_PRICE    7
#define     _GET_SHORT_TAKEPROFIT_PRICE   8
#define     _GET_LOTS                     9
#define     _GET_TRAILED_STOPLOSS_PRICE   10
#define     _GET_TRAILED_TAKEPROFIT_PRICE 11
#define     _GET_TRADED_TIMEFRAME         12
//------------------------------------------------------------------
//------------------------------------------------------------------
//------------------------------------------------------------------
static datetime LastBarTraded = 0;

int   LONGMA = 140;
//------------------------------------------------------------------
//------------------------------------------------------------------
//------------------------------------------------------------------
int init()
{
   return(0);
}
int deinit()
{
   
   return(0);
}

int start()
{
   double            Stoploss          = 0;
   double            TakeProfit        = 0;
   
   if(LastBarTraded())
      return(0);
//   if(!OpenNewBar())
//      return(0);

   if(OrdersTotal() > 0)
   {
      Stoploss = Strategy(_STRATEGY_NUMBER, _GET_TRAILED_STOPLOSS_PRICE);
      TakeProfit = Strategy(_STRATEGY_NUMBER, _GET_TRAILED_TAKEPROFIT_PRICE);
   
      if(Stoploss != 0 || TakeProfit != 0)
         ModifyAllPositions(_MAGICNUMBER, Stoploss, TakeProfit);

      if(Strategy(_STRATEGY_NUMBER, _CLOSE_LONG) == 1)
         CloseAllLongPositions(_MAGICNUMBER);
      if(Strategy(_STRATEGY_NUMBER, _CLOSE_SHORT) == 1)
         CloseAllShortPositions(_MAGICNUMBER);
   }
   

//   if(!OpenNewBar())
//      return(0);
   if(!TradeAllowed(1))
      return(0);

   if(Strategy(_STRATEGY_NUMBER, _OPEN_LONG) == 1)
      OpenPosition(false, Strategy(_STRATEGY_NUMBER, _GET_LOTS), Strategy(_STRATEGY_NUMBER, _GET_LONG_STOPLOSS_PRICE), Strategy(_STRATEGY_NUMBER, _GET_LONG_TAKEPROFIT_PRICE), 3, _MAGICNUMBER);
   if(Strategy(_STRATEGY_NUMBER, _OPEN_SHORT) == 1)
      OpenPosition(true, Strategy(_STRATEGY_NUMBER, _GET_LOTS), Strategy(_STRATEGY_NUMBER, _GET_SHORT_STOPLOSS_PRICE), Strategy(_STRATEGY_NUMBER, _GET_SHORT_TAKEPROFIT_PRICE), 3, _MAGICNUMBER);


   return(0);
}
//------------------------------------------------------------------
//------------------------------------------------------------------
//------------------------------------------------------------------
// Trading allowed modul
//------------------------------------------------------------------
//------------------------------------------------------------------
//------------------------------------------------------------------

//------------------------------------------------------------------
// Last bar already traded
//------------------------------------------------------------------
bool LastBarTraded()
{
//Trade only once on each bar
   if(LastBarTraded == Time[0])
      return(true);
   else
      return(false);
}
//------------------------------------------------------------------
// First tick of a traded timeframe bar
//------------------------------------------------------------------
bool OpenNewBar()
{
   if(iVolume(Symbol(), Strategy(_STRATEGY_NUMBER, _GET_TRADED_TIMEFRAME), 0) > 1)
      return(false);
   else
      return(true);
}
//------------------------------------------------------------------
// TradeAllowed function return true if trading is possible         
//------------------------------------------------------------------
bool TradeAllowed(int MAXORDERS)
{
//Trade only once on each bar
   if(!IsTradeAllowed()) 
      return(false);
   if(OrdersTotal() >= MAXORDERS)
      return(false);
   return(true);
}

//------------------------------------------------------------------
//------------------------------------------------------------------
//------------------------------------------------------------------
// MM Modul                                                         
//------------------------------------------------------------------
//------------------------------------------------------------------
//------------------------------------------------------------------
double GetLots(int MM_STRATEGY, int AMOUNT)
{
   double lot, result;

   switch(MM_STRATEGY)
   {
      case _MM_FIX_LOT:
      {
         lot = AMOUNT;

         break;
      }
      case _MM_FIX_PERC:
      {
         lot = NormalizeDouble(AccountFreeMargin() * AMOUNT / 1000.0, 1);

         break;
      }
      case _MM_FIX_PERC_AVG_LAST_PROFIT:
      {
         lot = NormalizeDouble(AccountFreeMargin() * AMOUNT / 1000.0, 1);

         break;
      }
   }

//   if(lot > AccountFreeMargin() / 1500.0)
//      lot = MathFloor(10 * AccountFreeMargin() / 1500.0)/ 10;

   if(lot < _MINLOTS)
      lot = _MINLOTS;
   else if(lot > _MAXLOTS)
      lot = _MAXLOTS;
      
   return(lot);
}
//------------------------------------------------------------------
//------------------------------------------------------------------
//------------------------------------------------------------------
// Order open modul
//------------------------------------------------------------------
//------------------------------------------------------------------
//------------------------------------------------------------------

//------------------------------------------------------------------------------------
// Opens position according to arguments (-1 short || 1 long, amount of Lots to trade 
//------------------------------------------------------------------------------------
void OpenPosition(bool SHORTLONG, double LOTS, double STOPLOSS, double TAKEPROFIT, int SLIPPAGE, int MAGICNUMBER)
{
   if(SHORTLONG)
   {
      OrderSend(Symbol(), OP_SELL, LOTS, Bid, SLIPPAGE, STOPLOSS, TAKEPROFIT, TimeToStr(Time[0]), MAGICNUMBER, 0, Red);
   }
   else
   {
      OrderSend(Symbol(), OP_BUY, LOTS, Ask, SLIPPAGE, STOPLOSS, TAKEPROFIT, TimeToStr(Time[0]), MAGICNUMBER, 0, Blue);
   }
   
   LastBarTraded = Time[0];
}
//------------------------------------------------------------------
//------------------------------------------------------------------
//------------------------------------------------------------------
//Position controll modul
//------------------------------------------------------------------
//------------------------------------------------------------------
//------------------------------------------------------------------
//------------------------------------------------------------------
void ModifyAllPositions(int MAGICNUMBER, double STOPLOSS, double TAKEPROFIT)
{
   for(int i = 0; i < OrdersTotal(); i++)
   {
      if(OrderSelect(i, SELECT_BY_POS, MODE_TRADES) == false)
         break;
      if(OrderMagicNumber() != MAGICNUMBER)
         continue;
      
      ModifyPosition(OrderTicket(), STOPLOSS, TAKEPROFIT);
   }
}
//------------------------------------------------------------------------------------
void ModifyPosition(int TICKETNUMBER, double STOPLOSS, double TAKEPROFIT)
{
   STOPLOSS = NormalizeDouble(STOPLOSS, 4);
   TAKEPROFIT = NormalizeDouble(TAKEPROFIT, 4);
   
   OrderSelect(TICKETNUMBER, SELECT_BY_TICKET);
   if(NormalizeDouble(OrderStopLoss(), 4) == NormalizeDouble(STOPLOSS, 4) && NormalizeDouble(OrderTakeProfit(), 4) == NormalizeDouble(TAKEPROFIT, 4))
      return;
      
//   Print(OrderTicket(), " - ", OrderOpenPrice(), " - ", OrderStopLoss(), " - ", OrderTakeProfit(), " - ", STOPLOSS, " - ", TAKEPROFIT);
   OrderModify(OrderTicket(), OrderOpenPrice(), STOPLOSS, TAKEPROFIT, 0);
}
//------------------------------------------------------------------------------------
// Close all positions
//------------------------------------------------------------------------------------
void CloseAllPositions(int MAGICNUMBER)
{
   int i;
   int OrderTickets2Close[];
   ArrayResize(OrderTickets2Close, 0);
   
   for(i = 0; i < OrdersTotal(); i++)
   {
      OrderSelect(i, SELECT_BY_POS);
      if(OrderMagicNumber() != MAGICNUMBER)
         continue;
      ArrayResize(OrderTickets2Close, ArraySize(OrderTickets2Close) + 1);
      OrderTickets2Close[ArraySize(OrderTickets2Close)] = OrderTicket();
   }

   ClosePositions(OrderTickets2Close);
}
//------------------------------------------------------------------------------------
// Close all long positions
//------------------------------------------------------------------------------------
void CloseAllLongPositions(int MAGICNUMBER)
{
   int i;
   int OrderTickets2Close[];
   ArrayResize(OrderTickets2Close, 0);
   
   for(i = 0; i < OrdersTotal(); i++)
   {
      OrderSelect(i, SELECT_BY_POS);
      if(OrderMagicNumber() != MAGICNUMBER || OrderType() != OP_BUY)
         continue;
      ArrayResize(OrderTickets2Close, ArraySize(OrderTickets2Close) + 1);
      OrderTickets2Close[ArraySize(OrderTickets2Close) - 1] = OrderTicket();
   }

   ClosePositions(OrderTickets2Close);
}
//------------------------------------------------------------------------------------
// Close all short positions
//------------------------------------------------------------------------------------
void CloseAllShortPositions(int MAGICNUMBER)
{
   int i;
   int OrderTickets2Close[];
   ArrayResize(OrderTickets2Close, 0);
   
   for(i = 0; i < OrdersTotal(); i++)
   {
      OrderSelect(i, SELECT_BY_POS);
      if(OrderMagicNumber() != MAGICNUMBER || OrderType() != OP_SELL)
         continue;
      ArrayResize(OrderTickets2Close, ArraySize(OrderTickets2Close) + 1);
      OrderTickets2Close[ArraySize(OrderTickets2Close) - 1] = OrderTicket();
   }

   ClosePositions(OrderTickets2Close);
}
//------------------------------------------------------------------------------------
// Close positions by ticket array
//------------------------------------------------------------------------------------
void ClosePositions(int OrderTickets2Close[])
{
   int i;
   
   for(i = 0; i < ArraySize(OrderTickets2Close); i++)
   {
      ClosePosition(OrderTickets2Close[i]);
   }
}
//------------------------------------------------------------------------------------
// Close position by ticket
//------------------------------------------------------------------------------------
void ClosePosition(int OrderTicket2Close)
{
   if(OrderSelect(OrderTicket2Close, SELECT_BY_TICKET))
   {
      if(OrderType() == OP_SELL)
         OrderClose(OrderTicket(), OrderLots(), Ask, 3, Orange);
      else if(OrderType() == OP_BUY)
         OrderClose(OrderTicket(), OrderLots(), Bid, 3, Orange);
   }
}
//------------------------------------------------------------------
//------------------------------------------------------------------
//------------------------------------------------------------------
// Tools - rozne
//------------------------------------------------------------------
//------------------------------------------------------------------
//------------------------------------------------------------------
//
string getStrategyCurrencyByNumber(int _CURRENCY)
{
// 1  - EURUSD
// 2  - GBPUSD
// 3  - USDCHF
// 4  - USDJPY
// 5  - EURJPY
// 6  - EURCHF
// 7  - EURGBP
// 8  - GBPJPY
// 9  - CHFJPY
// 10 - GBPCHF
   switch(_CURRENCY)
   {
      case 1:
         return ("EURUSD");
      case 2:
         return ("GBPUSD");
      case 3:
         return ("USDCHF");
      case 4:
         return ("USDJPY");
      case 5:
         return ("EURJPY");
      case 6:
         return ("EURCHF");
      case 7:
         return ("EURGBP");
      case 8:
         return ("GBPJPY");
      case 9:
         return ("CHFJPY");
      case 10:
         return ("GBPCHF");
   }
}
//------------------------------------------------------------------
int getStrategyTimeframeByNumber(int _PERIOD)
{
// 1 - PERIOD_M1
// 2 - PERIOD_M5
// 3 - PERIOD_M15
// 4 - PERIOD_M30
// 5 - PERIOD_H1
// 6 - PERIOD_H4
// 7 - PERIOD_D1
// 8 - PERIOD_W1
// 9 - PERIOD_MN1
   if(_STRATEGY_TIMEFRAME_CHOICE == 0)
      return(Period());
   else
      switch(_PERIOD)
      {
         case 1:
            return (PERIOD_M1);
         case 2:
            return (PERIOD_M5);
         case 3:
            return (PERIOD_M15);
         case 4:
            return (PERIOD_M30);
         case 5:
            return (PERIOD_H1);
         case 6:
            return (PERIOD_H4);
         case 7:
            return (PERIOD_D1);
         case 8:
            return (PERIOD_W1);
         case 9:
            return (PERIOD_MN1);
      }
}
//------------------------------------------------------------------
int HigherTimeframe(int Timeframe)
{
   switch(Timeframe)
   {
      case PERIOD_M1:
         return (PERIOD_M5);
      case PERIOD_M5:
         return (PERIOD_M15);
      case PERIOD_M15:
         return (PERIOD_M30);
      case PERIOD_M30:
         return (PERIOD_H1);
      case PERIOD_H1:
         return (PERIOD_H4);
      case PERIOD_H4:
         return (PERIOD_D1);
      case PERIOD_D1:
         return (PERIOD_W1);
      case PERIOD_W1:
         return (PERIOD_MN1);
   }
   
   return (Timeframe);
}
//------------------------------------------------------------------------------------
// Last fractal value
//------------------------------------------------------------------------------------
datetime getLastFractalTime(string _SYMBOL, int _TIMEFRAME, bool UpperLower)
{
   return (getNthFractalTime(_SYMBOL, _TIMEFRAME, UpperLower, 1));
}
//------------------------------------------------------------------------------------
// Previous fractal value
//------------------------------------------------------------------------------------
datetime getPreviousFractalTime(string _SYMBOL, int _TIMEFRAME, bool UpperLower)
{
   return (getNthFractalTime(_SYMBOL, _TIMEFRAME, UpperLower, 2));
}
//------------------------------------------------------------------------------------
// Last fractal value
//------------------------------------------------------------------------------------
double getLastFractalValue(string _SYMBOL, int _TIMEFRAME, bool UpperLower)
{
   return (getNthFractalValue(_SYMBOL, _TIMEFRAME, UpperLower, 1));
}
//------------------------------------------------------------------------------------
// Previous fractal value
//------------------------------------------------------------------------------------
double getPreviousFractalValue(string _SYMBOL, int _TIMEFRAME, bool UpperLower)
{
   return (getNthFractalValue(_SYMBOL, _TIMEFRAME, UpperLower, 2));
}
//------------------------------------------------------------------------------------
// NthFractal fractal value
//------------------------------------------------------------------------------------
double getNthFractalValue(string _SYMBOL, int _TIMEFRAME, bool UpperLower, int Nth)
{
   double   result      = 0;
   int      i           = 0;
   int      NthFractal  = Nth;     // NthFractal - put here number of fractal into history you want to get a value for
      
   if(UpperLower)
   {
      while(i < 1000 && NthFractal > 0)
      {
         result = iFractals(_SYMBOL, _TIMEFRAME, MODE_UPPER, i);
         
         i++;
         if(result > 0)
         {
            NthFractal--;
            continue;
         }
      }
   }
   else
   {
      while(i < 1000 && NthFractal > 0)
      {
         result = iFractals(_SYMBOL, _TIMEFRAME, MODE_LOWER, i);

         i++;
         if(result > 0)
         {
            NthFractal--;
            continue;
         }
      }
   }
   
   return (result);
}
//------------------------------------------------------------------------------------
// NthFractal fractal time
//------------------------------------------------------------------------------------
datetime getNthFractalTime(string _SYMBOL, int _TIMEFRAME, bool UpperLower, int Nth)
{
   datetime result      = 0;
   int      i           = 0;
   int      NthFractal  = Nth;     // NthFractal - put here number of fractal into history you want to get a value for
      
   if(UpperLower)
   {
      while(i < 1000 && NthFractal > 0)
      {
         i++;
         if(iFractals(_SYMBOL, _TIMEFRAME, MODE_UPPER, i) > 0)
         {
            NthFractal--;
            continue;
         }
      }
      
      return(iTime(_SYMBOL, _TIMEFRAME, i));
   }
   else
   {
      while(i < 1000 && NthFractal > 0)
      {
         i++;
         if(iFractals(_SYMBOL, _TIMEFRAME, MODE_LOWER, i) > 0)
         {
            NthFractal--;
            continue;
         }
      }

      return(iTime(_SYMBOL, _TIMEFRAME, i));
   }
   
   return (result);
}
//------------------------------------------------------------------
//------------------------------------------------------------------
//------------------------------------------------------------------
//Signal modul
//------------------------------------------------------------------
//------------------------------------------------------------------
//------------------------------------------------------------------
//
double Strategy(int STRATEGY, int COMMAND)
{
   switch(STRATEGY)
   {
// Ide o MACD strategiu, kde sa ako vstupne signaly vyhodnocuju MACD z dvoch TIMEFRAME
// V podstate je mozne kombinovat tuto logiku rozne a aplikovat nezavisle na vstupy a vystupy
      case 1:
      {
         return(Strategy_001(COMMAND));
      }
// Ide o MACD strategiu, kde sa ako vstupne a vystupne signaly vyhodnocuje MACD iba z jedneho TIMEFRAME - trailng stop
// pomocou LOW/HIGH predch. baru o adaptivnej velkosti podla prveho SL
      case 2:
      {
         return(Strategy_002(COMMAND));
      }
// Ide o MACD strategiu, kde sa ako vstupne a vystupne signaly vyhodnocuje MACD iba z jedneho TIMEFRAME - trailng stop
// pomocou LOW/HIGH predch. baru o adaptivnej velkosti podla prveho SL - rozne vstupne strategie za ucelom zvysenia efektivity
      case 3:
      {
         return(Strategy_003(COMMAND));
      }
// Ide o MACD strategiu, kde sa ako vstupne signaly vyhodnocuje MACD iba z jedneho TIMEFRAME - trailng stop
// pomocou LOW/HIGH predch. baru o adaptivnej velkosti podla prveho SL - rozne vystupne strategie za ucelom zvysenia efektivity
      case 4:
      {
         return(Strategy_004(COMMAND));
      }
// Ide o strategiu zachytenia trendu nestandardnymi metodami na urovni sviecok, prerazeni, naslednych neustale stupajucich/klesajucich  open/close atd
// vystupy su taktiez riadene podobnymi metodami 
      case 5:
      {
         return(Strategy_005(COMMAND));
      }
// Ide o strategiu dvoch MA s blizkou periodou - otvorenie/uzavretie pozicie pri prekrizeni dvoch MA
// Podporena je dlhym MA - ak je cena nad iba kupovat a opacne
// este su vstupy filtrovane pomocou MACD
      case 6:
      {
         return(Strategy_006(COMMAND));
      }
// Strategia vstupov len pri prekrizeni
      case 7:
      {
         return(Strategy_007(COMMAND));
      }
// Strategia SL a trailing stop podla fractals
// rozne vstupne strategie - filtrovanie pomocou roznych technik
      case 8:
      {
         return(Strategy_008(COMMAND));
      }
// kombinacie vstupov zo strategie 1 a stoploss zo strategie 8
      case 9:
      {
         return(Strategy_009(COMMAND));
      }
// fraktaly pre vstup, stop trailing aj vystup
      case 10:
      {
         return(Strategy_010(COMMAND));
      }
// 
      case 11:
      {
         return(Strategy_011(COMMAND));
      }
// fraktaly - macd - support/resistance levels z rovnakych aj vyssich timeframes podporene macd
      case 12:
      {
         return(Strategy_012(COMMAND));
      }
// pure macd neustale v trhu
      case 13:
      {
         return(Strategy_013(COMMAND));
      }
// fraktaly ako smernice pre suuport a resistance a ich prerazenie
      case 14:
      {
         return(Strategy_014(COMMAND));
      }
   }

   return(0);
}
//------------------------------------------------------------------//------------------------------------------------------------------
double Strategy_001(int COMMAND)
{
   string   _SYMBOL        = Symbol();
   int      _TIMEFRAME     = PERIOD_H1;
   int      _TIMEFRAME_2   = PERIOD_H1;
   int      _SLOWEMA       = 26;
   int      _FASTEMA       = 12;
   int      _MASIGNAL      = 9;
// velmi dobre:
//   int      _SHIFT         = 2;
//   int      _PRICE         = PRICE_OPEN;
   int      _SHIFT         = 0;
   int      _PRICE         = PRICE_OPEN;

   double   result         = 0;
   double   MACDHistogram, MACDHistogram2;
   double   MACDSignal, MACDSignal2;
   
   switch(COMMAND)
   {
/*
#define     _CLOSE_LONG                   1
#define     _CLOSE_SHORT                  2
#define     _OPEN_LONG                    3
#define     _OPEN_SHORT                   4
#define     _GET_LONG_STOPLOSS_PRICE      5
#define     _GET_SHORT_STOPLOSS_PRICE     6
#define     _GET_LONG_TAKEPROFIT_PRICE    7
#define     _GET_SHORT_TAKEPROFIT_PRICE   8
#define     _GET_LOTS                     9
#define     _GET_TRAILED_STOPLOSS_PRICE   10
#define     _GET_TRAILED_TAKEPROFIT_PRICE 11
#define     _GET_TRADED_TIMEFRAME         12
*/
      case _OPEN_LONG:
      {
         MACDHistogram = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT);
         MACDSignal = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT);
         
         MACDHistogram2 = iMACD(_SYMBOL, _TIMEFRAME_2, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT);
         MACDSignal2 = iMACD(_SYMBOL, _TIMEFRAME_2, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT);

// velmi dobre:
//         if(MACDHistogram > MACDSignal && MACDHistogram > 0)

//         if(MACDHistogram > MACDSignal && MACDHistogram2 > 0 && MACDSignal2 > 0 && MACDHistogram < 0 && MACDSignal < 0)
//         if(MACDHistogram > MACDSignal && MACDHistogram2 < MACDSignal2)
// celkom dobre
         if(MACDHistogram > MACDSignal && MACDHistogram2 < 0 && MACDSignal2 < 0)
//         if(MACDHistogram > MACDSignal && MACDHistogram2 > 0 && MACDSignal2 > 0 && MACDHistogram < 0)
//         if(MACDHistogram > MACDSignal && MACDHistogram2 > 0 && MACDSignal2 > 0)
            result = 1;
         
         break;
      }
      case _OPEN_SHORT:
      {
         MACDHistogram = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT);
         MACDSignal = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT);

         MACDHistogram2 = iMACD(_SYMBOL, _TIMEFRAME_2, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT);
         MACDSignal2 = iMACD(_SYMBOL, _TIMEFRAME_2, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT);

// velmi dobre:
//         if(MACDHistogram < MACDSignal && MACDHistogram < 0)

//         if(MACDHistogram < MACDSignal && MACDHistogram2 < 0 && MACDSignal2 < 0 && MACDHistogram > 0 && MACDSignal > 0)
//         if(MACDHistogram < MACDSignal && MACDHistogram2 > MACDSignal2)
// celkom dobre
         if(MACDHistogram < MACDSignal && MACDHistogram2 > 0 && MACDSignal2 > 0)
//         if(MACDHistogram < MACDSignal && MACDHistogram2 < 0 && MACDSignal2 < 0 && MACDHistogram > 0)
//         if(MACDHistogram < MACDSignal && MACDHistogram2 < 0 && MACDSignal2 < 0)
            result = 1;

         break;
      }
      case _CLOSE_LONG:
      {
         MACDHistogram = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT);
         MACDSignal = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT);
         
         if(MACDHistogram < MACDSignal)
//         if(MACDHistogram > 0 && MACDSignal > 0)
//         if(MACDHistogram > 0 && MACDSignal > 0 && MACDHistogram < MACDSignal)
            result = 1;
         
         break;
      }
      case _CLOSE_SHORT:
      {
         MACDHistogram = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT);
         MACDSignal = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT);
         
         if(MACDHistogram > MACDSignal)
//         if(MACDHistogram < 0 && MACDSignal < 0)
//         if(MACDHistogram < 0 && MACDSignal < 0 && MACDHistogram > MACDSignal)
            result = 1;

         break;
      }
      case _GET_LONG_STOPLOSS_PRICE:
      {
         break;
         
         result = iFractals(_SYMBOL, _TIMEFRAME, MODE_LOWER, 0);
         
         if(result > Ask - 10)
            result = 0;

         break;
      }
      case _GET_LONG_TAKEPROFIT_PRICE:
      {
         break;
      }
      case _GET_SHORT_STOPLOSS_PRICE:
      {
         break;
         
         result = iFractals(_SYMBOL, _TIMEFRAME, MODE_UPPER, 0);
         
         if(result < Bid + 10)
            result = 0;
         
         break;
      }
      case _GET_SHORT_TAKEPROFIT_PRICE:
      {
         break;
      }
      case _GET_TRAILED_STOPLOSS_PRICE:
      {
         break;
         
         if(OrdersTotal() == 1)
         {
            OrderSelect(0, SELECT_BY_POS);
            if(OrderMagicNumber() != _MAGICNUMBER)
               break;
            if(OrderProfit() > 0)
            {
               if(OrderType() == OP_BUY)
                  result = iLow(_SYMBOL, _TIMEFRAME, 1);
               else
                  result = iHigh(_SYMBOL, _TIMEFRAME, 1);
            }
         }
         
         break;
      }
      case _GET_TRAILED_TAKEPROFIT_PRICE:
      {
         break;
      }
      case _GET_LOTS:
      {
         result = 0.1;
         break;
      }
      case _GET_TRADED_TIMEFRAME:
      {
         result = _TIMEFRAME;
         break;
      }
   }
      
   return(result);
}
//------------------------------------------------------------------//------------------------------------------------------------------
double Strategy_002(int COMMAND)
{
   string   _SYMBOL        = Symbol();
   int      _TIMEFRAME     = Period();
   int      _SLOWEMA       = 26;
   int      _FASTEMA       = 12;
   int      _MASIGNAL      = 9;
// velmi dobre:
//   int      _SHIFT         = 2;
//   int      _PRICE         = PRICE_OPEN;
   int      _SHIFT         = 0;
   int      _PRICE         = PRICE_OPEN;

   double   result         = 0;
   double   MACDHistogram;
   double   MACDSignal;
   
   switch(COMMAND)
   {
/*
#define     _CLOSE_LONG                   1
#define     _CLOSE_SHORT                  2
#define     _OPEN_LONG                    3
#define     _OPEN_SHORT                   4
#define     _GET_LONG_STOPLOSS_PRICE      5
#define     _GET_SHORT_STOPLOSS_PRICE     6
#define     _GET_LONG_TAKEPROFIT_PRICE    7
#define     _GET_SHORT_TAKEPROFIT_PRICE   8
#define     _GET_LOTS                     9
#define     _GET_TRAILED_STOPLOSS_PRICE   10
#define     _GET_TRAILED_TAKEPROFIT_PRICE 11
#define     _GET_TRADED_TIMEFRAME         12
*/
      case _OPEN_LONG:
      {
         MACDHistogram = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT);
         MACDSignal = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT);

//         if(MACDHistogram > MACDSignal && MACDHistogram > 0)
         if(MACDHistogram > MACDSignal)
            result = 1;
         
         break;
      }
      case _OPEN_SHORT:
      {
         MACDHistogram = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT);
         MACDSignal = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT);

//         if(MACDHistogram < MACDSignal && MACDHistogram < 0)
         if(MACDHistogram < MACDSignal)
            result = 1;

         break;
      }
      case _CLOSE_LONG:
      {
         MACDHistogram = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT);
         MACDSignal = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT);
         
//         if(MACDHistogram < 0)
//         if(MACDHistogram < MACDSignal)
//         if(MACDHistogram > 0 && MACDSignal > 0)
//         if(MACDHistogram > 0 && MACDSignal > 0 && MACDHistogram < MACDSignal)
//            result = 1;
         
         break;
      }
      case _CLOSE_SHORT:
      {
         MACDHistogram = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT);
         MACDSignal = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT);
         
//         if(MACDHistogram > 0)
//         if(MACDHistogram > MACDSignal)
//         if(MACDHistogram < 0 && MACDSignal < 0)
//         if(MACDHistogram < 0 && MACDSignal < 0 && MACDHistogram > MACDSignal)
//            result = 1;

         break;
      }
      case _GET_LONG_STOPLOSS_PRICE:
      {
//         result = iFractals(_SYMBOL, _TIMEFRAME, MODE_LOWER, 1);
         result = iLow(_SYMBOL, _TIMEFRAME, 1);

         if(result > Ask - 10*Point)
            result = Ask - 10*Point;

         break;
      }
      case _GET_LONG_TAKEPROFIT_PRICE:
      {
         break;
      }
      case _GET_SHORT_STOPLOSS_PRICE:
      {
//         result = iFractals(_SYMBOL, _TIMEFRAME, MODE_UPPER, 1);
         result = iHigh(_SYMBOL, _TIMEFRAME, 1);

         if(result < Bid + 10*Point)
            result = Bid + 10*Point;
         
         break;
      }
      case _GET_SHORT_TAKEPROFIT_PRICE:
      {
         break;
      }
      case _GET_TRAILED_STOPLOSS_PRICE:
      {
         if(OrdersTotal() == 1)
         {
            OrderSelect(0, SELECT_BY_POS);
            if(OrderMagicNumber() != _MAGICNUMBER)
               break;
            if(OrderProfit() > 0)
            {
               if(OrderType() == OP_BUY)
               {
                  int i = iBarShift(_SYMBOL, _TIMEFRAME, OrderOpenTime());
                  
                  double Low1SL = iLow(_SYMBOL, _TIMEFRAME, 1);
                  double Low2SL = Bid - MathAbs(OrderOpenPrice() - iLow(_SYMBOL, _TIMEFRAME, i + 1));

                  if(Low1SL < Low2SL)
                     result = Low1SL;
                  else
                     result = Low2SL;
                  
                  if(result > Bid - 10*Point)
                     result = Bid - 10*Point;
                  
                  if(result <= OrderStopLoss())
                     result = 0;                  
               }
               else
               {
                  int j = iBarShift(_SYMBOL, _TIMEFRAME, OrderOpenTime());

                  double High1SL = iHigh(_SYMBOL, _TIMEFRAME, 1);
                  double High2SL = Ask + MathAbs(iHigh(_SYMBOL, _TIMEFRAME, j + 1) - OrderOpenPrice());
                  
                  if(High1SL > High2SL)
                     result = High1SL;
                  else
                     result = High2SL;
                  
                  if(result < Ask + 10*Point)
                     result = Ask + 10*Point;
                  if(result >= OrderStopLoss())
                     result = 0;
               }
            }
         }
         
         break;
      }
      case _GET_TRAILED_TAKEPROFIT_PRICE:
      {
         break;
      }
      case _GET_LOTS:
      {
         result = 0.1;
         break;
      }
      case _GET_TRADED_TIMEFRAME:
      {
         result = _TIMEFRAME;
         break;
      }
   }
      
   return(result);
}
//------------------------------------------------------------------//------------------------------------------------------------------
double Strategy_003(int COMMAND)
{
   string   _SYMBOL        = Symbol();
   int      _TIMEFRAME     = Period();
   int      _SLOWEMA       = 26;
   int      _FASTEMA       = 12;
   int      _MASIGNAL      = 9;
// velmi dobre:
//   int      _SHIFT         = 2;
//   int      _PRICE         = PRICE_OPEN;
   int      _SHIFT         = 0;
   int      _PRICE         = PRICE_OPEN;

   double   result         = 0;
   double   MACDHistogram;
   double   MACDSignal;
   
   switch(COMMAND)
   {
/*
#define     _CLOSE_LONG                   1
#define     _CLOSE_SHORT                  2
#define     _OPEN_LONG                    3
#define     _OPEN_SHORT                   4
#define     _GET_LONG_STOPLOSS_PRICE      5
#define     _GET_SHORT_STOPLOSS_PRICE     6
#define     _GET_LONG_TAKEPROFIT_PRICE    7
#define     _GET_SHORT_TAKEPROFIT_PRICE   8
#define     _GET_LOTS                     9
#define     _GET_TRAILED_STOPLOSS_PRICE   10
#define     _GET_TRAILED_TAKEPROFIT_PRICE 11
#define     _GET_TRADED_TIMEFRAME         12
*/
      case _OPEN_LONG:
      {
         MACDHistogram = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT);
         MACDSignal = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT);

         if(MACDHistogram > MACDSignal && MACDHistogram > 0)
//         if(MACDHistogram > MACDSignal && MACDHistogram < 0)
//         if(MACDHistogram > MACDSignal)
            result = 1;
         
         break;
      }
      case _OPEN_SHORT:
      {
         MACDHistogram = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT);
         MACDSignal = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT);

         if(MACDHistogram < MACDSignal && MACDHistogram < 0)
//         if(MACDHistogram < MACDSignal && MACDHistogram > 0)
//         if(MACDHistogram < MACDSignal)
            result = 1;

         break;
      }
      case _CLOSE_LONG:
      {
         MACDHistogram = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT);
         MACDSignal = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT);
         
//         if(MACDHistogram < 0)
//         if(MACDHistogram < MACDSignal)
//         if(MACDHistogram > 0 && MACDSignal > 0)
//         if(MACDHistogram > 0 && MACDSignal > 0 && MACDHistogram < MACDSignal)
//            result = 1;
         
         break;
      }
      case _CLOSE_SHORT:
      {
         MACDHistogram = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT);
         MACDSignal = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT);
         
//         if(MACDHistogram > 0)
//         if(MACDHistogram > MACDSignal)
//         if(MACDHistogram < 0 && MACDSignal < 0)
//         if(MACDHistogram < 0 && MACDSignal < 0 && MACDHistogram > MACDSignal)
//            result = 1;

         break;
      }
      case _GET_LONG_STOPLOSS_PRICE:
      {
//         result = iFractals(_SYMBOL, _TIMEFRAME, MODE_LOWER, 1);
         result = iLow(_SYMBOL, _TIMEFRAME, 1);

         if(result > Ask - 10*Point)
            result = Ask - 10*Point;

         break;
      }
      case _GET_LONG_TAKEPROFIT_PRICE:
      {
         break;
      }
      case _GET_SHORT_STOPLOSS_PRICE:
      {
//         result = iFractals(_SYMBOL, _TIMEFRAME, MODE_UPPER, 1);
         result = iHigh(_SYMBOL, _TIMEFRAME, 1);

         if(result < Bid + 10*Point)
            result = Bid + 10*Point;
         
         break;
      }
      case _GET_SHORT_TAKEPROFIT_PRICE:
      {
         break;
      }
      case _GET_TRAILED_STOPLOSS_PRICE:
      {
         if(OrdersTotal() == 1)
         {
            OrderSelect(0, SELECT_BY_POS);
            if(OrderMagicNumber() != _MAGICNUMBER)
               break;
            if(OrderProfit() > 0)
            {
               if(OrderType() == OP_BUY)
               {
                  int i = iBarShift(_SYMBOL, _TIMEFRAME, OrderOpenTime());
                  
                  double Low1SL = iLow(_SYMBOL, _TIMEFRAME, 1);
                  double Low2SL = Bid - MathAbs(OrderOpenPrice() - iLow(_SYMBOL, _TIMEFRAME, i + 1));

                  if(Low1SL < Low2SL)
                     result = Low1SL;
                  else
                     result = Low2SL;
                  
                  if(result > Bid - 10*Point)
                     result = Bid - 10*Point;
                  
                  if(result <= OrderStopLoss())
                     result = 0;
               }
               else
               {
                  int j = iBarShift(_SYMBOL, _TIMEFRAME, OrderOpenTime());

                  double High1SL = iHigh(_SYMBOL, _TIMEFRAME, 1);
                  double High2SL = Ask + MathAbs(iHigh(_SYMBOL, _TIMEFRAME, j + 1) - OrderOpenPrice());
                  
                  if(High1SL > High2SL)
                     result = High1SL;
                  else
                     result = High2SL;
                  
                  if(result < Ask + 10*Point)
                     result = Ask + 10*Point;
                  if(result >= OrderStopLoss())
                     result = 0;
               }
            }
         }
         
         break;
      }
      case _GET_TRAILED_TAKEPROFIT_PRICE:
      {
         break;
      }
      case _GET_LOTS:
      {
         result = 0.1;
         break;
      }
      case _GET_TRADED_TIMEFRAME:
      {
         result = _TIMEFRAME;
         break;
      }
   }
      
   return(result);
}
//------------------------------------------------------------------//------------------------------------------------------------------
double Strategy_004(int COMMAND)
{
   string   _SYMBOL        = Symbol();
   int      _TIMEFRAME     = Period();
   int      _SLOWEMA       = 26;
   int      _FASTEMA       = 12;
   int      _MASIGNAL      = 9;
   int      _SHIFT         = 0;
   int      _PRICE         = PRICE_OPEN;

   double   result         = 0;

   double   MACDHistogram;
   double   MACDSignal;
      
   switch(COMMAND)
   {
/*
#define     _CLOSE_LONG                   1
#define     _CLOSE_SHORT                  2
#define     _OPEN_LONG                    3
#define     _OPEN_SHORT                   4
#define     _GET_LONG_STOPLOSS_PRICE      5
#define     _GET_SHORT_STOPLOSS_PRICE     6
#define     _GET_LONG_TAKEPROFIT_PRICE    7
#define     _GET_SHORT_TAKEPROFIT_PRICE   8
#define     _GET_LOTS                     9
#define     _GET_TRAILED_STOPLOSS_PRICE   10
#define     _GET_TRAILED_TAKEPROFIT_PRICE 11
#define     _GET_TRADED_TIMEFRAME         12
*/
      case _OPEN_LONG:
      {
         MACDHistogram = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT);
         MACDSignal = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT);

         if(MACDHistogram > MACDSignal && MACDHistogram < 0)
//         if(MACDHistogram > 0)
            result = 1;
         
         break;
      }
      case _OPEN_SHORT:
      {
         MACDHistogram = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT);
         MACDSignal = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT);

         if(MACDHistogram < MACDSignal && MACDHistogram > 0)
//         if(MACDHistogram < 0)
            result = 1;

         break;
      }
      case _CLOSE_LONG:
      {
         MACDHistogram = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT);
         MACDSignal = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT);
   
         if(MACDHistogram < MACDSignal)
//         if(MACDHistogram < 0)
            result = 1;
         
         break;
      }
      case _CLOSE_SHORT:
      {
         MACDHistogram = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT);
         MACDSignal = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT);
         
         if(MACDHistogram > MACDSignal)
//         if(MACDHistogram > 0)
            result = 1;

         break;
      }
      case _GET_LONG_STOPLOSS_PRICE:
      {
         break;
      }
      case _GET_TRAILED_TAKEPROFIT_PRICE:
      {
         break;
      }
      case _GET_LOTS:
      {
         result = 0.1;
         break;
      }
      case _GET_TRADED_TIMEFRAME:
      {
         result = _TIMEFRAME;
         break;
      }
   }
      
   return(result);
}
//------------------------------------------------------------------//------------------------------------------------------------------
double Strategy_005(int COMMAND)
{
   string   _SYMBOL        = Symbol();
   int      _TIMEFRAME     = Period();
   int      _SLOWEMA       = 26;
   int      _FASTEMA       = 12;
   int      _MASIGNAL      = 9;
   int      _SHIFT         = 0;
   int      _PRICE         = PRICE_OPEN;

   double   result         = 0;

//   int      TIMEFRAME2 = _TIMEFRAME;
   int      TIMEFRAME2 = HigherTimeframe(_TIMEFRAME);
//   int      TIMEFRAME2 = HigherTimeframe(HigherTimeframe(_TIMEFRAME));

   double   MACDHistogram;
   double   MACDSignal;

   switch(COMMAND)
   {
/*
#define     _CLOSE_LONG                   1
#define     _CLOSE_SHORT                  2
#define     _OPEN_LONG                    3
#define     _OPEN_SHORT                   4
#define     _GET_LONG_STOPLOSS_PRICE      5
#define     _GET_SHORT_STOPLOSS_PRICE     6
#define     _GET_LONG_TAKEPROFIT_PRICE    7
#define     _GET_SHORT_TAKEPROFIT_PRICE   8
#define     _GET_LOTS                     9
#define     _GET_TRAILED_STOPLOSS_PRICE   10
#define     _GET_TRAILED_TAKEPROFIT_PRICE 11
#define     _GET_TRADED_TIMEFRAME         12
*/
      case _OPEN_LONG:
      {
         MACDHistogram = iMACD(_SYMBOL, TIMEFRAME2, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT);
         MACDSignal = iMACD(_SYMBOL, TIMEFRAME2, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT);
//         MACDHistogram = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT);
//         MACDSignal = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT);

         if(MACDHistogram > MACDSignal && MACDHistogram < 0)
//         if(MACDHistogram > MACDSignal)
//         if(MACDHistogram > 0)
//         if(Open[0] > Open[1] && Open[1] > Open[2] && Open[2] > Open[3])
         if(Open[0] > Open[1] && Open[1] > Open[2])
//         if(Open[0] > Open[3])
         if(Open[0] > Low[1] && Low[1] > Low[2])
            result = 1;
                  
         break;
      }
      case _OPEN_SHORT:
      {
         MACDHistogram = iMACD(_SYMBOL, TIMEFRAME2, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT);
         MACDSignal = iMACD(_SYMBOL, TIMEFRAME2, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT);
//         MACDHistogram = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT);
//         MACDSignal = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT);

         if(MACDHistogram < MACDSignal && MACDHistogram > 0)
//         if(MACDHistogram < MACDSignal)
//         if(MACDHistogram < 0)
//         if(Open[0] < Open[1] && Open[1] < Open[2] && Open[2] < Open[3])
         if(Open[0] < Open[1] && Open[1] < Open[2])
//         if(Open[0] < Open[3])
         if(Open[0] < High[1] && High[1] < High[2])
            result = 1;
         
         break;
      }
      case _CLOSE_LONG:
      {
         if(iOpen(_SYMBOL, TIMEFRAME2, 0) < iOpen(_SYMBOL, TIMEFRAME2, 1))
            result = 1;
         if(iClose(_SYMBOL, TIMEFRAME2, 1) < iClose(_SYMBOL, TIMEFRAME2, 2))
            result = 1;
/*
         if(iOpen(_SYMBOL, _TIMEFRAME, 0) < iOpen(_SYMBOL, _TIMEFRAME, 1))
            result = 1;
         if(iClose(_SYMBOL, _TIMEFRAME, 1) < iClose(_SYMBOL, _TIMEFRAME, 2))
            result = 1;
*/         
         break;
      }
      case _CLOSE_SHORT:
      {
         if(iOpen(_SYMBOL, TIMEFRAME2, 0) > iOpen(_SYMBOL, TIMEFRAME2, 1))
            result = 1;
         if(iClose(_SYMBOL, TIMEFRAME2, 1) > iClose(_SYMBOL, TIMEFRAME2, 2))
            result = 1;
/*
         if(iOpen(_SYMBOL, _TIMEFRAME, 0) > iOpen(_SYMBOL, _TIMEFRAME, 1))
            result = 1;
         if(iClose(_SYMBOL, _TIMEFRAME, 1) > iClose(_SYMBOL, _TIMEFRAME, 2))
            result = 1;
*/
         break;
      }
      case _GET_LONG_STOPLOSS_PRICE:
      {
//         result = iFractals(_SYMBOL, _TIMEFRAME, MODE_LOWER, 1);
         result = iLow(_SYMBOL, _TIMEFRAME, 1);

         if(result > Ask - 10*Point)
            result = Ask - 10*Point;

         break;
      }
      case _GET_LONG_TAKEPROFIT_PRICE:
      {
         break;
      }
      case _GET_SHORT_STOPLOSS_PRICE:
      {
//         result = iFractals(_SYMBOL, _TIMEFRAME, MODE_UPPER, 1);
         result = iHigh(_SYMBOL, _TIMEFRAME, 1);

         if(result < Bid + 10*Point)
            result = Bid + 10*Point;
         
         break;
      }
      case _GET_SHORT_TAKEPROFIT_PRICE:
      {
         break;
      }
      case _GET_TRAILED_STOPLOSS_PRICE:
      {
         if(OrdersTotal() == 1)
         {
            OrderSelect(0, SELECT_BY_POS);
            if(OrderMagicNumber() != _MAGICNUMBER)
               break;
            if(OrderProfit() > 0)
            {
               if(OrderType() == OP_BUY)
               {
                  int i = iBarShift(_SYMBOL, _TIMEFRAME, OrderOpenTime());
                  
                  double Low1SL = iLow(_SYMBOL, _TIMEFRAME, 1);
                  double Low2SL = Bid - MathAbs(OrderOpenPrice() - iLow(_SYMBOL, _TIMEFRAME, i + 1));

                  if(Low1SL < Low2SL)
                     result = Low1SL;
                  else
                     result = Low2SL;
                  
                  if(result > Bid - 10*Point)
                     result = Bid - 10*Point;
                  
                  if(result <= OrderStopLoss())
                     result = 0;
               }
               else
               {
                  int j = iBarShift(_SYMBOL, _TIMEFRAME, OrderOpenTime());

                  double High1SL = iHigh(_SYMBOL, _TIMEFRAME, 1);
                  double High2SL = Ask + MathAbs(iHigh(_SYMBOL, _TIMEFRAME, j + 1) - OrderOpenPrice());
                  
                  if(High1SL > High2SL)
                     result = High1SL;
                  else
                     result = High2SL;
                  
                  if(result < Ask + 10*Point)
                     result = Ask + 10*Point;
                  if(result >= OrderStopLoss())
                     result = 0;
               }
            }
         }
         
         break;
      }      
      case _GET_TRAILED_TAKEPROFIT_PRICE:
      {
         break;
      }
      case _GET_LOTS:
      {
         result = 0.1;
         break;
      }
      case _GET_TRADED_TIMEFRAME:
      {
         result = _TIMEFRAME;
         break;
      }
   }
      
   return(result);
}
//------------------------------------------------------------------//------------------------------------------------------------------
double Strategy_006(int COMMAND)
{
   string   _SYMBOL        = Symbol();
   int      _TIMEFRAME     = Period();
   int      _SLOWEMA       = 26;
   int      _FASTEMA       = 12;
   int      _MASIGNAL      = 9;
   int      _MAMETHOD      = MODE_EMA;
   int      _SLOWMA        = 20;
   int      _FASTMA        = 10;
   int      _LONGMA        = LONGMA;
   int      _SHIFT         = 0;
   int      _PRICE         = PRICE_OPEN;

   double   result         = 0;

   double   MAFast;
   double   MASlow;
   double   MALong;
   double   MALong1;
   double   MACDHistogram;
   double   MACDSignal;

   switch(COMMAND)
   {
/*
#define     _CLOSE_LONG                   1
#define     _CLOSE_SHORT                  2
#define     _OPEN_LONG                    3
#define     _OPEN_SHORT                   4
#define     _GET_LONG_STOPLOSS_PRICE      5
#define     _GET_SHORT_STOPLOSS_PRICE     6
#define     _GET_LONG_TAKEPROFIT_PRICE    7
#define     _GET_SHORT_TAKEPROFIT_PRICE   8
#define     _GET_LOTS                     9
#define     _GET_TRAILED_STOPLOSS_PRICE   10
#define     _GET_TRAILED_TAKEPROFIT_PRICE 11
#define     _GET_TRADED_TIMEFRAME         12
*/
      case _OPEN_LONG:
      {
         MAFast = iMA(_SYMBOL, _TIMEFRAME, _FASTMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MASlow = iMA(_SYMBOL, _TIMEFRAME, _SLOWMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MALong = iMA(_SYMBOL, _TIMEFRAME, _LONGMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MALong1 = iMA(_SYMBOL, _TIMEFRAME, _LONGMA, 0, _MAMETHOD, _PRICE, _SHIFT + 1);

         MACDHistogram = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT);
         MACDSignal = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT);

         if(MAFast > MASlow)
         if(Ask > MALong)
//         if(MAFast > MALong)
//         if(MALong1 < MALong)
         if(MACDHistogram > MACDSignal)
         if(MACDHistogram < 0)
//         if(MACDHistogram > 0)
            result = 1;
                  
         break;
      }
      case _OPEN_SHORT:
      {
         MAFast = iMA(_SYMBOL, _TIMEFRAME, _FASTMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MASlow = iMA(_SYMBOL, _TIMEFRAME, _SLOWMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MALong = iMA(_SYMBOL, _TIMEFRAME, _LONGMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MALong1 = iMA(_SYMBOL, _TIMEFRAME, _LONGMA, 0, _MAMETHOD, _PRICE, _SHIFT + 1);

         MACDHistogram = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT);
         MACDSignal = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT);

         if(MAFast < MASlow)
         if(Bid < MALong)
//         if(MAFast < MALong)
//         if(MALong1 > MALong)
         if(MACDHistogram < MACDSignal)
         if(MACDHistogram > 0)
//         if(MACDHistogram < 0)
            result = 1;
                  
         break;
      }
      case _CLOSE_LONG:
      {
         MAFast = iMA(_SYMBOL, _TIMEFRAME, _FASTMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MASlow = iMA(_SYMBOL, _TIMEFRAME, _SLOWMA, 0, _MAMETHOD, _PRICE, _SHIFT);

         if(MAFast < MASlow)
            result = 1;
                  
         break;
      }
      case _CLOSE_SHORT:
      {
         MAFast = iMA(_SYMBOL, _TIMEFRAME, _FASTMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MASlow = iMA(_SYMBOL, _TIMEFRAME, _SLOWMA, 0, _MAMETHOD, _PRICE, _SHIFT);

         if(MAFast > MASlow)
            result = 1;
                  
         break;
      }
      case _GET_LONG_STOPLOSS_PRICE:
      {
         break;

//         result = iFractals(_SYMBOL, _TIMEFRAME, MODE_LOWER, 1);
         result = iLow(_SYMBOL, _TIMEFRAME, 1);

         if(result > Ask - 10*Point)
            result = Ask - 10*Point;

         break;
      }
      case _GET_LONG_TAKEPROFIT_PRICE:
      {
         break;
      }
      case _GET_SHORT_STOPLOSS_PRICE:
      {
         break;

//         result = iFractals(_SYMBOL, _TIMEFRAME, MODE_UPPER, 1);
         result = iHigh(_SYMBOL, _TIMEFRAME, 1);

         if(result < Bid + 10*Point)
            result = Bid + 10*Point;
         
         break;
      }
      case _GET_SHORT_TAKEPROFIT_PRICE:
      {
         break;
      }
      case _GET_TRAILED_STOPLOSS_PRICE:
      {
         break;

         if(OrdersTotal() == 1)
         {
            OrderSelect(0, SELECT_BY_POS);
            if(OrderMagicNumber() != _MAGICNUMBER)
               break;
            if(OrderProfit() > 0)
            {
               if(OrderType() == OP_BUY)
               {
                  int i = iBarShift(_SYMBOL, _TIMEFRAME, OrderOpenTime());
                  
                  double Low1SL = iLow(_SYMBOL, _TIMEFRAME, 1);
                  double Low2SL = Bid - MathAbs(OrderOpenPrice() - iLow(_SYMBOL, _TIMEFRAME, i + 1));

                  if(Low1SL < Low2SL)
                     result = Low1SL;
                  else
                     result = Low2SL;
                  
                  if(result > Bid - 10*Point)
                     result = Bid - 10*Point;
                  
                  if(result <= OrderStopLoss())
                     result = 0;
               }
               else
               {
                  int j = iBarShift(_SYMBOL, _TIMEFRAME, OrderOpenTime());

                  double High1SL = iHigh(_SYMBOL, _TIMEFRAME, 1);
                  double High2SL = Ask + MathAbs(iHigh(_SYMBOL, _TIMEFRAME, j + 1) - OrderOpenPrice());
                  
                  if(High1SL > High2SL)
                     result = High1SL;
                  else
                     result = High2SL;
                  
                  if(result < Ask + 10*Point)
                     result = Ask + 10*Point;
                  if(result >= OrderStopLoss())
                     result = 0;
               }
            }
         }
         
         break;
      }      
      case _GET_TRAILED_TAKEPROFIT_PRICE:
      {
         break;
      }
      case _GET_LOTS:
      {
         result = 0.1;
//         result = GetLots(_MM_FIX_PERC_AVG_LAST_PROFIT, 0.2);
         break;
      }
      case _GET_TRADED_TIMEFRAME:
      {
         result = _TIMEFRAME;
         break;
      }
   }
      
   return(result);
}
//------------------------------------------------------------------//------------------------------------------------------------------
double Strategy_007(int COMMAND)
{
   string   _SYMBOL        = Symbol();
   int      _TIMEFRAME     = Period();
   int      _SLOWEMA       = 26;
   int      _FASTEMA       = 12;
   int      _MASIGNAL      = 9;
   int      _MAMETHOD      = MODE_EMA;
   int      _SLOWMA        = 20;
   int      _FASTMA        = 10;
   int      _LONGMA        = LONGMA;
   int      _SHIFT         = 0;
   int      _PRICE         = PRICE_OPEN;

   double   result         = 0;

   double   MAFast;
   double   MASlow;
   double   MALong;
   double   MACDHistogram;
   double   MACDSignal;
   double   MAFast1;
   double   MASlow1;
   double   MALong1;
   double   MACDHistogram1;
   double   MACDSignal1;

   int      i;

   switch(COMMAND)
   {
/*
#define     _CLOSE_LONG                   1
#define     _CLOSE_SHORT                  2
#define     _OPEN_LONG                    3
#define     _OPEN_SHORT                   4
#define     _GET_LONG_STOPLOSS_PRICE      5
#define     _GET_SHORT_STOPLOSS_PRICE     6
#define     _GET_LONG_TAKEPROFIT_PRICE    7
#define     _GET_SHORT_TAKEPROFIT_PRICE   8
#define     _GET_LOTS                     9
#define     _GET_TRAILED_STOPLOSS_PRICE   10
#define     _GET_TRAILED_TAKEPROFIT_PRICE 11
#define     _GET_TRADED_TIMEFRAME         12
*/
      case _OPEN_LONG:
      {
         MAFast = iMA(_SYMBOL, _TIMEFRAME, _FASTMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MASlow = iMA(_SYMBOL, _TIMEFRAME, _SLOWMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MAFast1 = iMA(_SYMBOL, _TIMEFRAME, _FASTMA, 0, _MAMETHOD, _PRICE, _SHIFT + 1);
         MASlow1 = iMA(_SYMBOL, _TIMEFRAME, _SLOWMA, 0, _MAMETHOD, _PRICE, _SHIFT + 1);
         MALong = iMA(_SYMBOL, _TIMEFRAME, _LONGMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MALong1 = iMA(_SYMBOL, _TIMEFRAME, _LONGMA, 0, _MAMETHOD, _PRICE, _SHIFT + 1);

         MACDHistogram = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT);
         MACDSignal = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT);
         MACDHistogram1 = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT + 1);
         MACDSignal1 = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT + 1);

//         if(MAFast1 < MASlow1 && MAFast > MASlow)
         if(Ask > MALong)
//         if(MAFast > MALong)
         if(MALong1 < MALong)
         if(MACDHistogram1 <= MACDSignal1 && MACDHistogram > MACDSignal)
         if(MACDHistogram < 0)
//         if(MACDHistogram > 0)
            result = 1;
                  
         break;
      }
      case _OPEN_SHORT:
      {
         MAFast = iMA(_SYMBOL, _TIMEFRAME, _FASTMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MASlow = iMA(_SYMBOL, _TIMEFRAME, _SLOWMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MAFast1 = iMA(_SYMBOL, _TIMEFRAME, _FASTMA, 0, _MAMETHOD, _PRICE, _SHIFT + 1);
         MASlow1 = iMA(_SYMBOL, _TIMEFRAME, _SLOWMA, 0, _MAMETHOD, _PRICE, _SHIFT + 1);
         MALong = iMA(_SYMBOL, _TIMEFRAME, _LONGMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MALong1 = iMA(_SYMBOL, _TIMEFRAME, _LONGMA, 0, _MAMETHOD, _PRICE, _SHIFT + 1);

         MACDHistogram = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT);
         MACDSignal = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT);
         MACDHistogram1 = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT + 1);
         MACDSignal1 = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT + 1);

//         if(MAFast1 > MASlow1 && MAFast < MASlow)
         if(Bid < MALong)
//         if(MAFast < MALong)
         if(MALong1 > MALong)
         if(MACDHistogram1 >= MACDSignal1 && MACDHistogram < MACDSignal)
         if(MACDHistogram > 0)
//         if(MACDHistogram < 0)
            result = 1;
                  
         break;
      }
      case _CLOSE_LONG:
      {
         MAFast = iMA(_SYMBOL, _TIMEFRAME, _FASTMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MASlow = iMA(_SYMBOL, _TIMEFRAME, _SLOWMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MAFast1 = iMA(_SYMBOL, _TIMEFRAME, _FASTMA, 0, _MAMETHOD, _PRICE, _SHIFT + 1);
         MASlow1 = iMA(_SYMBOL, _TIMEFRAME, _SLOWMA, 0, _MAMETHOD, _PRICE, _SHIFT + 1);
         MALong = iMA(_SYMBOL, _TIMEFRAME, _LONGMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MALong1 = iMA(_SYMBOL, _TIMEFRAME, _LONGMA, 0, _MAMETHOD, _PRICE, _SHIFT + 1);

         MACDHistogram = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT);
         MACDSignal = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT);
         MACDHistogram1 = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT + 1);
         MACDSignal1 = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT + 1);


//         if(MAFast < MASlow)
//            result = 1;
                  
         break;
      }
      case _CLOSE_SHORT:
      {
         MAFast = iMA(_SYMBOL, _TIMEFRAME, _FASTMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MASlow = iMA(_SYMBOL, _TIMEFRAME, _SLOWMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MAFast1 = iMA(_SYMBOL, _TIMEFRAME, _FASTMA, 0, _MAMETHOD, _PRICE, _SHIFT + 1);
         MASlow1 = iMA(_SYMBOL, _TIMEFRAME, _SLOWMA, 0, _MAMETHOD, _PRICE, _SHIFT + 1);
         MALong = iMA(_SYMBOL, _TIMEFRAME, _LONGMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MALong1 = iMA(_SYMBOL, _TIMEFRAME, _LONGMA, 0, _MAMETHOD, _PRICE, _SHIFT + 1);

         MACDHistogram = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT);
         MACDSignal = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT);
         MACDHistogram1 = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT + 1);
         MACDSignal1 = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT + 1);


//         if(MAFast > MASlow)
//            result = 1;
                  
         break;
      }
      case _GET_LONG_STOPLOSS_PRICE:
      {
//         break;

         result = getLastFractalValue(_SYMBOL, _TIMEFRAME, false);
//         result = iLow(_SYMBOL, _TIMEFRAME, 1);

         if(result > Ask - 10*Point)
            result = Ask - 10*Point;

         break;
      }
      case _GET_LONG_TAKEPROFIT_PRICE:
      {
         break;
      }
      case _GET_SHORT_STOPLOSS_PRICE:
      {
//         break;

           result = getLastFractalValue(_SYMBOL, _TIMEFRAME, true);
//         result = iHigh(_SYMBOL, _TIMEFRAME, 1);

         if(result < Bid + 10*Point)
            result = Bid + 10*Point;
         
         break;
      }
      case _GET_SHORT_TAKEPROFIT_PRICE:
      {
         break;
      }
      case _GET_TRAILED_STOPLOSS_PRICE:
      {
//         break;

         if(OrdersTotal() == 1)
         {
            OrderSelect(0, SELECT_BY_POS);
            if(OrderMagicNumber() != _MAGICNUMBER)
               break;
            if(OrderProfit() > 0)
            {
               if(OrderType() == OP_BUY)
               {
                  result = getLastFractalValue(_SYMBOL, _TIMEFRAME, false);
                  
                  if(result > Bid - 10*Point)
                     result = Bid - 10*Point;
                  
                  if(result <= OrderStopLoss())
                     result = 0;
               }
               else
               {
                  result = getLastFractalValue(_SYMBOL, _TIMEFRAME, true);
                  
                  if(result < Ask + 10*Point)
                     result = Ask + 10*Point;
                     
                  if(result >= OrderStopLoss())
                     result = 0;
               }
            }
         }
         
         break;
      }      
      case _GET_TRAILED_TAKEPROFIT_PRICE:
      {
         break;
      }
      case _GET_LOTS:
      {
         result = 0.1;
//         result = GetLots(_MM_FIX_PERC_AVG_LAST_PROFIT, 0.2);
         break;
      }
      case _GET_TRADED_TIMEFRAME:
      {
         result = _TIMEFRAME;
         break;
      }
   }
      
   return(result);
}
//------------------------------------------------------------------//------------------------------------------------------------------
double Strategy_008(int COMMAND)
{
   string   _SYMBOL        = Symbol();
   int      _TIMEFRAME     = Period();
   int      _SLOWEMA       = 26;
   int      _FASTEMA       = 12;
   int      _MASIGNAL      = 9;
   int      _MAMETHOD      = MODE_EMA;
   int      _SLOWMA        = 20;
   int      _FASTMA        = 10;
   int      _LONGMA        = LONGMA;
   int      _SHIFT         = 0;
   int      _PRICE         = PRICE_OPEN;

   double   result         = 0;

   double   MAFast;
   double   MASlow;
   double   MALong;
   double   MACDHistogram;
   double   MACDSignal;
   double   MAFast1;
   double   MASlow1;
   double   MALong1;
   double   MACDHistogram1;
   double   MACDSignal1;

   int      i;

   switch(COMMAND)
   {
/*
#define     _CLOSE_LONG                   1
#define     _CLOSE_SHORT                  2
#define     _OPEN_LONG                    3
#define     _OPEN_SHORT                   4
#define     _GET_LONG_STOPLOSS_PRICE      5
#define     _GET_SHORT_STOPLOSS_PRICE     6
#define     _GET_LONG_TAKEPROFIT_PRICE    7
#define     _GET_SHORT_TAKEPROFIT_PRICE   8
#define     _GET_LOTS                     9
#define     _GET_TRAILED_STOPLOSS_PRICE   10
#define     _GET_TRAILED_TAKEPROFIT_PRICE 11
#define     _GET_TRADED_TIMEFRAME         12
*/
      case _OPEN_LONG:
      {
         MAFast = iMA(_SYMBOL, _TIMEFRAME, _FASTMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MASlow = iMA(_SYMBOL, _TIMEFRAME, _SLOWMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MAFast1 = iMA(_SYMBOL, _TIMEFRAME, _FASTMA, 0, _MAMETHOD, _PRICE, _SHIFT + 1);
         MASlow1 = iMA(_SYMBOL, _TIMEFRAME, _SLOWMA, 0, _MAMETHOD, _PRICE, _SHIFT + 1);
         MALong = iMA(_SYMBOL, _TIMEFRAME, _LONGMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MALong1 = iMA(_SYMBOL, _TIMEFRAME, _LONGMA, 0, _MAMETHOD, _PRICE, _SHIFT + 1);

         MACDHistogram = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT);
         MACDSignal = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT);
         MACDHistogram1 = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT + 1);
         MACDSignal1 = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT + 1);

//         if(MAFast1 < MASlow1 && MAFast > MASlow)
//         if(MACDHistogram1 <= MACDSignal1 && MACDHistogram > MACDSignal)

//         if(MAFast > MASlow)
         if(Ask > MALong)
//         if(MAFast > MALong)
         if(MALong1 < MALong)
         if(MACDHistogram > MACDSignal)
         if(MACDHistogram < 0)
//         if(MACDHistogram > 0)
            result = 1;
                  
         break;
      }
      case _OPEN_SHORT:
      {
         MAFast = iMA(_SYMBOL, _TIMEFRAME, _FASTMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MASlow = iMA(_SYMBOL, _TIMEFRAME, _SLOWMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MAFast1 = iMA(_SYMBOL, _TIMEFRAME, _FASTMA, 0, _MAMETHOD, _PRICE, _SHIFT + 1);
         MASlow1 = iMA(_SYMBOL, _TIMEFRAME, _SLOWMA, 0, _MAMETHOD, _PRICE, _SHIFT + 1);
         MALong = iMA(_SYMBOL, _TIMEFRAME, _LONGMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MALong1 = iMA(_SYMBOL, _TIMEFRAME, _LONGMA, 0, _MAMETHOD, _PRICE, _SHIFT + 1);

         MACDHistogram = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT);
         MACDSignal = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT);
         MACDHistogram1 = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT + 1);
         MACDSignal1 = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT + 1);

//         if(MAFast1 > MASlow1 && MAFast < MASlow)
//         if(MACDHistogram1 >= MACDSignal1 && MACDHistogram < MACDSignal)

//         if(MAFast < MASlow)
         if(Bid < MALong)
//         if(MAFast < MALong)
         if(MALong1 > MALong)
         if(MACDHistogram < MACDSignal)
         if(MACDHistogram > 0)
//         if(MACDHistogram < 0)
            result = 1;
                  
         break;
      }
      case _CLOSE_LONG:
      {         
         break;

         if(OrdersTotal() == 1)
         {
            OrderSelect(0, SELECT_BY_POS);
            if(OrderMagicNumber() != _MAGICNUMBER)
               break;
            if(OrderProfit() > 0)
            {
               if(OrderType() == OP_BUY)
               {
//                  if(iHigh(_SYMBOL, _TIMEFRAME, 2) > iHigh(_SYMBOL, _TIMEFRAME, 1))
//                  if(iHigh(_SYMBOL, _TIMEFRAME, 1) > iHigh(_SYMBOL, _TIMEFRAME, 0))
                  if(iLow(_SYMBOL, _TIMEFRAME, 2) > iLow(_SYMBOL, _TIMEFRAME, 1))
                      result = 1;
               }
            }
         }

         break;

         if(OrdersTotal() == 1)
         {
            OrderSelect(0, SELECT_BY_POS);
            if(OrderMagicNumber() != _MAGICNUMBER)
               break;
            if(OrderProfit() > 0)
            {
               if(OrderType() == OP_BUY)
               {
                  if(getLastFractalValue(_SYMBOL, _TIMEFRAME, false) < getPreviousFractalValue(_SYMBOL, _TIMEFRAME, false))
                     result = 1;
               }
            }
         }

         break;
      }
      case _CLOSE_SHORT:
      {
         break;

         if(OrdersTotal() == 1)
         {
            OrderSelect(0, SELECT_BY_POS);
            if(OrderMagicNumber() != _MAGICNUMBER)
               break;
            if(OrderProfit() > 0)
            {
               if(OrderType() == OP_SELL)
               {
//                  if(iLow(_SYMBOL, _TIMEFRAME, 2) < iLow(_SYMBOL, _TIMEFRAME, 1))
//                  if(iLow(_SYMBOL, _TIMEFRAME, 1) > iLow(_SYMBOL, _TIMEFRAME, 0))
                  if(iHigh(_SYMBOL, _TIMEFRAME, 2) < iHigh(_SYMBOL, _TIMEFRAME, 1))
                     result = 1;
               }
            }
         }

         break;

         if(OrdersTotal() == 1)
         {
            OrderSelect(0, SELECT_BY_POS);
            if(OrderMagicNumber() != _MAGICNUMBER)
               break;
            if(OrderProfit() > 0)
            {
               if(OrderType() == OP_SELL)
               {
                  if(getLastFractalValue(_SYMBOL, _TIMEFRAME, true) > getPreviousFractalValue(_SYMBOL, _TIMEFRAME, true))
                     result = 1;
               }
            }
         }
         
         break;
      }
      case _GET_LONG_STOPLOSS_PRICE:
      {
//         break;

         result = getLastFractalValue(_SYMBOL, _TIMEFRAME, false);
//         result = iLow(_SYMBOL, _TIMEFRAME, 1);

         if(result > Ask - 10*Point)
            result = Ask - 10*Point;

         break;
      }
      case _GET_SHORT_STOPLOSS_PRICE:
      {
//         break;

           result = getLastFractalValue(_SYMBOL, _TIMEFRAME, true);
//         result = iHigh(_SYMBOL, _TIMEFRAME, 1);

         if(result < Bid + 10*Point)
            result = Bid + 10*Point;
         
         break;
      }
      case _GET_LONG_TAKEPROFIT_PRICE:
      {
         break;
      }
      case _GET_SHORT_TAKEPROFIT_PRICE:
      {
         break;
      }
      case _GET_TRAILED_STOPLOSS_PRICE:
      {
//         break;

         if(OrdersTotal() == 1)
         {
            OrderSelect(0, SELECT_BY_POS);
            if(OrderMagicNumber() != _MAGICNUMBER)
               break;
            if(OrderProfit() > 0)
            {
               if(OrderType() == OP_BUY)
               {
                  result = getLastFractalValue(_SYMBOL, _TIMEFRAME, false);
                  
                  if(result > Bid - 10*Point)
                     result = Bid - 10*Point;
                  
                  if(result <= OrderStopLoss())
                     result = OrderStopLoss();
               }
               else
               {
                  result = getLastFractalValue(_SYMBOL, _TIMEFRAME, true);
                  
                  if(result < Ask + 10*Point)
                     result = Ask + 10*Point;
                     
                  if(result >= OrderStopLoss())
                     result = OrderStopLoss();
               }
            }
         }
         
         break;
      }      
      case _GET_TRAILED_TAKEPROFIT_PRICE:
      {
         break;
         
         if(OrdersTotal() == 1)
         {
            OrderSelect(0, SELECT_BY_POS);
            if(OrderMagicNumber() != _MAGICNUMBER)
               break;
            if(OrderProfit() > 0)
            {
               if(OrderType() == OP_BUY)
               {
                  result = Bid + MathAbs(Bid - OrderStopLoss());
               }
               else
               {
                  result = Ask - MathAbs(Ask - OrderStopLoss());
               }
            }
         }

         break;
         
         if(OrdersTotal() == 1)
         {
            OrderSelect(0, SELECT_BY_POS);
            if(OrderMagicNumber() != _MAGICNUMBER)
               break;
            if(OrderProfit() > 0)
            {
               if(OrderType() == OP_BUY)
               {
                  result = getLastFractalValue(_SYMBOL, _TIMEFRAME, true);
                  
                  if(result > Bid)
                     result = Bid;
                  
                  if(result <= Bid)
                     result = 0;
               }
               else
               {
                  result = getLastFractalValue(_SYMBOL, _TIMEFRAME, false);
                  
                  if(result < Ask)
                     result = Ask;
                     
                  if(result >= Ask)
                     result = 0;
               }
            }
         }
         
         break;
      }
      case _GET_LOTS:
      {
         result = 0.1;
//         result = GetLots(_MM_FIX_PERC_AVG_LAST_PROFIT, 0.2);
         break;
      }
      case _GET_TRADED_TIMEFRAME:
      {
         result = _TIMEFRAME;
         break;
      }
   }
      
   return(result);
}
//------------------------------------------------------------------//------------------------------------------------------------------
double Strategy_009(int COMMAND)
{
   string   _SYMBOL        = Symbol();
   int      _TIMEFRAME     = PERIOD_M30;
   int      _TIMEFRAME_2   = PERIOD_H1;
   int      _SLOWEMA       = 26;
   int      _FASTEMA       = 12;
   int      _MASIGNAL      = 9;
   int      _MAMETHOD      = MODE_EMA;
   int      _SLOWMA        = 20;
   int      _FASTMA        = 10;
   int      _LONGMA        = LONGMA;
   int      _SHIFT         = 0;
   int      _PRICE         = PRICE_OPEN;

   double   result         = 0;
   
   double   MAFast;
   double   MASlow;
   double   MALong;
   double   MACDHistogram;
   double   MACDSignal;
   double   MACDHistogram2;
   double   MACDSignal2;
   double   MAFast1;
   double   MASlow1;
   double   MALong1;
   double   MACDHistogram1;
   double   MACDSignal1;

   int      i;

   switch(COMMAND)
   {
/*
#define     _CLOSE_LONG                   1
#define     _CLOSE_SHORT                  2
#define     _OPEN_LONG                    3
#define     _OPEN_SHORT                   4
#define     _GET_LONG_STOPLOSS_PRICE      5
#define     _GET_SHORT_STOPLOSS_PRICE     6
#define     _GET_LONG_TAKEPROFIT_PRICE    7
#define     _GET_SHORT_TAKEPROFIT_PRICE   8
#define     _GET_LOTS                     9
#define     _GET_TRAILED_STOPLOSS_PRICE   10
#define     _GET_TRAILED_TAKEPROFIT_PRICE 11
#define     _GET_TRADED_TIMEFRAME         12
*/
      case _OPEN_LONG:
      {
         MAFast = iMA(_SYMBOL, _TIMEFRAME, _FASTMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MASlow = iMA(_SYMBOL, _TIMEFRAME, _SLOWMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MAFast1 = iMA(_SYMBOL, _TIMEFRAME, _FASTMA, 0, _MAMETHOD, _PRICE, _SHIFT + 1);
         MASlow1 = iMA(_SYMBOL, _TIMEFRAME, _SLOWMA, 0, _MAMETHOD, _PRICE, _SHIFT + 1);
         MALong = iMA(_SYMBOL, _TIMEFRAME, _LONGMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MALong1 = iMA(_SYMBOL, _TIMEFRAME, _LONGMA, 0, _MAMETHOD, _PRICE, _SHIFT + 1);

         MACDHistogram = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT);
         MACDSignal = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT);
         MACDHistogram1 = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT + 1);
         MACDSignal1 = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT + 1);
         MACDHistogram2 = iMACD(_SYMBOL, _TIMEFRAME_2, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT);
         MACDSignal2 = iMACD(_SYMBOL, _TIMEFRAME_2, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT);

         if(MACDHistogram > MACDSignal)
         if(MACDHistogram < 0)
//         if(MACDHistogram > 0)
//         if(MACDSignal < 0)

//         if(MACDHistogram1 <= MACDSignal1)

//         if(MACDHistogram2 < MACDSignal2)
//         if(MACDHistogram2 > MACDSignal2)
//         if(MACDHistogram2 > 0)
         if(MACDHistogram2 < 0)
//         if(MACDSignal2 < 0)
//         if(MACDSignal2 > 0)

//         if(MAFast1 < MASlow1 && MAFast > MASlow)
//         if(MAFast > MASlow)

//         if(Ask > MALong)
//         if(MAFast > MALong)
//         if(MALong1 < MALong)
            result = 1;
                  
         break;
      }
      case _OPEN_SHORT:
      {
         MAFast = iMA(_SYMBOL, _TIMEFRAME, _FASTMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MASlow = iMA(_SYMBOL, _TIMEFRAME, _SLOWMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MAFast1 = iMA(_SYMBOL, _TIMEFRAME, _FASTMA, 0, _MAMETHOD, _PRICE, _SHIFT + 1);
         MASlow1 = iMA(_SYMBOL, _TIMEFRAME, _SLOWMA, 0, _MAMETHOD, _PRICE, _SHIFT + 1);
         MALong = iMA(_SYMBOL, _TIMEFRAME, _LONGMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MALong1 = iMA(_SYMBOL, _TIMEFRAME, _LONGMA, 0, _MAMETHOD, _PRICE, _SHIFT + 1);

         MACDHistogram = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT);
         MACDSignal = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT);
         MACDHistogram1 = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT + 1);
         MACDSignal1 = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT + 1);
         MACDHistogram2 = iMACD(_SYMBOL, _TIMEFRAME_2, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT);
         MACDSignal2 = iMACD(_SYMBOL, _TIMEFRAME_2, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT);

         if(MACDHistogram < MACDSignal)
         if(MACDHistogram > 0)
//         if(MACDHistogram < 0)
//         if(MACDSignal > 0)

//         if(MACDHistogram1 >= MACDSignal1)

//         if(MACDHistogram2 > MACDSignal2)
//         if(MACDHistogram2 < MACDSignal2)
//         if(MACDHistogram2 < 0)
         if(MACDHistogram2 > 0)
//         if(MACDSignal2 > 0)
//         if(MACDSignal2 < 0)

//         if(MAFast1 > MASlow1 && MAFast < MASlow)
//         if(MAFast < MASlow)

//         if(Bid < MALong)
//         if(MAFast < MALong)
//         if(MALong1 > MALong)
            result = 1;
                  
         break;
      }
      case _CLOSE_LONG:
      {
         break;
         
         if(OrdersTotal() == 1)
         {
            OrderSelect(0, SELECT_BY_POS);
            if(OrderMagicNumber() != _MAGICNUMBER)
               break;
            if(OrderProfit() > 0)
            {
               if(OrderType() == OP_BUY)
               {
                  if(Bid < iLow(_SYMBOL, _TIMEFRAME, 1))
                      result = 1;
               }
            }
         }

         break;
         
         if(OrdersTotal() == 1)
         {
            OrderSelect(0, SELECT_BY_POS);
            if(OrderMagicNumber() != _MAGICNUMBER)
               break;
            if(OrderProfit() > 0)
            {
               if(OrderType() == OP_BUY)
               {
                  if(iHigh(_SYMBOL, _TIMEFRAME, 2) > iHigh(_SYMBOL, _TIMEFRAME, 1))
//                  if(iHigh(_SYMBOL, _TIMEFRAME, 1) > iHigh(_SYMBOL, _TIMEFRAME, 0))
                      result = 1;
               }
            }
         }

         break;
         
         if(OrdersTotal() == 1)
         {
            OrderSelect(0, SELECT_BY_POS);
            if(OrderMagicNumber() != _MAGICNUMBER)
               break;
            if(OrderProfit() > 0)
            {
               if(OrderType() == OP_BUY)
               {
                  if(getLastFractalValue(_SYMBOL, _TIMEFRAME, false) < getPreviousFractalValue(_SYMBOL, _TIMEFRAME, false))
                     result = 1;
               }
            }
         }
         
         break;
      }
      case _CLOSE_SHORT:
      {
         break;
         
         if(OrdersTotal() == 1)
         {
            OrderSelect(0, SELECT_BY_POS);
            if(OrderMagicNumber() != _MAGICNUMBER)
               break;
            if(OrderProfit() > 0)
            {
               if(OrderType() == OP_SELL)
               {
                  if(Ask > iHigh(_SYMBOL, _TIMEFRAME, 1))
                     result = 1;
               }
            }
         }

         break;
         
         if(OrdersTotal() == 1)
         {
            OrderSelect(0, SELECT_BY_POS);
            if(OrderMagicNumber() != _MAGICNUMBER)
               break;
            if(OrderProfit() > 0)
            {
               if(OrderType() == OP_SELL)
               {
                  if(iLow(_SYMBOL, _TIMEFRAME, 2) < iLow(_SYMBOL, _TIMEFRAME, 1))
//                  if(iLow(_SYMBOL, _TIMEFRAME, 1) > iLow(_SYMBOL, _TIMEFRAME, 0))
                     result = 1;
               }
            }
         }

         break;
         
         if(OrdersTotal() == 1)
         {
            OrderSelect(0, SELECT_BY_POS);
            if(OrderMagicNumber() != _MAGICNUMBER)
               break;
            if(OrderProfit() > 0)
            {
               if(OrderType() == OP_SELL)
               {
                  if(getLastFractalValue(_SYMBOL, _TIMEFRAME, true) > getPreviousFractalValue(_SYMBOL, _TIMEFRAME, true))
                     result = 1;
               }
            }
         }
         
         break;
      }
      case _GET_LONG_STOPLOSS_PRICE:
      {
//         break;

         result = getLastFractalValue(_SYMBOL, _TIMEFRAME, false);
//         result = iLow(_SYMBOL, _TIMEFRAME, 1);

         if(result > Ask - 10*Point)
            result = Ask - 10*Point;

         break;
      }
      case _GET_SHORT_STOPLOSS_PRICE:
      {
//         break;

         result = getLastFractalValue(_SYMBOL, _TIMEFRAME, true);
//         result = iHigh(_SYMBOL, _TIMEFRAME, 1);

         if(result < Bid + 10*Point)
            result = Bid + 10*Point;
         
         break;
      }
      case _GET_LONG_TAKEPROFIT_PRICE:
      {
         break;
      }
      case _GET_SHORT_TAKEPROFIT_PRICE:
      {
         break;
      }
      case _GET_TRAILED_STOPLOSS_PRICE:
      {
//         break;

         if(OrdersTotal() == 1)
         {
            OrderSelect(0, SELECT_BY_POS);
            if(OrderMagicNumber() != _MAGICNUMBER)
               break;
//            if(OrderProfit() > 0)
            {
               if(OrderType() == OP_BUY)
               {
//                  result = iLow(_SYMBOL, _TIMEFRAME, 1);
                  result = getLastFractalValue(_SYMBOL, _TIMEFRAME, false);
                  
                  if(result > Bid - 10*Point)
                     result = Bid - 10*Point;
                  
                  if(result <= OrderStopLoss())
                     result = OrderStopLoss();
               }
               else
               {
                  result = iHigh(_SYMBOL, _TIMEFRAME, 1);
//                  result = getLastFractalValue(_SYMBOL, _TIMEFRAME, true);
                  
                  if(result < Ask + 10*Point)
                     result = Ask + 10*Point;
                     
                  if(result >= OrderStopLoss())
                     result = OrderStopLoss();
               }
            }
         }
         
         break;
      }      
      case _GET_TRAILED_TAKEPROFIT_PRICE:
      {
         break;
         
         if(OrdersTotal() == 1)
         {
            OrderSelect(0, SELECT_BY_POS);
            if(OrderMagicNumber() != _MAGICNUMBER)
               break;
            if(OrderProfit() > 0)
            {
               if(OrderType() == OP_BUY)
               {
                  result = Bid + MathAbs(Bid - OrderStopLoss());
               }
               else
               {
                  result = Ask - MathAbs(Ask - OrderStopLoss());
               }
            }
         }

         break;
         
         if(OrdersTotal() == 1)
         {
            OrderSelect(0, SELECT_BY_POS);
            if(OrderMagicNumber() != _MAGICNUMBER)
               break;
            if(OrderProfit() > 0)
            {
               if(OrderType() == OP_BUY)
               {
                  result = getLastFractalValue(_SYMBOL, _TIMEFRAME, true);
                  
                  if(result > Bid)
                     result = Bid;
                  
                  if(result <= Bid)
                     result = 0;
               }
               else
               {
                  result = getLastFractalValue(_SYMBOL, _TIMEFRAME, false);
                  
                  if(result < Ask)
                     result = Ask;
                     
                  if(result >= Ask)
                     result = 0;
               }
            }
         }
         
         break;
      }
      case _GET_LOTS:
      {
         result = 0.1;
//         result = GetLots(_MM_FIX_PERC_AVG_LAST_PROFIT, 0.2);
         break;
      }
      case _GET_TRADED_TIMEFRAME:
      {
         result = _TIMEFRAME;
         break;
      }
   }
      
   return(result);
}
//------------------------------------------------------------------//------------------------------------------------------------------
double Strategy_010(int COMMAND)
{
   string   _SYMBOL        = Symbol();
   int      _TIMEFRAME     = Period();
   int      _TIMEFRAME_2   = HigherTimeframe(_TIMEFRAME);
   int      _SLOWEMA       = 26;
   int      _FASTEMA       = 12;
   int      _MASIGNAL      = 9;
   int      _MAMETHOD      = MODE_EMA;
   int      _SLOWMA        = 20;
   int      _FASTMA        = 10;
   int      _LONGMA        = LONGMA;
   int      _SHIFT         = 0;
   int      _PRICE         = PRICE_OPEN;

   double   result         = 0;
   
   double   MAFast;
   double   MASlow;
   double   MALong;
   double   MACDHistogram;
   double   MACDSignal;
   double   MACDHistogram2;
   double   MACDSignal2;
   double   MAFast1;
   double   MASlow1;
   double   MALong1;
   double   MACDHistogram1;
   double   MACDSignal1;

   int      i;

   switch(COMMAND)
   {
/*
#define     _CLOSE_LONG                   1
#define     _CLOSE_SHORT                  2
#define     _OPEN_LONG                    3
#define     _OPEN_SHORT                   4
#define     _GET_LONG_STOPLOSS_PRICE      5
#define     _GET_SHORT_STOPLOSS_PRICE     6
#define     _GET_LONG_TAKEPROFIT_PRICE    7
#define     _GET_SHORT_TAKEPROFIT_PRICE   8
#define     _GET_LOTS                     9
#define     _GET_TRAILED_STOPLOSS_PRICE   10
#define     _GET_TRAILED_TAKEPROFIT_PRICE 11
#define     _GET_TRADED_TIMEFRAME         12
*/
      case _OPEN_LONG:
      {
         MAFast = iMA(_SYMBOL, _TIMEFRAME, _FASTMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MASlow = iMA(_SYMBOL, _TIMEFRAME, _SLOWMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MAFast1 = iMA(_SYMBOL, _TIMEFRAME, _FASTMA, 0, _MAMETHOD, _PRICE, _SHIFT + 1);
         MASlow1 = iMA(_SYMBOL, _TIMEFRAME, _SLOWMA, 0, _MAMETHOD, _PRICE, _SHIFT + 1);
         MALong = iMA(_SYMBOL, _TIMEFRAME, _LONGMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MALong1 = iMA(_SYMBOL, _TIMEFRAME, _LONGMA, 0, _MAMETHOD, _PRICE, _SHIFT + 1);

         MACDHistogram = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT);
         MACDSignal = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT);
         MACDHistogram1 = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT + 1);
         MACDSignal1 = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT + 1);
         MACDHistogram2 = iMACD(_SYMBOL, _TIMEFRAME_2, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT);
         MACDSignal2 = iMACD(_SYMBOL, _TIMEFRAME_2, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT);

         if(MACDHistogram > MACDSignal)
         if(MACDHistogram < 0)
//         if(MACDHistogram > 0)
//         if(MACDSignal < 0)

//         if(MACDHistogram1 <= MACDSignal1)

//         if(MACDHistogram2 < MACDSignal2)
//         if(MACDHistogram2 > MACDSignal2)
//         if(MACDHistogram2 > 0)
//         if(MACDHistogram2 < 0)
//         if(MACDSignal2 < 0)
//         if(MACDSignal2 > 0)

//         if(MAFast1 < MASlow1 && MAFast > MASlow)
//         if(MAFast > MASlow)

         if(Ask > MALong)
//         if(MAFast > MALong)
         if(MALong1 < MALong)

//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, true) < getPreviousFractalValue(_SYMBOL, _TIMEFRAME, true))
//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, true) > getPreviousFractalValue(_SYMBOL, _TIMEFRAME, true))
//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, false) > getPreviousFractalValue(_SYMBOL, _TIMEFRAME, false))
//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, false) < getPreviousFractalValue(_SYMBOL, _TIMEFRAME, false))
//         if(MathAbs(getLastFractalValue(_SYMBOL, _TIMEFRAME, true) - getLastFractalValue(_SYMBOL, _TIMEFRAME, false)) < MathAbs(getPreviousFractalValue(_SYMBOL, _TIMEFRAME, true) - getPreviousFractalValue(_SYMBOL, _TIMEFRAME, false)))
//         if(Ask > getLastFractalValue(_SYMBOL, _TIMEFRAME, true))
//         if(Ask < getLastFractalValue(_SYMBOL, _TIMEFRAME, true))
            result = 1;
                  
         break;
      }
      case _OPEN_SHORT:
      {
         MAFast = iMA(_SYMBOL, _TIMEFRAME, _FASTMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MASlow = iMA(_SYMBOL, _TIMEFRAME, _SLOWMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MAFast1 = iMA(_SYMBOL, _TIMEFRAME, _FASTMA, 0, _MAMETHOD, _PRICE, _SHIFT + 1);
         MASlow1 = iMA(_SYMBOL, _TIMEFRAME, _SLOWMA, 0, _MAMETHOD, _PRICE, _SHIFT + 1);
         MALong = iMA(_SYMBOL, _TIMEFRAME, _LONGMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MALong1 = iMA(_SYMBOL, _TIMEFRAME, _LONGMA, 0, _MAMETHOD, _PRICE, _SHIFT + 1);

         MACDHistogram = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT);
         MACDSignal = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT);
         MACDHistogram1 = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT + 1);
         MACDSignal1 = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT + 1);
         MACDHistogram2 = iMACD(_SYMBOL, _TIMEFRAME_2, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT);
         MACDSignal2 = iMACD(_SYMBOL, _TIMEFRAME_2, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT);

         if(MACDHistogram < MACDSignal)
         if(MACDHistogram > 0)
//         if(MACDHistogram < 0)
//         if(MACDSignal > 0)

         if(MACDHistogram1 >= MACDSignal1)

//         if(MACDHistogram2 > MACDSignal2)
//         if(MACDHistogram2 < MACDSignal2)
//         if(MACDHistogram2 < 0)
//         if(MACDHistogram2 > 0)
//         if(MACDSignal2 > 0)
//         if(MACDSignal2 < 0)

//         if(MAFast1 > MASlow1 && MAFast < MASlow)
//         if(MAFast < MASlow)

         if(Bid < MALong)
//         if(MAFast < MALong)
         if(MALong1 > MALong)

//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, true) < getPreviousFractalValue(_SYMBOL, _TIMEFRAME, true))
//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, true) > getPreviousFractalValue(_SYMBOL, _TIMEFRAME, true))
//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, false) > getPreviousFractalValue(_SYMBOL, _TIMEFRAME, false))
//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, false) < getPreviousFractalValue(_SYMBOL, _TIMEFRAME, false))
//         if(MathAbs(getLastFractalValue(_SYMBOL, _TIMEFRAME, true) - getLastFractalValue(_SYMBOL, _TIMEFRAME, false)) < MathAbs(getPreviousFractalValue(_SYMBOL, _TIMEFRAME, true) - getPreviousFractalValue(_SYMBOL, _TIMEFRAME, false)))
//         if(Bid < getLastFractalValue(_SYMBOL, _TIMEFRAME, false))
//         if(Bid > getLastFractalValue(_SYMBOL, _TIMEFRAME, false))
            result = 1;
                  
         break;
      }
      case _CLOSE_LONG:
      {
         MAFast = iMA(_SYMBOL, _TIMEFRAME, _FASTMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MASlow = iMA(_SYMBOL, _TIMEFRAME, _SLOWMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MAFast1 = iMA(_SYMBOL, _TIMEFRAME, _FASTMA, 0, _MAMETHOD, _PRICE, _SHIFT + 1);
         MASlow1 = iMA(_SYMBOL, _TIMEFRAME, _SLOWMA, 0, _MAMETHOD, _PRICE, _SHIFT + 1);
         MALong = iMA(_SYMBOL, _TIMEFRAME, _LONGMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MALong1 = iMA(_SYMBOL, _TIMEFRAME, _LONGMA, 0, _MAMETHOD, _PRICE, _SHIFT + 1);

         MACDHistogram = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT);
         MACDSignal = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT);
         MACDHistogram1 = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT + 1);
         MACDSignal1 = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT + 1);
         MACDHistogram2 = iMACD(_SYMBOL, _TIMEFRAME_2, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT);
         MACDSignal2 = iMACD(_SYMBOL, _TIMEFRAME_2, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT);

         if(MACDHistogram < MACDSignal)
         if(MACDHistogram > 0)
//         if(MACDHistogram < 0)
//         if(MACDSignal > 0)

         if(MACDHistogram1 >= MACDSignal1)

//         if(MACDHistogram2 > MACDSignal2)
//         if(MACDHistogram2 < MACDSignal2)
//         if(MACDHistogram2 < 0)
//         if(MACDHistogram2 > 0)
//         if(MACDSignal2 > 0)
//         if(MACDSignal2 < 0)

//         if(MAFast1 > MASlow1 && MAFast < MASlow)
//         if(MAFast < MASlow)

         if(Bid < MALong)
//         if(MAFast < MALong)
         if(MALong1 > MALong)

//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, true) < getPreviousFractalValue(_SYMBOL, _TIMEFRAME, true))
//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, true) > getPreviousFractalValue(_SYMBOL, _TIMEFRAME, true))
//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, false) > getPreviousFractalValue(_SYMBOL, _TIMEFRAME, false))
//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, false) < getPreviousFractalValue(_SYMBOL, _TIMEFRAME, false))
//         if(MathAbs(getLastFractalValue(_SYMBOL, _TIMEFRAME, true) - getLastFractalValue(_SYMBOL, _TIMEFRAME, false)) < MathAbs(getPreviousFractalValue(_SYMBOL, _TIMEFRAME, true) - getPreviousFractalValue(_SYMBOL, _TIMEFRAME, false)))
//         if(Bid < getLastFractalValue(_SYMBOL, _TIMEFRAME, false))
//         if(Bid > getLastFractalValue(_SYMBOL, _TIMEFRAME, false))
            result = 1;

         break;
         
         if(OrdersTotal() == 1)
         {
            OrderSelect(0, SELECT_BY_POS);
            if(OrderMagicNumber() != _MAGICNUMBER)
               break;
            if(OrderProfit() > 0)
            {
               if(OrderType() == OP_BUY)
               {
                  if(iHigh(_SYMBOL, _TIMEFRAME, 2) > iHigh(_SYMBOL, _TIMEFRAME, 1))
//                  if(iHigh(_SYMBOL, _TIMEFRAME, 1) > iHigh(_SYMBOL, _TIMEFRAME, 0))
                      result = 1;
               }
            }
         }

         break;
         
         if(OrdersTotal() == 1)
         {
            OrderSelect(0, SELECT_BY_POS);
            if(OrderMagicNumber() != _MAGICNUMBER)
               break;
            if(OrderProfit() > 0)
            {
               if(OrderType() == OP_BUY)
               {
                  if(Bid < iLow(_SYMBOL, _TIMEFRAME, 1))
                      result = 1;
               }
            }
         }

         break;
         
         if(OrdersTotal() == 1)
         {
            OrderSelect(0, SELECT_BY_POS);
            if(OrderMagicNumber() != _MAGICNUMBER)
               break;
            if(OrderProfit() > 0)
            {
               if(OrderType() == OP_BUY)
               {
                  if(getLastFractalValue(_SYMBOL, _TIMEFRAME, false) < getPreviousFractalValue(_SYMBOL, _TIMEFRAME, false))
                     result = 1;
               }
            }
         }
         
         break;
      }
      case _CLOSE_SHORT:
      {
         MAFast = iMA(_SYMBOL, _TIMEFRAME, _FASTMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MASlow = iMA(_SYMBOL, _TIMEFRAME, _SLOWMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MAFast1 = iMA(_SYMBOL, _TIMEFRAME, _FASTMA, 0, _MAMETHOD, _PRICE, _SHIFT + 1);
         MASlow1 = iMA(_SYMBOL, _TIMEFRAME, _SLOWMA, 0, _MAMETHOD, _PRICE, _SHIFT + 1);
         MALong = iMA(_SYMBOL, _TIMEFRAME, _LONGMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MALong1 = iMA(_SYMBOL, _TIMEFRAME, _LONGMA, 0, _MAMETHOD, _PRICE, _SHIFT + 1);

         MACDHistogram = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT);
         MACDSignal = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT);
         MACDHistogram1 = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT + 1);
         MACDSignal1 = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT + 1);
         MACDHistogram2 = iMACD(_SYMBOL, _TIMEFRAME_2, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT);
         MACDSignal2 = iMACD(_SYMBOL, _TIMEFRAME_2, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT);

         if(MACDHistogram > MACDSignal)
         if(MACDHistogram < 0)
//         if(MACDHistogram > 0)
//         if(MACDSignal < 0)

//         if(MACDHistogram1 <= MACDSignal1)

//         if(MACDHistogram2 < MACDSignal2)
//         if(MACDHistogram2 > MACDSignal2)
//         if(MACDHistogram2 > 0)
//         if(MACDHistogram2 < 0)
//         if(MACDSignal2 < 0)
//         if(MACDSignal2 > 0)

//         if(MAFast1 < MASlow1 && MAFast > MASlow)
//         if(MAFast > MASlow)

         if(Ask > MALong)
//         if(MAFast > MALong)
         if(MALong1 < MALong)

//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, true) < getPreviousFractalValue(_SYMBOL, _TIMEFRAME, true))
//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, true) > getPreviousFractalValue(_SYMBOL, _TIMEFRAME, true))
//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, false) > getPreviousFractalValue(_SYMBOL, _TIMEFRAME, false))
//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, false) < getPreviousFractalValue(_SYMBOL, _TIMEFRAME, false))
//         if(MathAbs(getLastFractalValue(_SYMBOL, _TIMEFRAME, true) - getLastFractalValue(_SYMBOL, _TIMEFRAME, false)) < MathAbs(getPreviousFractalValue(_SYMBOL, _TIMEFRAME, true) - getPreviousFractalValue(_SYMBOL, _TIMEFRAME, false)))
//         if(Ask > getLastFractalValue(_SYMBOL, _TIMEFRAME, true))
//         if(Ask < getLastFractalValue(_SYMBOL, _TIMEFRAME, true))
            result = 1;

         break;
         
         if(OrdersTotal() == 1)
         {
            OrderSelect(0, SELECT_BY_POS);
            if(OrderMagicNumber() != _MAGICNUMBER)
               break;
            if(OrderProfit() > 0)
            {
               if(OrderType() == OP_SELL)
               {
                  if(iLow(_SYMBOL, _TIMEFRAME, 2) < iLow(_SYMBOL, _TIMEFRAME, 1))
//                  if(iLow(_SYMBOL, _TIMEFRAME, 1) > iLow(_SYMBOL, _TIMEFRAME, 0))
                     result = 1;
               }
            }
         }

         break;
         
         if(OrdersTotal() == 1)
         {
            OrderSelect(0, SELECT_BY_POS);
            if(OrderMagicNumber() != _MAGICNUMBER)
               break;
            if(OrderProfit() > 0)
            {
               if(OrderType() == OP_SELL)
               {
                  if(Ask > iHigh(_SYMBOL, _TIMEFRAME, 1))
                     result = 1;
               }
            }
         }

         break;
         
         if(OrdersTotal() == 1)
         {
            OrderSelect(0, SELECT_BY_POS);
            if(OrderMagicNumber() != _MAGICNUMBER)
               break;
            if(OrderProfit() > 0)
            {
               if(OrderType() == OP_SELL)
               {
                  if(getLastFractalValue(_SYMBOL, _TIMEFRAME, true) > getPreviousFractalValue(_SYMBOL, _TIMEFRAME, true))
                     result = 1;
               }
            }
         }
         
         break;
      }
      case _GET_LONG_STOPLOSS_PRICE:
      {
//         break;

         result = getLastFractalValue(_SYMBOL, _TIMEFRAME, false) - 5*Point;
//         result = iLow(_SYMBOL, _TIMEFRAME, 1);

         if(result > Ask - 10*Point)
            result = Ask - 10*Point;

         break;
      }
      case _GET_SHORT_STOPLOSS_PRICE:
      {
//         break;

         result = getLastFractalValue(_SYMBOL, _TIMEFRAME, true) + 5*Point;
//         result = iHigh(_SYMBOL, _TIMEFRAME, 1);

         if(result < Bid + 10*Point)
            result = Bid + 10*Point;
         
         break;
      }
      case _GET_LONG_TAKEPROFIT_PRICE:
      {
         break;
      }
      case _GET_SHORT_TAKEPROFIT_PRICE:
      {
         break;
      }
      case _GET_TRAILED_STOPLOSS_PRICE:
      {
//         break;

         double beq = 0;
         
/*
         if(OrdersTotal() == 1)
         {
            OrderSelect(0, SELECT_BY_POS);
            if(OrderMagicNumber() != _MAGICNUMBER)
               break;
            if(OrderProfit() > 0)
            {
               if(OrderType() == OP_BUY)
               {
                  if(iLow(_SYMBOL, _TIMEFRAME, 1) > OrderOpenPrice())
                     beq = OrderOpenPrice();
                  
                  if(beq > Bid - 10*Point)
                     beq = Bid - 10*Point;
                  
                  if(beq <= OrderStopLoss())
                     beq = OrderStopLoss();
               }
               else
               {
                  if(iHigh(_SYMBOL, _TIMEFRAME, 1) < OrderOpenPrice())
                     beq = OrderOpenPrice();
                  
                  if(beq < Ask + 10*Point)
                     beq = Ask + 10*Point;
                     
                  if(beq >= OrderStopLoss())
                     beq = OrderStopLoss();
               }
            }
         }
*/
         
         if(OrdersTotal() == 1)
         {
            OrderSelect(0, SELECT_BY_POS);
            if(OrderMagicNumber() != _MAGICNUMBER)
               break;
//            if(OrderProfit() > 0)
            {
               if(OrderType() == OP_BUY)
               {
//                  result = iLow(_SYMBOL, _TIMEFRAME, 1);
                  result = getLastFractalValue(_SYMBOL, _TIMEFRAME, false) - 5*Point;
                  
                  if(beq > result)
                     result = beq;
                  
                  if(result > Bid - 10*Point)
                     result = Bid - 10*Point;
                  
                  if(result <= OrderStopLoss())
                     result = OrderStopLoss();
               }
               else
               {
//                  result = iHigh(_SYMBOL, _TIMEFRAME, 1);
                  result = getLastFractalValue(_SYMBOL, _TIMEFRAME, true) + 5*Point;
                  
                  if(beq > result)
                     result = beq;

                  if(result < Ask + 10*Point)
                     result = Ask + 10*Point;
                     
                  if(result >= OrderStopLoss())
                     result = OrderStopLoss();
               }
            }
         }
         
         break;
      }      
      case _GET_TRAILED_TAKEPROFIT_PRICE:
      {
         break;
         
         if(OrdersTotal() == 1)
         {
            OrderSelect(0, SELECT_BY_POS);
            if(OrderMagicNumber() != _MAGICNUMBER)
               break;
            if(OrderProfit() > 0)
            {
               if(OrderType() == OP_BUY)
               {
                  result = Bid + MathAbs(Bid - OrderStopLoss());
               }
               else
               {
                  result = Ask - MathAbs(Ask - OrderStopLoss());
               }
            }
         }

         break;
         
         if(OrdersTotal() == 1)
         {
            OrderSelect(0, SELECT_BY_POS);
            if(OrderMagicNumber() != _MAGICNUMBER)
               break;
            if(OrderProfit() > 0)
            {
               if(OrderType() == OP_BUY)
               {
                  result = getLastFractalValue(_SYMBOL, _TIMEFRAME, true);
                  
                  if(result > Bid)
                     result = Bid;
                  
                  if(result <= Bid)
                     result = 0;
               }
               else
               {
                  result = getLastFractalValue(_SYMBOL, _TIMEFRAME, false);
                  
                  if(result < Ask)
                     result = Ask;
                     
                  if(result >= Ask)
                     result = 0;
               }
            }
         }
         
         break;
      }
      case _GET_LOTS:
      {
         result = 0.1;
//         result = GetLots(_MM_FIX_PERC_AVG_LAST_PROFIT, 0.2);
         break;
      }
      case _GET_TRADED_TIMEFRAME:
      {
         result = _TIMEFRAME;
         break;
      }
   }
      
   return(result);
}
//------------------------------------------------------------------//------------------------------------------------------------------
double Strategy_011(int COMMAND)
{
   string   _SYMBOL        = Symbol();
   int      _TIMEFRAME     = getStrategyTimeframeByNumber(_STRATEGY_TIMEFRAME);
//   int      _TIMEFRAME     = _TIMEFRAME;
   int      _TIMEFRAME_2   = HigherTimeframe(_TIMEFRAME);
   int      _SLOWEMA       = 26;
   int      _FASTEMA       = 12;
   int      _MASIGNAL      = 9;
   int      _MAMETHOD      = MODE_EMA;
   int      _SLOWMA        = 20;
   int      _FASTMA        = 10;
   int      _LONGMA        = LONGMA;
   int      _SHIFT         = 0;
   int      _PRICE         = PRICE_OPEN;

   double   result         = 0;
   
   double   MAFast;
   double   MASlow;
   double   MALong;
   double   MACDHistogram;
   double   MACDSignal;
   double   MAFast1;
   double   MASlow1;
   double   MALong1;
   double   MACDHistogram1;
   double   MACDSignal1;
   double   MAFast2;
   double   MASlow2;
   double   MALong2;
   double   MACDHistogram2;
   double   MACDSignal2;
   double   T2_MACDHistogram;
   double   T2_MACDSignal;

   int      i;

   switch(COMMAND)
   {
/*
#define     _CLOSE_LONG                   1
#define     _CLOSE_SHORT                  2
#define     _OPEN_LONG                    3
#define     _OPEN_SHORT                   4
#define     _GET_LONG_STOPLOSS_PRICE      5
#define     _GET_SHORT_STOPLOSS_PRICE     6
#define     _GET_LONG_TAKEPROFIT_PRICE    7
#define     _GET_SHORT_TAKEPROFIT_PRICE   8
#define     _GET_LOTS                     9
#define     _GET_TRAILED_STOPLOSS_PRICE   10
#define     _GET_TRAILED_TAKEPROFIT_PRICE 11
#define     _GET_TRADED_TIMEFRAME         12
*/
      case _OPEN_LONG:
      {
//         _PRICE = PRICE_LOW;
         
         MAFast = iMA(_SYMBOL, _TIMEFRAME, _FASTMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MASlow = iMA(_SYMBOL, _TIMEFRAME, _SLOWMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MALong = iMA(_SYMBOL, _TIMEFRAME, _LONGMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MACDHistogram = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT);
         MACDSignal = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT);

         MAFast1 = iMA(_SYMBOL, _TIMEFRAME, _FASTMA, 0, _MAMETHOD, _PRICE, _SHIFT + 1);
         MASlow1 = iMA(_SYMBOL, _TIMEFRAME, _SLOWMA, 0, _MAMETHOD, _PRICE, _SHIFT + 1);
         MALong1 = iMA(_SYMBOL, _TIMEFRAME, _LONGMA, 0, _MAMETHOD, _PRICE, _SHIFT + 1);
         MACDHistogram1 = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT + 1);
         MACDSignal1 = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT + 1);

         MAFast2 = iMA(_SYMBOL, _TIMEFRAME, _FASTMA, 0, _MAMETHOD, _PRICE, _SHIFT + 2);
         MASlow2 = iMA(_SYMBOL, _TIMEFRAME, _SLOWMA, 0, _MAMETHOD, _PRICE, _SHIFT + 2);
         MALong2 = iMA(_SYMBOL, _TIMEFRAME, _LONGMA, 0, _MAMETHOD, _PRICE, _SHIFT + 2);
         MACDHistogram2 = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT + 2);
         MACDSignal2 = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT + 2);

         T2_MACDHistogram = iMACD(_SYMBOL, _TIMEFRAME_2, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT);
         T2_MACDSignal = iMACD(_SYMBOL, _TIMEFRAME_2, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT);

//         if(MACDHistogram < MACDSignal)
//         if(MACDHistogram > MACDSignal)
//         if(MACDHistogram < 0)
//         if(MACDHistogram > 0)
//         if(MACDSignal < 0)

         if(MACDHistogram1 > MACDHistogram2)
         if(MACDSignal1 < MACDSignal2)
         if(MACDHistogram1 <= MACDSignal1)
         if(MACDHistogram1 < 0)
         if(MACDSignal1 < 0)

//         if(MACDHistogram2 < MACDSignal2)
//         if(MACDHistogram2 > MACDSignal2)
//         if(MACDHistogram2 > 0)
//         if(MACDHistogram2 < 0)
//         if(MACDSignal2 < 0)
//         if(MACDSignal2 > 0)

//         if(MAFast1 < MASlow1 && MAFast > MASlow)
//         if(MAFast > MASlow)
//         if(MAFast1 > MASlow1)

//         if(Ask > MALong)
//         if(MAFast > MALong)
//         if(MALong1 < MALong)
         if(MALong2 < MALong1)

//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, true) < getPreviousFractalValue(_SYMBOL, _TIMEFRAME, true))
//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, true) > getPreviousFractalValue(_SYMBOL, _TIMEFRAME, true))
//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, false) > getPreviousFractalValue(_SYMBOL, _TIMEFRAME, false))
//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, false) < getPreviousFractalValue(_SYMBOL, _TIMEFRAME, false))
//         if(MathAbs(getLastFractalValue(_SYMBOL, _TIMEFRAME, true) - getLastFractalValue(_SYMBOL, _TIMEFRAME, false)) < MathAbs(getPreviousFractalValue(_SYMBOL, _TIMEFRAME, true) - getPreviousFractalValue(_SYMBOL, _TIMEFRAME, false)))
//         if(Ask > getLastFractalValue(_SYMBOL, _TIMEFRAME, true))
//         if(Ask < getLastFractalValue(_SYMBOL, _TIMEFRAME, true))
            result = 1;
                  
         break;
      }
      case _OPEN_SHORT:
      {
//         _PRICE = PRICE_HIGH;
         
         MAFast = iMA(_SYMBOL, _TIMEFRAME, _FASTMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MASlow = iMA(_SYMBOL, _TIMEFRAME, _SLOWMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MALong = iMA(_SYMBOL, _TIMEFRAME, _LONGMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MACDHistogram = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT);
         MACDSignal = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT);

         MAFast1 = iMA(_SYMBOL, _TIMEFRAME, _FASTMA, 0, _MAMETHOD, _PRICE, _SHIFT + 1);
         MASlow1 = iMA(_SYMBOL, _TIMEFRAME, _SLOWMA, 0, _MAMETHOD, _PRICE, _SHIFT + 1);
         MALong1 = iMA(_SYMBOL, _TIMEFRAME, _LONGMA, 0, _MAMETHOD, _PRICE, _SHIFT + 1);
         MACDHistogram1 = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT + 1);
         MACDSignal1 = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT + 1);

         MAFast2 = iMA(_SYMBOL, _TIMEFRAME, _FASTMA, 0, _MAMETHOD, _PRICE, _SHIFT + 2);
         MASlow2 = iMA(_SYMBOL, _TIMEFRAME, _SLOWMA, 0, _MAMETHOD, _PRICE, _SHIFT + 2);
         MALong2 = iMA(_SYMBOL, _TIMEFRAME, _LONGMA, 0, _MAMETHOD, _PRICE, _SHIFT + 2);
         MACDHistogram2 = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT + 2);
         MACDSignal2 = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT + 2);

         T2_MACDHistogram = iMACD(_SYMBOL, _TIMEFRAME_2, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT);
         T2_MACDSignal = iMACD(_SYMBOL, _TIMEFRAME_2, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT);


//         if(MACDHistogram > MACDSignal)
//         if(MACDHistogram < MACDSignal)
//         if(MACDHistogram > 0)
//         if(MACDHistogram < 0)
//         if(MACDSignal > 0)

         if(MACDHistogram1 < MACDHistogram2)
         if(MACDSignal1 > MACDSignal2)
         if(MACDHistogram1 >= MACDSignal1)
         if(MACDHistogram1 > 0)
         if(MACDSignal1 > 0)

//         if(MACDHistogram2 > MACDSignal2)
//         if(MACDHistogram2 < MACDSignal2)
//         if(MACDHistogram2 < 0)
//         if(MACDHistogram2 > 0)
//         if(MACDSignal2 > 0)
//         if(MACDSignal2 < 0)

//         if(MAFast1 > MASlow1 && MAFast < MASlow)
//         if(MAFast < MASlow)
//         if(MAFast1 < MASlow1)

//         if(Bid < MALong)
//         if(MAFast < MALong)
//         if(MALong1 > MALong)
         if(MALong2 > MALong1)

//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, true) < getPreviousFractalValue(_SYMBOL, _TIMEFRAME, true))
//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, true) > getPreviousFractalValue(_SYMBOL, _TIMEFRAME, true))
//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, false) > getPreviousFractalValue(_SYMBOL, _TIMEFRAME, false))
//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, false) < getPreviousFractalValue(_SYMBOL, _TIMEFRAME, false))
//         if(MathAbs(getLastFractalValue(_SYMBOL, _TIMEFRAME, true) - getLastFractalValue(_SYMBOL, _TIMEFRAME, false)) < MathAbs(getPreviousFractalValue(_SYMBOL, _TIMEFRAME, true) - getPreviousFractalValue(_SYMBOL, _TIMEFRAME, false)))
//         if(Bid < getLastFractalValue(_SYMBOL, _TIMEFRAME, false))
//         if(Bid > getLastFractalValue(_SYMBOL, _TIMEFRAME, false))
            result = 1;
                  
         break;
      }
      case _CLOSE_LONG:
      {
         break;
         
         MAFast = iMA(_SYMBOL, _TIMEFRAME, _FASTMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MASlow = iMA(_SYMBOL, _TIMEFRAME, _SLOWMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MALong = iMA(_SYMBOL, _TIMEFRAME, _LONGMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MACDHistogram = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT);
         MACDSignal = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT);

         MAFast1 = iMA(_SYMBOL, _TIMEFRAME, _FASTMA, 0, _MAMETHOD, _PRICE, _SHIFT + 1);
         MASlow1 = iMA(_SYMBOL, _TIMEFRAME, _SLOWMA, 0, _MAMETHOD, _PRICE, _SHIFT + 1);
         MALong1 = iMA(_SYMBOL, _TIMEFRAME, _LONGMA, 0, _MAMETHOD, _PRICE, _SHIFT + 1);
         MACDHistogram1 = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT + 1);
         MACDSignal1 = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT + 1);

         MAFast2 = iMA(_SYMBOL, _TIMEFRAME, _FASTMA, 0, _MAMETHOD, _PRICE, _SHIFT + 2);
         MASlow2 = iMA(_SYMBOL, _TIMEFRAME, _SLOWMA, 0, _MAMETHOD, _PRICE, _SHIFT + 2);
         MALong2 = iMA(_SYMBOL, _TIMEFRAME, _LONGMA, 0, _MAMETHOD, _PRICE, _SHIFT + 2);
         MACDHistogram2 = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT + 2);
         MACDSignal2 = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT + 2);

//         if(MACDHistogram < MACDSignal)
//         if(MACDHistogram > 0)
//         if(MACDHistogram < 0)
//         if(MACDSignal > 0)

//         if(MACDHistogram1 >= MACDSignal1)

//         if(MACDHistogram2 > MACDSignal2)
//         if(MACDHistogram2 < MACDSignal2)
//         if(MACDHistogram2 < 0)
//         if(MACDHistogram2 > 0)
//         if(MACDSignal2 > 0)
//         if(MACDSignal2 < 0)

//         if(MAFast1 > MASlow1 && MAFast < MASlow)
//         if(MAFast < MASlow)

//         if(Bid < MALong)
//         if(MAFast < MALong)
//         if(MALong1 > MALong)

//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, true) < getPreviousFractalValue(_SYMBOL, _TIMEFRAME, true))
//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, true) > getPreviousFractalValue(_SYMBOL, _TIMEFRAME, true))
//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, false) > getPreviousFractalValue(_SYMBOL, _TIMEFRAME, false))
//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, false) < getPreviousFractalValue(_SYMBOL, _TIMEFRAME, false))
//         if(MathAbs(getLastFractalValue(_SYMBOL, _TIMEFRAME, true) - getLastFractalValue(_SYMBOL, _TIMEFRAME, false)) < MathAbs(getPreviousFractalValue(_SYMBOL, _TIMEFRAME, true) - getPreviousFractalValue(_SYMBOL, _TIMEFRAME, false)))
//         if(Bid < getLastFractalValue(_SYMBOL, _TIMEFRAME, false))
//         if(Bid > getLastFractalValue(_SYMBOL, _TIMEFRAME, false))
         if(Bid > getLastFractalValue(_SYMBOL, _TIMEFRAME, true))
            result = 1;

         break;
         
         if(OrdersTotal() == 1)
         {
            OrderSelect(0, SELECT_BY_POS);
            if(OrderMagicNumber() != _MAGICNUMBER)
               break;
            if(OrderProfit() > 0)
            {
               if(OrderType() == OP_BUY)
               {
                  if(iHigh(_SYMBOL, _TIMEFRAME, 2) > iHigh(_SYMBOL, _TIMEFRAME, 1))
//                  if(iHigh(_SYMBOL, _TIMEFRAME, 1) > iHigh(_SYMBOL, _TIMEFRAME, 0))
                      result = 1;
               }
            }
         }

         break;
         
         if(OrdersTotal() == 1)
         {
            OrderSelect(0, SELECT_BY_POS);
            if(OrderMagicNumber() != _MAGICNUMBER)
               break;
            if(OrderProfit() > 0)
            {
               if(OrderType() == OP_BUY)
               {
                  if(Bid < iLow(_SYMBOL, _TIMEFRAME, 1))
                      result = 1;
               }
            }
         }

         break;
         
         if(OrdersTotal() == 1)
         {
            OrderSelect(0, SELECT_BY_POS);
            if(OrderMagicNumber() != _MAGICNUMBER)
               break;
            if(OrderProfit() > 0)
            {
               if(OrderType() == OP_BUY)
               {
                  if(getLastFractalValue(_SYMBOL, _TIMEFRAME, false) < getPreviousFractalValue(_SYMBOL, _TIMEFRAME, false))
                     result = 1;
               }
            }
         }
         
         break;
      }
      case _CLOSE_SHORT:
      {
         break;

         MAFast = iMA(_SYMBOL, _TIMEFRAME, _FASTMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MASlow = iMA(_SYMBOL, _TIMEFRAME, _SLOWMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MALong = iMA(_SYMBOL, _TIMEFRAME, _LONGMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MACDHistogram = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT);
         MACDSignal = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT);

         MAFast1 = iMA(_SYMBOL, _TIMEFRAME, _FASTMA, 0, _MAMETHOD, _PRICE, _SHIFT + 1);
         MASlow1 = iMA(_SYMBOL, _TIMEFRAME, _SLOWMA, 0, _MAMETHOD, _PRICE, _SHIFT + 1);
         MALong1 = iMA(_SYMBOL, _TIMEFRAME, _LONGMA, 0, _MAMETHOD, _PRICE, _SHIFT + 1);
         MACDHistogram1 = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT + 1);
         MACDSignal1 = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT + 1);

         MAFast2 = iMA(_SYMBOL, _TIMEFRAME, _FASTMA, 0, _MAMETHOD, _PRICE, _SHIFT + 2);
         MASlow2 = iMA(_SYMBOL, _TIMEFRAME, _SLOWMA, 0, _MAMETHOD, _PRICE, _SHIFT + 2);
         MALong2 = iMA(_SYMBOL, _TIMEFRAME, _LONGMA, 0, _MAMETHOD, _PRICE, _SHIFT + 2);
         MACDHistogram2 = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT + 2);
         MACDSignal2 = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT + 2);

//         if(MACDHistogram > MACDSignal)
//         if(MACDHistogram < 0)
//         if(MACDHistogram > 0)
//         if(MACDSignal < 0)

//         if(MACDHistogram1 <= MACDSignal1)

//         if(MACDHistogram2 < MACDSignal2)
//         if(MACDHistogram2 > MACDSignal2)
//         if(MACDHistogram2 > 0)
//         if(MACDHistogram2 < 0)
//         if(MACDSignal2 < 0)
//         if(MACDSignal2 > 0)

//         if(MAFast1 < MASlow1 && MAFast > MASlow)
//         if(MAFast > MASlow)

//         if(Ask > MALong)
//         if(MAFast > MALong)
//         if(MALong1 < MALong)

//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, true) < getPreviousFractalValue(_SYMBOL, _TIMEFRAME, true))
//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, true) > getPreviousFractalValue(_SYMBOL, _TIMEFRAME, true))
//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, false) > getPreviousFractalValue(_SYMBOL, _TIMEFRAME, false))
//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, false) < getPreviousFractalValue(_SYMBOL, _TIMEFRAME, false))
//         if(MathAbs(getLastFractalValue(_SYMBOL, _TIMEFRAME, true) - getLastFractalValue(_SYMBOL, _TIMEFRAME, false)) < MathAbs(getPreviousFractalValue(_SYMBOL, _TIMEFRAME, true) - getPreviousFractalValue(_SYMBOL, _TIMEFRAME, false)))
//         if(Ask > getLastFractalValue(_SYMBOL, _TIMEFRAME, true))
//         if(Ask < getLastFractalValue(_SYMBOL, _TIMEFRAME, true))
         if(Ask < getLastFractalValue(_SYMBOL, _TIMEFRAME, false))
            result = 1;

         break;
         
         if(OrdersTotal() == 1)
         {
            OrderSelect(0, SELECT_BY_POS);
            if(OrderMagicNumber() != _MAGICNUMBER)
               break;
            if(OrderProfit() > 0)
            {
               if(OrderType() == OP_SELL)
               {
                  if(iLow(_SYMBOL, _TIMEFRAME, 2) < iLow(_SYMBOL, _TIMEFRAME, 1))
//                  if(iLow(_SYMBOL, _TIMEFRAME, 1) > iLow(_SYMBOL, _TIMEFRAME, 0))
                     result = 1;
               }
            }
         }

         break;
         
         if(OrdersTotal() == 1)
         {
            OrderSelect(0, SELECT_BY_POS);
            if(OrderMagicNumber() != _MAGICNUMBER)
               break;
            if(OrderProfit() > 0)
            {
               if(OrderType() == OP_SELL)
               {
                  if(Ask > iHigh(_SYMBOL, _TIMEFRAME, 1))
                     result = 1;
               }
            }
         }

         break;
         
         if(OrdersTotal() == 1)
         {
            OrderSelect(0, SELECT_BY_POS);
            if(OrderMagicNumber() != _MAGICNUMBER)
               break;
            if(OrderProfit() > 0)
            {
               if(OrderType() == OP_SELL)
               {
                  if(getLastFractalValue(_SYMBOL, _TIMEFRAME, true) > getPreviousFractalValue(_SYMBOL, _TIMEFRAME, true))
                     result = 1;
               }
            }
         }
         
         break;
      }
      case _GET_LONG_STOPLOSS_PRICE:
      {
//         break;

         result = getLastFractalValue(_SYMBOL, _TIMEFRAME, false) - 5*Point;
//         result = iLow(_SYMBOL, _TIMEFRAME, 1);

         if(result > Ask - 10*Point)
            result = Ask - 10*Point;

         break;
      }
      case _GET_SHORT_STOPLOSS_PRICE:
      {
//         break;

         result = getLastFractalValue(_SYMBOL, _TIMEFRAME, true) + 5*Point;
//         result = iHigh(_SYMBOL, _TIMEFRAME, 1);

         if(result < Bid + 10*Point)
            result = Bid + 10*Point;
         
         break;
      }
      case _GET_LONG_TAKEPROFIT_PRICE:
      {
         break;
      }
      case _GET_SHORT_TAKEPROFIT_PRICE:
      {
         break;
      }
      case _GET_TRAILED_STOPLOSS_PRICE:
      {
//         break;

         double beq = 0;
         
/*
         if(OrdersTotal() == 1)
         {
            OrderSelect(0, SELECT_BY_POS);
            if(OrderMagicNumber() != _MAGICNUMBER)
               break;
            if(OrderProfit() > 0)
            {
               if(OrderType() == OP_BUY)
               {
                  if(iLow(_SYMBOL, _TIMEFRAME, 1) > OrderOpenPrice())
                     beq = OrderOpenPrice();
                  
                  if(beq > Bid - 10*Point)
                     beq = Bid - 10*Point;
                  
                  if(beq <= OrderStopLoss())
                     beq = OrderStopLoss();
               }
               else
               {
                  if(iHigh(_SYMBOL, _TIMEFRAME, 1) < OrderOpenPrice())
                     beq = OrderOpenPrice();
                  
                  if(beq < Ask + 10*Point)
                     beq = Ask + 10*Point;
                     
                  if(beq >= OrderStopLoss())
                     beq = OrderStopLoss();
               }
            }
         }
*/
         
         if(OrdersTotal() == 1)
         {
            OrderSelect(0, SELECT_BY_POS);
            if(OrderMagicNumber() != _MAGICNUMBER)
               break;
//            if(OrderProfit() > 0)
            {
               if(OrderType() == OP_BUY)
               {
//                  result = iLow(_SYMBOL, _TIMEFRAME, 1);
                  result = getLastFractalValue(_SYMBOL, _TIMEFRAME, false) - 5*Point;
                  
                  if(beq > result)
                     result = beq;
                  
                  if(result > Bid - 10*Point)
                     result = Bid - 10*Point;
                  
                  if(result <= OrderStopLoss())
                     result = OrderStopLoss();
               }
               else
               {
//                  result = iHigh(_SYMBOL, _TIMEFRAME, 1);
                  result = getLastFractalValue(_SYMBOL, _TIMEFRAME, true) + 5*Point;
                  
                  if(beq > result)
                     result = beq;

                  if(result < Ask + 10*Point)
                     result = Ask + 10*Point;
                     
                  if(result >= OrderStopLoss())
                     result = OrderStopLoss();
               }
            }
         }
         
         break;
      }      
      case _GET_TRAILED_TAKEPROFIT_PRICE:
      {
         break;
         
         if(OrdersTotal() == 1)
         {
            OrderSelect(0, SELECT_BY_POS);
            if(OrderMagicNumber() != _MAGICNUMBER)
               break;
            if(OrderProfit() > 0)
            {
               if(OrderType() == OP_BUY)
               {
                  result = Bid + MathAbs(Bid - OrderStopLoss());
               }
               else
               {
                  result = Ask - MathAbs(Ask - OrderStopLoss());
               }
            }
         }

         break;
         
         if(OrdersTotal() == 1)
         {
            OrderSelect(0, SELECT_BY_POS);
            if(OrderMagicNumber() != _MAGICNUMBER)
               break;
            if(OrderProfit() > 0)
            {
               if(OrderType() == OP_BUY)
               {
                  result = getLastFractalValue(_SYMBOL, _TIMEFRAME, true);
                  
                  if(result > Bid)
                     result = Bid;
                  
                  if(result <= Bid)
                     result = 0;
               }
               else
               {
                  result = getLastFractalValue(_SYMBOL, _TIMEFRAME, false);
                  
                  if(result < Ask)
                     result = Ask;
                     
                  if(result >= Ask)
                     result = 0;
               }
            }
         }
         
         break;
      }
      case _GET_LOTS:
      {
         result = 0.1;
//         result = GetLots(_MM_FIX_PERC_AVG_LAST_PROFIT, 0.2);
         break;
      }
      case _GET_TRADED_TIMEFRAME:
      {
         result = _TIMEFRAME;
         break;
      }
   }
      
   return(result);
}
//------------------------------------------------------------------//------------------------------------------------------------------
double Strategy_012(int COMMAND)
{
   string   _SYMBOL        = Symbol();
  int      _TIMEFRAME     = getStrategyTimeframeByNumber(_STRATEGY_TIMEFRAME);
 //  int      _TIMEFRAME     = _TIMEFRAME;
   int      _TIMEFRAME_2   = HigherTimeframe(_TIMEFRAME);
   int      _SLOWEMA       = 26;
   int      _FASTEMA       = 12;
   int      _MASIGNAL      = 9;
   int      _MAMETHOD      = MODE_EMA;
   int      _SLOWMA        = 20;
   int      _FASTMA        = 10;
   int      _LONGMA        = LONGMA;
   int      _SHIFT         = 0;
   int      _PRICE         = PRICE_OPEN;

   double   result         = 0;
   
   double   MAFast;
   double   MASlow;
   double   MALong;
   double   MACDHistogram;
   double   MACDSignal;
   double   MAFast1;
   double   MASlow1;
   double   MALong1;
   double   MACDHistogram1;
   double   MACDSignal1;
   double   MAFast2;
   double   MASlow2;
   double   MALong2;
   double   MACDHistogram2;
   double   MACDSignal2;
   double   T2_MACDHistogram;
   double   T2_MACDSignal;
   double   UpperFractalHL;
   double   LowerFractalHL;

   int      i;

   switch(COMMAND)
   {
/*
#define     _CLOSE_LONG                   1
#define     _CLOSE_SHORT                  2
#define     _OPEN_LONG                    3
#define     _OPEN_SHORT                   4
#define     _GET_LONG_STOPLOSS_PRICE      5
#define     _GET_SHORT_STOPLOSS_PRICE     6
#define     _GET_LONG_TAKEPROFIT_PRICE    7
#define     _GET_SHORT_TAKEPROFIT_PRICE   8
#define     _GET_LOTS                     9
#define     _GET_TRAILED_STOPLOSS_PRICE   10
#define     _GET_TRAILED_TAKEPROFIT_PRICE 11
#define     _GET_TRADED_TIMEFRAME         12
*/
      case _OPEN_LONG:
      {
//         _PRICE = PRICE_LOW;
         
         MAFast = iMA(_SYMBOL, _TIMEFRAME, _FASTMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MASlow = iMA(_SYMBOL, _TIMEFRAME, _SLOWMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MALong = iMA(_SYMBOL, _TIMEFRAME, _LONGMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MACDHistogram = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT);
         MACDSignal = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT);

         MAFast1 = iMA(_SYMBOL, _TIMEFRAME, _FASTMA, 0, _MAMETHOD, _PRICE, _SHIFT + 1);
         MASlow1 = iMA(_SYMBOL, _TIMEFRAME, _SLOWMA, 0, _MAMETHOD, _PRICE, _SHIFT + 1);
         MALong1 = iMA(_SYMBOL, _TIMEFRAME, _LONGMA, 0, _MAMETHOD, _PRICE, _SHIFT + 1);
         MACDHistogram1 = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT + 1);
         MACDSignal1 = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT + 1);

         MAFast2 = iMA(_SYMBOL, _TIMEFRAME, _FASTMA, 0, _MAMETHOD, _PRICE, _SHIFT + 2);
         MASlow2 = iMA(_SYMBOL, _TIMEFRAME, _SLOWMA, 0, _MAMETHOD, _PRICE, _SHIFT + 2);
         MALong2 = iMA(_SYMBOL, _TIMEFRAME, _LONGMA, 0, _MAMETHOD, _PRICE, _SHIFT + 2);
         MACDHistogram2 = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT + 2);
         MACDSignal2 = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT + 2);

         T2_MACDHistogram = iMACD(_SYMBOL, _TIMEFRAME_2, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT);
         T2_MACDSignal = iMACD(_SYMBOL, _TIMEFRAME_2, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT);

         UpperFractalHL = getLastFractalValue(_SYMBOL, _TIMEFRAME_2, true);
         LowerFractalHL = getLastFractalValue(_SYMBOL, _TIMEFRAME_2, true);

//         if(MACDHistogram < MACDSignal)
         if(MACDHistogram > MACDSignal)
         if(MACDHistogram < 0)
//         if(MACDHistogram > 0)
//         if(MACDSignal < 0)

//         if(MACDHistogram1 > MACDHistogram2)
//         if(MACDSignal1 < MACDSignal2)
//         if(MACDHistogram1 <= MACDSignal1)
//         if(MACDHistogram1 < 0)
//         if(MACDSignal1 < 0)

//         if(MACDHistogram2 < MACDSignal2)
//         if(MACDHistogram2 > MACDSignal2)
//         if(MACDHistogram2 > 0)
//         if(MACDHistogram2 < 0)
//         if(MACDSignal2 < 0)
//         if(MACDSignal2 > 0)

//         if(MAFast1 < MASlow1 && MAFast > MASlow)
//         if(MAFast > MASlow)
//         if(MAFast1 > MASlow1)

         if(Ask > MALong)
//         if(MAFast > MALong)
//         if(MALong1 < MALong)
//         if(MALong2 < MALong1)

//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, true) < getPreviousFractalValue(_SYMBOL, _TIMEFRAME, true))
//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, true) > getPreviousFractalValue(_SYMBOL, _TIMEFRAME, true))
//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, false) > getPreviousFractalValue(_SYMBOL, _TIMEFRAME, false))
//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, false) < getPreviousFractalValue(_SYMBOL, _TIMEFRAME, false))
//         if(MathAbs(getLastFractalValue(_SYMBOL, _TIMEFRAME, true) - getLastFractalValue(_SYMBOL, _TIMEFRAME, false)) < MathAbs(getPreviousFractalValue(_SYMBOL, _TIMEFRAME, true) - getPreviousFractalValue(_SYMBOL, _TIMEFRAME, false)))
//         if(Ask > getLastFractalValue(_SYMBOL, _TIMEFRAME, true))
//         if(Ask < getLastFractalValue(_SYMBOL, _TIMEFRAME, true))

         if(Ask > UpperFractalHL - 10*Point && Low[0] < UpperFractalHL)
            result = 1;
                  
         break;
      }
      case _OPEN_SHORT:
      {
//         _PRICE = PRICE_HIGH;
         
         MAFast = iMA(_SYMBOL, _TIMEFRAME, _FASTMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MASlow = iMA(_SYMBOL, _TIMEFRAME, _SLOWMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MALong = iMA(_SYMBOL, _TIMEFRAME, _LONGMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MACDHistogram = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT);
         MACDSignal = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT);

         MAFast1 = iMA(_SYMBOL, _TIMEFRAME, _FASTMA, 0, _MAMETHOD, _PRICE, _SHIFT + 1);
         MASlow1 = iMA(_SYMBOL, _TIMEFRAME, _SLOWMA, 0, _MAMETHOD, _PRICE, _SHIFT + 1);
         MALong1 = iMA(_SYMBOL, _TIMEFRAME, _LONGMA, 0, _MAMETHOD, _PRICE, _SHIFT + 1);
         MACDHistogram1 = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT + 1);
         MACDSignal1 = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT + 1);

         MAFast2 = iMA(_SYMBOL, _TIMEFRAME, _FASTMA, 0, _MAMETHOD, _PRICE, _SHIFT + 2);
         MASlow2 = iMA(_SYMBOL, _TIMEFRAME, _SLOWMA, 0, _MAMETHOD, _PRICE, _SHIFT + 2);
         MALong2 = iMA(_SYMBOL, _TIMEFRAME, _LONGMA, 0, _MAMETHOD, _PRICE, _SHIFT + 2);
         MACDHistogram2 = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT + 2);
         MACDSignal2 = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT + 2);

         T2_MACDHistogram = iMACD(_SYMBOL, _TIMEFRAME_2, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT);
         T2_MACDSignal = iMACD(_SYMBOL, _TIMEFRAME_2, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT);

         UpperFractalHL = getLastFractalValue(_SYMBOL, _TIMEFRAME_2, true);
         LowerFractalHL = getLastFractalValue(_SYMBOL, _TIMEFRAME_2, true);

//         if(MACDHistogram > MACDSignal)
         if(MACDHistogram < MACDSignal)
         if(MACDHistogram > 0)
//         if(MACDHistogram < 0)
//         if(MACDSignal > 0)

//       if(MACDHistogram1 < MACDHistogram2)
//       if(MACDSignal1 > MACDSignal2)
//       if(MACDHistogram1 >= MACDSignal1)
//       if(MACDHistogram1 > 0)
//       if(MACDSignal1 > 0)

//         if(MACDHistogram2 > MACDSignal2)
//         if(MACDHistogram2 < MACDSignal2)
//         if(MACDHistogram2 < 0)
//         if(MACDHistogram2 > 0)
//         if(MACDSignal2 > 0)
//         if(MACDSignal2 < 0)

//         if(MAFast1 > MASlow1 && MAFast < MASlow)
//         if(MAFast < MASlow)
//         if(MAFast1 < MASlow1)

         if(Bid < MALong)
//         if(MAFast < MALong)
//         if(MALong1 > MALong)
//        if(MALong2 > MALong1)

//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, true) < getPreviousFractalValue(_SYMBOL, _TIMEFRAME, true))
//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, true) > getPreviousFractalValue(_SYMBOL, _TIMEFRAME, true))
//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, false) > getPreviousFractalValue(_SYMBOL, _TIMEFRAME, false))
//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, false) < getPreviousFractalValue(_SYMBOL, _TIMEFRAME, false))
//         if(MathAbs(getLastFractalValue(_SYMBOL, _TIMEFRAME, true) - getLastFractalValue(_SYMBOL, _TIMEFRAME, false)) < MathAbs(getPreviousFractalValue(_SYMBOL, _TIMEFRAME, true) - getPreviousFractalValue(_SYMBOL, _TIMEFRAME, false)))
//         if(Bid < getLastFractalValue(_SYMBOL, _TIMEFRAME, false))
//         if(Bid > getLastFractalValue(_SYMBOL, _TIMEFRAME, false))

         if(Bid < LowerFractalHL + 10*Point && High[0] > LowerFractalHL)
            result = 1;
                  
         break;
      }
      case _CLOSE_LONG:
      {
         break;
         
         MAFast = iMA(_SYMBOL, _TIMEFRAME, _FASTMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MASlow = iMA(_SYMBOL, _TIMEFRAME, _SLOWMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MALong = iMA(_SYMBOL, _TIMEFRAME, _LONGMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MACDHistogram = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT);
         MACDSignal = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT);

         MAFast1 = iMA(_SYMBOL, _TIMEFRAME, _FASTMA, 0, _MAMETHOD, _PRICE, _SHIFT + 1);
         MASlow1 = iMA(_SYMBOL, _TIMEFRAME, _SLOWMA, 0, _MAMETHOD, _PRICE, _SHIFT + 1);
         MALong1 = iMA(_SYMBOL, _TIMEFRAME, _LONGMA, 0, _MAMETHOD, _PRICE, _SHIFT + 1);
         MACDHistogram1 = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT + 1);
         MACDSignal1 = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT + 1);

         MAFast2 = iMA(_SYMBOL, _TIMEFRAME, _FASTMA, 0, _MAMETHOD, _PRICE, _SHIFT + 2);
         MASlow2 = iMA(_SYMBOL, _TIMEFRAME, _SLOWMA, 0, _MAMETHOD, _PRICE, _SHIFT + 2);
         MALong2 = iMA(_SYMBOL, _TIMEFRAME, _LONGMA, 0, _MAMETHOD, _PRICE, _SHIFT + 2);
         MACDHistogram2 = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT + 2);
         MACDSignal2 = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT + 2);

//         if(MACDHistogram < MACDSignal)
//         if(MACDHistogram > 0)
//         if(MACDHistogram < 0)
//         if(MACDSignal > 0)

//         if(MACDHistogram1 >= MACDSignal1)

//         if(MACDHistogram2 > MACDSignal2)
//         if(MACDHistogram2 < MACDSignal2)
//         if(MACDHistogram2 < 0)
//         if(MACDHistogram2 > 0)
//         if(MACDSignal2 > 0)
//         if(MACDSignal2 < 0)

//         if(MAFast1 > MASlow1 && MAFast < MASlow)
//         if(MAFast < MASlow)

//         if(Bid < MALong)
//         if(MAFast < MALong)
//         if(MALong1 > MALong)

//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, true) < getPreviousFractalValue(_SYMBOL, _TIMEFRAME, true))
//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, true) > getPreviousFractalValue(_SYMBOL, _TIMEFRAME, true))
//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, false) > getPreviousFractalValue(_SYMBOL, _TIMEFRAME, false))
//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, false) < getPreviousFractalValue(_SYMBOL, _TIMEFRAME, false))
//         if(MathAbs(getLastFractalValue(_SYMBOL, _TIMEFRAME, true) - getLastFractalValue(_SYMBOL, _TIMEFRAME, false)) < MathAbs(getPreviousFractalValue(_SYMBOL, _TIMEFRAME, true) - getPreviousFractalValue(_SYMBOL, _TIMEFRAME, false)))
//         if(Bid < getLastFractalValue(_SYMBOL, _TIMEFRAME, false))
//         if(Bid > getLastFractalValue(_SYMBOL, _TIMEFRAME, false))
         if(Bid > getLastFractalValue(_SYMBOL, _TIMEFRAME, true))
            result = 1;

         break;
         
         if(OrdersTotal() == 1)
         {
            OrderSelect(0, SELECT_BY_POS);
            if(OrderMagicNumber() != _MAGICNUMBER)
               break;
            if(OrderProfit() > 0)
            {
               if(OrderType() == OP_BUY)
               {
                  if(iHigh(_SYMBOL, _TIMEFRAME, 2) > iHigh(_SYMBOL, _TIMEFRAME, 1))
//                  if(iHigh(_SYMBOL, _TIMEFRAME, 1) > iHigh(_SYMBOL, _TIMEFRAME, 0))
                      result = 1;
               }
            }
         }

         break;
         
         if(OrdersTotal() == 1)
         {
            OrderSelect(0, SELECT_BY_POS);
            if(OrderMagicNumber() != _MAGICNUMBER)
               break;
            if(OrderProfit() > 0)
            {
               if(OrderType() == OP_BUY)
               {
                  if(Bid < iLow(_SYMBOL, _TIMEFRAME, 1))
                      result = 1;
               }
            }
         }

         break;
         
         if(OrdersTotal() == 1)
         {
            OrderSelect(0, SELECT_BY_POS);
            if(OrderMagicNumber() != _MAGICNUMBER)
               break;
            if(OrderProfit() > 0)
            {
               if(OrderType() == OP_BUY)
               {
                  if(getLastFractalValue(_SYMBOL, _TIMEFRAME, false) < getPreviousFractalValue(_SYMBOL, _TIMEFRAME, false))
                     result = 1;
               }
            }
         }
         
         break;
      }
      case _CLOSE_SHORT:
      {
         break;

         MAFast = iMA(_SYMBOL, _TIMEFRAME, _FASTMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MASlow = iMA(_SYMBOL, _TIMEFRAME, _SLOWMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MALong = iMA(_SYMBOL, _TIMEFRAME, _LONGMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MACDHistogram = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT);
         MACDSignal = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT);

         MAFast1 = iMA(_SYMBOL, _TIMEFRAME, _FASTMA, 0, _MAMETHOD, _PRICE, _SHIFT + 1);
         MASlow1 = iMA(_SYMBOL, _TIMEFRAME, _SLOWMA, 0, _MAMETHOD, _PRICE, _SHIFT + 1);
         MALong1 = iMA(_SYMBOL, _TIMEFRAME, _LONGMA, 0, _MAMETHOD, _PRICE, _SHIFT + 1);
         MACDHistogram1 = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT + 1);
         MACDSignal1 = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT + 1);

         MAFast2 = iMA(_SYMBOL, _TIMEFRAME, _FASTMA, 0, _MAMETHOD, _PRICE, _SHIFT + 2);
         MASlow2 = iMA(_SYMBOL, _TIMEFRAME, _SLOWMA, 0, _MAMETHOD, _PRICE, _SHIFT + 2);
         MALong2 = iMA(_SYMBOL, _TIMEFRAME, _LONGMA, 0, _MAMETHOD, _PRICE, _SHIFT + 2);
         MACDHistogram2 = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT + 2);
         MACDSignal2 = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT + 2);

//         if(MACDHistogram > MACDSignal)
//         if(MACDHistogram < 0)
//         if(MACDHistogram > 0)
//         if(MACDSignal < 0)

//         if(MACDHistogram1 <= MACDSignal1)

//         if(MACDHistogram2 < MACDSignal2)
//         if(MACDHistogram2 > MACDSignal2)
//         if(MACDHistogram2 > 0)
//         if(MACDHistogram2 < 0)
//         if(MACDSignal2 < 0)
//         if(MACDSignal2 > 0)

//         if(MAFast1 < MASlow1 && MAFast > MASlow)
//         if(MAFast > MASlow)

//         if(Ask > MALong)
//         if(MAFast > MALong)
//         if(MALong1 < MALong)

//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, true) < getPreviousFractalValue(_SYMBOL, _TIMEFRAME, true))
//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, true) > getPreviousFractalValue(_SYMBOL, _TIMEFRAME, true))
//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, false) > getPreviousFractalValue(_SYMBOL, _TIMEFRAME, false))
//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, false) < getPreviousFractalValue(_SYMBOL, _TIMEFRAME, false))
//         if(MathAbs(getLastFractalValue(_SYMBOL, _TIMEFRAME, true) - getLastFractalValue(_SYMBOL, _TIMEFRAME, false)) < MathAbs(getPreviousFractalValue(_SYMBOL, _TIMEFRAME, true) - getPreviousFractalValue(_SYMBOL, _TIMEFRAME, false)))
//         if(Ask > getLastFractalValue(_SYMBOL, _TIMEFRAME, true))
//         if(Ask < getLastFractalValue(_SYMBOL, _TIMEFRAME, true))
         if(Ask < getLastFractalValue(_SYMBOL, _TIMEFRAME, false))
            result = 1;

         break;
         
         if(OrdersTotal() == 1)
         {
            OrderSelect(0, SELECT_BY_POS);
            if(OrderMagicNumber() != _MAGICNUMBER)
               break;
            if(OrderProfit() > 0)
            {
               if(OrderType() == OP_SELL)
               {
                  if(iLow(_SYMBOL, _TIMEFRAME, 2) < iLow(_SYMBOL, _TIMEFRAME, 1))
//                  if(iLow(_SYMBOL, _TIMEFRAME, 1) > iLow(_SYMBOL, _TIMEFRAME, 0))
                     result = 1;
               }
            }
         }

         break;
         
         if(OrdersTotal() == 1)
         {
            OrderSelect(0, SELECT_BY_POS);
            if(OrderMagicNumber() != _MAGICNUMBER)
               break;
            if(OrderProfit() > 0)
            {
               if(OrderType() == OP_SELL)
               {
                  if(Ask > iHigh(_SYMBOL, _TIMEFRAME, 1))
                     result = 1;
               }
            }
         }

         break;
         
         if(OrdersTotal() == 1)
         {
            OrderSelect(0, SELECT_BY_POS);
            if(OrderMagicNumber() != _MAGICNUMBER)
               break;
            if(OrderProfit() > 0)
            {
               if(OrderType() == OP_SELL)
               {
                  if(getLastFractalValue(_SYMBOL, _TIMEFRAME, true) > getPreviousFractalValue(_SYMBOL, _TIMEFRAME, true))
                     result = 1;
               }
            }
         }
         
         break;
      }
      case _GET_LONG_STOPLOSS_PRICE:
      {
//         break;

         result = getLastFractalValue(_SYMBOL, _TIMEFRAME, false) - 5*Point;
//         result = iLow(_SYMBOL, _TIMEFRAME, 1);

         if(result > Ask - 10*Point)
            result = Ask - 10*Point;

         break;
      }
      case _GET_SHORT_STOPLOSS_PRICE:
      {
//         break;

         result = getLastFractalValue(_SYMBOL, _TIMEFRAME, true) + 5*Point;
//         result = iHigh(_SYMBOL, _TIMEFRAME, 1);

         if(result < Bid + 10*Point)
            result = Bid + 10*Point;
         
         break;
      }
      case _GET_LONG_TAKEPROFIT_PRICE:
      {
         break;
      }
      case _GET_SHORT_TAKEPROFIT_PRICE:
      {
         break;
      }
      case _GET_TRAILED_STOPLOSS_PRICE:
      {
//         break;

         double beq = 0;
         
/*
         if(OrdersTotal() == 1)
         {
            OrderSelect(0, SELECT_BY_POS);
            if(OrderMagicNumber() != _MAGICNUMBER)
               break;
            if(OrderProfit() > 0)
            {
               if(OrderType() == OP_BUY)
               {
                  if(iLow(_SYMBOL, _TIMEFRAME, 1) > OrderOpenPrice())
                     beq = OrderOpenPrice();
                  
                  if(beq > Bid - 10*Point)
                     beq = Bid - 10*Point;
                  
                  if(beq <= OrderStopLoss())
                     beq = OrderStopLoss();
               }
               else
               {
                  if(iHigh(_SYMBOL, _TIMEFRAME, 1) < OrderOpenPrice())
                     beq = OrderOpenPrice();
                  
                  if(beq < Ask + 10*Point)
                     beq = Ask + 10*Point;
                     
                  if(beq >= OrderStopLoss())
                     beq = OrderStopLoss();
               }
            }
         }
*/
         
         if(OrdersTotal() == 1)
         {
            OrderSelect(0, SELECT_BY_POS);
            if(OrderMagicNumber() != _MAGICNUMBER)
               break;
            if(OrderProfit() > 0)
            {
               if(OrderType() == OP_BUY)
               {
//                  result = iLow(_SYMBOL, _TIMEFRAME, 1);
                  result = getLastFractalValue(_SYMBOL, _TIMEFRAME, false) - 5*Point;
                  
                  if(beq > result)
                     result = beq;
                  
                  if(result > Bid - 15*Point)
                     result = Bid - 15*Point;
                  
                  if(result <= OrderStopLoss())
                     result = OrderStopLoss();
               }
               else
               {
//                  result = iHigh(_SYMBOL, _TIMEFRAME, 1);
                  result = getLastFractalValue(_SYMBOL, _TIMEFRAME, true) + 5*Point;
                  
                  if(beq > result)
                     result = beq;

                  if(result < Ask + 15*Point)
                     result = Ask + 15*Point;
                     
                  if(result >= OrderStopLoss())
                     result = OrderStopLoss();
               }
            }
         }
         
         break;
      }      
      case _GET_TRAILED_TAKEPROFIT_PRICE:
      {
         break;
         
         if(OrdersTotal() == 1)
         {
            OrderSelect(0, SELECT_BY_POS);
            if(OrderMagicNumber() != _MAGICNUMBER)
               break;
            if(OrderProfit() > 0)
            {
               if(OrderType() == OP_BUY)
               {
                  result = Bid + MathAbs(Bid - OrderStopLoss());
               }
               else
               {
                  result = Ask - MathAbs(Ask - OrderStopLoss());
               }
            }
         }

         break;
         
         if(OrdersTotal() == 1)
         {
            OrderSelect(0, SELECT_BY_POS);
            if(OrderMagicNumber() != _MAGICNUMBER)
               break;
            if(OrderProfit() > 0)
            {
               if(OrderType() == OP_BUY)
               {
                  result = getLastFractalValue(_SYMBOL, _TIMEFRAME, true);
                  
                  if(result > Bid)
                     result = Bid;
                  
                  if(result <= Bid)
                     result = 0;
               }
               else
               {
                  result = getLastFractalValue(_SYMBOL, _TIMEFRAME, false);
                  
                  if(result < Ask)
                     result = Ask;
                     
                  if(result >= Ask)
                     result = 0;
               }
            }
         }
         
         break;
      }
      case _GET_LOTS:
      {
         result = 0.1;
//         result = GetLots(_MM_FIX_PERC_AVG_LAST_PROFIT, 0.2);
         break;
      }
      case _GET_TRADED_TIMEFRAME:
      {
         result = _TIMEFRAME;
         break;
      }
   }
      
   return(result);
}
//------------------------------------------------------------------//------------------------------------------------------------------
double Strategy_013(int COMMAND)
{
   string   _SYMBOL        = Symbol();
   int      _TIMEFRAME     = getStrategyTimeframeByNumber(_STRATEGY_TIMEFRAME);
//   int      _TIMEFRAME     = _TIMEFRAME;
   int      _TIMEFRAME_2   = HigherTimeframe(_TIMEFRAME);
   int      _SLOWEMA       = 26;
   int      _FASTEMA       = 12;
   int      _MASIGNAL      = 9;
   int      _MAMETHOD      = MODE_EMA;
   int      _SLOWMA        = 20;
   int      _FASTMA        = 10;
   int      _LONGMA        = LONGMA;
   int      _SHIFT         = 0;
   int      _PRICE         = PRICE_OPEN;

   double   result         = 0;
   
   double   MAFast;
   double   MASlow;
   double   MALong;
   double   MACDHistogram;
   double   MACDSignal;
   double   MAFast1;
   double   MASlow1;
   double   MALong1;
   double   MACDHistogram1;
   double   MACDSignal1;
   double   MAFast2;
   double   MASlow2;
   double   MALong2;
   double   MACDHistogram2;
   double   MACDSignal2;
   double   T2_MACDHistogram;
   double   T2_MACDSignal;
   double   UpperFractalHL;
   double   LowerFractalHL;

   int      i;

   switch(COMMAND)
   {
/*
#define     _CLOSE_LONG                   1
#define     _CLOSE_SHORT                  2
#define     _OPEN_LONG                    3
#define     _OPEN_SHORT                   4
#define     _GET_LONG_STOPLOSS_PRICE      5
#define     _GET_SHORT_STOPLOSS_PRICE     6
#define     _GET_LONG_TAKEPROFIT_PRICE    7
#define     _GET_SHORT_TAKEPROFIT_PRICE   8
#define     _GET_LOTS                     9
#define     _GET_TRAILED_STOPLOSS_PRICE   10
#define     _GET_TRAILED_TAKEPROFIT_PRICE 11
#define     _GET_TRADED_TIMEFRAME         12
*/
      case _OPEN_LONG:
      {
//         _PRICE = PRICE_LOW;
         if(!OpenNewBar())
            return(0);
         
         MAFast = iMA(_SYMBOL, _TIMEFRAME, _FASTMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MASlow = iMA(_SYMBOL, _TIMEFRAME, _SLOWMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MALong = iMA(_SYMBOL, _TIMEFRAME, _LONGMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MACDHistogram = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT);
         MACDSignal = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT);

         MAFast1 = iMA(_SYMBOL, _TIMEFRAME, _FASTMA, 0, _MAMETHOD, _PRICE, _SHIFT + 1);
         MASlow1 = iMA(_SYMBOL, _TIMEFRAME, _SLOWMA, 0, _MAMETHOD, _PRICE, _SHIFT + 1);
         MALong1 = iMA(_SYMBOL, _TIMEFRAME, _LONGMA, 0, _MAMETHOD, _PRICE, _SHIFT + 1);
         MACDHistogram1 = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT + 1);
         MACDSignal1 = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT + 1);

         MAFast2 = iMA(_SYMBOL, _TIMEFRAME, _FASTMA, 0, _MAMETHOD, _PRICE, _SHIFT + 2);
         MASlow2 = iMA(_SYMBOL, _TIMEFRAME, _SLOWMA, 0, _MAMETHOD, _PRICE, _SHIFT + 2);
         MALong2 = iMA(_SYMBOL, _TIMEFRAME, _LONGMA, 0, _MAMETHOD, _PRICE, _SHIFT + 2);
         MACDHistogram2 = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT + 2);
         MACDSignal2 = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT + 2);

         T2_MACDHistogram = iMACD(_SYMBOL, _TIMEFRAME_2, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT);
         T2_MACDSignal = iMACD(_SYMBOL, _TIMEFRAME_2, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT);

         UpperFractalHL = getLastFractalValue(_SYMBOL, _TIMEFRAME_2, true);
         LowerFractalHL = getLastFractalValue(_SYMBOL, _TIMEFRAME_2, true);

//         if(MACDHistogram < MACDSignal)
//         if(MACDHistogram > MACDSignal)
//         if(MACDHistogram < 0)
         if(MACDHistogram > 0)
//         if(MACDSignal < 0)

//         if(MACDHistogram1 > MACDHistogram2)
//         if(MACDSignal1 < MACDSignal2)
//         if(MACDHistogram1 <= MACDSignal1)
//         if(MACDHistogram1 < 0)
//         if(MACDSignal1 < 0)

//         if(MACDHistogram2 < MACDSignal2)
//         if(MACDHistogram2 > MACDSignal2)
//         if(MACDHistogram2 > 0)
//         if(MACDHistogram2 < 0)
//         if(MACDSignal2 < 0)
//         if(MACDSignal2 > 0)

//         if(MAFast1 < MASlow1 && MAFast > MASlow)
//         if(MAFast > MASlow)
//         if(MAFast1 > MASlow1)

//         if(Ask > MALong)
//         if(MAFast > MALong)
//         if(MALong1 < MALong)
//         if(MALong2 < MALong1)

//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, true) < getPreviousFractalValue(_SYMBOL, _TIMEFRAME, true))
//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, true) > getPreviousFractalValue(_SYMBOL, _TIMEFRAME, true))
//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, false) > getPreviousFractalValue(_SYMBOL, _TIMEFRAME, false))
//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, false) < getPreviousFractalValue(_SYMBOL, _TIMEFRAME, false))
//         if(MathAbs(getLastFractalValue(_SYMBOL, _TIMEFRAME, true) - getLastFractalValue(_SYMBOL, _TIMEFRAME, false)) < MathAbs(getPreviousFractalValue(_SYMBOL, _TIMEFRAME, true) - getPreviousFractalValue(_SYMBOL, _TIMEFRAME, false)))
//         if(Ask > getLastFractalValue(_SYMBOL, _TIMEFRAME, true))
//         if(Ask < getLastFractalValue(_SYMBOL, _TIMEFRAME, true))

//         if(Ask > UpperFractalHL - 10*Point && Low[0] < UpperFractalHL)
            result = 1;
                  
         break;
      }
      case _OPEN_SHORT:
      {
//         _PRICE = PRICE_HIGH;
         if(!OpenNewBar())
            return(0);
         
         MAFast = iMA(_SYMBOL, _TIMEFRAME, _FASTMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MASlow = iMA(_SYMBOL, _TIMEFRAME, _SLOWMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MALong = iMA(_SYMBOL, _TIMEFRAME, _LONGMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MACDHistogram = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT);
         MACDSignal = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT);

         MAFast1 = iMA(_SYMBOL, _TIMEFRAME, _FASTMA, 0, _MAMETHOD, _PRICE, _SHIFT + 1);
         MASlow1 = iMA(_SYMBOL, _TIMEFRAME, _SLOWMA, 0, _MAMETHOD, _PRICE, _SHIFT + 1);
         MALong1 = iMA(_SYMBOL, _TIMEFRAME, _LONGMA, 0, _MAMETHOD, _PRICE, _SHIFT + 1);
         MACDHistogram1 = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT + 1);
         MACDSignal1 = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT + 1);

         MAFast2 = iMA(_SYMBOL, _TIMEFRAME, _FASTMA, 0, _MAMETHOD, _PRICE, _SHIFT + 2);
         MASlow2 = iMA(_SYMBOL, _TIMEFRAME, _SLOWMA, 0, _MAMETHOD, _PRICE, _SHIFT + 2);
         MALong2 = iMA(_SYMBOL, _TIMEFRAME, _LONGMA, 0, _MAMETHOD, _PRICE, _SHIFT + 2);
         MACDHistogram2 = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT + 2);
         MACDSignal2 = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT + 2);

         T2_MACDHistogram = iMACD(_SYMBOL, _TIMEFRAME_2, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT);
         T2_MACDSignal = iMACD(_SYMBOL, _TIMEFRAME_2, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT);

         UpperFractalHL = getLastFractalValue(_SYMBOL, _TIMEFRAME_2, true);
         LowerFractalHL = getLastFractalValue(_SYMBOL, _TIMEFRAME_2, true);

//         if(MACDHistogram > MACDSignal)
//         if(MACDHistogram < MACDSignal)
//         if(MACDHistogram > 0)
         if(MACDHistogram < 0)
//         if(MACDSignal > 0)

//       if(MACDHistogram1 < MACDHistogram2)
//       if(MACDSignal1 > MACDSignal2)
//       if(MACDHistogram1 >= MACDSignal1)
//       if(MACDHistogram1 > 0)
//       if(MACDSignal1 > 0)

//         if(MACDHistogram2 > MACDSignal2)
//         if(MACDHistogram2 < MACDSignal2)
//         if(MACDHistogram2 < 0)
//         if(MACDHistogram2 > 0)
//         if(MACDSignal2 > 0)
//         if(MACDSignal2 < 0)

//         if(MAFast1 > MASlow1 && MAFast < MASlow)
//         if(MAFast < MASlow)
//         if(MAFast1 < MASlow1)

//         if(Bid < MALong)
//         if(MAFast < MALong)
//         if(MALong1 > MALong)
//        if(MALong2 > MALong1)

//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, true) < getPreviousFractalValue(_SYMBOL, _TIMEFRAME, true))
//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, true) > getPreviousFractalValue(_SYMBOL, _TIMEFRAME, true))
//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, false) > getPreviousFractalValue(_SYMBOL, _TIMEFRAME, false))
//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, false) < getPreviousFractalValue(_SYMBOL, _TIMEFRAME, false))
//         if(MathAbs(getLastFractalValue(_SYMBOL, _TIMEFRAME, true) - getLastFractalValue(_SYMBOL, _TIMEFRAME, false)) < MathAbs(getPreviousFractalValue(_SYMBOL, _TIMEFRAME, true) - getPreviousFractalValue(_SYMBOL, _TIMEFRAME, false)))
//         if(Bid < getLastFractalValue(_SYMBOL, _TIMEFRAME, false))
//         if(Bid > getLastFractalValue(_SYMBOL, _TIMEFRAME, false))

//         if(Bid < LowerFractalHL + 10*Point && High[0] > LowerFractalHL)
            result = 1;
                  
         break;
      }
      case _CLOSE_LONG:
      {
//         break;
         if(!OpenNewBar())
            return(0);
         
         MAFast = iMA(_SYMBOL, _TIMEFRAME, _FASTMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MASlow = iMA(_SYMBOL, _TIMEFRAME, _SLOWMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MALong = iMA(_SYMBOL, _TIMEFRAME, _LONGMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MACDHistogram = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT);
         MACDSignal = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT);

         MAFast1 = iMA(_SYMBOL, _TIMEFRAME, _FASTMA, 0, _MAMETHOD, _PRICE, _SHIFT + 1);
         MASlow1 = iMA(_SYMBOL, _TIMEFRAME, _SLOWMA, 0, _MAMETHOD, _PRICE, _SHIFT + 1);
         MALong1 = iMA(_SYMBOL, _TIMEFRAME, _LONGMA, 0, _MAMETHOD, _PRICE, _SHIFT + 1);
         MACDHistogram1 = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT + 1);
         MACDSignal1 = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT + 1);

         MAFast2 = iMA(_SYMBOL, _TIMEFRAME, _FASTMA, 0, _MAMETHOD, _PRICE, _SHIFT + 2);
         MASlow2 = iMA(_SYMBOL, _TIMEFRAME, _SLOWMA, 0, _MAMETHOD, _PRICE, _SHIFT + 2);
         MALong2 = iMA(_SYMBOL, _TIMEFRAME, _LONGMA, 0, _MAMETHOD, _PRICE, _SHIFT + 2);
         MACDHistogram2 = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT + 2);
         MACDSignal2 = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT + 2);

//         if(MACDHistogram < MACDSignal)
//         if(MACDHistogram > 0)
         if(MACDHistogram < 0)
//         if(MACDSignal > 0)

//         if(MACDHistogram1 >= MACDSignal1)

//         if(MACDHistogram2 > MACDSignal2)
//         if(MACDHistogram2 < MACDSignal2)
//         if(MACDHistogram2 < 0)
//         if(MACDHistogram2 > 0)
//         if(MACDSignal2 > 0)
//         if(MACDSignal2 < 0)

//         if(MAFast1 > MASlow1 && MAFast < MASlow)
//         if(MAFast < MASlow)

//         if(Bid < MALong)
//         if(MAFast < MALong)
//         if(MALong1 > MALong)

//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, true) < getPreviousFractalValue(_SYMBOL, _TIMEFRAME, true))
//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, true) > getPreviousFractalValue(_SYMBOL, _TIMEFRAME, true))
//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, false) > getPreviousFractalValue(_SYMBOL, _TIMEFRAME, false))
//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, false) < getPreviousFractalValue(_SYMBOL, _TIMEFRAME, false))
//         if(MathAbs(getLastFractalValue(_SYMBOL, _TIMEFRAME, true) - getLastFractalValue(_SYMBOL, _TIMEFRAME, false)) < MathAbs(getPreviousFractalValue(_SYMBOL, _TIMEFRAME, true) - getPreviousFractalValue(_SYMBOL, _TIMEFRAME, false)))
//         if(Bid < getLastFractalValue(_SYMBOL, _TIMEFRAME, false))
//         if(Bid > getLastFractalValue(_SYMBOL, _TIMEFRAME, false))
//         if(Bid > getLastFractalValue(_SYMBOL, _TIMEFRAME, true))
            result = 1;

         break;
         
         if(OrdersTotal() == 1)
         {
            OrderSelect(0, SELECT_BY_POS);
            if(OrderMagicNumber() != _MAGICNUMBER)
               break;
            if(OrderProfit() > 0)
            {
               if(OrderType() == OP_BUY)
               {
                  if(iHigh(_SYMBOL, _TIMEFRAME, 2) > iHigh(_SYMBOL, _TIMEFRAME, 1))
//                  if(iHigh(_SYMBOL, _TIMEFRAME, 1) > iHigh(_SYMBOL, _TIMEFRAME, 0))
                      result = 1;
               }
            }
         }

         break;
         
         if(OrdersTotal() == 1)
         {
            OrderSelect(0, SELECT_BY_POS);
            if(OrderMagicNumber() != _MAGICNUMBER)
               break;
            if(OrderProfit() > 0)
            {
               if(OrderType() == OP_BUY)
               {
                  if(Bid < iLow(_SYMBOL, _TIMEFRAME, 1))
                      result = 1;
               }
            }
         }

         break;
         
         if(OrdersTotal() == 1)
         {
            OrderSelect(0, SELECT_BY_POS);
            if(OrderMagicNumber() != _MAGICNUMBER)
               break;
            if(OrderProfit() > 0)
            {
               if(OrderType() == OP_BUY)
               {
                  if(getLastFractalValue(_SYMBOL, _TIMEFRAME, false) < getPreviousFractalValue(_SYMBOL, _TIMEFRAME, false))
                     result = 1;
               }
            }
         }
         
         break;
      }
      case _CLOSE_SHORT:
      {
//         break;
         if(!OpenNewBar())
            return(0);

         MAFast = iMA(_SYMBOL, _TIMEFRAME, _FASTMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MASlow = iMA(_SYMBOL, _TIMEFRAME, _SLOWMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MALong = iMA(_SYMBOL, _TIMEFRAME, _LONGMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MACDHistogram = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT);
         MACDSignal = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT);

         MAFast1 = iMA(_SYMBOL, _TIMEFRAME, _FASTMA, 0, _MAMETHOD, _PRICE, _SHIFT + 1);
         MASlow1 = iMA(_SYMBOL, _TIMEFRAME, _SLOWMA, 0, _MAMETHOD, _PRICE, _SHIFT + 1);
         MALong1 = iMA(_SYMBOL, _TIMEFRAME, _LONGMA, 0, _MAMETHOD, _PRICE, _SHIFT + 1);
         MACDHistogram1 = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT + 1);
         MACDSignal1 = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT + 1);

         MAFast2 = iMA(_SYMBOL, _TIMEFRAME, _FASTMA, 0, _MAMETHOD, _PRICE, _SHIFT + 2);
         MASlow2 = iMA(_SYMBOL, _TIMEFRAME, _SLOWMA, 0, _MAMETHOD, _PRICE, _SHIFT + 2);
         MALong2 = iMA(_SYMBOL, _TIMEFRAME, _LONGMA, 0, _MAMETHOD, _PRICE, _SHIFT + 2);
         MACDHistogram2 = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT + 2);
         MACDSignal2 = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT + 2);

//         if(MACDHistogram > MACDSignal)
//         if(MACDHistogram < 0)
         if(MACDHistogram > 0)
//         if(MACDSignal < 0)

//         if(MACDHistogram1 <= MACDSignal1)

//         if(MACDHistogram2 < MACDSignal2)
//         if(MACDHistogram2 > MACDSignal2)
//         if(MACDHistogram2 > 0)
//         if(MACDHistogram2 < 0)
//         if(MACDSignal2 < 0)
//         if(MACDSignal2 > 0)

//         if(MAFast1 < MASlow1 && MAFast > MASlow)
//         if(MAFast > MASlow)

//         if(Ask > MALong)
//         if(MAFast > MALong)
//         if(MALong1 < MALong)

//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, true) < getPreviousFractalValue(_SYMBOL, _TIMEFRAME, true))
//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, true) > getPreviousFractalValue(_SYMBOL, _TIMEFRAME, true))
//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, false) > getPreviousFractalValue(_SYMBOL, _TIMEFRAME, false))
//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, false) < getPreviousFractalValue(_SYMBOL, _TIMEFRAME, false))
//         if(MathAbs(getLastFractalValue(_SYMBOL, _TIMEFRAME, true) - getLastFractalValue(_SYMBOL, _TIMEFRAME, false)) < MathAbs(getPreviousFractalValue(_SYMBOL, _TIMEFRAME, true) - getPreviousFractalValue(_SYMBOL, _TIMEFRAME, false)))
//         if(Ask > getLastFractalValue(_SYMBOL, _TIMEFRAME, true))
//         if(Ask < getLastFractalValue(_SYMBOL, _TIMEFRAME, true))
//         if(Ask < getLastFractalValue(_SYMBOL, _TIMEFRAME, false))
            result = 1;

         break;
         
         if(OrdersTotal() == 1)
         {
            OrderSelect(0, SELECT_BY_POS);
            if(OrderMagicNumber() != _MAGICNUMBER)
               break;
            if(OrderProfit() > 0)
            {
               if(OrderType() == OP_SELL)
               {
                  if(iLow(_SYMBOL, _TIMEFRAME, 2) < iLow(_SYMBOL, _TIMEFRAME, 1))
//                  if(iLow(_SYMBOL, _TIMEFRAME, 1) > iLow(_SYMBOL, _TIMEFRAME, 0))
                     result = 1;
               }
            }
         }

         break;
         
         if(OrdersTotal() == 1)
         {
            OrderSelect(0, SELECT_BY_POS);
            if(OrderMagicNumber() != _MAGICNUMBER)
               break;
            if(OrderProfit() > 0)
            {
               if(OrderType() == OP_SELL)
               {
                  if(Ask > iHigh(_SYMBOL, _TIMEFRAME, 1))
                     result = 1;
               }
            }
         }

         break;
         
         if(OrdersTotal() == 1)
         {
            OrderSelect(0, SELECT_BY_POS);
            if(OrderMagicNumber() != _MAGICNUMBER)
               break;
            if(OrderProfit() > 0)
            {
               if(OrderType() == OP_SELL)
               {
                  if(getLastFractalValue(_SYMBOL, _TIMEFRAME, true) > getPreviousFractalValue(_SYMBOL, _TIMEFRAME, true))
                     result = 1;
               }
            }
         }
         
         break;
      }
      case _GET_LONG_STOPLOSS_PRICE:
      {
         break;

         result = getLastFractalValue(_SYMBOL, _TIMEFRAME, false) - 5*Point;
//         result = iLow(_SYMBOL, _TIMEFRAME, 1);

         if(result > Ask - 10*Point)
            result = Ask - 10*Point;

         break;
      }
      case _GET_SHORT_STOPLOSS_PRICE:
      {
         break;

         result = getLastFractalValue(_SYMBOL, _TIMEFRAME, true) + 5*Point;
//         result = iHigh(_SYMBOL, _TIMEFRAME, 1);

         if(result < Bid + 10*Point)
            result = Bid + 10*Point;
         
         break;
      }
      case _GET_LONG_TAKEPROFIT_PRICE:
      {
         break;
      }
      case _GET_SHORT_TAKEPROFIT_PRICE:
      {
         break;
      }
      case _GET_TRAILED_STOPLOSS_PRICE:
      {
         break;

         double beq = 0;
         
/*
         if(OrdersTotal() == 1)
         {
            OrderSelect(0, SELECT_BY_POS);
            if(OrderMagicNumber() != _MAGICNUMBER)
               break;
            if(OrderProfit() > 0)
            {
               if(OrderType() == OP_BUY)
               {
                  if(iLow(_SYMBOL, _TIMEFRAME, 1) > OrderOpenPrice())
                     beq = OrderOpenPrice();
                  
                  if(beq > Bid - 10*Point)
                     beq = Bid - 10*Point;
                  
                  if(beq <= OrderStopLoss())
                     beq = OrderStopLoss();
               }
               else
               {
                  if(iHigh(_SYMBOL, _TIMEFRAME, 1) < OrderOpenPrice())
                     beq = OrderOpenPrice();
                  
                  if(beq < Ask + 10*Point)
                     beq = Ask + 10*Point;
                     
                  if(beq >= OrderStopLoss())
                     beq = OrderStopLoss();
               }
            }
         }
*/
         
         if(OrdersTotal() == 1)
         {
            OrderSelect(0, SELECT_BY_POS);
            if(OrderMagicNumber() != _MAGICNUMBER)
               break;
            if(OrderProfit() > 0)
            {
               if(OrderType() == OP_BUY)
               {
//                  result = iLow(_SYMBOL, _TIMEFRAME, 1);
                  result = getLastFractalValue(_SYMBOL, _TIMEFRAME, false) - 5*Point;
                  
                  if(beq > result)
                     result = beq;
                  
                  if(result > Bid - 15*Point)
                     result = Bid - 15*Point;
                  
                  if(result <= OrderStopLoss())
                     result = OrderStopLoss();
               }
               else
               {
//                  result = iHigh(_SYMBOL, _TIMEFRAME, 1);
                  result = getLastFractalValue(_SYMBOL, _TIMEFRAME, true) + 5*Point;
                  
                  if(beq > result)
                     result = beq;

                  if(result < Ask + 15*Point)
                     result = Ask + 15*Point;
                     
                  if(result >= OrderStopLoss())
                     result = OrderStopLoss();
               }
            }
         }
         
         break;
      }      
      case _GET_TRAILED_TAKEPROFIT_PRICE:
      {
         break;
         
         if(OrdersTotal() == 1)
         {
            OrderSelect(0, SELECT_BY_POS);
            if(OrderMagicNumber() != _MAGICNUMBER)
               break;
            if(OrderProfit() > 0)
            {
               if(OrderType() == OP_BUY)
               {
                  result = Bid + MathAbs(Bid - OrderStopLoss());
               }
               else
               {
                  result = Ask - MathAbs(Ask - OrderStopLoss());
               }
            }
         }

         break;
         
         if(OrdersTotal() == 1)
         {
            OrderSelect(0, SELECT_BY_POS);
            if(OrderMagicNumber() != _MAGICNUMBER)
               break;
            if(OrderProfit() > 0)
            {
               if(OrderType() == OP_BUY)
               {
                  result = getLastFractalValue(_SYMBOL, _TIMEFRAME, true);
                  
                  if(result > Bid)
                     result = Bid;
                  
                  if(result <= Bid)
                     result = 0;
               }
               else
               {
                  result = getLastFractalValue(_SYMBOL, _TIMEFRAME, false);
                  
                  if(result < Ask)
                     result = Ask;
                     
                  if(result >= Ask)
                     result = 0;
               }
            }
         }
         
         break;
      }
      case _GET_LOTS:
      {
         result = 0.1;
//         result = GetLots(_MM_FIX_PERC_AVG_LAST_PROFIT, 0.2);
         break;
      }
      case _GET_TRADED_TIMEFRAME:
      {
         result = _TIMEFRAME;
         break;
      }
   }
      
   return(result);
}
//------------------------------------------------------------------//------------------------------------------------------------------
double Strategy_014(int COMMAND)
{
   string   _SYMBOL        = Symbol();
   int      _TIMEFRAME     = getStrategyTimeframeByNumber(_STRATEGY_TIMEFRAME);
//   int      _TIMEFRAME_2   = HigherTimeframe(HigherTimeframe(HigherTimeframe(_TIMEFRAME)));
   int      _TIMEFRAME_2   = _TIMEFRAME;
   int      _SHIFT         = 0;
   int      _PRICE         = PRICE_OPEN;

   double   result         = 0;
   
   double   UpperFractal1;
   double   LowerFractal1;
   datetime UpperFractalTime1;
   datetime LowerFractalTime1;
   int      UpperFractalShift1;
   int      LowerFractalShift1;
   double   UpperFractal2;
   double   LowerFractal2;
   datetime UpperFractalTime2;
   datetime LowerFractalTime2;
   int      UpperFractalShift2;
   int      LowerFractalShift2;

   int      i;

   switch(COMMAND)
   {
/*
#define     _CLOSE_LONG                   1
#define     _CLOSE_SHORT                  2
#define     _OPEN_LONG                    3
#define     _OPEN_SHORT                   4
#define     _GET_LONG_STOPLOSS_PRICE      5
#define     _GET_SHORT_STOPLOSS_PRICE     6
#define     _GET_LONG_TAKEPROFIT_PRICE    7
#define     _GET_SHORT_TAKEPROFIT_PRICE   8
#define     _GET_LOTS                     9
#define     _GET_TRAILED_STOPLOSS_PRICE   10
#define     _GET_TRAILED_TAKEPROFIT_PRICE 11
#define     _GET_TRADED_TIMEFRAME         12
*/
      case _OPEN_LONG:
      {
//         if(!OpenNewBar())
//            return(0);
         
/*
         UpperFractal1 = getLastFractalValue(_SYMBOL, _TIMEFRAME, true);
         UpperFractalTime1 = getLastFractalTime(_SYMBOL, _TIMEFRAME, true);
         UpperFractal2 = getPreviousFractalValue(_SYMBOL, _TIMEFRAME, true);
         UpperFractalTime2 = getPreviousFractalTime(_SYMBOL, _TIMEFRAME, true);

         UpperFractalShift1 = iBarShift(_SYMBOL, _TIMEFRAME, UpperFractalTime1);
         UpperFractalShift2 = iBarShift(_SYMBOL, _TIMEFRAME, UpperFractalTime2);
*/
         UpperFractal1 = getLastFractalValue(_SYMBOL, _TIMEFRAME_2, true);
         UpperFractalTime1 = getLastFractalTime(_SYMBOL, _TIMEFRAME_2, true);
         UpperFractal2 = getPreviousFractalValue(_SYMBOL, _TIMEFRAME_2, true);
         UpperFractalTime2 = getPreviousFractalTime(_SYMBOL, _TIMEFRAME_2, true);

         UpperFractalShift1 = iBarShift(_SYMBOL, _TIMEFRAME, UpperFractalTime1);
         UpperFractalShift2 = iBarShift(_SYMBOL, _TIMEFRAME, UpperFractalTime2);

         Print(Ask, " - ", UpperFractal2 - (UpperFractal2 - UpperFractal1) * (UpperFractalShift2 / (UpperFractalShift2 - UpperFractalShift1)));
         if(Ask > UpperFractal2 - (UpperFractal2 - UpperFractal1) * (UpperFractalShift2 / (UpperFractalShift2 - UpperFractalShift1)))
            result = 1;
                  
         break;
      }
      case _OPEN_SHORT:
      {
//         if(!OpenNewBar())
//            return(0);

/*         
         LowerFractal1 = getLastFractalValue(_SYMBOL, _TIMEFRAME, false);
         LowerFractalTime1 = getLastFractalTime(_SYMBOL, _TIMEFRAME, false);
         LowerFractal2 = getPreviousFractalValue(_SYMBOL, _TIMEFRAME, false);
         LowerFractalTime2 = getPreviousFractalTime(_SYMBOL, _TIMEFRAME, false);

         LowerFractalShift1 = iBarShift(_SYMBOL, _TIMEFRAME, LowerFractalTime1);
         LowerFractalShift2 = iBarShift(_SYMBOL, _TIMEFRAME, LowerFractalTime2);
*/
         LowerFractal1 = getLastFractalValue(_SYMBOL, _TIMEFRAME_2, false);
         LowerFractalTime1 = getLastFractalTime(_SYMBOL, _TIMEFRAME_2, false);
         LowerFractal2 = getPreviousFractalValue(_SYMBOL, _TIMEFRAME_2, false);
         LowerFractalTime2 = getPreviousFractalTime(_SYMBOL, _TIMEFRAME_2, false);

         LowerFractalShift1 = iBarShift(_SYMBOL, _TIMEFRAME, LowerFractalTime1);
         LowerFractalShift2 = iBarShift(_SYMBOL, _TIMEFRAME, LowerFractalTime2);

         Print(Bid, " - ", LowerFractal2 - (LowerFractal2 - LowerFractal1) * (LowerFractalShift2 / (LowerFractalShift2 - LowerFractalShift1)));
         if(Bid < LowerFractal2 - (LowerFractal2 - LowerFractal1) * (LowerFractalShift2 / (LowerFractalShift2 - LowerFractalShift1)))
            result = 1;
                  
         break;
      }
      case _CLOSE_LONG:
      {
         break;

         if(OrdersTotal() == 1)
         {
            OrderSelect(0, SELECT_BY_POS);
            if(OrderMagicNumber() != _MAGICNUMBER)
               break;
            if(OrderProfit() > 0)
            {
               if(OrderType() == OP_BUY)
               {
                  if(iHigh(_SYMBOL, _TIMEFRAME, 2) > iHigh(_SYMBOL, _TIMEFRAME, 1))
//                  if(iHigh(_SYMBOL, _TIMEFRAME, 1) > iHigh(_SYMBOL, _TIMEFRAME, 0))
                      result = 1;
               }
            }
         }

         break;

         if(!OpenNewBar())
            return(0);
         
//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, true) < getPreviousFractalValue(_SYMBOL, _TIMEFRAME, true))
//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, true) > getPreviousFractalValue(_SYMBOL, _TIMEFRAME, true))
//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, false) > getPreviousFractalValue(_SYMBOL, _TIMEFRAME, false))
//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, false) < getPreviousFractalValue(_SYMBOL, _TIMEFRAME, false))
//         if(MathAbs(getLastFractalValue(_SYMBOL, _TIMEFRAME, true) - getLastFractalValue(_SYMBOL, _TIMEFRAME, false)) < MathAbs(getPreviousFractalValue(_SYMBOL, _TIMEFRAME, true) - getPreviousFractalValue(_SYMBOL, _TIMEFRAME, false)))
//         if(Bid < getLastFractalValue(_SYMBOL, _TIMEFRAME, false))
//         if(Bid > getLastFractalValue(_SYMBOL, _TIMEFRAME, false))
//         if(Bid > getLastFractalValue(_SYMBOL, _TIMEFRAME, true))
//            result = 1;

         break;
         
         if(OrdersTotal() == 1)
         {
            OrderSelect(0, SELECT_BY_POS);
            if(OrderMagicNumber() != _MAGICNUMBER)
               break;
            if(OrderProfit() > 0)
            {
               if(OrderType() == OP_BUY)
               {
                  if(Bid < iLow(_SYMBOL, _TIMEFRAME, 1))
                      result = 1;
               }
            }
         }

         break;
         
         if(OrdersTotal() == 1)
         {
            OrderSelect(0, SELECT_BY_POS);
            if(OrderMagicNumber() != _MAGICNUMBER)
               break;
            if(OrderProfit() > 0)
            {
               if(OrderType() == OP_BUY)
               {
                  if(getLastFractalValue(_SYMBOL, _TIMEFRAME, false) < getPreviousFractalValue(_SYMBOL, _TIMEFRAME, false))
                     result = 1;
               }
            }
         }
         
         break;
      }
      case _CLOSE_SHORT:
      {
         break;

         if(OrdersTotal() == 1)
         {
            OrderSelect(0, SELECT_BY_POS);
            if(OrderMagicNumber() != _MAGICNUMBER)
               break;
            if(OrderProfit() > 0)
            {
               if(OrderType() == OP_SELL)
               {
                  if(iLow(_SYMBOL, _TIMEFRAME, 2) < iLow(_SYMBOL, _TIMEFRAME, 1))
//                  if(iLow(_SYMBOL, _TIMEFRAME, 1) > iLow(_SYMBOL, _TIMEFRAME, 0))
                     result = 1;
               }
            }
         }

         break;
         
         if(!OpenNewBar())
            return(0);

//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, true) < getPreviousFractalValue(_SYMBOL, _TIMEFRAME, true))
//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, true) > getPreviousFractalValue(_SYMBOL, _TIMEFRAME, true))
//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, false) > getPreviousFractalValue(_SYMBOL, _TIMEFRAME, false))
//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, false) < getPreviousFractalValue(_SYMBOL, _TIMEFRAME, false))
//         if(MathAbs(getLastFractalValue(_SYMBOL, _TIMEFRAME, true) - getLastFractalValue(_SYMBOL, _TIMEFRAME, false)) < MathAbs(getPreviousFractalValue(_SYMBOL, _TIMEFRAME, true) - getPreviousFractalValue(_SYMBOL, _TIMEFRAME, false)))
//         if(Ask > getLastFractalValue(_SYMBOL, _TIMEFRAME, true))
//         if(Ask < getLastFractalValue(_SYMBOL, _TIMEFRAME, true))
//         if(Ask < getLastFractalValue(_SYMBOL, _TIMEFRAME, false))
//            result = 1;

         break;
         
         if(OrdersTotal() == 1)
         {
            OrderSelect(0, SELECT_BY_POS);
            if(OrderMagicNumber() != _MAGICNUMBER)
               break;
            if(OrderProfit() > 0)
            {
               if(OrderType() == OP_SELL)
               {
                  if(Ask > iHigh(_SYMBOL, _TIMEFRAME, 1))
                     result = 1;
               }
            }
         }

         break;
         
         if(OrdersTotal() == 1)
         {
            OrderSelect(0, SELECT_BY_POS);
            if(OrderMagicNumber() != _MAGICNUMBER)
               break;
            if(OrderProfit() > 0)
            {
               if(OrderType() == OP_SELL)
               {
                  if(getLastFractalValue(_SYMBOL, _TIMEFRAME, true) > getPreviousFractalValue(_SYMBOL, _TIMEFRAME, true))
                     result = 1;
               }
            }
         }
         
         break;
      }
      case _GET_LONG_STOPLOSS_PRICE:
      {
//         break;

         result = getLastFractalValue(_SYMBOL, _TIMEFRAME, false);
//         result = iLow(_SYMBOL, _TIMEFRAME, 1);

         if(result > Ask - 10*Point)
            result = Ask - 10*Point;

         break;
      }
      case _GET_SHORT_STOPLOSS_PRICE:
      {
//         break;

         result = getLastFractalValue(_SYMBOL, _TIMEFRAME, true);
//         result = iHigh(_SYMBOL, _TIMEFRAME, 1);

         if(result < Bid + 10*Point)
            result = Bid + 10*Point;
         
         break;
      }
      case _GET_LONG_TAKEPROFIT_PRICE:
      {
         break;
      }
      case _GET_SHORT_TAKEPROFIT_PRICE:
      {
         break;
      }
      case _GET_TRAILED_STOPLOSS_PRICE:
      {
//         break;

         double beq = 0;
         
/*
         if(OrdersTotal() == 1)
         {
            OrderSelect(0, SELECT_BY_POS);
            if(OrderMagicNumber() != _MAGICNUMBER)
               break;
            if(OrderProfit() > 0)
            {
               if(OrderType() == OP_BUY)
               {
                  if(iLow(_SYMBOL, _TIMEFRAME, 1) > OrderOpenPrice())
                     beq = OrderOpenPrice();
                  
                  if(beq > Bid - 10*Point)
                     beq = Bid - 10*Point;
                  
                  if(beq <= OrderStopLoss())
                     beq = OrderStopLoss();
               }
               else
               {
                  if(iHigh(_SYMBOL, _TIMEFRAME, 1) < OrderOpenPrice())
                     beq = OrderOpenPrice();
                  
                  if(beq < Ask + 10*Point)
                     beq = Ask + 10*Point;
                     
                  if(beq >= OrderStopLoss())
                     beq = OrderStopLoss();
               }
            }
         }
*/
         
         if(OrdersTotal() == 1)
         {
            OrderSelect(0, SELECT_BY_POS);
            if(OrderMagicNumber() != _MAGICNUMBER)
               break;
//            if(OrderProfit() > 0)
            {
               if(OrderType() == OP_BUY)
               {
//                  result = iLow(_SYMBOL, _TIMEFRAME, 1);
                  result = getLastFractalValue(_SYMBOL, _TIMEFRAME, false);
                  
                  if(beq > result)
                     result = beq;
                  
                  if(result > Bid - 10*Point)
                     result = Bid - 10*Point;
                  
                  if(result <= OrderStopLoss())
                     result = OrderStopLoss();
               }
               else
               {
//                  result = iHigh(_SYMBOL, _TIMEFRAME, 1);
                  result = getLastFractalValue(_SYMBOL, _TIMEFRAME, true);
                  
                  if(beq > result)
                     result = beq;

                  if(result < Ask + 10*Point)
                     result = Ask + 10*Point;
                     
                  if(result >= OrderStopLoss())
                     result = OrderStopLoss();
               }
            }
         }
         
         break;
      }      
      case _GET_TRAILED_TAKEPROFIT_PRICE:
      {
         break;
         
         if(OrdersTotal() == 1)
         {
            OrderSelect(0, SELECT_BY_POS);
            if(OrderMagicNumber() != _MAGICNUMBER)
               break;
            if(OrderProfit() > 0)
            {
               if(OrderType() == OP_BUY)
               {
                  result = Bid + MathAbs(Bid - OrderStopLoss());
               }
               else
               {
                  result = Ask - MathAbs(Ask - OrderStopLoss());
               }
            }
         }

         break;
         
         if(OrdersTotal() == 1)
         {
            OrderSelect(0, SELECT_BY_POS);
            if(OrderMagicNumber() != _MAGICNUMBER)
               break;
            if(OrderProfit() > 0)
            {
               if(OrderType() == OP_BUY)
               {
                  result = getLastFractalValue(_SYMBOL, _TIMEFRAME, true);
                  
                  if(result > Bid)
                     result = Bid;
                  
                  if(result <= Bid)
                     result = 0;
               }
               else
               {
                  result = getLastFractalValue(_SYMBOL, _TIMEFRAME, false);
                  
                  if(result < Ask)
                     result = Ask;
                     
                  if(result >= Ask)
                     result = 0;
               }
            }
         }
         
         break;
      }
      case _GET_LOTS:
      {
         result = 0.1;
//         result = GetLots(_MM_FIX_PERC_AVG_LAST_PROFIT, 0.2);
         break;
      }
      case _GET_TRADED_TIMEFRAME:
      {
         result = _TIMEFRAME;
         break;
      }
   }
      
   return(result);
}


        
