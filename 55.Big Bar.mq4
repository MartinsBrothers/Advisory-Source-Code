//+------------------------------------------------------------------+
//|                                                   55.Big Bar.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+                           Code generated using FxPro Quant 2.1.4 |
//+------------------------------------------------------------------+
#property strict

#define __STRATEGY_MAGIC 1001000000
#define __SLEEP_AFTER_EXECUTION_FAIL 400

//Input variables
input int _SL_Points = 100;			// SL Points
input double _Lots = 0.1;			// Lots
input int _Candle_Points = 500;			// Candle Points
input int _TP_Points = 200;			// TP Points

//Global declaration
double _Open;
double _Close;
double _Transform;

int init() {

   return(0);
}

int start() {

   
   //Local declaration
   bool _Open_Sell_Position = false;
   bool _Open_Buy_Position = false;
   _Open = iOpen(Symbol(), 0, 1);
   _Close = iClose(Symbol(), 0, 1);
   _Transform = Transform(_Candle_Points, 2);
   if( (((_Open -
    (_Close)) >= _Transform) && 
   (Volume[0] == 1)) && !__isExist( 0, Symbol() ) ) {
      _Open_Sell_Position = _Lots >= MarketInfo( Symbol() ,MODE_MINLOT) && AccountFreeMarginCheck( Symbol(), 1, _Lots) >= 0;
      if( _Open_Sell_Position == true ) _Open_Sell_Position = OrderSend( Symbol(), 1, _Lots, MarketInfo( Symbol(), MODE_BID ), 10, __stopLossValue( Symbol(), 1, MarketInfo( Symbol(), MODE_BID ), _SL_Points ), __takeProfitValue( Symbol(), 1, MarketInfo( Symbol(), MODE_BID ), _TP_Points ), "FxProQuant" + "(" + WindowExpertName() + ") " + "", __STRATEGY_MAGIC + 0 ) >= 0;
      if( _Open_Sell_Position == false ) Sleep(__SLEEP_AFTER_EXECUTION_FAIL); 
   }
   if( (((_Close -
    (_Open)) >= _Transform) && 
   (Volume[0] == 1)) && !__isExist( 0, Symbol() ) ) {
      _Open_Buy_Position = _Lots >= MarketInfo( Symbol() ,MODE_MINLOT) && AccountFreeMarginCheck( Symbol(), 0, _Lots) >= 0;
      if( _Open_Buy_Position == true ) _Open_Buy_Position = OrderSend( Symbol(), 0, _Lots, MarketInfo( Symbol(), MODE_ASK ), 10, __stopLossValue( Symbol(), 0, MarketInfo( Symbol(), MODE_ASK ), _SL_Points ), __takeProfitValue( Symbol(), 0, MarketInfo( Symbol(), MODE_ASK ), _TP_Points ), "FxProQuant" + "(" + WindowExpertName() + ") " + "", __STRATEGY_MAGIC + 0 ) >= 0;
      if( _Open_Buy_Position == false ) Sleep(__SLEEP_AFTER_EXECUTION_FAIL); 
   }

   return(0);
}



bool __selectOrderByMagic(int magic, string symbol)
{
   for(int i = 0; i < OrdersTotal(); i++)
   {
      if(OrderSelect(i, SELECT_BY_POS, MODE_TRADES) && OrderMagicNumber() == __STRATEGY_MAGIC + magic && OrderSymbol() == symbol)
         return(true);
   }
   return(false);
}



bool __isExist(int magic, string symbol)
{
   return(__selectOrderByMagic(magic, symbol));
}



double __takeProfitValue(string symbol,int orderType, double price, double points)
{
   if (points == 0)
      return (0);
   else if (orderType == 0 || orderType == 2 || orderType == 4)
      return ( NormalizeDouble( price + MarketInfo( symbol, MODE_POINT ) * points, (int)MarketInfo( symbol, MODE_DIGITS ) ) );
   else 
      return ( NormalizeDouble( price - MarketInfo( symbol, MODE_POINT ) * points, (int)MarketInfo( symbol, MODE_DIGITS ) ) );
}



double __stopLossValue(string symbol, int orderType, double price, double points)
{
   if (points == 0)
      return (0);
   else if (orderType == 0 || orderType == 2 || orderType == 4)
      return ( NormalizeDouble( price - MarketInfo( symbol, MODE_POINT ) * points, (int)MarketInfo( symbol, MODE_DIGITS ) ) );
   else 
      return ( NormalizeDouble( price + MarketInfo( symbol, MODE_POINT ) * points, (int)MarketInfo( symbol, MODE_DIGITS ) ) );
}



double Transform (double Value, int Transformation)
{
   static double pipSize = 0;   
   if(pipSize == 0) pipSize = Point * (1 + 9 * (Digits == 3 || Digits == 5));

   switch(Transformation)
   { 
      case 0: return(Value/Point);
      case 1: return(Value/pipSize);
      case 2: return(Value*Point);
      case 3: return(Value*pipSize);  
      default: return(0);    
   }
}

        
