//+------------------------------------------------------------------+
//|                                           28.Adenan Scalping.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                           Amazing.mq5 |
//|                                                    Andriy Moraru |
//|                                         http://www.earnforex.com |
//|                                                               2010-2012 |
//+------------------------------------------------------------------+
#property copyright "www.EarnForex.com, 2010-2012"
#property link      "http://www.earnforex.com"
#property version   "1.2"

// Change log:
// 1.1 - Fixed .Type() function calls.
//       Variable err removed.        
// 1.2 - Fixed various Invalid Stops errors.        
 
#property description "Amazing - EA that helps to trade on news."
#property description "Set the NDay, NHour and NMin input parameters to the actual"
#property description "date and time of the news. EA will set up the pending orders"
#property description "(buy and sell) to be triggered by the news. It will use profit target"
#property description "and trailing stop to get the most out of it."

#include <Trade/Trade.mqh>
#include <Trade/PositionInfo.mqh>
#include <Trade/OrderInfo.mqh>

//Pips
input int TP           = 20; // Exact amount of the pips for profit
input int BEPips       = 0;  // Profit of Break Even. EA will move SL to break-even + 1 pip after this amount of pips of profit is reached.
input int TrailingStop = 0;

//Days
input int NDay  = 0;      // News Day (of the month)
input int NHour = 0;      // News Hour
input int NMin  = 0;      // News Minute

//Candles
input int CTCBN = 0;    // Number of Candles To Check Before News for determining High & Lows. Plus the current candle.

//Seconds
input int SecBPO = 300; // Seconds Before news to place the Pending Orders
input int SecBMO = 0;      // Seconds Before news to stop Modifying the pending Orders
input int STWAN  = 150; // Seconds To Wait After News to delete pending orders

//Miscellaneous
input bool OCO = true;         // One Cancels the Other. If true, will cancel the other pending order if one of them is triggered.
input bool MM  = true;      // Use Money Management
input int RiskPercent = 3; // Perecentage of the free margin to risk with each trade. Active if MM = true.
input double Lots = 0.1;     // Positions size if MM = false
input int Slippage = 10;     // Tolerated slippage in pips

//Text Strings
input string TradeLog       = "AmazingLog";
input string OrderComment = "AmazingEA";

double H, L;                     //High & Low
double HO, LO;                 //Open Prices for Buy & Sell
double HSL, LSL, HTP, LTP; //Stop Loss and Take Profit levels for Buy & Sell
double spread;

string filename;
int Magic;
int Deviation;

double Poin; // Adapted point value

//Main position class
CTrade *Trade;
CPositionInfo PositionInfo;
COrderInfo OrderInfo;
//+------------------------------------------------------------------+
//| Expert Initialization Function                                   |
//+------------------------------------------------------------------+
void OnInit()
{
   //Checking for unconvetional Point digits number
   if ((_Point == 0.00001) || (_Point == 0.001))
   {
      Poin = _Point * 10;
      Deviation = Slippage * 10;
   }
   else
   {
      Poin = _Point; //Normal
      Deviation = Slippage;
   }
   
   Magic = NDay + NHour + NMin; //Unique EA identifier
   MqlDateTime dt;
   TimeCurrent(dt);
   filename = _Symbol + TradeLog + "-" + IntegerToString(dt.mon) + "-" + IntegerToString(dt.day) + ".txt";
   Print(filename);

    //Initialize the Trade class object
    Trade = new CTrade;
    Trade.SetDeviationInPoints(Deviation);
    Trade.SetExpertMagicNumber(Magic);
}

//+------------------------------------------------------------------+
//| Expert Deinitialization Function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
    Comment("");
    delete Trade;
}

//+------------------------------------------------------------------+
//| Calculate Position Size Depending on Money Management                |
//+------------------------------------------------------------------+
double LotsOptimized()
{
   double lot;

   if (MM) lot = NormalizeDouble(MathFloor(AccountInfoDouble(ACCOUNT_FREEMARGIN) * RiskPercent / 100) / 100, 1);
   else       lot = Lots;
   
    //Returns number in standard Forex lots
   return(lot);
} 

//+------------------------------------------------------------------+
//| Check for Pending Stop Orders and Open Position                        |
//+------------------------------------------------------------------+
int CheckOrdersCondition()
{
    int result = 0;

    //First deal with the Orders
    int ot = OrdersTotal();
    for (int i = 0; i < ot; i++)
    {
        OrderSelect(OrderGetTicket(i));
        if ((OrderInfo.Symbol() == _Symbol) && (OrderInfo.Magic() == Magic) && (OrderInfo.OrderType() == ORDER_TYPE_BUY_STOP))
        {
            result = result + 10;
        }
        else if ((OrderInfo.Symbol() == _Symbol) && (OrderInfo.Magic() == Magic) && (OrderInfo.OrderType() == ORDER_TYPE_SELL_STOP))
        {
            result = result + 1;
        }
    }

    //Now deal with the positions
    if (PositionInfo.Select(_Symbol))
    {
        if (PositionInfo.PositionType() == POSITION_TYPE_BUY)
        {
            result = result + 1000;
        }
        else if (PositionInfo.PositionType() == POSITION_TYPE_SELL)
        { 
            result = result + 100;
        }
    }
    return(result); // 0 means there are no orders/positions
}
//   Result Pattern
//    1    1    1    1
//    |    |     |        |
//        |      |     |        -------- Sell Stop Order
//    |    |    --------Buy Stop Order
//        |      --------Sell Position
//        --------Buy Position
  
//+------------------------------------------------------------------+
//| Open Buy Stop Pending Order                                                    |
//+------------------------------------------------------------------+
void OpenBuyStop()
{
    ulong ticket, tries;
    tries = 0;
    if (!GlobalVariableCheck("InTrade")) // (semaphore check)
    {
        while (tries < 3)
        {
            GlobalVariableSet("InTrade", TimeCurrent());  // Set lock indicator (semaphore set)
            Trade.OrderOpen(_Symbol, ORDER_TYPE_BUY_STOP, LotsOptimized(), 0, HO, HSL, HTP, 0, 0, OrderComment);
            ticket = Trade.ResultOrder(); // Get ticket
            Write("in function OpenBuyStop OrderSend Executed , ticket =" + IntegerToString(ticket));
            GlobalVariableDel("InTrade");   // Clear lock indicator (semaphore del)
            if (ticket <= 0)
            {
                Write("Error Accured : " + ErrorDescription(GetLastError()) + " BuyStop @ " + DoubleToString(HO, _Digits) + " SL @ " + DoubleToString(HSL, _Digits) + " TP @ " + DoubleToString(HTP, _Digits));
                tries++;
            }
            else tries = 3;
        }
    }
}
  
//+------------------------------------------------------------------+
//| Open Sell Stop Pending Order                                                    |
//+------------------------------------------------------------------+
void OpenSellStop()
{
    ulong ticket, tries;
    tries = 0;
    if (!GlobalVariableCheck("InTrade")) // (semaphore check)
    {
        while (tries < 3)
        {
            GlobalVariableSet("InTrade", TimeCurrent());  // Set lock indicator (semaphore set)
            Trade.OrderOpen(_Symbol, ORDER_TYPE_SELL_STOP, LotsOptimized(), 0, LO, LSL, LTP, 0, 0, OrderComment);
            ticket = Trade.ResultOrder(); // Get ticket
            Write("in function OpenSellStop OrderSend Executed , ticket =" + IntegerToString(ticket));
            GlobalVariableDel("InTrade");   // Clear lock indicator (semaphore del)
            if (ticket <= 0)
            {
                Write("Error Accured : " + ErrorDescription(GetLastError()) + " SellStop @ " + DoubleToString(LO, _Digits) + " SL @ " + DoubleToString(LSL, _Digits) + " TP @ " + DoubleToString(LTP, _Digits));
                tries++;
            }
            else tries = 3;
        }
    }
}
 
//+------------------------------------------------------------------+
//| Move Position SL to Break Even if Needed                                    |
//+------------------------------------------------------------------+
void DoBE(int byPips)
{
    double Ask = SymbolInfoDouble(Symbol(), SYMBOL_ASK);
    double Bid = SymbolInfoDouble(Symbol(), SYMBOL_BID);
    double NewSL;
    PositionInfo.Select(_Symbol);
    if       ((PositionInfo.PositionType() == POSITION_TYPE_BUY) && (Bid - PositionInfo.PriceOpen() > byPips * Poin) && (PositionInfo.StopLoss() < PositionInfo.PriceOpen()))
    {
        NewSL = PositionInfo.PriceOpen() + Poin;
        if (Bid - NewSL > SymbolInfoInteger(Symbol(), SYMBOL_TRADE_STOPS_LEVEL) * _Point)
        {
           Write("Moving StopLoss of Buy Order to BreakEven+1.");
           Trade.PositionModify(_Symbol, NewSL, PositionInfo.TakeProfit());
        }
    }
    else if ((PositionInfo.PositionType() == POSITION_TYPE_SELL) && (PositionInfo.PriceOpen() - Ask > byPips * Poin) && (PositionInfo.StopLoss() > PositionInfo.PriceOpen()))
    { 
        NewSL = PositionInfo.PriceOpen() - Poin;
        if (NewSL - Ask > SymbolInfoInteger(Symbol(), SYMBOL_TRADE_STOPS_LEVEL) * _Point)
        {
           Write("Moving StopLoss of Sell Order to BreakEven+1.");
           Trade.PositionModify(_Symbol, NewSL, PositionInfo.TakeProfit());
        }
    }
}

//+------------------------------------------------------------------+
//| Move Trailing Stop if Needed                                                    |
//+------------------------------------------------------------------+
void DoTrail()
{
   double Ask = SymbolInfoDouble(Symbol(), SYMBOL_ASK);
    double Bid = SymbolInfoDouble(Symbol(), SYMBOL_BID);
    double NewSL;

    if (PositionInfo.Select(_Symbol))
    {
       if       ((PositionInfo.PositionType() == POSITION_TYPE_BUY) && (Bid - PositionInfo.PriceOpen() > TrailingStop * Poin) && (PositionInfo.StopLoss() < NormalizeDouble(Bid - TrailingStop * Poin, _Digits)))
       {
           NewSL = Bid - TrailingStop * Poin;
           if (Bid - NewSL > SymbolInfoInteger(Symbol(), SYMBOL_TRADE_STOPS_LEVEL) * _Point)
           {
               Trade.PositionModify(_Symbol, NewSL, PositionInfo.TakeProfit());
           }
         }
       else if ((PositionInfo.PositionType() == POSITION_TYPE_SELL) && (PositionInfo.PriceOpen() - Ask > TrailingStop * Poin) && ((PositionInfo.StopLoss() > NormalizeDouble(Ask + TrailingStop * Poin, _Digits)) || (PositionInfo.StopLoss() == 0)))
       {
           NewSL = Ask + TrailingStop * Poin;
           if (NewSL - Ask > SymbolInfoInteger(Symbol(), SYMBOL_TRADE_STOPS_LEVEL) * _Point)
           {
               Trade.PositionModify(_Symbol, NewSL, PositionInfo.TakeProfit());
           }
         }
   }
}

//+------------------------------------------------------------------+
//| Delete Pending Buy Stop Order                                                |
//+------------------------------------------------------------------+
void DeleteBuyStop()
{
    int ot = OrdersTotal();
    for (int i = 0; i < ot; i++)
    {
        ulong ticket = OrderGetTicket(i);
        if (OrderInfo.Select(ticket))
        {
           if ((OrderInfo.Symbol() == _Symbol) && (OrderInfo.Magic() == Magic) && (OrderInfo.OrderType() == ORDER_TYPE_BUY_STOP))
           {
               Trade.OrderDelete(ticket);
               Write("in function DeleteBuyStopOrderDelete Executed");
           }
        }
   }
}

//+------------------------------------------------------------------+
//| Delete Pending Sell Stop Order                                                |
//+------------------------------------------------------------------+
void DeleteSellStop()
{
    int ot = OrdersTotal();
    for (int i = 0; i < ot; i++)
    {
        ulong ticket = OrderGetTicket(i);
        if (OrderInfo.Select(ticket))
        {
           if ((OrderInfo.Symbol() == _Symbol) && (OrderInfo.Magic() == Magic) && (OrderInfo.OrderType() == ORDER_TYPE_SELL_STOP))
           {
               Trade.OrderDelete(ticket);
               Write("in function DeleteSellStopOrderDelete Executed");
           }
      }
   }
}

//+------------------------------------------------------------------+
//| Adjust Pending Orders to New High/Low Prices                            |
//+------------------------------------------------------------------+
void DoModify()
{
    int ot = OrdersTotal();
    for (int i = 0; i < ot; i++)
    {
        ulong ticket = OrderGetTicket(i);
        OrderSelect(ticket);
        if ((OrderInfo.Symbol() == _Symbol) && (OrderInfo.Magic() == Magic) && (OrderInfo.OrderType() == ORDER_TYPE_BUY_STOP))
        {
            if ((OrderInfo.PriceOpen() > HO) || (OrderInfo.PriceOpen() < HO))
            {
                Trade.OrderModify(ticket, HO, HSL, HTP, 0, 0);
                Write("in function DoModify , BuyStop OrderModify Executed, Buy Stop was @ " + DoubleToString(OrderInfo.PriceOpen(), _Digits) + " it was changed to " + DoubleToString(HO, _Digits));
            }
        }
        else if ((OrderInfo.Symbol() == _Symbol) && (OrderInfo.Magic() == Magic) && (OrderInfo.OrderType() == ORDER_TYPE_SELL_STOP))
        {
            if ((OrderInfo.PriceOpen() > LO) || (OrderInfo.PriceOpen() < LO))
            {
                Trade.OrderModify(ticket, LO, LSL, LTP, 0, 0);
                Write("in function DoModify , SellStop OrderModify Executed, Sell Stop was @ " + DoubleToString(OrderInfo.PriceOpen(), _Digits) + " it was changed to " + DoubleToString(LO, _Digits));
            }
        }
   }
}

//+------------------------------------------------------------------+
//| Logs a String to a File                                                        |
//+------------------------------------------------------------------+
void Write(string str)
{
    int handle;
    handle = FileOpen(filename, FILE_READ|FILE_WRITE|FILE_CSV, "/t");
   if(handle < 0)
   {
      Print("Failed to open the file by the absolute path.");
      Print("Error code ", GetLastError());
   }
    
    FileSeek(handle, 0, SEEK_END);      
   FileWrite(handle, str + " Time " + TimeToString(TimeCurrent(), TIME_DATE|TIME_SECONDS));
    FileClose(handle);
}

//+------------------------------------------------------------------+
//| Expert Every Tick Function                                       |
//+------------------------------------------------------------------+
void OnTick()
{
   int i;
   int OrdersCondition, secofday, secofnews;
   if (BEPips > 0) DoBE(BEPips);
   
   if (TrailingStop > 0) DoTrail();
   
   OrdersCondition = CheckOrdersCondition();
   
   MqlDateTime dt;
   TimeCurrent(dt);
   secofday = dt.hour * 3600 + dt.min * 60 + dt.sec;
   secofnews = NHour * 3600 + NMin * 60;
   
    MqlRates rates[];
    ArraySetAsSeries(rates, true);
    int copied = CopyRates(NULL, PERIOD_M1, 0, CTCBN + 1, rates);
   if (copied <= 0) Print("Error copying price data", GetLastError());
    
   double Ask = SymbolInfoDouble(Symbol(), SYMBOL_ASK);
    double Bid = SymbolInfoDouble(Symbol(), SYMBOL_BID);
    
    H = rates[0].high;
   L = rates[0].low;
   for (i = 1; i <= CTCBN; i++)
   {
       if (rates[i].high > H) H = rates[i].high;
   }
   for (i = 1; i <= CTCBN; i++)
   {
       if (rates[i].low < L) L = rates[i].low;
   }
   spread = Ask - Bid;
   HO = H + spread + 10 * Poin;
   LO = L - 10 * Poin;
   HSL = H + spread;
   LSL = L;
   HTP = HO + TP * Poin;
   LTP = LO - TP * Poin;

      string mm = "false";
      if (MM) mm = "true";
      string CommentString = "\nAmazing Forex System EA\n\nHigh @ " + DoubleToString(H, _Digits) + " Buy Order @ " + DoubleToString(HO, _Digits) + " Stoploss @ " + DoubleToString(HSL, _Digits) + " TakeProfit @ " + DoubleToString(HTP, _Digits) + "\nLow @ " + DoubleToString(L, _Digits) + " Sell Order @ " + DoubleToString(LO, _Digits) + " StopLoss @ " + DoubleToString(LSL, _Digits) + " TakeProfit @ " + DoubleToString(LTP, _Digits) + "\n\nNews Day: " + IntegerToString(NDay) + " News Time @ " + IntegerToString(NHour) + ":" + IntegerToString(NMin) + " CTCBN: " + IntegerToString(CTCBN) + " SecBPO: " + IntegerToString(SecBPO) + " SecBMO: " + IntegerToString(SecBMO) + " STWAN: " + IntegerToString(STWAN) + " OCO: " + IntegerToString(OCO) + " BEPips: " + IntegerToString(BEPips) + " Money Management: " + mm + " RiskPercent: " + IntegerToString(RiskPercent) + " Lots: " + DoubleToString(LotsOptimized(), 1);
   if (dt.day != NDay)
   {
        Comment(CommentString, "\n\nExpert is disabled because it's not a day of the expected news.");
        return;
   } 
   else
   {
       Comment(CommentString);
   }

   if ((secofday < secofnews) && (secofday > (secofnews - SecBPO)))
   {
      if (OrdersCondition == 0)
      {
         Write("Opening BuyStop & SellStop, OrdersCondition = " + IntegerToString(OrdersCondition) + " SecOfDay = " + IntegerToString(secofday));
         OpenBuyStop();
         OpenSellStop();
      }
      else if (OrdersCondition == 10)
      {
         Write("Opening SellStop, OrdersCondition = " + IntegerToString(OrdersCondition) + " SecOfDay = " + IntegerToString(secofday));
         OpenSellStop();
      }
      else if (OrdersCondition == 1)
      {
         Write("Opening BuyStop, OrdersCondition = " + IntegerToString(OrdersCondition) + " SecOfDay = " + IntegerToString(secofday));
         OpenBuyStop();
      }
   }

   if ((secofday < secofnews) && (secofday > (secofnews - SecBPO)) && (secofday < (secofnews - SecBMO)))
   {
       Write("Modifying Orders, OrdersCondition = " + IntegerToString(OrdersCondition) + " SecOfDay = " + IntegerToString(secofday));
       DoModify();
   }

   if ((secofday > secofnews) && (secofday < (secofnews + STWAN)) && (OCO))
   {
       if (OrdersCondition == 1001)
       {
         Write("Deleting SellStop Because of BuyStop Hit, OrdersCondition = " + IntegerToString(OrdersCondition) + " SecOfDay = " + IntegerToString(secofday));
         DeleteSellStop();
      }
      else if (OrdersCondition == 110)
      {
        Write("Deleting BuyStop Because of SellStop Hit, OrdersCondition = " + IntegerToString(OrdersCondition) + " SecOfDay = " + IntegerToString(secofday));
        DeleteBuyStop();
      }
   }
   
   if ((secofday > secofnews) && (secofday > (secofnews + STWAN)))
   {
      if (OrdersCondition == 11)
      {
         Write("Deleting BuyStop and SellStop Because 4 min expired, OrdersCondition = " + IntegerToString(OrdersCondition) + " SecOfDay = " + IntegerToString(secofday));
         DeleteBuyStop();
         DeleteSellStop();
      }
      else if ((OrdersCondition == 10) || (OrdersCondition == 110))
      {
          Write("Deleting BuyStop Because expired, OrdersCondition = " + IntegerToString(OrdersCondition) + " SecOfDay = " + IntegerToString(secofday));
          DeleteBuyStop();
      }
      else if ((OrdersCondition == 1) || (OrdersCondition == 1001))
      {
          Write("Deleting SellStop Because expired, OrdersCondition = " + IntegerToString(OrdersCondition) + " SecOfDay = " + IntegerToString(secofday));
          DeleteSellStop();
      }
   }
}
  
//+------------------------------------------------------------------+
//| Return Error Code Description                                    |
//+------------------------------------------------------------------+
string ErrorDescription(int error_code)
{
    string error_string;

   switch(error_code)
   {
      //---- codes returned from trade server
      case 0:
      case 1:   error_string="no error";                                                  break;
      case 2:   error_string="common error";                                              break;
      case 3:   error_string="invalid trade parameters";                                  break;
      case 4:   error_string="trade server is busy";                                      break;
      case 5:   error_string="old version of the client terminal";                        break;
      case 6:   error_string="no connection with trade server";                           break;
      case 7:   error_string="not enough rights";                                         break;
      case 8:   error_string="too frequent requests";                                     break;
      case 9:   error_string="malfunctional trade operation";                             break;
      case 64:  error_string="account disabled";                                          break;
      case 65:  error_string="invalid account";                                           break;
      case 128: error_string="trade timeout";                                             break;
      case 129: error_string="invalid price";                                             break;
      case 130: error_string="invalid stops";                                             break;
      case 131: error_string="invalid trade volume";                                      break;
      case 132: error_string="market is closed";                                          break;
      case 133: error_string="trade is disabled";                                         break;
      case 134: error_string="not enough money";                                          break;
      case 135: error_string="price changed";                                             break;
      case 136: error_string="off quotes";                                                break;
      case 137: error_string="broker is busy";                                            break;
      case 138: error_string="requote";                                                   break;
      case 139: error_string="order is locked";                                           break;
      case 140: error_string="long positions only allowed";                               break;
      case 141: error_string="too many requests";                                         break;
      case 145: error_string="modification denied because order too close to market";     break;
      case 146: error_string="trade context is busy";                                     break;
      //---- mql4 errors
      case 4000: error_string="no error";                                                 break;
      case 4001: error_string="wrong function pointer";                                   break;
      case 4002: error_string="array index is out of range";                              break;
      case 4003: error_string="no memory for function call stack";                        break;
      case 4004: error_string="recursive stack overflow";                                 break;
      case 4005: error_string="not enough stack for parameter";                           break;
      case 4006: error_string="no memory for parameter string";                           break;
      case 4007: error_string="no memory for temp string";                                break;
      case 4008: error_string="not initialized string";                                   break;
      case 4009: error_string="not initialized string in array";                          break;
      case 4010: error_string="no memory for array\' string";                             break;
      case 4011: error_string="too long string";                                          break;
      case 4012: error_string="remainder from zero divide";                               break;
      case 4013: error_string="zero divide";                                              break;
      case 4014: error_string="unknown command";                                          break;
      case 4015: error_string="wrong jump (never generated error)";                       break;
      case 4016: error_string="not initialized array";                                    break;
      case 4017: error_string="dll calls are not allowed";                                break;
      case 4018: error_string="cannot load library";                                      break;
      case 4019: error_string="cannot call function";                                     break;
      case 4020: error_string="expert function calls are not allowed";                    break;
      case 4021: error_string="not enough memory for temp string returned from function"; break;
      case 4022: error_string="system is busy (never generated error)";                   break;
      case 4050: error_string="invalid function parameters count";                        break;
      case 4051: error_string="invalid function parameter value";                         break;
      case 4052: error_string="string function internal error";                           break;
      case 4053: error_string="some array error";                                         break;
      case 4054: error_string="incorrect series array using";                             break;
      case 4055: error_string="custom indicator error";                                   break;
      case 4056: error_string="arrays are incompatible";                                  break;
      case 4057: error_string="global variables processing error";                        break;
      case 4058: error_string="global variable not found";                                break;
      case 4059: error_string="function is not allowed in testing mode";                  break;
      case 4060: error_string="function is not confirmed";                                break;
      case 4061: error_string="send mail error";                                          break;
      case 4062: error_string="string parameter expected";                                break;
      case 4063: error_string="integer parameter expected";                               break;
      case 4064: error_string="double parameter expected";                                break;
      case 4065: error_string="array as parameter expected";                              break;
      case 4066: error_string="requested history data in update state";                   break;
      case 4099: error_string="end of file";                                              break;
      case 4100: error_string="some file error";                                          break;
      case 4101: error_string="wrong file name";                                          break;
      case 4102: error_string="too many opened files";                                    break;
      case 4103: error_string="cannot open file";                                         break;
      case 4104: error_string="incompatible access to a file";                            break;
      case 4105: error_string="no order selected";                                        break;
      case 4106: error_string="unknown symbol";                                           break;
      case 4107: error_string="invalid price parameter for trade function";               break;
      case 4108: error_string="invalid ticket";                                           break;
      case 4109: error_string="trade is not allowed";                                     break;
      case 4110: error_string="longs are not allowed";                                    break;
      case 4111: error_string="shorts are not allowed";                                   break;
      case 4200: error_string="object is already exist";                                  break;
      case 4201: error_string="unknown object property";                                  break;
      case 4202: error_string="object is not exist";                                      break;
      case 4203: error_string="unknown object type";                                      break;
      case 4204: error_string="no object name";                                           break;
      case 4205: error_string="object coordinates error";                                 break;
      case 4206: error_string="no specified subwindow";                                   break;
      default:   error_string="unknown error";
    }
   return(error_string);
}  
//+------------------------------------------------------------------+
        
