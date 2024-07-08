//+------------------------------------------------------------------+
//|                                              110.DojiTrader1.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                  DojiTrader.mq4  |
//|                                                      Alex        |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Alex"
#property link      ""

//---- input parameters
extern double     Lots              =0.1;
extern double     MaximumRisk       =0.02;
extern double     DecreaseFactor    =3;
extern int        Target=15;
extern int        TimeOpen          =0;
extern int        TimeClose         =23;


int MagicNumber = 89354658;
string MagicName = "DojiTrader";

int      dBar; //dodji bar index
double   dHigh; //dodji bar high
double   dLow; //dodji bar low

int      eDirection = 0; //direction
double   ePrice; //entry price


double LotsOptimized()
  {
   double lot=Lots;
   int    orders=HistoryTotal();     // history orders total
   int    losses=0;                  // number of losses orders without a break
   lot=NormalizeDouble(AccountFreeMargin()*MaximumRisk/1000.0,1);
   if(DecreaseFactor>0)
     {
      for(int i=orders-1;i>=0;i--)
        {
         if(OrderSelect(i,SELECT_BY_POS,MODE_HISTORY)==false) { Print("Error in history!"); break; }
         if(OrderSymbol()!=Symbol() || OrderType()>OP_SELL) continue;
         if(OrderProfit()>0) break;
         if(OrderProfit()<0) losses++;
        }
      if(losses>1) lot=NormalizeDouble(lot-lot*losses/DecreaseFactor,1);
     }
   if(lot<0.1) lot=0.1;
   return(lot);
   }

//+------------------------------------------------------------------+
//| expert initialization function                                   |
//+------------------------------------------------------------------+
int init()
  {
//---- 
   
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| expert deinitialization function                                 |
//+------------------------------------------------------------------+
int deinit()
  {
//---- 
   
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| expert start function                                            |
//+------------------------------------------------------------------+
int start()
  {
//----            
   int orders = 0;
   int i = 0;

   //check if we have a current order, if we do select it
   for(i = 0; i < OrdersTotal(); i++ ){
      OrderSelect(i,SELECT_BY_POS);
      if( OrderMagicNumber() == MagicNumber && OrderSymbol() == Symbol()){
         orders ++;
         break;
      }
   }
   
   //check for open order
   if(orders > 0){
      if(eDirection == 1){
         //if last candle closed below the doji low
         if(Close[1] < dLow){
            OrderClose(OrderTicket(),OrderLots(),Bid,5,White);
         }
      }
      if(eDirection == -1){
         //if last candle closed higher then doji high
         if(Close[1] > dHigh){
            OrderClose(OrderTicket(),OrderLots(),Ask,5,White);
         }
      }
   }
   
   //trade EU and US sessions only
   if(Hour() < TimeOpen || Hour() >= TimeClose) return(0);

   //check that we don't already have an order going
   if(orders < 1){
   
      for(i = 1; i < Bars; i++ ){
         // if we got a doji then save the high and low
         if(Open[i] == Close[i]){
            dHigh = High[i];
            dLow = Low[i];
            dBar = i;
            break;
         }    
      }
   
      //if we had a doji within the last 3 Bars
      if(dBar < 4 && dBar > 1){      

         //did we already determine the direction/entry price?
         if(eDirection == 0){      
            //if last candle closed higher than the doji high, long is our direction
            if(Close[1] > dHigh){
               eDirection = 1;
               ePrice = Close[1];  
            }
            if(Close[1] < dLow){
               eDirection = -1;
               ePrice = Close[1];  
            }
         }   
      }
      else{
         eDirection = 0;
      }
   
      if(eDirection == 1 && Ask > ePrice){
         //buy
         OrderSend(Symbol(),OP_BUY,LotsOptimized(),Ask,5,Ask-50*Point,Ask+Target*Point,MagicName,MagicNumber,0,Green);
      }
      if(eDirection == -1 && Bid < ePrice){
         //sell
         OrderSend(Symbol(),OP_SELL,LotsOptimized(),Bid,5,Bid+50*Point,Bid-Target*Point,MagicName,MagicNumber,0,Red);
      }
   }    
      
   PrintComments();
//----
   return(0);
  }

void PrintComments(){
   Comment(
      "------------ Debugger -------------","\n",
      "dBar: ",dBar,"\n",
      "dBar Time: ",TimeHour(Time[dBar]), ":", TimeMinute(Time[dBar]), "\n",
      "Current Time: ",Hour(),":",Minute(),"\n",
      "dHigh: ",dHigh,"\n",
      "dLow: ",dLow,"\n",
      "eDirection: ",eDirection,"\n",            
      "ePrice: ",ePrice,"\n"
   );
}


//+------------------------------------------------------------------+
        
