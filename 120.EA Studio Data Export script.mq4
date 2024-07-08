//+------------------------------------------------------------------+
//|                             120.EA Studio Data Export script.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
//
// EA Studio Data Export
// Copyright 2018, Forex Software Ltd.
//
// Use this script in MT4 to export historical files for Expert Advisor Studio
// The files are saved in the MT5's \MQL4\Files folder with .json extension.
// Drag and drop the files in the Tools -> Data Import drop box.
//

#property copyright "Forex Software Ltd."
#property version   "3.3"
#property strict
#property show_inputs

static input int    Maximum_Bars = 100000; // Maximum count of bars
static input int    Spread       = 0;      // Spread [points] (0 - current)
static input double Commission   = 10;     // Commission in currency

// Commission in currency per lot. It is normally used by the ECN brokers.
// Example: 10 - it means 5 USD for the entry and 5 USD for the exit per round lot.

ENUM_TIMEFRAMES periods[] = {PERIOD_M1, PERIOD_M5, PERIOD_M15, PERIOD_M30, PERIOD_H1, PERIOD_H4, PERIOD_D1};
string comment = "";

void OnStart()
{
    const ENUM_INIT_RETCODE initRetcode = ValidateInit();

    if (initRetcode == INIT_FAILED) return;

    RefreshRates();
    for (int p = 0; p < ArraySize(periods); p++)
    {
        string fileName = _Symbol + PeriodToStr(periods[p]) + ".json";
        string data     = GetSymbolData(_Symbol, periods[p]);
        SaveFile(fileName, data);
    }
}

string GetSymbolData(string symbol, ENUM_TIMEFRAMES period)
{
    string name         = symbol;
    int    digits       = (int) SymbolInfoInteger(symbol, SYMBOL_DIGITS);
    int    maxBars      = MathMin(TerminalInfoInteger(TERMINAL_MAXBARS), Maximum_Bars);
    string server       = AccountInfoString(ACCOUNT_SERVER);
    string company      = AccountInfoString(ACCOUNT_COMPANY);
    string terminal     = TerminalInfoString(TERMINAL_NAME);
    string baseCurrency = StringSubstr(symbol, 0, 3);
    string priceIn      = StringSubstr(symbol, 3, 3);
    int    spread       = GetSpread();

    if (server == "")
    {
        server = "Unknown";
    }

    MqlRates rates[]; ArraySetAsSeries(rates,true);

    int bars = 0;
    if (period == PERIOD_D1)
    {
       datetime from = D'2007.01.01 00:00';
       datetime to   = TimeCurrent();
       bars = CopyRates(symbol, period, from, to, rates);
    }
    else
    {
       bars = CopyRates(symbol, period, 0, maxBars, rates);
    }

    if (bars < 300)
        return ("");

    int      multiplier = (int) MathPow(10, digits);
    datetime millennium = D'2000.01.01 00:00';

    string time   = "";
    string open   = "";
    string high   = "";
    string low    = "";
    string close  = "";
    string volume = "";

    for (int i = bars - 1; i >= 0; i--)
    {
      string comma = i > 0 ? "," : "";

      StringAdd(time,   IntegerToString((rates[i].time-millennium) / 60) + comma);
      StringAdd(open,   DoubleToString(rates[i].open,  digits) + comma);
      StringAdd(high,   DoubleToString(rates[i].high,  digits) + comma);
      StringAdd(low,    DoubleToString(rates[i].low,   digits) + comma);
      StringAdd(close,  DoubleToString(rates[i].close, digits) + comma);
      StringAdd(volume, IntegerToString(rates[i].tick_volume)  + comma);
    }

    string symbolData = "{"+
         "\"ver\":"            + "3"                                                      +  ","+
         "\"terminal\":\""     + terminal                                                 +"\","+
         "\"company\":\""      + company                                                  +"\","+
         "\"server\":\""       + server                                                   +"\","+
         "\"symbol\":\""       + name                                                     +"\","+
         "\"period\":"         + PeriodToStr(period)                                      + "," +
         "\"baseCurrency\":\"" + baseCurrency                                             +"\","+
         "\"priceIn\":\""      + priceIn                                                  +"\","+
         "\"lotSize\":"        + IntegerToString((int) MarketInfo(symbol,MODE_LOTSIZE))   + "," +
         "\"stopLevel\":"      + IntegerToString((int) MarketInfo(symbol,MODE_STOPLEVEL)) + "," +
         "\"tickValue\":"      + DoubleToString(MarketInfo(symbol,MODE_TICKVALUE),digits) + "," +
         "\"minLot\":"         + DoubleToString(MarketInfo(symbol,MODE_MINLOT),2)         + "," +
         "\"maxLot\":"         + DoubleToString(MarketInfo(symbol,MODE_MAXLOT),2)         + "," +
         "\"lotStep\":"        + DoubleToString(MarketInfo(symbol,MODE_LOTSTEP),2)        + "," +
         "\"serverTime\":"     + IntegerToString((TimeCurrent()-millennium)/60)           + "," +
         "\"swapLong\":"       + DoubleToString(MarketInfo(symbol,MODE_SWAPLONG),2)       + "," +
         "\"swapShort\":"      + DoubleToString(MarketInfo(symbol,MODE_SWAPSHORT),2)      + "," +
         "\"swapType\":"       + IntegerToString((int) MarketInfo(symbol,MODE_SWAPTYPE))  + "," +
         "\"swapThreeDays\":"  + IntegerToString(SymbolInfoInteger(_Symbol,SYMBOL_SWAP_ROLLOVER3DAYS)) + "," +
         "\"commission\":"     + DoubleToString(Commission,2)                             + "," +
         "\"bid\":"            + DoubleToString(MarketInfo(symbol,MODE_BID),digits)       + "," +
         "\"ask\":"            + DoubleToString(MarketInfo(symbol,MODE_ASK),digits)       + "," +
         "\"spread\":"         + IntegerToString(spread)                                  + "," +
         "\"digits\":"         + IntegerToString(digits)                                  + "," +
         "\"bars\":"           + IntegerToString(bars)                                    + "," +
         "\"time\":["          + time                                                     + "],"+
         "\"open\":["          + open                                                     + "],"+
         "\"high\":["          + high                                                     + "],"+
         "\"low\":["           + low                                                      + "],"+
         "\"close\":["         + close                                                    + "],"+
         "\"volume\":["        + volume                                                   + "]" +
         "}";

    comment += symbol + PeriodToStr(period) + ", " + IntegerToString(bars) + " bars" + "\n";
    Comment(comment);

    return (symbolData);
}

void SaveFile(string fileName, string data)
{
    ResetLastError();
    int file_handle = FileOpen(fileName, FILE_WRITE|FILE_IS_TEXT);
    if (file_handle != INVALID_HANDLE)
    {
        FileWrite(file_handle, data);
        FileClose(file_handle);
    }
}

string PeriodToStr(ENUM_TIMEFRAMES period)
{
   int seconds = PeriodSeconds(period);
   string text = IntegerToString(seconds / 60);
   return (text);
}

int GetSpread()
{
   if (Spread > 0) return (Spread);

   int    digits  = (int) SymbolInfoInteger(_Symbol, SYMBOL_DIGITS);
   double bid     = MarketInfo(_Symbol, MODE_BID);
   double ask     = MarketInfo(_Symbol, MODE_ASK);
   double spread  = (ask - bid) * MathPow(10, digits);
   int    rounded = RoundNumber(spread);

   return (rounded);
}

int RoundNumber(double number)
{
   int figures = number < 1000 ? 2 : 3;
   int multiplier = (int) MathPow(10, figures - 1);
   int result = (int) (MathCeil(number / multiplier)* multiplier);
   return (result);
}

ENUM_INIT_RETCODE ValidateInit()
{
   return (INIT_SUCCEEDED);
}

        
