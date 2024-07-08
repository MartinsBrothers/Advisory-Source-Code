//+------------------------------------------------------------------+
//|                                              104.Daily Scalp.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| DailyScalp.mq4 |
//|  |
//| 
//+------------------------------------------------------------------+
#property copyright "borrowed some code from mpfx"
#property link "http://www.stideas.com"

extern double TakeProfit = 30;
extern double Lots = 1;
extern double TrailingStop = 99;
extern double Stoploss = 17;
extern double Pips = 16;
extern double Perc = 5;

double Points;
int init ()
{
  Points = MarketInfo (Symbol(), MODE_POINT);
  //----
  return(0);
}
//+------------------------------------------------------------------+
//| |
//+------------------------------------------------------------------+
int deinit()
{
  return(0);
}
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//| expert start function |
//+------------------------------------------------------------------+
int start()
{
  double Levv=0;
  int cnt=0, total;

  if(Bars<10)
  {
    Print("bars less than 100");
    return(0);
  }  
  if(OrdersTotal()<1)
  {
    if(AccountFreeMargin()<(1*Lots))
    {
      Print("BrokeAsAJoke");
      return(0);
    }
    Levv= AccountEquity()*(Perc/100/100)/10;
    

    // (BUY)
    if (Close[1]>Close[2])
    {
      OrderSend(OP_BUY,Levv,Ask,3,Bid-Stoploss*Points,Ask+TakeProfit,0,0,Red);
      return(0);
    }
    if (Close[1]>Close[2])
    {
      OrderSend(OP_BUY,Levv,Ask,3,Bid-Stoploss*Points,Ask+TakeProfit,0,0,Red);
      return(0);
    }
    // (SELL)
    if (Close[1]<Close[2])
    {
      OrderSend(OP_SELL,Levv,Bid,3,Ask+Stoploss*Points,Bid-TakeProfit,0,0,Red);
      return(0);
    }
    if (Close[1]<Close[2])
    {
      OrderSend(OP_SELL,Levv,Bid,3,Ask+Stoploss*Points,Bid-TakeProfit,0,0,Red);
      return(0);
    }
    return(0);
  }

  total=OrdersTotal();
  for(cnt=0;cnt<OrdersTotal();cnt++)
  {
    OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES);
    if(OrderType()<=OP_SELL && OrderSymbol()==Symbol())
    {
      if(OrderType()==OP_BUY)
      {
        if(OrderOpenTime() - (CurTime() >= 86400)) //1 Day//
        {
          OrderClose(OrderTicket(),OrderLots(),Ask,3,Violet);
          return(0);
        }
      }
    }
  }

  total=OrdersTotal();
  for(cnt=0;cnt<OrdersTotal();cnt++)
  {
    OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES);
    if(OrderType()<=OP_BUY && OrderSymbol()==Symbol())
    {
      if(OrderType()==OP_SELL)
      {
        if (OrderOpenTime() - (CurTime() >= 86400)) //1 Day//
        {
          OrderClose(OrderTicket(),OrderLots(),Bid,3,Violet);
          return(0);
        }
      }
    }
  }
}
        
