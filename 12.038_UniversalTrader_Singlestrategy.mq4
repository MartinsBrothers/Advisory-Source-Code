//+------------------------------------------------------------------+
//|                        12.038_UniversalTrader_Singlestrategy.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
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
int   _STRATEGY_NUMBER              = 23;

int   _MIN_STOPLOSS_DISTANCE        = 10;
int   _MIN_TAKEPROFIT_DISTANCE      = 10;

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
extern string  poznamka1 = "0 - vyber timeframe podla dropdown menu - premenna _STRATEGY_TIMEFRAME sa ignoruje";
extern string  poznamka2 = "1 - vyber timeframe podla kodu timeframe 1 - 9";
extern int     _STRATEGY_TIMEFRAME_CHOICE    = 0;
extern int     _STRATEGY_TIMEFRAME           = 1;

extern int     _OPEN_SIGNAL_COMBINATION      = 1;  //27
extern int     _CLOSE_SIGNAL_COMBINATION     = 1;  //3
extern int     _STOPLOSS_COMBINATION         = 1;  //3
extern int     _TRAILING_STOPLOSS_COMBINATION= 1;  //3

int     _SIGNAL_COMBINATION           = 1;

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
#define     _OPEN_LONG                    1
#define     _OPEN_SHORT                   2
#define     _CLOSE_LONG                   3
#define     _CLOSE_SHORT                  4
#define     _GET_LONG_STOPLOSS_PRICE      5
#define     _GET_SHORT_STOPLOSS_PRICE     6
#define     _GET_LONG_TAKEPROFIT_PRICE    7
#define     _GET_SHORT_TAKEPROFIT_PRICE   8
#define     _GET_LOTS                     9
#define     _GET_TRAILED_STOPLOSS_PRICE   10
#define     _GET_TRAILED_TAKEPROFIT_PRICE 11
#define     _GET_TRADED_TIMEFRAME         12
#define     _OPEN_PENDING_BUY_STOP        13
#define     _OPEN_PENDING_SELL_STOP       14
#define     _OPEN_PENDING_BUY_LIMIT       15
#define     _OPEN_PENDING_SELL_LIMIT      16
#define     _GET_PENDING_BUY_STOP_PRICE   17
#define     _GET_PENDING_SELL_STOP_PRICE  18
#define     _GET_PENDING_ORDER_EXPIRATION 19
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
   _MIN_STOPLOSS_DISTANCE           = MarketInfo(Symbol(), MODE_STOPLEVEL);
   _MIN_TAKEPROFIT_DISTANCE         = MarketInfo(Symbol(), MODE_STOPLEVEL);

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
   

   if(!TradeAllowed(1))
      return(0);

   if(Strategy(_STRATEGY_NUMBER, _OPEN_LONG) == 1)
      OpenPosition(false, Strategy(_STRATEGY_NUMBER, _GET_LOTS), Strategy(_STRATEGY_NUMBER, _GET_LONG_STOPLOSS_PRICE), Strategy(_STRATEGY_NUMBER, _GET_LONG_TAKEPROFIT_PRICE), 3, _MAGICNUMBER);
   if(Strategy(_STRATEGY_NUMBER, _OPEN_SHORT) == 1)
      OpenPosition(true, Strategy(_STRATEGY_NUMBER, _GET_LOTS), Strategy(_STRATEGY_NUMBER, _GET_SHORT_STOPLOSS_PRICE), Strategy(_STRATEGY_NUMBER, _GET_SHORT_TAKEPROFIT_PRICE), 3, _MAGICNUMBER);

   if(Strategy(_STRATEGY_NUMBER, _OPEN_PENDING_BUY_STOP) == 1)
      OpenPendingPosition(false, Strategy(_STRATEGY_NUMBER, _GET_LOTS), Strategy(_STRATEGY_NUMBER, _GET_PENDING_BUY_STOP_PRICE), Strategy(_STRATEGY_NUMBER, _GET_LONG_STOPLOSS_PRICE), Strategy(_STRATEGY_NUMBER, _GET_LONG_TAKEPROFIT_PRICE), 3, _MAGICNUMBER, Strategy(_STRATEGY_NUMBER, _GET_PENDING_ORDER_EXPIRATION));
   if(Strategy(_STRATEGY_NUMBER, _OPEN_PENDING_SELL_STOP) == 1)
      OpenPendingPosition(true, Strategy(_STRATEGY_NUMBER, _GET_LOTS), Strategy(_STRATEGY_NUMBER, _GET_PENDING_SELL_STOP_PRICE), Strategy(_STRATEGY_NUMBER, _GET_SHORT_STOPLOSS_PRICE), Strategy(_STRATEGY_NUMBER, _GET_SHORT_TAKEPROFIT_PRICE), 3, _MAGICNUMBER, Strategy(_STRATEGY_NUMBER, _GET_PENDING_ORDER_EXPIRATION));

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
/*
bool OpenNewBar()
{
   if(iVolume(Symbol(), Strategy(_STRATEGY_NUMBER, _GET_TRADED_TIMEFRAME), 0) > 1)
      return(false);
   else
      return(true);
}
*/
bool OpenNewBar(int _TIMEFRAME)
{
   if(iVolume(Symbol(), _TIMEFRAME, 0) > 1)
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
   if(getOrdersTotalByMagicnumber(_MAGICNUMBER) >= MAXORDERS)
      return(false);
   return(true);
}
//------------------------------------------------------------------
int getOrdersTotalByMagicnumber(int MAGICNUMBER)
{
   int i = 0, OrdersTotalByMagicnumber = 0;
   for(i = 0; i < OrdersTotal(); i++)
   {
      OrderSelect(i, SELECT_BY_POS);
      if(OrderMagicNumber() == MAGICNUMBER)
         OrdersTotalByMagicnumber++;
   }
   return(OrdersTotalByMagicnumber);
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
// Opens position according to arguments (short || long, amount of Lots to trade 
//------------------------------------------------------------------------------------
void OpenPosition(bool SHORTLONG, double LOTS, double STOPLOSS, double TAKEPROFIT, int SLIPPAGE, int MAGICNUMBER)
{
   if(SHORTLONG)
   {
      if(STOPLOSS > 0)
      if(Ask + _MIN_STOPLOSS_DISTANCE*Point < STOPLOSS)
      {
         Print("Bad OrderOpen() STOPLOSS defined. Price Bid was: ", Ask, " and STOPLOSS was: ", STOPLOSS, " . STOPLOSS set to minimal value: ", Bid + _MIN_STOPLOSS_DISTANCE*Point);
         STOPLOSS = Ask + _MIN_STOPLOSS_DISTANCE*Point;
      }
      if(TAKEPROFIT > 0)
      if(Bid - _MIN_TAKEPROFIT_DISTANCE*Point > TAKEPROFIT)
      {
         Print("Bad OrderOpen() TAKEPROFIT defined. Price Bid was: ", Bid, " and TAKEPROFIT was: ", TAKEPROFIT, " . TAKEPROFIT set to minimal value: ", Bid - _MIN_TAKEPROFIT_DISTANCE*Point);
         TAKEPROFIT = Bid - _MIN_TAKEPROFIT_DISTANCE*Point;
      }
      OrderSend(Symbol(), OP_SELL, LOTS, Bid, SLIPPAGE, STOPLOSS, TAKEPROFIT, TimeToStr(Time[0]), MAGICNUMBER, 0, Red);
   }
   else
   {
      if(STOPLOSS > 0)
      if(Bid - _MIN_STOPLOSS_DISTANCE*Point < STOPLOSS)
      {
         Print("Bad OrderOpen() STOPLOSS defined. Price Bid was: ", Bid, " and STOPLOSS was: ", STOPLOSS, " . STOPLOSS set to minimal value: ", Bid - _MIN_STOPLOSS_DISTANCE*Point);
         STOPLOSS = Bid - _MIN_STOPLOSS_DISTANCE*Point;
      }
      if(TAKEPROFIT > 0)
      if(Ask + _MIN_TAKEPROFIT_DISTANCE*Point > TAKEPROFIT)
      {
         Print("Bad OrderOpen() TAKEPROFIT defined. Price Bid was: ", Ask, " and TAKEPROFIT was: ", TAKEPROFIT, " . TAKEPROFIT set to minimal value: ", Bid + _MIN_TAKEPROFIT_DISTANCE*Point);
         TAKEPROFIT = Ask + _MIN_TAKEPROFIT_DISTANCE*Point;
      }
      OrderSend(Symbol(), OP_BUY, LOTS, Ask, SLIPPAGE, STOPLOSS, TAKEPROFIT, TimeToStr(Time[0]), MAGICNUMBER, 0, Blue);
   }
   
   LastBarTraded = Time[0];
}
//------------------------------------------------------------------------------------
// Opens pending position according to arguments (sell stop || buy stop, amount of Lots to trade 
//------------------------------------------------------------------------------------
void OpenPendingPosition(bool SHORTLONG, double LOTS, double OPENPRICE, double STOPLOSS, double TAKEPROFIT, int SLIPPAGE, int MAGICNUMBER, datetime EXPIRATION)
{
   if(SHORTLONG)
   {
      OrderSend(Symbol(), OP_SELLSTOP, LOTS, OPENPRICE, SLIPPAGE, STOPLOSS, TAKEPROFIT, NULL, MAGICNUMBER, EXPIRATION, Red);
   }
   else
   {
      OrderSend(Symbol(), OP_BUYSTOP, LOTS, OPENPRICE, SLIPPAGE, STOPLOSS, TAKEPROFIT, NULL, MAGICNUMBER, EXPIRATION, Blue);
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

//check minimal distance of STOPLOSS and TAKEPROFIT and if are not met - correct SL and TP values to minimal values and print message into LOG file
   if(OrderType() == OP_BUY)
   {
      if(STOPLOSS > 0)
      if(Bid - _MIN_STOPLOSS_DISTANCE*Point < STOPLOSS)
      {
         Print("Bad OrderModify() STOPLOSS defined for order ticket: ", OrderTicket(), " and Magic number: ", OrderMagicNumber(), " . Price Bid was: ", Bid, " and STOPLOSS was: ", STOPLOSS, " . STOPLOSS set to minimal value: ", Bid - _MIN_STOPLOSS_DISTANCE*Point);
         STOPLOSS = Bid - _MIN_STOPLOSS_DISTANCE*Point;
      }
      if(TAKEPROFIT > 0)
      if(Ask + _MIN_TAKEPROFIT_DISTANCE*Point > TAKEPROFIT)
      {
         Print("Bad OrderModify() TAKEPROFIT defined for order ticket: ", OrderTicket(), " and Magic number: ", OrderMagicNumber(), " . Price Bid was: ", Ask, " and TAKEPROFIT was: ", TAKEPROFIT, " . TAKEPROFIT set to minimal value: ", Bid + _MIN_TAKEPROFIT_DISTANCE*Point);
         TAKEPROFIT = Ask + _MIN_TAKEPROFIT_DISTANCE*Point;
      }
      
      if(STOPLOSS > 0)
      if(OrderStopLoss() >= STOPLOSS)
         STOPLOSS = OrderStopLoss();
//      if(OrderTakeProfit() <= TAKEPROFIT)
//         TAKEPROFIT = OrderStopLoss();
   }
   if(OrderType() == OP_SELL)
   {
      if(STOPLOSS > 0)
      if(Ask + _MIN_STOPLOSS_DISTANCE*Point > STOPLOSS)
      {
         Print("Bad OrderModify() STOPLOSS defined for order ticket: ", OrderTicket(), " and Magic number: ", OrderMagicNumber(), " . Price Ask was: ", Ask, " and STOPLOSS was: ", STOPLOSS, " . STOPLOSS set to minimal value: ", Ask + _MIN_STOPLOSS_DISTANCE*Point);
         STOPLOSS = Ask + _MIN_STOPLOSS_DISTANCE*Point;
      }
      if(TAKEPROFIT > 0)
      if(Bid - _MIN_TAKEPROFIT_DISTANCE*Point < TAKEPROFIT)
      {
         Print("Bad OrderModify() TAKEPROFIT defined for order ticket: ", OrderTicket(), " and Magic number: ", OrderMagicNumber(), " . Price Ask was: ", Bid, " and TAKEPROFIT was: ", TAKEPROFIT, " . TAKEPROFIT set to minimal value: ", Ask - _MIN_TAKEPROFIT_DISTANCE*Point);
         TAKEPROFIT = Bid - _MIN_TAKEPROFIT_DISTANCE*Point;
      }

      if(STOPLOSS > 0)
      if(OrderStopLoss() <= STOPLOSS)
         return;
//      if(OrderTakeProfit() >= TAKEPROFIT)
//         TAKEPROFIT = OrderStopLoss();
   }
   
//   Print(Ask, " - ", Bid, " - ", OrderTicket(), " - ", OrderOpenPrice(), " - ", OrderStopLoss(), " - ", OrderTakeProfit(), " - ", STOPLOSS, " - ", TAKEPROFIT, " - ", OrderMagicNumber());
   OrderModify(OrderTicket(), OrderOpenPrice(), STOPLOSS, TAKEPROFIT, 0);
}
/*
Old function without any STOPLOSS and TAKEPROFIT security check
*/
/*
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
*/
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
int getHigherTimeframe(int Timeframe)
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
//------------------------------------------------------------------
int getLowerTimeframe(int Timeframe)
{
   switch(Timeframe)
   {
      case PERIOD_M1:
         return (PERIOD_M1);
      case PERIOD_M5:
         return (PERIOD_M1);
      case PERIOD_M15:
         return (PERIOD_M5);
      case PERIOD_M30:
         return (PERIOD_M15);
      case PERIOD_H1:
         return (PERIOD_M30);
      case PERIOD_H4:
         return (PERIOD_H1);
      case PERIOD_D1:
         return (PERIOD_H4);
      case PERIOD_W1:
         return (PERIOD_D1);
      case PERIOD_MN1:
         return (PERIOD_W1);
   }
   
   return (Timeframe);
}
//------------------------------------------------------------------------------------
// FRACTALS
//------------------------------------------------------------------------------------
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
//------------------------------------------------------------------------------------
// ZIGZAG
//------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------
// Last ZIGZAG time
//------------------------------------------------------------------------------------
datetime getLastZIGZAGTime(string _SYMBOL, int _TIMEFRAME, bool UpperLower)
{
   return (getNthZIGZAGTime(_SYMBOL, _TIMEFRAME, UpperLower, 1));
}
//------------------------------------------------------------------------------------
// Previous ZIGZAG time
//------------------------------------------------------------------------------------
datetime getPreviousZIGZAGTime(string _SYMBOL, int _TIMEFRAME, bool UpperLower)
{
   return (getNthZIGZAGTime(_SYMBOL, _TIMEFRAME, UpperLower, 2));
}
//------------------------------------------------------------------------------------
// Last ZIGZAG value
//------------------------------------------------------------------------------------
double getLastZIGZAGValue(string _SYMBOL, int _TIMEFRAME, bool UpperLower)
{
   return (getNthZIGZAGValue(_SYMBOL, _TIMEFRAME, UpperLower, 1));
}
//------------------------------------------------------------------------------------
// Previous ZIGZAG value
//------------------------------------------------------------------------------------
double getPreviousZIGZAGValue(string _SYMBOL, int _TIMEFRAME, bool UpperLower)
{
   return (getNthZIGZAGValue(_SYMBOL, _TIMEFRAME, UpperLower, 2));
}
//------------------------------------------------------------------------------------
// Nth ZIGZAG value
//------------------------------------------------------------------------------------
double getNthZIGZAGValue(string _SYMBOL, int _TIMEFRAME, bool UpperLower, int Nth)
{
   double   result      = 0;
   int      i           = 0;
   int      NthZIGZAG   = 2*Nth + 1;
   double   ZIGZAG1     = 0;
   double   ZIGZAG2     = 0;
   
   while(i < 1000 && NthZIGZAG > 0)
   {
      result = iCustom(_SYMBOL, _TIMEFRAME, "ZigZag", 12, 5, 3, 0, i);
                 
      i++;

      if(result > 0)
      {
         ZIGZAG1 = ZIGZAG2;
         ZIGZAG2 = result;
         NthZIGZAG--;
         continue;
      }
   }
   
   if(UpperLower)
   {
      if(ZIGZAG1 > ZIGZAG2)
         result = ZIGZAG1;
      else
         result = ZIGZAG2;
   }
   else
   {
      if(ZIGZAG1 > ZIGZAG2)
         result = ZIGZAG2;
      else
         result = ZIGZAG1;
   }
   
   return (result);
}


double getNthZIGZAGValueOld(string _SYMBOL, int _TIMEFRAME, bool UpperLower, int Nth)
{
   double   result      = 0;
   int      i           = 0;
   int      NthZIGZAG   = Nth;
   bool     LastZIGZAG  = true;
      
   if(UpperLower)
   {
      while(i < 1000 && NthZIGZAG > 0)
      {
         if(LastZIGZAG)
         {
            if(iCustom(_SYMBOL, _TIMEFRAME, "ZigZag", 12, 5, 3, 1, i) > 0 || iCustom(_SYMBOL, _TIMEFRAME, "ZigZag", 12, 5, 3, 2, i) > 0)
               LastZIGZAG = false;
            i++;
            continue;
         }

         result = iCustom(_SYMBOL, _TIMEFRAME, "ZigZag", 12, 5, 3, 1, i);
         
//         Print("upper:", result);
         
         i++;
         if(result > 0)
         {
            NthZIGZAG--;
            continue;
         }
      }
   }
   else
   {
      while(i < 1000 && NthZIGZAG > 0)
      {
         if(LastZIGZAG)
         {
            if(iCustom(_SYMBOL, _TIMEFRAME, "ZigZag", 12, 5, 3, 1, i) > 0 || iCustom(_SYMBOL, _TIMEFRAME, "ZigZag", 12, 5, 3, 2, i) > 0)
               LastZIGZAG = false;
            i++;
            continue;
         }

         result = iCustom(_SYMBOL, _TIMEFRAME, "ZigZag", 12, 5, 3, 2, i);

//         Print("lower:", result);

         i++;
         if(result > 0)
         {
            NthZIGZAG--;
            continue;
         }
      }
   }
   
   return (result);
}
//------------------------------------------------------------------------------------
// Nth ZIGZAG time
//------------------------------------------------------------------------------------
datetime getNthZIGZAGTime(string _SYMBOL, int _TIMEFRAME, bool UpperLower, int Nth)
{
   double   result      = 0;
   int      i           = 0;
   int      NthZIGZAG   = 2*Nth + 1;
   double   ZIGZAG1     = 0;
   double   ZIGZAG2     = 0;
   int      ZIGZAG1Time = 0;
   int      ZIGZAG2Time = 0;
   
   while(i < 1000 && NthZIGZAG > 0)
   {
      result = iCustom(_SYMBOL, _TIMEFRAME, "ZigZag", 12, 5, 3, 0, i);
      
      i++;

      if(result > 0)
      {
         ZIGZAG1 = ZIGZAG2;
         ZIGZAG2 = result;
         ZIGZAG1Time = ZIGZAG2Time;
         ZIGZAG2Time = i - 1;
         NthZIGZAG--;
         continue;
      }
   }
   
   if(UpperLower)
   {
      if(ZIGZAG1 > ZIGZAG2)
         result = ZIGZAG1Time;
      else
         result = ZIGZAG2Time;
   }
   else
   {
      if(ZIGZAG1 > ZIGZAG2)
         result = ZIGZAG2Time;
      else
         result = ZIGZAG1Time;
   }
   
   return(iTime(_SYMBOL, _TIMEFRAME, result));
}


datetime getNthZIGZAGTimeOld(string _SYMBOL, int _TIMEFRAME, bool UpperLower, int Nth)
{
   datetime result      = 0;
   int      i           = 0;
   int      NthZIGZAG   = Nth;
   bool     LastZIGZAG  = true;
      
   if(UpperLower)
   {
      while(i < 1000 && NthZIGZAG > 0)
      {
         if(LastZIGZAG)
         {
            if(iCustom(_SYMBOL, _TIMEFRAME, "ZigZag", 12, 5, 3, 1, i) > 0 || iCustom(_SYMBOL, _TIMEFRAME, "ZigZag", 12, 5, 3, 2, i) > 0)
               LastZIGZAG = false;
            i++;
            continue;
         }

         i++;
         if(iCustom(_SYMBOL, _TIMEFRAME, "ZigZag", 12, 5, 3, 1, i) > 0)
         {
            NthZIGZAG--;
            continue;
         }
      }
      
      return(iTime(_SYMBOL, _TIMEFRAME, i));
   }
   else
   {
      while(i < 1000 && NthZIGZAG > 0)
      {
         if(LastZIGZAG)
         {
            if(iCustom(_SYMBOL, _TIMEFRAME, "ZigZag", 12, 5, 3, 1, i) > 0 || iCustom(_SYMBOL, _TIMEFRAME, "ZigZag", 12, 5, 3, 2, i) > 0)
               LastZIGZAG = false;
            i++;
            continue;
         }

         i++;
         if(iCustom(_SYMBOL, _TIMEFRAME, "ZigZag", 12, 5, 3, 2, i) > 0)
         {
            NthZIGZAG--;
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
// denne sviecky - hladanie vnutornej sviecky - nerozhodnost trhu - umietnenie pending order nad/pod high/low vcerajsej sviecky a cakanie na prieraz
      case 15:
      {
         return(Strategy_015(COMMAND));
      }
// modifikacia predosleho systemu - nie pending orders ale market, aby bolo mozne pouzit aj nizsie timeframes
      case 16:
      {
         return(Strategy_016(COMMAND));
      }
// gap trading - medzi dnami/tyzdnami - gap sa zvykne zaplnit
// je dobre pockat na support - resistance aby sme mali pevny spodok - strop
      case 17:
      {
         return(Strategy_017(COMMAND));
      }
// Malo by to byt o fraktaloch, resp. ZIGZAG indikatore
// tato strategia pracuje s uhlami, periodou a dlzkami ZIGZAG indikatora
      case 18:
      {
         return(Strategy_018(COMMAND));
      }
// ZIGZAG + Bollinger Bands
// uhol spojnice ZIGZAG opacneho vrchola a dotycnice k BB - ak je vacsi -> place order
      case 19:
      {
         return(Strategy_019(COMMAND));
      }
// ZIGZAG pokus na viacerych timeframe
      case 20:
      {
         return(Strategy_020(COMMAND));
      }
// ZIGZAG spojnice vrcholov su supporty/resistance - ich prerazenie by malo vytvorit trend
      case 21:
      {
         return(Strategy_021(COMMAND));
      }
// ZIGZAG spojnice vrcholov su supporty/resistance - odrazenie od nich je pravdepodobne
      case 22:
      {
         return(Strategy_022(COMMAND));
      }
// ZIGZAG vrcholy su S/R urovne
      case 23:
      {
         return(Strategy_023(COMMAND));
      }
// TrendLinearReg indicator application
      case 24:
      {
         return(Strategy_024(COMMAND));
      }
   }

   return(0);
}
//------------------------------------------------------------------//------------------------------------------------------------------
double Strategy_001(int COMMAND)
{
   string   _SYMBOL        = Symbol();
   int      _TIMEFRAME     = getStrategyTimeframeByNumber(_STRATEGY_TIMEFRAME);
//   int      _TIMEFRAME_2   = getHigherTimeframe(getHigherTimeframe(_TIMEFRAME));
   int      _TIMEFRAME_2   = getHigherTimeframe(_TIMEFRAME);
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
      case _OPEN_LONG:
      {
         if(!OpenNewBar(_TIMEFRAME))
            break;

         MACDHistogram = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT);
         MACDSignal = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT);
         
         MACDHistogram2 = iMACD(_SYMBOL, _TIMEFRAME_2, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT);
         MACDSignal2 = iMACD(_SYMBOL, _TIMEFRAME_2, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT);

         switch(_OPEN_SIGNAL_COMBINATION)
         {
            case 1:
            {
               if(MACDHistogram > MACDSignal && MACDHistogram > 0)
                  result = 1;
               break;
            }
            case 2:
            {
               if(MACDHistogram > MACDSignal && MACDHistogram2 > 0 && MACDSignal2 > 0 && MACDHistogram < 0 && MACDSignal < 0)
                  result = 1;
               break;
            }
            case 3:
            {
               if(MACDHistogram > MACDSignal && MACDHistogram2 < MACDSignal2)
                  result = 1;
               break;
            }
            case 4:
            {
               if(MACDHistogram > MACDSignal && MACDHistogram2 < 0 && MACDSignal2 < 0)
                  result = 1;
               break;
            }
            case 5:
            {
               if(MACDHistogram > MACDSignal && MACDHistogram2 > 0 && MACDSignal2 > 0 && MACDHistogram < 0)
                  result = 1;
               break;
            }
            case 6:
            {
               if(MACDHistogram > MACDSignal && MACDHistogram2 > 0 && MACDSignal2 > 0)
                  result = 1;
               break;
            }
         }
         
         break;
      }
      case _OPEN_SHORT:
      {
         if(!OpenNewBar(_TIMEFRAME))
            break;

         MACDHistogram = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT);
         MACDSignal = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT);

         MACDHistogram2 = iMACD(_SYMBOL, _TIMEFRAME_2, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT);
         MACDSignal2 = iMACD(_SYMBOL, _TIMEFRAME_2, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT);

         switch(_OPEN_SIGNAL_COMBINATION)
         {
            case 1:
            {
               if(MACDHistogram < MACDSignal && MACDHistogram < 0)
                  result = 1;
               break;
            }
            case 2:
            {
               if(MACDHistogram < MACDSignal && MACDHistogram2 < 0 && MACDSignal2 < 0 && MACDHistogram > 0 && MACDSignal > 0)
                  result = 1;
               break;
            }
            case 3:
            {
               if(MACDHistogram < MACDSignal && MACDHistogram2 > MACDSignal2)
                  result = 1;
               break;
            }
            case 4:
            {
               if(MACDHistogram < MACDSignal && MACDHistogram2 > 0 && MACDSignal2 > 0)
                  result = 1;
               break;
            }
            case 5:
            {
               if(MACDHistogram < MACDSignal && MACDHistogram2 < 0 && MACDSignal2 < 0 && MACDHistogram > 0)
                  result = 1;
               break;
            }
            case 6:
            {
               if(MACDHistogram < MACDSignal && MACDHistogram2 < 0 && MACDSignal2 < 0)
                  result = 1;
               break;
            }
         }

         break;
      }
      case _CLOSE_LONG:
      {
         if(!OpenNewBar(_TIMEFRAME))
            break;

         MACDHistogram = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT);
         MACDSignal = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT);
         
         switch(_CLOSE_SIGNAL_COMBINATION)
         {
            case 1:
            {
               if(MACDHistogram < MACDSignal)
                  result = 1;
               break;
            }
            case 2:
            {
               if(MACDHistogram > 0 && MACDSignal > 0)
                  result = 1;
               break;
            }
            case 3:
            {
               if(MACDHistogram > 0 && MACDSignal > 0 && MACDHistogram < MACDSignal)
                  result = 1;
               break;
            }
         }
         
         break;
      }
      case _CLOSE_SHORT:
      {
         MACDHistogram = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT);
         MACDSignal = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT);
         
         if(!OpenNewBar(_TIMEFRAME))
            break;

         switch(_CLOSE_SIGNAL_COMBINATION)
         {
            case 1:
            {
               if(MACDHistogram > MACDSignal)
                  result = 1;
               break;
            }
            case 2:
            {
               if(MACDHistogram < 0 && MACDSignal < 0)
                  result = 1;
               break;
            }
            case 3:
            {
               if(MACDHistogram < 0 && MACDSignal < 0 && MACDHistogram > MACDSignal)
                  result = 1;
               break;
            }
         }

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
   int      _TIMEFRAME     = getStrategyTimeframeByNumber(_STRATEGY_TIMEFRAME);
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
      case _OPEN_LONG:
      {
         MACDHistogram = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT);
         MACDSignal = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT);

         switch(_OPEN_SIGNAL_COMBINATION)
         {
            case 1:
            {
               if(MACDHistogram > MACDSignal && MACDHistogram > 0)
                  result = 1;
               break;
            }
            case 2:
            {
               if(MACDHistogram > MACDSignal)
                  result = 1;
               break;
            }
         }
         
         break;
      }
      case _OPEN_SHORT:
      {
         MACDHistogram = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT);
         MACDSignal = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT);

         switch(_OPEN_SIGNAL_COMBINATION)
         {
            case 1:
            {
               if(MACDHistogram < MACDSignal && MACDHistogram < 0)
                  result = 1;
               break;
            }
            case 2:
            {
               if(MACDHistogram < MACDSignal)
                  result = 1;
               break;
            }
         }
         
         break;
      }
      case _CLOSE_LONG:
      {
         MACDHistogram = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT);
         MACDSignal = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT);
         
         switch(_CLOSE_SIGNAL_COMBINATION)
         {
            case 1:
            {
               if(MACDHistogram < 0)
                  result = 1;
               break;
            }
            case 2:
            {
               if(MACDHistogram < MACDSignal)
                  result = 1;
               break;
            }
            case 3:
            {
               if(MACDHistogram > 0 && MACDSignal > 0)
                  result = 1;
               break;
            }
            case 4:
            {
               if(MACDHistogram > 0 && MACDSignal > 0 && MACDHistogram < MACDSignal)
                  result = 1;
               break;
            }
            case 5:
            {
               break;
            }
         }

         break;
      }
      case _CLOSE_SHORT:
      {
         MACDHistogram = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT);
         MACDSignal = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT);
         
         switch(_CLOSE_SIGNAL_COMBINATION)
         {
            case 1:
            {
               if(MACDHistogram > 0)
                  result = 1;
               break;
            }
            case 2:
            {
               if(MACDHistogram > MACDSignal)
                  result = 1;
               break;
            }
            case 3:
            {
               if(MACDHistogram < 0 && MACDSignal < 0)
                  result = 1;
               break;
            }
            case 4:
            {
               if(MACDHistogram < 0 && MACDSignal < 0 && MACDHistogram > MACDSignal)
                  result = 1;
               break;
            }
            case 5:
            {
               break;
            }
         }

         break;
      }
      case _GET_LONG_STOPLOSS_PRICE:
      {

         switch(_STOPLOSS_COMBINATION)
         {
            case 1:
            {
               result = iFractals(_SYMBOL, _TIMEFRAME, MODE_LOWER, 1);
               break;
            }
            case 2:
            {
               result = iLow(_SYMBOL, _TIMEFRAME, 1);
               break;
            }
            case 3:
            {
               break;
            }
         }

         break;
      }
      case _GET_LONG_TAKEPROFIT_PRICE:
      {
         break;
      }
      case _GET_SHORT_STOPLOSS_PRICE:
      {
         switch(_STOPLOSS_COMBINATION)
         {
            case 1:
            {
               result = iFractals(_SYMBOL, _TIMEFRAME, MODE_UPPER, 1);
               break;
            }
            case 2:
            {
               result = iHigh(_SYMBOL, _TIMEFRAME, 1);
               break;
            }
            case 3:
            {
               break;
            }
         }

         break;
      }
      case _GET_SHORT_TAKEPROFIT_PRICE:
      {
         break;
      }
      case _GET_TRAILED_STOPLOSS_PRICE:
      {
         switch(_TRAILING_STOPLOSS_COMBINATION)
         {
            case 1:
            {
               break;
            }
            case 2:
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
   int      _TIMEFRAME     = getStrategyTimeframeByNumber(_STRATEGY_TIMEFRAME);
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
      case _OPEN_LONG:
      {
         MACDHistogram = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT);
         MACDSignal = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT);

         switch(_OPEN_SIGNAL_COMBINATION)
         {
            case 1:
            {
               if(MACDHistogram > MACDSignal && MACDHistogram > 0)
                  result = 1;
               break;
            }
            case 2:
            {
               if(MACDHistogram > MACDSignal && MACDHistogram < 0)
                  result = 1;
               break;
            }
            case 3:
            {
               if(MACDHistogram > MACDSignal)
                  result = 1;
               break;
            }
         }
         
         break;
      }
      case _OPEN_SHORT:
      {
         MACDHistogram = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT);
         MACDSignal = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT);

         switch(_OPEN_SIGNAL_COMBINATION)
         {
            case 1:
            {
               if(MACDHistogram < MACDSignal && MACDHistogram < 0)
                  result = 1;
               break;
            }
            case 2:
            {
               if(MACDHistogram < MACDSignal && MACDHistogram > 0)
                  result = 1;
               break;
            }
            case 3:
            {
               if(MACDHistogram < MACDSignal)
                  result = 1;
               break;
            }
         }

         break;
      }
      case _CLOSE_LONG:
      {
         MACDHistogram = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT);
         MACDSignal = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT);
         
         switch(_CLOSE_SIGNAL_COMBINATION)
         {
            case 1:
            {
               if(MACDHistogram < 0)
                  result = 1;
               break;
            }
            case 2:
            {
               if(MACDHistogram < MACDSignal)
                  result = 1;
               break;
            }
            case 3:
            {
               if(MACDHistogram > 0 && MACDSignal > 0)
                  result = 1;
               break;
            }
            case 4:
            {
               if(MACDHistogram > 0 && MACDSignal > 0 && MACDHistogram < MACDSignal)
                  result = 1;
               break;
            }
            case 5:
            {
               break;
            }
         }

         break;
      }
      case _CLOSE_SHORT:
      {
         MACDHistogram = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT);
         MACDSignal = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT);
         
         switch(_CLOSE_SIGNAL_COMBINATION)
         {
            case 1:
            {
               if(MACDHistogram > 0)
                  result = 1;
               break;
            }
            case 2:
            {
               if(MACDHistogram > MACDSignal)
                  result = 1;
               break;
            }
            case 3:
            {
               if(MACDHistogram < 0 && MACDSignal < 0)
                  result = 1;
               break;
            }
            case 4:
            {
               if(MACDHistogram < 0 && MACDSignal < 0 && MACDHistogram > MACDSignal)
                  result = 1;
               break;
            }
            case 5:
            {
               break;
            }
         }

         break;
      }
      case _GET_LONG_STOPLOSS_PRICE:
      {
         switch(_STOPLOSS_COMBINATION)
         {
            case 1:
            {
               result = iFractals(_SYMBOL, _TIMEFRAME, MODE_LOWER, 1);
               break;
            }
            case 2:
            {
               result = iLow(_SYMBOL, _TIMEFRAME, 1);
               break;
            }
            case 3:
            {
               break;
            }
         }

         break;
      }
      case _GET_LONG_TAKEPROFIT_PRICE:
      {
         break;
      }
      case _GET_SHORT_STOPLOSS_PRICE:
      {
         switch(_STOPLOSS_COMBINATION)
         {
            case 1:
            {
               result = iFractals(_SYMBOL, _TIMEFRAME, MODE_UPPER, 1);
               break;
            }
            case 2:
            {
               result = iHigh(_SYMBOL, _TIMEFRAME, 1);
               break;
            }
            case 3:
            {
               break;
            }
         }
         
         break;
      }
      case _GET_SHORT_TAKEPROFIT_PRICE:
      {
         break;
      }
      case _GET_TRAILED_STOPLOSS_PRICE:
      {
         switch(_TRAILING_STOPLOSS_COMBINATION)
         {
            case 1:
            {
               break;
            }
            case 2:
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
   int      _TIMEFRAME     = getStrategyTimeframeByNumber(_STRATEGY_TIMEFRAME);
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
   int      _TIMEFRAME     = getStrategyTimeframeByNumber(_STRATEGY_TIMEFRAME);
   int      _SLOWEMA       = 26;
   int      _FASTEMA       = 12;
   int      _MASIGNAL      = 9;
   int      _SHIFT         = 0;
   int      _PRICE         = PRICE_OPEN;

   double   result         = 0;

   int      TIMEFRAME2 = _TIMEFRAME;
//   TIMEFRAME2 = getHigherTimeframe(_TIMEFRAME);
   TIMEFRAME2 = getHigherTimeframe(getHigherTimeframe(_TIMEFRAME));

   double   MACDHistogram;
   double   MACDSignal;

   switch(COMMAND)
   {
      case _OPEN_LONG:
      {
         MACDHistogram = iMACD(_SYMBOL, TIMEFRAME2, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT);
         MACDSignal = iMACD(_SYMBOL, TIMEFRAME2, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT);

         switch(_OPEN_SIGNAL_COMBINATION)
         {
//-
//1
            case 1:
            {
               if(MACDHistogram > MACDSignal && MACDHistogram < 0)
               if(Open[0] > Open[1] && Open[1] > Open[2] && Open[2] > Open[3])
                  result = 1;
               break;
            }
            case 2:
            {
               if(MACDHistogram > MACDSignal && MACDHistogram < 0)
               if(Open[0] > Open[1] && Open[1] > Open[2])
                  result = 1;
               break;
            }
            case 3:
            {
               if(MACDHistogram > MACDSignal && MACDHistogram < 0)
               if(Open[0] > Open[3])
                  result = 1;
               break;
            }
            case 4:
            {
               if(MACDHistogram > MACDSignal && MACDHistogram < 0)
               if(Open[0] > Low[1] && Low[1] > Low[2])
                  result = 1;
               break;
            }
//2            
            case 5:
            {
               if(MACDHistogram > MACDSignal && MACDHistogram < 0)
               if(Open[0] > Open[1] && Open[1] > Open[2] && Open[2] > Open[3])
               if(Open[0] > Open[3])
                  result = 1;
               break;
            }
            case 6:
            {
               if(MACDHistogram > MACDSignal && MACDHistogram < 0)
               if(Open[0] > Open[1] && Open[1] > Open[2] && Open[2] > Open[3])
               if(Open[0] > Low[1] && Low[1] > Low[2])
                  result = 1;
               break;
            }
            case 7:
            {
               if(MACDHistogram > MACDSignal && MACDHistogram < 0)
               if(Open[0] > Open[1] && Open[1] > Open[2])
               if(Open[0] > Open[3])
                  result = 1;
               break;
            }
            case 8:
            {
               if(MACDHistogram > MACDSignal && MACDHistogram < 0)
               if(Open[0] > Open[1] && Open[1] > Open[2])
               if(Open[0] > Low[1] && Low[1] > Low[2])
                  result = 1;
               break;
            }
            case 9:
            {
               if(MACDHistogram > MACDSignal && MACDHistogram < 0)
               if(Open[0] > Open[3])
               if(Open[0] > Low[1] && Low[1] > Low[2])
                  result = 1;
               break;
            }
//3
            case 10:
            {
               if(MACDHistogram > MACDSignal && MACDHistogram < 0)
               if(Open[0] > Open[1] && Open[1] > Open[2] && Open[2] > Open[3])
               if(Open[0] > Open[3])
               if(Open[0] > Low[1] && Low[1] > Low[2])
                  result = 1;
               break;
            }
            case 11:
            {
               if(MACDHistogram > MACDSignal && MACDHistogram < 0)
               if(Open[0] > Open[1] && Open[1] > Open[2])
               if(Open[0] > Open[3])
               if(Open[0] > Low[1] && Low[1] > Low[2])
                  result = 1;
               break;
            }
//--
//1
            case 12:
            {
               if(MACDHistogram > MACDSignal)
               if(Open[0] > Open[1] && Open[1] > Open[2] && Open[2] > Open[3])
                  result = 1;
               break;
            }
            case 13:
            {
               if(MACDHistogram > MACDSignal)
               if(Open[0] > Open[1] && Open[1] > Open[2])
                  result = 1;
               break;
            }
            case 14:
            {
               if(MACDHistogram > MACDSignal)
               if(Open[0] > Open[3])
                  result = 1;
               break;
            }
            case 15:
            {
               if(MACDHistogram > MACDSignal)
               if(Open[0] > Low[1] && Low[1] > Low[2])
                  result = 1;
               break;
            }
//2            
            case 16:
            {
               if(MACDHistogram > MACDSignal)
               if(Open[0] > Open[1] && Open[1] > Open[2] && Open[2] > Open[3])
               if(Open[0] > Open[3])
                  result = 1;
               break;
            }
            case 17:
            {
               if(MACDHistogram > MACDSignal)
               if(Open[0] > Open[1] && Open[1] > Open[2] && Open[2] > Open[3])
               if(Open[0] > Low[1] && Low[1] > Low[2])
                  result = 1;
               break;
            }
            case 18:
            {
               if(MACDHistogram > MACDSignal)
               if(Open[0] > Open[1] && Open[1] > Open[2])
               if(Open[0] > Open[3])
                  result = 1;
               break;
            }
            case 19:
            {
               if(MACDHistogram > MACDSignal)
               if(Open[0] > Open[1] && Open[1] > Open[2])
               if(Open[0] > Low[1] && Low[1] > Low[2])
                  result = 1;
               break;
            }
            case 20:
            {
               if(MACDHistogram > MACDSignal)
               if(Open[0] > Open[3])
               if(Open[0] > Low[1] && Low[1] > Low[2])
                  result = 1;
               break;
            }
//3
            case 21:
            {
               if(MACDHistogram > MACDSignal)
               if(Open[0] > Open[1] && Open[1] > Open[2] && Open[2] > Open[3])
               if(Open[0] > Open[3])
               if(Open[0] > Low[1] && Low[1] > Low[2])
                  result = 1;
               break;
            }
            case 22:
            {
               if(MACDHistogram > MACDSignal)
               if(Open[0] > Open[1] && Open[1] > Open[2])
               if(Open[0] > Open[3])
               if(Open[0] > Low[1] && Low[1] > Low[2])
                  result = 1;
               break;
            }
//--
//1
            case 23:
            {
               if(MACDHistogram > 0)
               if(Open[0] > Open[1] && Open[1] > Open[2] && Open[2] > Open[3])
                  result = 1;
               break;
            }
            case 24:
            {
               if(MACDHistogram > 0)
               if(Open[0] > Open[1] && Open[1] > Open[2])
                  result = 1;
               break;
            }
            case 25:
            {
               if(MACDHistogram > 0)
               if(Open[0] > Open[3])
                  result = 1;
               break;
            }
            case 26:
            {
               if(MACDHistogram > 0)
               if(Open[0] > Low[1] && Low[1] > Low[2])
                  result = 1;
               break;
            }
//2            
            case 27:
            {
               if(MACDHistogram > 0)
               if(Open[0] > Open[1] && Open[1] > Open[2] && Open[2] > Open[3])
               if(Open[0] > Open[3])
                  result = 1;
               break;
            }
            case 28:
            {
               if(MACDHistogram > 0)
               if(Open[0] > Open[1] && Open[1] > Open[2] && Open[2] > Open[3])
               if(Open[0] > Low[1] && Low[1] > Low[2])
                  result = 1;
               break;
            }
            case 29:
            {
               if(MACDHistogram > 0)
               if(Open[0] > Open[1] && Open[1] > Open[2])
               if(Open[0] > Open[3])
                  result = 1;
               break;
            }
            case 30:
            {
               if(MACDHistogram > 0)
               if(Open[0] > Open[1] && Open[1] > Open[2])
               if(Open[0] > Low[1] && Low[1] > Low[2])
                  result = 1;
               break;
            }
            case 31:
            {
               if(MACDHistogram > 0)
               if(Open[0] > Open[3])
               if(Open[0] > Low[1] && Low[1] > Low[2])
                  result = 1;
               break;
            }
//3
            case 32:
            {
               if(MACDHistogram > 0)
               if(Open[0] > Open[1] && Open[1] > Open[2] && Open[2] > Open[3])
               if(Open[0] > Open[3])
               if(Open[0] > Low[1] && Low[1] > Low[2])
                  result = 1;
               break;
            }
            case 33:
            {
               if(MACDHistogram > 0)
               if(Open[0] > Open[1] && Open[1] > Open[2])
               if(Open[0] > Open[3])
               if(Open[0] > Low[1] && Low[1] > Low[2])
                  result = 1;
               break;
            }
         }
                  
         break;
      }
      case _OPEN_SHORT:
      {
         MACDHistogram = iMACD(_SYMBOL, TIMEFRAME2, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT);
         MACDSignal = iMACD(_SYMBOL, TIMEFRAME2, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT);

         switch(_OPEN_SIGNAL_COMBINATION)
         {
//-
//1
            case 1:
            {
               if(MACDHistogram < MACDSignal && MACDHistogram > 0)
               if(Open[0] < Open[1] && Open[1] < Open[2] && Open[2] < Open[3])
                  result = 1;
               break;
            }
            case 2:
            {
               if(MACDHistogram < MACDSignal && MACDHistogram > 0)
               if(Open[0] < Open[1] && Open[1] < Open[2])
                  result = 1;
               break;
            }
            case 3:
            {
               if(MACDHistogram < MACDSignal && MACDHistogram > 0)
               if(Open[0] < Open[3])
                  result = 1;
               break;
            }
            case 4:
            {
               if(MACDHistogram < MACDSignal && MACDHistogram > 0)
               if(Open[0] < High[1] && High[1] < High[2])
                  result = 1;
               break;
            }
//2            
            case 5:
            {
               if(MACDHistogram < MACDSignal && MACDHistogram > 0)
               if(Open[0] < Open[1] && Open[1] < Open[2] && Open[2] < Open[3])
               if(Open[0] < Open[3])
                  result = 1;
               break;
            }
            case 6:
            {
               if(MACDHistogram < MACDSignal && MACDHistogram > 0)
               if(Open[0] < Open[1] && Open[1] < Open[2] && Open[2] < Open[3])
               if(Open[0] < High[1] && High[1] < High[2])
                  result = 1;
               break;
            }
            case 7:
            {
               if(MACDHistogram < MACDSignal && MACDHistogram > 0)
               if(Open[0] < Open[1] && Open[1] < Open[2])
               if(Open[0] < Open[3])
                  result = 1;
               break;
            }
            case 8:
            {
               if(MACDHistogram < MACDSignal && MACDHistogram > 0)
               if(Open[0] < Open[1] && Open[1] < Open[2])
               if(Open[0] < High[1] && High[1] < High[2])
                  result = 1;
               break;
            }
            case 9:
            {
               if(MACDHistogram < MACDSignal && MACDHistogram > 0)
               if(Open[0] < Open[3])
               if(Open[0] < High[1] && High[1] < High[2])
                  result = 1;
               break;
            }
//3
            case 10:
            {
               if(MACDHistogram < MACDSignal && MACDHistogram > 0)
               if(Open[0] < Open[1] && Open[1] < Open[2] && Open[2] < Open[3])
               if(Open[0] < Open[3])
               if(Open[0] < High[1] && High[1] < High[2])
                  result = 1;
               break;
            }
            case 11:
            {
               if(MACDHistogram < MACDSignal && MACDHistogram > 0)
               if(Open[0] < Open[1] && Open[1] < Open[2])
               if(Open[0] < Open[3])
               if(Open[0] < High[1] && High[1] < High[2])
                  result = 1;
               break;
            }
//--
//1
            case 12:
            {
               if(MACDHistogram < MACDSignal)
               if(Open[0] < Open[1] && Open[1] < Open[2] && Open[2] < Open[3])
                  result = 1;
               break;
            }
            case 13:
            {
               if(MACDHistogram < MACDSignal)
               if(Open[0] < Open[1] && Open[1] < Open[2])
                  result = 1;
               break;
            }
            case 14:
            {
               if(MACDHistogram < MACDSignal)
               if(Open[0] < Open[3])
                  result = 1;
               break;
            }
            case 15:
            {
               if(MACDHistogram < MACDSignal)
               if(Open[0] < High[1] && High[1] < High[2])
                  result = 1;
               break;
            }
//2            
            case 16:
            {
               if(MACDHistogram < MACDSignal)
               if(Open[0] < Open[1] && Open[1] < Open[2] && Open[2] < Open[3])
               if(Open[0] < Open[3])
                  result = 1;
               break;
            }
            case 17:
            {
               if(MACDHistogram < MACDSignal)
               if(Open[0] < Open[1] && Open[1] < Open[2] && Open[2] < Open[3])
               if(Open[0] < High[1] && High[1] < High[2])
                  result = 1;
               break;
            }
            case 18:
            {
               if(MACDHistogram < MACDSignal)
               if(Open[0] < Open[1] && Open[1] < Open[2])
               if(Open[0] < Open[3])
                  result = 1;
               break;
            }
            case 19:
            {
               if(MACDHistogram < MACDSignal)
               if(Open[0] < Open[1] && Open[1] < Open[2])
               if(Open[0] < High[1] && High[1] < High[2])
                  result = 1;
               break;
            }
            case 20:
            {
               if(MACDHistogram < MACDSignal)
               if(Open[0] < Open[3])
               if(Open[0] < High[1] && High[1] < High[2])
                  result = 1;
               break;
            }
//3
            case 21:
            {
               if(MACDHistogram < MACDSignal)
               if(Open[0] < Open[1] && Open[1] < Open[2] && Open[2] < Open[3])
               if(Open[0] < Open[3])
               if(Open[0] < High[1] && High[1] < High[2])
                  result = 1;
               break;
            }
            case 22:
            {
               if(MACDHistogram < MACDSignal)
               if(Open[0] > Open[1] && Open[1] > Open[2])
               if(Open[0] < Open[3])
               if(Open[0] < High[1] && High[1] < High[2])
                  result = 1;
               break;
            }
//--
//1
            case 23:
            {
               if(MACDHistogram < 0)
               if(Open[0] < Open[1] && Open[1] < Open[2] && Open[2] < Open[3])
                  result = 1;
               break;
            }
            case 24:
            {
               if(MACDHistogram < 0)
               if(Open[0] < Open[1] && Open[1] < Open[2])
                  result = 1;
               break;
            }
            case 25:
            {
               if(MACDHistogram < 0)
               if(Open[0] < Open[3])
                  result = 1;
               break;
            }
            case 26:
            {
               if(MACDHistogram < 0)
               if(Open[0] < High[1] && High[1] < High[2])
                  result = 1;
               break;
            }
//2            
            case 27:
            {
               if(MACDHistogram < 0)
               if(Open[0] < Open[1] && Open[1] < Open[2] && Open[2] < Open[3])
               if(Open[0] < Open[3])
                  result = 1;
               break;
            }
            case 28:
            {
               if(MACDHistogram < 0)
               if(Open[0] < Open[1] && Open[1] < Open[2] && Open[2] < Open[3])
               if(Open[0] < High[1] && High[1] < High[2])
                  result = 1;
               break;
            }
            case 29:
            {
               if(MACDHistogram < 0)
               if(Open[0] < Open[1] && Open[1] < Open[2])
               if(Open[0] < Open[3])
                  result = 1;
               break;
            }
            case 30:
            {
               if(MACDHistogram < 0)
               if(Open[0] < Open[1] && Open[1] < Open[2])
               if(Open[0] < High[1] && High[1] < High[2])
                  result = 1;
               break;
            }
            case 31:
            {
               if(MACDHistogram < 0)
               if(Open[0] < Open[3])
               if(Open[0] < High[1] && High[1] < High[2])
                  result = 1;
               break;
            }
//3
            case 32:
            {
               if(MACDHistogram < 0)
               if(Open[0] < Open[1] && Open[1] < Open[2] && Open[2] < Open[3])
               if(Open[0] < Open[3])
               if(Open[0] < High[1] && High[1] < High[2])
                  result = 1;
               break;
            }
            case 33:
            {
               if(MACDHistogram < 0)
               if(Open[0] < Open[1] && Open[1] < Open[2])
               if(Open[0] < Open[3])
               if(Open[0] < High[1] && High[1] < High[2])
                  result = 1;
               break;
            }
         }
         
         break;
      }
      case _CLOSE_LONG:
      {
         switch(_CLOSE_SIGNAL_COMBINATION)
         {
            case 1:
            {
               if(iOpen(_SYMBOL, _TIMEFRAME, 0) < iOpen(_SYMBOL, _TIMEFRAME, 1))
                  result = 1;
               break;
            }
            case 2:
            {
               if(iOpen(_SYMBOL, TIMEFRAME2, 0) < iOpen(_SYMBOL, TIMEFRAME2, 1))
                  result = 1;
               break;
            }
            case 3:
            {
               if(iClose(_SYMBOL, _TIMEFRAME, 1) < iClose(_SYMBOL, _TIMEFRAME, 2))
                  result = 1;
               break;
            }
            case 4:
            {
               if(iClose(_SYMBOL, TIMEFRAME2, 1) < iClose(_SYMBOL, TIMEFRAME2, 2))
                  result = 1;
               break;
            }
            case 5:
            {
               break;
            }
         }

         break;
      }
      case _CLOSE_SHORT:
      {
         switch(_CLOSE_SIGNAL_COMBINATION)
         {
            case 1:
            {
               if(iOpen(_SYMBOL, _TIMEFRAME, 0) > iOpen(_SYMBOL, _TIMEFRAME, 1))
                  result = 1;
               break;
            }
            case 2:
            {
               if(iOpen(_SYMBOL, TIMEFRAME2, 0) > iOpen(_SYMBOL, TIMEFRAME2, 1))
                  result = 1;
               break;
            }
            case 3:
            {
               if(iClose(_SYMBOL, _TIMEFRAME, 1) > iClose(_SYMBOL, _TIMEFRAME, 2))
                  result = 1;
               break;
            }
            case 4:
            {
               if(iClose(_SYMBOL, TIMEFRAME2, 1) > iClose(_SYMBOL, TIMEFRAME2, 2))
                  result = 1;
               break;
            }
            case 5:
            {
               break;
            }
         }

         break;
      }
      case _GET_LONG_STOPLOSS_PRICE:
      {
         switch(_STOPLOSS_COMBINATION)
         {
            case 1:
            {
               result = iFractals(_SYMBOL, _TIMEFRAME, MODE_LOWER, 1);
               break;
            }
            case 2:
            {
               result = iLow(_SYMBOL, _TIMEFRAME, 1);
               break;
            }
            case 3:
            {
               break;
            }
         }

         break;
      }
      case _GET_LONG_TAKEPROFIT_PRICE:
      {
         break;
      }
      case _GET_SHORT_STOPLOSS_PRICE:
      {
         switch(_STOPLOSS_COMBINATION)
         {
            case 1:
            {
               result = iFractals(_SYMBOL, _TIMEFRAME, MODE_UPPER, 1);
               break;
            }
            case 2:
            {
               result = iHigh(_SYMBOL, _TIMEFRAME, 1);
               break;
            }
            case 3:
            {
               break;
            }
         }
         
         break;
      }
      case _GET_SHORT_TAKEPROFIT_PRICE:
      {
         break;
      }
      case _GET_TRAILED_STOPLOSS_PRICE:
      {
         switch(_TRAILING_STOPLOSS_COMBINATION)
         {
            case 1:
            {
               break;
            }
            case 2:
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
   int      _TIMEFRAME     = getStrategyTimeframeByNumber(_STRATEGY_TIMEFRAME);
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
      case _OPEN_LONG:
      {
         MAFast = iMA(_SYMBOL, _TIMEFRAME, _FASTMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MASlow = iMA(_SYMBOL, _TIMEFRAME, _SLOWMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MALong = iMA(_SYMBOL, _TIMEFRAME, _LONGMA, 0, _MAMETHOD, _PRICE, _SHIFT);
         MALong1 = iMA(_SYMBOL, _TIMEFRAME, _LONGMA, 0, _MAMETHOD, _PRICE, _SHIFT + 1);

         MACDHistogram = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT);
         MACDSignal = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT);

         switch(_OPEN_SIGNAL_COMBINATION)
         {
//1
            case 1:
            {
               if(MACDHistogram > MACDSignal)
               if(MAFast > MASlow)
                  result = 1;
               break;
            }
            case 2:
            {
               if(MACDHistogram > MACDSignal)
               if(Ask > MALong)
                  result = 1;
               break;
            }
            case 3:
            {
               if(MACDHistogram > MACDSignal)
               if(MAFast > MALong)
                  result = 1;
               break;
            }
            case 4:
            {
               if(MACDHistogram > MACDSignal)
               if(MALong1 < MALong)
                  result = 1;
               break;
            }
//
            case 5:
            {
               if(MACDHistogram < 0)
               if(MAFast > MASlow)
                  result = 1;
               break;
            }
            case 6:
            {
               if(MACDHistogram < 0)
               if(Ask > MALong)
                  result = 1;
               break;
            }
            case 7:
            {
               if(MACDHistogram < 0)
               if(MAFast > MALong)
                  result = 1;
               break;
            }
            case 8:
            {
               if(MACDHistogram < 0)
               if(MALong1 < MALong)
                  result = 1;
               break;
            }
//
            case 9:
            {
               if(MACDHistogram > 0)
               if(MAFast > MASlow)
                  result = 1;
               break;
            }
            case 10:
            {
               if(MACDHistogram > 0)
               if(Ask > MALong)
                  result = 1;
               break;
            }
            case 11:
            {
               if(MACDHistogram > 0)
               if(MAFast > MALong)
                  result = 1;
               break;
            }
            case 12:
            {
               if(MACDHistogram > 0)
               if(MALong1 < MALong)
                  result = 1;
               break;
            }
//
            case 13:
            {
               if(MACDHistogram > MACDSignal)
               if(MACDHistogram < 0)
               if(MAFast > MASlow)
                  result = 1;
               break;
            }
            case 14:
            {
               if(MACDHistogram > MACDSignal)
               if(MACDHistogram < 0)
               if(Ask > MALong)
                  result = 1;
               break;
            }
            case 15:
            {
               if(MACDHistogram > MACDSignal)
               if(MACDHistogram < 0)
               if(MAFast > MALong)
                  result = 1;
               break;
            }
            case 16:
            {
               if(MACDHistogram > MACDSignal)
               if(MACDHistogram < 0)
               if(MALong1 < MALong)
                  result = 1;
               break;
            }
//
            case 17:
            {
               if(MACDHistogram > MACDSignal)
               if(MACDHistogram > 0)
               if(MAFast > MASlow)
                  result = 1;
               break;
            }
            case 18:
            {
               if(MACDHistogram > MACDSignal)
               if(MACDHistogram > 0)
               if(Ask > MALong)
                  result = 1;
               break;
            }
            case 19:
            {
               if(MACDHistogram > MACDSignal)
               if(MACDHistogram > 0)
               if(MAFast > MALong)
                  result = 1;
               break;
            }
            case 20:
            {
               if(MACDHistogram > MACDSignal)
               if(MACDHistogram > 0)
               if(MALong1 < MALong)
                  result = 1;
               break;
            }
//2
            case 21:
            {
               if(MACDHistogram > MACDSignal)
               if(MAFast > MASlow)
               if(Ask > MALong)
                  result = 1;
               break;
            }
            case 22:
            {
               if(MACDHistogram > MACDSignal)
               if(MAFast > MASlow)
               if(MAFast > MALong)
                  result = 1;
               break;
            }
            case 23:
            {
               if(MACDHistogram > MACDSignal)
               if(MAFast > MASlow)
               if(MALong1 < MALong)
                  result = 1;
               break;
            }
            case 24:
            {
               if(MACDHistogram > MACDSignal)
               if(Ask > MALong)
               if(MAFast > MALong)
                  result = 1;
               break;
            }
            case 25:
            {
               if(MACDHistogram > MACDSignal)
               if(Ask > MALong)
               if(MALong1 < MALong)
                  result = 1;
               break;
            }
            case 26:
            {
               if(MACDHistogram > MACDSignal)
               if(MAFast > MALong)
               if(MALong1 < MALong)
                  result = 1;
               break;
            }
//
            case 27:
            {
               if(MACDHistogram < 0)
               if(MAFast > MASlow)
               if(Ask > MALong)
                  result = 1;
               break;
            }
            case 28:
            {
               if(MACDHistogram < 0)
               if(MAFast > MASlow)
               if(MAFast > MALong)
                  result = 1;
               break;
            }
            case 29:
            {
               if(MACDHistogram < 0)
               if(MAFast > MASlow)
               if(MALong1 < MALong)
                  result = 1;
               break;
            }
            case 30:
            {
               if(MACDHistogram < 0)
               if(Ask > MALong)
               if(MAFast > MALong)
                  result = 1;
               break;
            }
            case 31:
            {
               if(MACDHistogram < 0)
               if(Ask > MALong)
               if(MALong1 < MALong)
                  result = 1;
               break;
            }
            case 32:
            {
               if(MACDHistogram < 0)
               if(MAFast > MALong)
               if(MALong1 < MALong)
                  result = 1;
               break;
            }
//
            case 33:
            {
               if(MACDHistogram > 0)
               if(MAFast > MASlow)
               if(Ask > MALong)
                  result = 1;
               break;
            }
            case 34:
            {
               if(MACDHistogram > 0)
               if(MAFast > MASlow)
               if(MAFast > MALong)
                  result = 1;
               break;
            }
            case 35:
            {
               if(MACDHistogram > 0)
               if(MAFast > MASlow)
               if(MALong1 < MALong)
                  result = 1;
               break;
            }
            case 36:
            {
               if(MACDHistogram > 0)
               if(Ask > MALong)
               if(MAFast > MALong)
                  result = 1;
               break;
            }
            case 37:
            {
               if(MACDHistogram > 0)
               if(Ask > MALong)
               if(MALong1 < MALong)
                  result = 1;
               break;
            }
            case 38:
            {
               if(MACDHistogram > 0)
               if(MAFast > MALong)
               if(MALong1 < MALong)
                  result = 1;
               break;
            }
//
            case 39:
            {
               if(MACDHistogram > MACDSignal)
               if(MACDHistogram < 0)
               if(MAFast > MASlow)
               if(Ask > MALong)
                  result = 1;
               break;
            }
            case 40:
            {
               if(MACDHistogram > MACDSignal)
               if(MACDHistogram < 0)
               if(MAFast > MASlow)
               if(MAFast > MALong)
                  result = 1;
               break;
            }
            case 41:
            {
               if(MACDHistogram > MACDSignal)
               if(MACDHistogram < 0)
               if(MAFast > MASlow)
               if(MALong1 < MALong)
                  result = 1;
               break;
            }
            case 42:
            {
               if(MACDHistogram > MACDSignal)
               if(MACDHistogram < 0)
               if(Ask > MALong)
               if(MAFast > MALong)
                  result = 1;
               break;
            }
            case 43:
            {
               if(MACDHistogram > MACDSignal)
               if(MACDHistogram < 0)
               if(Ask > MALong)
               if(MALong1 < MALong)
                  result = 1;
               break;
            }
            case 44:
            {
               if(MACDHistogram > MACDSignal)
               if(MACDHistogram < 0)
               if(MAFast > MALong)
               if(MALong1 < MALong)
                  result = 1;
               break;
            }
//
            case 45:
            {
               if(MACDHistogram > MACDSignal)
               if(MACDHistogram > 0)
               if(MAFast > MASlow)
               if(Ask > MALong)
                  result = 1;
               break;
            }
            case 46:
            {
               if(MACDHistogram > MACDSignal)
               if(MACDHistogram > 0)
               if(MAFast > MASlow)
               if(MAFast > MALong)
                  result = 1;
               break;
            }
            case 47:
            {
               if(MACDHistogram > MACDSignal)
               if(MACDHistogram > 0)
               if(MAFast > MASlow)
               if(MALong1 < MALong)
                  result = 1;
               break;
            }
            case 48:
            {
               if(MACDHistogram > MACDSignal)
               if(MACDHistogram > 0)
               if(Ask > MALong)
               if(MAFast > MALong)
                  result = 1;
               break;
            }
            case 49:
            {
               if(MACDHistogram > MACDSignal)
               if(MACDHistogram > 0)
               if(Ask > MALong)
               if(MALong1 < MALong)
                  result = 1;
               break;
            }
            case 50:
            {
               if(MACDHistogram > MACDSignal)
               if(MACDHistogram > 0)
               if(MAFast > MALong)
               if(MALong1 < MALong)
                  result = 1;
               break;
            }
//3
            case 51:
            {
               if(MACDHistogram > MACDSignal)
               if(MAFast > MASlow)
               if(Ask > MALong)
               if(MAFast > MALong)
                  result = 1;
               break;
            }
            case 52:
            {
               if(MACDHistogram > MACDSignal)
               if(MAFast > MASlow)
               if(Ask > MALong)
               if(MALong1 < MALong)
                  result = 1;
               break;
            }
            case 53:
            {
               if(MACDHistogram > MACDSignal)
               if(MAFast > MASlow)
               if(MAFast > MALong)
               if(MALong1 < MALong)
                  result = 1;
               break;
            }            
            case 54:
            {
               if(MACDHistogram > MACDSignal)
               if(Ask > MALong)
               if(MAFast > MALong)
               if(MALong1 < MALong)
                  result = 1;
               break;
            }
//
            case 55:
            {
               if(MACDHistogram < 0)
               if(MAFast > MASlow)
               if(Ask > MALong)
               if(MAFast > MALong)
                  result = 1;
               break;
            }
            case 56:
            {
               if(MACDHistogram < 0)
               if(MAFast > MASlow)
               if(Ask > MALong)
               if(MALong1 < MALong)
                  result = 1;
               break;
            }
            case 57:
            {
               if(MACDHistogram < 0)
               if(MAFast > MASlow)
               if(MAFast > MALong)
               if(MALong1 < MALong)
                  result = 1;
               break;
            }            
            case 58:
            {
               if(MACDHistogram < 0)
               if(Ask > MALong)
               if(MAFast > MALong)
               if(MALong1 < MALong)
                  result = 1;
               break;
            }
//
            case 59:
            {
               if(MACDHistogram > 0)
               if(MAFast > MASlow)
               if(Ask > MALong)
               if(MAFast > MALong)
                  result = 1;
               break;
            }
            case 60:
            {
               if(MACDHistogram > 0)
               if(MAFast > MASlow)
               if(Ask > MALong)
               if(MALong1 < MALong)
                  result = 1;
               break;
            }
            case 61:
            {
               if(MACDHistogram > 0)
               if(MAFast > MASlow)
               if(MAFast > MALong)
               if(MALong1 < MALong)
                  result = 1;
               break;
            }            
            case 62:
            {
               if(MACDHistogram > 0)
               if(Ask > MALong)
               if(MAFast > MALong)
               if(MALong1 < MALong)
                  result = 1;
               break;
            }
//
            case 63:
            {
               if(MACDHistogram > MACDSignal)
               if(MACDHistogram < 0)
               if(MAFast > MASlow)
               if(Ask > MALong)
               if(MAFast > MALong)
                  result = 1;
               break;
            }
            case 64:
            {
               if(MACDHistogram > MACDSignal)
               if(MACDHistogram < 0)
               if(MAFast > MASlow)
               if(Ask > MALong)
               if(MALong1 < MALong)
                  result = 1;
               break;
            }
            case 65:
            {
               if(MACDHistogram > MACDSignal)
               if(MACDHistogram < 0)
               if(MAFast > MASlow)
               if(MAFast > MALong)
               if(MALong1 < MALong)
                  result = 1;
               break;
            }            
            case 66:
            {
               if(MACDHistogram > MACDSignal)
               if(MACDHistogram < 0)
               if(Ask > MALong)
               if(MAFast > MALong)
               if(MALong1 < MALong)
                  result = 1;
               break;
            }
//
            case 67:
            {
               if(MACDHistogram > MACDSignal)
               if(MACDHistogram > 0)
               if(MAFast > MASlow)
               if(Ask > MALong)
               if(MAFast > MALong)
                  result = 1;
               break;
            }
            case 68:
            {
               if(MACDHistogram > MACDSignal)
               if(MACDHistogram > 0)
               if(MAFast > MASlow)
               if(Ask > MALong)
               if(MALong1 < MALong)
                  result = 1;
               break;
            }
            case 69:
            {
               if(MACDHistogram > MACDSignal)
               if(MACDHistogram > 0)
               if(MAFast > MASlow)
               if(MAFast > MALong)
               if(MALong1 < MALong)
                  result = 1;
               break;
            }
            case 70:
            {
               if(MACDHistogram > MACDSignal)
               if(MACDHistogram > 0)
               if(Ask > MALong)
               if(MAFast > MALong)
               if(MALong1 < MALong)
                  result = 1;
               break;
            }
//4
            case 71:
            {
               if(MACDHistogram > MACDSignal)
               if(MAFast > MASlow)
               if(Ask > MALong)
               if(MAFast > MALong)
               if(MALong1 < MALong)
                  result = 1;
               break;
            }
            case 72:
            {
               if(MACDHistogram < 0)
               if(MAFast > MASlow)
               if(Ask > MALong)
               if(MAFast > MALong)
               if(MALong1 < MALong)
                  result = 1;
               break;
            }
            case 73:
            {
               if(MACDHistogram > 0)
               if(MAFast > MASlow)
               if(Ask > MALong)
               if(MAFast > MALong)
               if(MALong1 < MALong)
                  result = 1;
               break;
            }
            case 74:
            {
               if(MACDHistogram > MACDSignal)
               if(MACDHistogram < 0)
               if(MAFast > MASlow)
               if(Ask > MALong)
               if(MAFast > MALong)
               if(MALong1 < MALong)
                  result = 1;
               break;
            }
            case 75:
            {
               if(MACDHistogram > MACDSignal)
               if(MACDHistogram > 0)
               if(MAFast > MASlow)
               if(Ask > MALong)
               if(MAFast > MALong)
               if(MALong1 < MALong)
                  result = 1;
               break;
            }
         }

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

         switch(_OPEN_SIGNAL_COMBINATION)
         {
//1
            case 1:
            {
               if(MACDHistogram < MACDSignal)
               if(MAFast > MASlow)
                  result = 1;
               break;
            }
            case 2:
            {
               if(MACDHistogram < MACDSignal)
               if(Ask > MALong)
                  result = 1;
               break;
            }
            case 3:
            {
               if(MACDHistogram < MACDSignal)
               if(MAFast > MALong)
                  result = 1;
               break;
            }
            case 4:
            {
               if(MACDHistogram < MACDSignal)
               if(MALong1 < MALong)
                  result = 1;
               break;
            }
//
            case 5:
            {
               if(MACDHistogram > 0)
               if(MAFast > MASlow)
                  result = 1;
               break;
            }
            case 6:
            {
               if(MACDHistogram > 0)
               if(Ask > MALong)
                  result = 1;
               break;
            }
            case 7:
            {
               if(MACDHistogram > 0)
               if(MAFast > MALong)
                  result = 1;
               break;
            }
            case 8:
            {
               if(MACDHistogram > 0)
               if(MALong1 < MALong)
                  result = 1;
               break;
            }
//
            case 9:
            {
               if(MACDHistogram < 0)
               if(MAFast > MASlow)
                  result = 1;
               break;
            }
            case 10:
            {
               if(MACDHistogram < 0)
               if(Ask > MALong)
                  result = 1;
               break;
            }
            case 11:
            {
               if(MACDHistogram < 0)
               if(MAFast > MALong)
                  result = 1;
               break;
            }
            case 12:
            {
               if(MACDHistogram < 0)
               if(MALong1 < MALong)
                  result = 1;
               break;
            }
//
            case 13:
            {
               if(MACDHistogram < MACDSignal)
               if(MACDHistogram > 0)
               if(MAFast > MASlow)
                  result = 1;
               break;
            }
            case 14:
            {
               if(MACDHistogram < MACDSignal)
               if(MACDHistogram > 0)
               if(Ask > MALong)
                  result = 1;
               break;
            }
            case 15:
            {
               if(MACDHistogram < MACDSignal)
               if(MACDHistogram > 0)
               if(MAFast > MALong)
                  result = 1;
               break;
            }
            case 16:
            {
               if(MACDHistogram < MACDSignal)
               if(MACDHistogram > 0)
               if(MALong1 < MALong)
                  result = 1;
               break;
            }
//
            case 17:
            {
               if(MACDHistogram < MACDSignal)
               if(MACDHistogram < 0)
               if(MAFast > MASlow)
                  result = 1;
               break;
            }
            case 18:
            {
               if(MACDHistogram < MACDSignal)
               if(MACDHistogram < 0)
               if(Ask > MALong)
                  result = 1;
               break;
            }
            case 19:
            {
               if(MACDHistogram < MACDSignal)
               if(MACDHistogram < 0)
               if(MAFast > MALong)
                  result = 1;
               break;
            }
            case 20:
            {
               if(MACDHistogram < MACDSignal)
               if(MACDHistogram < 0)
               if(MALong1 < MALong)
                  result = 1;
               break;
            }
//2
            case 21:
            {
               if(MACDHistogram < MACDSignal)
               if(MAFast > MASlow)
               if(Ask > MALong)
                  result = 1;
               break;
            }
            case 22:
            {
               if(MACDHistogram < MACDSignal)
               if(MAFast > MASlow)
               if(MAFast > MALong)
                  result = 1;
               break;
            }
            case 23:
            {
               if(MACDHistogram < MACDSignal)
               if(MAFast > MASlow)
               if(MALong1 < MALong)
                  result = 1;
               break;
            }
            case 24:
            {
               if(MACDHistogram < MACDSignal)
               if(Ask > MALong)
               if(MAFast > MALong)
                  result = 1;
               break;
            }
            case 25:
            {
               if(MACDHistogram < MACDSignal)
               if(Ask > MALong)
               if(MALong1 < MALong)
                  result = 1;
               break;
            }
            case 26:
            {
               if(MACDHistogram < MACDSignal)
               if(MAFast > MALong)
               if(MALong1 < MALong)
                  result = 1;
               break;
            }
//
            case 27:
            {
               if(MACDHistogram > 0)
               if(MAFast > MASlow)
               if(Ask > MALong)
                  result = 1;
               break;
            }
            case 28:
            {
               if(MACDHistogram > 0)
               if(MAFast > MASlow)
               if(MAFast > MALong)
                  result = 1;
               break;
            }
            case 29:
            {
               if(MACDHistogram > 0)
               if(MAFast > MASlow)
               if(MALong1 < MALong)
                  result = 1;
               break;
            }
            case 30:
            {
               if(MACDHistogram > 0)
               if(Ask > MALong)
               if(MAFast > MALong)
                  result = 1;
               break;
            }
            case 31:
            {
               if(MACDHistogram > 0)
               if(Ask > MALong)
               if(MALong1 < MALong)
                  result = 1;
               break;
            }
            case 32:
            {
               if(MACDHistogram > 0)
               if(MAFast > MALong)
               if(MALong1 < MALong)
                  result = 1;
               break;
            }
//
            case 33:
            {
               if(MACDHistogram < 0)
               if(MAFast > MASlow)
               if(Ask > MALong)
                  result = 1;
               break;
            }
            case 34:
            {
               if(MACDHistogram < 0)
               if(MAFast > MASlow)
               if(MAFast > MALong)
                  result = 1;
               break;
            }
            case 35:
            {
               if(MACDHistogram < 0)
               if(MAFast > MASlow)
               if(MALong1 < MALong)
                  result = 1;
               break;
            }
            case 36:
            {
               if(MACDHistogram < 0)
               if(Ask > MALong)
               if(MAFast > MALong)
                  result = 1;
               break;
            }
            case 37:
            {
               if(MACDHistogram < 0)
               if(Ask > MALong)
               if(MALong1 < MALong)
                  result = 1;
               break;
            }
            case 38:
            {
               if(MACDHistogram < 0)
               if(MAFast > MALong)
               if(MALong1 < MALong)
                  result = 1;
               break;
            }
//
            case 39:
            {
               if(MACDHistogram < MACDSignal)
               if(MACDHistogram > 0)
               if(MAFast > MASlow)
               if(Ask > MALong)
                  result = 1;
               break;
            }
            case 40:
            {
               if(MACDHistogram < MACDSignal)
               if(MACDHistogram > 0)
               if(MAFast > MASlow)
               if(MAFast > MALong)
                  result = 1;
               break;
            }
            case 41:
            {
               if(MACDHistogram < MACDSignal)
               if(MACDHistogram > 0)
               if(MAFast > MASlow)
               if(MALong1 < MALong)
                  result = 1;
               break;
            }
            case 42:
            {
               if(MACDHistogram < MACDSignal)
               if(MACDHistogram > 0)
               if(Ask > MALong)
               if(MAFast > MALong)
                  result = 1;
               break;
            }
            case 43:
            {
               if(MACDHistogram < MACDSignal)
               if(MACDHistogram > 0)
               if(Ask > MALong)
               if(MALong1 < MALong)
                  result = 1;
               break;
            }
            case 44:
            {
               if(MACDHistogram < MACDSignal)
               if(MACDHistogram > 0)
               if(MAFast > MALong)
               if(MALong1 < MALong)
                  result = 1;
               break;
            }
//
            case 45:
            {
               if(MACDHistogram < MACDSignal)
               if(MACDHistogram < 0)
               if(MAFast > MASlow)
               if(Ask > MALong)
                  result = 1;
               break;
            }
            case 46:
            {
               if(MACDHistogram < MACDSignal)
               if(MACDHistogram < 0)
               if(MAFast > MASlow)
               if(MAFast > MALong)
                  result = 1;
               break;
            }
            case 47:
            {
               if(MACDHistogram < MACDSignal)
               if(MACDHistogram < 0)
               if(MAFast > MASlow)
               if(MALong1 < MALong)
                  result = 1;
               break;
            }
            case 48:
            {
               if(MACDHistogram < MACDSignal)
               if(MACDHistogram < 0)
               if(Ask > MALong)
               if(MAFast > MALong)
                  result = 1;
               break;
            }
            case 49:
            {
               if(MACDHistogram < MACDSignal)
               if(MACDHistogram < 0)
               if(Ask > MALong)
               if(MALong1 < MALong)
                  result = 1;
               break;
            }
            case 50:
            {
               if(MACDHistogram < MACDSignal)
               if(MACDHistogram < 0)
               if(MAFast > MALong)
               if(MALong1 < MALong)
                  result = 1;
               break;
            }
//3
            case 51:
            {
               if(MACDHistogram < MACDSignal)
               if(MAFast > MASlow)
               if(Ask > MALong)
               if(MAFast > MALong)
                  result = 1;
               break;
            }
            case 52:
            {
               if(MACDHistogram < MACDSignal)
               if(MAFast > MASlow)
               if(Ask > MALong)
               if(MALong1 < MALong)
                  result = 1;
               break;
            }
            case 53:
            {
               if(MACDHistogram < MACDSignal)
               if(MAFast > MASlow)
               if(MAFast > MALong)
               if(MALong1 < MALong)
                  result = 1;
               break;
            }            
            case 54:
            {
               if(MACDHistogram < MACDSignal)
               if(Ask > MALong)
               if(MAFast > MALong)
               if(MALong1 < MALong)
                  result = 1;
               break;
            }
//
            case 55:
            {
               if(MACDHistogram > 0)
               if(MAFast > MASlow)
               if(Ask > MALong)
               if(MAFast > MALong)
                  result = 1;
               break;
            }
            case 56:
            {
               if(MACDHistogram > 0)
               if(MAFast > MASlow)
               if(Ask > MALong)
               if(MALong1 < MALong)
                  result = 1;
               break;
            }
            case 57:
            {
               if(MACDHistogram > 0)
               if(MAFast > MASlow)
               if(MAFast > MALong)
               if(MALong1 < MALong)
                  result = 1;
               break;
            }            
            case 58:
            {
               if(MACDHistogram > 0)
               if(Ask > MALong)
               if(MAFast > MALong)
               if(MALong1 < MALong)
                  result = 1;
               break;
            }
//
            case 59:
            {
               if(MACDHistogram < 0)
               if(MAFast > MASlow)
               if(Ask > MALong)
               if(MAFast > MALong)
                  result = 1;
               break;
            }
            case 60:
            {
               if(MACDHistogram < 0)
               if(MAFast > MASlow)
               if(Ask > MALong)
               if(MALong1 < MALong)
                  result = 1;
               break;
            }
            case 61:
            {
               if(MACDHistogram < 0)
               if(MAFast > MASlow)
               if(MAFast > MALong)
               if(MALong1 < MALong)
                  result = 1;
               break;
            }            
            case 62:
            {
               if(MACDHistogram < 0)
               if(Ask > MALong)
               if(MAFast > MALong)
               if(MALong1 < MALong)
                  result = 1;
               break;
            }
//
            case 63:
            {
               if(MACDHistogram < MACDSignal)
               if(MACDHistogram > 0)
               if(MAFast > MASlow)
               if(Ask > MALong)
               if(MAFast > MALong)
                  result = 1;
               break;
            }
            case 64:
            {
               if(MACDHistogram < MACDSignal)
               if(MACDHistogram > 0)
               if(MAFast > MASlow)
               if(Ask > MALong)
               if(MALong1 < MALong)
                  result = 1;
               break;
            }
            case 65:
            {
               if(MACDHistogram < MACDSignal)
               if(MACDHistogram > 0)
               if(MAFast > MASlow)
               if(MAFast > MALong)
               if(MALong1 < MALong)
                  result = 1;
               break;
            }            
            case 66:
            {
               if(MACDHistogram < MACDSignal)
               if(MACDHistogram > 0)
               if(Ask > MALong)
               if(MAFast > MALong)
               if(MALong1 < MALong)
                  result = 1;
               break;
            }
//
            case 67:
            {
               if(MACDHistogram < MACDSignal)
               if(MACDHistogram < 0)
               if(MAFast > MASlow)
               if(Ask > MALong)
               if(MAFast > MALong)
                  result = 1;
               break;
            }
            case 68:
            {
               if(MACDHistogram < MACDSignal)
               if(MACDHistogram < 0)
               if(MAFast > MASlow)
               if(Ask > MALong)
               if(MALong1 < MALong)
                  result = 1;
               break;
            }
            case 69:
            {
               if(MACDHistogram < MACDSignal)
               if(MACDHistogram < 0)
               if(MAFast > MASlow)
               if(MAFast > MALong)
               if(MALong1 < MALong)
                  result = 1;
               break;
            }
            case 70:
            {
               if(MACDHistogram < MACDSignal)
               if(MACDHistogram < 0)
               if(Ask > MALong)
               if(MAFast > MALong)
               if(MALong1 < MALong)
                  result = 1;
               break;
            }
//4
            case 71:
            {
               if(MACDHistogram < MACDSignal)
               if(MAFast > MASlow)
               if(Ask > MALong)
               if(MAFast > MALong)
               if(MALong1 < MALong)
                  result = 1;
               break;
            }
            case 72:
            {
               if(MACDHistogram > 0)
               if(MAFast > MASlow)
               if(Ask > MALong)
               if(MAFast > MALong)
               if(MALong1 < MALong)
                  result = 1;
               break;
            }
            case 73:
            {
               if(MACDHistogram < 0)
               if(MAFast > MASlow)
               if(Ask > MALong)
               if(MAFast > MALong)
               if(MALong1 < MALong)
                  result = 1;
               break;
            }
            case 74:
            {
               if(MACDHistogram < MACDSignal)
               if(MACDHistogram > 0)
               if(MAFast > MASlow)
               if(Ask > MALong)
               if(MAFast > MALong)
               if(MALong1 < MALong)
                  result = 1;
               break;
            }
            case 75:
            {
               if(MACDHistogram < MACDSignal)
               if(MACDHistogram < 0)
               if(MAFast > MASlow)
               if(Ask > MALong)
               if(MAFast > MALong)
               if(MALong1 < MALong)
                  result = 1;
               break;
            }
         }
                  
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
         switch(_STOPLOSS_COMBINATION)
         {
            case 1:
            {
               result = iFractals(_SYMBOL, _TIMEFRAME, MODE_LOWER, 1);
               break;
            }
            case 2:
            {
               result = iLow(_SYMBOL, _TIMEFRAME, 1);
               break;
            }
            case 3:
            {
               break;
            }
         }

         break;
      }
      case _GET_LONG_TAKEPROFIT_PRICE:
      {
         break;
      }
      case _GET_SHORT_STOPLOSS_PRICE:
      {
         switch(_STOPLOSS_COMBINATION)
         {
            case 1:
            {
               result = iFractals(_SYMBOL, _TIMEFRAME, MODE_UPPER, 1);
               break;
            }
            case 2:
            {
               result = iHigh(_SYMBOL, _TIMEFRAME, 1);
               break;
            }
            case 3:
            {
               break;
            }
         }
         
         break;
      }
      case _GET_SHORT_TAKEPROFIT_PRICE:
      {
         break;
      }
      case _GET_TRAILED_STOPLOSS_PRICE:
      {
         switch(_TRAILING_STOPLOSS_COMBINATION)
         {
            case 1:
            {
               break;
            }
            case 2:
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
   int      _TIMEFRAME     = getStrategyTimeframeByNumber(_STRATEGY_TIMEFRAME);
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
   int      _TIMEFRAME     = getStrategyTimeframeByNumber(_STRATEGY_TIMEFRAME);
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
   int      _TIMEFRAME     = getStrategyTimeframeByNumber(_STRATEGY_TIMEFRAME);
   int      _TIMEFRAME_2   = getHigherTimeframe(_TIMEFRAME);
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
   int      _TIMEFRAME     = getStrategyTimeframeByNumber(_STRATEGY_TIMEFRAME);
   int      _TIMEFRAME_2   = getHigherTimeframe(_TIMEFRAME);
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
         if(Ask < getLastFractalValue(_SYMBOL, _TIMEFRAME, true))
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
         if(Bid > getLastFractalValue(_SYMBOL, _TIMEFRAME, false))
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
         if(Bid > getLastFractalValue(_SYMBOL, _TIMEFRAME, false))
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
         if(Ask < getLastFractalValue(_SYMBOL, _TIMEFRAME, true))
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

         double breakeven = 0;
         
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
                     breakeven = OrderOpenPrice();
                  
                  if(breakeven > Bid - 10*Point)
                     breakeven = Bid - 10*Point;
                  
                  if(breakeven <= OrderStopLoss())
                     breakeven = OrderStopLoss();
               }
               else
               {
                  if(iHigh(_SYMBOL, _TIMEFRAME, 1) < OrderOpenPrice())
                     breakeven = OrderOpenPrice();
                  
                  if(breakeven < Ask + 10*Point)
                     breakeven = Ask + 10*Point;
                     
                  if(breakeven >= OrderStopLoss())
                     breakeven = OrderStopLoss();
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
                  
                  if(breakeven > result)
                     result = breakeven;
                  
                  if(result > Bid - 10*Point)
                     result = Bid - 10*Point;
                  
                  if(result <= OrderStopLoss())
                     result = OrderStopLoss();
               }
               else
               {
//                  result = iHigh(_SYMBOL, _TIMEFRAME, 1);
                  result = getLastFractalValue(_SYMBOL, _TIMEFRAME, true) + 5*Point;
                  
                  if(breakeven > result)
                     result = breakeven;

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
   int      _TIMEFRAME_2   = getHigherTimeframe(_TIMEFRAME);
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
         if(Ask < getLastFractalValue(_SYMBOL, _TIMEFRAME, true))
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
         if(Bid > getLastFractalValue(_SYMBOL, _TIMEFRAME, false))
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

         double breakeven = 0;
         
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
                     breakeven = OrderOpenPrice();
                  
                  if(breakeven > Bid - 10*Point)
                     breakeven = Bid - 10*Point;
                  
                  if(breakeven <= OrderStopLoss())
                     breakeven = OrderStopLoss();
               }
               else
               {
                  if(iHigh(_SYMBOL, _TIMEFRAME, 1) < OrderOpenPrice())
                     breakeven = OrderOpenPrice();
                  
                  if(breakeven < Ask + 10*Point)
                     breakeven = Ask + 10*Point;
                     
                  if(breakeven >= OrderStopLoss())
                     breakeven = OrderStopLoss();
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
                  
                  if(breakeven > result)
                     result = breakeven;
                  
                  if(result > Bid - 10*Point)
                     result = Bid - 10*Point;
                  
                  if(result <= OrderStopLoss())
                     result = OrderStopLoss();
               }
               else
               {
//                  result = iHigh(_SYMBOL, _TIMEFRAME, 1);
                  result = getLastFractalValue(_SYMBOL, _TIMEFRAME, true) + 5*Point;
                  
                  if(breakeven > result)
                     result = breakeven;

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
//   int      _TIMEFRAME     = _TIMEFRAME;
   int      _TIMEFRAME_2   = getHigherTimeframe(_TIMEFRAME);
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

         double breakeven = 0;
         
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
                     breakeven = OrderOpenPrice();
                  
                  if(breakeven > Bid - 10*Point)
                     breakeven = Bid - 10*Point;
                  
                  if(breakeven <= OrderStopLoss())
                     breakeven = OrderStopLoss();
               }
               else
               {
                  if(iHigh(_SYMBOL, _TIMEFRAME, 1) < OrderOpenPrice())
                     breakeven = OrderOpenPrice();
                  
                  if(breakeven < Ask + 10*Point)
                     breakeven = Ask + 10*Point;
                     
                  if(breakeven >= OrderStopLoss())
                     breakeven = OrderStopLoss();
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
                  
                  if(breakeven > result)
                     result = breakeven;
                  
                  if(result > Bid - 15*Point)
                     result = Bid - 15*Point;
                  
                  if(result <= OrderStopLoss())
                     result = OrderStopLoss();
               }
               else
               {
//                  result = iHigh(_SYMBOL, _TIMEFRAME, 1);
                  result = getLastFractalValue(_SYMBOL, _TIMEFRAME, true) + 5*Point;
                  
                  if(breakeven > result)
                     result = breakeven;

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
   int      _TIMEFRAME_2   = getHigherTimeframe(_TIMEFRAME);
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
      case _OPEN_LONG:
      {
//         _PRICE = PRICE_LOW;
         if(!OpenNewBar(_TIMEFRAME))
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
         if(!OpenNewBar(_TIMEFRAME))
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
         if(!OpenNewBar(_TIMEFRAME))
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
         if(!OpenNewBar(_TIMEFRAME))
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

         double breakeven = 0;
         
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
                     breakeven = OrderOpenPrice();
                  
                  if(breakeven > Bid - 10*Point)
                     breakeven = Bid - 10*Point;
                  
                  if(breakeven <= OrderStopLoss())
                     breakeven = OrderStopLoss();
               }
               else
               {
                  if(iHigh(_SYMBOL, _TIMEFRAME, 1) < OrderOpenPrice())
                     breakeven = OrderOpenPrice();
                  
                  if(breakeven < Ask + 10*Point)
                     breakeven = Ask + 10*Point;
                     
                  if(breakeven >= OrderStopLoss())
                     breakeven = OrderStopLoss();
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
                  
                  if(breakeven > result)
                     result = breakeven;
                  
                  if(result > Bid - 15*Point)
                     result = Bid - 15*Point;
                  
                  if(result <= OrderStopLoss())
                     result = OrderStopLoss();
               }
               else
               {
//                  result = iHigh(_SYMBOL, _TIMEFRAME, 1);
                  result = getLastFractalValue(_SYMBOL, _TIMEFRAME, true) + 5*Point;
                  
                  if(breakeven > result)
                     result = breakeven;

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
   int      _TIMEFRAME_2   = _TIMEFRAME;
//   int      _TIMEFRAME_2   = getHigherTimeframe(_TIMEFRAME);
//   int      _TIMEFRAME_2   = getHigherTimeframe(getHigherTimeframe(_TIMEFRAME));
//   int      _TIMEFRAME_2   = getHigherTimeframe(getHigherTimeframe(getHigherTimeframe(_TIMEFRAME)));
   int      _SLOWEMA       = 26;
   int      _FASTEMA       = 12;
   int      _MASIGNAL      = 9;
   int      _MAMETHOD      = MODE_EMA;
   int      _SLOWMA        = 20;
   int      _FASTMA        = 10;
   int      _LONGMA        = LONGMA;
   int      _SHIFT         = 0;
   int      _PRICE         = PRICE_OPEN;
   int      _MAXSTOPLOSS   = 0;
   int      _MAX_FRACTAL_DISTANCE = 1000;
      
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
   double   EdgePrice;
   
   int      i;

   switch(COMMAND)
   {
      case _OPEN_LONG:
      {
//         if(!OpenNewBar(_TIMEFRAME))
//            break;

/*         
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
*/
/*
         UpperFractal1 = getLastFractalValue(_SYMBOL, _TIMEFRAME, true);
         UpperFractalTime1 = getLastFractalTime(_SYMBOL, _TIMEFRAME, true);
         UpperFractal2 = getPreviousFractalValue(_SYMBOL, _TIMEFRAME, true);
         UpperFractalTime2 = getPreviousFractalTime(_SYMBOL, _TIMEFRAME, true);
*/

         UpperFractal1 = getLastFractalValue(_SYMBOL, _TIMEFRAME_2, true);
         UpperFractalTime1 = getLastFractalTime(_SYMBOL, _TIMEFRAME_2, true);
         UpperFractal2 = getPreviousFractalValue(_SYMBOL, _TIMEFRAME_2, true);
         UpperFractalTime2 = getPreviousFractalTime(_SYMBOL, _TIMEFRAME_2, true);
         LowerFractal1 = getLastFractalValue(_SYMBOL, _TIMEFRAME_2, false);
         LowerFractalTime1 = getLastFractalTime(_SYMBOL, _TIMEFRAME_2, false);
         LowerFractal2 = getPreviousFractalValue(_SYMBOL, _TIMEFRAME_2, false);
         LowerFractalTime2 = getPreviousFractalTime(_SYMBOL, _TIMEFRAME_2, false);

         UpperFractalShift1 = iBarShift(_SYMBOL, _TIMEFRAME, UpperFractalTime1);
         UpperFractalShift2 = iBarShift(_SYMBOL, _TIMEFRAME, UpperFractalTime2);
         LowerFractalShift1 = iBarShift(_SYMBOL, _TIMEFRAME, LowerFractalTime1);
         LowerFractalShift2 = iBarShift(_SYMBOL, _TIMEFRAME, LowerFractalTime2);
         
         EdgePrice = UpperFractal2 - (UpperFractal2 - UpperFractal1) * (UpperFractalShift2 / (UpperFractalShift2 - UpperFractalShift1));

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

//         Print(Ask, " - ", UpperFractal2 - (UpperFractal2 - UpperFractal1) * (UpperFractalShift2 / (UpperFractalShift2 - UpperFractalShift1)));
         if(Ask > EdgePrice)
         if(Ask < LowerFractal1 + _MAX_FRACTAL_DISTANCE*Point)
         if(UpperFractal2 >= UpperFractal1)
            result = 1;
                  
         break;
      }
      case _OPEN_SHORT:
      {
//         if(!OpenNewBar(_TIMEFRAME))
//            break;
/*
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
*/
/*         
         LowerFractal1 = getLastFractalValue(_SYMBOL, _TIMEFRAME, false);
         LowerFractalTime1 = getLastFractalTime(_SYMBOL, _TIMEFRAME, false);
         LowerFractal2 = getPreviousFractalValue(_SYMBOL, _TIMEFRAME, false);
         LowerFractalTime2 = getPreviousFractalTime(_SYMBOL, _TIMEFRAME, false);
*/
         UpperFractal1 = getLastFractalValue(_SYMBOL, _TIMEFRAME_2, true);
         UpperFractalTime1 = getLastFractalTime(_SYMBOL, _TIMEFRAME_2, true);
         UpperFractal2 = getPreviousFractalValue(_SYMBOL, _TIMEFRAME_2, true);
         UpperFractalTime2 = getPreviousFractalTime(_SYMBOL, _TIMEFRAME_2, true);
         LowerFractal1 = getLastFractalValue(_SYMBOL, _TIMEFRAME_2, false);
         LowerFractalTime1 = getLastFractalTime(_SYMBOL, _TIMEFRAME_2, false);
         LowerFractal2 = getPreviousFractalValue(_SYMBOL, _TIMEFRAME_2, false);
         LowerFractalTime2 = getPreviousFractalTime(_SYMBOL, _TIMEFRAME_2, false);

         UpperFractalShift1 = iBarShift(_SYMBOL, _TIMEFRAME, UpperFractalTime1);
         UpperFractalShift2 = iBarShift(_SYMBOL, _TIMEFRAME, UpperFractalTime2);
         LowerFractalShift1 = iBarShift(_SYMBOL, _TIMEFRAME, LowerFractalTime1);
         LowerFractalShift2 = iBarShift(_SYMBOL, _TIMEFRAME, LowerFractalTime2);

         EdgePrice = LowerFractal2 - (LowerFractal2 - LowerFractal1) * (LowerFractalShift2 / (LowerFractalShift2 - LowerFractalShift1));
         
//         if(MACDHistogram > MACDSignal)
//         if(MACDHistogram < MACDSignal)
//         if(MACDHistogram > 0)
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

//         if(Bid < MALong)
//         if(MAFast < MALong)
//         if(MALong1 > MALong)
//        if(MALong2 > MALong1)

//         Print(Bid, " - ", LowerFractal2 - (LowerFractal2 - LowerFractal1) * (LowerFractalShift2 / (LowerFractalShift2 - LowerFractalShift1)));
         if(Bid < EdgePrice)
         if(Bid > UpperFractal1 - _MAX_FRACTAL_DISTANCE*Point)
         if(LowerFractal2 <= LowerFractal1)
            result = 1;
                  
         break;
      }
      case _CLOSE_LONG:
      {
         if(!OpenNewBar(_TIMEFRAME))
            break;

         break;

//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, true) < getPreviousFractalValue(_SYMBOL, _TIMEFRAME, true))
//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, true) > getPreviousFractalValue(_SYMBOL, _TIMEFRAME, true))
//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, false) > getPreviousFractalValue(_SYMBOL, _TIMEFRAME, false))
//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, false) < getPreviousFractalValue(_SYMBOL, _TIMEFRAME, false))
//         if(MathAbs(getLastFractalValue(_SYMBOL, _TIMEFRAME, true) - getLastFractalValue(_SYMBOL, _TIMEFRAME, false)) < MathAbs(getPreviousFractalValue(_SYMBOL, _TIMEFRAME, true) - getPreviousFractalValue(_SYMBOL, _TIMEFRAME, false)))
//         if(Bid < getLastFractalValue(_SYMBOL, _TIMEFRAME, false))
         if(Bid > getLastFractalValue(_SYMBOL, _TIMEFRAME, false))
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
         if(!OpenNewBar(_TIMEFRAME))
            break;

         break;

//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, true) < getPreviousFractalValue(_SYMBOL, _TIMEFRAME, true))
//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, true) > getPreviousFractalValue(_SYMBOL, _TIMEFRAME, true))
//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, false) > getPreviousFractalValue(_SYMBOL, _TIMEFRAME, false))
//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, false) < getPreviousFractalValue(_SYMBOL, _TIMEFRAME, false))
//         if(MathAbs(getLastFractalValue(_SYMBOL, _TIMEFRAME, true) - getLastFractalValue(_SYMBOL, _TIMEFRAME, false)) < MathAbs(getPreviousFractalValue(_SYMBOL, _TIMEFRAME, true) - getPreviousFractalValue(_SYMBOL, _TIMEFRAME, false)))
//         if(Ask > getLastFractalValue(_SYMBOL, _TIMEFRAME, true))
         if(Ask < getLastFractalValue(_SYMBOL, _TIMEFRAME, true))
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
//         break;

         result = getLastFractalValue(_SYMBOL, _TIMEFRAME, false);
//         result = iLow(_SYMBOL, _TIMEFRAME, 1);

         if(_MAXSTOPLOSS > 0)
            if(result < Ask - _MAXSTOPLOSS*Point)
               result = Ask - _MAXSTOPLOSS*Point;
            
         if(result > Ask - 10*Point)
            result = Ask - 10*Point;

         break;
      }
      case _GET_SHORT_STOPLOSS_PRICE:
      {
//         break;

         result = getLastFractalValue(_SYMBOL, _TIMEFRAME, true);
//         result = iHigh(_SYMBOL, _TIMEFRAME, 1);

         if(_MAXSTOPLOSS > 0)
            if(result > Bid + _MAXSTOPLOSS*Point)
               result = Bid + _MAXSTOPLOSS*Point;

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
         if(!OpenNewBar(_TIMEFRAME))
            break;

//         break;

         double breakeven = 0;

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
                     breakeven = OrderOpenPrice();
                  
                  if(breakeven > Bid - 10*Point)
                     breakeven = Bid - 10*Point;
               }
               else
               {
                  if(iHigh(_SYMBOL, _TIMEFRAME, 1) < OrderOpenPrice())
                     breakeven = OrderOpenPrice();
                  
                  if(breakeven < Ask + 10*Point)
                     breakeven = Ask + 10*Point;
               }
            }
         }

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
                  
                  if(breakeven > result)
                     result = breakeven;
                  
                  if(result > Bid - 10*Point)
                     result = Bid - 10*Point;
                  
                  if(result <= OrderStopLoss())
                     result = OrderStopLoss();
               }
               else
               {
//                  result = iHigh(_SYMBOL, _TIMEFRAME, 1);
                  result = getLastFractalValue(_SYMBOL, _TIMEFRAME, true);
                  
                  if(breakeven < result)
                     result = breakeven;

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
double Strategy_015(int COMMAND)
{
   string   _SYMBOL        = Symbol();
   int      _TIMEFRAME     = getStrategyTimeframeByNumber(_STRATEGY_TIMEFRAME);
      
   int      _DIFF          = 0;
   
   double   result         = 0;
   
   int      i;

   switch(COMMAND)
   {
      case _OPEN_LONG:
      {
         break;
      }
      case _OPEN_SHORT:
      {
         break;
      }
      case _OPEN_PENDING_BUY_STOP:
      {
         if(!OpenNewBar(_TIMEFRAME))
            break;

         if(High[1] < High[2])
         if(Low[1] > Low[2])
//         if(MathAbs(Open[1] - Close[1]) < MathAbs(Open[2] - Close[2]))
         if((Open[2] > Close[2] && Open[2] > Open[1] && Open[2] > Close[1] && Close[2] < Open[1] && Close[2] < Close[1]) || (Open[2] < Close[2] && Open[2] < Open[1] && Open[2] < Close[1] && Close[2] > Open[1] && Close[2] > Close[1]))
//         if((Open[2] > Close[2] && Open[2] > High[1] && Close[2] < Low[1]) || (Open[2] < Close[2] && Open[2] < Low[1] && Close[2] > High[1]))
            result = 1;
                  
         break;
      }
      case _OPEN_PENDING_SELL_STOP:
      {
         if(!OpenNewBar(_TIMEFRAME))
            break;

         if(High[1] < High[2])
         if(Low[1] > Low[2])
//         if(MathAbs(Open[1] - Close[1]) < MathAbs(Open[2] - Close[2]))
         if((Open[2] > Close[2] && Open[2] > Open[1] && Open[2] > Close[1] && Close[2] < Open[1] && Close[2] < Close[1]) || (Open[2] < Close[2] && Open[2] < Open[1] && Open[2] < Close[1] && Close[2] > Open[1] && Close[2] > Close[1]))
//         if((Open[2] > Close[2] && Open[2] > High[1] && Close[2] < Low[1]) || (Open[2] < Close[2] && Open[2] < Low[1] && Close[2] > High[1]))
            result = 1;
                  
         break;
      }
      case _GET_PENDING_BUY_STOP_PRICE:
      {
//         break;

         result = High[1] + _DIFF*Point;

         break;
      }
      case _GET_PENDING_SELL_STOP_PRICE:
      {
//         break;

         result = Low[1] - _DIFF*Point;
         
         break;
      }
      case _CLOSE_LONG:
      {
//         break;

         if(!OpenNewBar(_TIMEFRAME))
            break;

         result = 1;

         break;
      }
      case _CLOSE_SHORT:
      {
//         break;

         if(!OpenNewBar(_TIMEFRAME))
            break;

         result = 1;
         
         break;
      }
      case _GET_LONG_STOPLOSS_PRICE:
      {
//         break;

         result = Low[2];

         break;
      }
      case _GET_SHORT_STOPLOSS_PRICE:
      {
//         break;

         result = High[2];
         
         break;
      }
      case _GET_LONG_TAKEPROFIT_PRICE:
      {
         result = High[2];

         break;
      }
      case _GET_SHORT_TAKEPROFIT_PRICE:
      {
         result = Low[2];

         break;
      }
      case _GET_TRAILED_STOPLOSS_PRICE:
      {
//         break;

//         if(!OpenNewBar(_TIMEFRAME))
//            break;
         
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
      case _GET_PENDING_ORDER_EXPIRATION:
      {
         result = iTime(_SYMBOL, _TIMEFRAME, 0) + _TIMEFRAME*60;
         break;
      }
   }
      
   return(result);
}
//------------------------------------------------------------------//------------------------------------------------------------------
double Strategy_016(int COMMAND)
{
   string   _SYMBOL        = Symbol();
   int      _TIMEFRAME     = getStrategyTimeframeByNumber(_STRATEGY_TIMEFRAME);
   int      _SLOWEMA       = 26;
   int      _FASTEMA       = 12;
   int      _MASIGNAL      = 9;
   int      _SHIFT         = 0;
   int      _PRICE         = PRICE_OPEN;

   int      _DIFF          = 0;
   
   double   result         = 0;
   double   MACDHistogram;
   double   MACDSignal;
   
   int      i;

   switch(COMMAND)
   {
      case _OPEN_LONG:
      {
//         if(!OpenNewBar(_TIMEFRAME))
//            break;

         MACDHistogram = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT);
         MACDSignal = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT);

         switch(_OPEN_SIGNAL_COMBINATION)
         {
            case 1:
            {
//               if(MACDHistogram > MACDSignal)
//               if(MACDHistogram < MACDSignal)
//               if(MACDHistogram < 0)
//               if(MACDHistogram > 0)
               if(High[1] < High[2])
               if(Low[1] > Low[2])
               if(MathAbs(Open[1] - Close[1]) < MathAbs(Open[2] - Close[2]))
//               if((Open[2] > Close[2] && Open[2] > Open[1] && Open[2] > Close[1] && Close[2] < Open[1] && Close[2] < Close[1]) || (Open[2] < Close[2] && Open[2] < Open[1] && Open[2] < Close[1] && Close[2] > Open[1] && Close[2] > Close[1]))
//               if((Open[2] > Close[2] && Open[2] > High[1] && Close[2] < Low[1]) || (Open[2] < Close[2] && Open[2] < Low[1] && Close[2] > High[1]))
               if(Ask > High[1] + _DIFF*Point)
                  result = 1;
               break;
            }
            case 2:
            {
               if(MACDHistogram > MACDSignal)
//               if(MACDHistogram < MACDSignal)
//               if(MACDHistogram < 0)
//               if(MACDHistogram > 0)
               if(High[1] < High[2])
               if(Low[1] > Low[2])
               if(MathAbs(Open[1] - Close[1]) < MathAbs(Open[2] - Close[2]))
//               if((Open[2] > Close[2] && Open[2] > Open[1] && Open[2] > Close[1] && Close[2] < Open[1] && Close[2] < Close[1]) || (Open[2] < Close[2] && Open[2] < Open[1] && Open[2] < Close[1] && Close[2] > Open[1] && Close[2] > Close[1]))
//               if((Open[2] > Close[2] && Open[2] > High[1] && Close[2] < Low[1]) || (Open[2] < Close[2] && Open[2] < Low[1] && Close[2] > High[1]))
               if(Ask > High[1] + _DIFF*Point)
                  result = 1;
               break;
            }
            case 3:
            {
//               if(MACDHistogram > MACDSignal)
               if(MACDHistogram < MACDSignal)
//               if(MACDHistogram < 0)
//               if(MACDHistogram > 0)
               if(High[1] < High[2])
               if(Low[1] > Low[2])
               if(MathAbs(Open[1] - Close[1]) < MathAbs(Open[2] - Close[2]))
//               if((Open[2] > Close[2] && Open[2] > Open[1] && Open[2] > Close[1] && Close[2] < Open[1] && Close[2] < Close[1]) || (Open[2] < Close[2] && Open[2] < Open[1] && Open[2] < Close[1] && Close[2] > Open[1] && Close[2] > Close[1]))
//               if((Open[2] > Close[2] && Open[2] > High[1] && Close[2] < Low[1]) || (Open[2] < Close[2] && Open[2] < Low[1] && Close[2] > High[1]))
               if(Ask > High[1] + _DIFF*Point)
                  result = 1;
               break;
            }
            case 4:
            {
//               if(MACDHistogram > MACDSignal)
//               if(MACDHistogram < MACDSignal)
               if(MACDHistogram < 0)
//               if(MACDHistogram > 0)
               if(High[1] < High[2])
               if(Low[1] > Low[2])
               if(MathAbs(Open[1] - Close[1]) < MathAbs(Open[2] - Close[2]))
//               if((Open[2] > Close[2] && Open[2] > Open[1] && Open[2] > Close[1] && Close[2] < Open[1] && Close[2] < Close[1]) || (Open[2] < Close[2] && Open[2] < Open[1] && Open[2] < Close[1] && Close[2] > Open[1] && Close[2] > Close[1]))
//               if((Open[2] > Close[2] && Open[2] > High[1] && Close[2] < Low[1]) || (Open[2] < Close[2] && Open[2] < Low[1] && Close[2] > High[1]))
               if(Ask > High[1] + _DIFF*Point)
                  result = 1;
               break;
            }
            case 5:
            {
//               if(MACDHistogram > MACDSignal)
//               if(MACDHistogram < MACDSignal)
//               if(MACDHistogram < 0)
               if(MACDHistogram > 0)
               if(High[1] < High[2])
               if(Low[1] > Low[2])
               if(MathAbs(Open[1] - Close[1]) < MathAbs(Open[2] - Close[2]))
//               if((Open[2] > Close[2] && Open[2] > Open[1] && Open[2] > Close[1] && Close[2] < Open[1] && Close[2] < Close[1]) || (Open[2] < Close[2] && Open[2] < Open[1] && Open[2] < Close[1] && Close[2] > Open[1] && Close[2] > Close[1]))
//               if((Open[2] > Close[2] && Open[2] > High[1] && Close[2] < Low[1]) || (Open[2] < Close[2] && Open[2] < Low[1] && Close[2] > High[1]))
               if(Ask > High[1] + _DIFF*Point)
                  result = 1;
               break;
            }
            case 6:
            {
               if(MACDHistogram > MACDSignal)
//               if(MACDHistogram < MACDSignal)
               if(MACDHistogram < 0)
//               if(MACDHistogram > 0)
               if(High[1] < High[2])
               if(Low[1] > Low[2])
               if(MathAbs(Open[1] - Close[1]) < MathAbs(Open[2] - Close[2]))
//               if((Open[2] > Close[2] && Open[2] > Open[1] && Open[2] > Close[1] && Close[2] < Open[1] && Close[2] < Close[1]) || (Open[2] < Close[2] && Open[2] < Open[1] && Open[2] < Close[1] && Close[2] > Open[1] && Close[2] > Close[1]))
//               if((Open[2] > Close[2] && Open[2] > High[1] && Close[2] < Low[1]) || (Open[2] < Close[2] && Open[2] < Low[1] && Close[2] > High[1]))
               if(Ask > High[1] + _DIFF*Point)
                  result = 1;
               break;
            }
            case 7:
            {
               if(MACDHistogram > MACDSignal)
//               if(MACDHistogram < MACDSignal)
//               if(MACDHistogram < 0)
               if(MACDHistogram > 0)
               if(High[1] < High[2])
               if(Low[1] > Low[2])
               if(MathAbs(Open[1] - Close[1]) < MathAbs(Open[2] - Close[2]))
//               if((Open[2] > Close[2] && Open[2] > Open[1] && Open[2] > Close[1] && Close[2] < Open[1] && Close[2] < Close[1]) || (Open[2] < Close[2] && Open[2] < Open[1] && Open[2] < Close[1] && Close[2] > Open[1] && Close[2] > Close[1]))
//               if((Open[2] > Close[2] && Open[2] > High[1] && Close[2] < Low[1]) || (Open[2] < Close[2] && Open[2] < Low[1] && Close[2] > High[1]))
               if(Ask > High[1] + _DIFF*Point)
                  result = 1;
               break;
            }
            case 8:
            {
//               if(MACDHistogram > MACDSignal)
               if(MACDHistogram < MACDSignal)
               if(MACDHistogram < 0)
//               if(MACDHistogram > 0)
               if(High[1] < High[2])
               if(Low[1] > Low[2])
               if(MathAbs(Open[1] - Close[1]) < MathAbs(Open[2] - Close[2]))
//               if((Open[2] > Close[2] && Open[2] > Open[1] && Open[2] > Close[1] && Close[2] < Open[1] && Close[2] < Close[1]) || (Open[2] < Close[2] && Open[2] < Open[1] && Open[2] < Close[1] && Close[2] > Open[1] && Close[2] > Close[1]))
//               if((Open[2] > Close[2] && Open[2] > High[1] && Close[2] < Low[1]) || (Open[2] < Close[2] && Open[2] < Low[1] && Close[2] > High[1]))
               if(Ask > High[1] + _DIFF*Point)
                  result = 1;
               break;
            }
            case 9:
            {
//               if(MACDHistogram > MACDSignal)
               if(MACDHistogram < MACDSignal)
//               if(MACDHistogram < 0)
               if(MACDHistogram > 0)
               if(High[1] < High[2])
               if(Low[1] > Low[2])
               if(MathAbs(Open[1] - Close[1]) < MathAbs(Open[2] - Close[2]))
//               if((Open[2] > Close[2] && Open[2] > Open[1] && Open[2] > Close[1] && Close[2] < Open[1] && Close[2] < Close[1]) || (Open[2] < Close[2] && Open[2] < Open[1] && Open[2] < Close[1] && Close[2] > Open[1] && Close[2] > Close[1]))
//               if((Open[2] > Close[2] && Open[2] > High[1] && Close[2] < Low[1]) || (Open[2] < Close[2] && Open[2] < Low[1] && Close[2] > High[1]))
               if(Ask > High[1] + _DIFF*Point)
                  result = 1;
               break;
            }
            case 10:
            {
//               if(MACDHistogram > MACDSignal)
//               if(MACDHistogram < MACDSignal)
//               if(MACDHistogram < 0)
//               if(MACDHistogram > 0)
               if(High[1] < High[2])
               if(Low[1] > Low[2])
//               if(MathAbs(Open[1] - Close[1]) < MathAbs(Open[2] - Close[2]))
               if((Open[2] > Close[2] && Open[2] > Open[1] && Open[2] > Close[1] && Close[2] < Open[1] && Close[2] < Close[1]) || (Open[2] < Close[2] && Open[2] < Open[1] && Open[2] < Close[1] && Close[2] > Open[1] && Close[2] > Close[1]))
//               if((Open[2] > Close[2] && Open[2] > High[1] && Close[2] < Low[1]) || (Open[2] < Close[2] && Open[2] < Low[1] && Close[2] > High[1]))
               if(Ask > High[1] + _DIFF*Point)
                  result = 1;
               break;
            }
            case 11:
            {
               if(MACDHistogram > MACDSignal)
//               if(MACDHistogram < MACDSignal)
//               if(MACDHistogram < 0)
//               if(MACDHistogram > 0)
               if(High[1] < High[2])
               if(Low[1] > Low[2])
//               if(MathAbs(Open[1] - Close[1]) < MathAbs(Open[2] - Close[2]))
               if((Open[2] > Close[2] && Open[2] > Open[1] && Open[2] > Close[1] && Close[2] < Open[1] && Close[2] < Close[1]) || (Open[2] < Close[2] && Open[2] < Open[1] && Open[2] < Close[1] && Close[2] > Open[1] && Close[2] > Close[1]))
//               if((Open[2] > Close[2] && Open[2] > High[1] && Close[2] < Low[1]) || (Open[2] < Close[2] && Open[2] < Low[1] && Close[2] > High[1]))
               if(Ask > High[1] + _DIFF*Point)
                  result = 1;
               break;
            }
            case 12:
            {
//               if(MACDHistogram > MACDSignal)
               if(MACDHistogram < MACDSignal)
//               if(MACDHistogram < 0)
//               if(MACDHistogram > 0)
               if(High[1] < High[2])
               if(Low[1] > Low[2])
//               if(MathAbs(Open[1] - Close[1]) < MathAbs(Open[2] - Close[2]))
               if((Open[2] > Close[2] && Open[2] > Open[1] && Open[2] > Close[1] && Close[2] < Open[1] && Close[2] < Close[1]) || (Open[2] < Close[2] && Open[2] < Open[1] && Open[2] < Close[1] && Close[2] > Open[1] && Close[2] > Close[1]))
//               if((Open[2] > Close[2] && Open[2] > High[1] && Close[2] < Low[1]) || (Open[2] < Close[2] && Open[2] < Low[1] && Close[2] > High[1]))
               if(Ask > High[1] + _DIFF*Point)
                  result = 1;
               break;
            }
            case 13:
            {
//               if(MACDHistogram > MACDSignal)
//               if(MACDHistogram < MACDSignal)
               if(MACDHistogram < 0)
//               if(MACDHistogram > 0)
               if(High[1] < High[2])
               if(Low[1] > Low[2])
//               if(MathAbs(Open[1] - Close[1]) < MathAbs(Open[2] - Close[2]))
               if((Open[2] > Close[2] && Open[2] > Open[1] && Open[2] > Close[1] && Close[2] < Open[1] && Close[2] < Close[1]) || (Open[2] < Close[2] && Open[2] < Open[1] && Open[2] < Close[1] && Close[2] > Open[1] && Close[2] > Close[1]))
//               if((Open[2] > Close[2] && Open[2] > High[1] && Close[2] < Low[1]) || (Open[2] < Close[2] && Open[2] < Low[1] && Close[2] > High[1]))
               if(Ask > High[1] + _DIFF*Point)
                  result = 1;
               break;
            }
            case 14:
            {
//               if(MACDHistogram > MACDSignal)
//               if(MACDHistogram < MACDSignal)
//               if(MACDHistogram < 0)
               if(MACDHistogram > 0)
               if(High[1] < High[2])
               if(Low[1] > Low[2])
//               if(MathAbs(Open[1] - Close[1]) < MathAbs(Open[2] - Close[2]))
               if((Open[2] > Close[2] && Open[2] > Open[1] && Open[2] > Close[1] && Close[2] < Open[1] && Close[2] < Close[1]) || (Open[2] < Close[2] && Open[2] < Open[1] && Open[2] < Close[1] && Close[2] > Open[1] && Close[2] > Close[1]))
//               if((Open[2] > Close[2] && Open[2] > High[1] && Close[2] < Low[1]) || (Open[2] < Close[2] && Open[2] < Low[1] && Close[2] > High[1]))
               if(Ask > High[1] + _DIFF*Point)
                  result = 1;
               break;
            }
            case 15:
            {
               if(MACDHistogram > MACDSignal)
//               if(MACDHistogram < MACDSignal)
               if(MACDHistogram < 0)
//               if(MACDHistogram > 0)
               if(High[1] < High[2])
               if(Low[1] > Low[2])
//               if(MathAbs(Open[1] - Close[1]) < MathAbs(Open[2] - Close[2]))
               if((Open[2] > Close[2] && Open[2] > Open[1] && Open[2] > Close[1] && Close[2] < Open[1] && Close[2] < Close[1]) || (Open[2] < Close[2] && Open[2] < Open[1] && Open[2] < Close[1] && Close[2] > Open[1] && Close[2] > Close[1]))
//               if((Open[2] > Close[2] && Open[2] > High[1] && Close[2] < Low[1]) || (Open[2] < Close[2] && Open[2] < Low[1] && Close[2] > High[1]))
               if(Ask > High[1] + _DIFF*Point)
                  result = 1;
               break;
            }
            case 16:
            {
               if(MACDHistogram > MACDSignal)
//               if(MACDHistogram < MACDSignal)
//               if(MACDHistogram < 0)
               if(MACDHistogram > 0)
               if(High[1] < High[2])
               if(Low[1] > Low[2])
//               if(MathAbs(Open[1] - Close[1]) < MathAbs(Open[2] - Close[2]))
               if((Open[2] > Close[2] && Open[2] > Open[1] && Open[2] > Close[1] && Close[2] < Open[1] && Close[2] < Close[1]) || (Open[2] < Close[2] && Open[2] < Open[1] && Open[2] < Close[1] && Close[2] > Open[1] && Close[2] > Close[1]))
//               if((Open[2] > Close[2] && Open[2] > High[1] && Close[2] < Low[1]) || (Open[2] < Close[2] && Open[2] < Low[1] && Close[2] > High[1]))
               if(Ask > High[1] + _DIFF*Point)
                  result = 1;
               break;
            }
            case 17:
            {
//               if(MACDHistogram > MACDSignal)
               if(MACDHistogram < MACDSignal)
               if(MACDHistogram < 0)
//               if(MACDHistogram > 0)
               if(High[1] < High[2])
               if(Low[1] > Low[2])
//               if(MathAbs(Open[1] - Close[1]) < MathAbs(Open[2] - Close[2]))
               if((Open[2] > Close[2] && Open[2] > Open[1] && Open[2] > Close[1] && Close[2] < Open[1] && Close[2] < Close[1]) || (Open[2] < Close[2] && Open[2] < Open[1] && Open[2] < Close[1] && Close[2] > Open[1] && Close[2] > Close[1]))
//               if((Open[2] > Close[2] && Open[2] > High[1] && Close[2] < Low[1]) || (Open[2] < Close[2] && Open[2] < Low[1] && Close[2] > High[1]))
               if(Ask > High[1] + _DIFF*Point)
                  result = 1;
               break;
            }
            case 18:
            {
//               if(MACDHistogram > MACDSignal)
               if(MACDHistogram < MACDSignal)
//               if(MACDHistogram < 0)
               if(MACDHistogram > 0)
               if(High[1] < High[2])
               if(Low[1] > Low[2])
//               if(MathAbs(Open[1] - Close[1]) < MathAbs(Open[2] - Close[2]))
               if((Open[2] > Close[2] && Open[2] > Open[1] && Open[2] > Close[1] && Close[2] < Open[1] && Close[2] < Close[1]) || (Open[2] < Close[2] && Open[2] < Open[1] && Open[2] < Close[1] && Close[2] > Open[1] && Close[2] > Close[1]))
//               if((Open[2] > Close[2] && Open[2] > High[1] && Close[2] < Low[1]) || (Open[2] < Close[2] && Open[2] < Low[1] && Close[2] > High[1]))
               if(Ask > High[1] + _DIFF*Point)
                  result = 1;
               break;
            }
            case 19:
            {
//               if(MACDHistogram > MACDSignal)
//               if(MACDHistogram < MACDSignal)
//               if(MACDHistogram < 0)
//               if(MACDHistogram > 0)
               if(High[1] < High[2])
               if(Low[1] > Low[2])
//               if(MathAbs(Open[1] - Close[1]) < MathAbs(Open[2] - Close[2]))
//               if((Open[2] > Close[2] && Open[2] > Open[1] && Open[2] > Close[1] && Close[2] < Open[1] && Close[2] < Close[1]) || (Open[2] < Close[2] && Open[2] < Open[1] && Open[2] < Close[1] && Close[2] > Open[1] && Close[2] > Close[1]))
               if((Open[2] > Close[2] && Open[2] > High[1] && Close[2] < Low[1]) || (Open[2] < Close[2] && Open[2] < Low[1] && Close[2] > High[1]))
               if(Ask > High[1] + _DIFF*Point)
                  result = 1;
               break;
            }
            case 20:
            {
               if(MACDHistogram > MACDSignal)
//               if(MACDHistogram < MACDSignal)
//               if(MACDHistogram < 0)
//               if(MACDHistogram > 0)
               if(High[1] < High[2])
               if(Low[1] > Low[2])
//               if(MathAbs(Open[1] - Close[1]) < MathAbs(Open[2] - Close[2]))
//               if((Open[2] > Close[2] && Open[2] > Open[1] && Open[2] > Close[1] && Close[2] < Open[1] && Close[2] < Close[1]) || (Open[2] < Close[2] && Open[2] < Open[1] && Open[2] < Close[1] && Close[2] > Open[1] && Close[2] > Close[1]))
               if((Open[2] > Close[2] && Open[2] > High[1] && Close[2] < Low[1]) || (Open[2] < Close[2] && Open[2] < Low[1] && Close[2] > High[1]))
               if(Ask > High[1] + _DIFF*Point)
                  result = 1;
               break;
            }
            case 21:
            {
//               if(MACDHistogram > MACDSignal)
               if(MACDHistogram < MACDSignal)
//               if(MACDHistogram < 0)
//               if(MACDHistogram > 0)
               if(High[1] < High[2])
               if(Low[1] > Low[2])
//               if(MathAbs(Open[1] - Close[1]) < MathAbs(Open[2] - Close[2]))
//               if((Open[2] > Close[2] && Open[2] > Open[1] && Open[2] > Close[1] && Close[2] < Open[1] && Close[2] < Close[1]) || (Open[2] < Close[2] && Open[2] < Open[1] && Open[2] < Close[1] && Close[2] > Open[1] && Close[2] > Close[1]))
               if((Open[2] > Close[2] && Open[2] > High[1] && Close[2] < Low[1]) || (Open[2] < Close[2] && Open[2] < Low[1] && Close[2] > High[1]))
               if(Ask > High[1] + _DIFF*Point)
                  result = 1;
               break;
            }
            case 22:
            {
//               if(MACDHistogram > MACDSignal)
//               if(MACDHistogram < MACDSignal)
               if(MACDHistogram < 0)
//               if(MACDHistogram > 0)
               if(High[1] < High[2])
               if(Low[1] > Low[2])
//               if(MathAbs(Open[1] - Close[1]) < MathAbs(Open[2] - Close[2]))
//               if((Open[2] > Close[2] && Open[2] > Open[1] && Open[2] > Close[1] && Close[2] < Open[1] && Close[2] < Close[1]) || (Open[2] < Close[2] && Open[2] < Open[1] && Open[2] < Close[1] && Close[2] > Open[1] && Close[2] > Close[1]))
               if((Open[2] > Close[2] && Open[2] > High[1] && Close[2] < Low[1]) || (Open[2] < Close[2] && Open[2] < Low[1] && Close[2] > High[1]))
               if(Ask > High[1] + _DIFF*Point)
                  result = 1;
               break;
            }
            case 23:
            {
//               if(MACDHistogram > MACDSignal)
//               if(MACDHistogram < MACDSignal)
//               if(MACDHistogram < 0)
               if(MACDHistogram > 0)
               if(High[1] < High[2])
               if(Low[1] > Low[2])
//               if(MathAbs(Open[1] - Close[1]) < MathAbs(Open[2] - Close[2]))
//               if((Open[2] > Close[2] && Open[2] > Open[1] && Open[2] > Close[1] && Close[2] < Open[1] && Close[2] < Close[1]) || (Open[2] < Close[2] && Open[2] < Open[1] && Open[2] < Close[1] && Close[2] > Open[1] && Close[2] > Close[1]))
               if((Open[2] > Close[2] && Open[2] > High[1] && Close[2] < Low[1]) || (Open[2] < Close[2] && Open[2] < Low[1] && Close[2] > High[1]))
               if(Ask > High[1] + _DIFF*Point)
                  result = 1;
               break;
            }
            case 24:
            {
               if(MACDHistogram > MACDSignal)
//               if(MACDHistogram < MACDSignal)
               if(MACDHistogram < 0)
//               if(MACDHistogram > 0)
               if(High[1] < High[2])
               if(Low[1] > Low[2])
//               if(MathAbs(Open[1] - Close[1]) < MathAbs(Open[2] - Close[2]))
//               if((Open[2] > Close[2] && Open[2] > Open[1] && Open[2] > Close[1] && Close[2] < Open[1] && Close[2] < Close[1]) || (Open[2] < Close[2] && Open[2] < Open[1] && Open[2] < Close[1] && Close[2] > Open[1] && Close[2] > Close[1]))
               if((Open[2] > Close[2] && Open[2] > High[1] && Close[2] < Low[1]) || (Open[2] < Close[2] && Open[2] < Low[1] && Close[2] > High[1]))
               if(Ask > High[1] + _DIFF*Point)
                  result = 1;
               break;
            }
            case 25:
            {
               if(MACDHistogram > MACDSignal)
//               if(MACDHistogram < MACDSignal)
//               if(MACDHistogram < 0)
               if(MACDHistogram > 0)
               if(High[1] < High[2])
               if(Low[1] > Low[2])
//               if(MathAbs(Open[1] - Close[1]) < MathAbs(Open[2] - Close[2]))
//               if((Open[2] > Close[2] && Open[2] > Open[1] && Open[2] > Close[1] && Close[2] < Open[1] && Close[2] < Close[1]) || (Open[2] < Close[2] && Open[2] < Open[1] && Open[2] < Close[1] && Close[2] > Open[1] && Close[2] > Close[1]))
               if((Open[2] > Close[2] && Open[2] > High[1] && Close[2] < Low[1]) || (Open[2] < Close[2] && Open[2] < Low[1] && Close[2] > High[1]))
               if(Ask > High[1] + _DIFF*Point)
                  result = 1;
               break;
            }
            case 26:
            {
//               if(MACDHistogram > MACDSignal)
               if(MACDHistogram < MACDSignal)
               if(MACDHistogram < 0)
//               if(MACDHistogram > 0)
               if(High[1] < High[2])
               if(Low[1] > Low[2])
//               if(MathAbs(Open[1] - Close[1]) < MathAbs(Open[2] - Close[2]))
//               if((Open[2] > Close[2] && Open[2] > Open[1] && Open[2] > Close[1] && Close[2] < Open[1] && Close[2] < Close[1]) || (Open[2] < Close[2] && Open[2] < Open[1] && Open[2] < Close[1] && Close[2] > Open[1] && Close[2] > Close[1]))
               if((Open[2] > Close[2] && Open[2] > High[1] && Close[2] < Low[1]) || (Open[2] < Close[2] && Open[2] < Low[1] && Close[2] > High[1]))
               if(Ask > High[1] + _DIFF*Point)
                  result = 1;
               break;
            }
            case 27:
            {
//               if(MACDHistogram > MACDSignal)
               if(MACDHistogram < MACDSignal)
//               if(MACDHistogram < 0)
               if(MACDHistogram > 0)
               if(High[1] < High[2])
               if(Low[1] > Low[2])
//               if(MathAbs(Open[1] - Close[1]) < MathAbs(Open[2] - Close[2]))
//               if((Open[2] > Close[2] && Open[2] > Open[1] && Open[2] > Close[1] && Close[2] < Open[1] && Close[2] < Close[1]) || (Open[2] < Close[2] && Open[2] < Open[1] && Open[2] < Close[1] && Close[2] > Open[1] && Close[2] > Close[1]))
               if((Open[2] > Close[2] && Open[2] > High[1] && Close[2] < Low[1]) || (Open[2] < Close[2] && Open[2] < Low[1] && Close[2] > High[1]))
               if(Ask > High[1] + _DIFF*Point)
                  result = 1;
               break;
            }
         }
              
         break;
      }
      case _OPEN_SHORT:
      {
//         if(!OpenNewBar(_TIMEFRAME))
//            break;

         MACDHistogram = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_MAIN, _SHIFT);
         MACDSignal = iMACD(_SYMBOL, _TIMEFRAME, _FASTEMA, _SLOWEMA, _MASIGNAL, _PRICE, MODE_SIGNAL, _SHIFT);

         switch(_OPEN_SIGNAL_COMBINATION)
         {
            case 1:
            {
//               if(MACDHistogram > MACDSignal)
//               if(MACDHistogram < MACDSignal)
//               if(MACDHistogram < 0)
//               if(MACDHistogram > 0)
               if(High[1] < High[2])
               if(Low[1] > Low[2])
               if(MathAbs(Open[1] - Close[1]) < MathAbs(Open[2] - Close[2]))
//               if((Open[2] > Close[2] && Open[2] > Open[1] && Open[2] > Close[1] && Close[2] < Open[1] && Close[2] < Close[1]) || (Open[2] < Close[2] && Open[2] < Open[1] && Open[2] < Close[1] && Close[2] > Open[1] && Close[2] > Close[1]))
//               if((Open[2] > Close[2] && Open[2] > High[1] && Close[2] < Low[1]) || (Open[2] < Close[2] && Open[2] < Low[1] && Close[2] > High[1]))
               if(Bid < Low[1] - _DIFF*Point)
                  result = 1;
               break;
            }
            case 2:
            {
//               if(MACDHistogram > MACDSignal)
               if(MACDHistogram < MACDSignal)
//               if(MACDHistogram < 0)
//               if(MACDHistogram > 0)
               if(High[1] < High[2])
               if(Low[1] > Low[2])
               if(MathAbs(Open[1] - Close[1]) < MathAbs(Open[2] - Close[2]))
//               if((Open[2] > Close[2] && Open[2] > Open[1] && Open[2] > Close[1] && Close[2] < Open[1] && Close[2] < Close[1]) || (Open[2] < Close[2] && Open[2] < Open[1] && Open[2] < Close[1] && Close[2] > Open[1] && Close[2] > Close[1]))
//               if((Open[2] > Close[2] && Open[2] > High[1] && Close[2] < Low[1]) || (Open[2] < Close[2] && Open[2] < Low[1] && Close[2] > High[1]))
               if(Bid < Low[1] - _DIFF*Point)
                  result = 1;
               break;
            }
            case 3:
            {
               if(MACDHistogram > MACDSignal)
//               if(MACDHistogram < MACDSignal)
//               if(MACDHistogram < 0)
//               if(MACDHistogram > 0)
               if(High[1] < High[2])
               if(Low[1] > Low[2])
               if(MathAbs(Open[1] - Close[1]) < MathAbs(Open[2] - Close[2]))
//               if((Open[2] > Close[2] && Open[2] > Open[1] && Open[2] > Close[1] && Close[2] < Open[1] && Close[2] < Close[1]) || (Open[2] < Close[2] && Open[2] < Open[1] && Open[2] < Close[1] && Close[2] > Open[1] && Close[2] > Close[1]))
//               if((Open[2] > Close[2] && Open[2] > High[1] && Close[2] < Low[1]) || (Open[2] < Close[2] && Open[2] < Low[1] && Close[2] > High[1]))
               if(Bid < Low[1] - _DIFF*Point)
                  result = 1;
               break;
            }
            case 4:
            {
//               if(MACDHistogram > MACDSignal)
//               if(MACDHistogram < MACDSignal)
//               if(MACDHistogram < 0)
               if(MACDHistogram > 0)
               if(High[1] < High[2])
               if(Low[1] > Low[2])
               if(MathAbs(Open[1] - Close[1]) < MathAbs(Open[2] - Close[2]))
//               if((Open[2] > Close[2] && Open[2] > Open[1] && Open[2] > Close[1] && Close[2] < Open[1] && Close[2] < Close[1]) || (Open[2] < Close[2] && Open[2] < Open[1] && Open[2] < Close[1] && Close[2] > Open[1] && Close[2] > Close[1]))
//               if((Open[2] > Close[2] && Open[2] > High[1] && Close[2] < Low[1]) || (Open[2] < Close[2] && Open[2] < Low[1] && Close[2] > High[1]))
               if(Bid < Low[1] - _DIFF*Point)
                  result = 1;
               break;
            }
            case 5:
            {
//               if(MACDHistogram > MACDSignal)
//               if(MACDHistogram < MACDSignal)
               if(MACDHistogram < 0)
//               if(MACDHistogram > 0)
               if(High[1] < High[2])
               if(Low[1] > Low[2])
               if(MathAbs(Open[1] - Close[1]) < MathAbs(Open[2] - Close[2]))
//               if((Open[2] > Close[2] && Open[2] > Open[1] && Open[2] > Close[1] && Close[2] < Open[1] && Close[2] < Close[1]) || (Open[2] < Close[2] && Open[2] < Open[1] && Open[2] < Close[1] && Close[2] > Open[1] && Close[2] > Close[1]))
//               if((Open[2] > Close[2] && Open[2] > High[1] && Close[2] < Low[1]) || (Open[2] < Close[2] && Open[2] < Low[1] && Close[2] > High[1]))
               if(Bid < Low[1] - _DIFF*Point)
                  result = 1;
               break;
            }
            case 6:
            {
//               if(MACDHistogram > MACDSignal)
               if(MACDHistogram < MACDSignal)
//               if(MACDHistogram < 0)
               if(MACDHistogram > 0)
               if(High[1] < High[2])
               if(Low[1] > Low[2])
               if(MathAbs(Open[1] - Close[1]) < MathAbs(Open[2] - Close[2]))
//               if((Open[2] > Close[2] && Open[2] > Open[1] && Open[2] > Close[1] && Close[2] < Open[1] && Close[2] < Close[1]) || (Open[2] < Close[2] && Open[2] < Open[1] && Open[2] < Close[1] && Close[2] > Open[1] && Close[2] > Close[1]))
//               if((Open[2] > Close[2] && Open[2] > High[1] && Close[2] < Low[1]) || (Open[2] < Close[2] && Open[2] < Low[1] && Close[2] > High[1]))
               if(Bid < Low[1] - _DIFF*Point)
                  result = 1;
               break;
            }
            case 7:
            {
//               if(MACDHistogram > MACDSignal)
               if(MACDHistogram < MACDSignal)
               if(MACDHistogram < 0)
//               if(MACDHistogram > 0)
               if(High[1] < High[2])
               if(Low[1] > Low[2])
               if(MathAbs(Open[1] - Close[1]) < MathAbs(Open[2] - Close[2]))
//               if((Open[2] > Close[2] && Open[2] > Open[1] && Open[2] > Close[1] && Close[2] < Open[1] && Close[2] < Close[1]) || (Open[2] < Close[2] && Open[2] < Open[1] && Open[2] < Close[1] && Close[2] > Open[1] && Close[2] > Close[1]))
//               if((Open[2] > Close[2] && Open[2] > High[1] && Close[2] < Low[1]) || (Open[2] < Close[2] && Open[2] < Low[1] && Close[2] > High[1]))
               if(Bid < Low[1] - _DIFF*Point)
                  result = 1;
               break;
            }
            case 8:
            {
               if(MACDHistogram > MACDSignal)
//               if(MACDHistogram < MACDSignal)
//               if(MACDHistogram < 0)
               if(MACDHistogram > 0)
               if(High[1] < High[2])
               if(Low[1] > Low[2])
               if(MathAbs(Open[1] - Close[1]) < MathAbs(Open[2] - Close[2]))
//               if((Open[2] > Close[2] && Open[2] > Open[1] && Open[2] > Close[1] && Close[2] < Open[1] && Close[2] < Close[1]) || (Open[2] < Close[2] && Open[2] < Open[1] && Open[2] < Close[1] && Close[2] > Open[1] && Close[2] > Close[1]))
//               if((Open[2] > Close[2] && Open[2] > High[1] && Close[2] < Low[1]) || (Open[2] < Close[2] && Open[2] < Low[1] && Close[2] > High[1]))
               if(Bid < Low[1] - _DIFF*Point)
                  result = 1;
               break;
            }
            case 9:
            {
               if(MACDHistogram > MACDSignal)
//               if(MACDHistogram < MACDSignal)
               if(MACDHistogram < 0)
//               if(MACDHistogram > 0)
               if(High[1] < High[2])
               if(Low[1] > Low[2])
               if(MathAbs(Open[1] - Close[1]) < MathAbs(Open[2] - Close[2]))
//               if((Open[2] > Close[2] && Open[2] > Open[1] && Open[2] > Close[1] && Close[2] < Open[1] && Close[2] < Close[1]) || (Open[2] < Close[2] && Open[2] < Open[1] && Open[2] < Close[1] && Close[2] > Open[1] && Close[2] > Close[1]))
//               if((Open[2] > Close[2] && Open[2] > High[1] && Close[2] < Low[1]) || (Open[2] < Close[2] && Open[2] < Low[1] && Close[2] > High[1]))
               if(Bid < Low[1] - _DIFF*Point)
                  result = 1;
               break;
            }
            case 10:
            {
//               if(MACDHistogram > MACDSignal)
//               if(MACDHistogram < MACDSignal)
//               if(MACDHistogram < 0)
//               if(MACDHistogram > 0)
               if(High[1] < High[2])
               if(Low[1] > Low[2])
//               if(MathAbs(Open[1] - Close[1]) < MathAbs(Open[2] - Close[2]))
               if((Open[2] > Close[2] && Open[2] > Open[1] && Open[2] > Close[1] && Close[2] < Open[1] && Close[2] < Close[1]) || (Open[2] < Close[2] && Open[2] < Open[1] && Open[2] < Close[1] && Close[2] > Open[1] && Close[2] > Close[1]))
//               if((Open[2] > Close[2] && Open[2] > High[1] && Close[2] < Low[1]) || (Open[2] < Close[2] && Open[2] < Low[1] && Close[2] > High[1]))
               if(Bid < Low[1] - _DIFF*Point)
                  result = 1;
               break;
            }
            case 11:
            {
//               if(MACDHistogram > MACDSignal)
               if(MACDHistogram < MACDSignal)
//               if(MACDHistogram < 0)
//               if(MACDHistogram > 0)
               if(High[1] < High[2])
               if(Low[1] > Low[2])
//               if(MathAbs(Open[1] - Close[1]) < MathAbs(Open[2] - Close[2]))
               if((Open[2] > Close[2] && Open[2] > Open[1] && Open[2] > Close[1] && Close[2] < Open[1] && Close[2] < Close[1]) || (Open[2] < Close[2] && Open[2] < Open[1] && Open[2] < Close[1] && Close[2] > Open[1] && Close[2] > Close[1]))
//               if((Open[2] > Close[2] && Open[2] > High[1] && Close[2] < Low[1]) || (Open[2] < Close[2] && Open[2] < Low[1] && Close[2] > High[1]))
               if(Bid < Low[1] - _DIFF*Point)
                  result = 1;
               break;
            }
            case 12:
            {
               if(MACDHistogram > MACDSignal)
//               if(MACDHistogram < MACDSignal)
//               if(MACDHistogram < 0)
//               if(MACDHistogram > 0)
               if(High[1] < High[2])
               if(Low[1] > Low[2])
//               if(MathAbs(Open[1] - Close[1]) < MathAbs(Open[2] - Close[2]))
               if((Open[2] > Close[2] && Open[2] > Open[1] && Open[2] > Close[1] && Close[2] < Open[1] && Close[2] < Close[1]) || (Open[2] < Close[2] && Open[2] < Open[1] && Open[2] < Close[1] && Close[2] > Open[1] && Close[2] > Close[1]))
//               if((Open[2] > Close[2] && Open[2] > High[1] && Close[2] < Low[1]) || (Open[2] < Close[2] && Open[2] < Low[1] && Close[2] > High[1]))
               if(Bid < Low[1] - _DIFF*Point)
                  result = 1;
               break;
            }
            case 13:
            {
//               if(MACDHistogram > MACDSignal)
//               if(MACDHistogram < MACDSignal)
//               if(MACDHistogram < 0)
               if(MACDHistogram > 0)
               if(High[1] < High[2])
               if(Low[1] > Low[2])
//               if(MathAbs(Open[1] - Close[1]) < MathAbs(Open[2] - Close[2]))
               if((Open[2] > Close[2] && Open[2] > Open[1] && Open[2] > Close[1] && Close[2] < Open[1] && Close[2] < Close[1]) || (Open[2] < Close[2] && Open[2] < Open[1] && Open[2] < Close[1] && Close[2] > Open[1] && Close[2] > Close[1]))
//               if((Open[2] > Close[2] && Open[2] > High[1] && Close[2] < Low[1]) || (Open[2] < Close[2] && Open[2] < Low[1] && Close[2] > High[1]))
               if(Bid < Low[1] - _DIFF*Point)
                  result = 1;
               break;
            }
            case 14:
            {
//               if(MACDHistogram > MACDSignal)
//               if(MACDHistogram < MACDSignal)
               if(MACDHistogram < 0)
//               if(MACDHistogram > 0)
               if(High[1] < High[2])
               if(Low[1] > Low[2])
//               if(MathAbs(Open[1] - Close[1]) < MathAbs(Open[2] - Close[2]))
               if((Open[2] > Close[2] && Open[2] > Open[1] && Open[2] > Close[1] && Close[2] < Open[1] && Close[2] < Close[1]) || (Open[2] < Close[2] && Open[2] < Open[1] && Open[2] < Close[1] && Close[2] > Open[1] && Close[2] > Close[1]))
//               if((Open[2] > Close[2] && Open[2] > High[1] && Close[2] < Low[1]) || (Open[2] < Close[2] && Open[2] < Low[1] && Close[2] > High[1]))
               if(Bid < Low[1] - _DIFF*Point)
                  result = 1;
               break;
            }
            case 15:
            {
//               if(MACDHistogram > MACDSignal)
               if(MACDHistogram < MACDSignal)
//               if(MACDHistogram < 0)
               if(MACDHistogram > 0)
               if(High[1] < High[2])
               if(Low[1] > Low[2])
//               if(MathAbs(Open[1] - Close[1]) < MathAbs(Open[2] - Close[2]))
               if((Open[2] > Close[2] && Open[2] > Open[1] && Open[2] > Close[1] && Close[2] < Open[1] && Close[2] < Close[1]) || (Open[2] < Close[2] && Open[2] < Open[1] && Open[2] < Close[1] && Close[2] > Open[1] && Close[2] > Close[1]))
//               if((Open[2] > Close[2] && Open[2] > High[1] && Close[2] < Low[1]) || (Open[2] < Close[2] && Open[2] < Low[1] && Close[2] > High[1]))
               if(Bid < Low[1] - _DIFF*Point)
                  result = 1;
               break;
            }
            case 16:
            {
//               if(MACDHistogram > MACDSignal)
               if(MACDHistogram < MACDSignal)
               if(MACDHistogram < 0)
//               if(MACDHistogram > 0)
               if(High[1] < High[2])
               if(Low[1] > Low[2])
//               if(MathAbs(Open[1] - Close[1]) < MathAbs(Open[2] - Close[2]))
               if((Open[2] > Close[2] && Open[2] > Open[1] && Open[2] > Close[1] && Close[2] < Open[1] && Close[2] < Close[1]) || (Open[2] < Close[2] && Open[2] < Open[1] && Open[2] < Close[1] && Close[2] > Open[1] && Close[2] > Close[1]))
//               if((Open[2] > Close[2] && Open[2] > High[1] && Close[2] < Low[1]) || (Open[2] < Close[2] && Open[2] < Low[1] && Close[2] > High[1]))
               if(Bid < Low[1] - _DIFF*Point)
                  result = 1;
               break;
            }
            case 17:
            {
               if(MACDHistogram > MACDSignal)
//               if(MACDHistogram < MACDSignal)
//               if(MACDHistogram < 0)
               if(MACDHistogram > 0)
               if(High[1] < High[2])
               if(Low[1] > Low[2])
//               if(MathAbs(Open[1] - Close[1]) < MathAbs(Open[2] - Close[2]))
               if((Open[2] > Close[2] && Open[2] > Open[1] && Open[2] > Close[1] && Close[2] < Open[1] && Close[2] < Close[1]) || (Open[2] < Close[2] && Open[2] < Open[1] && Open[2] < Close[1] && Close[2] > Open[1] && Close[2] > Close[1]))
//               if((Open[2] > Close[2] && Open[2] > High[1] && Close[2] < Low[1]) || (Open[2] < Close[2] && Open[2] < Low[1] && Close[2] > High[1]))
               if(Bid < Low[1] - _DIFF*Point)
                  result = 1;
               break;
            }
            case 18:
            {
               if(MACDHistogram > MACDSignal)
//               if(MACDHistogram < MACDSignal)
               if(MACDHistogram < 0)
//               if(MACDHistogram > 0)
               if(High[1] < High[2])
               if(Low[1] > Low[2])
//               if(MathAbs(Open[1] - Close[1]) < MathAbs(Open[2] - Close[2]))
               if((Open[2] > Close[2] && Open[2] > Open[1] && Open[2] > Close[1] && Close[2] < Open[1] && Close[2] < Close[1]) || (Open[2] < Close[2] && Open[2] < Open[1] && Open[2] < Close[1] && Close[2] > Open[1] && Close[2] > Close[1]))
//               if((Open[2] > Close[2] && Open[2] > High[1] && Close[2] < Low[1]) || (Open[2] < Close[2] && Open[2] < Low[1] && Close[2] > High[1]))
               if(Bid < Low[1] - _DIFF*Point)
                  result = 1;
               break;
            }
            case 19:
            {
//               if(MACDHistogram > MACDSignal)
//               if(MACDHistogram < MACDSignal)
//               if(MACDHistogram < 0)
//               if(MACDHistogram > 0)
               if(High[1] < High[2])
               if(Low[1] > Low[2])
//               if(MathAbs(Open[1] - Close[1]) < MathAbs(Open[2] - Close[2]))
//               if((Open[2] > Close[2] && Open[2] > Open[1] && Open[2] > Close[1] && Close[2] < Open[1] && Close[2] < Close[1]) || (Open[2] < Close[2] && Open[2] < Open[1] && Open[2] < Close[1] && Close[2] > Open[1] && Close[2] > Close[1]))
               if((Open[2] > Close[2] && Open[2] > High[1] && Close[2] < Low[1]) || (Open[2] < Close[2] && Open[2] < Low[1] && Close[2] > High[1]))
               if(Bid < Low[1] - _DIFF*Point)
                  result = 1;
               break;
            }
            case 20:
            {
//               if(MACDHistogram > MACDSignal)
               if(MACDHistogram < MACDSignal)
//               if(MACDHistogram < 0)
//               if(MACDHistogram > 0)
               if(High[1] < High[2])
               if(Low[1] > Low[2])
//               if(MathAbs(Open[1] - Close[1]) < MathAbs(Open[2] - Close[2]))
//               if((Open[2] > Close[2] && Open[2] > Open[1] && Open[2] > Close[1] && Close[2] < Open[1] && Close[2] < Close[1]) || (Open[2] < Close[2] && Open[2] < Open[1] && Open[2] < Close[1] && Close[2] > Open[1] && Close[2] > Close[1]))
               if((Open[2] > Close[2] && Open[2] > High[1] && Close[2] < Low[1]) || (Open[2] < Close[2] && Open[2] < Low[1] && Close[2] > High[1]))
               if(Bid < Low[1] - _DIFF*Point)
                  result = 1;
               break;
            }
            case 21:
            {
               if(MACDHistogram > MACDSignal)
//               if(MACDHistogram < MACDSignal)
//               if(MACDHistogram < 0)
//               if(MACDHistogram > 0)
               if(High[1] < High[2])
               if(Low[1] > Low[2])
//               if(MathAbs(Open[1] - Close[1]) < MathAbs(Open[2] - Close[2]))
//               if((Open[2] > Close[2] && Open[2] > Open[1] && Open[2] > Close[1] && Close[2] < Open[1] && Close[2] < Close[1]) || (Open[2] < Close[2] && Open[2] < Open[1] && Open[2] < Close[1] && Close[2] > Open[1] && Close[2] > Close[1]))
               if((Open[2] > Close[2] && Open[2] > High[1] && Close[2] < Low[1]) || (Open[2] < Close[2] && Open[2] < Low[1] && Close[2] > High[1]))
               if(Bid < Low[1] - _DIFF*Point)
                  result = 1;
               break;
            }
            case 22:
            {
//               if(MACDHistogram > MACDSignal)
//               if(MACDHistogram < MACDSignal)
//               if(MACDHistogram < 0)
               if(MACDHistogram > 0)
               if(High[1] < High[2])
               if(Low[1] > Low[2])
//               if(MathAbs(Open[1] - Close[1]) < MathAbs(Open[2] - Close[2]))
//               if((Open[2] > Close[2] && Open[2] > Open[1] && Open[2] > Close[1] && Close[2] < Open[1] && Close[2] < Close[1]) || (Open[2] < Close[2] && Open[2] < Open[1] && Open[2] < Close[1] && Close[2] > Open[1] && Close[2] > Close[1]))
               if((Open[2] > Close[2] && Open[2] > High[1] && Close[2] < Low[1]) || (Open[2] < Close[2] && Open[2] < Low[1] && Close[2] > High[1]))
               if(Bid < Low[1] - _DIFF*Point)
                  result = 1;
               break;
            }
            case 23:
            {
//               if(MACDHistogram > MACDSignal)
//               if(MACDHistogram < MACDSignal)
               if(MACDHistogram < 0)
//               if(MACDHistogram > 0)
               if(High[1] < High[2])
               if(Low[1] > Low[2])
//               if(MathAbs(Open[1] - Close[1]) < MathAbs(Open[2] - Close[2]))
//               if((Open[2] > Close[2] && Open[2] > Open[1] && Open[2] > Close[1] && Close[2] < Open[1] && Close[2] < Close[1]) || (Open[2] < Close[2] && Open[2] < Open[1] && Open[2] < Close[1] && Close[2] > Open[1] && Close[2] > Close[1]))
               if((Open[2] > Close[2] && Open[2] > High[1] && Close[2] < Low[1]) || (Open[2] < Close[2] && Open[2] < Low[1] && Close[2] > High[1]))
               if(Bid < Low[1] - _DIFF*Point)
                  result = 1;
               break;
            }
            case 24:
            {
//               if(MACDHistogram > MACDSignal)
               if(MACDHistogram < MACDSignal)
//               if(MACDHistogram < 0)
               if(MACDHistogram > 0)
               if(High[1] < High[2])
               if(Low[1] > Low[2])
//               if(MathAbs(Open[1] - Close[1]) < MathAbs(Open[2] - Close[2]))
//               if((Open[2] > Close[2] && Open[2] > Open[1] && Open[2] > Close[1] && Close[2] < Open[1] && Close[2] < Close[1]) || (Open[2] < Close[2] && Open[2] < Open[1] && Open[2] < Close[1] && Close[2] > Open[1] && Close[2] > Close[1]))
               if((Open[2] > Close[2] && Open[2] > High[1] && Close[2] < Low[1]) || (Open[2] < Close[2] && Open[2] < Low[1] && Close[2] > High[1]))
               if(Bid < Low[1] - _DIFF*Point)
                  result = 1;
               break;
            }
            case 25:
            {
//               if(MACDHistogram > MACDSignal)
               if(MACDHistogram < MACDSignal)
               if(MACDHistogram < 0)
//               if(MACDHistogram > 0)
               if(High[1] < High[2])
               if(Low[1] > Low[2])
//               if(MathAbs(Open[1] - Close[1]) < MathAbs(Open[2] - Close[2]))
//               if((Open[2] > Close[2] && Open[2] > Open[1] && Open[2] > Close[1] && Close[2] < Open[1] && Close[2] < Close[1]) || (Open[2] < Close[2] && Open[2] < Open[1] && Open[2] < Close[1] && Close[2] > Open[1] && Close[2] > Close[1]))
               if((Open[2] > Close[2] && Open[2] > High[1] && Close[2] < Low[1]) || (Open[2] < Close[2] && Open[2] < Low[1] && Close[2] > High[1]))
               if(Bid < Low[1] - _DIFF*Point)
                  result = 1;
               break;
            }
            case 26:
            {
               if(MACDHistogram > MACDSignal)
//               if(MACDHistogram < MACDSignal)
//               if(MACDHistogram < 0)
               if(MACDHistogram > 0)
               if(High[1] < High[2])
               if(Low[1] > Low[2])
//               if(MathAbs(Open[1] - Close[1]) < MathAbs(Open[2] - Close[2]))
//               if((Open[2] > Close[2] && Open[2] > Open[1] && Open[2] > Close[1] && Close[2] < Open[1] && Close[2] < Close[1]) || (Open[2] < Close[2] && Open[2] < Open[1] && Open[2] < Close[1] && Close[2] > Open[1] && Close[2] > Close[1]))
               if((Open[2] > Close[2] && Open[2] > High[1] && Close[2] < Low[1]) || (Open[2] < Close[2] && Open[2] < Low[1] && Close[2] > High[1]))
               if(Bid < Low[1] - _DIFF*Point)
                  result = 1;
               break;
            }
            case 27:
            {
               if(MACDHistogram > MACDSignal)
//               if(MACDHistogram < MACDSignal)
               if(MACDHistogram < 0)
//               if(MACDHistogram > 0)
               if(High[1] < High[2])
               if(Low[1] > Low[2])
//               if(MathAbs(Open[1] - Close[1]) < MathAbs(Open[2] - Close[2]))
//               if((Open[2] > Close[2] && Open[2] > Open[1] && Open[2] > Close[1] && Close[2] < Open[1] && Close[2] < Close[1]) || (Open[2] < Close[2] && Open[2] < Open[1] && Open[2] < Close[1] && Close[2] > Open[1] && Close[2] > Close[1]))
               if((Open[2] > Close[2] && Open[2] > High[1] && Close[2] < Low[1]) || (Open[2] < Close[2] && Open[2] < Low[1] && Close[2] > High[1]))
               if(Bid < Low[1] - _DIFF*Point)
                  result = 1;
               break;
            }
         }

/*
         if(MACDHistogram < MACDSignal)
//         if(MACDHistogram > MACDSignal)
         if(MACDHistogram > 0)
//         if(MACDHistogram < 0)
         if(High[1] < High[2])
         if(Low[1] > Low[2])
         if(MathAbs(Open[1] - Close[1]) < MathAbs(Open[2] - Close[2]))
//         if((Open[2] > Close[2] && Open[2] > Open[1] && Open[2] > Close[1] && Close[2] < Open[1] && Close[2] < Close[1]) || (Open[2] < Close[2] && Open[2] < Open[1] && Open[2] < Close[1] && Close[2] > Open[1] && Close[2] > Close[1]))
//         if((Open[2] > Close[2] && Open[2] > High[1] && Close[2] < Low[1]) || (Open[2] < Close[2] && Open[2] < Low[1] && Close[2] > High[1]))
         if(Bid < Low[1] - _DIFF*Point)
            result = 1;
*/
                  
         break;
      }
      case _OPEN_PENDING_BUY_STOP:
      {
         break;
      }
      case _OPEN_PENDING_SELL_STOP:
      {
         break;
      }
      case _GET_PENDING_BUY_STOP_PRICE:
      {
         break;
      }
      case _GET_PENDING_SELL_STOP_PRICE:
      {
         break;
      }
      case _CLOSE_LONG:
      {
//         break;

         switch(_CLOSE_SIGNAL_COMBINATION)
         {
            case 1:
            {
               if(Bid > High[2])
                  result = 1;
               break;
            }
            case 2:
            {
               if(OrdersTotal() == 1)
               {
                  OrderSelect(0, SELECT_BY_POS);
                  if(OrderMagicNumber() != _MAGICNUMBER)
                     break;
                  if(OrderProfit() > 0)
                  {
                     if(High[2] > High[1])
                        result = 1;
                  }
               }
               
               break;
            }
            case 3:
            {
               break;
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
               if(High[2] > High[1])
                  result = 1;
            }
         }

         break;
      }
      case _CLOSE_SHORT:
      {
//         break;

         switch(_CLOSE_SIGNAL_COMBINATION)
         {
            case 1:
            {
               if(Ask < Low[2])
                  result = 1;
               break;
            }
            case 2:
            {
               if(OrdersTotal() == 1)
               {
                  OrderSelect(0, SELECT_BY_POS);
                  if(OrderMagicNumber() != _MAGICNUMBER)
                     break;
                  if(OrderProfit() > 0)
                  {
                     if(Low[2] < Low[1])
                        result = 1;
                  }
               }
               
               break;
            }
            case 3:
            {
               break;
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
               if(Low[2] < Low[1])
                  result = 1;
            }
         }

         break;
      }
      case _GET_LONG_STOPLOSS_PRICE:
      {
//         break;

         switch(_STOPLOSS_COMBINATION)
         {
            case 1:
            {
               result = Low[2];
               break;
            }
            case 2:
            {
               result = getLastFractalValue(_SYMBOL, _TIMEFRAME, false);
               break;
            }
            case 3:
            {
               break;
            }
         }

         break;
      }
      case _GET_SHORT_STOPLOSS_PRICE:
      {
//         break;

         switch(_STOPLOSS_COMBINATION)
         {
            case 1:
            {
               result = High[2];
               break;
            }
            case 2:
            {
               result = getLastFractalValue(_SYMBOL, _TIMEFRAME, true);
               break;
            }
            case 3:
            {
               break;
            }
         }
         
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

//         if(!OpenNewBar(_TIMEFRAME))
//            break;

         double breakeven = 0;

         switch(_TRAILING_STOPLOSS_COMBINATION)
         {
            case 1:
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
                        if(iLow(_SYMBOL, _TIMEFRAME, 1) > OrderOpenPrice())
                           breakeven = OrderOpenPrice();
                  
                        if(breakeven > Bid - 10*Point)
                           breakeven = Bid - 10*Point;
                     }
                     else
                     {
                        if(iHigh(_SYMBOL, _TIMEFRAME, 1) < OrderOpenPrice())
                           breakeven = OrderOpenPrice();
                  
                        if(breakeven < Ask + 10*Point)
                           breakeven = Ask + 10*Point;
                     }
                  }
               }

               break;
            }
            case 2:
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
      //                  result = iLow(_SYMBOL, _TIMEFRAME, 1);
                        result = getLastFractalValue(_SYMBOL, _TIMEFRAME, false);
                  
                        if(breakeven > result)
                           result = breakeven;
                  
                        if(result > Bid - 10*Point)
                           result = Bid - 10*Point;
                  
                        if(result <= OrderStopLoss())
                           result = OrderStopLoss();
                     }
                     else
                     {
      //                  result = iHigh(_SYMBOL, _TIMEFRAME, 1);
                        result = getLastFractalValue(_SYMBOL, _TIMEFRAME, true);
                  
                        if(breakeven < result)
                           result = breakeven;

                        if(result < Ask + 10*Point)
                           result = Ask + 10*Point;
                     
                        if(result >= OrderStopLoss())
                           result = OrderStopLoss();
                     }
                  }
               }
               
               break;
            }
            case 3:
            {
               break;
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
      case _GET_PENDING_ORDER_EXPIRATION:
      {
         break;

         result = iTime(_SYMBOL, _TIMEFRAME, 0) + _TIMEFRAME*60;

         break;
      }
   }
      
   return(result);
}
//------------------------------------------------------------------//------------------------------------------------------------------
double Strategy_017(int COMMAND)
{
   string   _SYMBOL        = Symbol();
   int      _TIMEFRAME     = getStrategyTimeframeByNumber(_STRATEGY_TIMEFRAME);
         
   double   result         = 0;
   
   int      i;

   switch(COMMAND)
   {
      case _OPEN_LONG:
      {
//         break;

//         if(!OpenNewBar(_TIMEFRAME))
//            break;
         if(iVolume(Symbol(), PERIOD_W1, 0) == 1)

// if there was a weekly gap
         if(iClose(Symbol(), PERIOD_W1, 1) > iOpen(Symbol(), PERIOD_W1, 0))
// if there is still a gap
         if(iClose(Symbol(), PERIOD_W1, 1) > iHigh(Symbol(), PERIOD_W1, 0))
// if price is inside of this gap
         if(Ask < iClose(Symbol(), PERIOD_W1, 1) && Ask >= iOpen(Symbol(), PERIOD_W1, 0))
            result = 1;

         break;
      }
      case _OPEN_SHORT:
      {
//         break;

//         if(!OpenNewBar(_TIMEFRAME))
//            break;
         if(iVolume(Symbol(), PERIOD_W1, 0) == 1)
            
// if there was a weekly gap
         if(iClose(Symbol(), PERIOD_W1, 1) < iOpen(Symbol(), PERIOD_W1, 0))
// if there is still a gap
         if(iClose(Symbol(), PERIOD_W1, 1) < iLow(Symbol(), PERIOD_W1, 0))
// if price is inside of this gap
         if(Bid > iClose(Symbol(), PERIOD_W1, 1) && Bid <= iOpen(Symbol(), PERIOD_W1, 0))
            result = 1;

         break;
      }
      case _CLOSE_LONG:
      {
//         if(Ask >= iClose(Symbol(), PERIOD_D1, 1))
         if(Ask >= iClose(Symbol(), PERIOD_W1, 1))
            result = 1;
            
            break;
      }
      case _CLOSE_SHORT:
      {
//         if(Bid <= iClose(Symbol(), PERIOD_D1, 1))
         if(Bid <= iClose(Symbol(), PERIOD_W1, 1))
            result = 1;
            
            break;
      }
      case _GET_LONG_STOPLOSS_PRICE:
      {
         result = Ask - 50*Point;
         
         break;
      }
      case _GET_SHORT_STOPLOSS_PRICE:
      {
         result = Bid + 50*Point;
         
         break;
      }
      case _OPEN_PENDING_BUY_STOP:
      {
         break;
      }
      case _OPEN_PENDING_SELL_STOP:
      {
         break;
      }
      case _GET_PENDING_BUY_STOP_PRICE:
      {
         break;
      }
      case _GET_PENDING_SELL_STOP_PRICE:
      {
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
      case _GET_PENDING_ORDER_EXPIRATION:
      {
         break;
      }
   }
      
   return(result);
}
//------------------------------------------------------------------//------------------------------------------------------------------
double Strategy_018(int COMMAND)
{
   string   _SYMBOL        = Symbol();
   int      _TIMEFRAME     = getStrategyTimeframeByNumber(_STRATEGY_TIMEFRAME);
         
   double   result         = 0;
   
   int      i;

   switch(COMMAND)
   {
      case _OPEN_LONG:
      {
         break;

         if(!OpenNewBar(_TIMEFRAME))
            break;

            result = 1;

         break;
      }
      case _OPEN_SHORT:
      {
         break;

         if(!OpenNewBar(_TIMEFRAME))
            break;

            result = 1;

         break;
      }
      case _CLOSE_LONG:
      {
         break;

            result = 1;
            
         break;
      }
      case _CLOSE_SHORT:
      {
         break;

            result = 1;
            
         break;
      }
      case _GET_LONG_STOPLOSS_PRICE:
      {
         break;
      }
      case _GET_SHORT_STOPLOSS_PRICE:
      {
         break;
      }
      case _OPEN_PENDING_BUY_STOP:
      {
         break;
      }
      case _OPEN_PENDING_SELL_STOP:
      {
         break;
      }
      case _GET_PENDING_BUY_STOP_PRICE:
      {
         break;
      }
      case _GET_PENDING_SELL_STOP_PRICE:
      {
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
      case _GET_PENDING_ORDER_EXPIRATION:
      {
         break;
      }
   }
      
   return(result);
}
//------------------------------------------------------------------//------------------------------------------------------------------
double Strategy_019(int COMMAND)
{
   string   _SYMBOL        = Symbol();
   int      _TIMEFRAME     = getStrategyTimeframeByNumber(_STRATEGY_TIMEFRAME);
         
   double   result         = 0;
   
   int      i;

   double   ZZLastTop;
   double   ZZLastBottom;
   double   BBTop;
   double   BBBottom;
   
   switch(COMMAND)
   {
      case _OPEN_LONG:
      {
         break;

         if(!OpenNewBar(_TIMEFRAME))
            break;

         ZZLastTop = iCustom(Symbol(), _TIMEFRAME, "ZigZag", 1, 0);
         ZZLastBottom = iCustom(Symbol(), _TIMEFRAME, "ZigZag", 2, 0);
         BBTop = iBands(Symbol(), _TIMEFRAME, 20, 2, 0, PRICE_CLOSE, 1, 0);
         BBBottom = iBands(Symbol(), _TIMEFRAME, 20, 2, 0, PRICE_CLOSE, 2, 0);
         
         if(Ask > BBBottom)
         if(ZZLastTop > BBBottom)
            result = 1;

         break;
      }
      case _OPEN_SHORT:
      {
         break;

         if(!OpenNewBar(_TIMEFRAME))
            break;

         ZZLastTop = iCustom(Symbol(), _TIMEFRAME, "ZigZag", 1, 0);
         ZZLastBottom = iCustom(Symbol(), _TIMEFRAME, "ZigZag", 2, 0);
         BBTop = iBands(Symbol(), _TIMEFRAME, 20, 2, 0, PRICE_CLOSE, 1, 0);
         BBBottom = iBands(Symbol(), _TIMEFRAME, 20, 2, 0, PRICE_CLOSE, 2, 0);

            result = 1;

         break;
      }
      case _CLOSE_LONG:
      {
         break;

            result = 1;
            
         break;
      }
      case _CLOSE_SHORT:
      {
         break;

            result = 1;
            
         break;
      }
      case _GET_LONG_STOPLOSS_PRICE:
      {
         break;
      }
      case _GET_SHORT_STOPLOSS_PRICE:
      {
         break;
      }
      case _OPEN_PENDING_BUY_STOP:
      {
         break;
      }
      case _OPEN_PENDING_SELL_STOP:
      {
         break;
      }
      case _GET_PENDING_BUY_STOP_PRICE:
      {
         break;
      }
      case _GET_PENDING_SELL_STOP_PRICE:
      {
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
      case _GET_PENDING_ORDER_EXPIRATION:
      {
         break;
      }
   }
      
   return(result);
}
//------------------------------------------------------------------//------------------------------------------------------------------
double Strategy_020(int COMMAND)
{
   string   _SYMBOL        = Symbol();
   int      _TIMEFRAME     = getStrategyTimeframeByNumber(_STRATEGY_TIMEFRAME);
         
   double   result         = 0;
   
   int      i;

   switch(COMMAND)
   {
      case _OPEN_LONG:
      {
//         break;

         if(!OpenNewBar(_TIMEFRAME))
            break;

//         Print(1, iCustom(Symbol(), _TIMEFRAME, "ZigZag", 1, 1));
//         Print(2, iCustom(Symbol(), getHigherTimeframe(_TIMEFRAME), "ZigZag", 1, 1));
//         Print(3, iCustom(Symbol(), getHigherTimeframe(getHigherTimeframe(_TIMEFRAME)), "ZigZag", 1, 1));
//         Print(4, iCustom(Symbol(), getHigherTimeframe(getHigherTimeframe(getHigherTimeframe(_TIMEFRAME))), "ZigZag", 1, 1));

         if(Ask > iCustom(Symbol(), _TIMEFRAME, "ZigZag", 1, 0))
//         if(Ask > iCustom(Symbol(), getHigherTimeframe(_TIMEFRAME), "ZigZag", 1, 0))
//         if(Ask > iCustom(Symbol(), getHigherTimeframe(getHigherTimeframe(_TIMEFRAME)), "ZigZag", 1, 0))
//         if(Ask > iCustom(Symbol(), getHigherTimeframe(getHigherTimeframe(getHigherTimeframe(_TIMEFRAME))), "ZigZag", 1, 0))
            result = 1;

         break;
      }
      case _OPEN_SHORT:
      {
//         break;

         if(!OpenNewBar(_TIMEFRAME))
            break;

//         Print(5, iCustom(Symbol(), _TIMEFRAME, "ZigZag", 2, 1));
//         Print(6, iCustom(Symbol(), getHigherTimeframe(_TIMEFRAME), "ZigZag", 2, 1));
//         Print(7, iCustom(Symbol(), getHigherTimeframe(getHigherTimeframe(_TIMEFRAME)), "ZigZag", 2, 1));
//         Print(8, iCustom(Symbol(), getHigherTimeframe(getHigherTimeframe(getHigherTimeframe(_TIMEFRAME))), "ZigZag", 2, 1));

         if(Bid < iCustom(Symbol(), _TIMEFRAME, "ZigZag", 2, 0))
//         if(Bid < iCustom(Symbol(), getHigherTimeframe(_TIMEFRAME), "ZigZag", 2, 0))
//         if(Bid < iCustom(Symbol(), getHigherTimeframe(getHigherTimeframe(_TIMEFRAME)), "ZigZag", 2, 0))
//         if(Bid < iCustom(Symbol(), getHigherTimeframe(getHigherTimeframe(getHigherTimeframe(_TIMEFRAME))), "ZigZag", 2, 0))
             result = 1;

         break;
      }
      case _CLOSE_LONG:
      {
//         break;

         if(Bid < iCustom(Symbol(), _TIMEFRAME, "ZigZag", 2, 0))
//         if(Bid < iCustom(Symbol(), getHigherTimeframe(_TIMEFRAME), "ZigZag", 2, 0))
//         if(Bid < iCustom(Symbol(), getHigherTimeframe(getHigherTimeframe(_TIMEFRAME)), "ZigZag", 2, 0))
//         if(Bid < iCustom(Symbol(), getHigherTimeframe(getHigherTimeframe(getHigherTimeframe(_TIMEFRAME))), "ZigZag", 2, 0))
             result = 1;
            
         break;
      }
      case _CLOSE_SHORT:
      {
//         break;

         if(Ask > iCustom(Symbol(), _TIMEFRAME, "ZigZag", 1, 0))
//         if(Ask > iCustom(Symbol(), getHigherTimeframe(_TIMEFRAME), "ZigZag", 1, 0))
//         if(Ask > iCustom(Symbol(), getHigherTimeframe(getHigherTimeframe(_TIMEFRAME)), "ZigZag", 1, 0))
//         if(Ask > iCustom(Symbol(), getHigherTimeframe(getHigherTimeframe(getHigherTimeframe(_TIMEFRAME))), "ZigZag", 1, 0))
            result = 1;
            
         break;
      }
      case _GET_LONG_STOPLOSS_PRICE:
      {
         break;
      }
      case _GET_SHORT_STOPLOSS_PRICE:
      {
         break;
      }
      case _OPEN_PENDING_BUY_STOP:
      {
         break;
      }
      case _OPEN_PENDING_SELL_STOP:
      {
         break;
      }
      case _GET_PENDING_BUY_STOP_PRICE:
      {
         break;
      }
      case _GET_PENDING_SELL_STOP_PRICE:
      {
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
      case _GET_PENDING_ORDER_EXPIRATION:
      {
         break;
      }
   }
      
   return(result);
}
//------------------------------------------------------------------//------------------------------------------------------------------
double Strategy_021(int COMMAND)
{
   string   _SYMBOL        = Symbol();
   int      _TIMEFRAME     = getStrategyTimeframeByNumber(_STRATEGY_TIMEFRAME);
         
   double   UpperZIGZAG1;
   double   LowerZIGZAG1;
   datetime UpperZIGZAGTime1;
   datetime LowerZIGZAGTime1;
   int      UpperZIGZAGShift1;
   int      LowerZIGZAGShift1;
   double   UpperZIGZAG2;
   double   LowerZIGZAG2;
   datetime UpperZIGZAGTime2;
   datetime LowerZIGZAGTime2;
   int      UpperZIGZAGShift2;
   int      LowerZIGZAGShift2;
   double   LastUpperFractal;
   double   LastLowerFractal;

   int      BreakOutTreshold = 0;
   double   EdgePrice;
   static datetime LastZIGZAGTime = 0;

   double   result         = 0;
   
   int      i;

//   Print(_TIMEFRAME);

   switch(COMMAND)
   {
      case _OPEN_LONG:
      {
//         break;

//         if(!OpenNewBar(_TIMEFRAME))
//            break;

         UpperZIGZAG1 = getLastZIGZAGValue(_SYMBOL, _TIMEFRAME, true);
         UpperZIGZAGTime1 = getLastZIGZAGTime(_SYMBOL, _TIMEFRAME, true);
         UpperZIGZAG2 = getPreviousZIGZAGValue(_SYMBOL, _TIMEFRAME, true);
         UpperZIGZAGTime2 = getPreviousZIGZAGTime(_SYMBOL, _TIMEFRAME, true);

         LowerZIGZAGTime1 = getLastZIGZAGTime(_SYMBOL, _TIMEFRAME, false);

         UpperZIGZAGShift1 = iBarShift(_SYMBOL, _TIMEFRAME, UpperZIGZAGTime1);
         UpperZIGZAGShift2 = iBarShift(_SYMBOL, _TIMEFRAME, UpperZIGZAGTime2);
         
//         LastUpperFractal = getLastFractalValue(_SYMBOL, _TIMEFRAME, true);
//         LastLowerFractal = getLastFractalValue(_SYMBOL, _TIMEFRAME, false);

//         EdgePrice = UpperZIGZAG2 - (UpperZIGZAG2 - UpperZIGZAG1) * (UpperZIGZAGShift2 / (UpperZIGZAGShift2 - UpperZIGZAGShift1));
         EdgePrice = UpperZIGZAG1 + UpperZIGZAGShift1 * (UpperZIGZAG1 - UpperZIGZAG2) / (UpperZIGZAGShift2 - UpperZIGZAGShift1);

//         Print(UpperZIGZAG1, " ", UpperZIGZAGTime1, " ", UpperZIGZAG2, " ", UpperZIGZAGTime2, " ", LowerZIGZAG1, " ", LowerZIGZAGTime1, " ", LowerZIGZAG2, " ", LowerZIGZAGTime2, " ", UpperZIGZAGShift1, " ", UpperZIGZAGShift2, " ", LowerZIGZAGShift1, " ", LowerZIGZAGShift2, " ", EdgePrice);

         if(LowerZIGZAGTime1 > UpperZIGZAGTime1)
         if(LastZIGZAGTime != UpperZIGZAGTime1)
//         if(LastUpperFractal > EdgePrice && LastLowerFractal > EdgePrice)
         if(Ask > EdgePrice + BreakOutTreshold*Point)
         {
            result = 1;

//            ObjectCreate(StringConcatenate(UpperZIGZAGTime1, 0), OBJ_TREND, 0, UpperZIGZAGTime1, UpperZIGZAG1, UpperZIGZAGTime2, UpperZIGZAG2);
//            ObjectCreate(StringConcatenate(UpperZIGZAGTime1, 1), OBJ_TREND, 0, UpperZIGZAGTime1, UpperZIGZAG1, Time[0], EdgePrice);
//            ObjectSet(StringConcatenate(UpperZIGZAGTime1, 1), OBJPROP_COLOR, 0x00FFFF);
            
//            Comment(LastZIGZAGTime, " - ", UpperZIGZAGTime1);
            LastZIGZAGTime = UpperZIGZAGTime1;
         }
         
         break;
      }
      case _OPEN_SHORT:
      {
//         break;

//         if(!OpenNewBar(_TIMEFRAME))
//            break;

         LowerZIGZAG1 = getLastZIGZAGValue(_SYMBOL, _TIMEFRAME, false);
         LowerZIGZAGTime1 = getLastZIGZAGTime(_SYMBOL, _TIMEFRAME, false);
         LowerZIGZAG2 = getPreviousZIGZAGValue(_SYMBOL, _TIMEFRAME, false);
         LowerZIGZAGTime2 = getPreviousZIGZAGTime(_SYMBOL, _TIMEFRAME, false);

         UpperZIGZAGTime1 = getLastZIGZAGTime(_SYMBOL, _TIMEFRAME, true);

         LowerZIGZAGShift1 = iBarShift(_SYMBOL, _TIMEFRAME, LowerZIGZAGTime1);
         LowerZIGZAGShift2 = iBarShift(_SYMBOL, _TIMEFRAME, LowerZIGZAGTime2);
         
//         LastUpperFractal = getLastFractalValue(_SYMBOL, _TIMEFRAME, true);
//         LastLowerFractal = getLastFractalValue(_SYMBOL, _TIMEFRAME, false);

//         EdgePrice = LowerZIGZAG2 - (LowerZIGZAG2 - LowerZIGZAG1) * (LowerZIGZAGShift2 / (LowerZIGZAGShift2 - LowerZIGZAGShift1));
         EdgePrice = LowerZIGZAG1 + LowerZIGZAGShift1 * (LowerZIGZAG1 - LowerZIGZAG2) / (LowerZIGZAGShift2 - LowerZIGZAGShift1);

//         Print(UpperZIGZAG1, " ", UpperZIGZAGTime1, " ", UpperZIGZAG2, " ", UpperZIGZAGTime2, " ", LowerZIGZAG1, " ", LowerZIGZAGTime1, " ", LowerZIGZAG2, " ", LowerZIGZAGTime2, " ", UpperZIGZAGShift1, " ", UpperZIGZAGShift2, " ", LowerZIGZAGShift1, " ", LowerZIGZAGShift2, " ", EdgePrice);
         
         if(LowerZIGZAGTime1 < UpperZIGZAGTime1)
         if(LastZIGZAGTime != LowerZIGZAGTime1)
//         if(LastUpperFractal < EdgePrice && LastLowerFractal < EdgePrice)
         if(Bid < EdgePrice - BreakOutTreshold*Point)
         {
            result = 1;

//            ObjectCreate(StringConcatenate(LowerZIGZAGTime1, 0), OBJ_TREND, 0, LowerZIGZAGTime1, LowerZIGZAG1, LowerZIGZAGTime2, LowerZIGZAG2);
//            ObjectCreate(StringConcatenate(LowerZIGZAGTime1, 1), OBJ_TREND, 0, LowerZIGZAGTime1, LowerZIGZAG1, Time[0], EdgePrice);
//            ObjectSet(StringConcatenate(LowerZIGZAGTime1, 1), OBJPROP_COLOR, 0x00FFFF);
            
//            Comment(LastZIGZAGTime, " - ", LowerZIGZAGTime1);
            LastZIGZAGTime = LowerZIGZAGTime1;
         }
         
         break;
      }
      case _CLOSE_LONG:
      {
         break;

         if(!OpenNewBar(_TIMEFRAME))
            break;

         if(OrdersTotal() == 1)
         {
            OrderSelect(0, SELECT_BY_POS);
            if(OrderMagicNumber() != _MAGICNUMBER)
               break;
            if(OrderProfit() > 0)
            {
//               if(iCCI(_SYMBOL, _TIMEFRAME, 14, PRICE_CLOSE, 1) < 100)
               if(iCCI(_SYMBOL, _TIMEFRAME, 14, PRICE_OPEN, 0) < 100)
                  result = 1;
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
               if(iHigh(_SYMBOL, _TIMEFRAME, 2) > iHigh(_SYMBOL, _TIMEFRAME, 1))
//                  if(iHigh(_SYMBOL, _TIMEFRAME, 1) > iHigh(_SYMBOL, _TIMEFRAME, 0))
                   result = 1;
            }
         }

         break;

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

         if(!OpenNewBar(_TIMEFRAME))
            break;

         if(OrdersTotal() == 1)
         {
            OrderSelect(0, SELECT_BY_POS);
            if(OrderMagicNumber() != _MAGICNUMBER)
               break;
            if(OrderProfit() > 0)
            {
//               if(iCCI(_SYMBOL, _TIMEFRAME, 14, PRICE_CLOSE, 1) > -100)
               if(iCCI(_SYMBOL, _TIMEFRAME, 14, PRICE_OPEN, 0) > -100)
                  result = 1;
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
               if(iLow(_SYMBOL, _TIMEFRAME, 2) < iLow(_SYMBOL, _TIMEFRAME, 1))
//                  if(iLow(_SYMBOL, _TIMEFRAME, 1) > iLow(_SYMBOL, _TIMEFRAME, 0))
                  result = 1;
            }
         }

         break;
         
//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, true) < getPreviousFractalValue(_SYMBOL, _TIMEFRAME, true))
//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, true) > getPreviousFractalValue(_SYMBOL, _TIMEFRAME, true))
         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, false) > getPreviousFractalValue(_SYMBOL, _TIMEFRAME, false))
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
//         result = getLastZIGZAGValue(_SYMBOL, _TIMEFRAME, false);
//         result = getLastFractalValue(_SYMBOL, _TIMEFRAME, false);
         result = iLow(_SYMBOL, _TIMEFRAME, 1);

         break;
      }
      case _GET_SHORT_STOPLOSS_PRICE:
      {
//         result = getLastZIGZAGValue(_SYMBOL, _TIMEFRAME, true);
//         result = getLastFractalValue(_SYMBOL, _TIMEFRAME, true);
         result = iHigh(_SYMBOL, _TIMEFRAME, 1);
         
         break;
      }
      case _OPEN_PENDING_BUY_STOP:
      {
         break;
      }
      case _OPEN_PENDING_SELL_STOP:
      {
         break;
      }
      case _GET_PENDING_BUY_STOP_PRICE:
      {
         break;
      }
      case _GET_PENDING_SELL_STOP_PRICE:
      {
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
                  result = iLow(_SYMBOL, _TIMEFRAME, 1);
               }
               if(OrderType() == OP_SELL)
               {
                  result = iHigh(_SYMBOL, _TIMEFRAME, 1);
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
      case _GET_PENDING_ORDER_EXPIRATION:
      {
         break;
      }
   }
      
   return(result);
}
//------------------------------------------------------------------//------------------------------------------------------------------
double Strategy_022(int COMMAND)
{
   string   _SYMBOL        = Symbol();
   int      _TIMEFRAME     = getStrategyTimeframeByNumber(_STRATEGY_TIMEFRAME);
         
   double   UpperZIGZAG1;
   double   LowerZIGZAG1;
   datetime UpperZIGZAGTime1;
   datetime LowerZIGZAGTime1;
   int      UpperZIGZAGShift1;
   int      LowerZIGZAGShift1;
   double   UpperZIGZAG2;
   double   LowerZIGZAG2;
   datetime UpperZIGZAGTime2;
   datetime LowerZIGZAGTime2;
   int      UpperZIGZAGShift2;
   int      LowerZIGZAGShift2;
   double   LastUpperFractal;
   double   LastLowerFractal;

   int      BreakOutTreshold = 0;
   double   EdgePrice;
   static datetime LastZIGZAGTime = 0;

   double   result         = 0;
   
   int      i;

//   Print(_TIMEFRAME);

   switch(COMMAND)
   {
      case _OPEN_LONG:
      {
//         break;

         if(!OpenNewBar(_TIMEFRAME))
            break;

         LowerZIGZAG1 = getLastZIGZAGValue(_SYMBOL, _TIMEFRAME, false);
         LowerZIGZAGTime1 = getLastZIGZAGTime(_SYMBOL, _TIMEFRAME, false);
         LowerZIGZAG2 = getPreviousZIGZAGValue(_SYMBOL, _TIMEFRAME, false);
         LowerZIGZAGTime2 = getPreviousZIGZAGTime(_SYMBOL, _TIMEFRAME, false);

         UpperZIGZAGTime1 = getLastZIGZAGTime(_SYMBOL, _TIMEFRAME, true);

         LowerZIGZAGShift1 = iBarShift(_SYMBOL, _TIMEFRAME, LowerZIGZAGTime1);
         LowerZIGZAGShift2 = iBarShift(_SYMBOL, _TIMEFRAME, LowerZIGZAGTime2);
         
//         LastUpperFractal = getLastFractalValue(_SYMBOL, _TIMEFRAME, true);
//         LastLowerFractal = getLastFractalValue(_SYMBOL, _TIMEFRAME, false);

//         EdgePrice = LowerZIGZAG2 - (LowerZIGZAG2 - LowerZIGZAG1) * (LowerZIGZAGShift2 / (LowerZIGZAGShift2 - LowerZIGZAGShift1));
         EdgePrice = LowerZIGZAG1 + LowerZIGZAGShift1 * (LowerZIGZAG1 - LowerZIGZAG2) / (LowerZIGZAGShift2 - LowerZIGZAGShift1);

//         Print(UpperZIGZAG1, " ", UpperZIGZAGTime1, " ", UpperZIGZAG2, " ", UpperZIGZAGTime2, " ", LowerZIGZAG1, " ", LowerZIGZAGTime1, " ", LowerZIGZAG2, " ", LowerZIGZAGTime2, " ", UpperZIGZAGShift1, " ", UpperZIGZAGShift2, " ", LowerZIGZAGShift1, " ", LowerZIGZAGShift2, " ", EdgePrice);
         
         if(LowerZIGZAGTime1 < UpperZIGZAGTime1)
         if(LastZIGZAGTime != LowerZIGZAGTime1)
//         if(LastUpperFractal < EdgePrice && LastLowerFractal < EdgePrice)
//         if(Ask < EdgePrice)
         if(Ask > EdgePrice)
         if(Low[1] < EdgePrice)
         if(Open[1] > EdgePrice && Close[1] > EdgePrice)
         if(Low[2] > EdgePrice)
         {
            result = 1;

//            ObjectCreate(StringConcatenate(LowerZIGZAGTime1, 0), OBJ_TREND, 0, LowerZIGZAGTime1, LowerZIGZAG1, LowerZIGZAGTime2, LowerZIGZAG2);
//            ObjectCreate(StringConcatenate(LowerZIGZAGTime1, 1), OBJ_TREND, 0, LowerZIGZAGTime1, LowerZIGZAG1, Time[0], EdgePrice);
//            ObjectSet(StringConcatenate(LowerZIGZAGTime1, 1), OBJPROP_COLOR, 0x00FFFF);
            
//            Comment(LastZIGZAGTime, " - ", LowerZIGZAGTime1);
            LastZIGZAGTime = LowerZIGZAGTime1;
         }
         
         break;
      }
      case _OPEN_SHORT:
      {
//         break;

         if(!OpenNewBar(_TIMEFRAME))
            break;

         UpperZIGZAG1 = getLastZIGZAGValue(_SYMBOL, _TIMEFRAME, true);
         UpperZIGZAGTime1 = getLastZIGZAGTime(_SYMBOL, _TIMEFRAME, true);
         UpperZIGZAG2 = getPreviousZIGZAGValue(_SYMBOL, _TIMEFRAME, true);
         UpperZIGZAGTime2 = getPreviousZIGZAGTime(_SYMBOL, _TIMEFRAME, true);

         LowerZIGZAGTime1 = getLastZIGZAGTime(_SYMBOL, _TIMEFRAME, false);

         UpperZIGZAGShift1 = iBarShift(_SYMBOL, _TIMEFRAME, UpperZIGZAGTime1);
         UpperZIGZAGShift2 = iBarShift(_SYMBOL, _TIMEFRAME, UpperZIGZAGTime2);
         
//         LastUpperFractal = getLastFractalValue(_SYMBOL, _TIMEFRAME, true);
//         LastLowerFractal = getLastFractalValue(_SYMBOL, _TIMEFRAME, false);

//         EdgePrice = UpperZIGZAG2 - (UpperZIGZAG2 - UpperZIGZAG1) * (UpperZIGZAGShift2 / (UpperZIGZAGShift2 - UpperZIGZAGShift1));
         EdgePrice = UpperZIGZAG1 + UpperZIGZAGShift1 * (UpperZIGZAG1 - UpperZIGZAG2) / (UpperZIGZAGShift2 - UpperZIGZAGShift1);

//         Print(UpperZIGZAG1, " ", UpperZIGZAGTime1, " ", UpperZIGZAG2, " ", UpperZIGZAGTime2, " ", LowerZIGZAG1, " ", LowerZIGZAGTime1, " ", LowerZIGZAG2, " ", LowerZIGZAGTime2, " ", UpperZIGZAGShift1, " ", UpperZIGZAGShift2, " ", LowerZIGZAGShift1, " ", LowerZIGZAGShift2, " ", EdgePrice);

         if(LowerZIGZAGTime1 > UpperZIGZAGTime1)
         if(LastZIGZAGTime != UpperZIGZAGTime1)
//         if(LastUpperFractal > EdgePrice && LastLowerFractal > EdgePrice)
//         if(Bid > EdgePrice)
         if(Bid < EdgePrice)
         if(High[1] > EdgePrice)
         if(Open[1] < EdgePrice && Close[1] < EdgePrice)
         if(High[2] < EdgePrice)
         {
            result = 1;

//            ObjectCreate(StringConcatenate(UpperZIGZAGTime1, 0), OBJ_TREND, 0, UpperZIGZAGTime1, UpperZIGZAG1, UpperZIGZAGTime2, UpperZIGZAG2);
//            ObjectCreate(StringConcatenate(UpperZIGZAGTime1, 1), OBJ_TREND, 0, UpperZIGZAGTime1, UpperZIGZAG1, Time[0], EdgePrice);
//            ObjectSet(StringConcatenate(UpperZIGZAGTime1, 1), OBJPROP_COLOR, 0x00FFFF);
            
//            Comment(LastZIGZAGTime, " - ", UpperZIGZAGTime1);
            LastZIGZAGTime = UpperZIGZAGTime1;
         }
         
         break;
      }
      case _CLOSE_LONG:
      {
         break;

//         if(!OpenNewBar(_TIMEFRAME))
//            break;

         if(OrdersTotal() == 1)
         {
            OrderSelect(0, SELECT_BY_POS);
            if(OrderMagicNumber() != _MAGICNUMBER)
               break;
//            if(OrderProfit() > 0)
            {
               if(iCustom(_SYMBOL, _TIMEFRAME, "ZigZag", 12, 5, 3, 0, 0) > 0)
                  result = 1;
            }
         }

         break;

         if(!OpenNewBar(_TIMEFRAME))
            break;

         if(OrdersTotal() == 1)
         {
            OrderSelect(0, SELECT_BY_POS);
            if(OrderMagicNumber() != _MAGICNUMBER)
               break;
            if(OrderProfit() > 0)
            {
//               if(iCCI(_SYMBOL, _TIMEFRAME, 14, PRICE_CLOSE, 1) < 100)
               if(iCCI(_SYMBOL, _TIMEFRAME, 14, PRICE_OPEN, 0) < 100)
                  result = 1;
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
               if(iHigh(_SYMBOL, _TIMEFRAME, 2) > iHigh(_SYMBOL, _TIMEFRAME, 1))
//                  if(iHigh(_SYMBOL, _TIMEFRAME, 1) > iHigh(_SYMBOL, _TIMEFRAME, 0))
                   result = 1;
            }
         }

         break;

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

//         if(!OpenNewBar(_TIMEFRAME))
//            break;

         if(OrdersTotal() == 1)
         {
            OrderSelect(0, SELECT_BY_POS);
            if(OrderMagicNumber() != _MAGICNUMBER)
               break;
//            if(OrderProfit() > 0)
            {
               if(iCustom(_SYMBOL, _TIMEFRAME, "ZigZag", 12, 5, 3, 0, 0) > 0)
                  result = 1;
            }
         }

         break;

         if(!OpenNewBar(_TIMEFRAME))
            break;

         if(OrdersTotal() == 1)
         {
            OrderSelect(0, SELECT_BY_POS);
            if(OrderMagicNumber() != _MAGICNUMBER)
               break;
            if(OrderProfit() > 0)
            {
//               if(iCCI(_SYMBOL, _TIMEFRAME, 14, PRICE_CLOSE, 1) > -100)
               if(iCCI(_SYMBOL, _TIMEFRAME, 14, PRICE_OPEN, 0) > -100)
                  result = 1;
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
               if(iLow(_SYMBOL, _TIMEFRAME, 2) < iLow(_SYMBOL, _TIMEFRAME, 1))
//                  if(iLow(_SYMBOL, _TIMEFRAME, 1) > iLow(_SYMBOL, _TIMEFRAME, 0))
                  result = 1;
            }
         }

         break;
         
//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, true) < getPreviousFractalValue(_SYMBOL, _TIMEFRAME, true))
//         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, true) > getPreviousFractalValue(_SYMBOL, _TIMEFRAME, true))
         if(getLastFractalValue(_SYMBOL, _TIMEFRAME, false) > getPreviousFractalValue(_SYMBOL, _TIMEFRAME, false))
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
//         result = getLastZIGZAGValue(_SYMBOL, _TIMEFRAME, false);
//         result = getLastFractalValue(_SYMBOL, _TIMEFRAME, false);
         result = iLow(_SYMBOL, _TIMEFRAME, 1);
//         result = Ask - 20*Point;
         
         break;
      }
      case _GET_SHORT_STOPLOSS_PRICE:
      {
//         result = getLastZIGZAGValue(_SYMBOL, _TIMEFRAME, true);
//         result = getLastFractalValue(_SYMBOL, _TIMEFRAME, true);
         result = iHigh(_SYMBOL, _TIMEFRAME, 1);
//         result = Bid + 20*Point;
         
         break;
      }
      case _OPEN_PENDING_BUY_STOP:
      {
         break;
      }
      case _OPEN_PENDING_SELL_STOP:
      {
         break;
      }
      case _GET_PENDING_BUY_STOP_PRICE:
      {
         break;
      }
      case _GET_PENDING_SELL_STOP_PRICE:
      {
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
                  result = iLow(_SYMBOL, _TIMEFRAME, 1);
               }
               if(OrderType() == OP_SELL)
               {
                  result = iHigh(_SYMBOL, _TIMEFRAME, 1);
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
      case _GET_PENDING_ORDER_EXPIRATION:
      {
         break;
      }
   }
      
   return(result);
}
//------------------------------------------------------------------//------------------------------------------------------------------
double Strategy_023(int COMMAND)
{
   string   _SYMBOL        = Symbol();
   int      _TIMEFRAME     = getStrategyTimeframeByNumber(_STRATEGY_TIMEFRAME);
   int      _TIMEFRAME_2   = getHigherTimeframe(_TIMEFRAME);
   int      _TIMEFRAME_HALF= getLowerTimeframe(_TIMEFRAME_HALF);
         
   double   UpperZIGZAG1;
   double   LowerZIGZAG1;
   double   UpperZIGZAG2;
   double   LowerZIGZAG2;
   int      UpperZIGZAGTime1;
   int      UpperZIGZAGTime2;
   int      LowerZIGZAGTime1;
   int      LowerZIGZAGTime2;
   
   double MacdDiff;
   
   static datetime LastUpperZIGZAGTime = 0;
   static datetime LastLowerZIGZAGTime = 0;

   double   result         = 0;
   
   int      i;

/*
Napady
********************************************
OPEN:
 - uz pri dotyku ceny sviecky, ktora bola vrcholom ZIGZAG
CLOSE:

SL:

TRAILING:

*/

   switch(COMMAND)
   {
      case _OPEN_LONG:
      {
//         break;

//         if(!OpenNewBar(_TIMEFRAME))
//            break;

         UpperZIGZAG1 = getLastZIGZAGValue(_SYMBOL, _TIMEFRAME, true);
         UpperZIGZAG2 = getPreviousZIGZAGValue(_SYMBOL, _TIMEFRAME, true);
         UpperZIGZAGTime1 = getLastZIGZAGTime(_SYMBOL, _TIMEFRAME, true);
         UpperZIGZAGTime2 = getPreviousZIGZAGTime(_SYMBOL, _TIMEFRAME, true);
         LowerZIGZAG1 = getLastZIGZAGValue(_SYMBOL, _TIMEFRAME, false);
         LowerZIGZAG2 = getPreviousZIGZAGValue(_SYMBOL, _TIMEFRAME, false);
         LowerZIGZAGTime1 = getLastZIGZAGTime(_SYMBOL, _TIMEFRAME, false);
         LowerZIGZAGTime2 = getPreviousZIGZAGTime(_SYMBOL, _TIMEFRAME, false);

         MacdDiff = iCustom(_SYMBOL, PERIOD_D1, "MACD+HistogramDiff+SignalDiff", 12, 26, 9, 2, 0);   

//if MACD diff > 0 - uptrend - trade with trend
         if(MacdDiff > 0)
//If this reversal was not traded yet         
         if(LastLowerZIGZAGTime != LowerZIGZAGTime1)
//Price touch S/R level from last ZIGZAT bottom
         if(Ask < LowerZIGZAG1)
//Last ZIGZAG top is younger than last ZIGZAG bottom - price came from up and will probably reverse
         if(LowerZIGZAGTime1 < UpperZIGZAGTime1)
         {
            result = 1;
            LastUpperZIGZAGTime = UpperZIGZAGTime1;
            LastLowerZIGZAGTime = LowerZIGZAGTime1;
         }
         
         break;
      }
      case _OPEN_SHORT:
      {
//         break;

//         if(!OpenNewBar(_TIMEFRAME))
//            break;

         UpperZIGZAG1 = getLastZIGZAGValue(_SYMBOL, _TIMEFRAME, true);
         UpperZIGZAG2 = getPreviousZIGZAGValue(_SYMBOL, _TIMEFRAME, true);
         UpperZIGZAGTime1 = getLastZIGZAGTime(_SYMBOL, _TIMEFRAME, true);
         UpperZIGZAGTime2 = getPreviousZIGZAGTime(_SYMBOL, _TIMEFRAME, true);
         LowerZIGZAG1 = getLastZIGZAGValue(_SYMBOL, _TIMEFRAME, false);
         LowerZIGZAG2 = getPreviousZIGZAGValue(_SYMBOL, _TIMEFRAME, false);
         LowerZIGZAGTime1 = getLastZIGZAGTime(_SYMBOL, _TIMEFRAME, false);
         LowerZIGZAGTime2 = getPreviousZIGZAGTime(_SYMBOL, _TIMEFRAME, false);
   
         MacdDiff = iCustom(_SYMBOL, PERIOD_D1, "MACD+HistogramDiff+SignalDiff", 12, 26, 9, 2, 0);   

//if MACD diff < 0 - downtrend - trade with trend
         if(MacdDiff < 0)
//If this reversal was not traded yet         
         if(LastUpperZIGZAGTime != UpperZIGZAGTime1)
//Price touch S/R level from last ZIGZAT top
         if(Bid > UpperZIGZAG1)
//Last ZIGZAG top is older than last ZIGZAG bottom - price came from down and will probably reverse
         if(LowerZIGZAGTime1 > UpperZIGZAGTime1)
         {
            result = 1;
            LastUpperZIGZAGTime = UpperZIGZAGTime1;
            LastLowerZIGZAGTime = LowerZIGZAGTime1;
         }

         break;
      }
      case _CLOSE_LONG:
      {
//         break;

         UpperZIGZAG1 = getLastZIGZAGValue(_SYMBOL, _TIMEFRAME, true);
         UpperZIGZAG2 = getPreviousZIGZAGValue(_SYMBOL, _TIMEFRAME, true);
         UpperZIGZAGTime1 = getLastZIGZAGTime(_SYMBOL, _TIMEFRAME, true);
         UpperZIGZAGTime2 = getPreviousZIGZAGTime(_SYMBOL, _TIMEFRAME, true);
         LowerZIGZAG1 = getLastZIGZAGValue(_SYMBOL, _TIMEFRAME, false);
         LowerZIGZAG2 = getPreviousZIGZAGValue(_SYMBOL, _TIMEFRAME, false);
         LowerZIGZAGTime1 = getLastZIGZAGTime(_SYMBOL, _TIMEFRAME, false);
         LowerZIGZAGTime2 = getPreviousZIGZAGTime(_SYMBOL, _TIMEFRAME, false);
   
         if(Bid > UpperZIGZAG1)
            result = 1;

//         if(Bid < getLastFractalValue(_SYMBOL, _TIMEFRAME, false))
//            result = 1;
            
         break;
      }
      case _CLOSE_SHORT:
      {
//         break;

         UpperZIGZAG1 = getLastZIGZAGValue(_SYMBOL, _TIMEFRAME, true);
         UpperZIGZAG2 = getPreviousZIGZAGValue(_SYMBOL, _TIMEFRAME, true);
         UpperZIGZAGTime1 = getLastZIGZAGTime(_SYMBOL, _TIMEFRAME, true);
         UpperZIGZAGTime2 = getPreviousZIGZAGTime(_SYMBOL, _TIMEFRAME, true);
         LowerZIGZAG1 = getLastZIGZAGValue(_SYMBOL, _TIMEFRAME, false);
         LowerZIGZAG2 = getPreviousZIGZAGValue(_SYMBOL, _TIMEFRAME, false);
         LowerZIGZAGTime1 = getLastZIGZAGTime(_SYMBOL, _TIMEFRAME, false);
         LowerZIGZAGTime2 = getPreviousZIGZAGTime(_SYMBOL, _TIMEFRAME, false);
   
         if(Ask < LowerZIGZAG1)
            result = 1;
            
//         if(Ask > getLastFractalValue(_SYMBOL, _TIMEFRAME, true))
//            result = 1;

         break;
      }
      case _GET_LONG_STOPLOSS_PRICE:
      {
         UpperZIGZAG1 = getLastZIGZAGValue(_SYMBOL, _TIMEFRAME, true);
         UpperZIGZAG2 = getPreviousZIGZAGValue(_SYMBOL, _TIMEFRAME, true);
         UpperZIGZAGTime1 = getLastZIGZAGTime(_SYMBOL, _TIMEFRAME, true);
         UpperZIGZAGTime2 = getPreviousZIGZAGTime(_SYMBOL, _TIMEFRAME, true);
         LowerZIGZAG1 = getLastZIGZAGValue(_SYMBOL, _TIMEFRAME, false);
         LowerZIGZAG2 = getPreviousZIGZAGValue(_SYMBOL, _TIMEFRAME, false);
         LowerZIGZAGTime1 = getLastZIGZAGTime(_SYMBOL, _TIMEFRAME, false);
         LowerZIGZAGTime2 = getPreviousZIGZAGTime(_SYMBOL, _TIMEFRAME, false);
   
         result = LowerZIGZAG1 - 20*Point;

         break;
      }
      case _GET_SHORT_STOPLOSS_PRICE:
      {
         UpperZIGZAG1 = getLastZIGZAGValue(_SYMBOL, _TIMEFRAME, true);
         UpperZIGZAG2 = getPreviousZIGZAGValue(_SYMBOL, _TIMEFRAME, true);
         UpperZIGZAGTime1 = getLastZIGZAGTime(_SYMBOL, _TIMEFRAME, true);
         UpperZIGZAGTime2 = getPreviousZIGZAGTime(_SYMBOL, _TIMEFRAME, true);
         LowerZIGZAG1 = getLastZIGZAGValue(_SYMBOL, _TIMEFRAME, false);
         LowerZIGZAG2 = getPreviousZIGZAGValue(_SYMBOL, _TIMEFRAME, false);
         LowerZIGZAGTime1 = getLastZIGZAGTime(_SYMBOL, _TIMEFRAME, false);
         LowerZIGZAGTime2 = getPreviousZIGZAGTime(_SYMBOL, _TIMEFRAME, false);
   
         result = UpperZIGZAG1 + 20*Point;

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
                  if(getLastFractalTime(_SYMBOL, _TIMEFRAME, true) > OrderOpenTime())
                     if(getLastFractalTime(_SYMBOL, _TIMEFRAME, false) >= OrderOpenTime())
                        result = getLastFractalTime(_SYMBOL, _TIMEFRAME, false);

//                  result = iLow(_SYMBOL, _TIMEFRAME, 1);
               }
               if(OrderType() == OP_SELL)
               {
                  if(getLastFractalTime(_SYMBOL, _TIMEFRAME, false) > OrderOpenTime())
                     if(getLastFractalTime(_SYMBOL, _TIMEFRAME, true) >= OrderOpenTime())
                        result = getLastFractalTime(_SYMBOL, _TIMEFRAME, true);

//                  result = iHigh(_SYMBOL, _TIMEFRAME, 1);
               }
            }
         }
         
         break;
      }      
      case _OPEN_PENDING_BUY_STOP:
      {
         break;
      }
      case _OPEN_PENDING_SELL_STOP:
      {
         break;
      }
      case _GET_PENDING_BUY_STOP_PRICE:
      {
         break;
      }
      case _GET_PENDING_SELL_STOP_PRICE:
      {
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
      case _GET_PENDING_ORDER_EXPIRATION:
      {
         break;
      }
   }
      
   return(result);
}
//------------------------------------------------------------------//------------------------------------------------------------------
double Strategy_024(int COMMAND)
{
   string   _SYMBOL        = Symbol();
   int      _TIMEFRAME     = getStrategyTimeframeByNumber(_STRATEGY_TIMEFRAME);
         
   double   result         = 0;
   
   double   TLR1, TLR2, TLR12, TLR22;
   double   MacdDiff1, MacdDiff0;
      
   int      i;

   switch(COMMAND)
   {
      case _OPEN_LONG:
      {
//         break;

         if(!OpenNewBar(_TIMEFRAME))
            break;

         MacdDiff1 = iCustom(_SYMBOL, PERIOD_D1, "MACD+HistogramDiff+SignalDiff", 12, 26, 9, 2, 1);   
         MacdDiff0 = iCustom(_SYMBOL, PERIOD_D1, "MACD+HistogramDiff+SignalDiff", 12, 26, 9, 2, 0);   

         TLR1=iCustom(_SYMBOL, _TIMEFRAME ,"TrendLinearReg",34,0,1);
         TLR12=iCustom(_SYMBOL, _TIMEFRAME ,"TrendLinearReg",34,0,2);

         if(TLR1 > 1) break;
         if(TLR12 > 1) TLR12 = 0;

         if(MacdDiff1 > 0)
         if(MacdDiff0 < 0)
         if(MacdDiff0 < MacdDiff1)
         if(TLR1 > TLR12)
            result = 1;

         break;
      }
      case _OPEN_SHORT:
      {
//         break;

         if(!OpenNewBar(_TIMEFRAME))
            break;

         MacdDiff1 = iCustom(_SYMBOL, PERIOD_D1, "MACD+HistogramDiff+SignalDiff", 12, 26, 9, 2, 1);   
         MacdDiff0 = iCustom(_SYMBOL, PERIOD_D1, "MACD+HistogramDiff+SignalDiff", 12, 26, 9, 2, 0);   

         TLR2=iCustom(_SYMBOL, _TIMEFRAME ,"TrendLinearReg",34,1,1);
         TLR22=iCustom(_SYMBOL, _TIMEFRAME ,"TrendLinearReg",34,1,2);

         if(TLR2 > 1) break;
         if(TLR22 > 1) TLR22 = 0;

         if(MacdDiff1 < 0)
         if(MacdDiff0 > 0)
         if(MacdDiff0 > MacdDiff1)
         if(TLR2 < TLR22)
            result = 1;

         break;
      }
      case _CLOSE_LONG:
      {
//         break;

         if(!OpenNewBar(_TIMEFRAME))
            break;

         TLR1=iCustom(_SYMBOL, _TIMEFRAME ,"TrendLinearReg",34,0,1);

         if(TLR1 > 1)
            result = 1;
            
         break;
      }
      case _CLOSE_SHORT:
      {
//         break;

         if(!OpenNewBar(_TIMEFRAME))
            break;

         TLR2=iCustom(_SYMBOL, _TIMEFRAME ,"TrendLinearReg",34,1,1);

         if(TLR2 > 1)
            result = 1;

         break;
      }
      case _GET_LONG_STOPLOSS_PRICE:
      {

         break;
      }
      case _GET_SHORT_STOPLOSS_PRICE:
      {

         break;
      }
      case _GET_TRAILED_STOPLOSS_PRICE:
      {
         break;
      }      
      case _OPEN_PENDING_BUY_STOP:
      {
         break;
      }
      case _OPEN_PENDING_SELL_STOP:
      {
         break;
      }
      case _GET_PENDING_BUY_STOP_PRICE:
      {
         break;
      }
      case _GET_PENDING_SELL_STOP_PRICE:
      {
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
      case _GET_PENDING_ORDER_EXPIRATION:
      {
         break;
      }
   }
      
   return(result);
}


        
