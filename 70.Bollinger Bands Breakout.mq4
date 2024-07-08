//+------------------------------------------------------------------+
//|                                  70.Bollinger Bands Breakout.mq4 |
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
input int _SL_Points = 500;			// SL Points
input double _Lots = 0.1;			// Lots
input int _TP_Points = 500;			// TP Points

//Global declaration
double _Historic_data;
double _Historic_data_1;
bool _Price_cross_BB_downward;
bool _Price_cross_BB_upward;

int init() {

   return(0);
}

int start() {

   
   //Local declaration
   bool _Close_All_Long_Trades = false;
   bool _Close_All_Short_Trades = false;
   bool _Open_Sell_Position = false;
   bool _Open_Buy_Position = false;
   _Historic_data = iClose(Symbol(), 0, 1);
   _Historic_data_1 = iClose(Symbol(), 0, 0);
   _Price_cross_BB_downward = ((_Historic_data >= iBands(Symbol(), 0, 20, 2, 0, 0, 2, 1)) && 
   (_Historic_data_1 < iBands(Symbol(), 0, 20, 2, 0, 0, 2, 0)));
   _Price_cross_BB_upward = ((_Historic_data_1 > iBands(Symbol(), 0, 20, 2, 0, 0, 1, 0)) && 
   (_Historic_data <= iBands(Symbol(), 0, 20, 2, 0, 0, 1, 1)));
   if( _Price_cross_BB_downward ) _Close_All_Long_Trades = Close_All_Long_Trades(0);
   if( _Price_cross_BB_upward ) _Close_All_Short_Trades = Close_All_Short_Trades(0);
   if( _Price_cross_BB_downward && !__isExist( 0, Symbol() ) ) {
      _Open_Sell_Position = _Lots >= MarketInfo( Symbol() ,MODE_MINLOT) && AccountFreeMarginCheck( Symbol(), 1, _Lots) >= 0;
      if( _Open_Sell_Position == true ) _Open_Sell_Position = OrderSend( Symbol(), 1, _Lots, MarketInfo( Symbol(), MODE_BID ), 10, __stopLossValue( Symbol(), 1, MarketInfo( Symbol(), MODE_BID ), _SL_Points ), __takeProfitValue( Symbol(), 1, MarketInfo( Symbol(), MODE_BID ), _TP_Points ), "FxProQuant" + "(" + WindowExpertName() + ") " + "", __STRATEGY_MAGIC + 0 ) >= 0;
      if( _Open_Sell_Position == false ) Sleep(__SLEEP_AFTER_EXECUTION_FAIL); 
   }
   if( _Price_cross_BB_upward && !__isExist( 0, Symbol() ) ) {
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



bool Close_All_Long_Trades(int MagicIndex)
{
   int total = OrdersTotal();
   bool result = true;

   for(int i=total-1;i>=0;i--)
   {
      if(!OrderSelect(i, SELECT_BY_POS)) continue;
      if(OrderMagicNumber() != __STRATEGY_MAGIC + MagicIndex || OrderSymbol() != Symbol()) continue;
      if(OrderType() != OP_BUY) continue;
      if(!OrderClose( OrderTicket(), OrderLots(), MarketInfo(OrderSymbol(), MODE_BID), 5, Red )){
         result = false;
         Sleep(__SLEEP_AFTER_EXECUTION_FAIL);
      }
   }
   return(result);
}


bool Close_All_Short_Trades(int MagicIndex)
{
   int total = OrdersTotal();
   bool result = true;

   for(int i=total-1;i>=0;i--)
   {
      if(!OrderSelect(i, SELECT_BY_POS)) continue;
      if(OrderMagicNumber() != __STRATEGY_MAGIC + MagicIndex || OrderSymbol() != Symbol()) continue;
      if(OrderType() != OP_SELL) continue;
      if(!OrderClose( OrderTicket(), OrderLots(), MarketInfo(OrderSymbol(), MODE_ASK), 5, Red )){
         result = false;
         Sleep(__SLEEP_AFTER_EXECUTION_FAIL);
      }
   }
   return(result);
}

        
