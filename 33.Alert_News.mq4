//+------------------------------------------------------------------+
//|                                                33.Alert_News.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                   Alert_News.mq4 |
//|                                                   David Louisson |
//|                                        http://www.metaquotes.net |
//+------------------------------------------------------------------+
#property copyright "David Louisson"
#property link      "http://www.metaquotes.net"

#property indicator_chart_window
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+

extern  int   AlertMins = 5;
extern  int   NumTimes  = 1;

string   FileName     = "news.csv";
int      handle;

int      eCount;              // Event counter
datetime eTime[9999];         // Event date/time, format = yyyy.mm.dd<space>hh:mm
int      eNumber[9999];       // Event seq# (same date/time use ascending seq#s)
int      eWingding[9999];     // Wingding code for implicated currency, as above
int      eImpact[9999];       // 1=low impact; 2=medium impact; 3=high impact
string   eCurrency[9999];     // Currency/ies on whose charts object will display; ALL = all currencies 
string   ePeriods[9999];      // Time period settings on which object will display (M1,M5,M15,M30,H1,H4,D1,W1,MTH; 0=no, 1=yes)
string   eText1[9999];        // First descr line, format = hh:mm XXX Y "event description"
                              //   where XXX=currency; Y=H/M/L impact
string   eText2[9999];        // Second descr line, shows Actual, Forecast, Previous values
int      eAlerts[9999];       // number of times alert already sounded


int init()
  {
   handle = FileOpen(FileName, FILE_CSV|FILE_READ,';');          // Open NEWS.CSV
   if(handle==0)
      Comment("File "+FileName+" not found.");

   for(eCount = 0; !FileIsEnding(handle); eCount++)              // Read from NEWS.CSV; one line per event
   {
      eTime[eCount]     = StrToTime(FileReadString(handle));     // Event date/time
      eNumber[eCount]   = StrToInteger(FileReadString(handle));  // Event seq# (same date/time have ascending seq#s)
      eWingding[eCount] = StrToInteger(FileReadString(handle));  // Wingding code denoting implicated currency
      eImpact[eCount]   = StrToInteger(FileReadString(handle));  // Impact: 1=low; 2=medium; 3=High
      eCurrency[eCount] = FileReadString(handle);                // Currency/ies on whose charts object will display; ALL = all currencies
      ePeriods[eCount]  = FileReadString(handle);                // Time period settings on which object will display (M1,M5,M15,M30,H1,H4,D1,W1,MTH; 0=no, 1=yes)
      eText1[eCount]    = FileReadString(handle);                // First line of description
      eText2[eCount]    = FileReadString(handle);                // Second line of description
      eAlerts[eCount]   = NumTimes;
      if (FileIsEnding(handle))  break;
   }

   int debug, i;
   debug=FileOpen("debug.txt", FILE_CSV|FILE_WRITE, '|');
   for( i=0; i<eCount; i++)
     FileWrite(debug,i,TimeToStr(eTime[i]),eNumber[i],eWingding[i],eImpact[i],eCurrency[i],eText1[i],eText2[i],eAlerts[i]);
   FileClose(debug);

   FileClose(handle);

   return(0);
  }
//+------------------------------------------------------------------+
//| Custom indicator deinitialization function                       |
//+------------------------------------------------------------------+
int deinit()
  {
   return(0);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int start()
  {
   for(int i=0; i<eCount; i++)   {
     if (eTime[i] >= TimeCurrent() && (eTime [i] - TimeCurrent()) <= AlertMins * 60 && eAlerts[i] > 0 && StringSubstr(eText1[i],2,1) == ":")   {
       Alert("NEWS: " + eText1[i]);
       eAlerts[i]--;
     }  
   }  
   return(0);
  }
//+------------------------------------------------------------------+
        
