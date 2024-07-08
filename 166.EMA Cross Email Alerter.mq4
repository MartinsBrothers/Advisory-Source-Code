//+------------------------------------------------------------------+
//|                                  166.EMA Cross Email Alerter.mq4 |
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
input int _Fast_EMA_Period = 14;			// Fast EMA Period
input int _Slow_EMA_Period = 50;			// Slow EMA Period

//Global declaration

int init() {

   return(0);
}

int start() {

   
   //Local declaration
   if( ((iMA(Symbol(), 0, _Fast_EMA_Period, 0, 1, 0, 0) > iMA(Symbol(), 0, _Slow_EMA_Period, 0, 1, 0, 0)) && 
   (iMA(Symbol(), 0, _Fast_EMA_Period, 0, 1, 0, 1) < iMA(Symbol(), 0, _Slow_EMA_Period, 0, 1, 0, 1)) && 
   (Volume[0] == 1)) ) SendMail( "EMA Cross", "Fast EMA has crossed above the slow" );
   if( ((iMA(Symbol(), 0, _Fast_EMA_Period, 0, 1, 0, 1) > iMA(Symbol(), 0, _Slow_EMA_Period, 0, 1, 0, 1)) && 
   (iMA(Symbol(), 0, _Fast_EMA_Period, 0, 1, 0, 0) < iMA(Symbol(), 0, _Slow_EMA_Period, 0, 1, 0, 0)) && 
   (Volume[0] == 1)) ) SendMail( "EMA Cross", "Fast EMA has cross below the slow" );

   return(0);
}
        
