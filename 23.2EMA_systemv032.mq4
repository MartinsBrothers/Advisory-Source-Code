//+------------------------------------------------------------------+
//|                                           23.2EMA_systemv032.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                              2EMA system-v03.mq4 |
//|                                                     Gerry Sutton |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Greybeard_xlx - Conversion of MQL-II"
#property link      "http://groups.yahoo.com/group/MetaTrader_Experts_and_Indicators/"
//+------------------------------------------------------------------+
//|  External Variables                                              |
//+------------------------------------------------------------------+
extern double mm = -1;
extern double lp = 300;
extern double sp = 30;	 
extern double slip = 5;
extern double Risk = 40;
extern double Lots = 1.0;
extern double TakeProfit = 360;
extern double Stoploss = 50;
extern double TrailingStop = 15;	
double Points;
//----

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int init ()
  {
   Points = MarketInfo (Symbol(), MODE_POINT);
//----
   return(0);
  }
//+------------------------------------------------------------------+ 
   if(Bars<301)
     {
      Print("Not enough Bars");
      return(0);  
     }
   if(TakeProfit<10)
     {
      Print("TakeProfit less than 10");
      return(0);  
     }
//+------------------------------------------------------------------+
//| Setting internal variables for quick access to data              |
//+------------------------------------------------------------------+
int start()
  {
   double b=0; 
   double balance=0;
   double Ilo=0;
   
   balance=AccountBalance();
   b=(5*Points+iATR(NULL,0,4,1)*5.5);

//+------------------------------------------------------------------+
//| Money Management mm=0(lots) mm=-1(Mini) mm=1(full compounding)   |
//+------------------------------------------------------------------+   
   
   if (mm < 0) {
   Ilo = MathCeil(balance*Risk/10000)/10;
        if (Ilo > 100)  {		
        Ilo = 100;		
        }
   } else {
   Ilo = Lots;
   }
   if (mm > 0)
    {
   Ilo = MathCeil(balance*Risk/10000)/10;
    if (Ilo > 1) 
    {
    Ilo = MathCeil(Ilo);
    }
    if (Ilo < 1)
    {
    Ilo = 1;
    }
    if (Ilo > 100) 
    {		
        Ilo = 100;		
        }
}

//----
Comment("   Account  :   ",AccountNumber(),"---",AccountName(), 
"\n","   StopLoss   :   ",b,
"\n","   Lots  :   ",Ilo,);
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
   if(OrdersTotal()<1) 
   {
   if(AccountFreeMargin()<(100*Lots))
        {
         Print("We have no money");
         return(0); 
         }
   
   if((iMA(NULL,0,lp,0,MODE_SMA,PRICE_CLOSE,3)<
      iMA(NULL,0,sp,0,MODE_EMA,PRICE_CLOSE,3)*0.998 &&
         iMA(NULL,0,lp,0,MODE_SMA,PRICE_CLOSE,0)>
         iMA(NULL,0,sp,0,MODE_EMA,PRICE_CLOSE,0)*0.998)&&
         iSAR(NULL,0,0.02,0.2,6)<Open[6] && 
         iSAR(NULL,0,0.02,0.2,0)>Open[0]) 	 
        {
         OrderSend(
         OP_SELL,
         Ilo,
         Bid,
         slip,
         Bid+Stoploss*Points,
         Bid-TakeProfit*Points,
         0,0,
         HotPink); 
         if(GetLastError()==0)Print("Order opened : ",OrderOpenPrice());
         return(0);
      }   
   if((iMA(NULL,0,lp,0,MODE_SMA,PRICE_CLOSE,3)>
      iMA(NULL,0,sp,0,MODE_EMA,PRICE_CLOSE,3)*1.002 &&
      iMA(NULL,0,lp,0,MODE_SMA,PRICE_CLOSE,0)<
      iMA(NULL,0,sp,0,MODE_EMA,PRICE_CLOSE,0)*1.002) && 
      iSAR(NULL,0,0.02,0.2,6)>Open[6] && 
      iSAR(NULL,0,0.02,0.2,0)<Open[0]) 	 
       {
          OrderSend(
          OP_BUY,
          Ilo,
          Ask,
          slip,
          Ask-Stoploss*Points,
          Ask+TakeProfit*Points,
          0,0,
          Lime); 
         if(GetLastError()==0)Print("Order opened : ",OrderOpenPrice());
         return(0); 
        }
        return(0);
       } 
      }
   int cnt=0, total;  
   total=OrdersTotal();
   for(cnt=0;cnt<total;cnt++)
     {
      OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES);
      if(OrderType()<=OP_SELL && 
         OrderSymbol()==Symbol())   
        {
         if(OrderType()==OP_BUY)  
           {
            if(OrderOpenPrice()>OrderStopLoss()&&
            (Bid-OrderOpenPrice()>(Bid-OrderOpenPrice()*0.004)) &&
             iMA(NULL,0,lp,0,MODE_SMA,PRICE_CLOSE,3)<
             iMA(NULL,0,sp,0,MODE_EMA,PRICE_CLOSE,3)*0.998 &&
             iMA(NULL,0,lp,0,MODE_SMA,PRICE_CLOSE,0)>
             iMA(NULL,0,sp,0,MODE_EMA,PRICE_CLOSE,0)*0.9978)
                {
                 OrderClose(
                 OrderTicket(),
                 OrderLots(),
                 Bid,
                 slip,
                 Red); 
                 return(0);
              }
            if(TrailingStop>0) 
              {                
               if(Bid-OrderOpenPrice()>b)
                 {
                  if(OrderStopLoss()<Bid-b)
                    {
                     OrderModify(
                     OrderTicket(),
                     OrderOpenPrice(),
                     Bid-b,OrderTakeProfit(),
                     0,
                     LimeGreen);
                     return(0);
                    }
                 }
              }
           }
         else 
           {
            if(OrderOpenPrice()<OrderStopLoss()&&
            (OrderOpenPrice()-Ask>(OrderOpenPrice()*0.004)) &&
             iMA(NULL,0,lp,0,MODE_SMA,PRICE_CLOSE,3)>
             iMA(NULL,0,sp,0,MODE_EMA,PRICE_CLOSE,3)*0.998 &&
             iMA(NULL,0,lp,0,MODE_SMA,PRICE_CLOSE,0)<
             iMA(NULL,0,sp,0,MODE_EMA,PRICE_CLOSE,0)*0.9978)
                {
               OrderClose(
               OrderTicket(),
               OrderLots(),
               Ask,
               slip,
               Red); 
               return(0); 
              }
            
            if(TrailingStop>0)  
              {                 
               if((OrderOpenPrice()-Ask)>(b))
                 {
                  if(OrderStopLoss()==0.0 || 
                     OrderStopLoss()>(Ask+b))
                    {
                     OrderModify(
                     OrderTicket(),
                     OrderOpenPrice(),
                     Ask+b,OrderTakeProfit(),
                     0,
                     HotPink);
                     return(0);
                    }
                 }
              }
           }
        }
      }
   return(0);
  // }
   
  
 



        
