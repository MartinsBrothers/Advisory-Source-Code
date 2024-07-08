//+------------------------------------------------------------------+
//|                                                    SA_EA_600.mq4 |
//|                                            Copyright © 2013, VGC |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2013, VGC"
#property link      "http://forexforum.bg/viewtopic.php?f=50&t=1352"


extern double MaxDD          = 30;
extern double MM             = 30;

extern string PipeName       = "SA_600";
extern string ServerPairName = "";
extern double BidCorrection  = 0;
extern double AskCorrection  = 0;

extern int    ActionPips     = 2;
extern int    TargetPips     = 5;
extern int    StopPips       = 15;
extern int    VirtualStops   = false;

extern int    ConfirmMS     = 20;
extern int    SleepMS       = 20;
extern int    Slippage      = 1;    
extern int    Magic         = 2013; 


#define PIPE_BASE_NAME     "\\\\.\\pipe\\mt4-"     // MUST tally with client code
#define ERROR_MORE_DATA 234

#import "kernel32.dll"
	int CallNamedPipeW(string pipeName, uchar& outBuffer[], int outBufferSz, uchar& inBuffer[], int inBufferSz, int& bytesRead[], int timeOut);
#import


datetime StartTime=0;
double   MinLots=0.1;
double   MaxLots=0.1;
double   LotStep=0.1;
double   MyPoint=0.0001;

string   MasterPair="";
double   MaxBalance=0;
double   TotalPips=0;
int      TotalTrades=0;
double   EntrySlippage=0;
int      EntryMS=0;
int      OpenErrors=0;


int      LastTicket=0;
double   MasterBid=0;
double   MasterAsk=0;

string   LastQ="";
           
int init()
  {
   Comment("Initialization ...");
   if(StringLen(ServerPairName)>=1)
      MasterPair=ServerPairName;
   else
      MasterPair=Symbol();

   StartTime=0;
   return(0);
  }

int deinit()
  {
   Comment("");
   return(0);
  }

int start()
  {
   double CurrentPips=0;
   string sInfo="";
   if(IsStopped() || !IsConnected())
      return(0);

   if(Digits<=3)
      MyPoint=0.01;
   MinLots=MarketInfo(Symbol(),MODE_MINLOT);
   MaxLots=MarketInfo(Symbol(),MODE_MAXLOT);
   LotStep=MarketInfo(Symbol(),MODE_LOTSTEP);

   if(StartTime<=0)
     {
      MaxBalance=AccountBalance();
      StartTime=TimeLocal();
      TotalPips=0;
      EntrySlippage=0;
      TotalTrades=0;
      EntryMS=0;
      LastTicket=0;
      OpenErrors=0;
     }

   while(!IsStopped())	
     {
      RefreshRates();
      double dBid=Bid;
      double dAsk=Ask;
      int OldTicket=LastTicket;
      LastTicket=0;
      for(int j=OrdersTotal()-1; j>=0; j--) 
          if(OrderSelect(j, SELECT_BY_POS, MODE_TRADES))
            if((OrderSymbol() == Symbol()) && (OrderMagicNumber() == Magic))
              {
               if(OrderType()==OP_BUY)
                  CurrentPips=dBid-OrderOpenPrice();
               else
                  CurrentPips=OrderOpenPrice()-dAsk;
               CurrentPips=CurrentPips/MyPoint;
               LastTicket=OrderTicket();
               if((CurrentPips>=TargetPips || CurrentPips<=-StopPips) && IsTradeContextBusy()==false)
                 {
                  if(OrderType()==OP_BUY)
                     OrderClose(OrderTicket(), OrderLots(), NormalizeDouble(dBid,Digits), Slippage*MyPoint/Point, Blue);
                  else
                     OrderClose(OrderTicket(), OrderLots(), NormalizeDouble(dAsk,Digits), Slippage*MyPoint/Point, Red);
                 }
               else  
               if(VirtualStops==false && OrderStopLoss()<Point && IsTradeContextBusy()==false)
                 {
                  double MinDistance=MarketInfo(Symbol(),MODE_STOPLEVEL)*Point+MyPoint;
                  if(OrderType()==OP_BUY)
                     OrderModify(OrderTicket(),OrderOpenPrice()
                                ,MathMin(OrderOpenPrice()-StopPips*MyPoint,dBid-MinDistance)
                                ,MathMax(OrderOpenPrice()+TargetPips*MyPoint,dAsk+MinDistance),0); 
                  else  
                     OrderModify(OrderTicket(),OrderOpenPrice()
                                ,MathMax(OrderOpenPrice()+StopPips*MyPoint,dAsk+MinDistance)
                                ,MathMin(OrderOpenPrice()-TargetPips*MyPoint,dBid-MinDistance),0); 
                 }

              }

      if(LastTicket==0 && OldTicket>0)
         if(OrderSelect(OldTicket, SELECT_BY_TICKET, MODE_HISTORY))
           {
            if(OrderType()==OP_BUY)
               TotalPips=TotalPips+(OrderClosePrice()-OrderOpenPrice())/MyPoint;
            else
               TotalPips=TotalPips+(OrderOpenPrice()-OrderClosePrice())/MyPoint;
           }

      MaxBalance=MathMax(MaxBalance,AccountBalance());
      if(AccountBalance()<=0)
         break;
      sInfo="";
      CheckMaster();
      if(MaxDD<=100*(MaxBalance-AccountBalance())/MaxBalance)
         sInfo=sInfo+"\nMaximum Drawdawn Reached !!!";
      else   
      if(MasterBid>=Point && MasterAsk>=Point)
         sInfo=sInfo+"\nBuy/Sell Levels: "+DoubleToStr((MasterBid-dAsk)/MyPoint-ActionPips,1)+" / "+DoubleToStr((dBid-MasterAsk)/MyPoint-ActionPips,1)+" pips";
      else
      if(StringLen(LastQ)>0)
         sInfo=sInfo+"\nServer: "+LastQ;
      else
         sInfo=sInfo+"\nServer not working !!!";

      if(LastTicket>0)
         sInfo=sInfo+", Position: "+DoubleToStr(CurrentPips,1)+" pips";
      else
      if(MasterBid>=Point && MasterAsk>=Point && MaxDD>100*(MaxBalance-AccountBalance())/MaxBalance)
        {
         int Oper=-1;
         if((MasterBid-dAsk)/MyPoint>=ActionPips)
            Oper=OP_BUY;
         else
         if((dBid-MasterAsk)/MyPoint>=ActionPips)
            Oper=OP_SELL;
         if(Oper!=-1 && ConfirmMS>0)
           {
            Sleep(ConfirmMS);
            RefreshRates();
            dBid=Bid;
            dAsk=Ask;
            CheckMaster();
            if(Oper==OP_BUY && (MasterBid-dAsk)/MyPoint<ActionPips)
               Oper=-1;
            if(Oper==OP_SELL && (dBid-MasterAsk)/MyPoint<ActionPips)
               Oper=-1;
           }
         if(Oper!=-1 && IsTradeContextBusy()==false)
           {
            double Lots=MathMax(MinLots,MathMin(MaxLots,MathCeil((MM/100)*AccountFreeMargin()/LotStep/(100000/100))*LotStep));
            int ExecutionTime=GetTickCount();
            if(Oper==OP_BUY)
               LastTicket=OrderSend(Symbol(), OP_BUY, Lots, NormalizeDouble(dAsk,Digits), Slippage*MyPoint/Point, 0, 0, "", Magic,0,Blue);
            else   
               LastTicket=OrderSend(Symbol(), OP_SELL, Lots, NormalizeDouble(dBid,Digits), Slippage*MyPoint/Point, 0, 0, "", Magic,0,Red);
            ExecutionTime=GetTickCount()-ExecutionTime;   
            if(LastTicket<0)
              {
               OpenErrors=OpenErrors+1;
              }
            else
              {
               TotalTrades=TotalTrades+1;
               EntryMS=EntryMS+ExecutionTime;
               if(OrderSelect(LastTicket,SELECT_BY_TICKET))
                  if(OrderType()==OP_BUY)
                     EntrySlippage=EntrySlippage+(dAsk-OrderOpenPrice())/MyPoint;
                  else   
                     EntrySlippage=EntrySlippage+(OrderOpenPrice()-dBid)/MyPoint;
              }
           }
        }

      Comment("\nMagic# "+DoubleToStr(Magic,0)+", MM "+DoubleToStr(MM,2)+ ", Max DD: " + DoubleToStr(MaxDD,1)+"%, Current Drawdawn: "+DoubleToStr(100*(MaxBalance-AccountBalance())/MaxBalance,1)+" %"+
              "\nMin Lot "+DoubleToStr(MinLots,2)+", Max Lot "+DoubleToStr(MaxLots,2)+", Lot Step "+DoubleToStr(LotStep,2)+", Stop Level "+DoubleToStr(MarketInfo(Symbol(),MODE_STOPLEVEL)*Point/MyPoint,1)+" pips"+
              "\n"+sInfo+
              "\nStart Time: "+TimeToStr(StartTime,TIME_DATE|TIME_SECONDS)+
              "\nLocal Time: "+TimeToStr(TimeLocal(),TIME_DATE|TIME_SECONDS)+
              "\nTotal Pips: "+DoubleToStr(TotalPips,1)+
              "\nTotal Trades: "+DoubleToStr(TotalTrades,0)+
              "\nEntry Errors: "+DoubleToStr(OpenErrors,0)+
              "\nOpen Slippage: "+DoubleToStr(EntrySlippage,1)+" pips"+
              "\nAverage Speed: "+DoubleToStr(EntryMS/MathMax(TotalTrades,1),0)+" ms"+
              "\nAverage Slippage: "+DoubleToStr(EntrySlippage/MathMax(TotalTrades,1),1)+" pips"
             );
      Sleep(MathMax(SleepMS,10));
      if(IsTesting())
         break;
     }
   return(0);
  }

void CheckMaster()
  {
   MasterBid=0;
   MasterAsk=0;
   LastQ="";
   if(IsTesting())
     {
      MasterBid=NormalizeDouble(MarketInfo(MasterPair,MODE_BID)/2+MarketInfo(MasterPair,MODE_ASK)/2-MyPoint+2*MyPoint*(MathRand()-32767/2)/(32767/6),Digits);
      MasterAsk=MasterBid+2*MyPoint;
     }
   else
     {
      string MyPipeName = PIPE_BASE_NAME+PipeName;
      string extMessage = MasterPair;
      uchar   aextMessage[2048];
      uchar inBuffer[2048];
      int bytesRead[1];
      StringToCharArray(extMessage,aextMessage);
      bool fSuccess = CallNamedPipeW(MyPipeName,aextMessage,StringLen(extMessage)+1,inBuffer,ArraySize(inBuffer),bytesRead,0) != 0;
      int lastError = GetLastError();
      if(fSuccess/* || lastError == ERROR_MORE_DATA*/) 
        { 
         string inString = "";
         for(int i=0; i<bytesRead[0]; i++)
             inString = inString + CharToStr(inBuffer[i]);
         int ai=StringFind(inString, "|", 0);
         if(ai>0)
           {
            MasterBid=StrToDouble(StringSubstr(inString, 0, ai));
            MasterAsk=StrToDouble(StringSubstr(inString, ai+1));
           }
         LastQ=inString;  
        }
     }
   if(MasterBid>0.0001)
      MasterBid=MasterBid+BidCorrection;
   if(MasterAsk>0.0001)
      MasterAsk=MasterAsk+AskCorrection;

  }

