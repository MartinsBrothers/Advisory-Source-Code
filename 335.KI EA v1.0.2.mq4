//+------------------------------------------------------------------+
//|                                                    KI TESTER.mq4 |
//|                                                      Nicholishen |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Nicholishen @ Apex Group Investments,LLC"
#property link      "www.forex-tsd.com"

#include <stdlib.mqh>
#include <WinUser32.mqh>
   extern int Confirm=1;
   extern int length1=3,length2=10,length3=16;
   
   extern double lots=0.1;            
   extern int TakeProfit=0;             
   extern int StopLoss=0;            
   extern bool UseTrail    = true; 
   
   extern double  TrailingAct   = 10;    
   extern double  TrailingStep   = 40;  

   extern bool UseADX=false;
   extern double ADXthresh=30;
   extern bool UseTimeFilter=false;
   extern int BeginHour=8;
   extern int EndHour=18;
   extern bool Reverse=false;
  
   int bar;
   int TestStart;
   int k;
   int mm,dd,yy,hh,min,ss,tf;
   string comment;
   string syym;
   string qwerty;
   int OrderID;
   extern int ID_Base=340000;
   double TrailPrice;
//+------------------------------------------------------------------+
//| expert initialization function                                   |
//+------------------------------------------------------------------+
int init()
  {
//----
   OrderID=ID_Base+Period();
   Comment ( "Last signal = ",lastsig());
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


int TimeFilter(){
   if(Hour()>EndHour || Hour()<BeginHour){
      return(1);
   }
   return(0);
}
//+------------------------------------------------------------------+
// Calculates Current Orders on TF,Pair,EA
//+------------------------------------------------------------------+

int CalculateCurrentOrders(){
   int orders=0;
   
   for(int i=0;i<OrdersTotal();i++){
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)){
         if(OrderSymbol()==Symbol() && OrderMagicNumber()==OrderID ){
            orders++;
         }
      }
   }
   
   return(orders);
}

double signal(int p,int x){
   int l1=length1,l2=length2,l3=length3;
   double
   sig=NormalizeDouble(iCustom(NULL,0,"KI_signals_v2",l1,l2,l3,p,x),4);
   //dnsig=NormalizeDouble(iCustom(NULL,0,"KI_signals_v2",3,10,16,3,n),4);
   
   
   if(sig>0 && sig<100)return(sig);
   
   return(0);
}
  
double lastsig(){
static double lst;
   for(int i=100;i>=0;i--){
      if(signal(2,i)>0)lst = signal(2,i);
      if(signal(3,i)>0)lst = signal(3,i);
   }
return(lst);
}

int TradeSignal(int f){

   double adxsig= iADX(NULL,0,14,0,MODE_MAIN,0);
   
   int x = Confirm;
 
      if(UseADX){
         if(adxsig>ADXthresh){   
            bool ADX=true;
         }else{
            ADX=false;
         }
      }else{
         ADX=true;
      }
         
      if(signal(2,x)>0 && ADX){
         if(Reverse){
            return(2);
         }else{
            return(1);
         }
      }
      if(signal(3,x)>0 && ADX){
         if(Reverse){
            return(1);
         }else{
            return(2);
         }
      }
  
   return(0);
}

//+------------------------------------------------------------------+
//| Open Conditions                       |
//+------------------------------------------------------------------+

void CheckForOpen(){
double sl,tp; int res,error;

  if(TradeSignal(1)==2){
      if (StopLoss==0) {sl=0;} else sl=Bid+Point*StopLoss;
      if (TakeProfit==0) {tp=0;} else tp=Bid-Point*TakeProfit;
     
      res = OrderSend(Symbol(),OP_SELL,lots,Bid,3,sl,tp,"D2",OrderID,0,Blue); // def
      if(res<0){
         error=GetLastError();
         Print("Error = ",ErrorDescription(error));
      }
  }
  if(TradeSignal(1)==1){
      if (StopLoss==0) {sl=0;} else sl=Ask-Point*StopLoss;
      if (TakeProfit==0) {tp=0;} else tp=Ask+Point*TakeProfit;
     
      res = OrderSend(Symbol(),OP_BUY,lots,Ask,3,sl,tp,"D2",OrderID,0,Red); // def
      if(res<0){
         error=GetLastError();
         Print("Error = ",ErrorDescription(error));
      }
  }
}   
  
//+------------------------------------------------------------------+
//| Close conditions                      |
//+------------------------------------------------------------------+
void CheckForClose(){

   for(int i=0;i<OrdersTotal();i++){
      OrderSelect(i,SELECT_BY_POS,MODE_TRADES);    
      if (OrderType()==OP_BUY && OrderMagicNumber()==OrderID && Symbol()==OrderSymbol()){
         if (TradeSignal(2)==2) {                          // MA SELL signals
            int res = OrderClose(OrderTicket(),OrderLots(),Bid,3,White); // close 
            TrailPrice=0;
            if(res<0){
               int error=GetLastError();
               Print("Error = ",ErrorDescription(error));
            }
         }     
      } 
      if (OrderType()==OP_SELL && OrderMagicNumber()==OrderID && Symbol()==OrderSymbol() ){
         if (TradeSignal(2)==1) {                          // MA BUY signals
            res = OrderClose(OrderTicket(),OrderLots(),Ask,3,White); // close 
            TrailPrice=0;
            if(res<0){
               error=GetLastError();
               Print("Error = ",ErrorDescription(error));
            }
         }     
      }  
   }    
}
void TrailingPositions() {
   for (int i=0; i<OrdersTotal(); i++) {
      if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES)) {
         if (OrderSymbol()==Symbol()&& OrderMagicNumber()==OrderID ) {
            if (OrderType()==OP_SELL) {
               if (OrderOpenPrice()-Ask>TrailingAct*Point && TrailPrice ==0) {
                  TrailPrice=Ask+TrailingStep*Point;
                  Print("TRAIL PRICE SET: ",TrailPrice);
                  if(TrailingStep > 8){
                     ModifyStopLoss(TrailPrice);
                  }
               }
               if (TrailPrice!=0 && Ask+TrailingStep*Point < TrailPrice  ){
                  TrailPrice=Ask-TrailingStep*Point;
                  Print("TRAIL PRICE MODIFIED: ",TrailPrice);
                  if(TrailingStep > 8){
                     ModifyStopLoss(TrailPrice);
                  }
               }
               if (TrailPrice != 0 && Ask >= TrailPrice ){
                  CloseOrder(2);
               }
            }
            if  (OrderType()==OP_BUY) {
               if (Bid-OrderOpenPrice() > TrailingAct*Point && TrailPrice ==0) {
                  TrailPrice=Bid-TrailingStep*Point;
                  Print("TRAIL PRICE MODIFIED: ",TrailPrice);
                  if(TrailingStep > 8){
                     ModifyStopLoss(TrailPrice);
                  }
               }
               if (TrailPrice!= 0 && Bid-TrailingStep*Point > TrailPrice ){
                  TrailPrice=Bid-TrailingStep*Point;
                  Print("TRAIL PRICE MODIFIED: ",TrailPrice);
                  if(TrailingStep > 8){
                     ModifyStopLoss(TrailPrice);
                  }
               }
               if (TrailPrice != 0 && Bid <= TrailPrice ){
                  CloseOrder(1);
               }   
            }
         }
      }
   }
}
void ModifyStopLoss(double ldStop) {
  bool   fm;
  double ldOpen=OrderOpenPrice();
  double ldTake=OrderTakeProfit();

  fm=OrderModify(OrderTicket(), ldOpen, ldStop, ldTake, 0, Pink);
  
}
void CloseOrder(int ord){
    for(int i=0;i<OrdersTotal();i++){
      OrderSelect(i,SELECT_BY_POS,MODE_TRADES);    
      if (OrderType()==OP_BUY && OrderMagicNumber()==OrderID && OrderSymbol()==Symbol() ){
         if (ord==1){
         int res = OrderClose(OrderTicket(),OrderLots(),Bid,3,White); // close 
         TrailPrice=0;
         if(res<0){
            int error=GetLastError();
            Print("Error = ",ErrorDescription(error));
         }
      }}     
      
      if (OrderType()==OP_SELL && OrderMagicNumber()==OrderID && OrderSymbol()==Symbol() ){
         if (ord==2) {                          // MA BUY signals
            res = OrderClose(OrderTicket(),OrderLots(),Ask,3,White); // close 
            TrailPrice=0;
            if(res<0){
               error=GetLastError();
               Print("Error = ",ErrorDescription(error));
            }
         }     
      }  
   }    
 }  

int start(){
   

   if(Bars<100 || IsTradeAllowed()==false) return;

   if(CalculateCurrentOrders()==0) {
      TrailPrice=0;
      if(UseTimeFilter && TimeFilter()==1)return;
      CheckForOpen();
   }else{
      CheckForClose();
   }

   if(UseTrail){TrailingPositions();}
 //  if(UseEmailAlerts){MailAlert();}
   
   return(0);
}  
//------------------------------------------------------------+
        
