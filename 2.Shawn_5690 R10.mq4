//+------------------------------------------------------------------+
//|                                             2.Shawn_5690 R10.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2013,{KingaSK} Kinga Kovacs, Owner: Kinga Kovacs"
#property link      "kingask2013@gmail.com     kingask2013@gmail.com"

int Gi_76 = 111111;
extern string Security_Part = "Please set your Account Number below ONLY if you are using the EA on YouTradeFx broker real account";
extern string Note = "The EA authorized to work on any demo account regardless to the broker name";
extern int Account_Number = 111111;
extern string EA_Setting = "                ------ EA Setting ------";
extern int Magic_Number = 23519;
extern bool Enabel_ECN_Broker = TRUE;
extern bool Enable_5Digit_Broker = TRUE;
extern bool KeepTrading = TRUE;
extern bool CloseAll_At_Maxtrades = TRUE;
extern bool Enable_Pending_First2Trade = TRUE;
extern int Pending_Distane_Pips = 500;
extern bool UseAveragePips = FALSE;
extern int NumberBars = 2;
extern string Trading_Setting = "              ----- Tradeing Setting -----";
extern int MaxSpreads_Points = 700;
extern int Max_Num_Trade = 2;
extern int Distance_ByNexrt_Level_Pips = 0;
extern double TotalProfit_Target = 0.05;
extern double TotalProfit_Step_Target = 0.05;
extern int Keep_TradeOpen = 100;
extern double LotSize = 0.1;
extern double MaxLot = 30.0;
extern bool AutoLot = TRUE;
extern double Amount_Per_baseLot = 100.0;
extern int TakeProfit_Pips = 0;
extern int StopLoss_Pips = 0;
extern int Slippage = 9;
int Gi_224 = 0;
double Gd_228 = 0.0;
string Gs_unused_236 = "";
double Gd_244 = 0.0;
double Gd_252 = 0.0;
double Gd_260 = 0.0;
int Gi_268 = 0;
double Gd_272 = 0.0;
string Gs_unused_280 = "";
double Gd_288 = 0.0;
double Gd_296 = 0.0;
double Gd_304 = 0.0;
int Gi_312 = 0;
int Gi_316 = 0;
int Gi_unused_320 = 0;
int Gi_unused_324 = 0;
string Gs_unused_328 = " ";
bool Gi_336 = TRUE;
double Gda_340[100];
int Gi_unused_344 = 0;
double G_ask_348 = 0.0;
double G_bid_356 = 0.0;
int Gi_unused_364 = 0;
int Gi_unused_368 = 0;
int Gi_unused_372 = 1;
bool Gi_376 = FALSE;
double Gd_380 = 0.0;
double G_lots_388 = 0.0;
bool Gi_396 = FALSE;
bool Gi_400 = FALSE;
bool Gi_404 = FALSE;
int Gi_408 = 0;
bool Gi_412 = FALSE;
double Gd_416;
double Gd_424;
double Gd_432;
double Gd_440;
int G_count_448 = 0;
int Gi_452;

// E37F0136AA3FFAF149B351F6A4C948E9
int init() {
   G_bid_356 = Bid;
   G_ask_348 = Ask;
   Gi_452 = TimeCurrent() - 5;
   return (0);
}
	  	   							  	 	 		  			 	 		  	    										   	   		   		  		   	 			   				  	 	 	 	 		 				 		 	 	 	   	     		 	  	 				  	 	  	 	 				 
// 52D46093050F38C27267BCE42543EF60
int deinit() {
   return (0);
}
	      				 		  	 				  					 		  		   				 					  		   		 	 		  			  	 				  				 		 	 	 				 							 	 	     	   	 		 	    				    	  	 						 
// EA2B2676C28C0DB26D39331A336C6B92
int start() {
   string Ls_20;
   int Li_unused_28;
   int Li_unused_32;
   int pos_36;
   bool Li_40;
   int count_44;
   int ticket_48;
   double order_open_price_52;
   int count_60;
   int ticket_64;
   double order_open_price_68;
   double Ld_76;
   int count_84;
   int count_88;
   double price_92;
   double price_100;
   double price_108;
   int Li_116;
   int Li_120;
   double Ld_124;
   double Ld_132;
   double Ld_140;
   bool Li_148;
   int index_152;
   bool Li_156;
   string Ls_0 = " ";
   int Li_8 = 1;
 //  if (Account_Number != Gi_76) {
  //     Ls_0 = "  You are not authorized to use this EA, please contact us at:kingask2013@gmail.com";
  //     Li_8 = 0;
  //  }
  //  if (IsDemo() == FALSE && AccountServer() != "Youtradefx-Real") {
   //    Ls_0 = "This EA is not working on live account, please contact us at: kingask2013@gmail.com";
   //    Li_8 = 0;
 //   }
 //   if (IsDemo() == TRUE || AccountServer() == "Youtradefx-Real" && Li_8 == 1) Li_8 = 1;
  //  if (IsDemo() == TRUE) Li_8 = 1;
   string Ls_12 = "";
   if (IsTradeContextBusy() == TRUE) {
      Li_8 = -1;
      Comment("Trade Context is busy");
   }
   if (Gi_224 != 0 || Gi_268 != 0 && Li_8 == 1) {
      Ls_20 = "Checking Opening Order request ...\n";
      if (Gi_224 != 0) {
         Ls_20 = Ls_20 + "Deal_With_Buy1:" + Gi_224 + "   Buy_Lot1:" + Gd_244 + "  Buy_openprice1:" + Gd_228 + "  Buy_SL1:" + Gd_260 + "  Buy_TP1:" + Gd_252 + "  Buy_Ticket1:" + Gi_312 
         + "\n";
      }
      if (Gi_268 != 0) {
         Ls_20 = Ls_20 + "Deal_With_Sell1:" + Gi_268 + "   Sell_Lot1:" + Gd_288 + "  Sell_openprice1:" + Gd_272 + "  Sell_SL1:" + Gd_304 + "  Sell_TP1:" + Gd_296 + "  Sell_Ticket1:" + Gi_316 
         + "\n";
      }
      Comment(Ls_20);
      Li_8 = 2;
   }
   if (Li_8 == 1 && Gi_396 == FALSE) {
      if (Enable_5Digit_Broker == TRUE) {
         Enable_5Digit_Broker = FALSE;
         TakeProfit_Pips = 10 * TakeProfit_Pips;
         StopLoss_Pips = 10 * StopLoss_Pips;
         Gi_unused_372 = 10;
         Slippage = 10 * Slippage;
         Distance_ByNexrt_Level_Pips = 10 * Distance_ByNexrt_Level_Pips;
         Pending_Distane_Pips = 10 * Pending_Distane_Pips;
      }
      Li_unused_28 = 0;
      Li_unused_32 = 0;
      pos_36 = OrdersTotal() - 1;
      Li_40 = FALSE;
      count_44 = 0;
      ticket_48 = 0;
      order_open_price_52 = 0;
      count_60 = 0;
      ticket_64 = 0;
      order_open_price_68 = 100000;
      Ld_76 = 0;
      count_84 = 0;
      count_88 = 0;
      for (pos_36 = OrdersTotal() - 1; pos_36 >= 0; pos_36--) {
         OrderSelect(pos_36, SELECT_BY_POS);
         if (OrderSymbol() == Symbol() && OrderMagicNumber() == Magic_Number) {
            Li_40 = TRUE;
            Ld_76 += OrderProfit();
            if (OrderType() == OP_BUY || OrderType() == OP_BUYSTOP) count_44++;
            if (OrderType() == OP_BUY || OrderType() == OP_BUYSTOP && OrderOpenPrice() > order_open_price_52) {
               order_open_price_52 = OrderOpenPrice();
               ticket_48 = OrderTicket();
            }
            if (OrderType() == OP_SELL || OrderType() == OP_SELLSTOP) count_60++;
            if (OrderType() == OP_SELL || OrderType() == OP_SELLSTOP && OrderOpenPrice() < order_open_price_68) {
               order_open_price_68 = OrderOpenPrice();
               ticket_64 = OrderTicket();
            }
            if (OrderType() == OP_BUYSTOP) count_84++;
            if (OrderType() == OP_SELLSTOP) count_88++;
         }
      }
      Ls_12 = "counter:" + Li_40 + "  Highest_Buy_Ticket:" + ticket_48 + "  Lowest_Sell_Ticket:" + ticket_64 
      + "\n";
      if (Li_40 == FALSE && KeepTrading == TRUE || Gi_376 == FALSE && MarketInfo(Symbol(), MODE_SPREAD) <= MaxSpreads_Points) {
         Gi_376 = TRUE;
         Gd_380 = 0;
         price_92 = NormalizeDouble(Ask, Digits);
         if (Enable_Pending_First2Trade == TRUE) {
            if (UseAveragePips) price_92 += (f0_1() + Pending_Distane_Pips) / 2.0 * Point;
            else price_92 += Pending_Distane_Pips / 2 * Point;
         }
         price_92 = NormalizeDouble(price_92, Digits);
         if (TakeProfit_Pips > 0) price_100 = price_92 + TakeProfit_Pips * Point;
         else price_100 = 0;
         if (StopLoss_Pips > 0) price_108 = price_92 - StopLoss_Pips * Point;
         else price_108 = 0;
         if (AutoLot == TRUE) {
            Li_116 = 1;
            for (Li_116 = 1; Li_116 <= 3000; Li_116++) {
               if (AccountBalance() <= Li_116 * Amount_Per_baseLot) {
                  G_lots_388 = Li_116 / 100.0;
                  break;
               }
            }
         } else G_lots_388 = LotSize;
         if (G_lots_388 < MarketInfo(Symbol(), MODE_MINLOT)) G_lots_388 = MarketInfo(Symbol(), MODE_MINLOT);
         if (G_lots_388 > MarketInfo(Symbol(), MODE_MAXLOT)) G_lots_388 = MarketInfo(Symbol(), MODE_MAXLOT);
         if (G_lots_388 > MaxLot) G_lots_388 = MaxLot;
         if (MarketInfo(Symbol(), MODE_MINLOT) == 0.01) G_lots_388 = NormalizeDouble(G_lots_388, 2);
         if (MarketInfo(Symbol(), MODE_MINLOT) == 0.1) G_lots_388 = NormalizeDouble(G_lots_388, 1);
         Print("Starting new cycle at  AccountBalance:" + AccountBalance() + "   Calculated Lot:" + G_lots_388);
         if (Enable_Pending_First2Trade == FALSE) OrderSend(Symbol(), OP_BUY, G_lots_388, price_92, Slippage, price_108, price_100, "", Magic_Number, 0, RoyalBlue);
         else {
            Print(f0_1());
            OrderSend(Symbol(), OP_BUYSTOP, G_lots_388, price_92, Slippage, price_108, price_100, "", Magic_Number, 0, RoyalBlue);
         }
         price_92 = NormalizeDouble(Bid, Digits);
         if (Enable_Pending_First2Trade == TRUE) {
            if (UseAveragePips) price_92 -= (f0_1() + Pending_Distane_Pips) / 2.0 * Point;
            else price_92 -= Pending_Distane_Pips / 2 * Point;
         }
         price_92 = NormalizeDouble(price_92, Digits);
         if (TakeProfit_Pips > 0) price_100 = price_92 - TakeProfit_Pips * Point;
         else price_100 = 0;
         if (StopLoss_Pips > 0) price_108 = price_92 + StopLoss_Pips * Point;
         else price_108 = 0;
         if (Enable_Pending_First2Trade == FALSE) OrderSend(Symbol(), OP_SELL, G_lots_388, price_92, Slippage, price_108, price_100, "", Magic_Number, 0, Red);
         else {
            Print(f0_1());
            OrderSend(Symbol(), OP_SELLSTOP, G_lots_388, price_92, Slippage, price_108, price_100, "", Magic_Number, 0, Red);
         }
      } else {
         if (Li_40 != FALSE) {
            Li_120 = 1;
            for (Li_120 = 1; Li_120 <= Max_Num_Trade - count_44 + 1; Li_120++) {
               OrderSelect(ticket_48, SELECT_BY_TICKET);
               Ld_124 = OrderOpenPrice() + Li_120 * Distance_ByNexrt_Level_Pips * Point;
               if (Li_120 == 1) {
                  Ls_12 = Ls_12 + "First NexLevel Buy:" + Ld_124 
                  + "\n";
               }
               if ((Ask >= Ld_124 && G_ask_348 < Ld_124 && count_44 + count_60 < Max_Num_Trade) || Gi_400 == TRUE) {
                  if (MarketInfo(Symbol(), MODE_SPREAD) <= MaxSpreads_Points && count_44 + count_60 < Max_Num_Trade) {
                     Gi_400 = FALSE;
                     price_92 = NormalizeDouble(Ask, Digits);
                     if (TakeProfit_Pips > 0) price_100 = price_92 + TakeProfit_Pips * Point;
                     else price_100 = 0;
                     if (StopLoss_Pips > 0) price_108 = price_92 - StopLoss_Pips * Point;
                     else price_108 = 0;
                     OrderSend(Symbol(), OP_BUY, G_lots_388, price_92, Slippage, price_108, price_100, "", Magic_Number, 0, RoyalBlue);
                     continue;
                  }
                  Gi_400 = TRUE;
               }
            }
            Li_120 = 1;
            for (Li_120 = 1; Li_120 <= Max_Num_Trade - count_60 + 1; Li_120++) {
               OrderSelect(ticket_64, SELECT_BY_TICKET);
               Ld_124 = OrderOpenPrice() - Li_120 * Distance_ByNexrt_Level_Pips * Point;
               if (Li_120 == 1) {
                  Ls_12 = Ls_12 + "First NexLevel Sell:" + Ld_124 
                  + "\n";
               }
               if ((Bid <= Ld_124 && G_bid_356 > Ld_124 && count_44 + count_60 < Max_Num_Trade) || Gi_404 == TRUE) {
                  if (MarketInfo(Symbol(), MODE_SPREAD) <= MaxSpreads_Points && count_44 + count_60 < Max_Num_Trade) {
                     Gi_404 = FALSE;
                     price_92 = NormalizeDouble(Bid, Digits);
                     if (TakeProfit_Pips > 0) price_100 = price_92 - TakeProfit_Pips * Point;
                     else price_100 = 0;
                     if (StopLoss_Pips > 0) price_108 = price_92 + StopLoss_Pips * Point;
                     else price_108 = 0;
                     OrderSend(Symbol(), OP_SELL, G_lots_388, price_92, Slippage, price_108, price_100, "", Magic_Number, 0, Red);
                     continue;
                  }
                  Gi_404 = TRUE;
               }
            }
         }
      }
      Ld_132 = G_lots_388 / 0.01;
      if (f0_0() != 0) {
         Ld_140 = f0_3();
         if (!Gi_412) {
            Gd_416 = TotalProfit_Target * Ld_132;
            Gd_432 = Gd_416;
            Gd_440 = TotalProfit_Step_Target * Ld_132;
            Gi_412 = TRUE;
         }
         if (Ld_140 > Gd_416) {
            Gd_416 = Ld_140;
            Print("trade profit  ", Gd_416);
            if (G_count_448 > 0) Gd_424 = Gd_416 - Gd_440;
         }
         if (G_count_448 == 0 && Gd_416 - Gd_432 >= Gd_440) {
            Gd_424 = Gd_416 - Gd_440;
            Print("profit for close  ", Gd_424);
            Print("add step ");
            G_count_448++;
         }
         if (f0_2()) {
            if (G_count_448 > 0 && Ld_140 <= Gd_424) {
               Gi_396 = TRUE;
               Print("close with profit", Gd_424);
               G_count_448 = 0;
               Gi_412 = FALSE;
            }
         }
      }
      if (count_44 + count_60 - count_84 - count_88 >= Max_Num_Trade && CloseAll_At_Maxtrades == TRUE) {
         Gi_396 = TRUE;
         Print("Close the cycle due to reaching max trades number");
      }
   }
   if (Gi_396 == TRUE) {
      pos_36 = OrdersTotal() - 1;
      Li_148 = FALSE;
      for (pos_36 = OrdersTotal() - 1; pos_36 >= 0; pos_36--) {
         OrderSelect(pos_36, SELECT_BY_POS);
         if (OrderSymbol() == Symbol() && OrderMagicNumber() == Magic_Number) {
            if (OrderType() == OP_BUY) OrderClose(OrderTicket(), OrderLots(), NormalizeDouble(MarketInfo(Symbol(), MODE_BID), MarketInfo(Symbol(), MODE_DIGITS)), 1000, Gold);
            if (OrderType() == OP_SELL) OrderClose(OrderTicket(), OrderLots(), NormalizeDouble(MarketInfo(Symbol(), MODE_ASK), MarketInfo(Symbol(), MODE_DIGITS)), 1000, Gold);
            if (OrderType() != OP_BUY && OrderType() != OP_SELL) OrderDelete(OrderTicket());
            Li_148 = TRUE;
         }
      }
      if (Li_148 == FALSE) {
         Gi_396 = FALSE;
         Gd_380 = 0;
         Gi_400 = FALSE;
         Gi_404 = FALSE;
      }
   }
   Ls_12 = Ls_12 + "Curret Speard:" + MarketInfo(Symbol(), MODE_SPREAD);
   Ls_12 = Ls_12 
   + "\n\nLastTrailed_TP:" + Gd_380;
   Comment(Ls_12);
   if (Gi_336 == TRUE) {
      index_152 = 0;
      Li_156 = FALSE;
      for (index_152 = 0; index_152 < 100; index_152++) {
         if (Gda_340[index_152] != 0.0) {
            OrderSelect(Gda_340[index_152], SELECT_BY_TICKET);
            if (OrderCloseTime() == 0) {
               Li_156 = TRUE;
               if (OrderType() == OP_BUY) OrderClose(OrderTicket(), OrderLots(), NormalizeDouble(Bid, Digits), Slippage, Gold);
               if (OrderType() == OP_SELL) OrderClose(OrderTicket(), OrderLots(), NormalizeDouble(Ask, Digits), Slippage, Gold);
               if (OrderType() != OP_BUY && OrderType() != OP_SELL) OrderDelete(OrderTicket());
            } else Gda_340[index_152] = 0;
         }
         if (Li_156 == FALSE) ObjectDelete("Closing_Flag");
      }
      index_152 = 0;
      for (index_152 = 0; index_152 < 100; index_152++) {
         if (Gda_340[index_152] == 0.0 && Gda_340[index_152 + 1] != 0.0) {
            Gda_340[index_152] = Gda_340[index_152 + 1];
            Gda_340[index_152 + 1] = 0;
         }
      }
   }
   if (Time[1] > Gi_408 && Ls_0 != " ") {
      Gi_408 = Time[1];
      Alert(Ls_0);
   }
   G_bid_356 = Bid;
   G_ask_348 = Ask;
   return (0);
}
		 			 	  		     		       	  						 		 	  		  		 	   	      	 	 	 	 			   	 				     		  		    	  	    		  			 			  	 	  	 		 		 	 		    		   			
// 7AA1EC0A310DF29C6D98B0354710655D
int f0_2() {
   int datetime_0 = 0;
   for (int pos_4 = 0; pos_4 < OrdersTotal(); pos_4++) {
      if (OrderSelect(pos_4, SELECT_BY_POS, MODE_TRADES)) {
         if (OrderSymbol() == Symbol() && OrderMagicNumber() == Magic_Number && OrderType() <= OP_SELL)
            if (OrderOpenTime() > datetime_0 && OrderOpenTime() > Gi_452) datetime_0 = OrderOpenTime();
      }
   }
   if (datetime_0 != 0) {
      if (TimeCurrent() - datetime_0 > Keep_TradeOpen) return (1);
      return (0);
   }
   return (0);
}
	 		   			 			  	   		  		  	 		       			 						 	 	   			  		  	    	 		    					 	 	 	   		 			  		 	 			   	  	  		 	 		 				 		 	  	   				 
// C9E339AC8E524CA7C6F5AA6D3A63450F
double f0_3() {
   double Ld_ret_0 = 0;
   for (int pos_8 = 0; pos_8 < OrdersTotal(); pos_8++) {
      if (OrderSelect(pos_8, SELECT_BY_POS, MODE_TRADES))
         if (OrderSymbol() == Symbol() && OrderMagicNumber() == Magic_Number && OrderType() <= OP_SELL) Ld_ret_0 = Ld_ret_0 + OrderProfit() + OrderSwap() + OrderCommission();
   }
   return (Ld_ret_0);
}
			   			   			 		 				 	  		  	 	 	  			   		 						 	 	 		 	     	    	  	   		 			   		 						  					  	   		 			 	  			  	 				  		 		 			 	 
// 33206DE718A258471B12F91D380A844C
int f0_0() {
   int count_0 = 0;
   for (int pos_4 = 0; pos_4 < OrdersTotal(); pos_4++) {
      if (OrderSelect(pos_4, SELECT_BY_POS, MODE_TRADES)) {
         if (OrderSymbol() == Symbol() && OrderType() <= OP_SELL)
            if (OrderMagicNumber() == Magic_Number) count_0++;
      }
   }
   return (count_0);
}
	   							   	 	 		  	 				 	 	  									    		  	 		 		 		    					  						 			 	 	  	 		  						  		 	  				   		   	   	  		   	 	 	 		   	 
// 53EC9730B2742CD8822653DBBCF452EB
double f0_1() {
   double Ld_ret_0 = 0;
   for (int Li_8 = 1; Li_8 <= NumberBars; Li_8++) Ld_ret_0 += (High[Li_8] - Low[Li_8]) / Point;
   Ld_ret_0 /= NumberBars;
   return (Ld_ret_0);
}

        
