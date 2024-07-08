//+------------------------------------------------------------------+
//| ASCTrend1i.mq4 
//| Ramdass - Conversion only
//| Updates:
//|  2014-02-11. Xaphod, v1.600
//|    - Update for MT4.5
//|    - Added alert sounds for buy and sell
//|  2014-01-30, v1.1, X
//|    - Add Alerts
//|  2013-04-15, v1.1, X
//|    - Bug fix. Check array bounds in loops
//|    - Bug fix. Set correct nr of counted bars on first run
//|  2012-10-23, X, Performance enhancements. About 500x improvement.
//|    - Removed redundant code and variables
//|    - Cleaned up and modified code for improved performance
//|    - Update only the new bars instead of the full buffer.
//|    - Commented code
//|    - Option to use full buffer size.
//+------------------------------------------------------------------+
#property indicator_chart_window
#property indicator_buffers 3
#property indicator_color1 Magenta
#property indicator_color2 Yellow
#property indicator_width1  1 
#property indicator_width2  1

#property strict
#property version     "1.600"
#property description "ASCTrend1 indicator with alerts."
#property description " "
#property description "For more info on this indicator go to:"
#property description "www.forex-tsd.com/move/598-asctrend-system.html"
#property description " "
#property description "Misc: To use the 'Alert_Sound' together with the 'Alert_Popup', disable the alert sound in the"
#property description "          'Tools/Options/Events' tab, otherwise the Alert_Sound will not play."


#define VERSION "1.600"
#define INDICATOR_NAME "AscTrend1"

#define RANGE_FACTOR 4.6
#define ALT_PERIOD 4
#define HIGH_LEVEL 67
#define LOW_LEVEL 33

//---- input parameters
extern int    Risk=6;            /* Risk */  // Risk level. WPR_Period=3+Risk*2 or WPR_Period=ALT_PERIOD for a large move 
extern int    BarCount=0;        /* Bar Count */  // 0 for full chart buffer
extern int    Alert_OnBar=1;     /* Alert - On change of this Bar */ // Alert when this bar changes. = for curent bar, 1 for last closed bar
extern bool   Alert_Popup=False; /* Alert - Popup Msg */ // Enable popup window & sound on alert
extern string Alert_SoundUp="";  /* Alert - Play Sound File for Buy Signal */ // Play sound on alert. Wav files only
extern string Alert_SoundDn="";  /* Alert - Play Sound File for Sell Signal */ // Play sound on alert. Wav files only
extern bool   Alert_Email=False; /* Alert - Send eMail */ // Enable send email on alert
extern string Alert_Subject="";  /* Alert - eMail Subject */ // Email Subject. Null string ("") will result in a preconfigured subject.

//---- buffers
double dn_sig[];
double up_sig[];
double signal[];

// Globals
bool gbInit;

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init() {
  //Init buffers
  IndicatorBuffers(4);
  SetIndexStyle(0,DRAW_ARROW);
  SetIndexArrow(0,234); 
  SetIndexStyle(1,DRAW_ARROW);
  SetIndexArrow(1,233); 
  SetIndexStyle(2,DRAW_NONE);
  
  SetIndexBuffer(0,dn_sig);
  SetIndexBuffer(1,up_sig);
  SetIndexBuffer(2,signal);
   
  SetIndexLabel(0, "Down");
  SetIndexLabel(1, "Up");
  SetIndexLabel(2, "Signal");

  SetIndexDrawBegin(0,3+Risk*2+1); 
  SetIndexDrawBegin(1,3+Risk*2+1);
   
  // Set max bars to draw
  if (BarCount<1 || BarCount>Bars) 
    BarCount=Bars-12;

  gbInit=True;
  return(0);
}
  
  
//+------------------------------------------------------------------+
//| ASCTrend1sig                                                     |
//+------------------------------------------------------------------+
int start() {
  int i,shift,counted_bars, min_bars, wpr_period;
  double wpr_value, avg_range, high_level,low_level;
  
  // Set levels 
  high_level=HIGH_LEVEL+Risk;
  low_level=LOW_LEVEL-Risk;
   
  // Check for enough bars
  min_bars=3+Risk*2+1;
  if(Bars<=min_bars) 
    return(0);
    
  // Get new bars
  counted_bars=IndicatorCounted();
  if(counted_bars<0) 
    return (-1); 
  if(counted_bars>0) 
    counted_bars--;
  shift=Bars-counted_bars;
  if (BarCount>0 && shift>BarCount)
    shift=BarCount;
  if (shift>Bars-min_bars)
    shift=Bars-min_bars;  
     
  while(shift>=0) { 
    // Calc Avg range for 10 bars
    i=shift;
    avg_range=0.0;
    for (i=shift; i<shift+10; i++) {
      if (i>=Bars) break;
      avg_range=avg_range+MathAbs(High[i]-Low[i]);
    }
    avg_range=avg_range/10.0;
 
    // Set period for WPR calculation.
    wpr_period=3+Risk*2;
    
    // Use alternative period if there has been a large move.
    i=shift;
    while (i<shift+6) {
      if (i>=Bars-3) break;
      if (MathAbs(Close[i+3]-Close[i])>=avg_range*RANGE_FACTOR) {
        wpr_period=ALT_PERIOD;
        break;
      }
      i++;
    }      
	 
    // Calc WPR 
    wpr_value=100-MathAbs(iWPR(NULL,0,wpr_period,shift)); 
    
    // Set current signal
    if (wpr_value>=high_level) 
      signal[shift] = 1;
    else if (wpr_value<=low_level) 
      signal[shift] = -1;  
    else if (wpr_value>low_level && signal[shift+1]==1) 
      signal[shift] = 1;
    else if (wpr_value<high_level && signal[shift+1]==-1) 
      signal[shift] = -1;      
    else
      signal[shift]=0;
      
    // Draw arrows
    dn_sig[shift]=0;
    up_sig[shift]=0;
    if (signal[shift]==-1 && signal[shift+1]==1)
      dn_sig[shift]=High[shift]+avg_range*0.5;
    if (signal[shift]==1 && signal[shift+1]==-1)
      up_sig[shift]=Low[shift]-avg_range*0.5;
    
    shift--;
  }

  // Alerts
  CheckAlert(Alert_OnBar);
  if (gbInit)
    gbInit=False;
  
  return(0);
}
//+------------------------------------------------------------------+




//-----------------------------------------------------------------------------
// function: CheckAlert()
// Description: Check for new alerts
//-----------------------------------------------------------------------------
void CheckAlert(int iBar) {
  static int iPrevAlert=0;
  int iCurSignal=0;
  
  if (Alert_Popup || Alert_Email || Alert_SoundUp!="" || Alert_SoundDn!="") {
    // range check error
    if (iBar<0 || iBar>=Bars)
      return;
  
    // Get current signal
    if (up_sig[iBar]>0)
      iCurSignal=1;
    else if (dn_sig[iBar]>0)
      iCurSignal=-1;
    else
      iCurSignal=0;
    
    // Show alert  
    if (iPrevAlert!=iCurSignal) {
      iPrevAlert=iCurSignal;    
      if (iCurSignal==1)
         AlertNow(Symbol()+", "+TF2Str(Period())+": AscTrend1 Buy Signal.",Alert_SoundUp);
      else if (iCurSignal==-1)
         AlertNow(Symbol()+", "+TF2Str(Period())+": AscTrend1 Sell Signal.",Alert_SoundDn);
    }
  }
  return;
}


//-----------------------------------------------------------------------------
// function: AlertNow()
// Description: Signal the popup and email alerts
//-----------------------------------------------------------------------------
void AlertNow(string sAlertMsg, string sAlertSnd="") {
  //PrintD(sAlertMsg);
  // No alerts on startup
  if (gbInit)
    return;
  //Popup Alert 
  if (Alert_Popup) 
    Alert(INDICATOR_NAME, ", ", sAlertMsg);
  if (sAlertSnd!="")
    PlaySound(sAlertSnd);
  //Email Alert
  if (Alert_Email) {
    if (Alert_Subject=="")
      SendMail( sAlertMsg, "MT4 Alert!\n"+INDICATOR_NAME+"\n" + TimeToStr(Time[0],TIME_DATE|TIME_SECONDS )+"\n"+sAlertMsg);
    else 
      SendMail( Alert_Subject, "MT4 Alert!\n"+INDICATOR_NAME+"\n" + TimeToStr(Time[0],TIME_DATE|TIME_SECONDS )+"\n"+sAlertMsg);          
  }
  
  return;
}


//-----------------------------------------------------------------------------
// function: TF2Str()
// Description: Convert time-frame to a string
//-----------------------------------------------------------------------------
string TF2Str(int iPeriod) {
  switch(iPeriod) {
    case PERIOD_M1: return("M1");
    case PERIOD_M5: return("M5");
    case PERIOD_M15: return("M15");
    case PERIOD_M30: return("M30");
    case PERIOD_H1: return("H1");
    case PERIOD_H4: return("H4");
    case PERIOD_D1: return("D1");
    case PERIOD_W1: return("W1");
    case PERIOD_MN1: return("MN1");
    default: return("M"+(string)iPeriod);
  }
  return("M?");
}