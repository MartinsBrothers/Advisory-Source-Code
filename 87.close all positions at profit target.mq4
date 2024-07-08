//+------------------------------------------------------------------+
//|                      87.close all positions at profit target.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
//|$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
//|              Close 
//|   Last Updated 12-12-2006 10:00pm
//|$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#define     NL    "\n" 

extern int    ProfitTarget     = 25;             // closes all orders once Float hits this $ amount
extern bool   CloseAllNow      = false;          // closes all orders now
extern bool   CloseProfitableTradesOnly = false; // closes only profitable trades
extern double ProftableTradeAmount      = 1;     // Only trades above this amount close out
extern bool   ClosePendingOnly = false;          // closes pending orders only
extern bool   UseAlerts        = false;

//+-------------+
//| Custom init |
//|-------------+
int init()
  {

  }

//+----------------+
//| Custom DE-init |
//+----------------+
int deinit()
  {

  }

//+------------------------------------------------------------------------+
//| Closes everything
//+------------------------------------------------------------------------+
void CloseAll()
{
  for(int i=OrdersTotal()-1;i>=0;i--)
 {
    OrderSelect(i, SELECT_BY_POS);
    bool result = false;
        if ( OrderType() == OP_BUY)  result = OrderClose( OrderTicket(), OrderLots(), MarketInfo(OrderSymbol(), MODE_BID), 5, Red );
        if ( OrderType() == OP_SELL)  result = OrderClose( OrderTicket(), OrderLots(), MarketInfo(OrderSymbol(), MODE_ASK), 5, Red );
        if ( OrderType()== OP_BUYSTOP)  result = OrderDelete( OrderTicket() );
        if ( OrderType()== OP_SELLSTOP)  result = OrderDelete( OrderTicket() );
        if (UseAlerts) PlaySound("alert.wav");
 }
  return; 
}
   
//+------------------------------------------------------------------------+
//| cancels all orders that are in profit
//+------------------------------------------------------------------------+
void CloseAllinProfit()
{
  for(int i=OrdersTotal()-1;i>=0;i--)
 {
    OrderSelect(i, SELECT_BY_POS);
    bool result = false;
        if ( OrderType() == OP_BUY && OrderProfit()+OrderSwap()>ProftableTradeAmount)  result = OrderClose( OrderTicket(), OrderLots(), MarketInfo(OrderSymbol(), MODE_BID), 5, Red );
        if ( OrderType() == OP_SELL && OrderProfit()+OrderSwap()>ProftableTradeAmount)  result = OrderClose( OrderTicket(), OrderLots(), MarketInfo(OrderSymbol(), MODE_ASK), 5, Red );
        if (UseAlerts) PlaySound("alert.wav");
 }
  return; 
}

//+------------------------------------------------------------------------+
//| cancels all pending orders 
//+------------------------------------------------------------------------+
void ClosePendingOrdersOnly()
{
  for(int i=OrdersTotal()-1;i>=0;i--)
 {
    OrderSelect(i, SELECT_BY_POS);
    bool result = false;
        if ( OrderType()== OP_BUYSTOP)   result = OrderDelete( OrderTicket() );
        if ( OrderType()== OP_SELLSTOP)  result = OrderDelete( OrderTicket() );
  }
  return; 
  }

//+-----------+
//| Main      |
//+-----------+
int start()
  {
   int      OrdersBUY;
   int      OrdersSELL;
   double   BuyLots, SellLots, BuyProfit, SellProfit;

//+------------------------------------------------------------------+
//  Determine last order price                                       |
//-------------------------------------------------------------------+
      for(int i=0;i<OrdersTotal();i++)
      {
         OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
           if(OrderType()==OP_BUY)  OrdersBUY++;
           if(OrderType()==OP_SELL) OrdersSELL++;
           if(OrderType()==OP_BUY)  BuyLots += OrderLots();
           if(OrderType()==OP_SELL) SellLots += OrderLots();
           if(OrderType() == OP_BUY)  BuyProfit += OrderProfit() + OrderCommission() + OrderSwap();
           if(OrderType() == OP_SELL)  SellProfit += OrderProfit() + OrderCommission() + OrderSwap();
      }               
   
    if(CloseAllNow) CloseAll();
    
    if(CloseProfitableTradesOnly) CloseAllinProfit();
    
    if(BuyProfit+SellProfit >= ProfitTarget) CloseAll(); 

    if(ClosePendingOnly) ClosePendingOrdersOnly();
       
   
   Comment("                            Comments Last Update 12-12-2006 10:00pm", NL,
           "                            Buys    ", OrdersBUY, NL,
           "                            BuyLots        ", BuyLots, NL,
           "                            Sells    ", OrdersSELL, NL,
           "                            SellLots        ", SellLots, NL,
           "                            Balance ", AccountBalance(), NL,
           "                            Equity        ", AccountEquity(), NL,
           "                            Margin              ", AccountMargin(), NL,
           "                            MarginPercent        ", MathRound((AccountEquity()/AccountMargin())*100), NL,
           "                            Current Time is  ",TimeHour(CurTime()),":",TimeMinute(CurTime()),".",TimeSeconds(CurTime()));
 } // start()

 





        
