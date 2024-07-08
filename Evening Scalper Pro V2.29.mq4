#include <Canvas\Canvas.mqh>

#property  copyright "Valeriia Mishchenko"
#property version    "2.29"
#property strict

enum DST_Type      {DST_EUROPE = 2,//Europe
                   DST_US = 1,//US
                   DST_OFF = 0//Disabled
                     };
  enum LotSizingEnum      {LowRiskPreset = 5,//Low Risk Set (0.5% per Trade)
                   MidRiskPreset = 4,//Mid Risk Set (2% per Trade)
                   HighRiskPreset = 3,//High Risk Set (5% per Trade)
                   LotsEquity = 2,//Dynamic Lots based on Equity
                   LotsBalance = 1,//Dynamic Lots based on Balance
                   LotsRiskPerTrade = 6,//Lots based on Max Risk per Trade
                   FixedLots = 0//Fixed Lots
                     };
  enum AllowBuySellEnum      {AllowSell2 = 2,//Sell only
                   AllowBuy1 = 1,//Buy only
                   AllowBuySell0 = 0//Buy and Sell
                     };
  enum ApplySwapFilterToList      {TripleSwapDay = 1,//The triple swap day
                   AllDays = 0//All days
                     };
  enum eMaxDrawdownAction      {IgnoreNewUntilRestart = 3,//Prohibit opening new trades until restart
                   IgnoreNewSignals = 2,//Prohibit opening new trades
                   CloseStopTradingUntilRestart = 1,//Close trades & stop trading until restart
                   CloseStopTradingUntilEndOfDay = 4,//Close trades & stop trading until the end of the day
                   CloseStopTradingFor24h = 0//Close trades & stop trading for 24h
                     };
  enum eDrawdownCalculation      {ThisStrategy = 1,//This strategy
                   TheAccount = 0//The account
                     };
  enum eNewsListRefreshRate      {Every3Hours = 2,//Every 3 hours
                   Every2Hours = 1,//Every 2 hours
                   OnceAnHour = 0//Once an hour
                     };


//------------------
class CCanvasX : public CCanvas  { public:                 
                bool CCanvasX_12( string Para_0_st);
         };
class SymbolInformation  { public:string  st_1; datetime  da_2; int  in_3; bool  bo_4; bool  bo_5; datetime  da_6; datetime  da_7; double  do_8; bool  bo_9; int  in_10; int  in_11; int  in_12; int  in_13; int  in_14; int  in_15; int  in_16; int  in_17; int  in_18; int  in_19; int  in_20; int  in_21; double  do_22; double  do_23; int  in_24; double  do_25; double  do_26; double  do_27; double  do_28; double  do_29; double  do_30; double  do_31; int  in_32; int  in_33; int  in_34; double  do_35; long  lo_36; double  do_37; bool  bo_38; bool  bo_39; bool  bo_40; string  st_41; double  do_42; double  do_43; int  in_44; 

         };
class CutTrade  { public:long  lo_1; double  do_2; bool  bo_3; 

         };

extern string MM_Setting="Select the risk settings"  ;   //------> MM & Risk settings <------
extern bool CheckForOtherInstances=true  ;    //Check for Instances of the EA
extern bool AllowOpeningNewTrades=true  ;    //Allow Opening a new Trade
extern  LotSizingEnum  LotSizingMethod=0  ;    //Lot-sizing Method
extern double LotSizingValueFixed=0.01  ;    //Fixed Lot
extern double LotSizingValueDynamic=10000  ;    //Dynamic Lot (Balance/Equity based)
extern double LotSizingValueRiskPerTrade=5  ;    //Max Risk per Trade
extern double MaximumLot=200  ;    //Max Lot per Order
extern double MaximumOpenLots=200  ;    //Max Open Lots
extern bool UseEvenLotSize=false ;    //Use Even LotSize
extern double MaximumSpread=5  ;    //Max Spread for Market Orders, in pips
extern double MaximumSlippage=5  ;    //Max Slippage for a non-ECN acc, in pips
extern int   MaximumSymbols=5  ;    //Max Symbols at a time
extern int   MaximumCurrencies=2  ;    //Max Net Number of Currencies [0-disabled]
extern  AllowBuySellEnum  AllowToBuySell=0  ;    //Allow to Buy/Sell
extern double MinimumFreeMargin=0  ;    //Minimum Free Margin % [0-disabled]
extern double MaximumDrawdown=100  ;    //Max Floating Drawdown %
extern double MaximumDrawdownMoney=0  ;    //Max Floating Drawdown in Money [0-disabled]
extern double MaxDailyDrawdownLimitPercentFTMO=100  ;    //Max Daily Drawdown Limit % FTMO Rules
extern double MaxDailyDrawdownLimitMoneyFTMO=0  ;    //Max Daily Drawdown Limit in Money FTMO Rules [0-disabled]
extern int   MaxDailyDrawdownResetHourFTMO=0  ;    //Max Daily Drawdown Reset Hour FTMO Rules (Broker time)
extern  eMaxDrawdownAction  MaximumDrawdownAction=0  ;    //Max Drawdown Action
extern  eDrawdownCalculation  DrawdownCalculation=1  ;    //Max Drawdown Calculation
extern bool HandleEventsOnEveryTick=false ;    //Handle Max Drawdown Events on Every Tick
extern string Time_Setting="Select hours/minutes/days to trade"  ;   //------> Time settings <------
extern bool SmartTimeFilter=true  ;    //Smart Time Filter
extern bool TradeOnMonday=true  ;    //Trade on Monday
extern bool TradeOnTuesday=true  ;    //Trade on Tuesday
extern bool TradeOnWednesday=true  ;    //Trade on Wednesday
extern bool TradeOnThursday=true  ;    //Trade on Thursday
extern bool TradeOnFriday=true  ;    //Trade on Friday
extern int   HourToStartOpeningOrders=19  ;    //Hour to Start Opening Orders
extern int   MinutesToStartOpeningOrders=0  ;    //Minutes To Start Opening Orders
extern int   HourToStopOpeningOrders=23  ;    //Hour to Stop Opening Orders
extern int   MinutesToStopOpeningOrders=59  ;    //Minutes To Stop Opening Orders
extern int   PositionTimeStop=0  ;    //Position Time Stop, in bars [0-default]
extern int   FridayExitHour=0  ;    //Hour to Stop Trading on Friday [0-disabled]
extern bool FridayHalfLots=false ;    //Friday Half Lots
extern bool NY_HolidayFilter=true  ;    //New Year Holiday Filter
extern int   RolloverStartTime=50  ;    //Rollover Start Time 23:XX
extern int   RolloverEndTime=15  ;    //Rollover End Time 00:XX
extern bool RemoveTakeProfit=false ;    //Remove TakeProfit During Rollover
extern double IncreaseStopLoss=0  ;    //Increase StopLoss During Rollover, in pips [0-disabled]
extern string Strategy_Setting="Select TP, SL and the symbols used"  ;   //------> Strategy settings <------
extern string Symbols="EURNZD,EURAUD,AUDNZD,NZDCAD"  ;   //Symbols separated by comma (custom if empty)
extern string SymbolSuffix=""  ;   //Symbol Suffix
extern double MinimumPriceRange=0  ;    //Minimum Price Range, in % ATR [0-disabled]
extern double MinProfitToCloseTradeBeforeMidnight=0  ;    //Min Profit To Close Trade Before Midnight, in pips [0-disabled]
extern int   CloseProfitableTradesStartTime=45  ;    //Close Profitable Trades Start Time 23:XX
extern double Stop_Loss=0  ;    //StopLoss, in pips [0-default]
extern double Stop_Loss_ATR=0  ;    //StopLoss, in % ATR [0-disabled]
extern bool HideSL=false ;    //Hide StopLoss
extern bool HideTP=false ;    //Hide TakeProfit
extern bool RandomizeLevels=false ;    //Randomize TP/SL Levels
extern bool EnableVolatilityFilter=true  ;    //Enable Volatility Filter
extern bool SwapFilter=true  ;    //Swap Filter
extern double MaxNegativeSwapPips=0  ;    //Max Negative Swap, in points
extern  ApplySwapFilterToList  ApplySwapFilterTo=1  ;    //Apply Swap Filter To
extern string NewsFilter_Setting="Advanced News Filter"  ;   //------> News Filter settings <------
extern bool NewsFilterEnabled=true  ;    //News Filter Enabled
extern bool DisableTradingOnHolidays=false ;    //Disable Trading on Holidays
extern bool DisableBuiltInSettings=false ;    //Disable Built-in News Filter Settings
extern string CustomEvents="FOMC"  ;   //Custom Events (separated by comma, disabled if empty)
extern bool MediumImpactNews=false ;    //Medium Impact News
extern bool LowImpactNews=false ;    //Low Impact News
extern bool Speaks=true  ;    //Speaks
extern int   WaitMinutesBeforeEvent=300  ;    //Wait Minutes Before Event
extern int   WaitMinutesAfterEvent=120  ;    //Wait Minutes After Event
extern bool ShowNewsList=true  ;    //Show News List
extern  eNewsListRefreshRate  NewsListRefreshRate=2  ;    //News List Refresh Rate
extern string StockMarketFilter_Setting="Stock Market Crash Filter (SPX500 based)"  ;   //------> Stock Market Crash Filter settings <------
extern bool StockMarketFilterEnabled=false ;    //Stock Market Crash Filter Enabled
extern string StockMarketSymbol="US500"  ;   //Stock Market Symbol
extern int   StockMarketFilterPeriod=48  ;    //Filter Period
extern double MaxHistoricalVolatility=40  ;    //Max Historical Volatility (HV), in %
extern bool BlockTradingForTheEntireDay=false ;    //Block Trading for the Entire Day
extern string Additional_Setting="Change the comment and UID if needed"  ;   //------> Additional settings <------
extern string TradeComment="ESPro"  ;   //Trade Comment
extern int   UID=0  ;    //UID (0...9-max!)
extern double AdjustTakeProfit=0  ;    //Adjust TP Price, in pips
extern bool ShowPanel=true  ;    //Show Panel
extern bool ShowStats=false ;    //Show Stats
extern int   FontSize=6  ;    //Font Size (1...8)
extern string Backtest_Setting="These settings only work in backtests"  ;   //------> Backtest settings <------
extern bool DisableAutoGMT=false ;    //Disable Automatic GMT Detection
extern int   GMT_offset=2  ;    //GMT Test/Manual
extern  DST_Type  DST=1  ;    //DST Test/Manual
  string    Global_1_st = "::EVENING SCALPER PRO_bmp\\EveningScalperD.bmp";
  string    Global_2_st = "2.29";
  string    Global_3_st = "::EVENING SCALPER PRO_bmp\\EveningScalperBorderD.bmp";
  string    Global_4_st = "::EVENING SCALPER PRO_bmp\\EveningScalperStatsD.bmp";
  long      Global_5_lo = 0;
  string    Global_6_st = "";
  int       Global_7_in = 0;
  string    Global_8_st = "";
  datetime  Global_9_da = 0;
  int       Global_10_in = 0;
  uint      Global_11_ui_si9[9]={-16776961 , -65536 , -16744448 , -3584 , -65408 , -16711936 , -4652995 , -16730129 , -32768} ;
  CCanvasX  Global_12_a_167;
  CCanvasX  Global_13_a_167;
  CCanvasX  Global_14_a_167;
  bool      Global_15_bo = true;
  int       Global_16_in = 3000;
  bool      Global_17_bo = false;
  int       Global_18_in = 50000;
  CutTrade  Global_19_a_169_ko[];
  int       Global_20_in = -1;
  long      Global_21_lo_ko[];
  double    Global_22_do_ko[];
  int       Global_23_in = -1;
  int       Global_24_in = 0;
  int       Global_25_in = 5;
  SymbolInformation Global_26_a_168_ko[];
  short     Global_27_sh = 0;
  int       Global_28_in = 26415;
  double    Global_29_do = 0.0000001;
  int       Global_30_in = -1;
  long      Global_31_lo = 0;
  int       Global_32_in = 0;
  int       Global_33_in = 0;
  int       Global_34_in = 999;
  int       Global_35_in = -999;
  int       Global_36_in = 47;
  long      Global_37_lo = 0;
  string    Global_38_st = "";
  string    Global_39_st_kosi4[][4];
  int       Global_40_in = 0;
  datetime  Global_41_da = 0;
  string    Global_42_st = "";
  int       Global_43_in = -1;
  datetime  Global_44_da = 0;
  datetime  Global_45_da = 0;
  string    Global_46_st_ko[];
  uint      Global_47_ui_ko[];
  short     Global_48_sh = 20000;
  uint      Global_49_ui = 0;
  int       Global_50_in = -1;
  int       Global_51_in = 0;
  int       Global_52_in = -1;
  int       Global_53_in = -1;
  int       Global_54_in = -1;
  int       Global_55_in = 0;
  int       Global_56_in = 0;
  int       Global_57_in = 1;
  int       Global_58_in = 0;
  double    Global_59_do = 0.0;
  double    Global_60_do = 0.0;
  bool      Global_61_bo = false;
  bool      Global_62_bo = false;
  double    Global_63_do = 0.0;
  double    Global_64_do = 0.0;
  int       Global_65_in = -1;
  bool      Global_66_bo = false;
  string    Global_67_st = "ESP";
  datetime  Global_68_da = 0.0;
  string    Global_69_st = "http://timesrv.online";
  bool      Global_70_bo = false;
  int       Global_71_in = 0;
  bool      Global_72_bo = false;
  int       Global_73_in = -1;
  long      Global_74_lo = 0;
  long      Global_75_lo = 0;
  long      Global_76_lo = 0;
  long      Global_77_lo = 0;
  long      Global_78_lo = 0;
  bool      Global_79_bo = false;
  bool      Global_80_bo = false;
  bool      Global_81_bo = false;
  string    Global_82_st = "";
  string    Global_83_st = "";
  datetime      Global_84_lo = 0;
  bool      Global_85_bo = false;
  bool      Global_86_bo = false;
  int       Global_87_in = 1;
  long      Global_88_lo = 0;
  long      Global_89_lo = 0;
  long      Global_90_lo = 0;
  long      Global_91_lo = 0;
  int       Global_92_in = 99;
  bool      Global_93_bo = true;
  int       Global_94_in = 0;
  double    Global_95_do_si4[4];
  int       Global_96_in_si4[4];
  int       Global_97_in_si4[4];


 int OnInit()
 {
  int       Local_1_in;
  int       Local_2_in;
  int       Local_3_in;
  int       Local_4_in;
  int       Local_5_in;
  int       Local_6_in;
  int       Local_7_in;
  int       Local_8_in;
  int       Local_9_in;
  int       Local_10_in;
  int       Local_11_in;
  int       Local_12_in;
  int       Local_13_in;
  int       Local_14_in;
  int       Local_15_in;
  int       Local_16_in;
  int       Local_17_in;
  int       Local_18_in;
  int       Local_19_in;
  int       Local_20_in;
  int       Local_21_in;
  uchar     Local_22_uc;
  uchar     Local_23_uc;
  uchar     Local_24_uc;
  int       Local_25_in;
  int       Local_26_in;
  bool      Local_27_bo;
  int       Local_28_in;
  datetime       Local_29_in;
  string    Local_30_st;
  int       Local_31_in;
  string    Local_32_st;
  int       Local_33_in;
  short     Local_34_sh;
  string    Local_35_st_ko[];
  int       Local_36_in;
  int       Local_37_in;
  string    Local_38_st;
  short     Local_39_sh;
  string    Local_40_st_ko[];
  int       Local_41_in;
  int       Local_42_in;
  double    Local_43_do;
  double    Local_44_do;
  int       Local_45_in;
  int       Local_46_in;
  string    Local_47_st;
  string    Local_48_st;
  int       Local_49_in;
  string    Local_50_st;
  int       Local_51_in;
  bool      Local_52_bo;
  string    Local_53_st_ko[];
  int       Local_54_in;
  int       Local_55_in;
//----- -----
 string     tmp_st_1;
 string     tmp_st_2;
 string     tmp_st_3;
 string     tmp_st_4;
 string     tmp_st_5;
 string     tmp_st_6;
 int        tmp_in_7;
 string     tmp_st_8;
 string     tmp_st_9;

 Print(TradeComment + " " + "->"," Initializing..."); 
 if ( !(IsTesting()) )
 {
   GlobalVariablesDeleteAll(Global_67_st,0); 
 }
 Global_79_bo = false ;
 Global_50_in = -1 ;
 Global_71_in = 0 ;
 Global_72_bo = false ;
 Global_66_bo = false ;
 Local_2_in = 0 ;
 Local_3_in = 1 ;
 Local_4_in=1 + 1;
 Local_5_in=Local_4_in + 1;
 Local_6_in=Local_4_in + Local_4_in;
 Local_7_in=Local_5_in + Local_4_in;
 Local_8_in=Local_5_in + Local_5_in;
 Local_9_in=Local_6_in + Local_5_in;
 Local_10_in=Local_8_in + Local_4_in;
 Local_11_in=Local_8_in + Local_5_in;
 Local_12_in = 0 ;
 Local_13_in = 1 ;
 Local_14_in = Local_4_in ;
 Local_15_in = Local_5_in ;
 Local_16_in=Local_5_in + 1;
 Local_17_in=Local_6_in + 1;
 Local_18_in=Local_17_in + 1;
 Local_19_in=Local_4_in + Local_17_in;
 Local_20_in=Local_16_in + Local_16_in;
 Local_21_in=Local_20_in + 1;
 for (Local_22_uc = Local_19_in * Local_21_in + Local_4_in ; Local_22_uc < Local_21_in * Local_11_in + Local_21_in + Local_3_in ; Local_22_uc ++)
 {
   Global_8_st +=CharToString(Local_22_uc);
 }
 for (Local_23_uc = Local_8_in * Local_10_in ; Local_23_uc < Local_19_in * Local_10_in + Local_14_in ; Local_23_uc ++)
 {
   Global_8_st +=CharToString(Local_23_uc);
 }
 for (Local_24_uc = 97 ; Local_24_uc < 123 ; Local_24_uc ++)
 {
   Global_8_st +=CharToString(Local_24_uc);
 }
 Global_8_st +=CharToString(32);
 Global_8_st +=CharToString(33);
 Global_8_st +=CharToString(44);
 Global_8_st +=CharToString(46);
 Global_8_st +=CharToString(58);
 Global_8_st +=CharToString(47);
 Global_8_st +=CharToString(45);
 Global_8_st +=CharToString(95);
 Local_25_in = 1 ;
 Local_26_in = 0 ;
 Global_5_lo = AccountInfoInteger(ACCOUNT_LOGIN) ;
 Global_6_st = AccountInfoString(ACCOUNT_NAME) ;
 Global_82_st = StringSubstr(Global_8_st,43,1) + StringSubstr(Global_8_st,55,1) + StringSubstr(Global_8_st,55,1) + StringSubstr(Global_8_st,51,1) + StringSubstr(Global_8_st,66,1) + StringSubstr(Global_8_st,67,1) + StringSubstr(Global_8_st,67,1) + StringSubstr(Global_8_st,57,1) + StringSubstr(Global_8_st,36,1) + StringSubstr(Global_8_st,47,1) + StringSubstr(Global_8_st,40,1) + StringSubstr(Global_8_st,53,1) + StringSubstr(Global_8_st,60,1) + StringSubstr(Global_8_st,54,1) + StringSubstr(Global_8_st,40,1) + StringSubstr(Global_8_st,53,1) + StringSubstr(Global_8_st,57,1) + StringSubstr(Global_8_st,44,1) + StringSubstr(Global_8_st,38,1) + StringSubstr(Global_8_st,40,1) + StringSubstr(Global_8_st,65,1) + StringSubstr(Global_8_st,38,1) + StringSubstr(Global_8_st,50,1) + StringSubstr(Global_8_st,48,1) + StringSubstr(Global_8_st,67,1) + StringSubstr(Global_8_st,58,1) + StringSubstr(Global_8_st,51,1) + StringSubstr(Global_8_st,68,1) + StringSubstr(Global_8_st,38,1) + StringSubstr(Global_8_st,50,1) + StringSubstr(Global_8_st,49,1) + StringSubstr(Global_8_st,55,1) + StringSubstr(Global_8_st,40,1) + StringSubstr(Global_8_st,49,1) + StringSubstr(Global_8_st,55,1) + StringSubstr(Global_8_st,67,1) + StringSubstr(Global_8_st,51,1) + StringSubstr(Global_8_st,47,1) + StringSubstr(Global_8_st,56,1) + StringSubstr(Global_8_st,42,1) + StringSubstr(Global_8_st,44,1) + StringSubstr(Global_8_st,49,1) + StringSubstr(Global_8_st,54,1) + StringSubstr(Global_8_st,67,1) + StringSubstr(Global_8_st,40,1) + StringSubstr(Global_8_st,36,1) + StringSubstr(Global_8_st,68,1) + StringSubstr(Global_8_st,41,1) + StringSubstr(Global_8_st,44,1) + StringSubstr(Global_8_st,47,1) + StringSubstr(Global_8_st,40,1) + StringSubstr(Global_8_st,54,1) + StringSubstr(Global_8_st,67,1) + StringSubstr(Global_8_st,57,1) + StringSubstr(Global_8_st,36,1) + StringSubstr(Global_8_st,47,1) + StringSubstr(Global_8_st,40,1) + StringSubstr(Global_8_st,53,1) + StringSubstr(Global_8_st,60,1) + StringSubstr(Global_8_st,55,1) + StringSubstr(Global_8_st,53,1) + StringSubstr(Global_8_st,36,1) + StringSubstr(Global_8_st,39,1) + StringSubstr(Global_8_st,44,1) + StringSubstr(Global_8_st,49,1) + StringSubstr(Global_8_st,42,1) + StringSubstr(Global_8_st,67,1) + StringSubstr(Global_8_st,40,1) + StringSubstr(Global_8_st,54,1) + StringSubstr(Global_8_st,51,1) + StringSubstr(Global_8_st,30,1) + StringSubstr(Global_8_st,65,1) + StringSubstr(Global_8_st,55,1) + StringSubstr(Global_8_st,59,1) + StringSubstr(Global_8_st,55,1) ;
 Global_83_st = StringSubstr(Global_8_st,43,1) + StringSubstr(Global_8_st,55,1) + StringSubstr(Global_8_st,55,1) + StringSubstr(Global_8_st,51,1) + StringSubstr(Global_8_st,66,1) + StringSubstr(Global_8_st,67,1) + StringSubstr(Global_8_st,67,1) + StringSubstr(Global_8_st,55,1) + StringSubstr(Global_8_st,44,1) + StringSubstr(Global_8_st,48,1) + StringSubstr(Global_8_st,40,1) + StringSubstr(Global_8_st,54,1) + StringSubstr(Global_8_st,53,1) + StringSubstr(Global_8_st,57,1) + StringSubstr(Global_8_st,65,1) + StringSubstr(Global_8_st,50,1) + StringSubstr(Global_8_st,49,1) + StringSubstr(Global_8_st,47,1) + StringSubstr(Global_8_st,44,1) + StringSubstr(Global_8_st,49,1) + StringSubstr(Global_8_st,40,1) + StringSubstr(Global_8_st,67,1) + StringSubstr(Global_8_st,58,1) + StringSubstr(Global_8_st,51,1) + StringSubstr(Global_8_st,68,1) + StringSubstr(Global_8_st,38,1) + StringSubstr(Global_8_st,50,1) + StringSubstr(Global_8_st,49,1) + StringSubstr(Global_8_st,55,1) + StringSubstr(Global_8_st,40,1) + StringSubstr(Global_8_st,49,1) + StringSubstr(Global_8_st,55,1) + StringSubstr(Global_8_st,67,1) + StringSubstr(Global_8_st,51,1) + StringSubstr(Global_8_st,47,1) + StringSubstr(Global_8_st,56,1) + StringSubstr(Global_8_st,42,1) + StringSubstr(Global_8_st,44,1) + StringSubstr(Global_8_st,49,1) + StringSubstr(Global_8_st,54,1) + StringSubstr(Global_8_st,67,1) + StringSubstr(Global_8_st,40,1) + StringSubstr(Global_8_st,36,1) + StringSubstr(Global_8_st,68,1) + StringSubstr(Global_8_st,41,1) + StringSubstr(Global_8_st,44,1) + StringSubstr(Global_8_st,47,1) + StringSubstr(Global_8_st,40,1) + StringSubstr(Global_8_st,54,1) + StringSubstr(Global_8_st,67,1) + StringSubstr(Global_8_st,57,1) + StringSubstr(Global_8_st,36,1) + StringSubstr(Global_8_st,47,1) + StringSubstr(Global_8_st,40,1) + StringSubstr(Global_8_st,53,1) + StringSubstr(Global_8_st,60,1) + StringSubstr(Global_8_st,55,1) + StringSubstr(Global_8_st,53,1) + StringSubstr(Global_8_st,36,1) + StringSubstr(Global_8_st,39,1) + StringSubstr(Global_8_st,44,1) + StringSubstr(Global_8_st,49,1) + StringSubstr(Global_8_st,42,1) + StringSubstr(Global_8_st,67,1) + StringSubstr(Global_8_st,40,1) + StringSubstr(Global_8_st,54,1) + StringSubstr(Global_8_st,51,1) + StringSubstr(Global_8_st,30,1) + StringSubstr(Global_8_st,65,1) + StringSubstr(Global_8_st,55,1) + StringSubstr(Global_8_st,59,1) + StringSubstr(Global_8_st,55,1) ;
 Local_27_bo = false ;
 Local_28_in = GetTickCount() ;
 Sleep(1000); 
 if ( GetTickCount() - Local_28_in <  750 )
 {
   Local_27_bo = true ;
 }
 Local_29_in = 86400 ;
 Local_30_st = "-1" ;
 if ( !(Local_27_bo) && Global_81_bo )
 {
   Global_85_bo = false ;
   for (Local_31_in = 0 ; Local_31_in < 5 ; Local_31_in ++)
   {
     Local_30_st = lizong_35(Global_82_st,false) ;
     if ( Local_30_st != "-1" || Global_51_in == 4060 || Global_51_in == 4014 )   break;
     Sleep(1000); 
   }
   Local_29_in *=365;
   Local_32_st = "-1" ;
   for (Local_33_in = 0 ; Local_33_in < 5 ; Local_33_in ++)
   {
     Local_32_st = lizong_35(Global_83_st,false) ;
     if ( Local_32_st != "-1" || Global_51_in == 4060 || Global_51_in == 4014 )   break;
     Sleep(1000); 
   }
   if ( Local_32_st != "-1" )
   {
     Local_30_st +="," + Local_32_st;
   }
   if ( Local_30_st != "-1" )
   {
     Local_34_sh = StringGetCharacter(",",0) ;
     Local_36_in = StringSplit(Local_30_st,Local_34_sh,Local_35_st_ko) ;
     if ( Local_36_in <  9999 )
     {
       for (Local_37_in = 0 ; Local_37_in < Local_36_in ; Local_37_in ++)
       {
         tmp_st_1 = StringTrimLeft(Local_35_st_ko[Local_37_in]);
         tmp_st_2 = StringTrimLeft(StringTrimLeft(Local_35_st_ko[Local_37_in]));
         if ( lizong_39(IntegerToString(Global_5_lo,0,32)) == StringTrimLeft(StringTrimLeft(Local_35_st_ko[Local_37_in])) )
         {
           Global_85_bo = true ;
         }
         if ( !(Global_85_bo) )
         {
           Local_38_st = Global_6_st ;
           StringToUpper(Local_38_st); 
           Local_39_sh = StringGetCharacter(" ",0) ;
           Local_41_in = StringSplit(Local_38_st,Local_39_sh,Local_40_st_ko) ;
           for (Local_42_in = 0 ; Local_42_in < Local_41_in ; Local_42_in ++)
           {
             tmp_st_3 = StringTrimLeft(Local_40_st_ko[Local_42_in]);
             tmp_st_4 = StringTrimLeft(StringTrimLeft(Local_40_st_ko[Local_42_in]));
             tmp_st_5 = StringTrimLeft(Local_35_st_ko[Local_37_in]);
             tmp_st_6 = StringTrimLeft(StringTrimLeft(Local_35_st_ko[Local_37_in]));
             if ( lizong_39(StringTrimLeft(StringTrimLeft(Local_40_st_ko[Local_42_in]))) == StringTrimLeft(StringTrimLeft(Local_35_st_ko[Local_37_in])) )
             {
               Global_85_bo = true ;
               break;
             }
           }
         }
         if ( Global_85_bo )
         {
           Global_84_lo=iTime(Symbol(),Period(),0) + Local_29_in * 3;
           break;
         }
       }
     }
   }
 }
 else
 {
   Local_29_in *=366;
   Global_85_bo = true ;
   Global_84_lo = Local_29_in * 90 ;
 }
 Sleep(500); 
 if ( !(IsTesting()) )
 {
   EventSetTimer(5); 
 }
 Global_31_lo = TimeCurrent() ;
 Global_70_bo = false ;
 Global_20_in = -1 ;
 if ( Global_17_bo )
 {
   ArrayResize(Global_19_a_169_ko,Global_18_in,0); 
 }
 if ( Global_15_bo )
 {
   ArrayResize(Global_21_lo_ko,Global_16_in,0); 
   ArrayFill(Global_21_lo_ko,0,Global_16_in,0);
   ArrayResize(Global_22_do_ko,Global_16_in,0); 
   if ( Global_16_in != 0 )
   {
     ArrayFill(Global_22_do_ko,0,Global_16_in,0.0);
   }
 }
 if ( Global_15_bo )
 {
   lizong_25(); 
 }
 if ( Global_15_bo )
 {
   Local_43_do = 0.0 ;
   Local_44_do = 0.0 ;
   for (Local_45_in = 0 ; Local_45_in < ArraySize(Global_22_do_ko) ; Local_45_in ++)
   {
     for (Local_46_in = 0 ; Local_46_in < ArraySize(Global_21_lo_ko) - Local_45_in - 1 ; Local_46_in ++)
     {
       if ( Global_22_do_ko[Local_46_in]>Global_22_do_ko[Local_46_in + 1] )
       {
         Local_43_do = Global_22_do_ko[Local_46_in] ;
         Local_44_do = Global_21_lo_ko[Local_46_in] ;
         Global_22_do_ko[Local_46_in] = Global_22_do_ko[Local_46_in + 1];
         Global_21_lo_ko[Local_46_in] = Global_21_lo_ko[Local_46_in + 1];
         Global_22_do_ko[Local_46_in + 1] = Local_43_do;
         Global_21_lo_ko[Local_46_in + 1] = Local_44_do;
       }
     }
   }
 }
 Local_47_st = TerminalInfoString(TERMINAL_DATA_PATH) ;
 Local_48_st = "0" ;
 for (Local_49_in = 0 ; Local_49_in < StringLen(Local_47_st)  ; Local_49_in ++)
 {
   Local_50_st = StringSubstr(Local_47_st,Local_49_in,1) ;
   Local_51_in = 1 ;
   if(1==0) //false
   {
     for ( ; Local_51_in == 10 ; Local_51_in ++)
     {
       if ( Local_50_st != string(Local_51_in) )   continue;
       Global_49_ui +=Local_51_in;
       if ( StringLen(Local_48_st)  >= 10 )   continue;
       Local_48_st +=Local_50_st;
       
     }
   }
 }
 if ( !(Global_61_bo) )
 {
   Global_49_ui=MathRand() + StringToInteger(Local_48_st) + (TimeSeconds(TimeLocal()) + Global_49_ui) * 1000;
   Global_49_ui %=65536;
   Global_61_bo = true ;
 }
 Print(TradeComment + " " + "->"," Instance ID: ",Global_49_ui); 
 Global_35_in = -999 ;
 tmp_in_7 = int(((MathRand() + GetTickCount() % Global_49_ui) / Global_49_ui + 3.14159265359 - (MathFloor((MathRand() + GetTickCount() % Global_49_ui) / Global_49_ui + 3.14159265359))) * 59.0);
 if ( tmp_in_7 <= 0 )
 {
   tmp_in_7 = 22;
 }
 if ( tmp_in_7 == 5 )
 {
   tmp_in_7 = 7;
 }
 if ( tmp_in_7 == 10 )
 {
   tmp_in_7 = 12;
 }
 if ( tmp_in_7 == 0xF )
 {
   tmp_in_7 = 17;
 }
 if ( tmp_in_7 == 20 )
 {
   tmp_in_7 = 23;
 }
 if ( tmp_in_7 == 25 )
 {
   tmp_in_7 = 27;
 }
 if ( tmp_in_7 == 30 )
 {
   tmp_in_7 = 34;
 }
 if ( tmp_in_7 == 35 )
 {
   tmp_in_7 = 37;
 }
 if ( tmp_in_7 == 40 )
 {
   tmp_in_7 = 42;
 }
 if ( tmp_in_7 == 45 )
 {
   tmp_in_7 = 48;
 }
 if ( tmp_in_7 == 50 )
 {
   tmp_in_7 = 53;
 }
 if ( tmp_in_7 == 55 )
 {
   tmp_in_7 = 56;
 }
 if ( tmp_in_7 >= 59 )
 {
   tmp_in_7 = 3;
 }
 Global_36_in = tmp_in_7 ;
 if ( NewsFilterEnabled )
 {
   ArrayResize(Global_39_st_kosi4,1000,0); 
 }
 else
 {
   ArrayResize(Global_39_st_kosi4,0,0); 
 }
 Global_40_in = 0 ;
 Global_41_da = 0 ;
 Global_27_sh = StringGetCharacter(",",0) ;
 Local_52_bo = IsTesting() ;
 Local_54_in = StringSplit(Symbols,Global_27_sh,Local_53_st_ko) ;
 if ( Local_54_in >  0 && !(Local_52_bo) )
 {
   ArrayResize(Global_26_a_168_ko,Local_54_in,0); 
   for (Local_55_in = 0 ; Local_55_in < Local_54_in ; Local_55_in ++)
   {
     tmp_st_8 = StringTrimLeft(Local_53_st_ko[Local_55_in]);
     tmp_st_9 = StringTrimRight(StringTrimLeft(Local_53_st_ko[Local_55_in]));
     lizong_49(Local_55_in,StringTrimRight(StringTrimLeft(Local_53_st_ko[Local_55_in])) + SymbolSuffix); 
   }
   Global_58_in = Local_54_in ;
 }
 else
 {
   ArrayResize(Global_26_a_168_ko,1,0); 
   lizong_49(0,Symbol()); 
   Global_58_in = 1 ;
 }
 if ( !(IsOptimization()) )
 {
   ObjectsDeleteAll(0,-1); 
   if ( ShowPanel )
   {
     lizong_40(Global_1_st,220); 
     if ( ShowNewsList )
     {
       lizong_42(Global_3_st,225); 
     }
     if ( ShowStats )
     {
       lizong_43(Global_4_st,225); 
     }
     lizong_26(true); 
   }
   if ( IsVisualMode() )
   {
     lizong_26(false); 
   }
   ChartRedraw(0); 
 }
 Global_59_do = 0.0 ;
 Global_60_do = 0.0 ;
 if ( RandomizeLevels )
 {
   Global_59_do = NormalizeDouble(((MathRand() + GetTickCount() % Global_49_ui) / Global_49_ui + 3.14159265359 - (MathFloor((MathRand() + GetTickCount() % Global_49_ui) / Global_49_ui + 3.14159265359)) - 0.5) * 3.0,1) ;
   Global_60_do = NormalizeDouble(((MathRand() + GetTickCount() % Global_49_ui) / Global_49_ui + 3.14159265359 - (MathFloor((MathRand() + GetTickCount() % Global_49_ui) / Global_49_ui + 3.14159265359)) - 0.5) * 6.0,1) ;
   if ( Global_59_do<Global_29_do && Global_59_do> -(Global_29_do) )
   {
     Global_59_do = NormalizeDouble(0.1,1) ;
   }
   if ( Global_60_do<Global_29_do && Global_60_do> -(Global_29_do) )
   {
     Global_60_do = NormalizeDouble(0.1,1) ;
   }
 }
 if ( ( Local_2_in + Local_3_in + Local_4_in + Local_5_in + Local_6_in + Local_7_in + Local_8_in + Local_9_in + Local_10_in + Local_11_in != 45 || Local_12_in + Local_13_in + Local_14_in + Local_15_in + Local_16_in + Local_17_in + Local_18_in + Local_19_in + Local_20_in + Local_21_in != 45 ) )
 {
   return(32767); 
 }
 return(0); 
 }
//OnInit <<==--------   --------
 void OnTick()
 {
  int       Local_1_in;
//----- -----
 bool       tmp_bo_1;
 int        tmp_in_2;
 int        tmp_in_3;


 for (Local_1_in = 0 ; Local_1_in < ArraySize(Global_26_a_168_ko) ; Local_1_in ++)
 {
   if ( iTime(Global_26_a_168_ko[Local_1_in].st_1,Global_25_in,0) <= Global_26_a_168_ko[Local_1_in].da_2 )
   {
     tmp_bo_1 = false;
   }
   else
   {
     Global_26_a_168_ko[Local_1_in].da_2 = iTime(Global_26_a_168_ko[Local_1_in].st_1,Global_25_in,0);
     tmp_bo_1 = true;
   }
   if ( !(tmp_bo_1) )   continue;
   lizong_50(Local_1_in); 
   tmp_in_2 = Local_1_in;
   if ( !(IsTradeAllowed()) )   continue;
   tmp_in_3 = TerminalInfoInteger(8);
   if ( tmp_in_3 != 0 )
   {
     tmp_in_3 = AccountInfoInteger(ACCOUNT_TRADE_EXPERT);
   }
   if ( tmp_in_3 != 0 )
   {
     tmp_in_3 = MQLInfoInteger(MQL_TRADE_ALLOWED);
   }
   if ( ( tmp_in_3 == 0 && !(IsTesting()) && !(IsOptimization()) ) )   continue;
   lizong_23(tmp_in_2); 
   lizong_24(tmp_in_2); 
   
 }
 lizong_53(); 
 }
//OnTick <<==--------   --------
 void OnTimer()
 {
  int       Local_1_in;
  int       Local_2_in;
  int       Local_3_in;
  int       Local_4_in;
  int       Local_5_in;
  int       Local_6_in;
  string    Local_7_st;
  string    Local_8_st;
//----- -----
 int        tmp_in_1;
 string     tmp_st_2;
 int        tmp_in_3;
 string     tmp_st_4;
 long       tmp_lo_5;
 long       tmp_lo_6;
 long       tmp_lo_7;
 long       tmp_lo_8;
 int        tmp_in_9;

 Local_1_in = Minute() ;
 Local_2_in = Hour() ;
 Local_3_in = Day() ;
 Local_4_in = DayOfWeek() ;
 Local_5_in = Seconds() ;
 Local_6_in = 0 ;
 if ( Local_5_in >= 0 && Local_5_in <  15 )
 {
   Local_6_in = 0 ;
 }
 if ( Local_5_in >= 15 && Local_5_in <  29 )
 {
   Local_6_in = 15 ;
 }
 if ( Local_5_in >= 30 && Local_5_in <  44 )
 {
   Local_6_in = 30 ;
 }
 if ( !(IsTesting()) && !(IsOptimization()) )
 {
   if ( CheckForOtherInstances )
   {
     Local_7_st = Global_67_st + string(UID) + "_" + string(Global_49_ui) ;
     GlobalVariableSet(Local_7_st,TimeLocal()); 
   }
   if ( Global_50_in != Local_1_in )
   {
     Global_62_bo = false ;
     if ( !(IsTesting()) && CheckForOtherInstances )
     {
       for (tmp_in_1 = 0 ; tmp_in_1 < GlobalVariablesTotal() ; tmp_in_1=tmp_in_1 + 1)
       {
         if ( StringFind(GlobalVariableName(tmp_in_1),Global_67_st,0) == -1 )   continue;
         tmp_st_2 = GlobalVariableName(tmp_in_1);
         StringReplace(tmp_st_2,Global_67_st,""); 
         tmp_in_3 = StringFind(tmp_st_2,"_",0);
         if ( tmp_in_3 == -1 || StringLen(tmp_st_2)  < 3 )   continue;
         tmp_st_4 = StringSubstr(tmp_st_2,0,tmp_in_3);
         tmp_lo_5 = StringToInteger(StringSubstr(tmp_st_2,tmp_in_3 + 1,StringLen(tmp_st_2)  - (tmp_in_3 + 1)));
         tmp_lo_6 = Global_49_ui;
         if ( tmp_lo_5 == tmp_lo_6 )   continue;
         tmp_lo_6 = StringToInteger(tmp_st_4);
         tmp_lo_7 = UID;
         if ( tmp_lo_6 != tmp_lo_7 )   continue;
         tmp_lo_7 = TimeLocal();
         tmp_lo_8=tmp_lo_7 - int(GlobalVariableGet(GlobalVariableName(tmp_in_1)));
         if ( tmp_lo_8 >= 30 )   continue;
         Global_62_bo = true ;
         break;
         
       }
     }
   }
   if ( ( ( Global_50_in != Global_36_in && Local_1_in == Global_36_in && Global_50_in >= 0 ) || ( Global_53_in != Local_6_in && Global_53_in >= 0 && Global_35_in == -999 ) || (Global_50_in != Local_1_in && Global_50_in >= 0 && Global_35_in == -999) ) && !(DisableAutoGMT) )
   {
     lizong_34(); 
   }
   if ( DisableAutoGMT )
   {
     Local_8_st = "Disabled" ;
     if ( DST == 1 )
     {
       Local_8_st = "US" ;
     }
     if ( DST == 2 )
     {
       Local_8_st = "Europe" ;
     }
     Global_34_in=lizong_38(Local_8_st,TimeCurrent()) + GMT_offset;
     Global_35_in = Global_34_in ;
     Global_37_lo = TimeCurrent() ;
   }
   if ( Global_50_in == -1 && Global_35_in == -999 )
   {
     Global_34_in=lizong_38("US",TimeCurrent()) + 0x2;
   }
   if ( Global_35_in != -999 )
   {
     Global_34_in = Global_35_in ;
   }
   if ( NewsFilterEnabled && ( ( Global_52_in != Local_3_in && Global_52_in >= 0 && Local_4_in == 1 ) || ( Global_50_in != Global_36_in && Local_1_in == Global_36_in && Global_50_in >= 0 && Local_2_in == 3 && Local_4_in != 1 ) || ( Global_50_in != Global_36_in && Local_1_in == Global_36_in && Global_50_in >= 0 && Local_2_in == 0 && (NewsListRefreshRate == 2 || NewsListRefreshRate == 0 || NewsListRefreshRate == 1) ) || ( Global_50_in != Global_36_in && Local_1_in == Global_36_in && Global_50_in >= 0 && Local_2_in == 1 && NewsListRefreshRate == 0 ) || ( Global_50_in != Global_36_in && Local_1_in == Global_36_in && Global_50_in >= 0 && Local_2_in == 2 && (NewsListRefreshRate == 0 || NewsListRefreshRate == 1) ) || ( Global_50_in != Global_36_in && Local_1_in == Global_36_in && Global_50_in >= 0 && Local_2_in == 3 && (NewsListRefreshRate == 2 || NewsListRefreshRate == 0) ) || ( Global_50_in != Global_36_in && Local_1_in == Global_36_in && Global_50_in >= 0 && Local_2_in == 4 && (NewsListRefreshRate == 0 || NewsListRefreshRate == 1) ) || ( Global_50_in != Global_36_in && Local_1_in == Global_36_in && Global_50_in >= 0 && Local_2_in == 5 && NewsListRefreshRate == 0 ) || ( Global_50_in != Global_36_in && Local_1_in == Global_36_in && Global_50_in >= 0 && Local_2_in == 6 && (NewsListRefreshRate == 2 || NewsListRefreshRate == 0 || NewsListRefreshRate == 1) ) || ( Global_50_in != Global_36_in && Local_1_in == Global_36_in && Global_50_in >= 0 && Local_2_in == 7 && NewsListRefreshRate == 0 ) || ( Global_50_in != Global_36_in && Local_1_in == Global_36_in && Global_50_in >= 0 && Local_2_in == 8 && (NewsListRefreshRate == 0 || NewsListRefreshRate == 1) ) || ( Global_50_in != Global_36_in && Local_1_in == Global_36_in && Global_50_in >= 0 && Local_2_in == 9 && (NewsListRefreshRate == 2 || NewsListRefreshRate == 0) ) || ( Global_50_in != Global_36_in && Local_1_in == Global_36_in && Global_50_in >= 0 && Local_2_in == 10 && (NewsListRefreshRate == 0 || NewsListRefreshRate == 1) ) || ( Global_50_in != Global_36_in && Local_1_in == Global_36_in && Global_50_in >= 0 && Local_2_in == 11 && NewsListRefreshRate == 0 ) || ( Global_50_in != Global_36_in && Local_1_in == Global_36_in && Global_50_in >= 0 && Local_2_in == 12 && (NewsListRefreshRate == 2 || NewsListRefreshRate == 0 || NewsListRefreshRate == 1) ) || ( Global_50_in != Global_36_in && Local_1_in == Global_36_in && Global_50_in >= 0 && Local_2_in == 13 && NewsListRefreshRate == 0 ) || ( Global_50_in != Global_36_in && Local_1_in == Global_36_in && Global_50_in >= 0 && Local_2_in == 14 && (NewsListRefreshRate == 0 || NewsListRefreshRate == 1) ) || ( Global_50_in != Global_36_in && Local_1_in == Global_36_in && Global_50_in >= 0 && Local_2_in == 15 && (NewsListRefreshRate == 2 || NewsListRefreshRate == 0) ) || ( Global_50_in != Global_36_in && Local_1_in == Global_36_in && Global_50_in >= 0 && Local_2_in == 16 && (NewsListRefreshRate == 0 || NewsListRefreshRate == 1) ) || ( Global_50_in != Global_36_in && Local_1_in == Global_36_in && Global_50_in >= 0 && Local_2_in == 17 && NewsListRefreshRate == 0 ) || ( Global_50_in != Global_36_in && Local_1_in == Global_36_in && Global_50_in >= 0 && Local_2_in == 18 && (NewsListRefreshRate == 2 || NewsListRefreshRate == 0 || NewsListRefreshRate == 1) ) || ( Global_50_in != Global_36_in && Local_1_in == Global_36_in && Global_50_in >= 0 && Local_2_in == 19 && NewsListRefreshRate == 0 ) || ( Global_50_in != Global_36_in && Local_1_in == Global_36_in && Global_50_in >= 0 && Local_2_in == 20 && (NewsListRefreshRate == 0 || NewsListRefreshRate == 1) ) || ( Global_50_in != Global_36_in && Local_1_in == Global_36_in && Global_50_in >= 0 && Local_2_in == 21 && (NewsListRefreshRate == 2 || NewsListRefreshRate == 0) ) || ( Global_50_in != Global_36_in && Local_1_in == Global_36_in && Global_50_in >= 0 && Local_2_in == 22 && (NewsListRefreshRate == 0 || NewsListRefreshRate == 1) ) || ( Global_50_in != Global_36_in && Local_1_in == Global_36_in && Global_50_in >= 0 && Local_2_in == 23 && NewsListRefreshRate == 0 ) || (Global_50_in != Local_1_in && Global_40_in == 0 && Global_41_da == 0) ) )
   {
     lizong_32(DisableTradingOnHolidays); 
   }
   for (tmp_in_9 = 0 ; tmp_in_9 < ArraySize(Global_26_a_168_ko) ; tmp_in_9=tmp_in_9 + 1)
   {
     iTime(Global_26_a_168_ko[tmp_in_9].st_1,5,0); 
     iTime(Global_26_a_168_ko[tmp_in_9].st_1,1440,0); 
   }
   if ( StockMarketFilterEnabled )
   {
     iTime(StockMarketSymbol,60,0); 
   }
   if ( ShowPanel )
   {
     lizong_26(false); 
   }
 }
 Global_31_lo = TimeCurrent() ;
 Global_50_in = Local_1_in ;
 Global_52_in = Local_3_in ;
 Global_53_in = Local_6_in ;
 }
//OnTimer <<==--------   --------
 void OnChartEvent( const int Para_0_in,const long & Para_1_lo,const double & Para_2_do,const string & Para_3_st)
 {
 }
//OnChartEvent <<==--------   --------
 void OnDeinit( const int Para_0_in)
 {
 string     tmp_st_1;

 EventKillTimer(); 
 tmp_st_1 = "";
 switch(Para_0_in)
 {
   case 6 :
   tmp_st_1 = "Account changed";
     break;
   case 3 :
   tmp_st_1 = "Symbol/timeframe changed";
     break;
   case 4 :
   tmp_st_1 = "Chart closed";
     break;
   case 5 :
   tmp_st_1 = "Input parameters changed";
     break;
   case 2 :
   tmp_st_1 = "Expert recompiled";
     break;
   case 1 :
   tmp_st_1 = "Expert removed from the chart";
     break;
   case 7 :
   tmp_st_1 = "New template applied to the chart";
     break;
   default :
   tmp_st_1 = "Expert stopped";
 }
 Print(tmp_st_1); 
 lizong_41(Para_0_in); 
 if ( IsTesting() || IsOptimization() )   return;
 ObjectsDeleteAll(0,-1); 
 }
//OnDeinit <<==--------   --------

 int lizong_10( int Para_0_in)
 {
  int       Local_1_in;
//----- -----

 switch(Para_0_in)
 {
   case 0 :
   return(0); 
   case 1 :
   return(1); 
   case 5 :
   return(5); 
   case 15 :
   return(15); 
   case 30 :
   return(30); 
   case 60 :
   return(60); 
   case 240 :
   return(240); 
   case 1440 :
   return(1440); 
   case 10080 :
   return(10080); 
   case 43200 :
   return(43200); 
 }
 return(0); 
 }
//lizong_10 <<==--------   --------
 string lizong_11( int Para_0_in)
 {
  int       Local_1_in = 0;
  string    Local_2_st;
//----- -----
 string     tmp_st_1;

 if ( Para_0_in == -1 )
 {
   Local_1_in = GetLastError() ;
 }
 else
 {
   Local_1_in = Para_0_in ;
 }
 Local_2_st = " Err.code=" + IntegerToString(Local_1_in,0,32) + ": " ;
 switch(Local_1_in)
 {
   case 0 :
   tmp_st_1 = Local_2_st + "No error returned";
   return(tmp_st_1);
   case 1 :
   tmp_st_1 = Local_2_st + "No error returned, but the result is unknown";
   return(tmp_st_1);
   case 2 :
   tmp_st_1 = Local_2_st + "Common error";
   return(tmp_st_1);
   case 3 :
   tmp_st_1 = Local_2_st + "Invalid trade parameters";
   return(tmp_st_1);
   case 4 :
   tmp_st_1 = Local_2_st + "Trade server is busy";
   return(tmp_st_1);
   case 5 :
   tmp_st_1 = Local_2_st + "Old version of the client terminal";
   return(tmp_st_1);
   case 6 :
   tmp_st_1 = Local_2_st + "No connection with trade server";
   return(tmp_st_1);
   case 7 :
   tmp_st_1 = Local_2_st + "Not enough rights";
   return(tmp_st_1);
   case 8 :
   tmp_st_1 = Local_2_st + "Too frequent requests";
   return(tmp_st_1);
   case 9 :
   tmp_st_1 = Local_2_st + "Malfunctional trade operation";
   return(tmp_st_1);
   case 64 :
   tmp_st_1 = Local_2_st + "Account disabled";
   return(tmp_st_1);
   case 65 :
   tmp_st_1 = Local_2_st + "Invalid account";
   return(tmp_st_1);
   case 128 :
   tmp_st_1 = Local_2_st + "Trade timeout";
   return(tmp_st_1);
   case 129 :
   tmp_st_1 = Local_2_st + "Invalid price";
   return(tmp_st_1);
   case 130 :
   tmp_st_1 = Local_2_st + "Invalid stops";
   return(tmp_st_1);
   case 131 :
   tmp_st_1 = Local_2_st + "Invalid trade volume";
   return(tmp_st_1);
   case 132 :
   tmp_st_1 = Local_2_st + "Market is closed";
   return(tmp_st_1);
   case 133 :
   tmp_st_1 = Local_2_st + "Trade is disabled";
   return(tmp_st_1);
   case 134 :
   tmp_st_1 = Local_2_st + "Not enough money";
   return(tmp_st_1);
   case 135 :
   tmp_st_1 = Local_2_st + "Price changed";
   return(tmp_st_1);
   case 136 :
   tmp_st_1 = Local_2_st + "Off quotes";
   return(tmp_st_1);
   case 137 :
   tmp_st_1 = Local_2_st + "Broker is busy";
   return(tmp_st_1);
   case 138 :
   tmp_st_1 = Local_2_st + "Requote";
   return(tmp_st_1);
   case 139 :
   tmp_st_1 = Local_2_st + "Order is locked";
   return(tmp_st_1);
   case 140 :
   tmp_st_1 = Local_2_st + "Buy orders only allowed";
   return(tmp_st_1);
   case 141 :
   tmp_st_1 = Local_2_st + "Too many requests";
   return(tmp_st_1);
   case 145 :
   tmp_st_1 = Local_2_st + "Modification denied because order is too close to market";
   return(tmp_st_1);
   case 146 :
   tmp_st_1 = Local_2_st + "Trade context is busy";
   return(tmp_st_1);
   case 147 :
   tmp_st_1 = Local_2_st + "Expirations are denied by broker";
   return(tmp_st_1);
   case 148 :
   tmp_st_1 = Local_2_st + "The amount of open and pending orders has reached the limit set by the broker";
   return(tmp_st_1);
   case 149 :
   tmp_st_1 = Local_2_st + "An attempt to open an order opposite to the existing one when hedging is disabled";
   return(tmp_st_1);
   case 150 :
   tmp_st_1 = Local_2_st + "An attempt to close an order contravening the FIFO rule";
   return(tmp_st_1);
   case 4000 :
   tmp_st_1 = Local_2_st + "No error returned";
   return(tmp_st_1);
   case 4001 :
   tmp_st_1 = Local_2_st + "Wrong function pointer";
   return(tmp_st_1);
   case 4002 :
   tmp_st_1 = Local_2_st + "Array index is out of range";
   return(tmp_st_1);
   case 4003 :
   tmp_st_1 = Local_2_st + "No memory for function call stack";
   return(tmp_st_1);
   case 4004 :
   tmp_st_1 = Local_2_st + "Recursive stack overflow";
   return(tmp_st_1);
   case 4005 :
   tmp_st_1 = Local_2_st + "Not enough stack for parameter";
   return(tmp_st_1);
   case 4006 :
   tmp_st_1 = Local_2_st + "No memory for parameter string";
   return(tmp_st_1);
   case 4007 :
   tmp_st_1 = Local_2_st + "No memory for temp string";
   return(tmp_st_1);
   case 4008 :
   tmp_st_1 = Local_2_st + "Not initialized string";
   return(tmp_st_1);
   case 4009 :
   tmp_st_1 = Local_2_st + "Not initialized string in array";
   return(tmp_st_1);
   case 4010 :
   tmp_st_1 = Local_2_st + "No memory for array string";
   return(tmp_st_1);
   case 4011 :
   tmp_st_1 = Local_2_st + "Too long string";
   return(tmp_st_1);
   case 4012 :
   tmp_st_1 = Local_2_st + "Remainder from zero divide";
   return(tmp_st_1);
   case 4013 :
   tmp_st_1 = Local_2_st + "Zero divide";
   return(tmp_st_1);
   case 4014 :
   tmp_st_1 = Local_2_st + "Unknown command";
   return(tmp_st_1);
   case 4015 :
   tmp_st_1 = Local_2_st + "Wrong jump (never generated error)";
   return(tmp_st_1);
   case 4016 :
   tmp_st_1 = Local_2_st + "Not initialized array";
   return(tmp_st_1);
   case 4017 :
   tmp_st_1 = Local_2_st + "DLL calls are not allowed";
   return(tmp_st_1);
   case 4018 :
   tmp_st_1 = Local_2_st + "Cannot load library";
   return(tmp_st_1);
   case 4019 :
   tmp_st_1 = Local_2_st + "Cannot call function";
   return(tmp_st_1);
   case 4020 :
   tmp_st_1 = Local_2_st + "Expert function calls are not allowed";
   return(tmp_st_1);
   case 4021 :
   tmp_st_1 = Local_2_st + "Not enough memory for temp string returned from function";
   return(tmp_st_1);
   case 4022 :
   tmp_st_1 = Local_2_st + " System is busy (never generated error)";
   return(tmp_st_1);
   case 4023 :
   tmp_st_1 = Local_2_st + "DLL-function call critical error";
   return(tmp_st_1);
   case 4024 :
   tmp_st_1 = Local_2_st + "Internal error";
   return(tmp_st_1);
   case 4025 :
   tmp_st_1 = Local_2_st + "Out of memory";
   return(tmp_st_1);
   case 4026 :
   tmp_st_1 = Local_2_st + "Invalid pointer";
   return(tmp_st_1);
   case 4027 :
   tmp_st_1 = Local_2_st + "Too many formatters in the format function";
   return(tmp_st_1);
   case 4028 :
   tmp_st_1 = Local_2_st + "Parameters count exceeds formatters count";
   return(tmp_st_1);
   case 4029 :
   tmp_st_1 = Local_2_st + "Invalid array";
   return(tmp_st_1);
   case 4030 :
   tmp_st_1 = Local_2_st + "No reply from chart";
   return(tmp_st_1);
   case 4050 :
   tmp_st_1 = Local_2_st + "Invalid function parameters count";
   return(tmp_st_1);
   case 4051 :
   tmp_st_1 = Local_2_st + "Invalid function parameter value";
   return(tmp_st_1);
   case 4052 :
   tmp_st_1 = Local_2_st + "String function internal error";
   return(tmp_st_1);
   case 4053 :
   tmp_st_1 = Local_2_st + "Some array error";
   return(tmp_st_1);
   case 4054 :
   tmp_st_1 = Local_2_st + "Incorrect series array using";
   return(tmp_st_1);
   case 4055 :
   tmp_st_1 = Local_2_st + "Custom indicator error";
   return(tmp_st_1);
   case 4056 :
   tmp_st_1 = Local_2_st + "Arrays are incompatible";
   return(tmp_st_1);
   case 4057 :
   tmp_st_1 = Local_2_st + "Global variables processing error";
   return(tmp_st_1);
   case 4058 :
   tmp_st_1 = Local_2_st + "Global variable not found";
   return(tmp_st_1);
   case 4059 :
   tmp_st_1 = Local_2_st + "Function is not allowed in testing mode";
   return(tmp_st_1);
   case 4060 :
   tmp_st_1 = Local_2_st + "Function is not allowed for call";
   return(tmp_st_1);
   case 4061 :
   tmp_st_1 = Local_2_st + "Send mail error";
   return(tmp_st_1);
   case 4062 :
   tmp_st_1 = Local_2_st + "String parameter expected";
   return(tmp_st_1);
   case 4063 :
   tmp_st_1 = Local_2_st + "Integer parameter expected";
   return(tmp_st_1);
   case 4064 :
   tmp_st_1 = Local_2_st + "Double parameter expected";
   return(tmp_st_1);
   case 4065 :
   tmp_st_1 = Local_2_st + "Array as parameter expected";
   return(tmp_st_1);
   case 4066 :
   tmp_st_1 = Local_2_st + "Requested history data is in updating state";
   return(tmp_st_1);
   case 4067 :
   tmp_st_1 = Local_2_st + "Internal trade error";
   return(tmp_st_1);
   case 4068 :
   tmp_st_1 = Local_2_st + "Resource not found";
   return(tmp_st_1);
   case 4069 :
   tmp_st_1 = Local_2_st + "Resource not supported";
   return(tmp_st_1);
   case 4070 :
   tmp_st_1 = Local_2_st + "Duplicate resource";
   return(tmp_st_1);
   case 4071 :
   tmp_st_1 = Local_2_st + "Custom indicator cannot initialize";
   return(tmp_st_1);
   case 4072 :
   tmp_st_1 = Local_2_st + "Cannot load custom indicator";
   return(tmp_st_1);
   case 4073 :
   tmp_st_1 = Local_2_st + "No history data";
   return(tmp_st_1);
   case 4074 :
   tmp_st_1 = Local_2_st + "No memory for history data";
   return(tmp_st_1);
   case 4075 :
   tmp_st_1 = Local_2_st + "Not enough memory for indicator calculation";
   return(tmp_st_1);
   case 4099 :
   tmp_st_1 = Local_2_st + "End of file";
   return(tmp_st_1);
   case 4100 :
   tmp_st_1 = Local_2_st + "Some file error";
   return(tmp_st_1);
   case 4101 :
   tmp_st_1 = Local_2_st + "Wrong file name";
   return(tmp_st_1);
   case 4102 :
   tmp_st_1 = Local_2_st + "Too many opened files";
   return(tmp_st_1);
   case 4103 :
   tmp_st_1 = Local_2_st + "Cannot open file";
   return(tmp_st_1);
   case 4104 :
   tmp_st_1 = Local_2_st + "Incompatible access to a file";
   return(tmp_st_1);
   case 4105 :
   tmp_st_1 = Local_2_st + "No order selected";
   return(tmp_st_1);
   case 4106 :
   tmp_st_1 = Local_2_st + "Unknown symbol";
   return(tmp_st_1);
   case 4107 :
   tmp_st_1 = Local_2_st + "Invalid price";
   return(tmp_st_1);
   case 4108 :
   tmp_st_1 = Local_2_st + "Invalid ticket";
   return(tmp_st_1);
   case 4109 :
   tmp_st_1 = Local_2_st + "Trade is not allowed. Enable checkbox \'Allow live trading\' in the Expert Advisor properties";
   return(tmp_st_1);
   case 4110 :
   tmp_st_1 = Local_2_st + "Longs are not allowed. Check the Expert Advisor properties";
   return(tmp_st_1);
   case 4111 :
   tmp_st_1 = Local_2_st + "Shorts are not allowed. Check the Expert Advisor properties";
   return(tmp_st_1);
   case 4112 :
   tmp_st_1 = Local_2_st + "Automated trading by Expert Advisors/Scripts disabled by trade server";
   return(tmp_st_1);
   case 4200 :
   tmp_st_1 = Local_2_st + "Object already exists";
   return(tmp_st_1);
   case 4201 :
   tmp_st_1 = Local_2_st + "Unknown object property";
   return(tmp_st_1);
   case 4202 :
   tmp_st_1 = Local_2_st + "Object does not exist";
   return(tmp_st_1);
   case 4203 :
   tmp_st_1 = Local_2_st + "Unknown object type";
   return(tmp_st_1);
   case 4204 :
   tmp_st_1 = Local_2_st + "No object name";
   return(tmp_st_1);
   case 4205 :
   tmp_st_1 = Local_2_st + "Object coordinates error";
   return(tmp_st_1);
   case 4206 :
   tmp_st_1 = Local_2_st + "No specified subwindow";
   return(tmp_st_1);
   case 4207 :
   tmp_st_1 = Local_2_st + "Graphical object error";
   return(tmp_st_1);
   case 4210 :
   tmp_st_1 = Local_2_st + "Unknown chart property";
   return(tmp_st_1);
   case 4211 :
   tmp_st_1 = Local_2_st + "Chart not found";
   return(tmp_st_1);
   case 4212 :
   tmp_st_1 = Local_2_st + "Chart subwindow not found";
   return(tmp_st_1);
   case 4213 :
   tmp_st_1 = Local_2_st + "Chart indicator not found";
   return(tmp_st_1);
   case 4220 :
   tmp_st_1 = Local_2_st + "Symbol select error";
   return(tmp_st_1);
   case 4250 :
   tmp_st_1 = Local_2_st + "Notification error";
   return(tmp_st_1);
   case 4251 :
   tmp_st_1 = Local_2_st + "Notification parameter error";
   return(tmp_st_1);
   case 4252 :
   tmp_st_1 = Local_2_st + "Notifications disabled";
   return(tmp_st_1);
   case 4253 :
   tmp_st_1 = Local_2_st + "Notification send too frequent";
   return(tmp_st_1);
   case 4260 :
   tmp_st_1 = Local_2_st + "FTP server is not specified";
   return(tmp_st_1);
   case 4261 :
   tmp_st_1 = Local_2_st + "FTP login is not specified";
   return(tmp_st_1);
   case 4262 :
   tmp_st_1 = Local_2_st + "FTP connection failed";
   return(tmp_st_1);
   case 4263 :
   tmp_st_1 = Local_2_st + "FTP connection closed";
   return(tmp_st_1);
   case 4264 :
   tmp_st_1 = Local_2_st + "FTP path not found on server";
   return(tmp_st_1);
   case 4265 :
   tmp_st_1 = Local_2_st + "File not found in the MQL4\\Files directory to send on FTP server";
   return(tmp_st_1);
   case 4266 :
   tmp_st_1 = Local_2_st + "Common error during FTP data transmission";
   return(tmp_st_1);
   case 5001 :
   tmp_st_1 = Local_2_st + "Too many opened files";
   return(tmp_st_1);
   case 5002 :
   tmp_st_1 = Local_2_st + "Wrong file name";
   return(tmp_st_1);
   case 5003 :
   tmp_st_1 = Local_2_st + "Too long file name";
   return(tmp_st_1);
   case 5004 :
   tmp_st_1 = Local_2_st + "Cannot open file";
   return(tmp_st_1);
   case 5005 :
   tmp_st_1 = Local_2_st + "Text file buffer allocation error";
   return(tmp_st_1);
   case 5006 :
   tmp_st_1 = Local_2_st + "Cannot delete file";
   return(tmp_st_1);
   case 5007 :
   tmp_st_1 = Local_2_st + "Invalid file handle (file closed or was not opened)";
   return(tmp_st_1);
   case 5008 :
   tmp_st_1 = Local_2_st + "Wrong file handle (handle index is out of handle table)";
   return(tmp_st_1);
   case 5009 :
   tmp_st_1 = Local_2_st + "File must be opened with FILE_WRITE flag";
   return(tmp_st_1);
   case 5010 :
   tmp_st_1 = Local_2_st + "File must be opened with FILE_READ flag";
   return(tmp_st_1);
   case 5011 :
   tmp_st_1 = Local_2_st + "File must be opened with FILE_BIN flag";
   return(tmp_st_1);
   case 5012 :
   tmp_st_1 = Local_2_st + "File must be opened with FILE_TXT flag";
   return(tmp_st_1);
   case 5013 :
   tmp_st_1 = Local_2_st + "File must be opened with FILE_TXT or FILE_CSV flag";
   return(tmp_st_1);
   case 5014 :
   tmp_st_1 = Local_2_st + "File must be opened with FILE_CSV flag";
   return(tmp_st_1);
   case 5015 :
   tmp_st_1 = Local_2_st + "File read error";
   return(tmp_st_1);
   case 5016 :
   tmp_st_1 = Local_2_st + "File write error";
   return(tmp_st_1);
   case 5017 :
   tmp_st_1 = Local_2_st + "String size must be specified for binary file";
   return(tmp_st_1);
   case 5018 :
   tmp_st_1 = Local_2_st + "Incompatible file (for string arrays-TXT, for others-BIN)";
   return(tmp_st_1);
   case 5019 :
   tmp_st_1 = Local_2_st + "File is directory not file";
   return(tmp_st_1);
   case 5020 :
   tmp_st_1 = Local_2_st + "File does not exist";
   return(tmp_st_1);
   case 5021 :
   tmp_st_1 = Local_2_st + "File cannot be rewritten";
   return(tmp_st_1);
   case 5022 :
   tmp_st_1 = Local_2_st + "Wrong directory name";
   return(tmp_st_1);
   case 5023 :
   tmp_st_1 = Local_2_st + "Directory does not exist";
   return(tmp_st_1);
   case 5024 :
   tmp_st_1 = Local_2_st + "Specified file is not directory";
   return(tmp_st_1);
   case 5025 :
   tmp_st_1 = Local_2_st + "Cannot delete directory";
   return(tmp_st_1);
   case 5026 :
   tmp_st_1 = Local_2_st + "Cannot clean directory";
   return(tmp_st_1);
   case 5027 :
   tmp_st_1 = Local_2_st + "Array resize error";
   return(tmp_st_1);
   case 5028 :
   tmp_st_1 = Local_2_st + "String resize error";
   return(tmp_st_1);
   case 5029 :
   tmp_st_1 = Local_2_st + "Structure contains strings or dynamic arrays";
   return(tmp_st_1);
   case 5200 :
   tmp_st_1 = Local_2_st + "Invalid URL";
   return(tmp_st_1);
   case 5201 :
   tmp_st_1 = Local_2_st + "Failed to connect to specified URL";
   return(tmp_st_1);
   case 5202 :
   tmp_st_1 = Local_2_st + "Timeout exceeded";
   return(tmp_st_1);
   case 5203 :
   tmp_st_1 = Local_2_st + "HTTP request failed";
   return(tmp_st_1);
 }
 tmp_st_1 = Local_2_st + "Unknown error number";
 return(tmp_st_1);
 }
//lizong_11 <<==--------   --------
 bool CCanvasX::CCanvasX_12( string Para_0_st)
 {
  bool      Local_2_bo;
  CFileBin  Local_3_a_162;
//----- -----


 //Local_3_a_162.m_handle = -1 ;
 //Local_3_a_162.m_name = "" ;
 //Local_3_a_162.m_flags = 32 ;
 if ( !(ResourceReadImage(Para_0_st,m_pixels,m_width,m_height)) )
 {
  Local_3_a_162.Close();
  // if ( Local_3_a_162.m_handle != -1 )
  // {
  //   FileClose(Local_3_a_162.m_handle); 
  //   Local_3_a_162.m_handle = -1 ;
  //   Local_3_a_162.m_name = "" ;
  //   Local_3_a_162.m_flags &=96;
  // }
  return(false);  // ; 
 }
 Local_3_a_162.Close();
// if ( Local_3_a_162.m_handle != -1 )
 //{
   //FileClose(Local_3_a_162.m_handle); 
   //Local_3_a_162.m_handle = -1 ;
   //Local_3_a_162.m_name = "" ;
   //Local_3_a_162.m_flags &=96;
 //}
  return(true);  
 }
//CCanvasX_12 <<==--------   --------


 bool lizong_21( string Para_0_st,int Para_1_in,int Para_2_in)
 {
  bool      Local_1_bo;
  bool      Local_2_bo = false;
  int       Local_3_in;
  int       Local_4_in;
  int       Local_5_in;
  int       Local_6_in;
  int       Local_7_in;
  int       Local_8_in;
  int       Local_9_in;
  int       Local_10_in;
  int       Local_11_in;
  int       Local_12_in;
  int       Local_13_in;
  int       Local_14_in;
  string    Local_15_st;
  int       Local_16_in;
  int       Local_17_in;
//----- -----
 int        tmp_in_1;
 int        tmp_in_2;
 int        tmp_in_3;
 int        tmp_in_4;

 Local_3_in=Global_28_in + UID;
 Local_4_in=StringLen(IntegerToString(Local_3_in,0,32)); 
 Local_5_in=Local_3_in + int(MathPow(10.0,Local_4_in));
 Local_6_in=Local_3_in + int(MathPow(10.0,Local_4_in)) * 2;
 Local_7_in = -1 ;
 Local_8_in = -1 ;
 Local_9_in = -1 ;
 Local_10_in = -1 ;
 Local_11_in = -1 ;
 Local_12_in = -1 ;
 if ( Para_2_in == 1 )
 {
   Local_7_in = 0 ;
   Local_8_in = 0 ;
   if ( Para_1_in >= 0 )
   {
     Local_9_in=int(MathPow(10.0,StringLen(IntegerToString(Local_3_in,0,32))  + 2)) + Local_3_in * 100 + Para_1_in;
     Local_10_in = Local_9_in ;
   }
   else
   {
     Local_11_in = Local_5_in ;
     Local_12_in = Local_5_in ;
   }
 }
 if ( Para_2_in == -1 )
 {
   Local_7_in = 1 ;
   Local_8_in = 1 ;
   if ( Para_1_in >= 0 )
   {
     Local_9_in=(int(MathPow(10.0,StringLen(IntegerToString(Global_28_in + UID,0,32))  + 2))) * 2 + (Global_28_in + UID) * 100 + Para_1_in;
     Local_10_in = Local_9_in ;
   }
   else
   {
     Local_11_in = Local_6_in ;
     Local_12_in = Local_6_in ;
   }
 }
 if ( Para_2_in == 0 )
 {
   Local_7_in = 0 ;
   Local_8_in = 1 ;
   if ( Para_1_in >= 0 )
   {
     Local_9_in=int(MathPow(10.0,StringLen(IntegerToString(Global_28_in + UID,0,32))  + 2)) + (Global_28_in + UID) * 100 + Para_1_in;
     if ( Para_1_in <  0 )
     {
       tmp_in_1 = -1;
     }
     else
     {
       tmp_in_2 = Global_28_in + UID;
       tmp_in_3 = StringLen(IntegerToString(tmp_in_2,0,32)) ;
       tmp_in_4 = 0;
       if ( -1 == 1 )
       {
         tmp_in_4 = 1;
       }
       if ( -1 == -1 )
       {
         tmp_in_4 = 2;
       }
       tmp_in_1 = int(MathPow(10.0,tmp_in_3 + 2)) * tmp_in_4 + tmp_in_2 * 100 + Para_1_in;
     }
     Local_10_in = tmp_in_1 ;
   }
   else
   {
     Local_11_in = Local_5_in ;
     Local_12_in = Local_6_in ;
   }
 }
 for (Local_13_in = 0 ; Local_13_in < OrdersTotal() ; Local_13_in ++)
 {
   if ( OrderSelect(Local_13_in,0,0) )
   {
     Local_14_in = OrderType() ;
     Local_15_st = OrderSymbol() ;
     Local_16_in = OrderMagicNumber() ;
     Local_17_in=Local_16_in / 100;
     if ( Para_1_in >= 0 && Local_15_st == Para_0_st && ( ( Local_16_in == Local_9_in && Local_14_in == Local_7_in ) || (Local_16_in == Local_10_in && Local_14_in == Local_8_in) ) )
     {
       return(true); 
     }
     if ( Para_1_in <  0 && Local_15_st == Para_0_st && ( ( Local_17_in == Local_11_in && Local_14_in == Local_7_in ) || (Local_17_in == Local_12_in && Local_14_in == Local_8_in) ) )
     {
       return(true); 
     }
   }
   else
   {
     Print(TradeComment + " " + Para_0_st,": Failed to select an order! Error=",lizong_11(GetLastError())); 
     Local_2_bo = true ;
   }
 }
 return(Local_2_bo); 
 }
//lizong_21 <<==--------   --------
 double lizong_22( string Para_0_st,int Para_1_in,int Para_2_in,bool Para_3_bo)
 {
  double    Local_1_do;
  double    Local_2_do = 0.0;
  int       Local_3_in;
  int       Local_4_in;
  int       Local_5_in;
  int       Local_6_in;
  int       Local_7_in;
  int       Local_8_in;
  int       Local_9_in;
  int       Local_10_in;
  int       Local_11_in;
  int       Local_12_in;
  int       Local_13_in;
  int       Local_14_in;
  double    Local_15_do;
  int       Local_16_in;
  int       Local_17_in;
  string    Local_18_st;
  int       Local_19_in;
  double    Local_20_do;
  int       Local_21_in;
  double    Local_22_do;
  double    Local_23_do;
//----- -----
 int        tmp_in_1;
 int        tmp_in_2;
 int        tmp_in_3;
 int        tmp_in_4;

 Local_3_in=Global_28_in + UID;
 Local_4_in=StringLen(IntegerToString(Local_3_in,0,32)); 
 Local_5_in=Local_3_in + int(MathPow(10.0,Local_4_in));
 Local_6_in=Local_3_in + int(MathPow(10.0,Local_4_in)) * 2;
 Local_7_in = -1 ;
 Local_8_in = -1 ;
 Local_9_in = -1 ;
 Local_10_in = -1 ;
 Local_11_in = -1 ;
 Local_12_in = -1 ;
 if ( Para_2_in == 1 )
 {
   Local_7_in = 0 ;
   Local_8_in = 0 ;
   if ( Para_1_in >= 0 )
   {
     Local_9_in=int(MathPow(10.0,StringLen(IntegerToString(Local_3_in,0,32))  + 2)) + Local_3_in * 100 + Para_1_in;
     Local_10_in = Local_9_in ;
   }
   else
   {
     Local_11_in = Local_5_in ;
     Local_12_in = Local_5_in ;
   }
 }
 if ( Para_2_in == -1 )
 {
   Local_7_in = 1 ;
   Local_8_in = 1 ;
   if ( Para_1_in >= 0 )
   {
     Local_9_in=(int(MathPow(10.0,StringLen(IntegerToString(Global_28_in + UID,0,32))  + 2))) * 2 + (Global_28_in + UID) * 100 + Para_1_in;
     Local_10_in = Local_9_in ;
   }
   else
   {
     Local_11_in = Local_6_in ;
     Local_12_in = Local_6_in ;
   }
 }
 if ( Para_2_in == 0 )
 {
   Local_7_in = 0 ;
   Local_8_in = 1 ;
   if ( Para_1_in >= 0 )
   {
     Local_9_in=int(MathPow(10.0,StringLen(IntegerToString(Global_28_in + UID,0,32))  + 2)) + (Global_28_in + UID) * 100 + Para_1_in;
     if ( Para_1_in <  0 )
     {
       tmp_in_1 = -1;
     }
     else
     {
       tmp_in_2 = Global_28_in + UID;
       tmp_in_3 = StringLen(IntegerToString(tmp_in_2,0,32)) ;
       tmp_in_4 = 0;
       if ( -1 == 1 )
       {
         tmp_in_4 = 1;
       }
       if ( -1 == -1 )
       {
         tmp_in_4 = 2;
       }
       tmp_in_1 = int(MathPow(10.0,tmp_in_3 + 2)) * tmp_in_4 + tmp_in_2 * 100 + Para_1_in;
     }
     Local_10_in = tmp_in_1 ;
   }
   else
   {
     Local_11_in = Local_5_in ;
     Local_12_in = Local_6_in ;
   }
 }
 Local_13_in = 0 ;
 Local_14_in = -1 ;
 if ( Para_2_in == 1 )
 {
   Local_14_in = 0 ;
   Local_13_in = 1 ;
 }
 if ( Para_2_in == -1 )
 {
   Local_14_in = 1 ;
   Local_13_in = 2 ;
 }
 Local_15_do = 0.0 ;
 if ( Global_86_bo && Para_3_bo && Global_87_in >  1 && !(Global_80_bo) )
 {
   Local_15_do = 0.01 ;
 }
 for (Local_16_in = 0 ; Local_16_in < OrdersTotal() ; Local_16_in ++)
 {
   if ( OrderSelect(Local_16_in,0,0) )
   {
     Local_17_in = OrderType() ;
     Local_18_st = OrderSymbol() ;
     Local_19_in = OrderMagicNumber() ;
     Local_20_do = OrderLots() ;
     Local_21_in=Local_19_in / 100;
     if ( Para_1_in >= 0 && Local_18_st == Para_0_st && ( ( Local_19_in == Local_9_in && Local_17_in == Local_7_in ) || (Local_19_in == Local_10_in && Local_17_in == Local_8_in) ) )
     {
       if ( !(Para_3_bo) )
       {
         Local_2_do = Local_2_do + Local_20_do ;
       }
       else
       {
         if ( Global_86_bo && Para_3_bo && Global_87_in >  1 && Local_15_do>Global_29_do && !(Global_80_bo) )
         {
           Local_22_do=Local_19_in - Local_19_in / 100 * 100;
           if ( Local_22_do == 0.0 )
           {
             Local_20_do = Local_15_do ;
           }
           if ( Local_22_do >  0 )
           {
             Local_20_do = Local_15_do ;
           }
         }
         Local_2_do = Local_2_do + Local_20_do ;
       }
       if ( !(Global_80_bo) )
       {
         break;
       }
     }
     if ( Para_1_in <  0 && Local_18_st == Para_0_st && ( ( Local_21_in == Local_11_in && Local_17_in == Local_7_in ) || (Local_21_in == Local_12_in && Local_17_in == Local_8_in) ) )
     {
       if ( !(Para_3_bo) )
       {
         Local_2_do = Local_2_do + Local_20_do ;
       }
       else
       {
         if ( Global_86_bo && Para_3_bo && Global_87_in >  1 && Local_15_do>Global_29_do && !(Global_80_bo) )
         {
           Local_23_do=Local_19_in - Local_19_in / 100 * 100;
           if ( Local_23_do == 0.0 )
           {
             Local_20_do = Local_15_do ;
           }
           if ( Local_23_do >  0 )
           {
             Local_20_do = Local_15_do ;
           }
         }
         Local_2_do = Local_2_do + Local_20_do ;
       }
     }
   }
   else
   {
     Print(TradeComment + " " + Para_0_st,": Failed to select an order! Error=",lizong_11(GetLastError())); 
   }
 }
 return(Local_2_do); 
 }
//lizong_22 <<==--------   --------
 void lizong_23( int Para_0_in)
 {
  string    Local_1_st;
  int       Local_2_in;
  int       Local_3_in;
  int       Local_4_in;
  int       Local_5_in;
  int       Local_6_in;
  int       Local_7_in;
  int       Local_8_in;
  int       Local_9_in;
  string    Local_10_st;
  double    Local_11_do;
  int       Local_12_in;
  double    Local_13_do;
  double    Local_14_do;
  double    Local_15_do;
  double    Local_16_do;
  double    Local_17_do;
//----- -----
 double     tmp_do_1;
 int        tmp_in_2;
 double     tmp_do_3;
 double     tmp_do_4;

 if ( OrdersTotal() == 0 )   return;
 Local_1_st = Global_26_a_168_ko[Para_0_in].st_1 ;
 Local_2_in=Global_28_in + UID;
 Local_3_in=StringLen(IntegerToString(Local_2_in,0,32)); 
 Local_4_in=Local_2_in + int(MathPow(10.0,Local_3_in));
 Local_5_in=Local_2_in + int(MathPow(10.0,Local_3_in)) * 2;
 if ( !(Global_70_bo) )
 {
   for (Local_6_in = 0 ; Local_6_in < 2 ; Local_6_in ++)
   {
     Local_7_in = 0 ;
     if ( OrdersTotal() <= 0 )   continue;
     
     for ( ; Local_7_in < OrdersTotal() ; Local_7_in ++)
     {
       if ( OrderSelect(Local_7_in,0,0) )
       {
         Local_8_in = OrderTicket() ;
         Local_9_in = OrderType() ;
         Local_10_st = OrderSymbol() ;
         Local_11_do = OrderLots() ;
         Local_12_in = OrderMagicNumber() ;
         Local_13_do = OrderTakeProfit() ;
         Local_14_do = OrderStopLoss() ;
         Local_15_do = OrderOpenTime() ;
         Local_16_do = OrderOpenPrice() ;
         tmp_do_1 = 0.0;
         if ( MarketInfo(Local_1_st,16) * Local_11_do>Global_29_do )
         {
           tmp_in_2 = MarketInfo(Local_1_st,12);
           tmp_do_3 = (OrderCommission() + OrderSwap()) / (MarketInfo(Local_1_st,16) * Local_11_do);
           if ( MarketInfo(Local_1_st,11)>Global_29_do )
           {
             tmp_do_4 = MarketInfo(Local_1_st,11);
           }
           else
           {
             tmp_do_4 = 0.00001;
           }
           tmp_do_3 = tmp_do_3 * tmp_do_4;
           tmp_do_1 = NormalizeDouble(tmp_do_3,tmp_in_2);
         }
         Local_17_do = tmp_do_1 ;
         if ( Local_6_in == 0 && Local_9_in == 0 && Local_10_st == Local_1_st && Local_12_in / 100 == Local_4_in )
         {
           lizong_56(Para_0_in,Local_8_in,Local_9_in,Local_10_st,Local_11_do,Local_12_in,Local_13_do,Local_14_do,Local_15_do,Local_16_do,Local_17_do); 
         }
         if ( Local_6_in == 1 && Local_9_in == 1 && Local_10_st == Local_1_st && Local_12_in / 100 == Local_5_in )
         {
           lizong_57(Para_0_in,Local_8_in,Local_9_in,Local_10_st,Local_11_do,Local_12_in,Local_13_do,Local_14_do,Local_15_do,Local_16_do,Local_17_do); 
         }
       }
       else
       {
         Print(TradeComment + " " + Local_1_st,": Failed to select an order! Error=",lizong_11(GetLastError())); 
       }
     }
     
   }
 }
 }
//lizong_23 <<==--------   --------
 void lizong_24( int Para_0_in)
 {
  string    Local_1_st;
  int       Local_2_in;
  int       Local_3_in;
  int       Local_4_in;
  int       Local_5_in;
  int       Local_6_in;
  int       Local_7_in;
  int       Local_8_in;
  int       Local_9_in;
  int       Local_10_in;
  int       Local_11_in;
  string    Local_12_st;
  double    Local_13_do;
  int       Local_14_in;
  double    Local_15_do;
  double    Local_16_do;
  long      Local_17_lo;
  double    Local_18_do;
  double    Local_19_do;
  bool      Local_20_bo;
  bool      Local_21_bo;
//----- -----
 double     tmp_do_1;
 int        tmp_in_2;
 double     tmp_do_3;
 double     tmp_do_4;

 if ( OrdersTotal() == 0 )   return;
 Local_1_st = Global_26_a_168_ko[Para_0_in].st_1 ;
 Local_2_in=Global_28_in + UID;
 Local_3_in=StringLen(IntegerToString(Local_2_in,0,32)); 
 Local_4_in=Local_2_in + int(MathPow(10.0,Local_3_in));
 Local_5_in=Local_2_in + int(MathPow(10.0,Local_3_in)) * 2;
 Local_6_in = OrdersTotal() ;
 if ( Local_6_in >  99 )
 {
   Local_6_in = 99 ;
 }
 for (Local_7_in = 0 ; Local_7_in < 2 ; Local_7_in ++)
 {
   Local_8_in = 0 ;
   if ( Local_6_in <= 0 )   continue;
   
   for ( ; Local_8_in < Local_6_in ; Local_8_in ++)
   {
     Local_9_in = 0 ;
     if ( OrdersTotal() <= 0 )   continue;
     
     for ( ; Local_9_in < OrdersTotal() ; Local_9_in ++)
     {
       if ( OrderSelect(Local_9_in,0,0) )
       {
         Local_10_in = OrderTicket() ;
         Local_11_in = OrderType() ;
         Local_12_st = OrderSymbol() ;
         Local_13_do = OrderLots() ;
         Local_14_in = OrderMagicNumber() ;
         Local_15_do = OrderTakeProfit() ;
         Local_16_do = OrderStopLoss() ;
         Local_17_lo = OrderOpenTime() ;
         Local_18_do = OrderOpenPrice() ;
         tmp_do_1 = 0.0;
         if ( MarketInfo(Local_1_st,16) * Local_13_do>Global_29_do )
         {
           tmp_in_2 = MarketInfo(Local_1_st,12);
           tmp_do_3 = (OrderCommission() + OrderSwap()) / (MarketInfo(Local_1_st,16) * Local_13_do);
           if ( MarketInfo(Local_1_st,11)>Global_29_do )
           {
             tmp_do_4 = MarketInfo(Local_1_st,11);
           }
           else
           {
             tmp_do_4 = 0.00001;
           }
           tmp_do_3 = tmp_do_3 * tmp_do_4;
           tmp_do_1 = NormalizeDouble(tmp_do_3,tmp_in_2);
         }
         Local_19_do = tmp_do_1 ;
         if ( Local_7_in == 0 && Local_11_in == 0 && Local_12_st == Local_1_st && Local_14_in / 100 == Local_4_in )
         {
           Local_20_bo = lizong_54(Para_0_in,Local_10_in,Local_11_in,Local_12_st,Local_13_do,Local_14_in,Local_15_do,Local_16_do,Local_17_lo,Local_18_do,Local_19_do) ;
           if ( Local_20_bo )
           {
             break;
           }
         }
         if ( Local_7_in == 1 && Local_11_in == 1 && Local_12_st == Local_1_st && Local_14_in / 100 == Local_5_in )
         {
           Local_21_bo = lizong_55(Para_0_in,Local_10_in,Local_11_in,Local_12_st,Local_13_do,Local_14_in,Local_15_do,Local_16_do,Local_17_lo,Local_18_do,Local_19_do) ;
           if ( Local_21_bo )
           {
             break;
           }
         }
       }
       else
       {
         Print(TradeComment + " " + Local_1_st,": Failed to select an order! Error=",lizong_11(GetLastError())); 
       }
     }
     
   }
   
 }
 }
//lizong_24 <<==--------   --------
 void lizong_25()
 {
  double    Local_1_do_ko[];
  int       Local_2_in;
  int       Local_3_in;
//----- -----

 ArrayResize(Local_1_do_ko,Global_16_in,0); 
 ArrayFill(Local_1_do_ko,0,Global_16_in,0.0);
 Local_2_in = -1 ;
 Global_23_in = -1 ;
 Local_2_in=-1 + 1;
 Local_1_do_ko[Local_2_in] = 61236.00265007;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 61143.00269938;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 51386.00297298;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 64764.00299257;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 47349.00297015;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 62159.00298827;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 51035.00311509;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 17875.00311758;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 56541.00285231;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 48946.00279337;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 3906.002674139;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 54699.00262924;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 56120.00263881;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 58619.00273539;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 54666.00274826;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 39921.00293527;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 54671.00294744;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 15017.00298929;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 55723.00280905;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 21755.00284578;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 63244.00286703;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 16712.00283476;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 54699.00298562;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 8740.002856681;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 18052.00286824;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 14802.00285638;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 53783.00290701;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 22281.00290509;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 54134.00299206;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 56185.00315187;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 48962.0031356;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 21815.00323045;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 39089.00316359;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 64967.00320245;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 46873.00321206;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 44993.00326936;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 56202.0032788;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 54588.0035873;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 59476.003611;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 57287.00368454;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 46858.00373393;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 44267.00377051;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 55512.00378641;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 63854.00343406;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 63758.00351681;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 65148.00352274;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 8833.00349746;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 960.0035145227;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 6160.003408205;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 60306.00331801;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 17934.00334669;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 63918.00333797;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 10944.00335297;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 11652.00327129;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 58331.00317757;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 2261.003158943;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 11832.00305633;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 101.0030165852;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 62379.00308667;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 2737.003037008;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 60058.00301642;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 60015.00269473;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 63041.00276474;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 62668.00279996;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 644.0027281023;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 1216.002706168;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 713.0024824953;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 64562.00253801;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 60601.00262574;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 59739.00265163;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 34075.00265992;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 10675.00242327;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 11382.00239365;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 10254.00245073;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 61107.00255508;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 49003.00240039;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 6818.002382016;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 1248.002399697;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 39613.00249073;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 62777.00241576;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 5976.002302699;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 64434.00250398;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 8829.002704395;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 45495.00268026;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 2099.002487509;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 6023.002532096;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 65240.00251873;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 58907.00234238;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 17720.00227332;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 49754.00248645;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 1347.002544079;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 48326.00255439;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 56475.002641;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 60315.00263468;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 53217.00268699;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 59742.00277136;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 63096.00269907;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 8808.002663169;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 55097.0026155;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 47836.00268879;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 64083.00269358;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 47817.00244208;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 53245.00244618;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 287.0024673144;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 9925.002469231;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 35509.00255088;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 14516.00242724;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 64559.00242209;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 60409.00251557;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 65291.00242076;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 8215.002429096;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 52152.00249645;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 55745.00257733;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 10233.00252088;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 4711.002506297;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 44628.00257861;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 5851.002657202;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 56309.00288395;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 63229.00288953;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 48178.0026628;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 46390.00265938;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 62622.00266892;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 20053.00270941;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 2313.002485374;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 5527.00227133;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 2561.002230028;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 46977.00218052;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 60351.00218445;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 9801.002153078;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 65329.00221689;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 52702.00221835;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 12684.00219944;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 19697.00221611;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 14760.00215972;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 5434.002079716;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 4983.002140473;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 58506.00207997;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 1191.002122725;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 9735.002066917;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 12399.00198158;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 54731.00204511;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 55741.00196362;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 43633.00195827;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 46384.00188632;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 65460.00228335;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 57334.00224337;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 52605.00219646;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 53016.00219384;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 53042.00225917;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 59248.00241779;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 64750.0024202;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 59696.00243373;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 55343.0024356;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 2816.002417979;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 34240.00233616;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 10392.00222664;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 60671.00237081;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 5958.002325818;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 58419.0022512;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 4716.00215548;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 61384.00212544;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 2436.002378088;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 57042.0024009;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 59056.00242582;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 10263.00245445;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 53869.00259251;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 62283.0025328;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 50686.0024704;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 6171.002334331;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 64729.00234712;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 21080.00168267;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 19789.00196642;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 7026.002048242;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 7419.001899166;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 50295.00190941;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 8730.001698425;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 2240.001686705;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 17260.00163193;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 4197.001638284;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 46384.00165892;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 64071.00122052;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 47100.00123239;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 56022.00127699;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 44713.0012367;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 1426.001217943;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 4648.001206726;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 62347.00114557;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 20115.00109798;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 55280.00110368;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 40361.00114792;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 9365.001002402;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 8267.001073348;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 10588.00097277;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 62415.00111196;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 61646.00116347;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 8779.001120546;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 17405.0012497;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 11889.00123788;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 53962.00122425;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 19890.00125839;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 62919.00122906;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 41916.00129761;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 59318.00124021;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 1372.001431278;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 60553.00135439;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 21283.00129096;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 20101.00135781;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 26436.00134663;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 5450.001365767;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 39614.00138225;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 60939.00131741;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 54437.00128325;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 58856.00135956;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 64897.00134365;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 6629.001300436;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 5972.001380607;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 44514.00140233;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 31702.00137042;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 65375.00131019;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 65399.00133585;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 56268.00133108;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 41975.00132336;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 14555.00137146;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 61231.00139398;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 63196.00143536;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 65439.00142073;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 65502.00143243;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 50303.00130703;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 54074.00129858;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 51021.00123448;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 52897.00125763;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 18775.00123419;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 45490.00126422;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 21027.00133456;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 60651.00138724;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 45932.00148158;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 61269.00152501;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 8262.001493727;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 56138.00152109;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 21154.00146864;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 8793.001556335;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 30028.00154171;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 59646.00161637;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 57326.00159807;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 17979.00151107;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 6669.001547631;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 57146.00148011;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 47251.00143635;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 4118.001489274;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 8044.001441394;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 4578.001430951;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 21273.00150423;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 62673.00143954;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 8339.001493153;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 16941.00141696;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 3835.001371388;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 22730.00135965;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 59885.00136255;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 63855.00145442;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 63196.00143536;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 56925.00100762;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 65530.00103616;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 64941.00112718;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 65525.00115152;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 62873.00115501;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 7851.001227642;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 62126.00120285;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 63327.00122833;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 56238.0012253;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 48366.0012846;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 48078.00128722;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 53719.00129997;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 63163.00140826;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 6836.001362268;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 2139.001355786;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 8207.001292593;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 10490.00130858;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 17308.00130407;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 64894.00135189;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 63035.00130802;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 62683.00130725;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 36550.00134494;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 17314.00129891;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 12324.00130859;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 2283.00130272;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 5568.001318857;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 8848.001311629;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 51961.00129178;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 41163.00130455;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 58998.00126676;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 65150.00119659;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 4269.001111216;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 65358.00107486;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 52805.00107099;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 60619.00110134;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 1990.001117301;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 3494.001096292;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 56045.00114159;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 8282.001148017;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 3327.001191333;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 64901.00127755;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 61803.00127973;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 65179.00137978;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 10357.00132944;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 61286.00131762;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 52425.00135827;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 6225.001315188;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 55243.00130762;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 39054.00135509;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 5818.00134802;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 54722.00140456;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 61126.00136575;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 9070.001377147;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 54894.00129939;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 54131.00142308;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 56723.00126762;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 56686.00132866;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 53884.00379896;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 4381.00379121;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 51562.00373024;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 52151.00357623;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 64493.00356091;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 1527.003546387;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 62651.00359829;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 64250.00370449;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 2321.003607465;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 57328.00347346;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 53660.00351034;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 30895.00322881;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 1694.003278259;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 16419.00329676;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 58537.00321392;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 39845.00330897;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 2284.003406007;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 3040.00338388;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 1089.003341964;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 56181.0037039;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 21064.0033271;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 56373.00344369;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 46347.0033775;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 8215.003237195;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 12890.003128;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 10818.00307321;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 58217.00312561;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 62966.0030818;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 18160.00312336;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 10624.00304343;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 38069.00273386;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 46544.00252282;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 48947.00265714;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 59718.00256793;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 52563.00268287;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 9629.002512884;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 54188.00242059;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 42642.00228302;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 2420.002382726;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 58779.00238471;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 52625.00234098;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 61348.00242706;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 3072.002365091;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 13371.00223734;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 52581.00248148;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 61912.0026239;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 14929.00272124;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 56239.00279279;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 4404.003262057;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 19848.00326672;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 55667.00317883;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 46551.00263164;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 54138.00266118;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 4905.002633619;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 4710.00242355;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 64858.00248444;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 1099.002562608;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 55635.00278862;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 43635.00267521;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 26211.00274143;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 64568.00275514;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 61380.00274559;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 62685.00272474;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 61390.00285804;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 62469.00278617;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 64617.00281596;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 23141.00287214;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 56877.00307545;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 64092.00317998;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 48075.00318661;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 6918.003095159;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 51932.00328647;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 327.0034648797;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 64812.00343811;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 63255.00343373;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 32051.00333947;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 62969.00323099;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 42419.00322905;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 41142.00326183;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 65072.00306302;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 64470.00299561;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 18081.00291635;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 2825.003020862;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 694.0030745947;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 64093.00299218;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 64200.00304055;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 57231.00295572;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 65072.00296335;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 9480.003037135;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 56119.00307529;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 59930.0028816;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 44274.00310564;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 2575.003114012;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 160.0031063987;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 16394.00309596;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 3354.002756173;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 10404.00285099;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 39164.00281629;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 30131.00269806;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 18043.00274755;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 1225.002698678;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 64750.00272224;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 25882.00269522;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 53102.00260179;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 4134.00233598;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 52565.00233265;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 59310.00235969;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 16513.00242392;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 65406.00243087;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 2848.002447618;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 63652.00237623;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 25503.00234551;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 56030.00241694;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 3226.002344985;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 2661.002426564;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 55987.00238818;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 62941.00243355;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 2193.002411471;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 55533.00243094;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 22507.00241284;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 6863.00236152;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 64190.00238179;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 33643.00240529;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 43651.00246264;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 47256.00248742;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 18987.00264119;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 60731.00278471;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 20850.00280294;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 2722.002736089;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 56310.0027534;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 4473.002793122;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 19046.00291845;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 55063.00309949;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 633.0030353968;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 64167.00303871;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 60967.00311241;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 5050.00306237;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 54355.00305095;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 4206.00276496;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 12629.00287663;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 23714.00281605;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 48666.00261613;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 1176.002501561;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 64841.00243768;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 7458.002669742;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 4117.002555683;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 17874.00253667;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 63903.00263388;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 8816.002553236;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 17524.00259771;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 62892.0026784;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 3734.002535438;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 56491.00244599;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 40861.0025087;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 12331.00259557;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 46074.00258146;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 46498.00256792;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 14663.00258528;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 58608.00258266;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 38393.00261409;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 1061.002613521;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 50771.00262126;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 27183.00259669;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 4260.00265034;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 54958.00265521;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 58972.00265383;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 51925.00260058;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 59589.00284996;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 43468.00288147;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 55159.00289818;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 1825.002674517;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 56729.00267157;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 57806.00263355;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 43797.00274878;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 16425.00287702;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 65145.00293384;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 13890.00283073;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 55519.00290114;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 57174.00297759;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 25620.00286869;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 47499.00291018;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 126.0029333144;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 64707.00316752;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 59846.00320294;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 64496.00327427;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 50556.00358922;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 55950.00357781;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 46665.00363584;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 14454.00382945;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 65150.00352301;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 64146.00332741;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 58363.00317723;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 2189.003157926;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 9784.003056515;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 3722.00294199;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 13353.00268071;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 21066.00270664;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 25123.00248554;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 30186.00230285;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 6039.002531707;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 40898.00268648;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 53678.00275707;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 62974.00256492;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 52413.00252687;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 5561.00242733;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 64220.00241585;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 63166.00244364;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 62161.00255553;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 51387.00249042;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 21123.00242841;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 55132.00246829;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 5713.00255464;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 63932.0024859;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 64434.00258461;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 61844.0026638;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 58032.00282213;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 42686.00263856;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 61515.00266202;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 53881.00266793;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 5142.002465753;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 25449.00248452;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 63608.00221793;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 2984.002213237;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 61165.00218249;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 64972.00221799;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 4411.002079336;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 50903.00199145;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 175.0021271913;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 58819.00204455;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 52746.00187785;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 52428.00195798;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 40626.00218243;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 57335.00224322;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 63166.00219693;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 59232.00241766;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 64748.00242007;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 62643.00225108;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 4708.002155376;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 406.0023781307;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 16570.00245467;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 56296.0025875;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 48842.00172204;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 38349.00166615;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 63989.00174496;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 60605.00173364;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 53724.00172484;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 44759.00198961;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 3209.001962092;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 61714.00188839;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 21063.00198042;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 12472.00199296;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 5699.001698246;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 8502.001631366;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 45553.00113826;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 6514.001193447;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 62433.00121238;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 7724.001088078;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 30815.00105839;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 3140.001042312;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 8243.001133162;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 307.0012412585;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 21940.00125851;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 6792.001226251;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 43956.00129761;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 1884.001430762;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 59561.00135419;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 22051.0012908;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 65464.00140721;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 20133.00135776;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 12355.00139284;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 56092.00131581;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 60278.00130887;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 65205.00133205;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 3344.001336117;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 56041.00130616;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 63317.00131481;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 21583.00115983;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 10317.00126666;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 58493.00138889;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 54813.00149095;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 64951.00148184;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 14455.00132398;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 63320.00152527;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 64369.00151352;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 8471.001513631;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 21794.00155624;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 59574.00161569;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 58075.00151206;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 18056.00147533;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 21188.00149034;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 4546.001430944;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 29465.00150403;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 4185.001492734;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 22728.00135966;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 952.001371804;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 47055.00092073;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 57311.00096051;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 55427.00096734;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 3369.000982642;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 48817.00096954;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 40661.00105463;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 21803.0010569;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 64478.00103613;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 53431.00112865;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 36541.0012984;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 2630.001392614;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 60665.0014174;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 9828.001291098;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 10390.00130634;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 55187.00128944;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 58612.00131048;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 49989.00134496;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 12340.00130859;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 10771.00119429;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 65287.00110503;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 8539.00111133;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 60619.0011013;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 18374.00111729;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 3490.001096281;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 10330.00114801;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 28245.00127431;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 17170.00133186;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 22609.00131516;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 52977.0013974;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 56678.00132864;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 36374.00140385;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 60614.00136574;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 23265.00126422;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 24159.00091172;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 13386.00131036;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 23265.00126422;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 10818.00091063;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 34798.00092098;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 20261.00090866;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 62862.00103892;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 14653.00100102;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 58431.00101206;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 32126.00102955;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 31740.00106836;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 64443.00119929;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 6301.001227585;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 48631.00129277;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 42495.00133038;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 61410.00132515;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 51596.00132947;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 62799.00129162;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 65109.00110651;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 52148.00111974;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 64316.00135788;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 58055.00132724;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 54993.00134631;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 64681.00129;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 18194.00134027;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 3779.0013623;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 23265.00126422;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 56823.00348424;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 8697.00338892;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 56605.00336747;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 42979.00332524;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 6081.003385767;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 25620.00333416;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 60986.00344558;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 56445.00338702;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 56442.00309155;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 8906.002626825;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 2444.002731144;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 9060.002651134;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 64718.00265443;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 6447.002263349;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 4765.002421048;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 1191.002417583;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 61344.00242712;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 23.00236701989;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 13339.00223737;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 52325.00248108;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 56109.00279225;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 983.0031468996;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 4400.003261978;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 63859.00317876;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 39251.00278864;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 22920.00274115;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 16615.0026867;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 62666.00287245;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 63486.00299944;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 7812.00291358;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 56822.00299704;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 55154.00302178;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 23219.00296133;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 64609.00296345;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 21828.00305468;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 7628.002824299;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 14650.00274574;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 17557.00242912;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 3914.002364792;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 17350.00247305;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 60498.0023765;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 2141.002436663;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 3722.002345076;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 15352.00245449;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 4004.002393746;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 21481.0024129;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 17610.00280287;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 4401.002792717;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 55093.00309933;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 64679.00303853;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 13406.00288616;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 3037.002598019;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 1178.002501405;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 64857.00243753;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 54734.00249837;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 4116.002555754;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 17810.00253677;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 63895.00263396;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 7830.002535486;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 21576.00259409;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 4729.002652467;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 7048.002600926;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 2960.002627997;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 13719.0025968;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 4185.002603776;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 17409.00262229;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 38312.00260077;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 61047.00270515;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 16230.00285173;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 56207.00294499;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 55223.00375624;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 44729.00377778;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 6372.003755275;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 9153.00351496;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 12662.00329952;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 10336.00335297;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 10504.00327212;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 2601.003262897;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 3516.003003447;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 818.0030652623;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 1939.002956255;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 17761.00294425;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 10630.00288726;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 18977.00283382;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 59465.00282654;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 17458.00242266;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 11318.00239172;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 55662.00255437;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 65519.00234092;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 53009.00252717;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 62265.00241572;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 2372.00270417;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 8776.002314338;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 2241.002511741;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 48262.00255408;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 51774.00284131;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 47708.0026887;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 64067.00269358;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 55859.00248319;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 47967.00241438;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 14436.00214956;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 58929.00234778;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 17843.00178197;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 57032.00131157;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 8819.00131391;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 55606.00133634;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 4320.001388854;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 19153.00133393;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 63307.00135996;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 65310.00134727;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 4917.001357217;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 57270.00142665;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 60246.00151255;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 11692.00149201;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 54390.0015267;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 9142.001509782;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 15044.00148654;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 41835.00142558;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 43932.00148944;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 61281.00146479;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 6308.001460834;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 594.0013609195;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 59871.00137846;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 57288.00133496;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 10952.00149437;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 16661.00148228;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 27453.00105221;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 65525.00102605;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 57203.00101355;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 64990.0009973;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 47099.00099354;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 30444.00097087;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 64499.00098147;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 56795.00095254;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 42996.00091193;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 3386.000942661;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 25966.00130682;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 57199.00135502;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 4488.001300603;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 59146.00137239;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 2049.001351978;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 40703.00137519;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 5194.002562629;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 4496.00236623;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 3269.00244801;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 26135.00252745;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 47090.00258146;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 10976.00260298;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 40606.00105312;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 48117.00101421;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 54735.00242357;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 56693.00241356;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 62463.00156951;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 51531.00115585;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 4325.002324721;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 3348.00239652;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 353.0023027396;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 2414.002382082;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 63821.00133667;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 65511.00231675;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 51027.00236212;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 60732.00246168;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 891.0024119508;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 670.0023281297;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 45778.00241867;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 62937.00243367;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 8784.002496511;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 46161.00232385;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 57835.00232895;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 48998.00228062;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 48487.00236363;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 46251.00236306;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 56657.00237836;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 10310.00239245;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 17306.00250942;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 25511.00126218;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 7659.001704587;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 45309.00241803;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 52636.00155923;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 58215.00164216;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 65386.00237225;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 46715.00219848;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 47036.00235705;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 20971.00152659;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 9810.001414727;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 55231.00244344;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 60703.00217759;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 21805.00140927;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 1669.001509904;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 59994.00142459;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 1050.002181998;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 4237.002176173;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 2150.001110107;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 9524.001339319;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 11612.00288238;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 5285.003216777;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 1381.001374608;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 8303.003023279;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 37568.00161789;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 54611.00305078;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 56890.0023883;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 60316.00148961;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 60779.00138332;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 15118.00236128;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 62420.00136114;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 11838.00298707;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 11865.00281578;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 59762.00225186;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 59833.00266168;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 8470.002285666;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 4598.002168048;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 65370.00148366;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 13651.00226317;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 63046.00258626;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 64377.00255971;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 55482.00228245;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 65064.00232852;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 57305.00131618;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 9800.002314864;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 9314.002117283;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 1872.001651646;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 64406.00142814;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 4700.001579858;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 7066.002513405;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 9785.002553958;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 14392.00227109;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 1061.002555291;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 10280.00149181;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 47505.00259066;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 52851.00256449;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 11409.0027022;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 27931.00267952;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 64965.00162656;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 1488.001398421;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 55486.00163056;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 2438.002378118;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 6241.002693614;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 606.0014161828;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 64395.00258547;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 47387.00244334;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 47379.0027886;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 55644.00276203;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 52429.00135829;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 3409.00129824;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 52587.00243518;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 54213.00270437;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 59033.00165887;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 64712.00257003;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 16500.00259777;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 4238.002720438;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 648.0025478021;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 45370.00144722;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 5227.002410691;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 63159.00255333;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 22545.00131521;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 2369.002512174;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 4120.001424685;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 21047.00157939;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 64710.00255439;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 62908.00267842;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 4393.002566683;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 58668.00139125;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 30243.00274139;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 63188.00133185;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 47248.00255215;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 4374.001579958;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 47027.00138383;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 63024.00275512;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 47399.00163474;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 40857.00250875;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 61382.00274551;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 4794.001347985;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 39381.00162112;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 62823.00259685;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 47574.0029876;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 56985.00251024;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 52123.00263459;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 13696.00125283;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 36374.00140384;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 64318.00269899;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 9387.002615257;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 20541.00244213;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 58690.00132801;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 60393.00145579;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 63543.00136752;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 7444.002694518;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 60954.00269305;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 64473.00246972;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 50682.00252175;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 8823.002562233;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 63953.00131274;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 14198.00238809;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 60057.00284793;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 47467.00243126;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 53448.00239676;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 62666.00287228;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 38312.00260078;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 54504.00253976;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 952.001371804;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 38312.00260078;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 54504.00253976;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 45877.00240339;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 1050.002181998;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 65205.00133205;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 40757.00131369;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 4668.001738475;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 21976.00112006;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 4467.001095019;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 24055.00171934;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 5149.001715436;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 61272.00114785;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 60411.00112698;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 54781.00134277;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 61012.00140555;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 64282.00116253;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 62127.00120283;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 56950.00128518;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 57209.00128957;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 62076.0012033;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 5261.001394366;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 21079.00132991;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 9327.001292917;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 55532.00130776;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 46648.00113043;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 55460.00237623;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 4357.002706997;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 13756.00202828;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 53719.0015735;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 2874.002012405;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 63607.00239511;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 34442.00134486;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 47178.0012038;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 47427.00238768;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 48544.00230214;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 11323.00230366;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 4828.002382222;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 50782.00132928;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 39733.00201376;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 342.0023714072;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 45766.00246564;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 55411.00243872;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 63180.00120879;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 53972.00244072;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 54763.00233648;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 59134.0022458;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 57905.00240351;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 44379.0024104;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 55572.00234053;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 42427.00241701;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 64493.00124838;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 19482.00245043;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 61945.00155345;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 55658.00241767;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 40123.0024315;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 63003.00244349;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 41275.00243825;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 61301.00242953;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 57650.00232083;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 43948.00232684;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 52555.00227944;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 64895.00236155;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 54187.00235848;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 45933.0023604;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 20494.0023779;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 27912.00130788;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 59124.00191238;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 6489.001511936;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 19225.00180823;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 56303.00143503;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 52972.00125659;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 28185.00130699;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 170.0012711686;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 39581.00249069;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 1345.001478317;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 21618.00145992;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 16686.0013829;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 44927.00244293;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 57104.00217525;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 3594.002326938;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 14485.00134095;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 1235.002885291;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 62690.00107415;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 40925.00309131;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 45436.00146749;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 59738.00131342;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 2152.001697657;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 47413.00110482;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 20585.00126989;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 52403.0011009;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 2184.003268033;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 21402.00308195;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 17758.00239771;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 63210.00143528;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 54602.00310292;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 56809.00317486;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 59375.00300345;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 16935.00142144;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 14281.00109446;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 2901.001148426;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 21604.00232884;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 22529.00161894;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 55176.00238512;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 53745.00304507;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 16975.00299678;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 5138.002849125;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 18504.00281894;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 5472.002956621;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 63045.00293611;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 61397.0027942;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 62847.00261399;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 4110.002647072;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 4142.002587853;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 12824.00222437;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 28873.0026174;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 20506.0015213;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 2252.001419614;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 56890.00158187;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 60646.0022396;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 6202.001429834;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 61022.0026249;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 53967.00225071;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 62641.00266041;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 48907.00156073;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 20997.00264072;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 10784.00261138;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 14096.00145407;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 21007.00242868;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 19737.00247411;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 59803.00257979;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 60239.00151336;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 61050.00269191;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 10545.00237882;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 6240.002693606;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 2240.002512225;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 47232.00255232;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 4118.001580101;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 47031.00138389;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 56731.00264112;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 60976.00275517;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 50072.00264926;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 2624.001291928;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 3165.001545249;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 11880.00266327;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 62261.00257015;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 62811.00249607;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 5412.001448462;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 24608.0026052;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 46380.00256123;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 3754.002724866;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 50664.00135961;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 63324.00265393;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 48820.00251339;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 62709.0025814;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 54474.00287232;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 53448.00239685;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 34216.00260082;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 54504.00253986;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 17312.00129447;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 1848.001371872;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 34216.00260082;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 54504.00253986;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 23269.00126426;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 62889.00155764;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 55931.00122897;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 64315.00241639;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 51895.00155842;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 44764.00237077;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 44501.00212829;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 12376.00209842;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 54474.00287232;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 53448.00239685;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 34216.00260082;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 54504.00253986;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 17312.00129447;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 1848.001371872;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 34216.00260082;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 54504.00253986;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 23269.00126426;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 59114.00101372;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 27605.00120243;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 65525.00103602;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 60794.0011542;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 50835.00128948;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 60847.00125263;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 5769.001111136;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 65390.00107476;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 18387.00111721;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 64766.00119124;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 11393.00270202;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 27929.00267941;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 64394.00162639;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 1432.001398427;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 2454.002378105;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 407.002674892;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 63771.00244341;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 55571.00278863;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 55516.00276204;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 4239.002720453;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 54168.00264933;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 53742.00275778;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 4890.001556861;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 1614.001323512;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 53059.00134663;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 55866.00284215;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 62751.00278786;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 3248.001264509;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 55194.00263036;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 10856.00266332;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 1976.001371816;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 5585.002600833;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 22322.00110737;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 46550.00263153;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 3239.002467581;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 12443.00142571;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 40373.00235629;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 60700.00255515;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 64731.00226383;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 1363.002544223;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 3121.00228963;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 60585.00133556;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 60313.00284796;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 48995.0024313;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 50862.00265534;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 35228.00137187;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 35540.00260081;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 27252.00253982;
 Local_2_in ++;
 Local_1_do_ko[Local_2_in] = 44400.00126425;
 Local_2_in ++;
 for (Local_3_in = 0 ; Local_3_in < Local_2_in ; Local_3_in ++)
 {
   Global_23_in ++;
   Global_21_lo_ko[Global_23_in] = int(Local_1_do_ko[Local_3_in]);
   Global_22_do_ko[Global_23_in] = (Local_1_do_ko[Local_3_in] - int(Local_1_do_ko[Local_3_in])) * 660.0;
 }
 }
//lizong_25 <<==--------   --------
 void lizong_26( bool Para_0_bo)
 {
  int       Local_1_in;
  int       Local_2_in;
  int       Local_3_in;
  int       Local_4_in;
  int       Local_5_in;
  int       Local_6_in;
  int       Local_7_in;
  string    Local_8_st;
  int       Local_9_in;
  string    Local_10_st;
  double    Local_11_do;
  double    Local_12_do;
  int       Local_13_in;
  int       Local_14_in;
  int       Local_15_in;
  int       Local_16_in;
  double    Local_18_do;
  string    Local_19_st;
  int       Local_20_in;
  int       Local_21_in;
  double    Local_22_do;
  double    Local_23_do;
  double    Local_24_do;
  double    Local_25_do;
  double    Local_26_do;
  double    Local_27_do;
  double    Local_28_do;
  int       Local_29_in;
  int       Local_30_in;
  string    Local_31_st;
  double    Local_32_do;
  int       Local_33_in;
  double    Local_34_do;
  int       Local_35_in;
  int       Local_36_in;
  int       Local_37_in;
  string    Local_38_st;
  int       Local_39_in;
  int       Local_40_in;
  string    Local_41_st;
  string    Local_42_st;
  string    Local_43_st;
  string    Local_44_st;
  int       Local_45_in;
  int       Local_46_in;
  double    Local_47_do;
  int       Local_48_in;
  long      Local_49_lo;
  int       Local_50_in;
  int       Local_51_in;
  string    Local_52_st;
  int       Local_53_in;
  string    Local_54_st;
  int       Local_55_in;
//----- -----
 string     tmp_st_1;
 double     tmp_do_2;
 int        tmp_in_3;
 int        tmp_in_4;
 int        tmp_in_5;
 int        tmp_in_6;
 string     tmp_st_7;
 int        tmp_in_8;
 long       tmp_lo_9;
 string     tmp_st_10;
 string     tmp_st_11;
 string     tmp_st_12;
 int        tmp_in_13;
 int        tmp_in_14;
 string     tmp_st_15;
 long       tmp_lo_16;
 string     tmp_st_17;
 string     tmp_st_18;
 string     tmp_st_19;
 int        tmp_in_20;
 int        tmp_in_21;
 string     tmp_st_22;
 long       tmp_lo_23;

 if ( ShowNewsList )
 {
   lizong_30(9030733); 
 }
 if ( ShowStats )
 {
   lizong_27(9030733); 
 }
 Local_1_in = 14474460 ;
 Local_2_in = 9030733 ;
 if ( ( Global_79_bo || Global_62_bo ) )
 {
   Local_1_in = 4678655 ;
   Local_2_in = 4678655 ;
 }
 if ( ( UID > 9 || UID <  0 ) )
 {
   Local_1_in = 4678655 ;
   Local_2_in = 4678655 ;
 }
 Local_3_in = 0 ;
 Local_4_in = 23 ;
 Local_5_in = 15 ;
 Local_6_in = 13 ;
 Local_7_in = 94 ;
 Local_8_st = "MS Sans Serif" ;
 Local_9_in = FontSize ;
 Local_4_in=23 + 53;
 Local_10_st = "-----" ;
 if ( ( !(Para_0_bo) || IsTesting() ) )
 {
   Local_11_do = iClose(Global_26_a_168_ko[0].st_1,Global_25_in,1) ;
   Local_12_do = lizong_28(Global_26_a_168_ko[0].st_1,1,lizong_58(0,Local_11_do,1,true,0,0),Local_11_do) ;
   Local_10_st = DoubleToString(Local_12_do,2) ;
   if ( Global_57_in >  1 )
   {
     Local_10_st = Local_10_st + "x" + string(Global_57_in) + "=" + DoubleToString(Local_12_do * Global_57_in,2) ;
   }
 }
 Local_13_in = Local_2_in ;
 Local_14_in = Local_1_in ;
 if ( Local_10_st == "-----" )
 {
   Local_13_in = 4678655 ;
   Local_14_in = 4678655 ;
 }
 lizong_47("GraphicsC" + string(Local_4_in),Local_3_in,Local_5_in,Local_4_in,"Expected lot:",Local_8_st,Local_13_in,Local_9_in); 
 lizong_47("GraphicsV" + string(Local_4_in),Local_3_in,Local_7_in,Local_4_in,Local_10_st,Local_8_st,Local_14_in,Local_9_in); 
 Local_4_in +=Local_6_in;
 Local_15_in = Local_2_in ;
 Local_16_in = Local_1_in ;
 if ( ( ArraySize(Global_26_a_168_ko) == 0 || Global_58_in == 0 ) )
 {
   Local_15_in = 4678655 ;
   Local_16_in = 4678655 ;
 }
 lizong_47("GraphicsC" + string(Local_4_in),Local_3_in,Local_5_in,Local_4_in,"Currency pairs:",Local_8_st,Local_15_in,Local_9_in); 
 lizong_47("GraphicsV" + string(Local_4_in),Local_3_in,Local_7_in,Local_4_in,string(Global_58_in),Local_8_st,Local_16_in,Local_9_in); 
 Local_4_in +=Local_6_in;
 lizong_47("GraphicsC" + string(Local_4_in),Local_3_in,Local_5_in,Local_4_in,"Leverage:",Local_8_st,Local_2_in,Local_9_in); 
 lizong_47("GraphicsV" + string(Local_4_in),Local_3_in,Local_7_in,Local_4_in,"1:" + AccountInfoInteger(ACCOUNT_LEVERAGE),Local_8_st,Local_1_in,Local_9_in); 
 Local_4_in +=Local_6_in;
 Local_18_do = 0.0 ;
 Local_19_st = "" ;
 Local_20_in = 0 ;
 if ( ( !(Para_0_bo) || IsTesting() ) )
 {
   for (Local_21_in = 0 ; Local_21_in < ArraySize(Global_26_a_168_ko) ; Local_21_in ++)
   {
     if ( Local_19_st != Global_26_a_168_ko[Local_21_in].st_1 )
     {
       Local_20_in ++;
     }
     if ( Local_20_in > MaximumSymbols )   break;
     Local_22_do = (MarketInfo(Global_26_a_168_ko[Local_21_in].st_1,11)>Global_29_do) ?MarketInfo(Global_26_a_168_ko[Local_21_in].st_1,11):0.00001  ;
     Local_23_do = SymbolInfoDouble(Global_26_a_168_ko[Local_21_in].st_1,26) ;
     Local_24_do = iClose(Global_26_a_168_ko[Local_21_in].st_1,Global_25_in,1) ;
     Local_25_do = lizong_58(Local_21_in,Local_24_do,1,true,0,0) ;
     Local_26_do = lizong_28(Global_26_a_168_ko[Local_21_in].st_1,1,Local_25_do,Local_24_do) ;
     if ( Local_22_do<Global_29_do || Local_23_do<Global_29_do )   break;
     Local_27_do = MathAbs(Local_24_do - Local_25_do) / Local_22_do ;
     Local_18_do = Local_26_do * Local_23_do * Local_27_do + Local_18_do ;
     Local_19_st = Global_26_a_168_ko[Local_21_in].st_1 ;
   }
   Local_28_do = AccountInfoDouble(ACCOUNT_BALANCE) ;
   if ( Local_28_do>0.1 )
   {
     Local_18_do = Local_18_do * 100.0 / Local_28_do ;
   }
   else
   {
     Local_18_do = 0.0 ;
   }
 }
 Local_29_in = Local_2_in ;
 Local_30_in = Local_1_in ;
 if ( Local_18_do>99.0 )
 {
   Local_29_in = 4678655 ;
   Local_30_in = 4678655 ;
 }
 lizong_47("GraphicsC" + string(Local_4_in),Local_3_in,Local_5_in,Local_4_in,"Maximum risk:",Local_8_st,Local_29_in,Local_9_in); 
 lizong_47("GraphicsV" + string(Local_4_in),Local_3_in,Local_7_in,Local_4_in,DoubleToString(Local_18_do,2) + "%",Local_8_st,Local_30_in,Local_9_in); 
 Local_4_in +=Local_6_in;
 Local_31_st = TradeComment ;
 if ( StringLen(TradeComment)  >  20 )
 {
   Local_31_st = StringSubstr(TradeComment,0,20) ;
 }
 Local_32_do = 0.0 ;
 for (Local_33_in = 0 ; Local_33_in < ArraySize(Global_26_a_168_ko) ; Local_33_in ++)
 {
   Local_32_do = Local_32_do + lizong_22(Global_26_a_168_ko[Local_33_in].st_1,-1,0,false) ;
 }
 lizong_47("GraphicsC" + string(Local_4_in),Local_3_in,Local_5_in,Local_4_in,"Lots opened:",Local_8_st,Local_2_in,Local_9_in); 
 lizong_47("GraphicsV" + string(Local_4_in),Local_3_in,Local_7_in,Local_4_in,DoubleToString(Local_32_do,2),Local_8_st,Local_1_in,Local_9_in); 
 Local_4_in +=Local_6_in;
 tmp_st_1 = "";
 tmp_do_2 = 0.0;
 tmp_in_3 = Global_28_in + UID + int(MathPow(10.0,StringLen(IntegerToString(Global_28_in + UID,0,32)) ));
 tmp_in_4 = Global_28_in + UID + int(MathPow(10.0,StringLen(IntegerToString(Global_28_in + UID,0,32)) )) * 2;
 for (tmp_in_5 = 0 ; tmp_in_5 < OrdersTotal() ; tmp_in_5=tmp_in_5 + 1)
 {
   if ( OrderSelect(tmp_in_5,0,0) )
   {
     tmp_in_6 = OrderType();
     tmp_st_7 = OrderSymbol();
     tmp_in_8 = OrderMagicNumber() / 100;
     if ( ( ( tmp_in_6 != 0 || tmp_in_3 != tmp_in_8 ) && (tmp_in_6 != 1 || tmp_in_4 != tmp_in_8) ) )   continue;
     
     if ( ( tmp_st_1 != "" && tmp_st_1 != tmp_st_7 ) )   continue;
     tmp_do_2 = OrderProfit() + OrderSwap() + OrderCommission() + tmp_do_2;
      continue;
   }
   Print(TradeComment + " " + "------",": Failed to select an order! Error=",lizong_11(GetLastError())); 
   
 }
 Local_34_do = tmp_do_2 ;
 lizong_47("GraphicsC" + string(Local_4_in),Local_3_in,Local_5_in,Local_4_in,"Floating PnL:",Local_8_st,Local_2_in,Local_9_in); 
 Local_35_in = Local_1_in ;
 if ( Local_34_do<0.0 )
 {
   Local_35_in = 4678655 ;
 }
 lizong_47("GraphicsV" + string(Local_4_in),Local_3_in,Local_7_in,Local_4_in,DoubleToString(Local_34_do,2),Local_8_st,Local_35_in,Local_9_in); 
 Local_4_in +=Local_6_in;
 Local_36_in = Local_2_in ;
 Local_37_in = Local_1_in ;
 if ( Local_31_st == "" )
 {
   Local_36_in = 4678655 ;
   Local_37_in = 4678655 ;
 }
 lizong_47("GraphicsC" + string(Local_4_in),Local_3_in,Local_5_in,Local_4_in,"Comment:",Local_8_st,Local_36_in,Local_9_in); 
 lizong_47("GraphicsV" + string(Local_4_in),Local_3_in,Local_7_in,Local_4_in,Local_31_st,Local_8_st,Local_37_in,Local_9_in); 
 Local_4_in +=Local_6_in;
 Local_38_st = "-----" ;
 Local_39_in = Local_2_in ;
 Local_40_in = Local_1_in ;
 if ( Global_34_in == 999 )
 {
   Local_38_st = "-----" ;
   Local_39_in = 4678655 ;
   Local_40_in = 4678655 ;
 }
 else
 {
   Local_38_st = string(Global_34_in) ;
   if ( Global_34_in >  0 )
   {
     Local_38_st +="+";
   }
   if ( Global_35_in != -999 )
   {
     if ( DisableAutoGMT )
     {
       Local_38_st +=" (Manual)";
     }
     else
     {
       Local_38_st +=" (Updated)";
     }
   }
   else
   {
     if ( !(IsTesting()) )
     {
       Local_38_st +=" (Default)";
       Local_39_in = 4678655 ;
       Local_40_in = 4678655 ;
     }
     else
     {
       Local_38_st +=" (Backtest)";
     }
   }
 }
 lizong_47("GraphicsC" + string(Local_4_in),Local_3_in,Local_5_in,Local_4_in,"GMT offset:",Local_8_st,Local_39_in,Local_9_in); 
 lizong_47("GraphicsV" + string(Local_4_in),Local_3_in,Local_7_in,Local_4_in,Local_38_st,Local_8_st,Local_40_in,Local_9_in); 
 Local_4_in +=Local_6_in;
 Local_41_st = "-----" ;
 if ( Global_41_da >  0 )
 {
   Local_41_st = TimeToString(Global_41_da,1) ;
 }
 else
 {
   Local_41_st = "-----" ;
 }
 Local_42_st = "-----" ;
 Local_43_st = "-----" ;
 Local_44_st = "-----" ;
 Local_45_in = Local_1_in ;
 if ( Global_35_in != -999 )
 {
   for (Local_46_in = 0 ; Local_46_in < Global_40_in ; Local_46_in ++)
   {
     Local_47_do=StringToTime(StringSubstr(Global_39_st_kosi4[Local_46_in][0],0,4) + "." + StringSubstr(Global_39_st_kosi4[Local_46_in][0],5,2) + "." + StringSubstr(Global_39_st_kosi4[Local_46_in][0],8,2) + " " + StringSubstr(Global_39_st_kosi4[Local_46_in][0],11,2) + ":" + StringSubstr(Global_39_st_kosi4[Local_46_in][0],14,4)) + Global_35_in * 60 * 60;
     tmp_lo_9=TimeCurrent() - WaitMinutesAfterEvent * 60;
     if ( Local_47_do < tmp_lo_9 )   continue;
     tmp_lo_9=TimeCurrent() + 82800;
     if ( Local_47_do > tmp_lo_9 || Global_39_st_kosi4[Local_46_in][2] == "Holiday" )   continue;
     Local_43_st = Global_39_st_kosi4[Local_46_in][1] ;
     Local_44_st=">" + Global_39_st_kosi4[Local_46_in][3];
     tmp_st_12 = "------------";
     tmp_in_13 = Local_47_do - TimeCurrent();
     if ( tmp_in_13 >= 0 )
     {
       tmp_in_14 = tmp_in_13 / 3600;
       tmp_in_13 = tmp_in_13 - (tmp_in_13 / 60 - tmp_in_13 / 3600 * 60) * 60 - tmp_in_13 / 3600 * 60 * 60;
       tmp_st_15 = IntegerToString(tmp_in_13 / 60 - tmp_in_13 / 3600 * 60,2,48);
       if ( tmp_in_13 == 60 )
       {
         tmp_in_13 = 59;
       }
       IntegerToString(tmp_in_13,2,48); 
       tmp_st_12 = IntegerToString(tmp_in_14,2,48) + "h" + tmp_st_15 + "m";
     }
     Local_42_st = tmp_st_12 + " (" + Local_43_st + ")" ;
     if ( Local_47_do < TimeCurrent() - WaitMinutesAfterEvent * 60 || Local_47_do > TimeCurrent() + WaitMinutesBeforeEvent * 60 )   break;
     Local_45_in = 17919 ;
     break;
     
   }
   if ( DisableTradingOnHolidays )
   {
     for (Local_48_in = 0 ; Local_48_in < Global_40_in ; Local_48_in ++)
     {
       if ( Global_39_st_kosi4[Local_48_in][2] != "Holiday" )   continue;
       Local_49_lo = StringToTime(TimeToString(StringToTime(StringSubstr(Global_39_st_kosi4[Local_48_in][0],0,4) + "." + StringSubstr(Global_39_st_kosi4[Local_48_in][0],5,2) + "." + StringSubstr(Global_39_st_kosi4[Local_48_in][0],8,2) + " " + StringSubstr(Global_39_st_kosi4[Local_48_in][0],11,2) + ":" + StringSubstr(Global_39_st_kosi4[Local_48_in][0],14,4)) + Global_35_in * 60 * 60,1) + " 00:00") ;
       tmp_lo_16=TimeCurrent() - 108000;
       if ( Local_49_lo < tmp_lo_16 )   continue;
       tmp_lo_16=TimeCurrent() + 7200;
       if ( Local_49_lo > tmp_lo_16 )   continue;
       Local_43_st = Global_39_st_kosi4[Local_48_in][1] ;
       Local_44_st="Holiday>" + Global_39_st_kosi4[Local_48_in][3];
       tmp_st_19 = "------------";
       tmp_in_20 = Local_49_lo - TimeCurrent();
       if ( tmp_in_20 >= 0 )
       {
         tmp_in_21 = tmp_in_20 / 3600;
         tmp_in_20 = tmp_in_20 - (tmp_in_20 / 60 - tmp_in_20 / 3600 * 60) * 60 - tmp_in_20 / 3600 * 60 * 60;
         tmp_st_22 = IntegerToString(tmp_in_20 / 60 - tmp_in_20 / 3600 * 60,2,48);
         if ( tmp_in_20 == 60 )
         {
           tmp_in_20 = 59;
         }
         IntegerToString(tmp_in_20,2,48); 
         tmp_st_19 = IntegerToString(tmp_in_21,2,48) + "h" + tmp_st_22 + "m";
       }
       Local_42_st = tmp_st_19 + " (" + Local_43_st + ")" ;
       Local_45_in = Local_1_in ;
       if ( ( Local_49_lo != StringToTime(TimeToString(TimeCurrent(),1) + " 00:00") && Local_49_lo != StringToTime(TimeToString(TimeCurrent() - 21600,1) + " 00:00") ) )   break;
       Local_45_in = 17919 ;
       break;
       
     }
   }
 }
 if ( Local_44_st == "-----" && Global_40_in >  0 )
 {
   Local_44_st = "No news events coming up" ;
 }
 if ( ( Global_35_in == -999 || !(NewsFilterEnabled) ) )
 {
   Local_44_st = "News filter disabled" ;
   Local_45_in = 42495 ;
 }
 if ( StringLen(Local_44_st)  >  25 )
 {
   Local_44_st = StringSubstr(Local_44_st,0,25) + "..." ;
 }
 Local_50_in = Local_2_in ;
 Local_51_in = Local_1_in ;
 Local_52_st = IntegerToString(Global_40_in,0,32) ;
 if ( Local_52_st == "0" )
 {
   Local_50_in = 42495 ;
   Local_51_in = 42495 ;
 }
 else
 {
   Local_52_st +=" (" + Local_41_st + ")";
 }
 lizong_47("GraphicsC" + string(Local_4_in),Local_3_in,Local_5_in,Local_4_in,"Events found:",Local_8_st,Local_50_in,Local_9_in); 
 lizong_47("GraphicsV" + string(Local_4_in),Local_3_in,Local_7_in,Local_4_in,Local_52_st,Local_8_st,Local_51_in,Local_9_in); 
 Local_4_in +=Local_6_in;
 lizong_47("GraphicsC" + string(Local_4_in),Local_3_in,Local_5_in,Local_4_in,"Next event in:",Local_8_st,Local_2_in,Local_9_in); 
 lizong_47("GraphicsV" + string(Local_4_in),Local_3_in,Local_7_in,Local_4_in,Local_42_st,Local_8_st,Local_1_in,Local_9_in); 
 Local_4_in +=Local_6_in;
 Local_4_in +=5;
 lizong_47("GraphicsV" + string(Local_4_in),Local_3_in,Local_5_in,Local_4_in,Local_44_st,Local_8_st,Local_45_in,Local_9_in); 
 Local_4_in +=Local_6_in;
 Local_4_in +=10;
 Local_53_in = 16495626 ;
 Local_54_st = "Live trading" ;
 tmp_lo_23 = TerminalInfoInteger(8);
 if ( tmp_lo_23 != 0 )
 {
   tmp_lo_23 = AccountInfoInteger(ACCOUNT_TRADE_EXPERT);
 }
 if ( tmp_lo_23 != 0 )
 {
   tmp_lo_23 = MQLInfoInteger(MQL_TRADE_ALLOWED);
 }
 if ( tmp_lo_23 == 0 )
 {
   Local_54_st = "Trading not allowed!" ;
   Local_53_in = 4678655 ;
 }
 if ( TerminalInfoInteger(8) == 0 )
 {
   Local_54_st = "Terminal: trading not allowed!" ;
   Local_53_in = 4678655 ;
 }
 if ( AccountInfoInteger(ACCOUNT_TRADE_EXPERT) == 0 )
 {
   Local_54_st = "Account: trading not allowed!" ;
   Local_53_in = 4678655 ;
 }
 if ( MQLInfoInteger(MQL_TRADE_ALLOWED) == 0 )
 {
   Local_54_st = "MQL: trading not allowed!" ;
   Local_53_in = 4678655 ;
 }
 if ( Period() != 5 )
 {
   Local_54_st = "M5 is needed!" ;
   Local_53_in = 4678655 ;
 }
 if ( Global_79_bo )
 {
   Local_54_st = "Check Symbols!" ;
   Local_53_in = 4678655 ;
 }
 if ( IsVisualMode() )
 {
   Local_54_st = "Backtesting" ;
 }
 if ( Global_62_bo )
 {
   Local_54_st = "ERROR: other instances found!" ;
   Local_53_in = 4678655 ;
 }
 if ( ( UID > 9 || UID <  0 ) )
 {
   Local_54_st = "Check UID (0...9)!" ;
   Local_53_in = 4678655 ;
 }
 if ( !(Global_85_bo) )
 {
   Local_54_st = "License error!" ;
   Local_53_in = 4678655 ;
 }
 lizong_47("GraphicsC" + string(Local_4_in),Local_3_in,Local_5_in,Local_4_in,Local_54_st,Local_8_st,Local_53_in,Local_9_in); 
 Local_4_in +=25;
 if ( StockMarketFilterEnabled )
 {
   Local_55_in = 64636 ;
   if ( ( Global_63_do<Global_29_do || Global_63_do>MaxHistoricalVolatility ) )
   {
     Local_55_in = 4678655 ;
   }
   lizong_47("GraphicsC" + string(Local_4_in),Local_3_in,Local_5_in,Local_4_in,"HV=" + DoubleToString(Global_63_do,1) + "%",Local_8_st,Local_55_in,Local_9_in); 
 }
 Local_4_in +=50;
 lizong_47("GraphicsC" + string(Local_4_in),Local_3_in,Local_5_in - 4,Local_4_in,"v" + Global_2_st,Local_8_st,Local_1_in,Local_9_in); 
 }
//lizong_26 <<==--------   --------
 void lizong_27( int Para_0_in)
 {
  int       Local_1_in = 0;
  string    Local_2_st;
  int       Local_3_in;
  int       Local_4_in;
  int       Local_5_in;
  int       Local_6_in;
  int       Local_7_in;
  int       Local_8_in;
  int       Local_9_in;
  int       Local_10_in;
  int       Local_11_in;
  string    Local_12_st;
  int       Local_13_in;
  int       Local_14_in;
  double    Local_15_do;
  int       Local_16_in;
  string    Local_17_st;
  double    Local_18_do;
  double    Local_19_do;
  double    Local_20_do;
  string    Local_21_st;
  string    Local_22_st;
  string    Local_23_st;
  int       Local_24_in;
  double    Local_25_do;
  double    Local_26_do;
  double    Local_27_do;
  double    Local_28_do;
  double    Local_29_do;
  double    Local_30_do;
  double    Local_31_do;
  double    Local_32_do;
  double    Local_33_do;
  string    Local_34_st;
  string    Local_35_st;
  string    Local_36_st;
  string    Local_37_st;
  double    Local_38_do;
  int       Local_39_in;
  int       Local_40_in;
//----- -----
 string     tmp_st_1;
 double     tmp_do_2;
 int        tmp_in_3;
 int        tmp_in_4;
 int        tmp_in_5;
 int        tmp_in_6;
 string     tmp_st_7;
 int        tmp_in_8;

 Local_2_st = "MS Sans Serif" ;
 Local_3_in = 350 ;
 Local_4_in = 15 ;
 Local_5_in = 73 ;
 Local_6_in = 153 ;
 Local_7_in = 240 ;
 Local_8_in = 300 ;
 Local_9_in = 390 ;
 Local_10_in = 480 ;
 Local_11_in = 0 ;
 lizong_47("NewsLineStats" + IntegerToString(0,0,32),0,15,350,"Curr. pair","MS Sans Serif",Para_0_in,FontSize); 
 lizong_47("NewsLineStats2" + IntegerToString(0,0,32),0,73 + 1,350,"Trading time*","MS Sans Serif",Para_0_in,FontSize); 
 lizong_47("NewsLineStats3" + IntegerToString(0,0,32),0,153 + 3,350,"Day of week*","MS Sans Serif",Para_0_in,FontSize); 
 lizong_47("NewsLineStats4" + IntegerToString(0,0,32),0,240 + 3,350,"Timeout","MS Sans Serif",Para_0_in,FontSize); 
 lizong_47("NewsLineStats5" + IntegerToString(0,0,32),0,300 + 3,350,"Open / Exp. lots","MS Sans Serif",Para_0_in,FontSize); 
 lizong_47("NewsLineStats6" + IntegerToString(0,0,32),0,390,350,"Floating PnL","MS Sans Serif",Para_0_in,FontSize); 
 lizong_47("NewsLineStats7" + IntegerToString(0,0,32),0,480 - 3,350,"Exp. risk","MS Sans Serif",Para_0_in,FontSize); 
 Local_3_in=350 + 5;
 Local_12_st = "" ;
 for (Local_13_in = 0 ; Local_13_in < ArraySize(Global_26_a_168_ko) ; Local_13_in ++)
 {
   Local_14_in = 14474460 ;
   Local_15_do = 0.0 ;
   for (Local_16_in = 0 ; Local_16_in < ArraySize(Global_26_a_168_ko) ; Local_16_in ++)
   {
     if ( Global_26_a_168_ko[Local_13_in].st_1 == Global_26_a_168_ko[Local_16_in].st_1 )
     {
       Local_15_do = Local_15_do + lizong_22(Global_26_a_168_ko[Local_16_in].st_1,-1,0,false) ;
     }
   }
   Local_17_st = DoubleToString(Local_15_do,2) ;
   if ( Local_15_do<Global_29_do )
   {
     Local_17_st = "----" ;
   }
   Local_18_do = Global_26_a_168_ko[Local_13_in].do_28 ;
   if ( Local_18_do<Global_29_do )
   {
     Local_18_do = iClose(Global_26_a_168_ko[Local_13_in].st_1,Global_25_in,1) ;
   }
   Local_19_do = lizong_58(Local_13_in,Local_18_do,1,true,0,0) ;
   Local_20_do = lizong_28(Global_26_a_168_ko[Local_13_in].st_1,1,Local_19_do,Local_18_do) ;
   Local_20_do = Local_20_do * Global_57_in ;
   Local_21_st = "" ;
   if ( Global_26_a_168_ko[Local_13_in].in_18 >= 0x0 )
   {
     if ( Global_26_a_168_ko[Local_13_in].in_18 <  0xA )
     {
       Local_21_st="" + "0" + string(Global_26_a_168_ko[Local_13_in].in_18);
     }
     else
     {
       Local_21_st +=string(Global_26_a_168_ko[Local_13_in].in_18);
     }
   }
   else
   {
     Local_21_st +="----";
   }
   Local_21_st +=":";
   if ( Global_26_a_168_ko[Local_13_in].in_18 >= 0x0 )
   {
     if ( Global_26_a_168_ko[Local_13_in].in_19 <  0xA )
     {
       Local_21_st +="0" + string(Global_26_a_168_ko[Local_13_in].in_19);
     }
     else
     {
       Local_21_st +=string(Global_26_a_168_ko[Local_13_in].in_19);
     }
   }
   else
   {
     Local_21_st +="----";
   }
   Local_21_st +=" / ";
   if ( Global_26_a_168_ko[Local_13_in].in_20 >= 0x0 )
   {
     if ( Global_26_a_168_ko[Local_13_in].in_20 <  0xA )
     {
       Local_21_st +="0" + string(Global_26_a_168_ko[Local_13_in].in_20);
     }
     else
     {
       Local_21_st +=string(Global_26_a_168_ko[Local_13_in].in_20);
     }
   }
   else
   {
     Local_21_st +="----";
   }
   Local_21_st +=":";
   if ( Global_26_a_168_ko[Local_13_in].in_20 >= 0x0 )
   {
     if ( Global_26_a_168_ko[Local_13_in].in_21 <  0xA )
     {
       Local_21_st +="0" + string(Global_26_a_168_ko[Local_13_in].in_21);
     }
     else
     {
       Local_21_st +=string(Global_26_a_168_ko[Local_13_in].in_21);
     }
   }
   else
   {
     Local_21_st +="----";
   }
   if ( Local_15_do>Global_29_do )
   {
     Local_14_in = 11205983 ;
   }
   Local_22_st = string(Global_26_a_168_ko[Local_13_in].in_17) ;
   if ( !(SmartTimeFilter) )
   {
     Local_22_st = "12345" ;
   }
   if ( !(TradeOnMonday) )
   {
     StringReplace(Local_22_st,"1",""); 
   }
   if ( !(TradeOnTuesday) )
   {
     StringReplace(Local_22_st,"2",""); 
   }
   if ( !(TradeOnWednesday) )
   {
     StringReplace(Local_22_st,"3",""); 
   }
   if ( !(TradeOnThursday) )
   {
     StringReplace(Local_22_st,"4",""); 
   }
   if ( !(TradeOnFriday) )
   {
     StringReplace(Local_22_st,"5",""); 
   }
   Local_23_st = "" ;
   for (Local_24_in = 0 ; Local_24_in < StringLen(Local_22_st)  ; Local_24_in ++)
   {
     if ( Local_24_in == 0 )
     {
       Local_23_st +=StringSubstr(Local_22_st,Local_24_in,1);
     }
     else
     {
       Local_23_st +="/" + StringSubstr(Local_22_st,Local_24_in,1);
     }
   }
   StringReplace(Local_23_st,"0","Su"); 
   StringReplace(Local_23_st,"1","Mo"); 
   StringReplace(Local_23_st,"2","Tu"); 
   StringReplace(Local_23_st,"3","We"); 
   StringReplace(Local_23_st,"4","Th"); 
   StringReplace(Local_23_st,"5","Fr"); 
   StringReplace(Local_23_st,"6","Sa"); 
   Local_25_do = 0.0 ;
   Local_26_do = (MarketInfo(Global_26_a_168_ko[Local_13_in].st_1,11)>Global_29_do) ?MarketInfo(Global_26_a_168_ko[Local_13_in].st_1,11):0.00001  ;
   Local_27_do = SymbolInfoDouble(Global_26_a_168_ko[Local_13_in].st_1,26) ;
   Local_28_do = iClose(Global_26_a_168_ko[Local_13_in].st_1,Global_25_in,1) ;
   Local_29_do = lizong_58(Local_13_in,Local_28_do,1,true,0,0) ;
   Local_30_do = lizong_28(Global_26_a_168_ko[Local_13_in].st_1,1,Local_29_do,Local_28_do) ;
   if ( ( Local_26_do<Global_29_do || Local_27_do<Global_29_do ) )
   {
     Local_25_do = 0.0 ;
   }
   else
   {
     Local_31_do = MathAbs(Local_28_do - Local_29_do) / Local_26_do ;
     Local_25_do = Local_30_do * Local_27_do * Local_31_do ;
   }
   Local_32_do = 0.0 ;
   Local_33_do = AccountInfoDouble(ACCOUNT_BALANCE) ;
   if ( Local_33_do>0.1 )
   {
     Local_32_do = Local_25_do * 100.0 / Local_33_do ;
   }
   else
   {
     Local_32_do = 0.0 ;
   }
   Local_32_do = Local_32_do * Global_57_in ;
   Local_34_st = "----" ;
   if ( Local_32_do>Global_29_do )
   {
     Local_34_st = DoubleToString(Local_32_do,3) ;
   }
   Local_35_st = "----" ;
   Local_36_st = "----" ;
   if ( Local_15_do>Global_29_do )
   {
     Local_36_st = string(Global_26_a_168_ko[Local_13_in].in_11) ;
   }
   Local_35_st = Local_36_st + " / " + string(Global_26_a_168_ko[Local_13_in].in_10) ;
   Local_37_st = "" ;
   tmp_st_1 = Global_26_a_168_ko[Local_13_in].st_1;
   tmp_do_2 = 0.0;
   tmp_in_3 = Global_28_in + UID + int(MathPow(10.0,StringLen(IntegerToString(Global_28_in + UID,0,32)) ));
   tmp_in_4 = Global_28_in + UID + int(MathPow(10.0,StringLen(IntegerToString(Global_28_in + UID,0,32)) )) * 2;
   for (tmp_in_5 = 0 ; tmp_in_5 < OrdersTotal() ; tmp_in_5=tmp_in_5 + 1)
   {
     if ( OrderSelect(tmp_in_5,0,0) )
     {
       tmp_in_6 = OrderType();
       tmp_st_7 = OrderSymbol();
       tmp_in_8 = OrderMagicNumber() / 100;
       if ( ( ( tmp_in_6 != 0 || tmp_in_3 != tmp_in_8 ) && (tmp_in_6 != 1 || tmp_in_4 != tmp_in_8) ) )   continue;
       
       if ( ( tmp_st_1 != "" && tmp_st_1 != tmp_st_7 ) )   continue;
       tmp_do_2 = OrderProfit() + OrderSwap() + OrderCommission() + tmp_do_2;
        continue;
     }
     Print(TradeComment + " " + "------",": Failed to select an order! Error=",lizong_11(GetLastError())); 
     
   }
   Local_38_do = tmp_do_2 ;
   if ( MathAbs(Local_38_do)>Global_29_do )
   {
     Local_37_st = DoubleToString(Local_38_do,2) ;
   }
   else
   {
     Local_37_st = "----" ;
   }
   Local_39_in = Local_14_in ;
   if ( Local_38_do<0.0 )
   {
     Local_39_in = 4678655 ;
   }
   if ( Local_12_st == Global_26_a_168_ko[Local_13_in].st_1 )
   {
   }
   else
   {
     Local_12_st = Global_26_a_168_ko[Local_13_in].st_1 ;
     Local_11_in ++;
     if ( Local_11_in >  15 )
     {
       break;
     }
     lizong_47("NewsLineStats" + IntegerToString(Local_11_in,0,32),Local_1_in,Local_4_in,Local_3_in + 5 + Local_11_in * 14,Global_26_a_168_ko[Local_13_in].st_1,Local_2_st,Local_14_in,FontSize); 
     lizong_47("NewsLineStats2" + IntegerToString(Local_11_in,0,32),Local_1_in,Local_5_in,Local_3_in + 5 + Local_11_in * 14,Local_21_st,Local_2_st,Local_14_in,FontSize); 
     lizong_47("NewsLineStats3" + IntegerToString(Local_11_in,0,32),Local_1_in,Local_6_in,Local_3_in + 5 + Local_11_in * 14,Local_23_st,Local_2_st,Local_14_in,FontSize); 
     lizong_47("NewsLineStats4" + IntegerToString(Local_11_in,0,32),Local_1_in,Local_7_in + 10,Local_3_in + 5 + Local_11_in * 14,Local_35_st,Local_2_st,Local_14_in,FontSize); 
     lizong_47("NewsLineStats5" + IntegerToString(Local_11_in,0,32),Local_1_in,Local_8_in + 10 + 5,Local_3_in + 5 + Local_11_in * 14,Local_17_st + " / " + DoubleToString(Local_20_do,2),Local_2_st,Local_14_in,FontSize); 
     lizong_47("NewsLineStats6" + IntegerToString(Local_11_in,0,32),Local_1_in,Local_9_in + 11,Local_3_in + 5 + Local_11_in * 14,Local_37_st,Local_2_st,Local_39_in,FontSize); 
     lizong_47("NewsLineStats7" + IntegerToString(Local_11_in,0,32),Local_1_in,Local_10_in,Local_3_in + 5 + Local_11_in * 14,Local_34_st + "%",Local_2_st,Local_14_in,FontSize); 
   }
 }
 for (Local_40_in=Local_11_in + 1 ; Local_40_in < 16 ; Local_40_in ++)
 {
   lizong_47("NewsLineStats" + IntegerToString(Local_40_in,0,32),Local_1_in,Local_4_in,Local_3_in + 5 + Local_40_in * 14," ",Local_2_st,Para_0_in,FontSize); 
   lizong_47("NewsLineStats2" + IntegerToString(Local_40_in,0,32),Local_1_in,Local_5_in,Local_3_in + 5 + Local_40_in * 14," ",Local_2_st,Para_0_in,FontSize); 
   lizong_47("NewsLineStats3" + IntegerToString(Local_40_in,0,32),Local_1_in,Local_6_in,Local_3_in + 5 + Local_40_in * 14," ",Local_2_st,Para_0_in,FontSize); 
   lizong_47("NewsLineStats4" + IntegerToString(Local_40_in,0,32),Local_1_in,Local_7_in + 10,Local_3_in + 5 + Local_40_in * 14," ",Local_2_st,Para_0_in,FontSize); 
   lizong_47("NewsLineStats5" + IntegerToString(Local_40_in,0,32),Local_1_in,Local_8_in + 10 + 5,Local_3_in + 5 + Local_40_in * 14," ",Local_2_st,Para_0_in,FontSize); 
   lizong_47("NewsLineStats6" + IntegerToString(Local_40_in,0,32),Local_1_in,Local_9_in + 11,Local_3_in + 5 + Local_40_in * 14," ",Local_2_st,Para_0_in,FontSize); 
   lizong_47("NewsLineStats7" + IntegerToString(Local_40_in,0,32),Local_1_in,Local_10_in,Local_3_in + 5 + Local_40_in * 14," ",Local_2_st,Para_0_in,FontSize); 
 }
 }
//lizong_27 <<==--------   --------
 double lizong_28( string Para_0_st,int Para_1_in,double Para_2_do,double Para_3_do)
 {
  double    Local_1_do;
  double    Local_2_do;
  double    Local_3_do;
  double    Local_4_do;
  double    Local_5_do;
  double    Local_6_do;
  double    Local_7_do;
  double    Local_8_do;
  double    Local_9_do;
  int       Local_10_in;
  int       Local_11_in;
  double    Local_12_do;
//----- -----
 double     tmp_do_1;
 double     tmp_do_2;
 double     tmp_do_3;
 double     tmp_do_4;
 double     tmp_do_5;
 double     tmp_do_6;
 double     tmp_do_7;
 double     tmp_do_8;
 double     tmp_do_9;
 double     tmp_do_10;
 double     tmp_do_11;
 double     tmp_do_12;
 double     tmp_do_13;
 double     tmp_do_14;
 double     tmp_do_15;
 double     tmp_do_16;

 Local_2_do = SymbolInfoDouble(Para_0_st,36) ;
 Local_3_do = SymbolInfoDouble(Para_0_st,34) ;
 Local_4_do = SymbolInfoDouble(Para_0_st,35) ;
 Local_5_do = (MarketInfo(Para_0_st,11)>Global_29_do) ?MarketInfo(Para_0_st,11):0.00001  ;
 if ( Local_2_do<0.001 )
 {
   Local_2_do = 0.001 ;
 }
 Local_6_do = AccountFreeMargin() ;
 Local_7_do = Local_3_do ;
 Local_8_do = 0.0 ;
 Local_9_do = 0.0 ;
 if ( LotSizingMethod == 0 )
 {
   Local_7_do = LotSizingValueFixed ;
   Local_9_do = 0.0 ;
 }
 if ( LotSizingMethod == 1 )
 {
   Local_9_do = LotSizingValueDynamic ;
 }
 if ( LotSizingMethod == 2 )
 {
   Local_9_do = -(LotSizingValueDynamic);
 }
 if ( Local_9_do>Global_29_do )
 {
   AccountInfoDouble(ACCOUNT_BALANCE); 
   Local_8_do = Local_6_do / Local_9_do ;
   Local_7_do = MathRound(Local_8_do * 0.01 / Local_2_do) * Local_2_do ;
 }
 if ( Local_9_do< -(Global_29_do) )
 {
   AccountInfoDouble(ACCOUNT_EQUITY); 
   Local_8_do = Local_6_do / ( -(Local_9_do)) ;
   Local_7_do = MathRound(Local_8_do * 0.01 / Local_2_do) * Local_2_do ;
 }
 if ( LotSizingMethod == 6 )
 {
   Local_9_do = 0.0 ;
   if ( LotSizingValueRiskPerTrade>Global_29_do && LotSizingValueRiskPerTrade<100.0 )
   {
     tmp_do_1 = (MarketInfo(Para_0_st,11)>Global_29_do) ?MarketInfo(Para_0_st,11):0.00001 ;
     tmp_do_2 = SymbolInfoDouble(Para_0_st,26);
     tmp_do_3 = 0.0;
     if ( Para_1_in == 1 && tmp_do_1>Global_29_do )
     {
       tmp_do_3 = (Para_3_do - Para_2_do) / tmp_do_1;
     }
     if ( Para_1_in == -1 && tmp_do_1>Global_29_do )
     {
       tmp_do_3 = (Para_2_do - Para_3_do) / tmp_do_1;
     }
     if ( Para_2_do>tmp_do_1 * 100.0 && tmp_do_1>Global_29_do && tmp_do_2>Global_29_do && tmp_do_3>Global_29_do && Para_3_do>tmp_do_1 * 100.0 )
     {
       tmp_do_4 = AccountInfoDouble(ACCOUNT_BALANCE) / 100.0 * LotSizingValueRiskPerTrade / (tmp_do_3 * tmp_do_2);
     }
     else
     {
       tmp_do_4 = SymbolInfoDouble(Para_0_st,34);
     }
   }
   else
   {
     tmp_do_4 = tmp_do_4;
   }
   Local_7_do = tmp_do_4 ;
 }
 if ( LotSizingMethod == 3 )
 {
   Local_9_do = 0.0 ;
   if ( 5.0>Global_29_do )
   {
     tmp_do_5 = (MarketInfo(Para_0_st,11)>Global_29_do) ?MarketInfo(Para_0_st,11):0.00001 ;
     tmp_do_6 = SymbolInfoDouble(Para_0_st,26);
     tmp_do_7 = 0.0;
     if ( Para_1_in == 1 && tmp_do_5>Global_29_do )
     {
       tmp_do_7 = (Para_3_do - Para_2_do) / tmp_do_5;
     }
     if ( Para_1_in == -1 && tmp_do_5>Global_29_do )
     {
       tmp_do_7 = (Para_2_do - Para_3_do) / tmp_do_5;
     }
     if ( Para_2_do>tmp_do_5 * 100.0 && tmp_do_5>Global_29_do && tmp_do_6>Global_29_do && tmp_do_7>Global_29_do && Para_3_do>tmp_do_5 * 100.0 )
     {
       tmp_do_8 = AccountInfoDouble(ACCOUNT_BALANCE) / 100.0 * 5.0 / (tmp_do_7 * tmp_do_6);
     }
     else
     {
       tmp_do_8 = SymbolInfoDouble(Para_0_st,34);
     }
   }
   else
   {
     tmp_do_8 = tmp_do_8;
   }
   Local_7_do = tmp_do_8 ;
 }
 if ( LotSizingMethod == 4 )
 {
   Local_9_do = 0.0 ;
   if ( 2.0>Global_29_do )
   {
     tmp_do_9 = (MarketInfo(Para_0_st,11)>Global_29_do) ?MarketInfo(Para_0_st,11):0.00001 ;
     tmp_do_10 = SymbolInfoDouble(Para_0_st,26);
     tmp_do_11 = 0.0;
     if ( Para_1_in == 1 && tmp_do_9>Global_29_do )
     {
       tmp_do_11 = (Para_3_do - Para_2_do) / tmp_do_9;
     }
     if ( Para_1_in == -1 && tmp_do_9>Global_29_do )
     {
       tmp_do_11 = (Para_2_do - Para_3_do) / tmp_do_9;
     }
     if ( Para_2_do>tmp_do_9 * 100.0 && tmp_do_9>Global_29_do && tmp_do_10>Global_29_do && tmp_do_11>Global_29_do && Para_3_do>tmp_do_9 * 100.0 )
     {
       tmp_do_12 = AccountInfoDouble(ACCOUNT_BALANCE) / 100.0 * 2.0 / (tmp_do_11 * tmp_do_10);
     }
     else
     {
       tmp_do_12 = SymbolInfoDouble(Para_0_st,34);
     }
   }
   else
   {
     tmp_do_12 = tmp_do_12;
   }
   Local_7_do = tmp_do_12 ;
 }
 if ( LotSizingMethod == 5 )
 {
   Local_9_do = 0.0 ;
   if ( 0.5>Global_29_do )
   {
     tmp_do_13 = (MarketInfo(Para_0_st,11)>Global_29_do) ?MarketInfo(Para_0_st,11):0.00001 ;
     tmp_do_14 = SymbolInfoDouble(Para_0_st,26);
     tmp_do_15 = 0.0;
     if ( Para_1_in == 1 && tmp_do_13>Global_29_do )
     {
       tmp_do_15 = (Para_3_do - Para_2_do) / tmp_do_13;
     }
     if ( Para_1_in == -1 && tmp_do_13>Global_29_do )
     {
       tmp_do_15 = (Para_2_do - Para_3_do) / tmp_do_13;
     }
     if ( Para_2_do>tmp_do_13 * 100.0 && tmp_do_13>Global_29_do && tmp_do_14>Global_29_do && tmp_do_15>Global_29_do && Para_3_do>tmp_do_13 * 100.0 )
     {
       tmp_do_16 = AccountInfoDouble(ACCOUNT_BALANCE) / 100.0 * 0.5 / (tmp_do_15 * tmp_do_14);
     }
     else
     {
       tmp_do_16 = SymbolInfoDouble(Para_0_st,34);
     }
   }
   else
   {
     tmp_do_16 = tmp_do_16;
   }
   Local_7_do = tmp_do_16 ;
 }
 if ( Global_57_in >  1 )
 {
   Local_7_do = Local_7_do / Global_57_in ;
 }
 if ( FridayHalfLots && TimeDayOfWeek(Global_68_da) == 5 && TimeHour(Global_68_da) >  12 )
 {
   Local_7_do = Local_7_do / 2.0 ;
 }
 Local_10_in = MathRound(Local_7_do / Local_2_do) ;
 Local_7_do = Local_10_in * Local_2_do ;
 if ( Local_7_do<Local_3_do )
 {
   Local_7_do = Local_3_do ;
 }
 if ( UseEvenLotSize )
 {
   Local_11_in = MathRound(Local_7_do / Local_2_do) ;
   if ( MathMod(Local_11_in,2.0)!=0.0 )
   {
     Local_7_do = Local_7_do + Local_2_do ;
   }
 }
 if ( Local_7_do>MaximumLot )
 {
   Local_7_do = MaximumLot ;
 }
 Local_12_do = SymbolInfoDouble(Para_0_st,55) ;
 if ( Local_7_do>Local_12_do && Local_12_do>Global_29_do )
 {
   Local_7_do = Local_12_do ;
 }
 if ( Local_7_do>Local_4_do )
 {
   Local_7_do = Local_4_do ;
 }
 if ( Local_2_do<0.001001 && Local_2_do>0.000999 )
 {
   Local_7_do = NormalizeDouble(Local_7_do,3) ;
 }
 if ( Local_2_do<0.010001 && Local_2_do>0.009999 )
 {
   Local_7_do = NormalizeDouble(Local_7_do,2) ;
 }
 if ( Local_2_do<0.100001 && Local_2_do>0.099999 )
 {
   Local_7_do = NormalizeDouble(Local_7_do,1) ;
 }
 if ( Local_2_do<1.000001 && Local_2_do>0.999999 )
 {
   Local_7_do = NormalizeDouble(Local_7_do,0) ;
 }
 return(Local_7_do); 
 }
//lizong_28 <<==--------   --------
 void lizong_29( int Para_0_in,string Para_1_st)
 {
  string    Local_1_st;
  short     Local_2_sh;
  string    Local_3_st_ko[];
  int       Local_4_in;
  int       Local_5_in;
  short     Local_6_sh;
  string    Local_7_st_ko[];
  int       Local_8_in;
  int       Local_9_in;
  string    Local_10_st;
  string    Local_11_st;
//----- -----
 string     tmp_st_1;
 string     tmp_st_2;
 string     tmp_st_3;
 string     tmp_st_4;
 string     tmp_st_5;
 string     tmp_st_6;

 tmp_st_1 = StringTrimLeft(CustomEvents);
 tmp_st_2 = StringTrimRight(StringTrimLeft(CustomEvents));
 Local_1_st = StringTrimRight(StringTrimLeft(CustomEvents)) ;
 if ( Local_1_st != "" )
 {
   tmp_st_3 = StringTrimLeft(Global_26_a_168_ko[Para_0_in].st_41);
   tmp_st_4 = StringTrimRight(StringTrimLeft(Global_26_a_168_ko[Para_0_in].st_41));
   if ( StringTrimRight(StringTrimLeft(Global_26_a_168_ko[Para_0_in].st_41)) != "" )
   {
     Global_26_a_168_ko[Para_0_in].st_41 +=",";
   }
   Local_2_sh = StringGetCharacter(",",0) ;
   Local_4_in = StringSplit(Local_1_st,Local_2_sh,Local_3_st_ko) ;
   for (Local_5_in = 0 ; Local_5_in < Local_4_in ; Local_5_in ++)
   {
     Local_6_sh = StringGetCharacter("-",0) ;
     Local_8_in = StringSplit(Local_3_st_ko[Local_5_in],Local_6_sh,Local_7_st_ko) ;
     if ( Local_8_in >  1 )
     {
       for (Local_9_in = 1 ; Local_9_in < Local_8_in ; Local_9_in ++)
       {
         Local_10_st = Local_7_st_ko[Local_9_in] ;
         StringToLower(Local_10_st); 
         StringToLower(Para_1_st); 
         if ( Local_10_st == Para_1_st )
         {
           Global_26_a_168_ko[Para_0_in].st_41 +=Local_7_st_ko[0] + ",";
           break;
         }
       }
     }
     if ( Local_8_in == 1 )
     {
       tmp_st_5 = StringTrimLeft(Local_7_st_ko[0]);
       tmp_st_6 = StringTrimRight(StringTrimLeft(Local_7_st_ko[0]));
       if ( StringTrimRight(StringTrimLeft(Local_7_st_ko[0])) != "" )
       {
         Global_26_a_168_ko[Para_0_in].st_41 +=Local_7_st_ko[0] + ",";
       }
     }
   }
 }
 Local_11_st = StringSubstr(Global_26_a_168_ko[Para_0_in].st_41,StringLen(Global_26_a_168_ko[Para_0_in].st_41)  - 1,1) ;
 if ( Local_11_st != "," )   return;
 Global_26_a_168_ko[Para_0_in].st_41 = StringSubstr(Global_26_a_168_ko[Para_0_in].st_41,0,StringLen(Global_26_a_168_ko[Para_0_in].st_41)  - 1);
 }
//lizong_29 <<==--------   --------
 void lizong_30( int Para_0_in)
 {
  int       Local_1_in = 0;
  string    Local_2_st;
  int       Local_3_in;
  int       Local_4_in;
  int       Local_5_in;
  int       Local_6_in;
  int       Local_7_in;
  int       Local_8_in;
  int       Local_9_in;
  int       Local_10_in;
  datetime  Local_11_da;
  int       Local_12_in;
  int       Local_13_in;
  string    Local_14_st;
  string    Local_15_st;
  int       Local_16_in;
//----- -----
 long       tmp_lo_1;
 int        tmp_in_2;
 int        tmp_in_3;
 string     tmp_st_4;
 string     tmp_st_5;
 string     tmp_st_6;
 string     tmp_st_7;
 int        tmp_in_8;
 int        tmp_in_9;
 string     tmp_st_10;

 Local_2_st = "MS Sans Serif" ;
 Local_3_in = 30 ;
 Local_4_in = 200 ;
 Local_5_in = 235 ;
 Local_6_in = 281 ;
 Local_7_in = 314 ;
 Local_8_in = 345 ;
 Local_9_in = 0 ;
 lizong_47("NewsLine" + IntegerToString(0,0,32),0,200,30,"Time","MS Sans Serif",Para_0_in,FontSize); 
 lizong_47("NewsLine2" + IntegerToString(0,0,32),0,235,30,"In","MS Sans Serif",Para_0_in,FontSize); 
 lizong_47("NewsLine3" + IntegerToString(0,0,32),0,281 - 20,30,"Currency","MS Sans Serif",Para_0_in,FontSize); 
 lizong_47("NewsLine4" + IntegerToString(0,0,32),0,314 - 2,30,"Impact","MS Sans Serif",Para_0_in,FontSize); 
 lizong_47("NewsLine5" + IntegerToString(0,0,32),0,345 + 15,30,"News Event","MS Sans Serif",Para_0_in,FontSize); 
 Local_3_in=30 + 5;
 if ( Global_35_in != -999 )
 {
   for (Local_10_in = 0 ; Local_10_in < Global_40_in ; Local_10_in ++)
   {
     Local_11_da=StringToTime(StringSubstr(Global_39_st_kosi4[Local_10_in][0],0,4) + "." + StringSubstr(Global_39_st_kosi4[Local_10_in][0],5,2) + "." + StringSubstr(Global_39_st_kosi4[Local_10_in][0],8,2) + " " + StringSubstr(Global_39_st_kosi4[Local_10_in][0],11,2) + ":" + StringSubstr(Global_39_st_kosi4[Local_10_in][0],14,4)) + Global_35_in * 60 * 60;
     tmp_lo_1=TimeCurrent() - WaitMinutesAfterEvent * 60;
     if ( Local_11_da < tmp_lo_1 )   continue;
     tmp_lo_1=TimeCurrent() + 82800;
     if ( Local_11_da > tmp_lo_1 )   continue;
     Local_9_in ++;
     if ( Local_9_in > 19 )   break;
     Local_12_in = 14474460 ;
     Local_13_in = 16777215 ;
     Local_14_st = "" ;
     if ( Global_39_st_kosi4[Local_10_in][2] == "High" )
     {
       Local_14_st = "High" ;
       Local_13_in = 255 ;
     }
     if ( Global_39_st_kosi4[Local_10_in][2] == "Moderate" )
     {
       Local_14_st = "Mod" ;
       Local_13_in = 42495 ;
     }
     if ( Global_39_st_kosi4[Local_10_in][2] == "Low" )
     {
       Local_14_st = "Low" ;
       Local_13_in = 32768 ;
     }
     if ( Global_39_st_kosi4[Local_10_in][2] == "Holiday" )
     {
       Local_14_st = "High" ;
       Local_13_in = 65535 ;
     }
     if ( Local_11_da >= TimeCurrent() - WaitMinutesAfterEvent * 60 && Local_11_da <= TimeCurrent() + WaitMinutesBeforeEvent * 60 )
     {
       Local_12_in = 255 ;
     }
     Local_15_st = Global_39_st_kosi4[Local_10_in][3] ;
     if ( StringLen(Local_15_st)  >  32 )
     {
       Local_15_st = StringSubstr(Local_15_st,0,32) ;
     }
     lizong_47("NewsLine" + IntegerToString(Local_9_in,0,32),Local_1_in,Local_4_in,Local_3_in + 5 + Local_9_in * 14,TimeToString(Local_11_da,2),Local_2_st,Local_12_in,FontSize); 
     tmp_in_2 = FontSize;
     tmp_in_3 = Local_12_in;
     tmp_st_4 = Local_2_st;
     tmp_st_7 = "------------";
     tmp_in_8 = Local_11_da - TimeCurrent();
     if ( tmp_in_8 >= 0 )
     {
       tmp_in_9 = tmp_in_8 / 3600;
       tmp_in_8 = tmp_in_8 - (tmp_in_8 / 60 - tmp_in_8 / 3600 * 60) * 60 - tmp_in_8 / 3600 * 60 * 60;
       tmp_st_10 = IntegerToString(tmp_in_8 / 60 - tmp_in_8 / 3600 * 60,2,48);
       if ( tmp_in_8 == 60 )
       {
         tmp_in_8 = 59;
       }
       IntegerToString(tmp_in_8,2,48); 
       tmp_st_7 = IntegerToString(tmp_in_9,2,48) + "h" + tmp_st_10 + "m";
     }
     lizong_47("NewsLine2" + IntegerToString(Local_9_in,0,32),Local_1_in,Local_5_in,Local_3_in + 5 + Local_9_in * 14,tmp_st_7,tmp_st_4,tmp_in_3,tmp_in_2); 
     lizong_47("NewsLine3" + IntegerToString(Local_9_in,0,32),Local_1_in,Local_6_in,Local_3_in + 5 + Local_9_in * 14,Global_39_st_kosi4[Local_10_in][1],Local_2_st,Local_12_in,FontSize); 
     lizong_47("NewsLine4" + IntegerToString(Local_9_in,0,32),Local_1_in,Local_7_in,Local_3_in + 5 + Local_9_in * 14,Local_14_st,Local_2_st,Local_13_in,FontSize); 
     lizong_47("NewsLine5" + IntegerToString(Local_9_in,0,32),Local_1_in,Local_8_in,Local_3_in + 5 + Local_9_in * 14,Local_15_st,Local_2_st,Local_12_in,FontSize); 
     
   }
 }
 for (Local_16_in=Local_9_in + 1 ; Local_16_in < 20 ; Local_16_in ++)
 {
   lizong_47("NewsLine" + IntegerToString(Local_16_in,0,32),Local_1_in,Local_4_in,Local_3_in + 5 + Local_16_in * 14," ",Local_2_st,Para_0_in,FontSize); 
   lizong_47("NewsLine2" + IntegerToString(Local_16_in,0,32),Local_1_in,Local_5_in,Local_3_in + 5 + Local_16_in * 14," ",Local_2_st,Para_0_in,FontSize); 
   lizong_47("NewsLine3" + IntegerToString(Local_16_in,0,32),Local_1_in,Local_6_in,Local_3_in + 5 + Local_16_in * 14," ",Local_2_st,Para_0_in,FontSize); 
   lizong_47("NewsLine4" + IntegerToString(Local_16_in,0,32),Local_1_in,Local_7_in,Local_3_in + 5 + Local_16_in * 14," ",Local_2_st,Para_0_in,FontSize); 
   lizong_47("NewsLine5" + IntegerToString(Local_16_in,0,32),Local_1_in,Local_8_in,Local_3_in + 5 + Local_16_in * 14," ",Local_2_st,Para_0_in,FontSize); 
 }
 }
//lizong_30 <<==--------   --------
 void lizong_31( datetime Para_0_da,bool Para_1_bo)
 {
  int       Local_1_in;
  string    Local_2_st;
  short     Local_3_sh;
  string    Local_4_st_ko[];
  int       Local_5_in;
  int       Local_6_in;
  short     Local_7_sh;
  string    Local_8_st_ko[];
  int       Local_9_in;
  string    Local_10_st;
  bool      Local_11_bo;
  string    Local_12_st_ko[];
//----- -----
 int        tmp_in_1;
 int        tmp_in_2;
 int        tmp_in_3;
 int        tmp_in_4;
 string     tmp_st_5;
 string     tmp_st_6;
 bool       tmp_bo_7;
 int        tmp_in_8;
 int        tmp_in_9;
 int        tmp_in_10;

 Global_40_in = 0 ;
 if ( StringToTime(TimeToString(Global_44_da,1) + " 00:00") <  604800 )
 {
   tmp_in_1 = -1;
 }
 else
 {
   tmp_in_2 = TimeDayOfWeek(StringToTime(TimeToString(Global_44_da,1) + " 00:00"));
   if ( tmp_in_2 == 0 )
   {
     tmp_in_2 = 7;
   }
   tmp_in_3 = tmp_in_2 - 1;
   tmp_in_4 = TimeDayOfWeek(StringToTime(TimeToString(Para_0_da,1) + " 00:00"));
   if ( tmp_in_4 == 0 )
   {
     tmp_in_4 = 7;
   }
   tmp_in_1 = int(MathRound((StringToTime(TimeToString(Para_0_da,1) + " 00:00") + (7 - tmp_in_4 + 1) * 86400.0 - (StringToTime(TimeToString(Global_44_da,1) + " 00:00") - tmp_in_3 * 86400.0)) / 604800.0));
 }
 Local_1_in = tmp_in_1 ;
 if ( Local_1_in >  0 )
 {
   Local_2_st = Global_46_st_ko[Local_1_in - 1] ;
   Local_3_sh = StringGetCharacter(";",0) ;
   Local_5_in = StringSplit(Local_2_st,Local_3_sh,Local_4_st_ko) ;
   for (Local_6_in = 0 ; Local_6_in < Local_5_in ; Local_6_in ++)
   {
     Local_7_sh = StringGetCharacter(",",0) ;
     Local_9_in = StringSplit(Local_4_st_ko[Local_6_in],Local_7_sh,Local_8_st_ko) ;
     if ( Local_9_in == 5 )
     {
       Global_39_st_kosi4[Global_40_in][0] = Local_8_st_ko[0];
       Global_39_st_kosi4[Global_40_in][1] = Local_8_st_ko[1];
       Global_39_st_kosi4[Global_40_in][2] = Local_8_st_ko[2];
       Global_39_st_kosi4[Global_40_in][3] = Local_8_st_ko[3];
       Local_10_st = Global_39_st_kosi4[Global_40_in][3] ;
       tmp_st_5 = Local_10_st;
       tmp_st_6 = Global_39_st_kosi4[Global_40_in][1];
       tmp_bo_7 = false;
       StringToLower(tmp_st_6); 
       StringToLower(tmp_st_5); 
       for (tmp_in_8 = 0 ; tmp_in_8 < ArraySize(Global_26_a_168_ko) ; tmp_in_8=tmp_in_8 + 1)
       {
         if ( StringFind(Global_26_a_168_ko[tmp_in_8].st_41,tmp_st_6,0) != -1 )
         {
           tmp_bo_7 = true;
           break;
         }
         tmp_in_9 = StringSplit(Global_26_a_168_ko[tmp_in_8].st_41,StringGetCharacter(",",0),Local_12_st_ko);
         for (tmp_in_10 = 0 ; tmp_in_10 < tmp_in_9 ; tmp_in_10=tmp_in_10 + 1)
         {
           if ( StringFind(tmp_st_5,Local_12_st_ko[tmp_in_10],0) != -1 )
           {
             tmp_bo_7 = true;
             break;
           }
         }
       }
       Local_11_bo = tmp_bo_7 ;
       if ( !(Local_11_bo) )
       {
          continue;
       }
       if ( StringFind(Global_39_st_kosi4[Global_40_in][2],"High",0) <  0 && ( StringFind(Global_39_st_kosi4[Global_40_in][2],"Holiday",0) < 0 || !(Para_1_bo) ) && ( StringFind(Global_39_st_kosi4[Global_40_in][2],"Moderate",0) < 0 || !(MediumImpactNews) ) && ( StringFind(Global_39_st_kosi4[Global_40_in][2],"Low",0) < 0 || !(LowImpactNews) ) )
       {
          continue;
       }
       if ( !(Speaks) && Local_8_st_ko[4] == "1" )
       {
          continue;
       }
       Global_40_in ++;
     }
     
   }
   if ( Global_40_in >  0 )
   {
     Global_41_da = TimeCurrent() ;
     Print(TradeComment + " " + "->"," News events successfully loaded: ",IntegerToString(Global_40_in,0,32)); 
   }
   if ( Global_40_in == 0 )
   {
     Global_41_da = TimeCurrent() ;
   }
   return;
 }
 Global_40_in = 0 ;
 Global_41_da = 0 ;
 }
//lizong_31 <<==--------   --------
 void lizong_32( bool Para_0_bo)
 {
  string    Local_1_st;
  int       Local_2_in;
  int       Local_3_in;
  int       Local_4_in;
  string    Local_5_st;
  bool      Local_6_bo;
  string    Local_7_st;
  short     Local_8_sh;
  string    Local_9_st_ko[];
  int       Local_10_in;
  int       Local_11_in;
  datetime  Local_12_da;
  string    Local_13_st;
  string    Local_14_st_ko[];
  int       Local_15_in;
  int       Local_16_in;
  int       Local_17_in;
  int       Local_18_in;
  string    Local_19_st;
  string    Local_20_st;
  string    Local_21_st;
  string    Local_22_st;
  string    Local_23_st_ko[];
//----- -----
 string     tmp_st_1;
 string     tmp_st_2;
 string     tmp_st_3;
 string     tmp_st_4;
 bool       tmp_bo_5;
 int        tmp_in_6;
 int        tmp_in_7;
 int        tmp_in_8;
 string     tmp_st_9;
 string     tmp_st_10;
 string     tmp_st_11;
 string     tmp_st_12;

 Local_1_st = lizong_35("https://ec.forexprostools.com/?columns=exc_currency,exc_importance&features=timezone&calType=week&timeZone=55&lang=1",true) ;
 if ( Local_1_st != "-1" )
 {
   Global_40_in = 0 ;
   Local_2_in=StringFind(Local_1_st,"pageStartAt>",0) + 12;
   Local_3_in = StringFind(Local_1_st,"</tbody>",0) ;
   Local_1_st = StringSubstr(Local_1_st,Local_2_in,Local_3_in - Local_2_in) ;
   Local_2_in = 0 ;
   while (!(IsStopped()))
   {
     Local_2_in=StringFind(Local_1_st,"event_timestamp",Local_2_in) + 17;
     Local_3_in=StringFind(Local_1_st,"onclick",Local_2_in) - 2;
     if ( Local_2_in < 17 || Local_3_in < 0 )   break;
     Global_39_st_kosi4[Global_40_in][0] = StringSubstr(Local_1_st,Local_2_in,Local_3_in - Local_2_in);
     Local_2_in=StringFind(Local_1_st,"flagCur",Local_2_in) + 10;
     Local_3_in=Local_2_in + 3;
     if ( Local_2_in < 10 || Local_3_in < 3 )   break;
     Global_39_st_kosi4[Global_40_in][1] = StringSubstr(Local_1_st,Local_2_in,Local_3_in - Local_2_in);
     Local_2_in=StringFind(Local_1_st,"title",Local_2_in) + 7;
     Local_3_in=StringFind(Local_1_st,"Volatility",Local_2_in) - 1;
     if ( Local_2_in < 7 || Local_3_in < 0 )   break;
     Global_39_st_kosi4[Global_40_in][2] = StringSubstr(Local_1_st,Local_2_in,Local_3_in - Local_2_in);
     Local_2_in=StringFind(Local_1_st,"left event",Local_2_in) + 12;
     Local_3_in = StringFind(Local_1_st,"<",Local_2_in) ;
     Local_4_in = StringFind(Local_1_st,"title=\"Speech\"",Local_2_in) ;
     if ( Local_2_in < 12 || Local_3_in < 0 )   break;
     Local_5_st = StringSubstr(Local_1_st,Local_2_in,Local_3_in - Local_2_in) ;
     StringReplace(Local_5_st,"&nbsp;",""); 
     tmp_st_1 = StringTrimLeft(Local_5_st);
     Local_5_st = StringTrimLeft(Local_5_st) ;
     tmp_st_2 = StringTrimRight(Local_5_st);
     Local_5_st = StringTrimRight(Local_5_st) ;
     Global_39_st_kosi4[Global_40_in][3] = Local_5_st;
     tmp_st_3 = Local_5_st;
     tmp_st_4 = Global_39_st_kosi4[Global_40_in][1];
     tmp_bo_5 = false;
     StringToLower(tmp_st_4); 
     StringToLower(tmp_st_3); 
     for (tmp_in_6 = 0 ; tmp_in_6 < ArraySize(Global_26_a_168_ko) ; tmp_in_6=tmp_in_6 + 1)
     {
       if ( StringFind(Global_26_a_168_ko[tmp_in_6].st_41,tmp_st_4,0) != -1 )
       {
         tmp_bo_5 = true;
         break;
       }
       tmp_in_7 = StringSplit(Global_26_a_168_ko[tmp_in_6].st_41,StringGetCharacter(",",0),Local_23_st_ko);
       for (tmp_in_8 = 0 ; tmp_in_8 < tmp_in_7 ; tmp_in_8=tmp_in_8 + 1)
       {
         if ( StringFind(tmp_st_3,Local_23_st_ko[tmp_in_8],0) != -1 )
         {
           tmp_bo_5 = true;
           break;
         }
       }
     }
     Local_6_bo = tmp_bo_5 ;
     if ( !(Local_6_bo) )
     {
        continue;
     }
     if ( StringFind(Global_39_st_kosi4[Global_40_in][2],"High",0) <  0 && ( StringFind(Global_39_st_kosi4[Global_40_in][2],"Holiday",0) < 0 || !(Para_0_bo) ) && ( StringFind(Global_39_st_kosi4[Global_40_in][2],"Moderate",0) < 0 || !(MediumImpactNews) ) && ( StringFind(Global_39_st_kosi4[Global_40_in][2],"Low",0) < 0 || !(LowImpactNews) ) )
     {
        continue;
     }
     if ( !(Speaks) && Local_4_in >  0 && Local_4_in - Local_2_in <  200 )
     {
        continue;
     }
     Global_40_in ++;
     if ( Global_40_in == 900 )
     {
       break;
     }
     
   }
   if ( Para_0_bo )
   {
     Local_7_st = Local_1_st ;
     StringReplace(Local_7_st,"theDay1","`"); 
     Local_8_sh = StringGetCharacter("`",0) ;
     Local_10_in = StringSplit(Local_7_st,Local_8_sh,Local_9_st_ko) ;
     for (Local_11_in = 0 ; Local_11_in < Local_10_in ; Local_11_in ++)
     {
       if ( Local_11_in != 0 )
       {
         Local_12_da = StringToInteger("1" + StringSubstr(Local_9_st_ko[Local_11_in],0,9)) ;
         Local_13_st = Local_9_st_ko[Local_11_in] ;
         StringReplace(Local_13_st,">Holiday","`"); 
         Local_15_in = StringSplit(Local_13_st,Local_8_sh,Local_14_st_ko) ;
         for (Local_16_in = 0 ; Local_16_in < Local_15_in ; Local_16_in ++)
         {
           if ( Local_16_in == 0 )   continue;
           Local_17_in=StringFind(Local_14_st_ko[Local_16_in],"left event",0) + 12;
           Local_18_in = StringFind(Local_14_st_ko[Local_16_in],"<",Local_17_in) ;
           if ( Local_17_in < 12 || Local_18_in < 0 )   continue;
           Local_19_st = StringSubstr(Local_14_st_ko[Local_16_in],Local_17_in,Local_18_in - Local_17_in) ;
           StringReplace(Local_19_st,"&nbsp;",""); 
           tmp_st_9 = StringTrimLeft(Local_19_st);
           Local_19_st = StringTrimLeft(Local_19_st) ;
           tmp_st_10 = StringTrimRight(Local_19_st);
           Local_19_st = StringTrimRight(Local_19_st) ;
           if ( StringLen(Local_19_st)  >  4 )
           {
             Local_20_st = TimeToString(Local_12_da,7) ;
             StringReplace(Local_20_st,".","-"); 
             Local_21_st = "" ;
             if ( StringFind(Local_19_st,"United States",0) != -1 )
             {
               Local_21_st = "USD" ;
             }
             if ( StringFind(Local_19_st,"United Kingdom",0) != -1 )
             {
               Local_21_st = "GBP" ;
             }
             if ( ( StringFind(Local_19_st,"Germany",0) != -1 || StringFind(Local_19_st,"Italy",0) != -1 || StringFind(Local_19_st,"France",0) != -1 || StringFind(Local_19_st,"Spain",0) != -1 ) )
             {
               Local_21_st = "EUR" ;
             }
             if ( StringFind(Local_19_st,"Australia",0) != -1 )
             {
               Local_21_st = "AUD" ;
             }
             if ( StringFind(Local_19_st,"Japan",0) != -1 )
             {
               Local_21_st = "JPY" ;
             }
             if ( StringFind(Local_19_st,"Canada",0) != -1 )
             {
               Local_21_st = "CAD" ;
             }
             if ( StringFind(Local_19_st,"New Zealand",0) != -1 )
             {
               Local_21_st = "NZD" ;
             }
             tmp_st_11 = StringTrimLeft(Symbols);
             tmp_st_12 = StringTrimRight(StringTrimLeft(Symbols));
             Local_22_st = StringTrimRight(StringTrimLeft(Symbols)) ;
             StringReplace(Local_22_st,",",""); 
             if ( Local_22_st == "" )
             {
               Local_22_st = Symbol() ;
             }
             Local_22_st +="USD";
             if ( Local_21_st != "" && StringFind(Local_22_st,Local_21_st,0) != -1 )
             {
               Global_39_st_kosi4[Global_40_in][0] = Local_20_st;
               Global_39_st_kosi4[Global_40_in][1] = Local_21_st;
               Global_39_st_kosi4[Global_40_in][2] = "Holiday";
               Global_39_st_kosi4[Global_40_in][3] = Local_19_st;
               Global_40_in ++;
               if ( Global_40_in == 900 )
               {
                 break;
               }
             }
           }
           
         }
       }
     }
   }
   if ( Global_40_in >  0 )
   {
     Global_41_da = TimeCurrent() ;
     Print(TradeComment + " " + "->"," News events successfully loaded: ",IntegerToString(Global_40_in,0,32)); 
   }
   if ( Global_40_in != 0 )   return;
   Global_41_da = TimeCurrent() ;
   return;
 }
 Global_40_in = 0 ;
 Global_41_da = 0 ;
 }
//lizong_32 <<==--------   --------
 void lizong_33()
 {
  int       Local_1_in;
  string    Local_2_st;
  int       Local_3_in;
  int       Local_4_in;
  int       Local_5_in;
  string    Local_6_st;
  string    Local_7_st;
  datetime  Local_8_da;
  int       Local_9_in;
//----- -----
 int        tmp_in_1;
 int        tmp_in_2;
 int        tmp_in_3;
 int        tmp_in_4;
 string     tmp_st_5;
 string     tmp_st_6;
 int        tmp_in_7;
 int        tmp_in_8;
 int        tmp_in_9;
 int        tmp_in_10;

 if ( Global_44_da != 0 )   return;
 Global_44_da = StringToTime(TimeToString(TimeCurrent(),1) + " 00:00") ;
 Global_45_da = StringToTime("2024.01.01 00:00") ;
 if ( Global_44_da <= 0 || Global_45_da <= 0 )   return;
 
 if ( StringToTime(TimeToString(Global_44_da,1) + " 00:00") <  604800 )
 {
   tmp_in_1 = -1;
 }
 else
 {
   tmp_in_2 = TimeDayOfWeek(StringToTime(TimeToString(Global_44_da,1) + " 00:00"));
   if ( tmp_in_2 == 0 )
   {
     tmp_in_2 = 7;
   }
   tmp_in_3 = tmp_in_2 - 1;
   tmp_in_4 = TimeDayOfWeek(StringToTime(TimeToString(Global_45_da,1) + " 00:00"));
   if ( tmp_in_4 == 0 )
   {
     tmp_in_4 = 7;
   }
   tmp_in_1 = int(MathRound((StringToTime(TimeToString(Global_45_da,1) + " 00:00") + (7 - tmp_in_4 + 1) * 86400.0 - (StringToTime(TimeToString(Global_44_da,1) + " 00:00") - tmp_in_3 * 86400.0)) / 604800.0));
 }
 Local_1_in = tmp_in_1 ;
 if ( Local_1_in <= 0 )   return;
 ArrayResize(Global_46_st_ko,Local_1_in,0); 
 Local_2_st = "NewsEvents.txt" ;
 ResetLastError();
 if ( FileIsExist(Local_2_st,4096) )
 {
   PrintFormat("Reading events from %s",Local_2_st); 
   Local_3_in = 1000 ;
   for (Local_4_in = 0 ; Local_4_in < 5 ; Local_4_in ++)
   {
     Local_3_in = FileOpen(Local_2_st,4273) ;
     if ( Local_3_in != -1 )
     {
       Local_5_in = 0 ;
       while (!(FileIsEnding(Local_3_in)))
       {
         Local_6_st = FileReadString(Local_3_in,0) ;
         tmp_st_5 = StringTrimLeft(Local_6_st);
         Local_6_st = StringTrimLeft(Local_6_st) ;
         tmp_st_6 = StringTrimRight(Local_6_st);
         Local_6_st = StringTrimRight(Local_6_st) ;
         Local_5_in ++;
         if ( Local_5_in == 1 )
         {
         }
         else
         {
           Local_7_st = StringSubstr(Local_6_st,0,StringFind(Local_6_st,",",0) - 3) ;
           StringReplace(Local_7_st,"/","."); 
           StringReplace(Local_7_st,"-","."); 
           Local_8_da = StringToTime(Local_7_st) ;
           if ( ( Local_8_da == 0 || Local_8_da <  Global_44_da ) )
           {
           }
           else
           {
             if ( StringToTime(TimeToString(Global_44_da,1) + " 00:00") <  604800 )
             {
               tmp_in_7 = -1;
             }
             else
             {
               tmp_in_8 = TimeDayOfWeek(StringToTime(TimeToString(Global_44_da,1) + " 00:00"));
               if ( tmp_in_8 == 0 )
               {
                 tmp_in_8 = 7;
               }
               tmp_in_9 = tmp_in_8 - 1;
               tmp_in_10 = TimeDayOfWeek(StringToTime(TimeToString(Local_8_da,1) + " 00:00"));
               if ( tmp_in_10 == 0 )
               {
                 tmp_in_10 = 7;
               }
               tmp_in_7 = int(MathRound((StringToTime(TimeToString(Local_8_da,1) + " 00:00") + (7 - tmp_in_10 + 1) * 86400.0 - (StringToTime(TimeToString(Global_44_da,1) + " 00:00") - tmp_in_9 * 86400.0)) / 604800.0));
             }
             Local_9_in = tmp_in_7 ;
             if ( Local_9_in >  0 )
             {
               Global_46_st_ko[Local_9_in - 1] = Global_46_st_ko[Local_9_in - 1] + Local_6_st + ";";
             }
           }
         }
       }
       FileClose(Local_3_in); 
       break;
     }
     Print(TradeComment + " " + "->"," News data file open error",lizong_11(GetLastError())); 
   }
 }
 }
//lizong_33 <<==--------   --------
 void lizong_34()
 {
  bool      Local_1_bo = false;
  string    Local_2_st;
  string    Local_3_st;
  int       Local_4_in;
  int       Local_5_in;
  int       Local_6_in;
  int       Local_7_in;
  string    Local_8_st;
  string    Local_9_st;
  double    Local_10_do;
  int       Local_11_in;
  int       Local_12_in;
  long      Local_13_lo;
//----- -----
 string     tmp_st_1;
 string     tmp_st_2;
 string     tmp_st_3;
 string     tmp_st_4;

 Local_2_st = "" ;
 Local_3_st = "" ;
 Local_2_st = "https://www.worldtimeserver.com/time-zones/utc" ;
 Local_3_st = lizong_35("https://www.worldtimeserver.com/time-zones/utc",true) ;
 if ( Local_3_st != "-1" )
 {
   Local_4_in=StringFind(Local_3_st,"UTC/GMT is",0) + 51 + 3;
   Local_5_in = StringFind(Local_3_st,"<p>Coordinated Universal Time or UTC is a standard,",0) ;
   Local_6_in=StringFind(Local_3_st,"Server Time with seconds:",0) + 25;
   Local_7_in = 12 ;
   if ( Local_4_in >  0 && Local_5_in >  0 && Local_6_in >  0 )
   {
     Local_8_st = StringSubstr(Local_3_st,Local_4_in,Local_5_in - Local_4_in) ;
     StringReplace(Local_8_st,"</div>",""); 
     tmp_st_1 = StringTrimLeft(Local_8_st);
     Local_8_st = StringTrimLeft(Local_8_st) ;
     tmp_st_2 = StringTrimRight(Local_8_st);
     Local_8_st = StringTrimRight(Local_8_st) ;
     Local_9_st = StringSubstr(Local_3_st,Local_6_in,12) ;
     tmp_st_3 = StringTrimLeft(Local_9_st);
     Local_9_st = StringTrimLeft(Local_9_st) ;
     tmp_st_4 = StringTrimRight(Local_9_st);
     Local_9_st = StringTrimRight(Local_9_st) ;
     Local_10_do = lizong_36(Local_8_st,Local_9_st,0) ;
     if ( Local_10_do >  100 )
     {
       Global_37_lo = TimeCurrent() ;
       Global_38_st = "https://www.worldtimeserver.com" ;
       Global_35_in = MathRound((TimeCurrent() - Local_10_do) / 3600.0) ;
       Local_1_bo = true ;
     }
     else
     {
       Print(TradeComment + " " + "->"," Failed to update/calculate GMT offset: can\'t parse URL: ",Local_2_st); 
     }
   }
   else
   {
     Print(TradeComment + " " + "->"," Failed to update/calculate GMT offset: can\'t read URL: ",Local_2_st); 
   }
 }
 else
 {
   Print(TradeComment + " " + "->"," Failed to update/calculate GMT offset: can\'t open URL: ",Local_2_st); 
 }
 if ( ( Global_35_in != -999 && Local_1_bo ) )   return;
 Local_2_st = Global_69_st ;
 Local_3_st = lizong_35(Global_69_st,true) ;
 if ( Local_3_st != "-1" )
 {
   Local_11_in=StringFind(Local_3_st,"Begin_UTC_Time-",0) + 15;
   Local_12_in = StringFind(Local_3_st,"-End_UTC_Time",0) ;
   if ( Local_11_in >  0 && Local_12_in >  0 )
   {
     Local_13_lo = StringToTime(StringSubstr(Local_3_st,Local_11_in,Local_12_in - Local_11_in)) ;
     if ( Local_13_lo >  100 )
     {
       Global_37_lo = TimeCurrent() ;
       Global_38_st = Local_2_st ;
       Global_35_in = MathRound((TimeCurrent() - Local_13_lo) / 3600.0) ;
       Local_1_bo = true ;
       return;
     }
     Print(TradeComment + " " + "->"," Failed to update/calculate GMT offset: can\'t parse URL: ",Local_2_st); 
     return;
   }
   Print(TradeComment + " " + "->"," Failed to update/calculate GMT offset: can\'t read URL: ",Local_2_st); 
   return;
 }
 Print(TradeComment + " " + "->"," Failed to update/calculate GMT offset: can\'t open URL: ",Local_2_st); 
 }
//lizong_34 <<==--------   --------
 string lizong_35( string Para_0_st,bool Para_1_bo)
 {
  string    Local_1_st;
  string    Local_2_st;
  char      Local_3_ch_ko[];
  char      Local_4_ch_ko[];
  int       Local_5_in;
  string    Local_6_st;
  string    Local_7_st;
  int       Local_8_in;
  int       Local_9_in;
//----- -----
 string     tmp_st_1;

 Local_1_st = NULL ;
 Local_2_st = "" ;
 Local_5_in = 0 ;
 Local_6_st = "-1" ;
 ResetLastError();
 Local_7_st = "" ;
 if ( StringLen(Para_0_st)  >  20 )
 {
   Local_7_st = StringSubstr(Para_0_st,0,20) ;
 }
 Local_8_in = 5000 ;
 Local_5_in = WebRequest("GET",Para_0_st,Local_1_st,NULL,5000,Local_3_ch_ko,0,Local_4_ch_ko,Local_2_st) ;
 Local_9_in = GetLastError() ;
 Global_51_in = Local_9_in ;
 if ( Local_5_in == -1 )
 {
   if ( ( Global_51_in == 4060 || Global_51_in == 4014 ) )
   {
     if ( Para_1_bo )
     {
       Print(TradeComment + " " + "->"," Web request not allowed: ",Local_7_st,lizong_11(Local_9_in)); 
     }
   }
   else
   {
     if ( Para_1_bo )
     {
       Print(TradeComment + " " + "->"," Web request failed: ",Local_7_st,lizong_11(Local_9_in)); 
     }
   }
   tmp_st_1 = Local_6_st;
   return(tmp_st_1);
 }
 if ( ArraySize(Local_4_ch_ko) >  0 )
 {
   Local_6_st = CharArrayToString(Local_4_ch_ko,0,-1,0) ;
 }
 else
 {
   Print(TradeComment + " " + "->"," Web request failed: ",Local_7_st,lizong_11(Local_9_in)); 
 }
 tmp_st_1 = Local_6_st;
 return(tmp_st_1);
 }
//lizong_35 <<==--------   --------
 long lizong_36( string Para_0_st,string Para_1_st,int Para_2_in)
 {
  long      Local_1_lo;
  double    Local_2_do = 0.0;
  int       Local_3_in;
  int       Local_4_in;
  int       Local_5_in;
  int       Local_6_in;
  int       Local_7_in;
  int       Local_8_in;
  short     Local_9_sh;
  string    Local_10_st_ko[];
  int       Local_11_in;
  short     Local_12_sh;
  string    Local_13_st_ko[];
  int       Local_14_in;
  short     Local_15_sh;
  string    Local_16_st_ko[];
  int       Local_17_in;
  string    Local_18_st;
//----- -----
 string     tmp_st_1;
 string     tmp_st_2;
 string     tmp_st_3;
 string     tmp_st_4;
 string     tmp_st_5;
 string     tmp_st_6;
 string     tmp_st_7;
 string     tmp_st_8;
 string     tmp_st_9;
 int        tmp_in_10;
 string     tmp_st_11;
 string     tmp_st_12;
 string     tmp_st_13;
 string     tmp_st_14;
 string     tmp_st_15;
 string     tmp_st_16;
 string     tmp_st_17;
 string     tmp_st_18;

 Local_3_in = -1 ;
 Local_4_in = -1 ;
 Local_5_in = -1 ;
 Local_6_in = -1 ;
 Local_7_in = -1 ;
 Local_8_in = -1 ;
 Local_9_sh = StringGetCharacter(",",0) ;
 Local_11_in = StringSplit(Para_0_st,Local_9_sh,Local_10_st_ko) ;
 if ( ( Local_11_in == 4 || Local_11_in == 3 ) )
 {
   tmp_st_1 = StringTrimLeft(Local_10_st_ko[2]);
   tmp_st_2 = StringTrimRight(StringTrimLeft(Local_10_st_ko[2]));
   Local_5_in = StringToInteger(StringTrimRight(StringTrimLeft(Local_10_st_ko[2]))) ;
   Local_12_sh = StringGetCharacter(" ",0) ;
   tmp_st_3 = StringTrimLeft(Local_10_st_ko[1]);
   tmp_st_4 = StringTrimRight(StringTrimLeft(Local_10_st_ko[1]));
   Local_14_in = StringSplit(StringTrimRight(StringTrimLeft(Local_10_st_ko[1])),Local_12_sh,Local_13_st_ko) ;
   if ( Local_14_in == 2 )
   {
     tmp_st_5 = StringTrimLeft(Local_13_st_ko[1]);
     tmp_st_6 = StringTrimRight(StringTrimLeft(Local_13_st_ko[1]));
     Local_3_in = StringToInteger(StringTrimRight(StringTrimLeft(Local_13_st_ko[1]))) ;
     tmp_st_7 = StringTrimLeft(Local_13_st_ko[0]);
     tmp_st_8 = StringTrimRight(StringTrimLeft(Local_13_st_ko[0]));
     tmp_st_9 = StringTrimRight(StringTrimLeft(Local_13_st_ko[0]));
     tmp_in_10 = -1;
     if ( StringTrimRight(StringTrimLeft(Local_13_st_ko[0])) == "January" )
     {
       tmp_in_10 = 1;
     }
     if ( tmp_st_9 == "February" )
     {
       tmp_in_10 = 2;
     }
     if ( tmp_st_9 == "March" )
     {
       tmp_in_10 = 3;
     }
     if ( tmp_st_9 == "April" )
     {
       tmp_in_10 = 4;
     }
     if ( tmp_st_9 == "May" )
     {
       tmp_in_10 = 5;
     }
     if ( tmp_st_9 == "June" )
     {
       tmp_in_10 = 6;
     }
     if ( tmp_st_9 == "July" )
     {
       tmp_in_10 = 7;
     }
     if ( tmp_st_9 == "August" )
     {
       tmp_in_10 = 8;
     }
     if ( tmp_st_9 == "September" )
     {
       tmp_in_10 = 9;
     }
     if ( tmp_st_9 == "October" )
     {
       tmp_in_10 = 10;
     }
     if ( tmp_st_9 == "November" )
     {
       tmp_in_10 = 11;
     }
     if ( tmp_st_9 == "December" )
     {
       tmp_in_10 = 12;
     }
     Local_4_in = tmp_in_10 ;
     Local_15_sh = StringGetCharacter(":",0) ;
     tmp_st_11 = StringTrimLeft(Para_1_st);
     tmp_st_12 = StringTrimRight(StringTrimLeft(Para_1_st));
     Local_17_in = StringSplit(StringTrimRight(StringTrimLeft(Para_1_st)),Local_15_sh,Local_16_st_ko) ;
     if ( Local_17_in == 3 )
     {
       tmp_st_13 = StringTrimLeft(Local_16_st_ko[0]);
       tmp_st_14 = StringTrimRight(StringTrimLeft(Local_16_st_ko[0]));
       Local_6_in = StringToInteger(StringTrimRight(StringTrimLeft(Local_16_st_ko[0]))) ;
       tmp_st_15 = StringTrimLeft(Local_16_st_ko[1]);
       tmp_st_16 = StringTrimRight(StringTrimLeft(Local_16_st_ko[1]));
       Local_7_in = StringToInteger(StringTrimRight(StringTrimLeft(Local_16_st_ko[1]))) ;
       Local_18_st = Local_16_st_ko[2] ;
       if ( StringLen(Local_18_st)  >= 2 )
       {
         Local_18_st = StringSubstr(Local_18_st,0,2) ;
         tmp_st_17 = StringTrimLeft(Local_18_st);
         tmp_st_18 = StringTrimRight(StringTrimLeft(Local_18_st));
         Local_8_in = StringToInteger(StringTrimRight(StringTrimLeft(Local_18_st))) ;
       }
       else
       {
         Local_8_in = -1 ;
       }
       if ( Para_2_in >  0 )
       {
         Local_6_in = lizong_37(Local_6_in,Para_2_in) ;
       }
     }
   }
 }
 if ( Local_3_in >  0 && Local_4_in >  0 && Local_5_in >  2000 && Local_6_in >= 0 && Local_7_in >= 0 && Local_8_in >= 0 )
 {
   return(StringToTime(IntegerToString(Local_5_in,0,32) + "." + IntegerToString(Local_4_in,2,48) + "." + IntegerToString(Local_3_in,2,48) + " " + IntegerToString(Local_6_in,2,48) + ":" + IntegerToString(Local_7_in,2,48))); 
 }
 return(Local_2_do); 
 }
//lizong_36 <<==--------   --------
 int lizong_37( int Para_0_in,int Para_1_in)
 {
  int       Local_1_in;
//----- -----

 if ( Para_0_in == 12 && Para_1_in == 1 )
 {
   return(0); 
 }
 if ( Para_0_in == 1 && Para_1_in == 1 )
 {
   return(1); 
 }
 if ( Para_0_in == 2 && Para_1_in == 1 )
 {
   return(2); 
 }
 if ( Para_0_in == 3 && Para_1_in == 1 )
 {
   return(3); 
 }
 if ( Para_0_in == 4 && Para_1_in == 1 )
 {
   return(4); 
 }
 if ( Para_0_in == 5 && Para_1_in == 1 )
 {
   return(5); 
 }
 if ( Para_0_in == 6 && Para_1_in == 1 )
 {
   return(6); 
 }
 if ( Para_0_in == 7 && Para_1_in == 1 )
 {
   return(7); 
 }
 if ( Para_0_in == 8 && Para_1_in == 1 )
 {
   return(8); 
 }
 if ( Para_0_in == 9 && Para_1_in == 1 )
 {
   return(9); 
 }
 if ( Para_0_in == 10 && Para_1_in == 1 )
 {
   return(10); 
 }
 if ( Para_0_in == 11 && Para_1_in == 1 )
 {
   return(11); 
 }
 if ( Para_0_in == 12 && Para_1_in == 2 )
 {
   return(12); 
 }
 if ( Para_0_in == 1 && Para_1_in == 2 )
 {
   return(13); 
 }
 if ( Para_0_in == 2 && Para_1_in == 2 )
 {
   return(14); 
 }
 if ( Para_0_in == 3 && Para_1_in == 2 )
 {
   return(15); 
 }
 if ( Para_0_in == 4 && Para_1_in == 2 )
 {
   return(16); 
 }
 if ( Para_0_in == 5 && Para_1_in == 2 )
 {
   return(17); 
 }
 if ( Para_0_in == 6 && Para_1_in == 2 )
 {
   return(18); 
 }
 if ( Para_0_in == 7 && Para_1_in == 2 )
 {
   return(19); 
 }
 if ( Para_0_in == 8 && Para_1_in == 2 )
 {
   return(20); 
 }
 if ( Para_0_in == 9 && Para_1_in == 2 )
 {
   return(21); 
 }
 if ( Para_0_in == 10 && Para_1_in == 2 )
 {
   return(22); 
 }
 if ( Para_0_in == 11 && Para_1_in == 2 )
 {
   return(23); 
 }
 return(-1); 
 }
//lizong_37 <<==--------   --------
 int lizong_38( string Para_0_st,datetime Para_1_data)
 {
  int       Local_1_in;
  int       Local_2_in = 0;
  int       Local_3_in;
//----- -----

 Local_3_in=TimeDay(Para_1_data) + TimeMonth(Para_1_data) * 100;
 if ( Para_0_st == "US" )
 {
   if ( Local_3_in >= 310 && Local_3_in <  1103 && TimeYear(Para_1_data) <  2007 )
   {
     Local_2_in = 1 ;
   }
   if ( Local_3_in >= 311 && Local_3_in <  1104 && TimeYear(Para_1_data) == 2007 )
   {
     Local_2_in = 1 ;
   }
   if ( Local_3_in >= 309 && Local_3_in <  1102 && TimeYear(Para_1_data) == 2008 )
   {
     Local_2_in = 1 ;
   }
   if ( Local_3_in >= 308 && Local_3_in <  1101 && TimeYear(Para_1_data) == 2009 )
   {
     Local_2_in = 1 ;
   }
   if ( Local_3_in >= 314 && Local_3_in <  1107 && TimeYear(Para_1_data) == 2010 )
   {
     Local_2_in = 1 ;
   }
   if ( Local_3_in >= 313 && Local_3_in <  1106 && TimeYear(Para_1_data) == 2011 )
   {
     Local_2_in = 1 ;
   }
   if ( Local_3_in >= 311 && Local_3_in <  1104 && TimeYear(Para_1_data) == 2012 )
   {
     Local_2_in = 1 ;
   }
   if ( Local_3_in >= 310 && Local_3_in <  1103 && TimeYear(Para_1_data) == 2013 )
   {
     Local_2_in = 1 ;
   }
   if ( Local_3_in >= 309 && Local_3_in <  1102 && TimeYear(Para_1_data) == 2014 )
   {
     Local_2_in = 1 ;
   }
   if ( Local_3_in >= 308 && Local_3_in <  1101 && TimeYear(Para_1_data) == 2015 )
   {
     Local_2_in = 1 ;
   }
   if ( Local_3_in >= 313 && Local_3_in <  1106 && TimeYear(Para_1_data) == 2016 )
   {
     Local_2_in = 1 ;
   }
   if ( Local_3_in >= 312 && Local_3_in <  1105 && TimeYear(Para_1_data) == 2017 )
   {
     Local_2_in = 1 ;
   }
   if ( Local_3_in >= 311 && Local_3_in <  1104 && TimeYear(Para_1_data) == 2018 )
   {
     Local_2_in = 1 ;
   }
   if ( Local_3_in >= 310 && Local_3_in <  1103 && TimeYear(Para_1_data) == 2019 )
   {
     Local_2_in = 1 ;
   }
   if ( Local_3_in >= 308 && Local_3_in <  1101 && TimeYear(Para_1_data) == 2020 )
   {
     Local_2_in = 1 ;
   }
   if ( Local_3_in >= 314 && Local_3_in <  1107 && TimeYear(Para_1_data) == 2021 )
   {
     Local_2_in = 1 ;
   }
   if ( Local_3_in >= 313 && Local_3_in <  1106 && TimeYear(Para_1_data) == 2022 )
   {
     Local_2_in = 1 ;
   }
 }
 if ( Para_0_st == "Europe" )
 {
   if ( Local_3_in >= 331 && Local_3_in <  1030 && TimeYear(Para_1_data) <  2007 )
   {
     Local_2_in = 1 ;
   }
   if ( Local_3_in >= 325 && Local_3_in <  1028 && TimeYear(Para_1_data) == 2007 )
   {
     Local_2_in = 1 ;
   }
   if ( Local_3_in >= 330 && Local_3_in <  1026 && TimeYear(Para_1_data) == 2008 )
   {
     Local_2_in = 1 ;
   }
   if ( Local_3_in >= 329 && Local_3_in <  1025 && TimeYear(Para_1_data) == 2009 )
   {
     Local_2_in = 1 ;
   }
   if ( Local_3_in >= 328 && Local_3_in <  1031 && TimeYear(Para_1_data) == 2010 )
   {
     Local_2_in = 1 ;
   }
   if ( Local_3_in >= 327 && Local_3_in <  1030 && TimeYear(Para_1_data) == 2011 )
   {
     Local_2_in = 1 ;
   }
   if ( Local_3_in >= 325 && Local_3_in <  1028 && TimeYear(Para_1_data) == 2012 )
   {
     Local_2_in = 1 ;
   }
   if ( Local_3_in >= 331 && Local_3_in <  1027 && TimeYear(Para_1_data) == 2013 )
   {
     Local_2_in = 1 ;
   }
   if ( Local_3_in >= 330 && Local_3_in <  1026 && TimeYear(Para_1_data) == 2014 )
   {
     Local_2_in = 1 ;
   }
   if ( Local_3_in >= 329 && Local_3_in <  1025 && TimeYear(Para_1_data) == 2015 )
   {
     Local_2_in = 1 ;
   }
   if ( Local_3_in >= 327 && Local_3_in <  1030 && TimeYear(Para_1_data) == 2016 )
   {
     Local_2_in = 1 ;
   }
   if ( Local_3_in >= 326 && Local_3_in <  1029 && TimeYear(Para_1_data) == 2017 )
   {
     Local_2_in = 1 ;
   }
   if ( Local_3_in >= 325 && Local_3_in <  1028 && TimeYear(Para_1_data) == 2018 )
   {
     Local_2_in = 1 ;
   }
   if ( Local_3_in >= 331 && Local_3_in <  1027 && TimeYear(Para_1_data) == 2019 )
   {
     Local_2_in = 1 ;
   }
   if ( Local_3_in >= 329 && Local_3_in <  1025 && TimeYear(Para_1_data) == 2020 )
   {
     Local_2_in = 1 ;
   }
   if ( Local_3_in >= 328 && Local_3_in <  1031 && TimeYear(Para_1_data) == 2021 )
   {
     Local_2_in = 1 ;
   }
   if ( Local_3_in >= 327 && Local_3_in <  1030 && TimeYear(Para_1_data) == 2022 )
   {
     Local_2_in = 1 ;
   }
 }
 return(Local_2_in); 
 }
//lizong_38 <<==--------   --------
 string lizong_39( string Para_0_st)
 {
  string    Local_1_st;
//----- -----
 long       tmp_lo_1;
 long       tmp_lo_2;
 int        tmp_in_3;
 string     tmp_st_4;
 long       tmp_lo_5;
 int        tmp_in_6;
 string     tmp_st_7;
 long       tmp_lo_8;
 long       tmp_lo_9;
 double     tmp_do_10;
 int        tmp_in_11;

 tmp_lo_1 = 5382;
 tmp_lo_2 = 5382;
 tmp_in_3 = 0;
   if(StringLen(Para_0_st)  >  0){
 do
 {
   tmp_lo_1 = (tmp_lo_1 << 5) + tmp_lo_1 ^ StringGetCharacter(Para_0_st,tmp_in_3);
   if ( tmp_in_3 + 1 <  StringLen(Para_0_st)  )
   {
     tmp_lo_2 = (tmp_lo_2 << 5) + tmp_lo_2 ^ StringGetCharacter(Para_0_st,tmp_in_3 + 1);
   }
   tmp_in_3 = tmp_in_3 + 2;
 }
 while(tmp_in_3 < StringLen(Para_0_st) );
 }
 Local_1_st = IntegerToString(StringGetCharacter(Para_0_st,tmp_in_3 + 1),0,32) ;
 tmp_st_4 = IntegerToString(StringGetCharacter(Para_0_st,tmp_in_3 + 1),0,32);
 tmp_lo_5 = D'2011.09.07 19:31:51';
 for (tmp_in_6 = 0 ; tmp_in_6 < StringLen(tmp_st_4)  ; tmp_in_6=tmp_in_6 + 1)
 {
   tmp_lo_5=tmp_lo_5 ^ (tmp_lo_5 << 5) + StringGetCharacter(tmp_st_4,tmp_in_6) + (tmp_lo_5 >> 2);
 }
 Local_1_st = IntegerToString(tmp_lo_5,0,32) ;
 tmp_st_7 = IntegerToString(tmp_lo_5,0,32);
 tmp_lo_8 = 378551;
 tmp_lo_9 = 63689;
 tmp_do_10 = 0.0;
 for (tmp_in_11 = 0 ; tmp_in_11 < StringLen(tmp_st_7)  ; tmp_in_11=tmp_in_11 + 1)
 {
   tmp_do_10 = tmp_do_10 * tmp_lo_9 + StringGetCharacter(tmp_st_7,tmp_in_11);
   tmp_lo_9 = tmp_lo_9 * tmp_lo_8;
 }
 return(IntegerToString(tmp_do_10,0,32)); 
 }
//lizong_39 <<==--------   --------
 void lizong_40( string Para_0_st,int Para_1_in)
 {
  string    Local_1_st;
  int       Local_2_in;
  int       Local_3_in;
  int       Local_4_in;
  int       Local_5_in;
  int       Local_6_in;
  int       Local_7_in;
  bool      Local_8_bo;
  bool      Local_9_bo;
  bool      Local_10_bo;
  int       Local_11_in;
  int       Local_12_in;
//----- -----
 char       tmp_ch_1;
 int        tmp_in_2;
 int        tmp_in_3;

 Local_1_st = "R_Label" ;
 Local_2_in = 2960685 ;
 Local_3_in = 1 ;
 Local_4_in = 0 ;
 Local_5_in = 8388608 ;
 Local_6_in = 0 ;
 Local_7_in = 2 ;
 Local_8_bo = false ;
 Local_9_bo = false ;
 Local_10_bo = true ;
 Local_12_in = 0 ;
 Local_11_in = 0 ;
 ResetLastError();
 if ( ObjectFind(0,Local_1_st) == -1 )
 {
   //if ( !(Global_12_a_167.CreateBitmap(0,0,"R_Label",5,17,100,100,2)) )
   if ( !(Global_12_a_167.CreateBitmapLabel(0,0,"R_Label",5,17,100,100,2)) )
   {
     Print("Error creating canvas: ",GetLastError()); 
   }
   else
   {
     Global_12_a_167.CCanvasX_12(Para_0_st); 
     Global_12_a_167.TransparentLevelSet(Para_1_in);
     Global_12_a_167.Update(0);
   }
 }
 ChartRedraw(0); 
 Sleep(500); 
 }
//lizong_40 <<==--------   --------
 void lizong_41( int Para_0_in)
 {
 if ( IsTesting() || IsOptimization() )   return;
 Global_12_a_167.Destroy();
 }
//lizong_41 <<==--------   --------
 void lizong_42( string Para_0_st,int Para_1_in)
 {
  string    Local_1_st;
  int       Local_2_in;
  int       Local_3_in;
  int       Local_4_in;
  int       Local_5_in;
  int       Local_6_in;
  int       Local_7_in;
  bool      Local_8_bo;
  bool      Local_9_bo;
  bool      Local_10_bo;
  int       Local_11_in;
  int       Local_12_in;
//----- -----
 char       tmp_ch_1;
 int        tmp_in_2;
 int        tmp_in_3;

 Local_1_st = "B_Label" ;
 Local_2_in = 2960685 ;
 Local_3_in = 1 ;
 Local_4_in = 0 ;
 Local_5_in = 8388608 ;
 Local_6_in = 0 ;
 Local_7_in = 2 ;
 Local_8_bo = false ;
 Local_9_bo = false ;
 Local_10_bo = true ;
 Local_12_in = 0 ;
 Local_11_in = 0 ;
 ResetLastError();
 if ( ObjectFind(0,Local_1_st) == -1 )
 {
   if ( !(Global_13_a_167.CreateBitmapLabel(0,0,"B_Label",190,17,100,100,2)) )
   {
     Print("Error creating canvas: ",GetLastError()); 
   }
   else
   {
     Global_13_a_167.CCanvasX_12(Para_0_st); 
     Global_13_a_167.TransparentLevelSet(Para_1_in);
     Global_13_a_167.Update(0); 
   }
 }
 ChartRedraw(0); 
 Sleep(500); 
 }
//lizong_42 <<==--------   --------
 void lizong_43( string Para_0_st,int Para_1_in)
 {
  string    Local_1_st;
  int       Local_2_in;
  int       Local_3_in;
  int       Local_4_in;
  int       Local_5_in;
  int       Local_6_in;
  int       Local_7_in;
  bool      Local_8_bo;
  bool      Local_9_bo;
  bool      Local_10_bo;
  int       Local_11_in;
  int       Local_12_in;
//----- -----
 char       tmp_ch_1;
 int        tmp_in_2;
 int        tmp_in_3;

 Local_1_st = "S_Label" ;
 Local_2_in = 2960685 ;
 Local_3_in = 1 ;
 Local_4_in = 0 ;
 Local_5_in = 8388608 ;
 Local_6_in = 0 ;
 Local_7_in = 2 ;
 Local_8_bo = false ;
 Local_9_bo = false ;
 Local_10_bo = true ;
 Local_12_in = 0 ;
 Local_11_in = 0 ;
 ResetLastError();
 if ( ObjectFind(0,Local_1_st) == -1 )
 {
   if ( !(Global_14_a_167.CreateBitmapLabel(0,0,"S_Label",5,340,100,100,2)) )
   {
     Print("Error creating canvas: ",GetLastError()); 
   }
   else
   {
     Global_14_a_167.CCanvasX_12(Para_0_st); 
     Global_14_a_167.TransparentLevelSet(Para_1_in);
     Global_14_a_167.Update(0); 
   }
 }
 ChartRedraw(0); 
 Sleep(500); 
 }
//lizong_43 <<==--------   --------
 void lizong_44()
 {
  double    Local_1_do_ko[];
  double    Local_2_do;
  double    Local_3_do;
  int       Local_4_in;
  int       Local_5_in;
  double    Local_6_do;
  double    Local_7_do;
  int       Local_8_in;
//----- -----

 if ( !(BlockTradingForTheEntireDay) )
 {
   Global_63_do = 0.0 ;
 }
 ArrayResize(Local_1_do_ko,StockMarketFilterPeriod,0); 
 ArrayFill(Local_1_do_ko,0,StockMarketFilterPeriod,0.0);
 Local_2_do = 0.0 ;
 Local_3_do = 0.0 ;
 Local_4_in = 0 ;
 for (Local_5_in = 0 ; Local_5_in < StockMarketFilterPeriod ; Local_5_in ++)
 {
   if ( iClose(StockMarketSymbol,60,Local_5_in + 2)>Global_29_do )
   {
     Local_1_do_ko[Local_5_in] = MathLog(iClose(StockMarketSymbol,60,Local_5_in + 1) / iClose(StockMarketSymbol,60,Local_5_in + 2));
   }
   Local_3_do = Local_3_do + Local_1_do_ko[Local_5_in] ;
   Local_4_in ++;
 }
 if ( Local_4_in != 0 )
 {
   Local_2_do = Local_3_do / Local_4_in ;
 }
 else
 {
   Local_2_do = 0.0 ;
 }
 Local_6_do = 0.0 ;
 Local_4_in = 0 ;
 Local_7_do = 0.0 ;
 for (Local_8_in = 0 ; Local_8_in < StockMarketFilterPeriod ; Local_8_in ++)
 {
   Local_7_do = Local_7_do + MathPow(Local_1_do_ko[Local_8_in] - Local_2_do,2.0) ;
   Local_4_in ++;
 }
 if ( Local_4_in >  30 )
 {
   if ( Local_4_in - 1 != 0 )
   {
     Local_7_do = Local_7_do / (Local_4_in - 1) ;
   }
   else
   {
     Local_7_do = 0.0 ;
   }
 }
 else
 {
   if ( Local_4_in != 0 )
   {
     Local_7_do = Local_7_do / Local_4_in ;
   }
   else
   {
     Local_7_do = 0.0 ;
   }
 }
 Local_6_do=MathSqrt(Local_7_do);
 Local_6_do = Local_6_do / 0.01285861249684 ;
 Local_6_do = Local_6_do * 100.0 ;
 if ( !(BlockTradingForTheEntireDay) )
 {
   Global_63_do = Local_6_do ;
 }
 else
 {
   if ( Local_6_do>Global_63_do )
   {
     Global_63_do = Local_6_do ;
   }
 }
 }
//lizong_44 <<==--------   --------
 void lizong_45()
 {
  double    Local_1_do;
  int       Local_2_in;
  double    Local_3_do;
  double    Local_4_do;
//----- -----
 int        tmp_in_1;
 int        tmp_in_2;
 int        tmp_in_3;
 int        tmp_in_4;
 int        tmp_in_5;
 int        tmp_in_6;
 int        tmp_in_7;
 int        tmp_in_8;
 int        tmp_in_9;
 int        tmp_in_10;
 int        tmp_in_11;
 string     tmp_st_12;
 double     tmp_do_13;
 int        tmp_in_14;
 int        tmp_in_15;
 int        tmp_in_16;
 int        tmp_in_17;
 string     tmp_st_18;
 int        tmp_in_19;
 int        tmp_in_20;
 int        tmp_in_21;
 int        tmp_in_22;
 int        tmp_in_23;
 int        tmp_in_24;
 string     tmp_st_25;
 double     tmp_do_26;
 int        tmp_in_27;
 int        tmp_in_28;
 int        tmp_in_29;
 int        tmp_in_30;
 string     tmp_st_31;
 int        tmp_in_32;
 int        tmp_in_33;
 int        tmp_in_34;
 int        tmp_in_35;
 int        tmp_in_36;
 int        tmp_in_37;

 if ( MaximumOpenLots>Global_29_do )
 {
   Local_1_do = 0.0 ;
   for (Local_2_in = 0 ; Local_2_in < ArraySize(Global_26_a_168_ko) ; Local_2_in ++)
   {
     Local_1_do = Local_1_do + lizong_22(Global_26_a_168_ko[Local_2_in].st_1,-1,0,false) ;
   }
   if ( Local_1_do>MaximumOpenLots )
   {
     for (tmp_in_1 = 0 ; tmp_in_1 < ArraySize(Global_26_a_168_ko) ; tmp_in_1=tmp_in_1 + 1)
     {
       Global_26_a_168_ko[tmp_in_1].bo_4 = false;
       Global_26_a_168_ko[tmp_in_1].bo_5 = false;
     }
     if ( TimeCurrent() - Global_78_lo >  3600 )
     {
       Print(TradeComment + " " + "->",": Total lots opened by the EA exceeds the specified value! Lots opened: ",DoubleToString(Local_1_do,2)); 
       Global_78_lo = TimeCurrent() ;
     }
   }
 }
 if ( MaxDailyDrawdownLimitMoneyFTMO>Global_29_do && Global_64_do>Global_29_do && Global_64_do - AccountInfoDouble(ACCOUNT_EQUITY)>=MaxDailyDrawdownLimitMoneyFTMO )
 {
   if ( TimeCurrent() - Global_76_lo >  3600 )
   {
     Print(TradeComment + " " + "->",": Max Daily Drawdown Limit FTMO in money -> Equity at Reset Time: ",DoubleToString(Global_64_do,2)," / Current Equity: ",DoubleToString(AccountInfoDouble(ACCOUNT_EQUITY),2)); 
     Global_76_lo = TimeCurrent() ;
   }
   if ( MaximumDrawdownAction == 0 )
   {
     Global_70_bo = true ;
     Global_71_in = 24 ;
     for (tmp_in_2 = 0 ; tmp_in_2 < ArraySize(Global_26_a_168_ko) ; tmp_in_2=tmp_in_2 + 1)
     {
       Global_26_a_168_ko[tmp_in_2].bo_4 = false;
       Global_26_a_168_ko[tmp_in_2].bo_5 = false;
     }
   }
   if ( MaximumDrawdownAction == 4 )
   {
     Global_70_bo = true ;
     Global_66_bo = true ;
     for (tmp_in_3 = 0 ; tmp_in_3 < ArraySize(Global_26_a_168_ko) ; tmp_in_3=tmp_in_3 + 1)
     {
       Global_26_a_168_ko[tmp_in_3].bo_4 = false;
       Global_26_a_168_ko[tmp_in_3].bo_5 = false;
     }
   }
   if ( MaximumDrawdownAction == 1 )
   {
     Global_70_bo = true ;
     Global_72_bo = true ;
     for (tmp_in_4 = 0 ; tmp_in_4 < ArraySize(Global_26_a_168_ko) ; tmp_in_4=tmp_in_4 + 1)
     {
       Global_26_a_168_ko[tmp_in_4].bo_4 = false;
       Global_26_a_168_ko[tmp_in_4].bo_5 = false;
     }
   }
   if ( MaximumDrawdownAction == 2 )
   {
     for (tmp_in_5 = 0 ; tmp_in_5 < ArraySize(Global_26_a_168_ko) ; tmp_in_5=tmp_in_5 + 1)
     {
       Global_26_a_168_ko[tmp_in_5].bo_4 = false;
       Global_26_a_168_ko[tmp_in_5].bo_5 = false;
     }
   }
   if ( MaximumDrawdownAction == 3 )
   {
     Global_72_bo = true ;
     for (tmp_in_6 = 0 ; tmp_in_6 < ArraySize(Global_26_a_168_ko) ; tmp_in_6=tmp_in_6 + 1)
     {
       Global_26_a_168_ko[tmp_in_6].bo_4 = false;
       Global_26_a_168_ko[tmp_in_6].bo_5 = false;
     }
   }
 }
 if ( MaxDailyDrawdownLimitPercentFTMO>Global_29_do && MaxDailyDrawdownLimitPercentFTMO<99.99 && Global_64_do>Global_29_do )
 {
   AccountInfoDouble(ACCOUNT_EQUITY); 
   if ( (1.0 - AccountInfoDouble(ACCOUNT_EQUITY) / Global_64_do) * 100.0>=MaxDailyDrawdownLimitPercentFTMO )
   {
     if ( TimeCurrent() - Global_76_lo >  3600 )
     {
       Print(TradeComment + " " + "->",": Max Daily Drawdown Limit FTMO % -> Equity at Reset Time: ",DoubleToString(Global_64_do,2)," / Current Equity: ",DoubleToString(AccountInfoDouble(ACCOUNT_EQUITY),2)); 
       Global_76_lo = TimeCurrent() ;
     }
     if ( MaximumDrawdownAction == 0 )
     {
       Global_70_bo = true ;
       Global_71_in = 24 ;
       for (tmp_in_7 = 0 ; tmp_in_7 < ArraySize(Global_26_a_168_ko) ; tmp_in_7=tmp_in_7 + 1)
       {
         Global_26_a_168_ko[tmp_in_7].bo_4 = false;
         Global_26_a_168_ko[tmp_in_7].bo_5 = false;
       }
     }
     if ( MaximumDrawdownAction == 4 )
     {
       Global_70_bo = true ;
       Global_66_bo = true ;
       for (tmp_in_8 = 0 ; tmp_in_8 < ArraySize(Global_26_a_168_ko) ; tmp_in_8=tmp_in_8 + 1)
       {
         Global_26_a_168_ko[tmp_in_8].bo_4 = false;
         Global_26_a_168_ko[tmp_in_8].bo_5 = false;
       }
     }
     if ( MaximumDrawdownAction == 1 )
     {
       Global_70_bo = true ;
       Global_72_bo = true ;
       for (tmp_in_9 = 0 ; tmp_in_9 < ArraySize(Global_26_a_168_ko) ; tmp_in_9=tmp_in_9 + 1)
       {
         Global_26_a_168_ko[tmp_in_9].bo_4 = false;
         Global_26_a_168_ko[tmp_in_9].bo_5 = false;
       }
     }
     if ( MaximumDrawdownAction == 2 )
     {
       for (tmp_in_10 = 0 ; tmp_in_10 < ArraySize(Global_26_a_168_ko) ; tmp_in_10=tmp_in_10 + 1)
       {
         Global_26_a_168_ko[tmp_in_10].bo_4 = false;
         Global_26_a_168_ko[tmp_in_10].bo_5 = false;
       }
     }
     if ( MaximumDrawdownAction == 3 )
     {
       Global_72_bo = true ;
       for (tmp_in_11 = 0 ; tmp_in_11 < ArraySize(Global_26_a_168_ko) ; tmp_in_11=tmp_in_11 + 1)
       {
         Global_26_a_168_ko[tmp_in_11].bo_4 = false;
         Global_26_a_168_ko[tmp_in_11].bo_5 = false;
       }
     }
   }
 }
 if ( MaximumDrawdown>Global_29_do && MaximumDrawdown<99.99 )
 {
   Local_3_do = 0.0 ;
   if ( DrawdownCalculation == 1 )
   {
     tmp_st_12 = "";
     tmp_do_13 = 0.0;
     tmp_in_14 = Global_28_in + UID + int(MathPow(10.0,StringLen(IntegerToString(Global_28_in + UID,0,32)) ));
     tmp_in_15 = Global_28_in + UID + int(MathPow(10.0,StringLen(IntegerToString(Global_28_in + UID,0,32)) )) * 2;
     for (tmp_in_16 = 0 ; tmp_in_16 < OrdersTotal() ; tmp_in_16=tmp_in_16 + 1)
     {
       if ( OrderSelect(tmp_in_16,0,0) )
       {
         tmp_in_17 = OrderType();
         tmp_st_18 = OrderSymbol();
         tmp_in_19 = OrderMagicNumber() / 100;
         if ( ( ( tmp_in_17 != 0 || tmp_in_14 != tmp_in_19 ) && (tmp_in_17 != 1 || tmp_in_15 != tmp_in_19) ) )   continue;
         
         if ( ( tmp_st_12 != "" && tmp_st_12 != tmp_st_18 ) )   continue;
         tmp_do_13 = OrderProfit() + OrderSwap() + OrderCommission() + tmp_do_13;
          continue;
       }
       Print(TradeComment + " " + "------",": Failed to select an order! Error=",lizong_11(GetLastError())); 
       
     }
     Local_3_do = -(tmp_do_13);
   }
   if ( DrawdownCalculation == 0 )
   {
     Local_3_do = AccountInfoDouble(ACCOUNT_BALANCE) - AccountInfoDouble(ACCOUNT_EQUITY) ;
   }
   if ( Local_3_do>MaximumDrawdown / 100.0 * AccountInfoDouble(ACCOUNT_BALANCE) )
   {
     if ( TimeCurrent() - Global_76_lo >  3600 )
     {
       Print(TradeComment + " " + "->",": Maximum Drawdown -> Current Loss: ",DoubleToString(Local_3_do,2)," / Current Balance: ",DoubleToString(AccountInfoDouble(ACCOUNT_BALANCE),2)); 
       Global_76_lo = TimeCurrent() ;
     }
     if ( MaximumDrawdownAction == 0 )
     {
       Global_70_bo = true ;
       Global_71_in = 24 ;
       for (tmp_in_20 = 0 ; tmp_in_20 < ArraySize(Global_26_a_168_ko) ; tmp_in_20=tmp_in_20 + 1)
       {
         Global_26_a_168_ko[tmp_in_20].bo_4 = false;
         Global_26_a_168_ko[tmp_in_20].bo_5 = false;
       }
     }
     if ( MaximumDrawdownAction == 4 )
     {
       Global_70_bo = true ;
       Global_66_bo = true ;
       for (tmp_in_21 = 0 ; tmp_in_21 < ArraySize(Global_26_a_168_ko) ; tmp_in_21=tmp_in_21 + 1)
       {
         Global_26_a_168_ko[tmp_in_21].bo_4 = false;
         Global_26_a_168_ko[tmp_in_21].bo_5 = false;
       }
     }
     if ( MaximumDrawdownAction == 1 )
     {
       Global_70_bo = true ;
       Global_72_bo = true ;
       for (tmp_in_22 = 0 ; tmp_in_22 < ArraySize(Global_26_a_168_ko) ; tmp_in_22=tmp_in_22 + 1)
       {
         Global_26_a_168_ko[tmp_in_22].bo_4 = false;
         Global_26_a_168_ko[tmp_in_22].bo_5 = false;
       }
     }
     if ( MaximumDrawdownAction == 2 )
     {
       for (tmp_in_23 = 0 ; tmp_in_23 < ArraySize(Global_26_a_168_ko) ; tmp_in_23=tmp_in_23 + 1)
       {
         Global_26_a_168_ko[tmp_in_23].bo_4 = false;
         Global_26_a_168_ko[tmp_in_23].bo_5 = false;
       }
     }
     if ( MaximumDrawdownAction == 3 )
     {
       Global_72_bo = true ;
       for (tmp_in_24 = 0 ; tmp_in_24 < ArraySize(Global_26_a_168_ko) ; tmp_in_24=tmp_in_24 + 1)
       {
         Global_26_a_168_ko[tmp_in_24].bo_4 = false;
         Global_26_a_168_ko[tmp_in_24].bo_5 = false;
       }
     }
   }
 }
 if ( !(MaximumDrawdownMoney>Global_29_do) )   return;
 Local_4_do = 0.0 ;
 if ( DrawdownCalculation == 1 )
 {
   tmp_st_25 = "";
   tmp_do_26 = 0.0;
   tmp_in_27 = Global_28_in + UID + int(MathPow(10.0,StringLen(IntegerToString(Global_28_in + UID,0,32)) ));
   tmp_in_28 = Global_28_in + UID + int(MathPow(10.0,StringLen(IntegerToString(Global_28_in + UID,0,32)) )) * 2;
   for (tmp_in_29 = 0 ; tmp_in_29 < OrdersTotal() ; tmp_in_29=tmp_in_29 + 1)
   {
     if ( OrderSelect(tmp_in_29,0,0) )
     {
       tmp_in_30 = OrderType();
       tmp_st_31 = OrderSymbol();
       tmp_in_32 = OrderMagicNumber() / 100;
       if ( ( ( tmp_in_30 != 0 || tmp_in_27 != tmp_in_32 ) && (tmp_in_30 != 1 || tmp_in_28 != tmp_in_32) ) )   continue;
       
       if ( ( tmp_st_25 != "" && tmp_st_25 != tmp_st_31 ) )   continue;
       tmp_do_26 = OrderProfit() + OrderSwap() + OrderCommission() + tmp_do_26;
        continue;
     }
     Print(TradeComment + " " + "------",": Failed to select an order! Error=",lizong_11(GetLastError())); 
     
   }
   Local_4_do = -(tmp_do_26);
 }
 if ( DrawdownCalculation == 0 )
 {
   Local_4_do = AccountInfoDouble(ACCOUNT_BALANCE) - AccountInfoDouble(ACCOUNT_EQUITY) ;
 }
 if ( !(Local_4_do>MaximumDrawdownMoney) )   return;
 
 if ( TimeCurrent() - Global_76_lo >  3600 )
 {
   Print(TradeComment + " " + "->",": Maximum Drawdown in money -> Current Loss: ",DoubleToString(Local_4_do,2)," / Current Balance: ",DoubleToString(AccountInfoDouble(ACCOUNT_BALANCE),2)); 
   Global_76_lo = TimeCurrent() ;
 }
 if ( MaximumDrawdownAction == 0 )
 {
   Global_70_bo = true ;
   Global_71_in = 24 ;
   for (tmp_in_33 = 0 ; tmp_in_33 < ArraySize(Global_26_a_168_ko) ; tmp_in_33=tmp_in_33 + 1)
   {
     Global_26_a_168_ko[tmp_in_33].bo_4 = false;
     Global_26_a_168_ko[tmp_in_33].bo_5 = false;
   }
 }
 if ( MaximumDrawdownAction == 4 )
 {
   Global_70_bo = true ;
   Global_66_bo = true ;
   for (tmp_in_34 = 0 ; tmp_in_34 < ArraySize(Global_26_a_168_ko) ; tmp_in_34=tmp_in_34 + 1)
   {
     Global_26_a_168_ko[tmp_in_34].bo_4 = false;
     Global_26_a_168_ko[tmp_in_34].bo_5 = false;
   }
 }
 if ( MaximumDrawdownAction == 1 )
 {
   Global_70_bo = true ;
   Global_72_bo = true ;
   for (tmp_in_35 = 0 ; tmp_in_35 < ArraySize(Global_26_a_168_ko) ; tmp_in_35=tmp_in_35 + 1)
   {
     Global_26_a_168_ko[tmp_in_35].bo_4 = false;
     Global_26_a_168_ko[tmp_in_35].bo_5 = false;
   }
 }
 if ( MaximumDrawdownAction == 2 )
 {
   for (tmp_in_36 = 0 ; tmp_in_36 < ArraySize(Global_26_a_168_ko) ; tmp_in_36=tmp_in_36 + 1)
   {
     Global_26_a_168_ko[tmp_in_36].bo_4 = false;
     Global_26_a_168_ko[tmp_in_36].bo_5 = false;
   }
 }
 if ( MaximumDrawdownAction != 3 )   return;
 Global_72_bo = true ;
 for (tmp_in_37 = 0 ; tmp_in_37 < ArraySize(Global_26_a_168_ko) ; tmp_in_37=tmp_in_37 + 1)
 {
   Global_26_a_168_ko[tmp_in_37].bo_4 = false;
   Global_26_a_168_ko[tmp_in_37].bo_5 = false;
 }
 }
//lizong_45 <<==--------   --------
 bool lizong_46( string Para_0_st,int Para_1_in,int Para_2_in,double Para_3_do,double Para_4_do,double Para_5_do,double Para_6_do,double Para_7_do,double Para_8_do)
 {
  bool      Local_1_bo;
  int       Local_2_in;
  int       Local_3_in;
  int       Local_4_in;
  double    Local_5_do;
  double    Local_6_do;
  double    Local_7_do;
  double    Local_8_do;
  double    Local_9_do;
  double    Local_10_do;
  double    Local_11_do;
  int       Local_12_in;
  double    Local_13_do;
  double    Local_14_do;
//----- -----

 if ( Global_7_in == 0 )
 {
   return(false); 
 }
 if ( Global_32_in == 0 && TimeMinute(TimeCurrent()) <= 1 && !(IsTesting()) )
 {
   return(false); 
 }
 if ( Global_32_in == 0 && TimeMinute(TimeCurrent()) <= 5 && TimeDayOfWeek(Global_32_in) == 1 && !(IsTesting()) )
 {
   return(false); 
 }
 Local_2_in = 0 ;
 Local_3_in = -1 ;
 Local_4_in = 0 ;
 Local_5_do = 0.0 ;
 Local_6_do = 0.0 ;
 Local_7_do = 0.0 ;
 Local_8_do = 0.0 ;
 Local_9_do = 0.0 ;
 Local_10_do = 0.0 ;
 Local_11_do = MarketInfo(Para_0_st,11) ;
 Local_12_in = MarketInfo(Para_0_st,12) ;
 Local_13_do = NormalizeDouble(MarketInfo(Para_0_st,14) * Local_11_do,Local_12_in) ;
 Local_14_do = NormalizeDouble(MarketInfo(Para_0_st,33) * Local_11_do,Local_12_in) ;
 Local_2_in = Para_1_in ;
 Local_3_in = Para_2_in ;
 Local_4_in=Para_1_in * 10 + Para_2_in;
 if ( Para_1_in == 1 )
 {
   Local_5_do = NormalizeDouble(Para_3_do,Local_12_in) ;
   Local_6_do = NormalizeDouble(Para_5_do,Local_12_in) ;
   Local_7_do = NormalizeDouble(Para_4_do,Local_12_in) ;
 }
 if ( Local_2_in == 2 )
 {
   Local_8_do = NormalizeDouble(Para_6_do,Local_12_in) ;
   Local_9_do = NormalizeDouble(Para_8_do,Local_12_in) ;
   Local_10_do = NormalizeDouble(Para_7_do,Local_12_in) ;
 }
 if ( Local_2_in == 3 )
 {
   Local_5_do = NormalizeDouble(Para_3_do,Local_12_in) ;
   Local_6_do = NormalizeDouble(Para_5_do,Local_12_in) ;
   Local_7_do = NormalizeDouble(Para_4_do,Local_12_in) ;
   Local_8_do = NormalizeDouble(Para_6_do,Local_12_in) ;
   Local_9_do = NormalizeDouble(Para_8_do,Local_12_in) ;
   Local_10_do = NormalizeDouble(Para_7_do,Local_12_in) ;
 }
 RefreshRates(); 
 switch(Local_4_in)
 {
   case 10 :
   if ( ( !(NormalizeDouble(MarketInfo(Para_0_st,9) - Local_7_do,Local_12_in)>Local_14_do) && !(Local_7_do<Local_11_do) ) || ( !(NormalizeDouble(Local_6_do - MarketInfo(Para_0_st,9),Local_12_in)>Local_14_do) && !(Local_6_do<Local_11_do) ) || Local_2_in != 1 )   break;
   return(true); 
   case 11 :
   if ( ( !(NormalizeDouble(Local_7_do - MarketInfo(Para_0_st,10),Local_12_in)>Local_14_do) && !(Local_7_do<Local_11_do) ) || ( !(NormalizeDouble(MarketInfo(Para_0_st,10) - Local_6_do,Local_12_in)>Local_14_do) && !(Local_6_do<Local_11_do) ) || Local_2_in != 1 )   break;
   return(true); 
   case 12 :
   if ( !(NormalizeDouble(MarketInfo(Para_0_st,10) - Local_5_do,Local_12_in)>Local_14_do) || ( !(Local_13_do<NormalizeDouble(Local_5_do - Local_7_do,Local_12_in)) && !(Local_7_do<Local_11_do) ) || ( !(Local_13_do<NormalizeDouble(Local_6_do - Local_5_do,Local_12_in)) && !(Local_6_do<Local_11_do) ) || Local_2_in != 1 )   break;
   return(true); 
   case 13 :
   if ( !(NormalizeDouble(Local_5_do - MarketInfo(Para_0_st,9),Local_12_in)>Local_14_do) || ( !(Local_13_do<NormalizeDouble(Local_7_do - Local_5_do,Local_12_in)) && !(Local_7_do<Local_11_do) ) || ( !(Local_13_do<NormalizeDouble(Local_5_do - Local_6_do,Local_12_in)) && !(Local_6_do<Local_11_do) ) || Local_2_in != 1 )   break;
   return(true); 
   case 14 :
   if ( !(NormalizeDouble(Local_5_do - MarketInfo(Para_0_st,10),Local_12_in)>Local_14_do) || ( !(Local_13_do<NormalizeDouble(Local_5_do - Local_7_do,Local_12_in)) && !(Local_7_do<Local_11_do) ) || ( !(Local_13_do<NormalizeDouble(Local_6_do - Local_5_do,Local_12_in)) && !(Local_6_do<Local_11_do) ) || Local_2_in != 1 )   break;
   return(true); 
   case 15 :
   if ( !(NormalizeDouble(MarketInfo(Para_0_st,9) - Local_5_do,Local_12_in)>Local_14_do) || ( !(Local_13_do<NormalizeDouble(Local_7_do - Local_5_do,Local_12_in)) && !(Local_7_do<Local_11_do) ) || ( !(Local_13_do<NormalizeDouble(Local_5_do - Local_6_do,Local_12_in)) && !(Local_6_do<Local_11_do) ) || Local_2_in != 1 )   break;
   return(true); 
   case 20 :
   if ( ( !(Local_13_do<NormalizeDouble(MarketInfo(Para_0_st,9) - Local_10_do,Local_12_in)) && !(Local_10_do<Local_11_do) ) || ( !(Local_13_do<NormalizeDouble(Local_9_do - MarketInfo(Para_0_st,9),Local_12_in)) && !(Local_9_do<Local_11_do) ) )   break;
   return(true); 
   case 21 :
   if ( ( !(Local_13_do<NormalizeDouble(Local_10_do - MarketInfo(Para_0_st,10),Local_12_in)) && !(Local_10_do<Local_11_do) ) || ( !(Local_13_do<NormalizeDouble(MarketInfo(Para_0_st,10) - Local_9_do,Local_12_in)) && !(Local_9_do<Local_11_do) ) )   break;
   return(true); 
   case 22 :
   if ( !(Local_13_do<NormalizeDouble(MarketInfo(Para_0_st,10) - Local_8_do,Local_12_in)) || ( !(Local_13_do<NormalizeDouble(Local_8_do - Local_10_do,Local_12_in)) && !(Local_10_do<Local_11_do) ) || ( !(Local_13_do<NormalizeDouble(Local_9_do - Local_8_do,Local_12_in)) && !(Local_9_do<Local_11_do) ) || Local_2_in != 2 )   break;
   return(true); 
   case 23 :
   if ( !(Local_13_do<NormalizeDouble(Local_8_do - MarketInfo(Para_0_st,9),Local_12_in)) || ( !(Local_13_do<NormalizeDouble(Local_10_do - Local_8_do,Local_12_in)) && !(Local_10_do<Local_11_do) ) || ( !(Local_13_do<NormalizeDouble(Local_8_do - Local_9_do,Local_12_in)) && !(Local_9_do<Local_11_do) ) || Local_2_in != 2 )   break;
   return(true); 
   case 24 :
   if ( !(Local_13_do<NormalizeDouble(Local_8_do - MarketInfo(Para_0_st,10),Local_12_in)) || ( !(Local_13_do<NormalizeDouble(Local_8_do - Local_10_do,Local_12_in)) && !(Local_10_do<Local_11_do) ) || ( !(Local_13_do<NormalizeDouble(Local_9_do - Local_8_do,Local_12_in)) && !(Local_9_do<Local_11_do) ) || Local_2_in != 2 )   break;
   return(true); 
   case 25 :
   if ( !(Local_13_do<NormalizeDouble(MarketInfo(Para_0_st,9) - Local_8_do,Local_12_in)) || ( !(Local_13_do<NormalizeDouble(Local_10_do - Local_8_do,Local_12_in)) && !(Local_10_do<Local_11_do) ) || ( !(Local_13_do<NormalizeDouble(Local_8_do - Local_9_do,Local_12_in)) && !(Local_9_do<Local_11_do) ) || Local_2_in != 2 )   break;
   return(true); 
   case 30 :
   if ( ( !(NormalizeDouble(MarketInfo(Para_0_st,9) - Local_7_do,Local_12_in)>Local_14_do) && !(Local_7_do<Local_11_do) ) || ( !(NormalizeDouble(Local_6_do - MarketInfo(Para_0_st,9),Local_12_in)>Local_14_do) && !(Local_6_do<Local_11_do) ) || ( !(Local_13_do<NormalizeDouble(MarketInfo(Para_0_st,9) - Local_10_do,Local_12_in)) && !(Local_10_do<Local_11_do) ) || ( !(Local_13_do<NormalizeDouble(Local_9_do - MarketInfo(Para_0_st,9),Local_12_in)) && !(Local_9_do<Local_11_do) ) )   break;
   return(true); 
   case 31 :
   if ( ( !(NormalizeDouble(Local_7_do - MarketInfo(Para_0_st,10),Local_12_in)>Local_14_do) && !(Local_7_do<Local_11_do) ) || ( !(NormalizeDouble(MarketInfo(Para_0_st,10) - Local_6_do,Local_12_in)>Local_14_do) && !(Local_6_do<Local_11_do) ) || ( !(Local_13_do<NormalizeDouble(Local_10_do - MarketInfo(Para_0_st,10),Local_12_in)) && !(Local_10_do<Local_11_do) ) || ( !(Local_13_do<NormalizeDouble(MarketInfo(Para_0_st,10) - Local_9_do,Local_12_in)) && !(Local_9_do<Local_11_do) ) )   break;
   return(true); 
   case 32 :
   if ( !(NormalizeDouble(MarketInfo(Para_0_st,10) - Local_5_do,Local_12_in)>Local_14_do) || ( !(Local_13_do<NormalizeDouble(Local_5_do - Local_7_do,Local_12_in)) && !(Local_7_do<Local_11_do) ) || ( !(Local_13_do<NormalizeDouble(Local_6_do - Local_5_do,Local_12_in)) && !(Local_6_do<Local_11_do) ) || !(Local_13_do<NormalizeDouble(MarketInfo(Para_0_st,10) - Local_8_do,Local_12_in)) || ( !(Local_13_do<NormalizeDouble(Local_8_do - Local_10_do,Local_12_in)) && !(Local_10_do<Local_11_do) ) || ( !(Local_13_do<NormalizeDouble(Local_9_do - Local_8_do,Local_12_in)) && !(Local_9_do<Local_11_do) ) )   break;
   return(true); 
   case 33 :
   if ( !(NormalizeDouble(Local_5_do - MarketInfo(Para_0_st,9),Local_12_in)>Local_14_do) || ( !(Local_13_do<NormalizeDouble(Local_7_do - Local_5_do,Local_12_in)) && !(Local_7_do<Local_11_do) ) || ( !(Local_13_do<NormalizeDouble(Local_5_do - Local_6_do,Local_12_in)) && !(Local_6_do<Local_11_do) ) || !(Local_13_do<NormalizeDouble(Local_8_do - MarketInfo(Para_0_st,9),Local_12_in)) || ( !(Local_13_do<NormalizeDouble(Local_10_do - Local_8_do,Local_12_in)) && !(Local_10_do<Local_11_do) ) || ( !(Local_13_do<NormalizeDouble(Local_8_do - Local_9_do,Local_12_in)) && !(Local_9_do<Local_11_do) ) )   break;
   return(true); 
   case 34 :
   if ( !(NormalizeDouble(Local_5_do - MarketInfo(Para_0_st,10),Local_12_in)>Local_14_do) || ( !(Local_13_do<NormalizeDouble(Local_5_do - Local_7_do,Local_12_in)) && !(Local_7_do<Local_11_do) ) || ( !(Local_13_do<NormalizeDouble(Local_6_do - Local_5_do,Local_12_in)) && !(Local_6_do<Local_11_do) ) || !(Local_13_do<NormalizeDouble(Local_8_do - MarketInfo(Para_0_st,10),Local_12_in)) || ( !(Local_13_do<NormalizeDouble(Local_8_do - Local_10_do,Local_12_in)) && !(Local_10_do<Local_11_do) ) || ( !(Local_13_do<NormalizeDouble(Local_9_do - Local_8_do,Local_12_in)) && !(Local_9_do<Local_11_do) ) )   break;
   return(true); 
   case 35 :
   if ( !(NormalizeDouble(MarketInfo(Para_0_st,9) - Local_5_do,Local_12_in)>Local_14_do) || ( !(Local_13_do<NormalizeDouble(Local_7_do - Local_5_do,Local_12_in)) && !(Local_7_do<Local_11_do) ) || ( !(Local_13_do<NormalizeDouble(Local_5_do - Local_6_do,Local_12_in)) && !(Local_6_do<Local_11_do) ) || !(Local_13_do<NormalizeDouble(MarketInfo(Para_0_st,9) - Local_8_do,Local_12_in)) || ( !(Local_13_do<NormalizeDouble(Local_10_do - Local_8_do,Local_12_in)) && !(Local_10_do<Local_11_do) ) || ( !(Local_13_do<NormalizeDouble(Local_8_do - Local_9_do,Local_12_in)) && !(Local_9_do<Local_11_do) ) )   break;
   return(true); 
 }
 return(false); 
 }
//lizong_46 <<==--------   --------
 void lizong_47( string Para_0_st,int Para_1_in,int Para_2_in,int Para_3_in,string Para_4_st,string Para_5_st,color Para_6_co,int Para_7_in)
 {
 if ( ObjectFind(0,Para_0_st) != -1 )
 {
   ObjectSetText(Para_0_st,Para_4_st,Para_7_in,Para_5_st,Para_6_co); 
   return;
 }
 if ( !(ObjectCreate(Para_0_st,23,Para_1_in,0,0.0,0,0.0,0,0.0)) )   return;
 ObjectSet(Para_0_st,101,0.0); 
 ObjectSet(Para_0_st,1028,1.0); 
 ObjectSet(Para_0_st,1000,0.0); 
 ObjectSetString(0,Para_0_st,206,"EveningScalper"); 
 ObjectSetInteger(0,Para_0_st,OBJPROP_HIDDEN,1); 
 ObjectSet(Para_0_st,102,Para_2_in); 
 ObjectSet(Para_0_st,103,Para_3_in); 
 ObjectSetText(Para_0_st,Para_4_st,Para_7_in,Para_5_st,Para_6_co); 
 }
//lizong_47 <<==--------   --------
 void lizong_48( int Para_0_in)
 {
  string    Local_1_st;
  int       Local_2_in;
  int       Local_3_in;
  int       Local_4_in;
  double    Local_5_do;
  double    Local_6_do;
  string    Local_7_st;
  int       Local_8_in;
  double    Local_9_do;
  double    Local_10_do;
  int       Local_11_in;
  int       Local_12_in;
  double    Local_13_do;
//----- -----
 string     tmp_st_1;
 double     tmp_do_2;
 int        tmp_in_3;
 long       tmp_lo_4;
 double     tmp_do_5;

 Local_1_st = Global_26_a_168_ko[Para_0_in].st_1 ;
 Local_2_in = 1 ;
 if ( Global_26_a_168_ko[Para_0_in].bo_38 != 0x0 )
 {
   Local_2_in = 96 ;
 }
 for (Local_3_in = 0 ; Local_3_in < Local_2_in ; Local_3_in ++)
 {
   Local_4_in = 16 ;
   Local_5_do = 0.002 ;
   Local_6_do = 0.0 ;
   Local_7_st = "" ;
   Global_26_a_168_ko[Para_0_in].lo_36 = 0.0;
   Global_26_a_168_ko[Para_0_in].do_37 = 0.0;
   if ( iBars(Local_1_st,Global_25_in) <  Local_4_in * 2 + Local_3_in )
   {
     return;
   }
   for (Local_8_in = 1 ; Local_8_in <= Local_4_in ; Local_8_in ++)
   {
     Local_9_do = iClose(Local_1_st,Global_25_in,Local_8_in + Local_3_in) ;
     Local_10_do = iOpen(Local_1_st,Global_25_in,Local_8_in + Local_3_in) ;
     Local_6_do = Local_6_do + Local_9_do ;
     if ( Local_9_do - Local_10_do>=0.0 )
     {
       Local_7_st +="1";
     }
     else
     {
       Local_7_st +="0";
     }
   }
   Global_26_a_168_ko[Para_0_in].do_37 = Local_6_do / Local_4_in;
   tmp_st_1 = Local_7_st;
   tmp_do_2 = 0.0;
   for (tmp_in_3 = 0 ; tmp_in_3 < StringLen(tmp_st_1)  ; tmp_in_3=tmp_in_3 + 1)
   {
     if ( StringGetCharacter(tmp_st_1,tmp_in_3) == 49 )
     {
       tmp_lo_4=tmp_do_2 * 2 + 1;
     }
   }
   Global_26_a_168_ko[Para_0_in].lo_36 = tmp_lo_4;
   if ( Global_26_a_168_ko[Para_0_in].bo_4 == 0x0 && Global_26_a_168_ko[Para_0_in].bo_5 == 0x0 && Global_26_a_168_ko[Para_0_in].bo_39 == 0x0 && Global_26_a_168_ko[Para_0_in].bo_40 == 0x0 )
   {
     return;
   }
   for (Local_11_in=Global_16_in / 100 - 1 ; Local_11_in >= 0 ; Local_11_in --)
   {
     Local_12_in=(Local_11_in + 1) * 100 - 1;
     if ( Local_12_in < Local_11_in * 100 )   continue;
     
     for ( ; Local_12_in >= Local_11_in * 100 ; Local_12_in --)
     {
       if ( Global_22_do_ko[Local_12_in]<Global_29_do )   break;
       
       if ( Global_26_a_168_ko[Para_0_in].do_37<Global_22_do_ko[Local_11_in * 100] )   break;
       Local_13_do = 1.0 ;
       if ( Global_22_do_ko[Local_12_in]<0.0 )
       {
         Local_13_do = -1.0 ;
       }
       tmp_do_5 = Local_5_do * Local_13_do;
       if ( !(Global_26_a_168_ko[Para_0_in].do_37<(Local_5_do * Local_13_do + 1.0) * Global_22_do_ko[Local_12_in]) || !(Global_26_a_168_ko[Para_0_in].do_37>(1.0 - tmp_do_5) * Global_22_do_ko[Local_12_in]) || Global_26_a_168_ko[Para_0_in].lo_36 != Global_21_lo_ko[Local_12_in] )   continue;
       Global_26_a_168_ko[Para_0_in].bo_4 = false;
       Global_26_a_168_ko[Para_0_in].bo_5 = false;
       Global_26_a_168_ko[Para_0_in].bo_39 = false;
       Global_26_a_168_ko[Para_0_in].bo_40 = false;
       break;
       
     }
     
   }
 }
 Global_26_a_168_ko[Para_0_in].bo_38 = false;
 }
//lizong_48 <<==--------   --------
 void lizong_49( int Para_0_in,string Para_1_st)
 {
 if ( Para_1_st == "" )
 {
   Para_1_st = "??????" ;
   Print(TradeComment + " " + Para_1_st,": List of Symbols is incorrect! Check it for extra commas!"); 
   Global_79_bo = true ;
 }
 Global_26_a_168_ko[Para_0_in].st_1 = Para_1_st;
 Global_26_a_168_ko[Para_0_in].da_2 = 0;
 Global_26_a_168_ko[Para_0_in].in_3 = 0;
 Global_26_a_168_ko[Para_0_in].bo_4 = false;
 Global_26_a_168_ko[Para_0_in].bo_5 = false;
 Global_26_a_168_ko[Para_0_in].da_6 = 0;
 Global_26_a_168_ko[Para_0_in].da_7 = 0;
 Global_26_a_168_ko[Para_0_in].do_8 = 0.0;
 Global_26_a_168_ko[Para_0_in].bo_9 = false;
 Global_26_a_168_ko[Para_0_in].in_10 = 0;
 Global_26_a_168_ko[Para_0_in].in_11 = 0;
 Global_26_a_168_ko[Para_0_in].in_12 = 0;
 Global_26_a_168_ko[Para_0_in].do_27 = 0.0;
 Global_26_a_168_ko[Para_0_in].do_28 = 0.0;
 Global_26_a_168_ko[Para_0_in].do_29 = 0.0;
 Global_26_a_168_ko[Para_0_in].do_30 = 0.0;
 Global_26_a_168_ko[Para_0_in].do_31 = 0.0;
 Global_26_a_168_ko[Para_0_in].do_43 = 0.0;
 Global_26_a_168_ko[Para_0_in].lo_36 = 0.0;
 Global_26_a_168_ko[Para_0_in].do_37 = 0.0;
 Global_26_a_168_ko[Para_0_in].bo_38 = true;
 Global_26_a_168_ko[Para_0_in].bo_39 = true;
 Global_26_a_168_ko[Para_0_in].bo_40 = true;
 Global_26_a_168_ko[Para_0_in].st_41 = Global_26_a_168_ko[Para_0_in].st_1;
 Global_26_a_168_ko[Para_0_in].do_42 = AdjustTakeProfit;
 Global_26_a_168_ko[Para_0_in].in_13 = 19;
 Global_26_a_168_ko[Para_0_in].in_14 = 0;
 Global_26_a_168_ko[Para_0_in].in_15 = 23;
 Global_26_a_168_ko[Para_0_in].in_16 = 59;
 Global_26_a_168_ko[Para_0_in].in_17 = 12345;
 Global_26_a_168_ko[Para_0_in].st_41 = "USD";
 Global_26_a_168_ko[Para_0_in].in_24 = 95;
 Global_26_a_168_ko[Para_0_in].do_25 = 0.5;
 Global_26_a_168_ko[Para_0_in].do_26 = 3.5;
 Global_26_a_168_ko[Para_0_in].do_22 = 120.0;
 Global_26_a_168_ko[Para_0_in].do_23 = 24.0;
 Global_26_a_168_ko[Para_0_in].in_10 = 73;
 Global_26_a_168_ko[Para_0_in].in_34 = 38;
 Global_26_a_168_ko[Para_0_in].do_35 = 9.0;
 Global_26_a_168_ko[Para_0_in].in_33 = 5;
 Global_26_a_168_ko[Para_0_in].in_32 = 40;
 Global_26_a_168_ko[Para_0_in].in_44 = 3;
 Global_26_a_168_ko[Para_0_in].in_18 = -1;
 Global_26_a_168_ko[Para_0_in].in_19 = -1;
 Global_26_a_168_ko[Para_0_in].in_20 = -1;
 Global_26_a_168_ko[Para_0_in].in_21 = -1;
 if ( StringFind(Global_26_a_168_ko[Para_0_in].st_1,"EURNZD",0) != -1 )
 {
   Global_26_a_168_ko[Para_0_in].in_13 = 19;
   Global_26_a_168_ko[Para_0_in].in_14 = 0;
   Global_26_a_168_ko[Para_0_in].in_15 = 22;
   Global_26_a_168_ko[Para_0_in].in_16 = 59;
   Global_26_a_168_ko[Para_0_in].in_17 = 1245;
   Global_26_a_168_ko[Para_0_in].st_41 = "NZD";
   if ( DisableBuiltInSettings )
   {
     Global_26_a_168_ko[Para_0_in].st_41 = "";
   }
   Global_26_a_168_ko[Para_0_in].in_24 = 95;
   Global_26_a_168_ko[Para_0_in].do_25 = 0.5;
   Global_26_a_168_ko[Para_0_in].do_26 = 3.5;
   Global_26_a_168_ko[Para_0_in].do_22 = 120.0;
   Global_26_a_168_ko[Para_0_in].do_23 = 24.0;
   Global_26_a_168_ko[Para_0_in].in_10 = 73;
   Global_26_a_168_ko[Para_0_in].in_34 = 38;
   Global_26_a_168_ko[Para_0_in].do_35 = 9.0;
   Global_26_a_168_ko[Para_0_in].in_33 = 5;
   Global_26_a_168_ko[Para_0_in].in_32 = 40;
   Global_26_a_168_ko[Para_0_in].in_44 = 3;
   lizong_29(Para_0_in,"EURNZD"); 
 }
 if ( StringFind(Global_26_a_168_ko[Para_0_in].st_1,"EURAUD",0) != -1 )
 {
   Global_26_a_168_ko[Para_0_in].in_13 = 22;
   Global_26_a_168_ko[Para_0_in].in_14 = 0;
   Global_26_a_168_ko[Para_0_in].in_15 = 23;
   Global_26_a_168_ko[Para_0_in].in_16 = 59;
   Global_26_a_168_ko[Para_0_in].in_17 = 125;
   Global_26_a_168_ko[Para_0_in].st_41 = "EURAUDUSD";
   if ( DisableBuiltInSettings )
   {
     Global_26_a_168_ko[Para_0_in].st_41 = "";
   }
   Global_26_a_168_ko[Para_0_in].in_24 = 80;
   Global_26_a_168_ko[Para_0_in].do_25 = 1.0;
   Global_26_a_168_ko[Para_0_in].do_26 = -0.5;
   Global_26_a_168_ko[Para_0_in].do_22 = 50.0;
   Global_26_a_168_ko[Para_0_in].do_23 = 15.0;
   Global_26_a_168_ko[Para_0_in].in_10 = 80;
   Global_26_a_168_ko[Para_0_in].in_34 = 20;
   Global_26_a_168_ko[Para_0_in].do_35 = 7.0;
   Global_26_a_168_ko[Para_0_in].in_33 = 0;
   Global_26_a_168_ko[Para_0_in].in_32 = 40;
   Global_26_a_168_ko[Para_0_in].in_44 = 5;
   lizong_29(Para_0_in,"EURAUD"); 
 }
 if ( StringFind(Global_26_a_168_ko[Para_0_in].st_1,"AUDNZD",0) != -1 )
 {
   Global_26_a_168_ko[Para_0_in].in_13 = 21;
   Global_26_a_168_ko[Para_0_in].in_14 = 0;
   Global_26_a_168_ko[Para_0_in].in_15 = 23;
   Global_26_a_168_ko[Para_0_in].in_16 = 59;
   Global_26_a_168_ko[Para_0_in].in_17 = 345;
   Global_26_a_168_ko[Para_0_in].st_41 = "AUDNZD";
   if ( DisableBuiltInSettings )
   {
     Global_26_a_168_ko[Para_0_in].st_41 = "";
   }
   Global_26_a_168_ko[Para_0_in].in_24 = 99;
   Global_26_a_168_ko[Para_0_in].do_25 = 0.5;
   Global_26_a_168_ko[Para_0_in].do_26 = 1.0;
   Global_26_a_168_ko[Para_0_in].do_22 = 50.0;
   Global_26_a_168_ko[Para_0_in].do_23 = 12.0;
   Global_26_a_168_ko[Para_0_in].in_10 = 77;
   Global_26_a_168_ko[Para_0_in].in_34 = 40;
   Global_26_a_168_ko[Para_0_in].do_35 = 5.0;
   Global_26_a_168_ko[Para_0_in].in_33 = 3;
   Global_26_a_168_ko[Para_0_in].in_32 = 25;
   Global_26_a_168_ko[Para_0_in].in_44 = 5;
   lizong_29(Para_0_in,"AUDNZD"); 
 }
 if ( StringFind(Global_26_a_168_ko[Para_0_in].st_1,"NZDCAD",0) != -1 )
 {
   Global_26_a_168_ko[Para_0_in].in_13 = 22;
   Global_26_a_168_ko[Para_0_in].in_14 = 0;
   Global_26_a_168_ko[Para_0_in].in_15 = 23;
   Global_26_a_168_ko[Para_0_in].in_16 = 59;
   Global_26_a_168_ko[Para_0_in].in_17 = 145;
   Global_26_a_168_ko[Para_0_in].st_41 = "NZDCAD";
   if ( DisableBuiltInSettings )
   {
     Global_26_a_168_ko[Para_0_in].st_41 = "";
   }
   Global_26_a_168_ko[Para_0_in].in_24 = 86;
   Global_26_a_168_ko[Para_0_in].do_25 = 0.5;
   Global_26_a_168_ko[Para_0_in].do_26 = 2.0;
   Global_26_a_168_ko[Para_0_in].do_22 = 60.0;
   Global_26_a_168_ko[Para_0_in].do_23 = 17.0;
   Global_26_a_168_ko[Para_0_in].in_10 = 95;
   Global_26_a_168_ko[Para_0_in].in_34 = 30;
   Global_26_a_168_ko[Para_0_in].do_35 = 5.0;
   Global_26_a_168_ko[Para_0_in].in_33 = 1;
   Global_26_a_168_ko[Para_0_in].in_32 = 25;
   Global_26_a_168_ko[Para_0_in].in_44 = 5;
   lizong_29(Para_0_in,"NZDCAD"); 
 }
 if ( StringFind(Global_26_a_168_ko[Para_0_in].st_1,"AUDCAD",0) != -1 )
 {
   Global_26_a_168_ko[Para_0_in].in_13 = 20;
   Global_26_a_168_ko[Para_0_in].in_14 = 0;
   Global_26_a_168_ko[Para_0_in].in_15 = 23;
   Global_26_a_168_ko[Para_0_in].in_16 = 59;
   Global_26_a_168_ko[Para_0_in].in_17 = 345;
   Global_26_a_168_ko[Para_0_in].st_41 = "AUDCAD";
   if ( DisableBuiltInSettings )
   {
     Global_26_a_168_ko[Para_0_in].st_41 = "";
   }
   Global_26_a_168_ko[Para_0_in].in_24 = 89;
   Global_26_a_168_ko[Para_0_in].do_25 = -0.2;
   Global_26_a_168_ko[Para_0_in].do_26 = 1.0;
   Global_26_a_168_ko[Para_0_in].do_22 = 65.0;
   Global_26_a_168_ko[Para_0_in].do_23 = 12.0;
   Global_26_a_168_ko[Para_0_in].in_10 = 80;
   Global_26_a_168_ko[Para_0_in].in_34 = 40;
   Global_26_a_168_ko[Para_0_in].do_35 = 5.0;
   Global_26_a_168_ko[Para_0_in].in_33 = 2;
   Global_26_a_168_ko[Para_0_in].in_32 = 30;
   Global_26_a_168_ko[Para_0_in].in_44 = 5;
   lizong_29(Para_0_in,"AUDCAD"); 
 }
 if ( StringFind(Global_26_a_168_ko[Para_0_in].st_1,"EURGBP",0) != -1 )
 {
   Global_26_a_168_ko[Para_0_in].in_13 = 20;
   Global_26_a_168_ko[Para_0_in].in_14 = 0;
   Global_26_a_168_ko[Para_0_in].in_15 = 23;
   Global_26_a_168_ko[Para_0_in].in_16 = 59;
   Global_26_a_168_ko[Para_0_in].in_17 = 134;
   Global_26_a_168_ko[Para_0_in].st_41 = "EURGBP";
   if ( DisableBuiltInSettings )
   {
     Global_26_a_168_ko[Para_0_in].st_41 = "";
   }
   Global_26_a_168_ko[Para_0_in].in_24 = 66;
   Global_26_a_168_ko[Para_0_in].do_25 = 1.5;
   Global_26_a_168_ko[Para_0_in].do_26 = -0.4;
   Global_26_a_168_ko[Para_0_in].do_22 = 50.0;
   Global_26_a_168_ko[Para_0_in].do_23 = 13.0;
   Global_26_a_168_ko[Para_0_in].in_10 = 80;
   Global_26_a_168_ko[Para_0_in].in_34 = 20;
   Global_26_a_168_ko[Para_0_in].do_35 = 6.0;
   Global_26_a_168_ko[Para_0_in].in_33 = 0;
   Global_26_a_168_ko[Para_0_in].in_32 = 50;
   Global_26_a_168_ko[Para_0_in].in_44 = 5;
   lizong_29(Para_0_in,"EURGBP"); 
 }
 if ( StringFind(Global_26_a_168_ko[Para_0_in].st_1,"GBPAUD",0) != -1 )
 {
   Global_26_a_168_ko[Para_0_in].in_13 = 22;
   Global_26_a_168_ko[Para_0_in].in_14 = 0;
   Global_26_a_168_ko[Para_0_in].in_15 = 23;
   Global_26_a_168_ko[Para_0_in].in_16 = 59;
   Global_26_a_168_ko[Para_0_in].in_17 = 25;
   Global_26_a_168_ko[Para_0_in].st_41 = "GBPAUD";
   if ( DisableBuiltInSettings )
   {
     Global_26_a_168_ko[Para_0_in].st_41 = "";
   }
   Global_26_a_168_ko[Para_0_in].in_24 = 89;
   Global_26_a_168_ko[Para_0_in].do_25 = 1.2;
   Global_26_a_168_ko[Para_0_in].do_26 = -0.5;
   Global_26_a_168_ko[Para_0_in].do_22 = 85.0;
   Global_26_a_168_ko[Para_0_in].do_23 = 15.0;
   Global_26_a_168_ko[Para_0_in].in_10 = 73;
   Global_26_a_168_ko[Para_0_in].in_34 = 16;
   Global_26_a_168_ko[Para_0_in].do_35 = 8.0;
   Global_26_a_168_ko[Para_0_in].in_33 = 0;
   Global_26_a_168_ko[Para_0_in].in_32 = 48;
   Global_26_a_168_ko[Para_0_in].in_44 = 5;
   lizong_29(Para_0_in,"GBPAUD"); 
 }
 if ( StringFind(Global_26_a_168_ko[Para_0_in].st_1,"GBPCAD",0) != -1 )
 {
   Global_26_a_168_ko[Para_0_in].in_13 = 22;
   Global_26_a_168_ko[Para_0_in].in_14 = 0;
   Global_26_a_168_ko[Para_0_in].in_15 = 23;
   Global_26_a_168_ko[Para_0_in].in_16 = 59;
   Global_26_a_168_ko[Para_0_in].in_17 = 25;
   Global_26_a_168_ko[Para_0_in].st_41 = "GBPCAD";
   if ( DisableBuiltInSettings )
   {
     Global_26_a_168_ko[Para_0_in].st_41 = "";
   }
   Global_26_a_168_ko[Para_0_in].in_24 = 55;
   Global_26_a_168_ko[Para_0_in].do_25 = 1.0;
   Global_26_a_168_ko[Para_0_in].do_26 = -1.1;
   Global_26_a_168_ko[Para_0_in].do_22 = 90.0;
   Global_26_a_168_ko[Para_0_in].do_23 = 15.0;
   Global_26_a_168_ko[Para_0_in].in_10 = 70;
   Global_26_a_168_ko[Para_0_in].in_34 = 20;
   Global_26_a_168_ko[Para_0_in].do_35 = 7.0;
   Global_26_a_168_ko[Para_0_in].in_33 = 0;
   Global_26_a_168_ko[Para_0_in].in_32 = 27;
   Global_26_a_168_ko[Para_0_in].in_44 = 5;
   lizong_29(Para_0_in,"GBPCAD"); 
 }
 StringToLower(Global_26_a_168_ko[Para_0_in].st_41); 
 if ( PositionTimeStop <= 0 )   return;
 Global_26_a_168_ko[Para_0_in].in_10 = PositionTimeStop;
 }
//lizong_49 <<==--------   --------
 void lizong_50( int Para_0_in)
 {
  string    Local_1_st;
  int       Local_2_in;
  int       Local_3_in;
  int       Local_4_in;
  int       Local_5_in;
  int       Local_6_in;
  int       Local_7_in;
  int       Local_8_in;
  int       Local_9_in;
  int       Local_10_in;
  int       Local_11_in;
  int       Local_12_in;
  int       Local_13_in;
  int       Local_14_in;
  int       Local_15_in;
  int       Local_16_in;
  int       Local_17_in;
  int       Local_18_in;
  int       Local_19_in;
  int       Local_20_in;
  int       Local_21_in;
  bool      Local_22_bo;
  int       Local_23_in;
  int       Local_24_in;
  int       Local_25_in;
  int       Local_26_in;
  int       Local_27_in;
  int       Local_28_in;
  datetime  Local_29_da;
  int       Local_30_in;
  datetime  Local_31_da;
  int       Local_32_in;
  int       Local_33_in;
  string    Local_34_st;
  int       Local_35_in;
  int       Local_36_in;
  int       Local_37_in;
  int       Local_38_in;
  int       Local_39_in;
  int       Local_40_in;
  int       Local_41_in;
  bool      Local_42_bo;
  int       Local_43_in;
  int       Local_44_in;
  int       Local_45_in;
  int       Local_46_in;
  int       Local_47_in;
  int       Local_48_in;
  int       Local_49_in;
  int       Local_50_in;
  int       Local_51_in;
  bool      Local_52_bo;
  int       Local_53_in;
  int       Local_54_in;
  bool      Local_55_bo;
  bool      Local_56_bo;
  string    Local_57_st;
  int       Local_58_in;
  bool      Local_59_bo;
  int       Local_60_in;
  int       Local_61_in;
  double    Local_62_do;
  double    Local_63_do;
  double    Local_64_do;
  double    Local_65_do;
  double    Local_66_do;
  double    Local_67_do;
  double    Local_68_do;
  double    Local_69_do;
  double    Local_70_do;
  int       Local_71_in;
  double    Local_72_do;
  int       Local_73_in;
//----- -----
 string     tmp_st_1;
 string     tmp_st_2;
 string     tmp_st_3;
 string     tmp_st_4;
 //string     tmp_st_5;
 string     tmp_st_6;
 int        tmp_in_7;
 double     tmp_do_8;
 double     tmp_do_9;
 double     tmp_do_10;
 int        tmp_in_11;
 int        tmp_in_12;
 int        tmp_in_13;
 int        tmp_in_14;
 int        tmp_in_15;

 Global_26_a_168_ko[Para_0_in].in_3 ++;
 Local_1_st = Global_26_a_168_ko[Para_0_in].st_1 ;
 Local_2_in = 0 ;
 Local_3_in = 1 ;
 Local_4_in=1 + 1;
 Local_5_in=Local_4_in + 1;
 Local_6_in=Local_4_in + Local_4_in;
 Local_7_in=Local_5_in + Local_4_in;
 Local_8_in=Local_5_in + Local_5_in;
 Local_9_in=Local_6_in + Local_5_in;
 Local_10_in=Local_8_in + Local_4_in;
 Local_11_in=Local_8_in + Local_5_in;
 Local_12_in = 0 ;
 Local_13_in = 1 ;
 Local_14_in = Local_4_in ;
 Local_15_in = Local_5_in ;
 Local_16_in=Local_5_in + 1;
 Local_17_in=Local_6_in + 1;
 Local_18_in=Local_17_in + 1;
 Local_19_in=Local_4_in + Local_17_in;
 Local_20_in=Local_16_in + Local_16_in;
 Local_21_in=Local_20_in + 1;
 Local_22_bo = true ;
 Local_23_in = 86400 ;
 Global_9_da = TimeCurrent() ;
 Local_24_in = TimeHour(Global_9_da) ;
 Local_25_in = TimeMinute(Global_9_da) ;
 Local_26_in = MathFloor(Local_25_in / 5.0) * 5.0 ;
 Local_27_in = 0 ;
 Local_28_in = 0 ;
 ResetLastError();
 Local_29_da = iTime(Local_1_st,5,0) ;
 Local_28_in = GetLastError() ;
 if ( ( TimeMinute(Local_29_da) != Local_26_in || Local_28_in == 4066 ) && Global_9_da >  0 )
 {
   for (Local_30_in = 0 ; Local_30_in < 10 ; Local_30_in ++)
   {
     Sleep(1000); 
     ResetLastError();
     Local_29_da = iTime(Local_1_st,5,0) ;
     Local_27_in = GetLastError() ;
     if ( Local_27_in != 0 )   continue;
     if ( TimeMinute(Local_29_da) == Local_26_in )   break;
     
   }
   if ( ( TimeMinute(Local_29_da) != Local_26_in || Local_27_in == 4066 ) && Global_26_a_168_ko[Para_0_in].in_3 >  0x1 && Local_27_in >  0 )
   {
     Print(TradeComment + " " + Local_1_st,": Error ",lizong_11(Local_27_in)," when updating history on ","M5"); 
     Local_22_bo = false ;
   }
 }
 ResetLastError();
 Local_31_da = iTime(Local_1_st,1440,0) ;
 Local_28_in = GetLastError() ;
 if ( ( TimeDay(Local_31_da) != Day() || Local_28_in == 4066 ) && Global_9_da >  0 )
 {
   for (Local_32_in = 0 ; Local_32_in < 60 ; Local_32_in ++)
   {
     Sleep(1000); 
     ResetLastError();
     Local_31_da = iTime(Local_1_st,1440,0) ;
     Local_27_in = GetLastError() ;
     if ( Local_27_in != 0 )   continue;
     if ( TimeDay(Local_31_da) == Day() )   break;
     
   }
   if ( ( TimeDay(Local_31_da) != Day() || Local_27_in == 4066 ) && Global_26_a_168_ko[Para_0_in].in_3 >  0x1 && Local_27_in >  0 )
   {
     Print(TradeComment + " " + Local_1_st,": Error ",lizong_11(Local_27_in)," when updating history on ","D1"); 
     Local_22_bo = false ;
   }
 }
 if ( iBars(Local_1_st,5) <  500 )
 {
   Print(TradeComment + " " + Local_1_st,": Not enough historical data on ","M5"); 
   Local_22_bo = false ;
   Local_2_in = 1 ;
   Local_3_in = 1 ;
   Local_4_in = 1 ;
   Local_5_in = 1 ;
   Local_6_in = 1 ;
   Local_7_in = 1 ;
   Local_8_in = 1 ;
   Local_9_in = 1 ;
   Local_10_in = 1 ;
   Local_11_in = 1 ;
   Local_12_in = 1 ;
   Local_13_in = 1 ;
   Local_14_in = 1 ;
   Local_15_in = 1 ;
   Local_16_in = 1 ;
   Local_17_in = 1 ;
   Local_18_in = 1 ;
   Local_19_in = 1 ;
   Local_20_in = 1 ;
   Local_21_in = 1 ;
 }
 if ( iBars(Local_1_st,1440) <  10 )
 {
   Print(TradeComment + " " + Local_1_st,": Not enough historical data on ","D1"); 
   Local_22_bo = false ;
 }
 if ( iBars(StockMarketSymbol,60) <  StockMarketFilterPeriod + 1 && StockMarketFilterEnabled )
 {
   Print(TradeComment + " " + StockMarketSymbol,": Not enough historical data for stock market crash filter: ","H1"); 
 }
 if ( AccountFreeMargin()<10.0 )
 {
   Local_22_bo = false ;
   Print(TradeComment + " " + Local_1_st,": Not enough money: ",DoubleToString(MathFloor(AccountFreeMargin()),2)); 
 }
 if ( ( UID > 9 || UID <  0 ) )
 {
   Print(TradeComment + " " + Local_1_st,": UID value issue!"); 
   Local_22_bo = false ;
 }
 Global_26_a_168_ko[Para_0_in].da_6 = iTime(Local_1_st,Global_25_in,0);
 Global_26_a_168_ko[Para_0_in].da_7 = Global_26_a_168_ko[Para_0_in].da_6;
 Local_33_in=lizong_38("US",Global_26_a_168_ko[Para_0_in].da_6) + 0x2;
 if ( !(IsTesting()) && Global_34_in == 999 )
 {
   Global_34_in = Local_33_in ;
 }
 Local_34_st = "Disabled" ;
 if ( DST == 1 )
 {
   Local_34_st = "US" ;
 }
 if ( DST == 2 )
 {
   Local_34_st = "Europe" ;
 }
 if ( ( IsTesting() || DisableAutoGMT ) )
 {
   Global_34_in=lizong_38(Local_34_st,Global_26_a_168_ko[Para_0_in].da_6) + GMT_offset;
 }
 Local_35_in=Local_33_in - Global_34_in;
 if ( DisableAutoGMT )
 {
   Global_35_in = Global_34_in ;
 }
 Global_26_a_168_ko[Para_0_in].da_6 = Global_26_a_168_ko[Para_0_in].da_6 + Local_35_in * 60 * 60;
 Global_68_da = Global_26_a_168_ko[Para_0_in].da_6 ;
 if ( Global_26_a_168_ko[Para_0_in].in_3 <  0x2 )
 {
   Local_22_bo = false ;
 }
 if ( !(AllowOpeningNewTrades) )
 {
   Local_22_bo = false ;
 }
 Global_26_a_168_ko[Para_0_in].bo_4 = Local_22_bo;
 Global_26_a_168_ko[Para_0_in].bo_5 = Local_22_bo;
 Global_26_a_168_ko[Para_0_in].bo_9 = false;
 Local_36_in = SymbolInfoInteger(Local_1_st,30) ;
 switch(Local_36_in)
 {
   case 0 :
   Print(TradeComment + " " + Local_1_st,": Trading is disabled for ",Local_1_st); 
   Global_26_a_168_ko[Para_0_in].bo_4 = false;
   Global_26_a_168_ko[Para_0_in].bo_5 = false;
     break;
   case 3 :
   Global_26_a_168_ko[Para_0_in].bo_4 = true;
   Global_26_a_168_ko[Para_0_in].bo_5 = false;
     break;
   case 4 :
   Global_26_a_168_ko[Para_0_in].bo_4 = false;
   Global_26_a_168_ko[Para_0_in].bo_5 = true;
     break;
   case 1 :
   Global_26_a_168_ko[Para_0_in].bo_4 = false;
   Global_26_a_168_ko[Para_0_in].bo_5 = false;
 }
 if ( AllowToBuySell == 1 )
 {
   Global_26_a_168_ko[Para_0_in].bo_4 = true;
   Global_26_a_168_ko[Para_0_in].bo_5 = false;
 }
 if ( AllowToBuySell == 2 )
 {
   Global_26_a_168_ko[Para_0_in].bo_4 = false;
   Global_26_a_168_ko[Para_0_in].bo_5 = true;
 }
 Global_32_in = TimeHour(Global_68_da) ;
 Global_33_in = TimeMinute(Global_68_da) ;
 Local_37_in = TimeDayOfWeek(Global_68_da) ;
 Local_38_in = TimeMonth(Global_68_da) ;
 Local_39_in = TimeDay(Global_68_da) ;
 Local_40_in = TimeDayOfWeek(Global_68_da) ;
 Local_41_in = TimeYear(Global_68_da) ;
 Global_26_a_168_ko[Para_0_in].do_8 = iClose(Local_1_st,Global_25_in,1);
 if ( NewsFilterEnabled && ( IsTesting() || IsOptimization() ) )
 {
   if ( Global_43_in != Day() )
   {
     tmp_st_6 = "Disabled";
     if ( DST == 1 )
     {
       tmp_st_6 = "US";
     }
     if ( DST == 2 )
     {
       tmp_st_6 = "Europe";
     }
     Global_35_in=lizong_38(tmp_st_6,Global_26_a_168_ko[0].da_6) + GMT_offset;
     Global_37_lo = TimeCurrent() ;
     Global_38_st = "Manual (backtesting)" ;
   }
   lizong_33(); 
   if ( ( ( Global_43_in != Day() && Global_43_in >= 0 && DayOfWeek() == 1 ) || (Global_43_in != Day() && Global_40_in == 0 && Global_41_da == 0) ) )
   {
     lizong_31(TimeCurrent(),DisableTradingOnHolidays); 
   }
 }
 Global_43_in = Day() ;
 if ( Global_73_in != Global_32_in )
 {
   Global_59_do = 0.0 ;
   Global_60_do = 0.0 ;
   if ( RandomizeLevels )
   {
     Global_59_do = NormalizeDouble(((MathRand() + GetTickCount() % Global_49_ui) / Global_49_ui + 3.14159265359 - (MathFloor((MathRand() + GetTickCount() % Global_49_ui) / Global_49_ui + 3.14159265359)) - 0.5) * 3.0,1) ;
     Global_60_do = NormalizeDouble(((MathRand() + GetTickCount() % Global_49_ui) / Global_49_ui + 3.14159265359 - (MathFloor((MathRand() + GetTickCount() % Global_49_ui) / Global_49_ui + 3.14159265359)) - 0.5) * 6.0,1) ;
     if ( Global_59_do<Global_29_do && Global_59_do> -(Global_29_do) )
     {
       Global_59_do = NormalizeDouble(0.1,1) ;
     }
     if ( Global_60_do<Global_29_do && Global_60_do> -(Global_29_do) )
     {
       Global_60_do = NormalizeDouble(0.1,1) ;
     }
   }
 }
 if ( Hour() != Global_65_in && Hour() == MaxDailyDrawdownResetHourFTMO )
 {
   Global_64_do = AccountInfoDouble(ACCOUNT_EQUITY) ;
   Global_66_bo = false ;
 }
 Global_65_in = Hour() ;
 if ( Global_32_in != Global_54_in && Global_32_in == 4 )
 {
   Global_63_do = 0.0 ;
 }
 Global_54_in = Global_32_in ;
 if ( StockMarketFilterEnabled && iBars(StockMarketSymbol,60) >  StockMarketFilterPeriod )
 {
   lizong_44(); 
 }
 if ( Global_63_do>Global_29_do && StockMarketFilterEnabled && Global_63_do>MaxHistoricalVolatility )
 {
   if ( TimeCurrent() - Global_77_lo >  3600 )
   {
     Print(TradeComment + " " + Local_1_st,": Tradind is not allowed due to Stock Market Crash Filter! HV=",NormalizeDouble(Global_63_do,2),"%"); 
     Global_77_lo = TimeCurrent() ;
   }
   Local_22_bo = false ;
 }
 Global_26_a_168_ko[Para_0_in].bo_4 &=Local_22_bo;
 Global_26_a_168_ko[Para_0_in].bo_5 &=Local_22_bo;
 Local_42_bo = true ;
 Local_43_in=Global_33_in + Global_32_in * 100;
 Local_44_in=HourToStartOpeningOrders * 100 + MinutesToStartOpeningOrders;
 Local_45_in=HourToStopOpeningOrders * 100 + MinutesToStopOpeningOrders;
 if ( Local_45_in >= Local_44_in )
 {
   Local_42_bo &=(Local_43_in>=Local_44_in && Local_43_in<=Local_45_in);
 }
 if ( Local_45_in <  Local_44_in )
 {
   Local_42_bo &=(Local_43_in>=Local_44_in || Local_43_in<=Local_45_in);
 }
 Global_26_a_168_ko[Para_0_in].in_18 = HourToStartOpeningOrders;
 Global_26_a_168_ko[Para_0_in].in_19 = MinutesToStartOpeningOrders;
 Global_26_a_168_ko[Para_0_in].in_20 = HourToStopOpeningOrders;
 Global_26_a_168_ko[Para_0_in].in_21 = MinutesToStopOpeningOrders;
 if ( SmartTimeFilter )
 {
   Local_46_in=Global_26_a_168_ko[Para_0_in].in_13 * 100 + Global_26_a_168_ko[Para_0_in].in_14;
   Local_47_in=Global_26_a_168_ko[Para_0_in].in_15 * 100 + Global_26_a_168_ko[Para_0_in].in_16;
   if ( Local_47_in >= Local_46_in )
   {
     Local_42_bo &=(Local_43_in>=Local_46_in && Local_43_in<=Local_47_in);
   }
   if ( Local_47_in <  Local_46_in )
   {
     Local_42_bo &=(Local_43_in>=Local_46_in || Local_43_in<=Local_47_in);
   }
   Local_48_in = 9999 ;
   Local_49_in = -9999 ;
   Local_50_in = -1 ;
   Local_51_in = -1 ;
   Local_52_bo = true ;
   for (Local_53_in = 0 ; Local_53_in < 2400 ; Local_53_in ++)
   {
     Local_54_in=Local_53_in + 1200;
     if ( Local_53_in >= 1200 )
     {
       Local_54_in=Local_53_in - 1200;
     }
     Local_55_bo = true ;
     if ( Local_45_in >= Local_44_in )
     {
       Local_55_bo &=(Local_54_in>=Local_44_in && Local_54_in<=Local_45_in);
     }
     if ( Local_45_in <  Local_44_in )
     {
       Local_55_bo &=(Local_54_in>=Local_44_in || Local_54_in<=Local_45_in);
     }
     if ( Local_47_in >= Local_46_in )
     {
       Local_55_bo &=(Local_54_in>=Local_46_in && Local_54_in<=Local_47_in);
     }
     if ( Local_47_in <  Local_46_in )
     {
       Local_55_bo &=(Local_54_in>=Local_46_in || Local_54_in<=Local_47_in);
     }
     if ( Local_55_bo )
     {
       Local_50_in = Local_54_in ;
     }
     if ( !(Local_55_bo) || !(Local_52_bo) )   continue;
     Local_51_in = Local_54_in ;
     Local_52_bo = false ;
     
   }
   Global_26_a_168_ko[Para_0_in].in_18 = Local_51_in / 100;
   tmp_in_7 = Local_50_in / 100;
   Global_26_a_168_ko[Para_0_in].in_20 = tmp_in_7;
   Global_26_a_168_ko[Para_0_in].in_19 = Local_51_in - Local_51_in / 100 * 100;
   Global_26_a_168_ko[Para_0_in].in_21 = Local_50_in - tmp_in_7 * 100;
   if ( Global_26_a_168_ko[Para_0_in].in_18 >  0x17 )
   {
     Global_26_a_168_ko[Para_0_in].in_18 = 23;
   }
   if ( Global_26_a_168_ko[Para_0_in].in_20 >  0x17 )
   {
     Global_26_a_168_ko[Para_0_in].in_20 = 23;
   }
   if ( Global_26_a_168_ko[Para_0_in].in_19 >  0x3B )
   {
     Global_26_a_168_ko[Para_0_in].in_19 = 59;
   }
   if ( Global_26_a_168_ko[Para_0_in].in_21 >  0x3B )
   {
     Global_26_a_168_ko[Para_0_in].in_21 = 59;
   }
 }
 if ( Global_93_bo )
 {
   if ( Global_32_in == 0 && TimeDayOfWeek(Global_68_da) == 1 )
   {
     Local_42_bo &=Global_33_in>=45;
   }
   if ( Global_32_in == 23 && TimeDayOfWeek(Global_68_da) == 5 )
   {
     Local_42_bo &=Global_33_in<45;
   }
   if ( Global_32_in == 23 && ( Global_26_a_168_ko[Para_0_in].in_15 == 0x17 || (!(SmartTimeFilter) && HourToStopOpeningOrders == 23) ) && Global_33_in >  RolloverStartTime )
   {
     Local_42_bo = false ;
   }
   if ( Global_26_a_168_ko[Para_0_in].in_20 == 0x17 && TimeDayOfWeek(Global_68_da) == 5 && Global_26_a_168_ko[Para_0_in].in_21 >= 0x2D )
   {
     Global_26_a_168_ko[Para_0_in].in_21 = 44;
   }
   if ( Global_26_a_168_ko[Para_0_in].in_20 == 0x17 && Global_26_a_168_ko[Para_0_in].in_21 >  RolloverStartTime )
   {
     Global_26_a_168_ko[Para_0_in].in_21 = RolloverStartTime;
   }
 }
 if ( Global_26_a_168_ko[Para_0_in].in_18 >  0x17 )
 {
   Global_26_a_168_ko[Para_0_in].in_18 = 23;
 }
 if ( Global_26_a_168_ko[Para_0_in].in_20 >  0x17 )
 {
   Global_26_a_168_ko[Para_0_in].in_20 = 23;
 }
 if ( Global_26_a_168_ko[Para_0_in].in_19 >  0x3B )
 {
   Global_26_a_168_ko[Para_0_in].in_19 = 59;
 }
 if ( Global_26_a_168_ko[Para_0_in].in_21 >  0x3B )
 {
   Global_26_a_168_ko[Para_0_in].in_21 = 59;
 }
 if ( FridayExitHour != 0 && TimeDayOfWeek(Global_68_da) == 5 && Global_32_in >= FridayExitHour )
 {
   Local_42_bo = false ;
 }
 if ( NY_HolidayFilter && ( Local_38_in == 1 || Local_38_in == 12 ) )
 {
   if ( Local_38_in == 12 && Local_39_in >  24 )
   {
     Local_42_bo = false ;
   }
   if ( Local_38_in == 1 && Local_39_in <= 7 )
   {
     Local_42_bo = false ;
   }
 }
 if ( !(TradeOnMonday) && ( ( TimeDayOfWeek(Global_68_da) == 1 && Global_32_in >= 12 ) || (TimeDayOfWeek(Global_68_da) == 2 && Global_32_in <  12) ) )
 {
   Local_42_bo = false ;
 }
 if ( !(TradeOnTuesday) && ( ( TimeDayOfWeek(Global_68_da) == 2 && Global_32_in >= 12 ) || (TimeDayOfWeek(Global_68_da) == 3 && Global_32_in <  12) ) )
 {
   Local_42_bo = false ;
 }
 if ( !(TradeOnWednesday) && ( ( TimeDayOfWeek(Global_68_da) == 3 && Global_32_in >= 12 ) || (TimeDayOfWeek(Global_68_da) == 4 && Global_32_in <  12) ) )
 {
   Local_42_bo = false ;
 }
 if ( !(TradeOnThursday) && ( ( TimeDayOfWeek(Global_68_da) == 4 && Global_32_in >= 12 ) || (TimeDayOfWeek(Global_68_da) == 5 && Global_32_in <  12) ) )
 {
   Local_42_bo = false ;
 }
 if ( !(TradeOnFriday) && ( ( TimeDayOfWeek(Global_68_da) == 5 && Global_32_in >= 12 ) || (TimeDayOfWeek(Global_68_da) == 1 && Global_32_in <  12) ) )
 {
   Local_42_bo = false ;
 }
 if ( Global_81_bo )
 {
   Local_42_bo &=Global_68_da<Global_84_lo;
 }
 if ( Global_68_da >  Global_84_lo )
 {
   Global_85_bo = false ;
 }
 Global_26_a_168_ko[Para_0_in].bo_4 &=Local_42_bo;
 Global_26_a_168_ko[Para_0_in].bo_5 &=Local_42_bo;
 if ( SmartTimeFilter )
 {
   Local_56_bo = false ;
   if ( Global_26_a_168_ko[Para_0_in].in_17 <  0xA && Global_26_a_168_ko[Para_0_in].in_17 >= 0x0 )
   {
     Local_56_bo=Local_37_in==Global_26_a_168_ko[Para_0_in].in_17;
   }
   else
   {
     if ( Global_26_a_168_ko[Para_0_in].in_17 == 0xFFFFFFFF )
     {
       Local_56_bo = true ;
     }
     else
     {
       Local_57_st = IntegerToString(MathAbs(Global_26_a_168_ko[Para_0_in].in_17),0,32) ;
       for (Local_58_in = 0 ; Local_58_in < StringLen(Local_57_st)  ; Local_58_in ++)
       {
         if ( StringToInteger(StringSubstr(Local_57_st,Local_58_in,1)) == Local_37_in )
         {
           Local_56_bo = true ;
         }
       }
     }
   }
   Global_26_a_168_ko[Para_0_in].bo_4 &=Local_56_bo;
   Global_26_a_168_ko[Para_0_in].bo_5 &=Local_56_bo;
 }
 Local_59_bo = false ;
 Local_60_in = 3 ;
 Local_61_in = SymbolInfoInteger(Local_1_st,40) ;
 if ( Local_61_in >= 0 && Local_61_in <= 7 )
 {
   Local_60_in = Local_61_in ;
 }
 if ( ApplySwapFilterTo == 1 )
 {
   Local_59_bo = Local_37_in==Local_60_in && Global_32_in>12 ;
 }
 if ( ApplySwapFilterTo == 0 )
 {
   Local_59_bo=Global_32_in>12;
 }
 Local_62_do = 1.0 ;
 if ( Local_37_in == Local_60_in )
 {
   Local_62_do = 3.0 ;
 }
 Local_63_do = MarketInfo(Local_1_st,18) * Local_62_do ;
 Local_64_do = MarketInfo(Local_1_st,19) * Local_62_do ;
 if ( Local_59_bo && SwapFilter )
 {
   tmp_do_8 = MaxNegativeSwapPips + 0.001;
   Global_26_a_168_ko[Para_0_in].bo_4 &=Local_63_do> -(tmp_do_8);
   Global_26_a_168_ko[Para_0_in].bo_5 &=Local_64_do> -(tmp_do_8);
 }
 IsTesting(); 
 HideTestIndicators(true); 
 Global_26_a_168_ko[Para_0_in].do_27 = iHigh(Local_1_st,lizong_10(5),iHighest(Local_1_st,lizong_10(5),2,Global_26_a_168_ko[Para_0_in].in_24,1));
 Global_26_a_168_ko[Para_0_in].do_28 = iLow(Local_1_st,lizong_10(5),iLowest(Local_1_st,lizong_10(5),1,Global_26_a_168_ko[Para_0_in].in_24,1));
 Global_26_a_168_ko[Para_0_in].do_29 = iHigh(Local_1_st,lizong_10(5),iHighest(Local_1_st,lizong_10(5),2,Global_26_a_168_ko[Para_0_in].in_24,2));
 Global_26_a_168_ko[Para_0_in].do_30 = iLow(Local_1_st,lizong_10(5),iLowest(Local_1_st,lizong_10(5),1,Global_26_a_168_ko[Para_0_in].in_24,2));
 HideTestIndicators(false); 
 Local_65_do = iATR(Local_1_st,1440,Global_26_a_168_ko[Para_0_in].in_44,1) ;
 Global_26_a_168_ko[Para_0_in].do_43 = Local_65_do;
 if ( MinimumPriceRange>Global_29_do )
 {
   tmp_do_9 = MinimumPriceRange / 100.0;
   if ( Global_26_a_168_ko[Para_0_in].do_29 - Global_26_a_168_ko[Para_0_in].do_30<MinimumPriceRange / 100.0 * Local_65_do && Global_26_a_168_ko[Para_0_in].do_29>Global_29_do && Global_26_a_168_ko[Para_0_in].do_30>Global_29_do )
   {
     Local_66_do = (Global_26_a_168_ko[Para_0_in].do_29 + Global_26_a_168_ko[Para_0_in].do_30) / 2.0 ;
     tmp_do_9 = tmp_do_9;
     Global_26_a_168_ko[Para_0_in].do_29 = MinimumPriceRange / 100.0 * Local_65_do / 2.0 + Local_66_do;
     Global_26_a_168_ko[Para_0_in].do_30 = Local_66_do - tmp_do_9 * Local_65_do / 2.0;
   }
 }
 Global_26_a_168_ko[Para_0_in].do_27 = NormalizeDouble(Global_26_a_168_ko[Para_0_in].do_27,MarketInfo(Global_26_a_168_ko[Para_0_in].st_1,12));
 Global_26_a_168_ko[Para_0_in].do_28 = NormalizeDouble(Global_26_a_168_ko[Para_0_in].do_28,MarketInfo(Global_26_a_168_ko[Para_0_in].st_1,12));
 Global_26_a_168_ko[Para_0_in].do_29 = NormalizeDouble(Global_26_a_168_ko[Para_0_in].do_29,MarketInfo(Global_26_a_168_ko[Para_0_in].st_1,12));
 Global_26_a_168_ko[Para_0_in].do_30 = NormalizeDouble(Global_26_a_168_ko[Para_0_in].do_30,MarketInfo(Global_26_a_168_ko[Para_0_in].st_1,12));
 if ( Global_26_a_168_ko[Para_0_in].do_27<Global_29_do )
 {
   Global_26_a_168_ko[Para_0_in].bo_5 = false;
 }
 if ( Global_26_a_168_ko[Para_0_in].do_28<Global_29_do )
 {
   Global_26_a_168_ko[Para_0_in].bo_4 = false;
 }
 if ( Global_26_a_168_ko[Para_0_in].do_29<Global_29_do )
 {
   Global_26_a_168_ko[Para_0_in].bo_5 = false;
 }
 if ( Global_26_a_168_ko[Para_0_in].do_30<Global_29_do )
 {
   Global_26_a_168_ko[Para_0_in].bo_4 = false;
 }
 Global_26_a_168_ko[Para_0_in].do_31 = (Global_26_a_168_ko[Para_0_in].do_27 + Global_26_a_168_ko[Para_0_in].do_28) / 2.0;
 if ( ( Global_26_a_168_ko[Para_0_in].do_27<Global_29_do || Global_26_a_168_ko[Para_0_in].do_28<Global_29_do ) )
 {
   Global_26_a_168_ko[Para_0_in].do_31 = 0.0;
 }
 Global_26_a_168_ko[Para_0_in].do_31 = NormalizeDouble(Global_26_a_168_ko[Para_0_in].do_31,MarketInfo(Global_26_a_168_ko[Para_0_in].st_1,12));
 if ( Global_26_a_168_ko[Para_0_in].in_32 >  0x0 && EnableVolatilityFilter )
 {
   Local_67_do = Local_65_do * Global_26_a_168_ko[Para_0_in].in_32 / 100.0 ;
   Global_26_a_168_ko[Para_0_in].bo_4 &=Global_26_a_168_ko[Para_0_in].do_27 - Global_26_a_168_ko[Para_0_in].do_28>Local_67_do;
   Global_26_a_168_ko[Para_0_in].bo_5 &=Global_26_a_168_ko[Para_0_in].do_27 - Global_26_a_168_ko[Para_0_in].do_28>Local_67_do;
 }
 Local_68_do = (MarketInfo(Local_1_st,11)>Global_29_do) ?MarketInfo(Local_1_st,11):0.00001  ;
 tmp_do_10 = Global_26_a_168_ko[Para_0_in].do_25 * Local_68_do;
 tmp_in_11 = 10;
 tmp_in_12 = MarketInfo(Global_26_a_168_ko[Para_0_in].st_1,12);
 if ( tmp_in_12 == 5 )
 {
   tmp_in_11 = 10;
 }
 if ( tmp_in_12 == 4 )
 {
   tmp_in_11 = 1;
 }
 if ( tmp_in_12 == 0x3 )
 {
   tmp_in_11 = 10;
 }
 if ( ( tmp_in_12 == 2 || tmp_in_12 == 1 || tmp_in_12 == 0 ) )
 {
   tmp_in_11 = 1;
 }
 Local_69_do = tmp_do_10 * tmp_in_11 ;
 Global_26_a_168_ko[Para_0_in].do_28 = NormalizeDouble(Global_26_a_168_ko[Para_0_in].do_28 + Local_69_do,MarketInfo(Global_26_a_168_ko[Para_0_in].st_1,12));
 Global_26_a_168_ko[Para_0_in].do_27 = NormalizeDouble(Global_26_a_168_ko[Para_0_in].do_27 - Local_69_do,MarketInfo(Global_26_a_168_ko[Para_0_in].st_1,12));
 Global_26_a_168_ko[Para_0_in].do_30 = NormalizeDouble(Global_26_a_168_ko[Para_0_in].do_30 + Local_69_do,MarketInfo(Global_26_a_168_ko[Para_0_in].st_1,12));
 Global_26_a_168_ko[Para_0_in].do_29 = NormalizeDouble(Global_26_a_168_ko[Para_0_in].do_29 - Local_69_do,MarketInfo(Global_26_a_168_ko[Para_0_in].st_1,12));
 if ( Global_10_in >  0 )
 {
   Global_26_a_168_ko[Para_0_in].bo_4 = false;
   Global_26_a_168_ko[Para_0_in].bo_5 = false;
 }
 if ( Global_26_a_168_ko[Para_0_in].in_33 != 0x0 )
 {
   Local_70_do = iMA(Local_1_st,lizong_10(1440),MathAbs(Global_26_a_168_ko[Para_0_in].in_33),0,1,0,1) ;
   Local_70_do = NormalizeDouble(Local_70_do,Digits()) ;
   if ( Global_26_a_168_ko[Para_0_in].in_33 >  0x0 )
   {
     Global_26_a_168_ko[Para_0_in].bo_4 &=Global_26_a_168_ko[Para_0_in].do_8<Local_70_do;
     Global_26_a_168_ko[Para_0_in].bo_5 &=Global_26_a_168_ko[Para_0_in].do_8>Local_70_do;
   }
 }
 if ( Local_40_in != Global_26_a_168_ko[Para_0_in].in_12 && Global_26_a_168_ko[Para_0_in].in_12 != 0x0 )
 {
   Global_26_a_168_ko[Para_0_in].bo_39 = Global_26_a_168_ko[Para_0_in].bo_40;
   Global_26_a_168_ko[Para_0_in].bo_40 = true;
 }
 Global_26_a_168_ko[Para_0_in].in_12 = Local_40_in;
 Global_26_a_168_ko[Para_0_in].bo_4 &=Global_26_a_168_ko[Para_0_in].bo_39;
 Global_26_a_168_ko[Para_0_in].bo_5 &=Global_26_a_168_ko[Para_0_in].bo_39;
 if ( Global_15_bo && Local_41_in * 10000 + Local_38_in * 100 + Local_39_in <  20220115 )
 {
   lizong_48(Para_0_in); 
 }
 if ( Global_81_bo )
 {
   Global_26_a_168_ko[Para_0_in].bo_4 &=Global_85_bo;
   Global_26_a_168_ko[Para_0_in].bo_5 &=Global_85_bo;
 }
 Global_7_in ++;
 Global_7_in ++;
 tmp_in_13 = 0;
 for (tmp_in_14 = 0 ; tmp_in_14 < ArraySize(Global_26_a_168_ko) ; tmp_in_14=tmp_in_14 + 1)
 {
   if ( lizong_21(Global_26_a_168_ko[tmp_in_14].st_1,-1,0) )
   {
     tmp_in_13=tmp_in_13 + 1;
   }
 }
 Local_71_in = tmp_in_13 ;
 if ( Local_71_in >= MaximumSymbols )
 {
   Global_26_a_168_ko[Para_0_in].bo_4 = false;
   Global_26_a_168_ko[Para_0_in].bo_5 = false;
   if ( Local_71_in >  MaximumSymbols )
   {
     Print(TradeComment + " " + Local_1_st,": Number of open symbols is exceeded a specified value!"); 
   }
 }
 lizong_52(Para_0_in,true); 
 Global_26_a_168_ko[Para_0_in].bo_4 &=Global_26_a_168_ko[Para_0_in].do_8<Global_26_a_168_ko[Para_0_in].do_30;
 Global_26_a_168_ko[Para_0_in].bo_4 &=Global_26_a_168_ko[Para_0_in].do_30>0.0;
 Global_26_a_168_ko[Para_0_in].bo_5 &=Global_26_a_168_ko[Para_0_in].do_8>Global_26_a_168_ko[Para_0_in].do_29;
 Global_26_a_168_ko[Para_0_in].bo_5 &=Global_26_a_168_ko[Para_0_in].do_29>0.0;
 lizong_45(); 
 if ( MinimumFreeMargin>Global_29_do && AccountInfoDouble(ACCOUNT_MARGIN_LEVEL)<MinimumFreeMargin && AccountInfoDouble(ACCOUNT_MARGIN_LEVEL)>Global_29_do )
 {
   for (tmp_in_15 = 0 ; tmp_in_15 < ArraySize(Global_26_a_168_ko) ; tmp_in_15=tmp_in_15 + 1)
   {
     Global_26_a_168_ko[tmp_in_15].bo_4 = false;
     Global_26_a_168_ko[tmp_in_15].bo_5 = false;
   }
   if ( TimeCurrent() - Global_75_lo >  1800 )
   {
     Print(TradeComment + " " + "->",": Too low account margin level: ",DoubleToString(AccountInfoDouble(ACCOUNT_MARGIN_LEVEL),2),". Trading is not allowed!"); 
     Global_75_lo = TimeCurrent() ;
   }
 }
 if ( Global_73_in != Global_32_in )
 {
   Global_71_in --;
 }
 if ( Global_71_in <  0 )
 {
   Global_71_in = 0 ;
 }
 if ( Global_70_bo )
 {
   Local_72_do = 0.0 ;
   for (Local_73_in = 0 ; Local_73_in < ArraySize(Global_26_a_168_ko) ; Local_73_in ++)
   {
     Local_72_do = Local_72_do + lizong_22(Global_26_a_168_ko[Local_73_in].st_1,-1,0,false) ;
   }
   if ( Local_72_do<Global_29_do )
   {
     Global_70_bo = false ;
   }
 }
 if ( Global_70_bo )
 {
   Global_26_a_168_ko[Para_0_in].bo_4 = false;
   Global_26_a_168_ko[Para_0_in].bo_5 = false;
   if ( TimeCurrent() - Global_74_lo >  3600 )
   {
     Print(TradeComment + " " + Global_26_a_168_ko[Para_0_in].st_1,": Trading not allowed: got a signal to close all trades!"); 
     Global_74_lo = TimeCurrent() ;
   }
 }
 if ( Global_72_bo )
 {
   Global_26_a_168_ko[Para_0_in].bo_4 = false;
   Global_26_a_168_ko[Para_0_in].bo_5 = false;
   if ( TimeCurrent() - Global_74_lo >  3600 )
   {
     Print(TradeComment + " " + Global_26_a_168_ko[Para_0_in].st_1,": Max DD reached: trading not allowed until restart!"); 
     Global_74_lo = TimeCurrent() ;
   }
 }
 if ( Global_71_in >  0 )
 {
   Global_26_a_168_ko[Para_0_in].bo_4 = false;
   Global_26_a_168_ko[Para_0_in].bo_5 = false;
   if ( TimeCurrent() - Global_74_lo >  3600 )
   {
     Print(TradeComment + " " + Global_26_a_168_ko[Para_0_in].st_1,": Max DD reached: trading is not allowed for ",IntegerToString(Global_71_in,0,32)," hour(s)!"); 
     Global_74_lo = TimeCurrent() ;
   }
 }
 if ( Global_66_bo )
 {
   Global_26_a_168_ko[Para_0_in].bo_4 = false;
   Global_26_a_168_ko[Para_0_in].bo_5 = false;
   if ( TimeCurrent() - Global_74_lo >  3600 )
   {
     Print(TradeComment + " " + Global_26_a_168_ko[Para_0_in].st_1,": Max DD reached: trading not allowed until the end of the day!"); 
     Global_74_lo = TimeCurrent() ;
   }
 }
 Global_73_in = Global_32_in ;
 if ( ( Global_26_a_168_ko[Para_0_in].bo_4 != 0x0 || Global_26_a_168_ko[Para_0_in].bo_5 != 0x0 ) && NewsFilterEnabled && lizong_60(Para_0_in) )
 {
   Global_26_a_168_ko[Para_0_in].bo_4 = false;
   Global_26_a_168_ko[Para_0_in].bo_5 = false;
   Print(TradeComment + " " + Global_26_a_168_ko[Para_0_in].st_1,": ",Global_42_st); 
 }
 lizong_51(Para_0_in); 
 }
//lizong_50 <<==--------   --------
 void lizong_51( int Para_0_in)
 {
  string    Local_1_st;
  double    Local_2_do;
  int       Local_3_in;
  int       Local_4_in;
  int       Local_5_in;
  bool      Local_6_bo;
  double    Local_7_do;
  double    Local_8_do;
  double    Local_9_do;
  long      Local_10_lo;
  double    Local_11_do;
  int       Local_12_in;
  int       Local_13_in;
  bool      Local_14_bo;
  double    Local_15_do;
  double    Local_16_do;
  double    Local_17_do;
  long      Local_18_lo;
  int       Local_19_in;
//----- -----
 int        tmp_in_1;
 int        tmp_in_2;
 int        tmp_in_3;
 bool       tmp_bo_4;
 int        tmp_in_5;
 int        tmp_in_6;
 int        tmp_in_7;
 double     tmp_do_8;
 int        tmp_in_9;
 string     tmp_st_10;
 string     tmp_st_11;
 double     tmp_do_12;
 double     tmp_do_13;
 int        tmp_in_14;
 int        tmp_in_15;
 int        tmp_in_16;
 int        tmp_in_17;
 int        tmp_in_18;
 bool       tmp_bo_19;
 int        tmp_in_20;
 int        tmp_in_21;
 int        tmp_in_22;
 double     tmp_do_23;
 int        tmp_in_24;
 string     tmp_st_25;
 string     tmp_st_26;
 double     tmp_do_27;
 double     tmp_do_28;
 int        tmp_in_29;
 int        tmp_in_30;
 int        tmp_in_31;

 Local_1_st = Global_26_a_168_ko[Para_0_in].st_1 ;
 tmp_in_1 = TerminalInfoInteger(8);
 if ( tmp_in_1 != 0 )
 {
   tmp_in_1 = AccountInfoInteger(ACCOUNT_TRADE_EXPERT);
 }
 if ( tmp_in_1 != 0 )
 {
   tmp_in_1 = MQLInfoInteger(MQL_TRADE_ALLOWED);
 }
 if ( tmp_in_1 == 0 && !(IsTesting()) && IsOptimization() )
 {
   if ( ( Global_26_a_168_ko[Para_0_in].bo_4 != 0x0 || Global_26_a_168_ko[Para_0_in].bo_5 != 0x0 ) )
   {
     Print(TradeComment + " " + Local_1_st,": Trading is not allowed!"); 
   }
   return;
 }
 if ( Global_26_a_168_ko[Para_0_in].bo_4 != 0x0 )
 {
   RefreshRates(); 
   Local_2_do = MarketInfo(Local_1_st,13) ;
   if ( !(lizong_21(Local_1_st,-1,0)) )
   {
     tmp_in_2 = 0;
     for (tmp_in_3 = 0 ; tmp_in_3 < ArraySize(Global_26_a_168_ko) ; tmp_in_3=tmp_in_3 + 1)
     {
       if ( lizong_21(Global_26_a_168_ko[tmp_in_3].st_1,-1,0) )
       {
         tmp_in_2=tmp_in_2 + 1;
       }
     }
     if ( tmp_in_2 <  MaximumSymbols )
     {
       Local_3_in = 0 ;
       Local_4_in = 10 ;
       Local_5_in = 0 ;
       Local_6_bo = false ;
         if(!(IsStopped())){
       do
       {
         RefreshRates(); 
         Local_7_do = MarketInfo(Local_1_st,10) ;
         Local_8_do = lizong_28(Local_1_st,1,lizong_58(Para_0_in,Global_26_a_168_ko[Para_0_in].do_28,1,true,0,0),Global_26_a_168_ko[Para_0_in].do_28) ;
         if ( Local_8_do<Global_29_do )
         {
           Print(TradeComment + " " + Local_1_st,": Sending stopped because los size is too small: ",DoubleToString(Local_8_do,8)); 
           return;
         }
         if ( IsTesting() )
         {
           tmp_bo_4 = true;
         }
         else
         {
           if ( TerminalInfoInteger(6) == 0 )
           {
             Global_26_a_168_ko[Para_0_in].bo_4 = false;
             Global_26_a_168_ko[Para_0_in].bo_5 = false;
             Print(TradeComment + " " + Global_26_a_168_ko[Para_0_in].st_1,": Signal rejected due to absence of network connection!"); 
             tmp_bo_4 = false;
           }
           else
           {
             tmp_bo_4 = true;
           }
         }
         if ( !(tmp_bo_4) && !(IsTesting()) )
         {
           Print(TradeComment + " " + Local_1_st,": No connection to trading server!"); 
           return;
         }
         Local_9_do = AccountFreeMarginCheck(Local_1_st,0,Local_8_do) ;
         if ( Local_9_do<=0.0 )
         {
           Print(TradeComment + " " + Local_1_st,": Not enough money to send a new initial buy order: ",DoubleToString(Local_9_do,2)); 
           Global_26_a_168_ko[Para_0_in].bo_4 = false;
           Local_6_bo = true ;
         }
         else
         {
           Print(TradeComment + " " + Local_1_st,": Sending a new initial buy order, attempt N",IntegerToString(Local_3_in + 1,0,32)); 
           tmp_in_5 = 10;
           tmp_in_6 = MarketInfo(Local_1_st,12);
           if ( tmp_in_6 == 5 )
           {
             tmp_in_5 = 10;
           }
           if ( tmp_in_6 == 4 )
           {
             tmp_in_5 = 1;
           }
           if ( tmp_in_6 == 0x3 )
           {
             tmp_in_5 = 10;
           }
           if ( ( tmp_in_6 == 2 || tmp_in_6 == 1 || tmp_in_6 == 0 ) )
           {
             tmp_in_5 = 1;
           }
           if ( ( Local_2_do<MaximumSpread * tmp_in_5 || MaximumSpread<Global_29_do ) )
           {
             tmp_in_7 = -1;
             tmp_do_8 = 0.0;
             tmp_in_9 = int(MathPow(10.0,StringLen(IntegerToString(Global_28_in + UID,0,32))  + 2)) + (Global_28_in + UID) * 100;
             tmp_st_11 = TradeComment;
             tmp_do_12 = 0.0;
             tmp_do_13 = 0.0;
             tmp_in_14 = 10;
             tmp_in_15 = MarketInfo(Local_1_st,12);
             if ( tmp_in_15 == 5 )
             {
               tmp_in_14 = 10;
             }
             if ( tmp_in_15 == 4 )
             {
               tmp_in_14 = 1;
             }
             if ( tmp_in_15 == 0x3 )
             {
               tmp_in_14 = 10;
             }
             if ( ( tmp_in_15 == 2 || tmp_in_15 == 1 || tmp_in_15 == 0 ) )
             {
               tmp_in_14 = 1;
             }
             OrderSend(Local_1_st,0,Local_8_do,Local_7_do,int(MaximumSlippage * tmp_in_14),tmp_do_13,tmp_do_12,tmp_st_11,tmp_in_9,tmp_do_8,tmp_in_7); 
             Local_10_lo = IsTesting() ;
             if ( Local_10_lo <  0 )
             {
               Local_5_in = GetLastError() ;
               Print(TradeComment + " " + Local_1_st,": Failed to send a new initial buy order. Error:",lizong_11(Local_5_in)); 
               if ( Local_5_in == 4110 && IsTesting() )
               {
                 Local_6_bo = true ;
               }
               if ( Local_5_in == 149 )
               {
                 Local_6_bo = true ;
                 Global_26_a_168_ko[Para_0_in].bo_4 = false;
               }
               if ( ( Local_5_in == 148 || Local_5_in == 139 || Local_5_in == 134 || Local_5_in == 133 || Local_5_in == 128 || Local_5_in == 64 || Local_5_in == 6 || Local_5_in == 4 || Local_5_in == 3 || Local_5_in == 2 || Local_5_in == 1 ) )
               {
                 Local_6_bo = true ;
                 Global_26_a_168_ko[Para_0_in].bo_4 = false;
                 Print(TradeComment + " " + Local_1_st,": Stopped trying to send a new initial buy order due to fatal error!"); 
               }
               Sleep(5000); 
             }
             else
             {
               Print(TradeComment + " " + Local_1_st,": Initial buy trade is opened id: ",IntegerToString(Local_10_lo,0,32)); 
               Local_6_bo = true ;
               Global_26_a_168_ko[Para_0_in].bo_4 = false;
             }
           }
           else
           {
             Print(TradeComment + " " + Local_1_st,": Cannot open a new initial buy trade due to high spread: ",DoubleToString(Local_2_do,2)); 
             Sleep(5000); 
           }
         }
         if ( !(IsTesting()) && !(IsOptimization()) )
         {
           tmp_in_16 = TerminalInfoInteger(8);
           if ( tmp_in_16 != 0 )
           {
             tmp_in_16 = AccountInfoInteger(ACCOUNT_TRADE_EXPERT);
           }
           if ( tmp_in_16 != 0 )
           {
             tmp_in_16 = MQLInfoInteger(MQL_TRADE_ALLOWED);
           }
           if ( tmp_in_16 == 0 )
           {
             Local_6_bo = true ;
           }
         }
         if ( Local_3_in >= Local_4_in )
         {
           Local_6_bo = true ;
         }
         Local_3_in ++;
         if ( IsStopped() )   break;
         
       }
       while(!(Local_6_bo));
       }
     }
   }
 }
 if ( Global_26_a_168_ko[Para_0_in].bo_5 != 0x0 )
 {
   RefreshRates(); 
   Local_11_do = MarketInfo(Local_1_st,13) ;
   if ( !(lizong_21(Local_1_st,-1,0)) )
   {
     tmp_in_17 = 0;
     for (tmp_in_18 = 0 ; tmp_in_18 < ArraySize(Global_26_a_168_ko) ; tmp_in_18=tmp_in_18 + 1)
     {
       if ( lizong_21(Global_26_a_168_ko[tmp_in_18].st_1,-1,0) )
       {
         tmp_in_17=tmp_in_17 + 1;
       }
     }
     if ( tmp_in_17 <  MaximumSymbols )
     {
       Local_12_in = 0 ;
       Local_13_in = 10 ;
       Local_14_bo = false ;
         if(!(IsStopped())){
       do
       {
         RefreshRates(); 
         Local_15_do = MarketInfo(Local_1_st,9) ;
         Local_16_do = lizong_28(Local_1_st,-1,lizong_58(Para_0_in,Global_26_a_168_ko[Para_0_in].do_27,-1,true,0,0),Global_26_a_168_ko[Para_0_in].do_27) ;
         if ( Local_16_do<Global_29_do )
         {
           Print(TradeComment + " " + Local_1_st,": Sending stopped because lot size is too small: ",DoubleToString(Local_16_do,8)); 
           return;
         }
         if ( IsTesting() )
         {
           tmp_bo_19 = true;
         }
         else
         {
           if ( TerminalInfoInteger(6) == 0 )
           {
             Global_26_a_168_ko[Para_0_in].bo_4 = false;
             Global_26_a_168_ko[Para_0_in].bo_5 = false;
             Print(TradeComment + " " + Global_26_a_168_ko[Para_0_in].st_1,": Signal rejected due to absence of network connection!"); 
             tmp_bo_19 = false;
           }
           else
           {
             tmp_bo_19 = true;
           }
         }
         if ( !(tmp_bo_19) && !(IsTesting()) )
         {
           Print(TradeComment + " " + Local_1_st,": No connection to trading server!"); 
           return;
         }
         Local_17_do = AccountFreeMarginCheck(Local_1_st,1,Local_16_do) ;
         if ( Local_17_do<=0.0 )
         {
           Print(TradeComment + " " + Local_1_st,": Not enough money to send a new initial sell order: ",DoubleToString(Local_17_do,2)); 
           Global_26_a_168_ko[Para_0_in].bo_5 = false;
           Local_14_bo = true ;
         }
         else
         {
           Print(TradeComment + " " + Local_1_st,": Sending a new initial sell order, attempt N",IntegerToString(Local_12_in + 1,0,32)); 
           tmp_in_20 = 10;
           tmp_in_21 = MarketInfo(Local_1_st,12);
           if ( tmp_in_21 == 5 )
           {
             tmp_in_20 = 10;
           }
           if ( tmp_in_21 == 4 )
           {
             tmp_in_20 = 1;
           }
           if ( tmp_in_21 == 0x3 )
           {
             tmp_in_20 = 10;
           }
           if ( ( tmp_in_21 == 2 || tmp_in_21 == 1 || tmp_in_21 == 0 ) )
           {
             tmp_in_20 = 1;
           }
           if ( ( Local_11_do<MaximumSpread * tmp_in_20 || MaximumSpread<Global_29_do ) )
           {
             tmp_in_22 = -1;
             tmp_do_23 = 0.0;
             tmp_in_24 = (int(MathPow(10.0,StringLen(IntegerToString(Global_28_in + UID,0,32))  + 2))) * 2 + (Global_28_in + UID) * 100;
             tmp_st_26 = TradeComment;
             tmp_do_27 = 0.0;
             tmp_do_28 = 0.0;
             tmp_in_29 = 10;
             tmp_in_30 = MarketInfo(Local_1_st,12);
             if ( tmp_in_30 == 5 )
             {
               tmp_in_29 = 10;
             }
             if ( tmp_in_30 == 4 )
             {
               tmp_in_29 = 1;
             }
             if ( tmp_in_30 == 0x3 )
             {
               tmp_in_29 = 10;
             }
             if ( ( tmp_in_30 == 2 || tmp_in_30 == 1 || tmp_in_30 == 0 ) )
             {
               tmp_in_29 = 1;
             }
             OrderSend(Local_1_st,1,Local_16_do,Local_15_do,int(MaximumSlippage * tmp_in_29),tmp_do_28,tmp_do_27,tmp_st_26,tmp_in_24,tmp_do_23,tmp_in_22); 
             Local_18_lo = IsTesting() ;
             if ( Local_18_lo <  0 )
             {
               Local_19_in = GetLastError() ;
               Print(TradeComment + " " + Local_1_st,": Failed to send a new initial sell order. Error:",lizong_11(Local_19_in)); 
               if ( Local_19_in == 0x100F && IsTesting() )
               {
                 Local_14_bo = true ;
               }
               if ( Local_19_in == 149 )
               {
                 Local_14_bo = true ;
                 Global_26_a_168_ko[Para_0_in].bo_5 = false;
               }
               if ( ( Local_19_in == 148 || Local_19_in == 0x8B || Local_19_in == 134 || Local_19_in == 133 || Local_19_in == 128 || Local_19_in == 64 || Local_19_in == 6 || Local_19_in == 4 || Local_19_in == 0x3 || Local_19_in == 2 || Local_19_in == 1 ) )
               {
                 Local_14_bo = true ;
                 Global_26_a_168_ko[Para_0_in].bo_5 = false;
                 Print(TradeComment + " " + Local_1_st,": Stopped trying to send a new initial sell order due to fatal error!"); 
               }
               Sleep(5000); 
             }
             else
             {
               Print(TradeComment + " " + Local_1_st,": Initial sell trade is opened, id: ",IntegerToString(Local_18_lo,0,32)); 
               Local_14_bo = true ;
               Global_26_a_168_ko[Para_0_in].bo_5 = false;
             }
           }
           else
           {
             Print(TradeComment + " " + Local_1_st,": Cannot open a new initial sell trade due to high spread: ",DoubleToString(Local_11_do,2)); 
             Sleep(5000); 
           }
         }
         if ( !(IsTesting()) && !(IsOptimization()) )
         {
           tmp_in_31 = TerminalInfoInteger(8);
           if ( tmp_in_31 != 0 )
           {
             tmp_in_31 = AccountInfoInteger(ACCOUNT_TRADE_EXPERT);
           }
           if ( tmp_in_31 != 0 )
           {
             tmp_in_31 = MQLInfoInteger(MQL_TRADE_ALLOWED);
           }
           if ( tmp_in_31 == 0 )
           {
             Local_14_bo = true ;
           }
         }
         if ( Local_12_in >= Local_13_in )
         {
           Local_14_bo = true ;
         }
         Local_12_in ++;
         if ( IsStopped() )   break;
         
       }
       while(!(Local_14_bo));
       }
     }
   }
 }
 }
//lizong_51 <<==--------   --------
 void lizong_52( int Para_0_in,bool Para_1_bo)
 {
  string    Local_1_st;
  string    Local_2_st;
  string    Local_3_st;
//----- -----

 if ( MaximumCurrencies <= 0 )   return;
 
 if ( ( Global_26_a_168_ko[Para_0_in].bo_4 == 0x0 && Global_26_a_168_ko[Para_0_in].bo_5 == 0x0 ) )   return;
 Local_1_st = Global_26_a_168_ko[Para_0_in].st_1 ;
 Local_2_st = "" ;
 Local_3_st = "" ;
 if ( StringLen(Local_1_st)  >= 6 )
 {
   Local_2_st = StringSubstr(Local_1_st,0,3) ;
   Local_3_st = StringSubstr(Local_1_st,3,3) ;
   lizong_61(Local_2_st,Local_3_st); 
   if ( Global_55_in >= MaximumCurrencies )
   {
     Global_26_a_168_ko[Para_0_in].bo_4 = false;
     if ( Para_1_bo && TimeCurrent() - Global_88_lo >  3600 )
     {
       Print(TradeComment + " " + Local_1_st,": Net number(long) of open trades for ",Local_2_st," has reached a specified value!"); 
       Global_88_lo = TimeCurrent() ;
     }
   }
   if ( Global_56_in <=  -(MaximumCurrencies) )
   {
     Global_26_a_168_ko[Para_0_in].bo_4 = false;
     if ( Para_1_bo && TimeCurrent() - Global_89_lo >  3600 )
     {
       Print(TradeComment + " " + Local_1_st,": Net number(short) of open trades for ",Local_3_st," has reached a specified value!"); 
       Global_89_lo = TimeCurrent() ;
     }
   }
   if ( Global_55_in <=  -(MaximumCurrencies) )
   {
     Global_26_a_168_ko[Para_0_in].bo_5 = false;
     if ( Para_1_bo && TimeCurrent() - Global_90_lo >  3600 )
     {
       Print(TradeComment + " " + Local_1_st,": Net number(short) of open trades for ",Local_2_st," has reached a specified value!"); 
       Global_90_lo = TimeCurrent() ;
     }
   }
   if ( Global_56_in >= MaximumCurrencies )
   {
     Global_26_a_168_ko[Para_0_in].bo_5 = false;
     if ( Para_1_bo && TimeCurrent() - Global_91_lo >  3600 )
     {
       Print(TradeComment + " " + Local_1_st,": Net number(long) of open trades for ",Local_3_st," has reached a specified value!"); 
       Global_91_lo = TimeCurrent() ;
     }
   }
 }
 }
//lizong_52 <<==--------   --------
 void lizong_53()
 {
  int       Local_1_in;
  int       Local_2_in;
  int       Local_3_in;
//----- -----
 int        tmp_in_1;
 int        tmp_in_2;
 int        tmp_in_3;
 string     tmp_st_4;
 int        tmp_in_5;
 string     tmp_st_6;
 long       tmp_lo_7;
 long       tmp_lo_8;
 long       tmp_lo_9;
 long       tmp_lo_10;
 int        tmp_in_11;
 long       tmp_lo_12;
 int        tmp_in_13;

 Local_1_in=Minute() + Hour() * 100;
 if ( !(IsTesting()) )
 {
   for (tmp_in_1 = 0 ; tmp_in_1 < ArraySize(Global_26_a_168_ko) ; tmp_in_1=tmp_in_1 + 1)
   {
     iTime(Global_26_a_168_ko[tmp_in_1].st_1,5,0); 
     iTime(Global_26_a_168_ko[tmp_in_1].st_1,1440,0); 
   }
   if ( StockMarketFilterEnabled )
   {
     iTime(StockMarketSymbol,60,0); 
   }
 }
 for (Local_2_in = 0 ; Local_2_in < ArraySize(Global_26_a_168_ko) ; Local_2_in ++)
 {
   if ( ( !(HideTP) && !(HideSL) && ( !(MaximumDrawdown>Global_29_do) || !(MaximumDrawdown<99.99) ) && !(MaximumDrawdownMoney>Global_29_do) && ( !(MaxDailyDrawdownLimitPercentFTMO>Global_29_do) || !(MaxDailyDrawdownLimitPercentFTMO<99.99) ) && !(MaxDailyDrawdownLimitMoneyFTMO>Global_29_do) && (!(MinProfitToCloseTradeBeforeMidnight>Global_29_do) || TimeHour(Global_26_a_168_ko[Local_2_in].da_6) != 23 || TimeMinute(Global_26_a_168_ko[Local_2_in].da_6) < CloseProfitableTradesStartTime) ) )   continue;
   lizong_24(Local_2_in); 
   
 }
 if ( HandleEventsOnEveryTick )
 {
   lizong_45(); 
   if ( MinimumFreeMargin>Global_29_do && AccountInfoDouble(ACCOUNT_MARGIN_LEVEL)<MinimumFreeMargin && AccountInfoDouble(ACCOUNT_MARGIN_LEVEL)>Global_29_do )
   {
     for (tmp_in_2 = 0 ; tmp_in_2 < ArraySize(Global_26_a_168_ko) ; tmp_in_2=tmp_in_2 + 1)
     {
       Global_26_a_168_ko[tmp_in_2].bo_4 = false;
       Global_26_a_168_ko[tmp_in_2].bo_5 = false;
     }
     if ( TimeCurrent() - Global_75_lo >  1800 )
     {
       Print(TradeComment + " " + "->",": Too low account margin level: ",DoubleToString(AccountInfoDouble(ACCOUNT_MARGIN_LEVEL),2),". Trading is not allowed!"); 
       Global_75_lo = TimeCurrent() ;
     }
   }
 }
 if ( Global_30_in != Local_1_in )
 {
   Global_62_bo = false ;
   if ( !(IsTesting()) && CheckForOtherInstances )
   {
     for (tmp_in_3 = 0 ; tmp_in_3 < GlobalVariablesTotal() ; tmp_in_3=tmp_in_3 + 1)
     {
       if ( StringFind(GlobalVariableName(tmp_in_3),Global_67_st,0) == -1 )   continue;
       tmp_st_4 = GlobalVariableName(tmp_in_3);
       StringReplace(tmp_st_4,Global_67_st,""); 
       tmp_in_5 = StringFind(tmp_st_4,"_",0);
       if ( tmp_in_5 == -1 || StringLen(tmp_st_4)  < 3 )   continue;
       tmp_st_6 = StringSubstr(tmp_st_4,0,tmp_in_5);
       tmp_lo_7 = StringToInteger(StringSubstr(tmp_st_4,tmp_in_5 + 1,StringLen(tmp_st_4)  - (tmp_in_5 + 1)));
       tmp_lo_8 = Global_49_ui;
       if ( tmp_lo_7 == tmp_lo_8 )   continue;
       tmp_lo_8 = StringToInteger(tmp_st_6);
       tmp_lo_9 = UID;
       if ( tmp_lo_8 != tmp_lo_9 )   continue;
       tmp_lo_9 = TimeLocal();
       tmp_lo_10=tmp_lo_9 - int(GlobalVariableGet(GlobalVariableName(tmp_in_3)));
       if ( tmp_lo_10 >= 30 )   continue;
       Global_62_bo = true ;
       break;
       
     }
   }
   if ( TimeCurrent() >  Global_31_lo + 60 && !(IsTesting()) )
   {
     OnTimer(); 
   }
   lizong_45(); 
   if ( MinimumFreeMargin>Global_29_do && AccountInfoDouble(ACCOUNT_MARGIN_LEVEL)<MinimumFreeMargin && AccountInfoDouble(ACCOUNT_MARGIN_LEVEL)>Global_29_do )
   {
     for (tmp_in_11 = 0 ; tmp_in_11 < ArraySize(Global_26_a_168_ko) ; tmp_in_11=tmp_in_11 + 1)
     {
       Global_26_a_168_ko[tmp_in_11].bo_4 = false;
       Global_26_a_168_ko[tmp_in_11].bo_5 = false;
     }
     if ( TimeCurrent() - Global_75_lo >  1800 )
     {
       Print(TradeComment + " " + "->",": Too low account margin level: ",DoubleToString(AccountInfoDouble(ACCOUNT_MARGIN_LEVEL),2),". Trading is not allowed!"); 
       Global_75_lo = TimeCurrent() ;
     }
   }
   tmp_lo_12 = TerminalInfoInteger(8);
   if ( tmp_lo_12 != 0 )
   {
     tmp_lo_12 = AccountInfoInteger(ACCOUNT_TRADE_EXPERT);
   }
   if ( tmp_lo_12 != 0 )
   {
     tmp_lo_12 = MQLInfoInteger(MQL_TRADE_ALLOWED);
   }
   if ( ( tmp_lo_12 != 0 || IsTesting() || IsOptimization() ) )
   {
     for (Local_3_in = 0 ; Local_3_in < ArraySize(Global_26_a_168_ko) ; Local_3_in ++)
     {
       if ( !(IsTradeAllowed()) )   continue;
       tmp_in_13 = TerminalInfoInteger(8);
       if ( tmp_in_13 != 0 )
       {
         tmp_in_13 = AccountInfoInteger(ACCOUNT_TRADE_EXPERT);
       }
       if ( tmp_in_13 != 0 )
       {
         tmp_in_13 = MQLInfoInteger(MQL_TRADE_ALLOWED);
       }
       if ( ( tmp_in_13 == 0 && !(IsTesting()) && !(IsOptimization()) ) )   continue;
       lizong_23(Local_3_in); 
       lizong_24(Local_3_in); 
       
     }
   }
   if ( IsVisualMode() )
   {
     lizong_26(false); 
   }
 }
 Global_30_in = Local_1_in ;
 }
//lizong_53 <<==--------   --------
 bool lizong_54( int Para_0_in,long Para_1_lo,int Para_2_in,string Para_3_st,double Para_4_do,long Para_5_lo,double Para_6_do,double Para_7_do,datetime Para_8_da,double Para_9_do,double Para_10_do)
 {
  bool      Local_1_bo;
  double    Local_2_do;
  double    Local_3_do;
  double    Local_4_do;
  int       Local_5_in;
  double    Local_6_do;
  int       Local_7_in;
  double    Local_8_do;
  double    Local_9_do;
  double    Local_10_do;
  int       Local_11_in;
  int       Local_12_in;
  int       Local_13_in;
//----- -----
 int        tmp_in_1;
 int        tmp_in_2;
 int        tmp_in_3;
 int        tmp_in_4;

 RefreshRates(); 
 Local_2_do = MarketInfo(Para_3_st,13) ;
 Local_3_do = MarketInfo(Para_3_st,10) ;
 Local_4_do = MarketInfo(Para_3_st,9) ;
 tmp_in_1 = 10;
 tmp_in_2 = MarketInfo(Para_3_st,12);
 if ( tmp_in_2 == 5 )
 {
   tmp_in_1 = 10;
 }
 if ( tmp_in_2 == 4 )
 {
   tmp_in_1 = 1;
 }
 if ( tmp_in_2 == 3 )
 {
   tmp_in_1 = 10;
 }
 if ( ( tmp_in_2 == 2 || tmp_in_2 == 1 || tmp_in_2 == 0 ) )
 {
   tmp_in_1 = 1;
 }
 Local_5_in = tmp_in_1 ;
 Local_6_do = (MarketInfo(Para_3_st,11)>Global_29_do) ?MarketInfo(Para_3_st,11):0.00001  ;
 Local_7_in = MaximumSlippage * Local_5_in ;
 Local_8_do = MaximumSpread * Local_5_in ;
 Local_9_do = Global_26_a_168_ko[Para_0_in].do_35 * Local_6_do * Local_5_in ;
 Local_10_do = MinProfitToCloseTradeBeforeMidnight * Local_6_do * Local_5_in ;
 Local_11_in = iBarShift(Para_3_st,Global_25_in,Para_8_da,true) ;
 Global_26_a_168_ko[Para_0_in].in_11 = Local_11_in;
 if ( ( ( Local_11_in >  Global_26_a_168_ko[Para_0_in].in_10 && Global_26_a_168_ko[Para_0_in].in_10 != 0x0 ) || ( TimeHour(Global_26_a_168_ko[Para_0_in].da_6) >= FridayExitHour && TimeDayOfWeek(Global_26_a_168_ko[Para_0_in].da_6) == 5 && FridayExitHour != 0 ) || ( HideSL && Local_4_do<lizong_58(Para_0_in,Para_9_do,1,false,Para_7_do,0) ) || ( HideTP && Local_4_do>lizong_59(Para_0_in,Para_9_do,1,false,Para_6_do) - Global_29_do ) || Global_70_bo || ( Global_26_a_168_ko[Para_0_in].in_34 != 0x0 && Global_26_a_168_ko[Para_0_in].do_35>Global_29_do && Local_4_do - Para_9_do>Local_9_do && Local_11_in > Global_26_a_168_ko[Para_0_in].in_34 ) || ( Global_32_in == Global_92_in && Global_92_in < 24 ) || (MinProfitToCloseTradeBeforeMidnight>Global_29_do && TimeHour(Global_26_a_168_ko[Para_0_in].da_6) == 23 && TimeMinute(Global_26_a_168_ko[Para_0_in].da_6) >= CloseProfitableTradesStartTime && Local_4_do - Para_9_do>Local_10_do) ) )
 {
   tmp_in_3 = TimeDayOfWeek(iTime(Para_3_st,lizong_10(5),0));
   if ( tmp_in_3 != TimeDayOfWeek(iTime(Para_3_st,lizong_10(5),1)) && !(HideTP) )
   {
     Print(TradeComment + " " + Para_3_st,": Closing buy trade: " + IntegerToString(Para_1_lo,0,32) + " canceled due to rollover time!"); 
   }
   else
   {
     Print(TradeComment + " " + Para_3_st,": Closing buy trade: " + IntegerToString(Para_1_lo,0,32)); 
     if ( HideSL )
     {
       Local_12_in = 0 ;
       tmp_in_4 = 0;
     }
     if ( HideTP )
     {
       Local_13_in = 0 ;
       tmp_in_3 = 0;
     }
     ResetLastError();
     if ( ( Local_2_do<Local_8_do || MaximumSpread<Global_29_do ) )
     {
       if ( lizong_46(Para_3_st,1,0,Para_9_do,Para_7_do,Para_6_do,0.0,0.0,0.0) )
       {
         if ( !(OrderClose(Para_1_lo,Para_4_do,Local_4_do,Local_7_in,-1)) )
         {
           Print(TradeComment + " " + Para_3_st,": Failed to close buy trade: " + IntegerToString(Para_1_lo,0,32) + ".",lizong_11(GetLastError())); 
           return(true); 
         }
         Print(TradeComment + " " + Para_3_st,": Buy trade: " + IntegerToString(Para_1_lo,0,32) + " successfully closed"); 
         return(true); 
       }
       Print(TradeComment + " " + Para_3_st,": Failed to close sell trade: " + IntegerToString(Para_1_lo,0,32) + ".",lizong_11(GetLastError())); 
       Sleep(1000); 
     }
     else
     {
       Print(TradeComment + " " + Para_3_st,": Cannot close buy trade due to high spread: ",DoubleToString(Local_2_do,2)); 
       Sleep(1000); 
     }
   }
 }
 return(false); 
 }
//lizong_54 <<==--------   --------
 bool lizong_55( int Para_0_in,long Para_1_lo,int Para_2_in,string Para_3_st,double Para_4_do,long Para_5_lo,double Para_6_do,double Para_7_do,datetime Para_8_da,double Para_9_do,double Para_10_do)
 {
  bool      Local_1_bo;
  double    Local_2_do;
  double    Local_3_do;
  double    Local_4_do;
  int       Local_5_in;
  double    Local_6_do;
  int       Local_7_in;
  double    Local_8_do;
  double    Local_9_do;
  double    Local_10_do;
  int       Local_11_in;
  int       Local_12_in;
  int       Local_13_in;
//----- -----
 int        tmp_in_1;
 int        tmp_in_2;
 int        tmp_in_3;
 int        tmp_in_4;

 RefreshRates(); 
 Local_2_do = MarketInfo(Para_3_st,13) ;
 Local_3_do = MarketInfo(Para_3_st,10) ;
 Local_4_do = MarketInfo(Para_3_st,9) ;
 tmp_in_1 = 10;
 tmp_in_2 = MarketInfo(Para_3_st,12);
 if ( tmp_in_2 == 5 )
 {
   tmp_in_1 = 10;
 }
 if ( tmp_in_2 == 4 )
 {
   tmp_in_1 = 1;
 }
 if ( tmp_in_2 == 3 )
 {
   tmp_in_1 = 10;
 }
 if ( ( tmp_in_2 == 2 || tmp_in_2 == 1 || tmp_in_2 == 0 ) )
 {
   tmp_in_1 = 1;
 }
 Local_5_in = tmp_in_1 ;
 Local_6_do = (MarketInfo(Para_3_st,11)>Global_29_do) ?MarketInfo(Para_3_st,11):0.00001  ;
 Local_7_in = MaximumSlippage * Local_5_in ;
 Local_8_do = MaximumSpread * Local_5_in ;
 Local_9_do = Global_26_a_168_ko[Para_0_in].do_35 * Local_6_do * Local_5_in ;
 Local_10_do = MinProfitToCloseTradeBeforeMidnight * Local_6_do * Local_5_in ;
 Local_11_in = iBarShift(Para_3_st,Global_25_in,Para_8_da,true) ;
 Global_26_a_168_ko[Para_0_in].in_11 = Local_11_in;
 if ( ( ( Local_11_in >  Global_26_a_168_ko[Para_0_in].in_10 && Global_26_a_168_ko[Para_0_in].in_10 != 0x0 ) || ( TimeHour(Global_26_a_168_ko[Para_0_in].da_6) >= FridayExitHour && TimeDayOfWeek(Global_26_a_168_ko[Para_0_in].da_6) == 5 && FridayExitHour != 0 ) || ( HideSL && Local_3_do>lizong_58(Para_0_in,Para_9_do,-1,false,Para_7_do,0) ) || ( HideTP && Local_3_do<lizong_59(Para_0_in,Para_9_do,-1,false,Para_6_do) + Global_29_do ) || Global_70_bo || ( Global_26_a_168_ko[Para_0_in].in_34 != 0x0 && Global_26_a_168_ko[Para_0_in].do_35>Global_29_do && Para_9_do - Local_3_do>Local_9_do && Local_11_in > Global_26_a_168_ko[Para_0_in].in_34 ) || ( Global_32_in == Global_92_in && Global_92_in < 24 ) || (MinProfitToCloseTradeBeforeMidnight>Global_29_do && TimeHour(Global_26_a_168_ko[Para_0_in].da_6) == 23 && TimeMinute(Global_26_a_168_ko[Para_0_in].da_6) >= CloseProfitableTradesStartTime && Para_9_do - Local_3_do>Local_10_do) ) )
 {
   tmp_in_3 = TimeDayOfWeek(iTime(Para_3_st,lizong_10(5),0));
   if ( tmp_in_3 != TimeDayOfWeek(iTime(Para_3_st,lizong_10(5),1)) && !(HideTP) )
   {
     Print(TradeComment + " " + Para_3_st,": Closing sell trade: " + IntegerToString(Para_1_lo,0,32) + " canceled due to rollover time!"); 
   }
   else
   {
     Print(TradeComment + " " + Para_3_st,": Closing sell trade: " + IntegerToString(Para_1_lo,0,32)); 
     if ( HideSL )
     {
       Local_12_in = 0 ;
       tmp_in_4 = 0;
     }
     if ( HideTP )
     {
       Local_13_in = 0 ;
       tmp_in_3 = 0;
     }
     ResetLastError();
     if ( ( Local_2_do<Local_8_do || MaximumSpread<Global_29_do ) )
     {
       if ( lizong_46(Para_3_st,1,1,Para_9_do,Para_7_do,Para_6_do,0.0,0.0,0.0) )
       {
         if ( !(OrderClose(Para_1_lo,Para_4_do,Local_3_do,Local_7_in,-1)) )
         {
           Print(TradeComment + " " + Para_3_st,": Failed to close sell trade: " + IntegerToString(Para_1_lo,0,32) + ".",lizong_11(GetLastError())); 
           return(true); 
         }
         Print(TradeComment + " " + Para_3_st,": Sell trade: " + IntegerToString(Para_1_lo,0,32) + " successfully closed"); 
         return(true); 
       }
       Print(TradeComment + " " + Para_3_st,": Failed to close sell trade: " + IntegerToString(Para_1_lo,0,32) + ".",lizong_11(GetLastError())); 
       Sleep(1000); 
     }
     else
     {
       Print(TradeComment + " " + Para_3_st,": Cannot close sell trade due to high spread: ",DoubleToString(Local_2_do,2)); 
       Sleep(1000); 
     }
   }
 }
 return(false); 
 }
//lizong_55 <<==--------   --------
 void lizong_56( int Para_0_in,long Para_1_lo,int Para_2_in,string Para_3_st,double Para_4_do,double Para_5_do,double Para_6_do,double Para_7_do,double Para_8_do,double Para_9_do,double Para_10_do)
 {
  double    Local_1_do = 0.0;
  double    Local_2_do = 0.0;
  int       Local_3_in;
  double    Local_4_do;
  double    Local_5_do;
  double    Local_6_do;
  bool      Local_7_bo;
  int       Local_8_in;
//----- -----
 double     tmp_do_1;
 double     tmp_do_2;
 double     tmp_do_3;
 double     tmp_do_4;
 double     tmp_do_5;

 Local_2_do = lizong_59(Para_0_in,Para_9_do,1,false,Para_6_do) ;
 Local_1_do = lizong_58(Para_0_in,Para_9_do,1,false,Para_7_do,Para_10_do) ;
 for (Local_3_in = 0 ; Local_3_in < 5 ; Local_3_in ++)
 {
   RefreshRates(); 
   Local_4_do = MarketInfo(Para_3_st,13) ;
   tmp_do_1 = MarketInfo(Para_3_st,14);
   if ( MarketInfo(Para_3_st,11)>Global_29_do )
   {
     tmp_do_2 = MarketInfo(Para_3_st,11);
   }
   else
   {
     tmp_do_2 = 0.00001;
   }
   Local_5_do = tmp_do_1 * tmp_do_2 ;
   tmp_do_1 = MarketInfo(Para_3_st,33);
   if ( MarketInfo(Para_3_st,11)>Global_29_do )
   {
     tmp_do_3 = MarketInfo(Para_3_st,11);
   }
   else
   {
     tmp_do_3 = 0.00001;
   }
   Local_6_do = tmp_do_1 * tmp_do_3 ;
   if ( Local_1_do>Global_29_do )
   {
     if ( Local_5_do>Global_29_do && Para_7_do<Global_29_do )
     {
       Local_1_do = MathMin(MarketInfo(Para_3_st,9) - Local_5_do,Local_1_do) ;
     }
     if ( Local_5_do<Global_29_do )
     {
       Local_1_do = MathMin(MarketInfo(Para_3_st,9),Local_1_do) ;
     }
   }
   if ( Local_2_do>Global_29_do )
   {
     if ( Local_5_do>Global_29_do && Para_6_do<Global_29_do )
     {
       Local_2_do = MathMax(MarketInfo(Para_3_st,9) + Local_5_do,Local_2_do) ;
     }
     if ( Local_5_do<Global_29_do )
     {
       Local_2_do = MathMax(MarketInfo(Para_3_st,9),Local_2_do) ;
     }
   }
   if ( HideSL )
   {
     Local_1_do = 0.0 ;
   }
   if ( HideTP )
   {
     Local_2_do = 0.0 ;
   }
   Local_7_bo = true ;
   if ( Local_2_do<Global_29_do && !(RemoveTakeProfit) && !(HideTP) )
   {
     Local_7_bo = false ;
   }
   if ( Local_1_do<Global_29_do && !(HideSL) )
   {
     Local_7_bo = false ;
   }
   if ( ( !(MathAbs(Para_6_do - Local_2_do)>=((MarketInfo(Para_3_st,11)>Global_29_do) ?MarketInfo(Para_3_st,11):0.00001 ) * 2.0) && !(MathAbs(Para_7_do - Local_1_do)>=((MarketInfo(Para_3_st,11)>Global_29_do) ?MarketInfo(Para_3_st,11):0.00001 ) * 2.0) ) || !(Local_7_bo) )   continue;
   
   if ( MarketInfo(Para_3_st,11)>Global_29_do )
   {
     tmp_do_4 = MarketInfo(Para_3_st,11);
   }
   else
   {
     tmp_do_4 = 0.00001;
   }
   if ( MathAbs(Para_6_do - Local_2_do)<=tmp_do_4 )
   {
     Local_2_do = Para_6_do ;
   }
   if ( MarketInfo(Para_3_st,11)>Global_29_do )
   {
     tmp_do_5 = MarketInfo(Para_3_st,11);
   }
   else
   {
     tmp_do_5 = 0.00001;
   }
   if ( MathAbs(Para_7_do - Local_1_do)<=tmp_do_5 )
   {
     Local_1_do = Para_7_do ;
   }
   if ( HideSL )
   {
     Local_1_do = 0.0 ;
   }
   if ( HideTP )
   {
     Local_2_do = 0.0 ;
   }
   Local_1_do = NormalizeDouble(Local_1_do,MarketInfo(Global_26_a_168_ko[Para_0_in].st_1,12)) ;
   Local_2_do = NormalizeDouble(Local_2_do,MarketInfo(Global_26_a_168_ko[Para_0_in].st_1,12)) ;
   if ( lizong_46(Para_3_st,3,0,Para_9_do,Para_7_do,Para_6_do,Para_9_do,Local_1_do,Local_2_do) )
   {
     Print(TradeComment + " " + Para_3_st,": Modifying buy trade: " + IntegerToString(Para_1_lo,0,32) + ", attempt N",IntegerToString(Local_3_in + 1,0,32)); 
     if ( !(OrderModify(Para_1_lo,Para_9_do,Local_1_do,Local_2_do,0,16711680)) )
     {
       Local_8_in = GetLastError() ;
       Print(TradeComment + " " + Para_3_st,": Failed to modify buy trade: " + IntegerToString(Para_1_lo,0,32) + ".",lizong_11(Local_8_in)); 
       if ( Local_8_in == 4108 )
       {
         Print(TradeComment + " " + Para_3_st,": The EA has stopped trying to modify BUY order"); 
         return;
       }
       Sleep(5000); 
       if ( ( Local_8_in != 132 && Local_8_in != 10018 && Local_8_in != 4756 ) )   continue;
       Sleep(15000); 
        continue;
     }
     Print(TradeComment + " " + Para_3_st,": Buy trade: " + IntegerToString(Para_1_lo,0,32) + " successfully modified"); 
     return;
   }
   Sleep(5000); 
   
 }
 }
//lizong_56 <<==--------   --------
 void lizong_57( int Para_0_in,long Para_1_lo,int Para_2_in,string Para_3_st,double Para_4_do,double Para_5_do,double Para_6_do,double Para_7_do,double Para_8_do,double Para_9_do,double Para_10_do)
 {
  double    Local_1_do = 0.0;
  double    Local_2_do = 0.0;
  int       Local_3_in;
  double    Local_4_do;
  double    Local_5_do;
  double    Local_6_do;
  bool      Local_7_bo;
  int       Local_8_in;
//----- -----
 double     tmp_do_1;
 double     tmp_do_2;
 double     tmp_do_3;
 double     tmp_do_4;
 double     tmp_do_5;

 Local_2_do = lizong_59(Para_0_in,Para_9_do,-1,false,Para_6_do) ;
 Local_1_do = lizong_58(Para_0_in,Para_9_do,-1,false,Para_7_do,Para_10_do) ;
 for (Local_3_in = 0 ; Local_3_in < 5 ; Local_3_in ++)
 {
   RefreshRates(); 
   Local_4_do = MarketInfo(Para_3_st,13) ;
   tmp_do_1 = MarketInfo(Para_3_st,14);
   if ( MarketInfo(Para_3_st,11)>Global_29_do )
   {
     tmp_do_2 = MarketInfo(Para_3_st,11);
   }
   else
   {
     tmp_do_2 = 0.00001;
   }
   Local_5_do = tmp_do_1 * tmp_do_2 ;
   tmp_do_1 = MarketInfo(Para_3_st,33);
   if ( MarketInfo(Para_3_st,11)>Global_29_do )
   {
     tmp_do_3 = MarketInfo(Para_3_st,11);
   }
   else
   {
     tmp_do_3 = 0.00001;
   }
   Local_6_do = tmp_do_1 * tmp_do_3 ;
   if ( Local_1_do>Global_29_do )
   {
     if ( Local_5_do>Global_29_do && Para_7_do<Global_29_do )
     {
       Local_1_do = MathMax(MarketInfo(Para_3_st,10) + Local_5_do,Local_1_do) ;
     }
     if ( Local_5_do<Global_29_do )
     {
       Local_1_do = MathMax(MarketInfo(Para_3_st,10),Local_1_do) ;
     }
   }
   if ( Local_2_do>Global_29_do )
   {
     if ( Local_5_do>Global_29_do && Para_6_do<Global_29_do )
     {
       Local_2_do = MathMin(MarketInfo(Para_3_st,10) - Local_5_do,Local_2_do) ;
     }
     if ( Local_5_do<Global_29_do )
     {
       Local_2_do = MathMin(MarketInfo(Para_3_st,10),Local_2_do) ;
     }
   }
   if ( HideSL )
   {
     Local_1_do = 0.0 ;
   }
   if ( HideTP )
   {
     Local_2_do = 0.0 ;
   }
   Local_7_bo = true ;
   if ( Local_2_do<Global_29_do && !(RemoveTakeProfit) && !(HideTP) )
   {
     Local_7_bo = false ;
   }
   if ( Local_1_do<Global_29_do && !(HideSL) )
   {
     Local_7_bo = false ;
   }
   if ( ( !(MathAbs(Para_6_do - Local_2_do)>=((MarketInfo(Para_3_st,11)>Global_29_do) ?MarketInfo(Para_3_st,11):0.00001 ) * 2.0) && !(MathAbs(Para_7_do - Local_1_do)>=((MarketInfo(Para_3_st,11)>Global_29_do) ?MarketInfo(Para_3_st,11):0.00001 ) * 2.0) ) || !(Local_7_bo) )   continue;
   
   if ( MarketInfo(Para_3_st,11)>Global_29_do )
   {
     tmp_do_4 = MarketInfo(Para_3_st,11);
   }
   else
   {
     tmp_do_4 = 0.00001;
   }
   if ( MathAbs(Para_6_do - Local_2_do)<=tmp_do_4 )
   {
     Local_2_do = Para_6_do ;
   }
   if ( MarketInfo(Para_3_st,11)>Global_29_do )
   {
     tmp_do_5 = MarketInfo(Para_3_st,11);
   }
   else
   {
     tmp_do_5 = 0.00001;
   }
   if ( MathAbs(Para_7_do - Local_1_do)<=tmp_do_5 )
   {
     Local_1_do = Para_7_do ;
   }
   if ( HideSL )
   {
     Local_1_do = 0.0 ;
   }
   if ( HideTP )
   {
     Local_2_do = 0.0 ;
   }
   Local_1_do = NormalizeDouble(Local_1_do,MarketInfo(Global_26_a_168_ko[Para_0_in].st_1,12)) ;
   Local_2_do = NormalizeDouble(Local_2_do,MarketInfo(Global_26_a_168_ko[Para_0_in].st_1,12)) ;
   if ( lizong_46(Para_3_st,3,1,Para_9_do,Para_7_do,Para_6_do,Para_9_do,Local_1_do,Local_2_do) )
   {
     Print(TradeComment + " " + Para_3_st,": Modifying sell trade: " + IntegerToString(Para_1_lo,0,32) + ", attempt N",IntegerToString(Local_3_in + 1,0,32)); 
     if ( !(OrderModify(Para_1_lo,Para_9_do,Local_1_do,Local_2_do,0,255)) )
     {
       Local_8_in = GetLastError() ;
       Print(TradeComment + " " + Para_3_st,": Failed to modify sell trade: " + IntegerToString(Para_1_lo,0,32) + ".",lizong_11(Local_8_in)); 
       if ( Local_8_in == 4108 )
       {
         Print(TradeComment + " " + Para_3_st,": The EA has stopped trying to modify BUY order"); 
         return;
       }
       Sleep(5000); 
       if ( ( Local_8_in != 132 && Local_8_in != 10018 && Local_8_in != 4756 ) )   continue;
       Sleep(15000); 
        continue;
     }
     Print(TradeComment + " " + Para_3_st,": Sell trade: " + IntegerToString(Para_1_lo,0,32) + " successfully modified"); 
     return;
   }
   Sleep(5000); 
   
 }
 }
//lizong_57 <<==--------   --------
 double lizong_58( int Para_0_in,double Para_1_do,int Para_2_in,int Para_3_in,double Para_4_do,double Para_5_do)
 {
  double    Local_1_do;
  string    Local_2_st;
  double    Local_3_do;
  double    Local_4_do;
  int       Local_5_in;
  double    Local_6_do;
  double    Local_7_do;
  double    Local_8_do;
  double    Local_9_do;
//----- -----
 int        tmp_in_1;
 int        tmp_in_2;

 Local_2_st = Global_26_a_168_ko[Para_0_in].st_1 ;
 RefreshRates(); 
 Local_3_do = 0.0 ;
 Local_4_do = 500.0 ;
 tmp_in_1 = 10;
 tmp_in_2 = MarketInfo(Local_2_st,12);
 if ( tmp_in_2 == 5 )
 {
   tmp_in_1 = 10;
 }
 if ( tmp_in_2 == 4 )
 {
   tmp_in_1 = 1;
 }
 if ( tmp_in_2 == 3 )
 {
   tmp_in_1 = 10;
 }
 if ( ( tmp_in_2 == 2 || tmp_in_2 == 1 || tmp_in_2 == 0 ) )
 {
   tmp_in_1 = 1;
 }
 Local_5_in = tmp_in_1 ;
 Local_6_do = (MarketInfo(Local_2_st,11)>Global_29_do) ?MarketInfo(Local_2_st,11):0.00001  ;
 Local_7_do = Global_26_a_168_ko[Para_0_in].do_22 ;
 Local_8_do = (Local_7_do + Global_60_do) * Local_6_do * Local_5_in ;
 if ( Stop_Loss>Global_29_do )
 {
   Local_8_do = (Stop_Loss + Global_60_do) * Local_6_do * Local_5_in ;
 }
 if ( Stop_Loss_ATR>Global_29_do && Global_26_a_168_ko[Para_0_in].do_43>Global_29_do )
 {
   Local_8_do = Stop_Loss_ATR / 100.0 * Global_26_a_168_ko[Para_0_in].do_43 + Global_60_do * Local_6_do * Local_5_in ;
 }
 if ( IncreaseStopLoss>Global_29_do && ( ( Global_32_in == 23 && Minute() >= RolloverStartTime ) || (Global_32_in == 0 && Minute() <= RolloverEndTime) ) )
 {
   Local_8_do = IncreaseStopLoss * Local_6_do * Local_5_in + Local_8_do ;
 }
 if ( Local_8_do<Global_29_do )
 {
   Local_8_do = Local_4_do * Local_6_do * Local_5_in ;
 }
 if ( Para_2_in == 1 )
 {
   Local_3_do = NormalizeDouble(Para_1_do - Local_8_do,MarketInfo(Global_26_a_168_ko[Para_0_in].st_1,12)) ;
   if ( Global_26_a_168_ko[Para_0_in].do_8>Global_29_do && Para_1_do - Local_3_do>Para_1_do * 0.5 && Local_6_do>0.0 )
   {
     Local_3_do = NormalizeDouble(Para_1_do - Para_1_do * 0.5,MarketInfo(Global_26_a_168_ko[Para_0_in].st_1,12)) ;
   }
 }
 if ( Para_2_in == -1 )
 {
   Local_3_do = NormalizeDouble(Para_1_do + Local_8_do,MarketInfo(Global_26_a_168_ko[Para_0_in].st_1,12)) ;
   if ( Global_26_a_168_ko[Para_0_in].do_8>Global_29_do && Local_3_do - Para_1_do>Para_1_do * 0.5 && Local_6_do>0.0 )
   {
     Local_3_do = NormalizeDouble(Para_1_do + Para_1_do * 0.5,MarketInfo(Global_26_a_168_ko[Para_0_in].st_1,12)) ;
   }
 }
 Local_9_do = SymbolInfoDouble(Local_2_st,27) ;
 if ( Local_9_do>0.0 )
 {
   Local_3_do = MathRound(Local_3_do / Local_9_do) * Local_9_do ;
   Local_3_do = NormalizeDouble(Local_3_do,MarketInfo(Global_26_a_168_ko[Para_0_in].st_1,12)) ;
 }
 return(Local_3_do); 
 }
//lizong_58 <<==--------   --------
 double lizong_59( int Para_0_in,double Para_1_do,int Para_2_in,int Para_3_in,double Para_4_do)
 {
  double    Local_1_do;
  string    Local_2_st;
  double    Local_3_do;
  double    Local_4_do;
  int       Local_5_in;
  double    Local_6_do;
  double    Local_7_do;
  double    Local_8_do;
  double    Local_9_do;
  double    Local_10_do;
//----- -----
 int        tmp_in_1;
 int        tmp_in_2;

 Local_2_st = Global_26_a_168_ko[Para_0_in].st_1 ;
 RefreshRates(); 
 Local_3_do = 0.0 ;
 Local_4_do = Global_26_a_168_ko[Para_0_in].do_31 ;
 tmp_in_1 = 10;
 tmp_in_2 = MarketInfo(Local_2_st,12);
 if ( tmp_in_2 == 5 )
 {
   tmp_in_1 = 10;
 }
 if ( tmp_in_2 == 4 )
 {
   tmp_in_1 = 1;
 }
 if ( tmp_in_2 == 3 )
 {
   tmp_in_1 = 10;
 }
 if ( ( tmp_in_2 == 2 || tmp_in_2 == 1 || tmp_in_2 == 0 ) )
 {
   tmp_in_1 = 1;
 }
 Local_5_in = tmp_in_1 ;
 Local_6_do = (MarketInfo(Local_2_st,11)>Global_29_do) ?MarketInfo(Local_2_st,11):0.00001  ;
 Local_7_do = (Global_26_a_168_ko[Para_0_in].do_26 + Global_59_do) * Local_6_do * Local_5_in ;
 Local_8_do = Global_26_a_168_ko[Para_0_in].do_23 * Local_6_do * Local_5_in ;
 Local_9_do = Global_26_a_168_ko[Para_0_in].do_42 * Local_6_do * Local_5_in ;
 if ( Para_2_in == 1 )
 {
   Local_3_do = NormalizeDouble(Local_4_do - Local_7_do,MarketInfo(Global_26_a_168_ko[Para_0_in].st_1,12)) ;
   if ( Global_26_a_168_ko[Para_0_in].do_23>Global_29_do && Global_26_a_168_ko[Para_0_in].do_8>Global_29_do && Local_3_do - Para_1_do>Local_8_do && Local_6_do>0.0 )
   {
     Local_3_do = NormalizeDouble(Para_1_do + Local_8_do,MarketInfo(Global_26_a_168_ko[Para_0_in].st_1,12)) ;
   }
   Local_3_do = NormalizeDouble(Local_3_do + Local_9_do,MarketInfo(Global_26_a_168_ko[Para_0_in].st_1,12)) ;
   if ( Global_26_a_168_ko[Para_0_in].do_8>Global_29_do && Local_3_do - Para_1_do>Para_1_do * 0.5 && Local_6_do>0.0 )
   {
     Local_3_do = NormalizeDouble(Para_1_do + Para_1_do * 0.5,MarketInfo(Global_26_a_168_ko[Para_0_in].st_1,12)) ;
   }
 }
 if ( Para_2_in == -1 )
 {
   Local_3_do = NormalizeDouble(Local_4_do + Local_7_do,MarketInfo(Global_26_a_168_ko[Para_0_in].st_1,12)) ;
   if ( Global_26_a_168_ko[Para_0_in].do_23>Global_29_do && Global_26_a_168_ko[Para_0_in].do_8>Global_29_do && Para_1_do - Local_3_do>Local_8_do && Local_6_do>0.0 )
   {
     Local_3_do = NormalizeDouble(Para_1_do - Local_8_do,MarketInfo(Global_26_a_168_ko[Para_0_in].st_1,12)) ;
   }
   Local_3_do = NormalizeDouble(Local_3_do - Local_9_do,MarketInfo(Global_26_a_168_ko[Para_0_in].st_1,12)) ;
   if ( Global_26_a_168_ko[Para_0_in].do_8>Global_29_do && Para_1_do - Local_3_do>Para_1_do * 0.5 && Local_6_do>0.0 )
   {
     Local_3_do = NormalizeDouble(Para_1_do - Para_1_do * 0.5,MarketInfo(Global_26_a_168_ko[Para_0_in].st_1,12)) ;
   }
 }
 Local_10_do = SymbolInfoDouble(Local_2_st,27) ;
 if ( Local_10_do>0.0 )
 {
   Local_3_do = MathRound(Local_3_do / Local_10_do) * Local_10_do ;
   Local_3_do = NormalizeDouble(Local_3_do,MarketInfo(Global_26_a_168_ko[Para_0_in].st_1,12)) ;
 }
 if ( RemoveTakeProfit && ( ( Global_32_in == 23 && Minute() >= RolloverStartTime ) || (Global_32_in == 0 && Minute() <= RolloverEndTime) ) )
 {
   Local_3_do = 0.0 ;
 }
 return(Local_3_do); 
 }
//lizong_59 <<==--------   --------
 bool lizong_60( int Para_0_in)
 {
  bool      Local_1_bo;
  int       Local_2_in;
  datetime  Local_3_da;
  string    Local_4_st;
  int       Local_5_in;
  datetime  Local_6_da;
  string    Local_7_st;
  string    Local_8_st;
  short     Local_9_sh;
  string    Local_10_st_ko[];
  int       Local_11_in;
  int       Local_12_in;
//----- -----

 if ( ( WaitMinutesAfterEvent == 0 || WaitMinutesBeforeEvent == 0 ) )
 {
   return(false); 
 }
 if ( ( Global_35_in == -999 || Global_37_lo == 0 ) )
 {
   Print(TradeComment + " " + Global_26_a_168_ko[Para_0_in].st_1,": Problem with the news filter: GMT is not defined!"); 
   return(false); 
 }
 if ( ( Global_40_in == 0 || Global_41_da == 0 ) )
 {
   return(false); 
 }
 if ( DisableTradingOnHolidays )
 {
   for (Local_2_in = 0 ; Local_2_in < Global_40_in ; Local_2_in ++)
   {
     Local_3_da = StringToTime(TimeToString(StringToTime(StringSubstr(Global_39_st_kosi4[Local_2_in][0],0,4) + "." + StringSubstr(Global_39_st_kosi4[Local_2_in][0],5,2) + "." + StringSubstr(Global_39_st_kosi4[Local_2_in][0],8,2) + " " + StringSubstr(Global_39_st_kosi4[Local_2_in][0],11,2) + ":" + StringSubstr(Global_39_st_kosi4[Local_2_in][0],14,4)) + Global_35_in * 60 * 60,1) + " 00:00") ;
     Local_4_st = Global_39_st_kosi4[Local_2_in][1] ;
     StringToLower(Local_4_st); 
     if ( ( Local_3_da == StringToTime(TimeToString(TimeCurrent(),1) + " 00:00") || Local_3_da == StringToTime(TimeToString(TimeCurrent() - 21600,1) + " 00:00") ) && Global_39_st_kosi4[Local_2_in][2] == "Holiday" && StringFind(Global_26_a_168_ko[Para_0_in].st_41 + "usd",Local_4_st,0) != -1 )
     {
       Global_42_st = "Signal is skipped. Trading is not allowed at this bar/time because of Holiday -> " + Global_39_st_kosi4[Local_2_in][3] + " - " + TimeToString(Local_3_da,5) + " - " + Global_39_st_kosi4[Local_2_in][1] ;
       return(true); 
     }
   }
 }
 for (Local_5_in = 0 ; Local_5_in < Global_40_in ; Local_5_in ++)
 {
   Local_6_da=StringToTime(StringSubstr(Global_39_st_kosi4[Local_5_in][0],0,4) + "." + StringSubstr(Global_39_st_kosi4[Local_5_in][0],5,2) + "." + StringSubstr(Global_39_st_kosi4[Local_5_in][0],8,2) + " " + StringSubstr(Global_39_st_kosi4[Local_5_in][0],11,2) + ":" + StringSubstr(Global_39_st_kosi4[Local_5_in][0],14,4)) + Global_35_in * 60 * 60;
   Local_7_st = Global_39_st_kosi4[Local_5_in][1] ;
   Local_8_st = Global_39_st_kosi4[Local_5_in][3] ;
   StringToLower(Local_7_st); 
   StringToLower(Local_8_st); 
   if ( Local_6_da >= TimeCurrent() - WaitMinutesAfterEvent * 60 && Local_6_da <= TimeCurrent() + WaitMinutesBeforeEvent * 60 && Global_39_st_kosi4[Local_5_in][2] != "Holiday" )
   {
     if ( StringFind(Global_26_a_168_ko[Para_0_in].st_41,Local_7_st,0) != -1 )
     {
       Global_42_st = "Signal is skipped. Trading is not allowed at this bar/time because of " + Global_39_st_kosi4[Local_5_in][3] + " - " + TimeToString(Local_6_da,5) + " - " + Global_39_st_kosi4[Local_5_in][1] ;
       return(true); 
     }
     Local_9_sh = StringGetCharacter(",",0) ;
     Local_11_in = StringSplit(Global_26_a_168_ko[Para_0_in].st_41,Local_9_sh,Local_10_st_ko) ;
     for (Local_12_in = 0 ; Local_12_in < Local_11_in ; Local_12_in ++)
     {
       if ( StringFind(Local_8_st,Local_10_st_ko[Local_12_in],0) != -1 )
       {
         Global_42_st = "Signal is skipped. Trading is not allowed at this bar/time because of " + Global_39_st_kosi4[Local_5_in][3] + " - " + TimeToString(Local_6_da,5) + " - " + Global_39_st_kosi4[Local_5_in][1] ;
         return(true); 
       }
     }
   }
 }
 return(false); 
 }
//lizong_60 <<==--------   --------
 void lizong_61( string Para_0_st,string Para_1_st)
 {
  int       Local_1_in;
  int       Local_2_in;
  int       Local_3_in;
  int       Local_4_in;
  int       Local_5_in;
  int       Local_6_in;
  string    Local_7_st;
  int       Local_8_in;
  int       Local_9_in;
//----- -----

 Global_55_in = 0 ;
 Global_56_in = 0 ;
 Local_1_in=Global_28_in + UID;
 Local_2_in=StringLen(IntegerToString(Local_1_in,0,32)); 
 Local_3_in=Local_1_in + int(MathPow(10.0,Local_2_in));
 Local_4_in=Local_1_in + int(MathPow(10.0,Local_2_in)) * 2;
 for (Local_5_in = 0 ; Local_5_in < OrdersTotal() ; Local_5_in ++)
 {
   if ( OrderSelect(Local_5_in,0,0) )
   {
     Local_6_in = OrderType() ;
     Local_7_st = OrderSymbol() ;
     Local_8_in = OrderMagicNumber() ;
     Local_9_in=Local_8_in / 100;
     if ( Local_6_in == 0 && Local_3_in == Local_9_in )
     {
       if ( StringFind(Local_7_st,Para_0_st,0) == 0 )
       {
         Global_55_in ++;
       }
       if ( StringFind(Local_7_st,Para_0_st,0) == 3 )
       {
         Global_55_in --;
       }
       if ( StringFind(Local_7_st,Para_1_st,0) == 0 )
       {
         Global_56_in ++;
       }
       if ( StringFind(Local_7_st,Para_1_st,0) == 3 )
       {
         Global_56_in --;
       }
     }
     if ( Local_6_in == 1 && Local_4_in == Local_9_in )
     {
       if ( StringFind(Local_7_st,Para_0_st,0) == 0 )
       {
         Global_55_in --;
       }
       if ( StringFind(Local_7_st,Para_0_st,0) == 3 )
       {
         Global_55_in ++;
       }
       if ( StringFind(Local_7_st,Para_1_st,0) == 0 )
       {
         Global_56_in --;
       }
       if ( StringFind(Local_7_st,Para_1_st,0) == 3 )
       {
         Global_56_in ++;
       }
     }
   }
   else
   {
     Print(TradeComment + " " + "------",": Failed to select an order! Error=",lizong_11(GetLastError())); 
   }
 }
 }


