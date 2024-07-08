#property copyright "EAPASSING";
#property link "https://t.me/fundedautomatico";
#property version "";
#property strict
#property description "Web:https://eapassing.com/ \nTelegram: https://t.me/fundedautomatico";

#include <JAson.mqh>
#import "stdlib.ex4"

string ErrorDescription(int);

#import

enum ENUM_ORDERS
{
   pendientes = 0, // Órdenes pendientes
   amercado = 1 // Órdenes a mercado
};

enum ENUM_TYPE_SLTP
{
   desdeinicio = 0, // Stop loss desde el inicio
   alabrirorden = 1 // Stop loss una vez orden a mercado
};

extern double Lots = 0.1; // Lotaje
extern string IniRango = "13:30"; // .
extern string EndRango = "14:30"; // .
extern string EndOperativa = "16:00"; // .
extern ENUM_ORDERS TypeOrders = pendientes; // .
extern bool PriceBidBuys; // .
extern ENUM_TYPE_SLTP TipoSL = desdeinicio; // .
extern int SL = 20; // .
extern int TP = 120; // .
extern bool UseBreakEven; // .
extern int BreakEven = 50; // .
extern int SLBreakEven; // .
extern bool UseTrailing = true; // .
extern int TrailStart = 20; // .
extern int TrailStop = 20; // .
extern int TrailStep = 20; // .
extern double TPMonth; // Take profit mensual(%)
extern int MaxOrdersDay = 3; // .
extern string I3_2 = "--------------------------------"; // ---------------------------------------------------------------
extern bool UseSpreadProtect; // .
extern int SpreadMax = 15; // .
extern bool Display = true; // .
extern string Comentario; // .
extern bool PopupAlert; // .
extern bool PushAlert; // .
extern bool EmailAlert; // .

struct stApi
{
   public:
      int m_0;
      int m_4;
      string m_8;
      double m_20;
      datetime m_28;
      datetime m_36;
      bool m_44;
      string m_45;
      string m_57;
      datetime m_69;
};

string Is_0170;
string Is_0080;
string Is_0180;
bool returned_b;
bool Gb_0000;
bool Gb_0001;
int Ii_0064;
long returned_l;
string Is_0090;
string Is_00A0;
string Is_00B0;
string Is_00C0;
string Is_00D0;
string Is_0110;
string Is_00E0;
string Is_00F0;
string Is_0100;
string Is_0160;
string Is_0130;
string Is_0140;
string Is_0150;
int returned_i;
long Il_05D8;
bool Ib_016C;
double Gd_0000;
int Gi_0001;
int Gi_0003;
int Gi_0004;
string Is_0070;
int Gi_0005;
int Gi_0006;
long Gl_0006;
long Gl_0007;
double Gd_0008;
bool Gb_0009;
int Gi_000A;
int Gi_000B;
int Gi_000C;
int Gi_000D;
int Gi_000E;
int Gi_000F;
int Gi_0010;
double Gd_0011;
int Gi_0012;
bool Gb_0012;
int Gi_0015;
int Gi_0016;
int Gi_0017;
double Gd_0018;
double Gd_0019;
int Gi_001A;
double Gd_001A;
double Ind_000;
double Gd_001B;
int Gi_001C;
int Gi_001D;
double Gd_001D;
int Gi_001E;
int Gi_001F;
int Gi_0020;
int Gi_0021;
int Gi_0022;
double Gd_0023;
double Gd_0024;
int Gi_0025;
double Gd_0025;
double Gd_0026;
int Gi_0027;
int Gi_0028;
double Gd_0028;
int Gi_0029;
int Gi_002A;
int Gi_002B;
long Gl_0013;
string Is_0120;
double Gd_0014;
long Gl_0015;
long Gl_0002;
long Gl_0003;
int Ii_05CC;
int Ii_05D0;
int Gi_0000;
int Ii_0000;
string Is_0008;
string Is_0018;
string Is_0028;
string Is_0038;
string Is_0048;
string Is_0058;
int Ii_0068;
bool Ib_016D;
string Is_05C0;
int Gi_0002;
string Gs_0000;
double Ind_004;
short Gst_0000;
short Gst_0001;
short Gst_0005;
short Gst_0002;
double Ind_001;
short Gst_0004;
char Gc_0000;
char Gc_000C;
char Gc_000D;
bool Gb_000E;
char Gc_000F;
char Gc_0010;
int Gi_0011;
char Gc_000E;
int Gi_0009;
char Gc_0009;
bool Gb_000A;
char Gc_000B;
string Gs_0006;
int Gi_0007;
char Gc_0001;
char Gc_0002;
bool Gb_0003;
char Gc_0004;
char Gc_0003;
bool Gb_0005;
char Gc_0006;
char Gc_0007;
int Gi_0008;
char Gc_0008;
char Gc_000A;
char Gc_0005;
double Gd_0001;
bool Gb_0002;
bool Gb_0004;
double Gd_0006;
double Gd_0007;
bool Gb_0008;
double Gd_0009;
bool Gb_0006;
double Gd_0004;
double Gd_0002;
double Gd_0003;
double Gd_000B;
double Gd_000C;
double Ind_002;
bool Gb_000D;
long Gl_0000;
long Gl_0001;
double Gd_0005;
long Gl_0008;
double Gd_000A;
long Gl_0010;
double Gd_0012;
double Gd_0015;
double Gd_0016;
int Gi_0018;
long Gl_0004;
long Gl_0005;
bool Gb_0007;
long Gl_000B;
double Gd_000D;
bool Gb_000C;
long Gl_0009;
CJAVal* Global_Pointer_00000007;
struct Global_Struct_00000009;
string Gs_0008;
string Gs_000A;
string Gs_000C;
CJAVal* Global_Pointer_0000000D;
struct Global_Struct_0000000F;
string Gs_000E;
string Gs_0011;
string Gs_0010;
int Gi_0013;
long Gl_0014;
long Gl_0016;
string Gs_0017;
int Gi_0019;
string Gs_0019;
long Gl_001A;
string Gs_001F;
long Gl_0020;
string Gs_0025;
bool Gb_0026;
string Gs_0028;
string Gs_0029;
double Gd_002A;
int Gi_002C;
int Gi_002D;
short Gst_0021;
short returned_st;
string Gs_0021;
string Gs_0022;
int Gi_0023;
string Gs_0023;
short Gst_001B;
int Gi_001B;
string Gs_001B;
string Gs_001C;
string Gs_001D;
double returned_double;
int init()
{
   string tmp_str0000;
   string tmp_str0001;
   string tmp_str0002;
   string tmp_str0003;
   string tmp_str0004;
   string tmp_str0005;
   string tmp_str0006;
   string tmp_str0007;
   int Li_FFFC;
   Ii_0000 = 0;
   Is_0008 = "======MONEY=====================";
   Is_0018 = "======ENTRADA===================";
   Is_0028 = "======SALIDA====================";
   Is_0038 = "======FILTROS===================";
   Is_0048 = "======OTROS AJUSTES=============";
   Is_0058 = "======NOTIFICACIONES============";
   Ii_0064 = 0;
   Ii_0068 = 0;
   Ib_016C = false;
   Ib_016D = true;
   Is_05C0 = "lkjf54;.?";
   Ii_05CC = 0;
   Ii_05D0 = 0;
   Il_05D8 = 0;

   Is_0170 = Is_0080 + "FallosConsultaApi";
   Is_0180 = Is_0080 + "IniFecha";

   if (IsConnected() != true) { 
   Alert("No hay conexión con el servidor.");
   Gb_0000 = false;
   } 
   else { 
   if (IsExpertEnabled() != true) { 
   Alert("Revisa la configuración para asesores expertos en Herramientas->Opciones->Asesores Expertos. No está habilitada la operativa automática.");
   }} 

   if ((Lots == 0)) { 
   Alert("Volumen debe ser mayor que 0.");
   Li_FFFC = 32767;
   return Li_FFFC;
   } 
   tmp_str0001 = IniRango;
   if (func_1116(tmp_str0001) != true) { 
   tmp_str0002 = "El formato de fecha en Hora inicio rango no es correcto. Formato correcto HH:MM y se ha introducido " + IniRango;
   tmp_str0002 = tmp_str0002 + ".";
   Alert(tmp_str0002);
   Li_FFFC = 32767;
   return Li_FFFC;
   } 
   tmp_str0003 = EndRango;
   if (func_1116(tmp_str0003) != true) { 
   tmp_str0004 = "El formato de fecha en Hora fin rango no es correcto. Formato correcto HH:MM y se ha introducido " + EndRango;
   tmp_str0004 = tmp_str0004 + ".";
   Alert(tmp_str0004);
   Li_FFFC = 32767;
   return Li_FFFC;
   } 
   tmp_str0005 = EndOperativa;
   if (func_1116(tmp_str0005) != true) { 
   tmp_str0006 = "El formato de fecha en Hora fin operativa no es correcto. Formato correcto HH:MM y se ha introducido " + EndOperativa;
   tmp_str0006 = tmp_str0006 + ".";
   Alert(tmp_str0006);
   Li_FFFC = 32767;
   return Li_FFFC;
   } 
   Ii_0064 = (int)ChartID();
   tmp_str0007 = (string)Ii_0064;
   tmp_str0007 = tmp_str0007 + "_";
   Is_0080 = tmp_str0007;
   Is_0090 = tmp_str0007 + "PaintBoxDay";
   Is_00A0 = tmp_str0007 + "Buys";
   Is_00B0 = tmp_str0007 + "Sells";
   Is_00C0 = tmp_str0007 + "Max";
   Is_00D0 = tmp_str0007 + "Min";
   Is_0110 = tmp_str0007 + "PriceOpen_t";
   Is_00E0 = tmp_str0007 + "NoPermiteBuy";
   Is_00F0 = tmp_str0007 + "NoPermiteSell";
   Is_0100 = tmp_str0007 + "DayTP";
   Is_0160 = tmp_str0007 + "LastOrder";
   Is_0130 = tmp_str0007 + "BalaceIniMes";
   Is_0140 = tmp_str0007 + "Mes";
   Is_0150 = tmp_str0007 + "MesClose";
   EventSetTimer(1);
   func_1144();
   Li_FFFC = 0;
   
   return Li_FFFC;
}

void OnTick()
{
   string tmp_str0000;
   string tmp_str0001;
   string tmp_str0002;
   string tmp_str0003;
   string tmp_str0004;
   string tmp_str0005;
   string tmp_str0006;
   string tmp_str0007;
   string tmp_str0008;
   string tmp_str0009;
   string tmp_str000A;
   string tmp_str000B;
   string tmp_str000C;
   string tmp_str000D;
   string tmp_str000E;
   string tmp_str000F;
   string tmp_str0010;
   string tmp_str0011;
   string tmp_str0012;
   string tmp_str0013;
   string tmp_str0014;
   string tmp_str0015;
   string tmp_str0016;
   string tmp_str0017;
   string tmp_str0018;
   string tmp_str0019;
   string tmp_str001A;
   string tmp_str001B;
   string tmp_str001C;
   string tmp_str001D;
   string tmp_str001E;
   string tmp_str001F;
   string tmp_str0020;
   string tmp_str0021;
   string tmp_str0022;
   string tmp_str0023;
   string tmp_str0024;
   string tmp_str0025;
   string tmp_str0026;
   string tmp_str0027;
   string tmp_str0028;
   string tmp_str0029;
   string tmp_str002A;
   string tmp_str002B;
   string tmp_str002C;
   string tmp_str002D;
   string tmp_str002E;
   string tmp_str002F;
   string tmp_str0030;
   string tmp_str0031;
   string tmp_str0032;
   string tmp_str0033;
   string tmp_str0034;
   string tmp_str0035;
   string tmp_str0036;
   string tmp_str0037;
   string tmp_str0038;
   string tmp_str0039;
   string tmp_str003A;
   string tmp_str003B;
   string tmp_str003C;
   string tmp_str003D;
   string tmp_str003E;
   string tmp_str003F;
   string tmp_str0040;
   string tmp_str0041;
   string tmp_str0042;
   string tmp_str0043;
   string tmp_str0044;
   string tmp_str0045;
   string tmp_str0046;
   string tmp_str0047;
   string tmp_str0048;
   string tmp_str0049;
   string tmp_str004A;
   string tmp_str004B;
   string tmp_str004C;
   string tmp_str004D;
   string tmp_str004E;
   int Li_FFFC;
   int Li_FFF8;

   if (Il_05D8 >= iTime(_Symbol, _Period, 0)) { 
   Ib_016C = false;
   } 
   else { 
   Il_05D8 = iTime(_Symbol, _Period, 0);
   Ib_016C = true;
   } 
   func_1151();
   func_1146();
   if (Display) { 
   func_1086();
   } 
   if (UseTrailing) { 
   func_1143(TrailStart, TrailStop, TrailStep);
   } 
   if (UseBreakEven) { 
   func_1154(BreakEven, SLBreakEven);
   } 
   if (func_1139()) return; 
   func_1128();
   tmp_str0000 = Is_0090;
   Gd_0000 = 0;
   if (GlobalVariableGet(tmp_str0000, Gd_0000) != true) { 
   Gd_0000 = 0;
   } 
   Gi_0001 = (int)Gd_0000;
   if (Gi_0001 == DayOfYear()) { 
   Gb_0001 = false;
   } 
   else { 
   Gl_0002 = TimeCurrent();
   tmp_str0001 = TimeToString(TimeCurrent(), 1);
   tmp_str0001 = tmp_str0001 + " ";
   tmp_str0001 = tmp_str0001 + EndRango;
   if (Gl_0002 >= StringToTime(tmp_str0001)) { 
   Gb_0001 = true;
   } 
   else { 
   Gb_0001 = false;
   }} 
   if (Gb_0001) { 
   func_1110();
   tmp_str0002 = Is_00A0;
   if (GlobalVariableSet(tmp_str0002, 0) == 0) {
   tmp_str0003 = "Se ha producido un error al actualizar la variable global" + Is_00A0;
   tmp_str0003 = tmp_str0003 + " con valor ";
   Gi_0004 = _Digits;
   tmp_str0003 = tmp_str0003 + DoubleToString(NormalizeDouble(0, Gi_0004), Gi_0004);
   tmp_str0003 = tmp_str0003 + ". Error ";
   tmp_str0003 = tmp_str0003 + ErrorDescription(GetLastError());
   tmp_str0004 = tmp_str0003;
   Is_0070 = tmp_str0003;
   tmp_str0006 = _Symbol + "(";
   tmp_str0006 = tmp_str0006 + func_1087(_Period);
   tmp_str0006 = tmp_str0006 + ")";
   tmp_str0006 = tmp_str0006 + ": ";
   tmp_str0006 = tmp_str0006 + tmp_str0003;
   tmp_str0005 = tmp_str0006;
   if (PopupAlert) { 
   Alert(tmp_str0005);
   } 
   else { 
   Print(tmp_str0004);
   } 
   if (PushAlert) { 
   SendNotification(tmp_str0005);
   } 
   if (EmailAlert != false) {
   SendMail(tmp_str0005, tmp_str0004);
   }}
   else{
   GlobalVariablesFlush();
   }
   tmp_str0006 = Is_00B0;
   if (GlobalVariableSet(tmp_str0006, 0) == 0) {
   tmp_str0007 = "Se ha producido un error al actualizar la variable global" + Is_00B0;
   tmp_str0007 = tmp_str0007 + " con valor ";
   Gi_0005 = _Digits;
   tmp_str0007 = tmp_str0007 + DoubleToString(NormalizeDouble(0, Gi_0005), Gi_0005);
   tmp_str0007 = tmp_str0007 + ". Error ";
   tmp_str0007 = tmp_str0007 + ErrorDescription(GetLastError());
   tmp_str0008 = tmp_str0007;
   Is_0070 = tmp_str0007;
   tmp_str000A = _Symbol + "(";
   tmp_str000A = tmp_str000A + func_1087(_Period);
   tmp_str000A = tmp_str000A + ")";
   tmp_str000A = tmp_str000A + ": ";
   tmp_str000A = tmp_str000A + tmp_str0007;
   tmp_str0009 = tmp_str000A;
   if (PopupAlert) { 
   Alert(tmp_str0009);
   } 
   else { 
   Print(tmp_str0008);
   } 
   if (PushAlert) { 
   SendNotification(tmp_str0009);
   } 
   if (EmailAlert != false) {
   SendMail(tmp_str0009, tmp_str0008);
   }}
   else{
   GlobalVariablesFlush();
   }
   tmp_str000A = Is_0160;
   if (GlobalVariableSet(tmp_str000A, -1) == 0) {
   tmp_str000B = "Se ha producido un error al actualizar la variable global" + Is_0160;
   tmp_str000B = tmp_str000B + " con valor ";
   Gi_0006 = _Digits;
   tmp_str000B = tmp_str000B + DoubleToString(NormalizeDouble(-1, Gi_0006), Gi_0006);
   tmp_str000B = tmp_str000B + ". Error ";
   tmp_str000B = tmp_str000B + ErrorDescription(GetLastError());
   tmp_str000C = tmp_str000B;
   Is_0070 = tmp_str000B;
   tmp_str000E = _Symbol + "(";
   tmp_str000E = tmp_str000E + func_1087(_Period);
   tmp_str000E = tmp_str000E + ")";
   tmp_str000E = tmp_str000E + ": ";
   tmp_str000E = tmp_str000E + tmp_str000B;
   tmp_str000D = tmp_str000E;
   if (PopupAlert) { 
   Alert(tmp_str000D);
   } 
   else { 
   Print(tmp_str000C);
   } 
   if (PushAlert) { 
   SendNotification(tmp_str000D);
   } 
   if (EmailAlert != false) {
   SendMail(tmp_str000D, tmp_str000C);
   }}
   else{
   GlobalVariablesFlush();
   }} 
   tmp_str000E = TimeToString(TimeCurrent(), 1);
   tmp_str000E = tmp_str000E + " ";
   tmp_str000E = tmp_str000E + EndRango;
   Gl_0006 = StringToTime(tmp_str000E);
   tmp_str000F = TimeToString(TimeCurrent(), 1);
   tmp_str000F = tmp_str000F + " ";
   tmp_str000F = tmp_str000F + EndOperativa;
   Gl_0007 = StringToTime(tmp_str000F);
   if (TimeCurrent() >= Gl_0006 && TimeCurrent() <= Gl_0007) { 
   Gd_0008 = 1;
   } 
   else { 
   if (Gl_0007 < Gl_0006) { 
   Gl_0007 = Gl_0007 + 86400;
   } 
   if (TimeCurrent() >= Gl_0006 && TimeCurrent() <= Gl_0007) { 
   Gd_0008 = 1;
   } 
   else { 
   Gl_0007 = Gl_0007 - 86400;
   Gl_0006 = Gl_0006 - 86400;
   if (TimeCurrent() >= Gl_0006 && TimeCurrent() <= Gl_0007) { 
   Gd_0008 = 1;
   } 
   else { 
   Gd_0008 = 0;
   }}} 
   if (Gd_0008 != 0) { 
   Gb_0009 = true;
   } 
   else { 
   Gb_0009 = false;
   } 
   if (Gb_0009 != true) { 
   Gi_000A = 1;
   if (OrdersTotal() < 1) return; 
   do { 
   if (OrderSelect((Gi_000A - 1), 0, 0) == true 
   && OrderMagicNumber() == Ii_0064 && OrderType() != OP_BUY && OrderType() != OP_SELL) { 
   Gi_000B = func_1097(OrderType());
   if (!OrderDelete(OrderTicket(), Gi_000B)) {
   tmp_str0010 = (string)OrderTicket();
   tmp_str0010 = "Error al eliminar la orden pendiente " + tmp_str0010;
   tmp_str0010 = tmp_str0010 + ". Error: ";
   tmp_str0010 = tmp_str0010 + ErrorDescription(GetLastError());
   tmp_str0011 = tmp_str0010;
   Is_0070 = tmp_str0010;
   tmp_str0013 = _Symbol + "(";
   tmp_str0013 = tmp_str0013 + func_1087(_Period);
   tmp_str0013 = tmp_str0013 + ")";
   tmp_str0013 = tmp_str0013 + ": ";
   tmp_str0013 = tmp_str0013 + tmp_str0010;
   tmp_str0012 = tmp_str0013;
   if (PopupAlert) { 
   Alert(tmp_str0012);
   } 
   else { 
   Print(tmp_str0011);
   } 
   if (PushAlert) { 
   SendNotification(tmp_str0012);
   } 
   if (EmailAlert != false) {
   SendMail(tmp_str0012, tmp_str0011);
   }}
   else{
   tmp_str0013 = (string)OrderTicket();
   Gi_000C = ObjectsTotal(-1);
   if (Gi_000C >= 0) { 
   do { 
   tmp_str0014 = ObjectName(Gi_000C);
   if (ObjectType(tmp_str0014) == 1) { 
   tmp_str0015 = ObjectName(Gi_000C);
   if (StringFind(tmp_str0015, tmp_str0013, 0) >= 0) { 
   tmp_str0016 = ObjectName(Gi_000C);
   ObjectDelete(tmp_str0016);
   }} 
   Gi_000C = Gi_000C - 1;
   } while (Gi_000C >= 0); 
   }}} 
   Gi_000A = Gi_000A + 1;
   } while (Gi_000A <= OrdersTotal()); 
   return ;
   } 
   if (func_1135() != true) { 
   Gi_000D = 1;
   if (OrdersTotal() < 1) return; 
   do { 
   if (OrderSelect((Gi_000D - 1), 0, 0) == true && OrderMagicNumber() == Ii_0064 && OrderType() != OP_BUY && OrderType() != OP_SELL) { 
   Gi_000E = func_1097(OrderType());
   if (!OrderDelete(OrderTicket(), Gi_000E)) {
   tmp_str0017 = (string)OrderTicket();
   tmp_str0017 = "Error al eliminar la orden pendiente " + tmp_str0017;
   tmp_str0017 = tmp_str0017 + ". Error: ";
   tmp_str0017 = tmp_str0017 + ErrorDescription(GetLastError());
   tmp_str0018 = tmp_str0017;
   Is_0070 = tmp_str0017;
   tmp_str001A = _Symbol + "(";
   tmp_str001A = tmp_str001A + func_1087(_Period);
   tmp_str001A = tmp_str001A + ")";
   tmp_str001A = tmp_str001A + ": ";
   tmp_str001A = tmp_str001A + tmp_str0017;
   tmp_str0019 = tmp_str001A;
   if (PopupAlert) { 
   Alert(tmp_str0019);
   } 
   else { 
   Print(tmp_str0018);
   } 
   if (PushAlert) { 
   SendNotification(tmp_str0019);
   } 
   if (EmailAlert != false) {
   SendMail(tmp_str0019, tmp_str0018);
   }}
   else{
   tmp_str001A = (string)OrderTicket();
   Gi_000F = ObjectsTotal(-1);
   if (Gi_000F >= 0) { 
   do { 
   tmp_str001B = ObjectName(Gi_000F);
   if (ObjectType(tmp_str001B) == 1) { 
   tmp_str001C = ObjectName(Gi_000F);
   if (StringFind(tmp_str001C, tmp_str001A, 0) >= 0) { 
   tmp_str001D = ObjectName(Gi_000F);
   ObjectDelete(tmp_str001D);
   }} 
   Gi_000F = Gi_000F - 1;
   } while (Gi_000F >= 0); 
   }}} 
   Gi_000D = Gi_000D + 1;
   } while (Gi_000D <= OrdersTotal()); 
   return ;
   } 
   Gi_0010 = Month();
   tmp_str001E = Is_0150;
   Gd_0011 = 0;
   if (GlobalVariableGet(tmp_str001E, Gd_0011) != true) { 
   Gd_0011 = 0;
   } 
   Gi_0012 = (int)Gd_0011;
   if (Gi_0010 == Gi_0012) { 
   Gb_0012 = true;
   } 
   else { 
   Gl_0013 = TimeCurrent();
   tmp_str001F = Is_0120;
   Gd_0014 = 0;
   if (GlobalVariableGet(tmp_str001F, Gd_0014) != true) { 
   Gd_0014 = 0;
   } 
   Gl_0015 = (int)Gd_0014;
   if (Gl_0013 < Gl_0015) { 
   Gb_0012 = true;
   } 
   else { 
   Gb_0012 = false;
   }} 
   if (Gb_0012) return; 
   if (func_1082()) { 
   tmp_str0020 = Comentario;
   if (TipoSL == 0) { 
   Gi_0017 = SL;
   } 
   else { 
   Gi_0017 = 0;
   } 
   Gd_0018 = 0;
   if (TypeOrders == 0) { 
   tmp_str0021 = Is_00C0;
   Gd_0019 = 0;
   if (GlobalVariableGet(tmp_str0021, Gd_0019) != true) { 
   Gd_0019 = 0;
   } 
   Gd_0018 = Gd_0019;
   } 
   else { 
   Gd_0018 = Ask;
   } 
   Li_FFFC = func_1084(Lots, 0, NormalizeDouble(Gd_0018, _Digits), Gi_0017, TP, Ii_0064, tmp_str0020, 16711680);
   if (Li_FFFC > 0) { 
   tmp_str0022 = (string)TimeCurrent();
   tmp_str0022 = "BUY. Hora: " + tmp_str0022;
   tmp_str0023 = tmp_str0022;
   Is_0070 = tmp_str0022;
   tmp_str0025 = _Symbol + "(";
   tmp_str0025 = tmp_str0025 + func_1087(_Period);
   tmp_str0025 = tmp_str0025 + ")";
   tmp_str0025 = tmp_str0025 + ": ";
   tmp_str0025 = tmp_str0025 + tmp_str0022;
   tmp_str0024 = tmp_str0025;
   if (PopupAlert) { 
   Alert(tmp_str0024);
   } 
   else { 
   Print(tmp_str0023);
   } 
   if (PushAlert) { 
   SendNotification(tmp_str0024);
   } 
   if (EmailAlert) { 
   SendMail(tmp_str0024, tmp_str0023);
   } 
   tmp_str0025 = Is_00E0;
   if (GlobalVariableSet(tmp_str0025, 1) == 0) {
   tmp_str0026 = "Se ha producido un error al actualizar la variable global" + Is_00E0;
   tmp_str0026 = tmp_str0026 + " con valor ";
   Gi_001A = _Digits;
   tmp_str0026 = tmp_str0026 + DoubleToString(NormalizeDouble(1, Gi_001A), Gi_001A);
   tmp_str0026 = tmp_str0026 + ". Error ";
   tmp_str0026 = tmp_str0026 + ErrorDescription(GetLastError());
   tmp_str0027 = tmp_str0026;
   Is_0070 = tmp_str0026;
   tmp_str0029 = _Symbol + "(";
   tmp_str0029 = tmp_str0029 + func_1087(_Period);
   tmp_str0029 = tmp_str0029 + ")";
   tmp_str0029 = tmp_str0029 + ": ";
   tmp_str0029 = tmp_str0029 + tmp_str0026;
   tmp_str0028 = tmp_str0029;
   if (PopupAlert) { 
   Alert(tmp_str0028);
   } 
   else { 
   Print(tmp_str0027);
   } 
   if (PushAlert) { 
   SendNotification(tmp_str0028);
   } 
   if (EmailAlert != false) {
   SendMail(tmp_str0028, tmp_str0027);
   }}
   else{
   GlobalVariablesFlush();
   }
   tmp_str0029 = Is_00A0;
   Gd_001A = 0;
   if (GlobalVariableGet(tmp_str0029, Gd_001A) != true) { 
   Gd_001A = 0;
   } 
   Gd_001B = (Gd_001A + 1);
   tmp_str002A = Is_00A0;
   if (GlobalVariableSet(tmp_str002A, Gd_001B) == 0) {
   tmp_str002B = "Se ha producido un error al actualizar la variable global" + Is_00A0;
   tmp_str002B = tmp_str002B + " con valor ";
   Gi_001D = _Digits;
   tmp_str002B = tmp_str002B + DoubleToString(NormalizeDouble(Gd_001B, Gi_001D), Gi_001D);
   tmp_str002B = tmp_str002B + ". Error ";
   tmp_str002B = tmp_str002B + ErrorDescription(GetLastError());
   tmp_str002C = tmp_str002B;
   Is_0070 = tmp_str002B;
   tmp_str002E = _Symbol + "(";
   tmp_str002E = tmp_str002E + func_1087(_Period);
   tmp_str002E = tmp_str002E + ")";
   tmp_str002E = tmp_str002E + ": ";
   tmp_str002E = tmp_str002E + tmp_str002B;
   tmp_str002D = tmp_str002E;
   if (PopupAlert) { 
   Alert(tmp_str002D);
   } 
   else { 
   Print(tmp_str002C);
   } 
   if (PushAlert) { 
   SendNotification(tmp_str002D);
   } 
   if (EmailAlert != false) {
   SendMail(tmp_str002D, tmp_str002C);
   }}
   else{
   GlobalVariablesFlush();
   }
   tmp_str002E = Is_00C0;
   Gd_001D = 0;
   if (GlobalVariableGet(tmp_str002E, Gd_001D) != true) { 
   Gd_001D = 0;
   } 
   tmp_str002F = (string)Li_FFFC;
   tmp_str002F = Is_0110 + tmp_str002F;
   tmp_str0030 = tmp_str002F;
   if (GlobalVariableSet(tmp_str0030, Gd_001D) == 0) {
   tmp_str002F = "Se ha producido un error al actualizar la variable global" + tmp_str002F;
   tmp_str002F = tmp_str002F + " con valor ";
   Gi_001F = _Digits;
   tmp_str002F = tmp_str002F + DoubleToString(NormalizeDouble(Gd_001D, Gi_001F), Gi_001F);
   tmp_str002F = tmp_str002F + ". Error ";
   tmp_str002F = tmp_str002F + ErrorDescription(GetLastError());
   tmp_str0031 = tmp_str002F;
   Is_0070 = tmp_str002F;
   tmp_str0033 = _Symbol + "(";
   tmp_str0033 = tmp_str0033 + func_1087(_Period);
   tmp_str0033 = tmp_str0033 + ")";
   tmp_str0033 = tmp_str0033 + ": ";
   tmp_str0033 = tmp_str0033 + tmp_str002F;
   tmp_str0032 = tmp_str0033;
   if (PopupAlert) { 
   Alert(tmp_str0032);
   } 
   else { 
   Print(tmp_str0031);
   } 
   if (PushAlert) { 
   SendNotification(tmp_str0032);
   } 
   if (EmailAlert != false) {
   SendMail(tmp_str0032, tmp_str0031);
   }}
   else{
   GlobalVariablesFlush();
   }
   tmp_str0033 = Is_0160;
   if (GlobalVariableSet(tmp_str0033, 0) == 0) {
   tmp_str0034 = "Se ha producido un error al actualizar la variable global" + Is_0160;
   tmp_str0034 = tmp_str0034 + " con valor ";
   Gi_0020 = _Digits;
   tmp_str0034 = tmp_str0034 + DoubleToString(NormalizeDouble(0, Gi_0020), Gi_0020);
   tmp_str0034 = tmp_str0034 + ". Error ";
   tmp_str0034 = tmp_str0034 + ErrorDescription(GetLastError());
   tmp_str0035 = tmp_str0034;
   Is_0070 = tmp_str0034;
   tmp_str0037 = _Symbol + "(";
   tmp_str0037 = tmp_str0037 + func_1087(_Period);
   tmp_str0037 = tmp_str0037 + ")";
   tmp_str0037 = tmp_str0037 + ": ";
   tmp_str0037 = tmp_str0037 + tmp_str0034;
   tmp_str0036 = tmp_str0037;
   if (PopupAlert) { 
   Alert(tmp_str0036);
   } 
   else { 
   Print(tmp_str0035);
   } 
   if (PushAlert) { 
   SendNotification(tmp_str0036);
   } 
   if (EmailAlert != false) {
   SendMail(tmp_str0036, tmp_str0035);
   }}
   else{
   GlobalVariablesFlush();
   }}} 
   if (!func_1083()) return; 
   tmp_str0037 = Comentario;
   if (TipoSL == 0) { 
   Gi_0022 = SL;
   } 
   else { 
   Gi_0022 = 0;
   } 
   Gd_0023 = 0;
   if (TypeOrders == 0) { 
   tmp_str0038 = Is_00D0;
   Gd_0024 = 0;
   if (GlobalVariableGet(tmp_str0038, Gd_0024) != true) { 
   Gd_0024 = 0;
   } 
   Gd_0023 = Gd_0024;
   } 
   else { 
   Gd_0023 = Bid;
   } 
   Li_FFF8 = func_1084(Lots, 1, NormalizeDouble(Gd_0023, _Digits), Gi_0022, TP, Ii_0064, tmp_str0037, 255);
   if (Li_FFF8 <= 0) return; 
   tmp_str0039 = (string)TimeCurrent();
   tmp_str0039 = "SELL. Hora: " + tmp_str0039;
   tmp_str003A = tmp_str0039;
   Is_0070 = tmp_str0039;
   tmp_str003C = _Symbol + "(";
   tmp_str003C = tmp_str003C + func_1087(_Period);
   tmp_str003C = tmp_str003C + ")";
   tmp_str003C = tmp_str003C + ": ";
   tmp_str003C = tmp_str003C + tmp_str0039;
   tmp_str003B = tmp_str003C;
   if (PopupAlert) { 
   Alert(tmp_str003B);
   } 
   else { 
   Print(tmp_str003A);
   } 
   if (PushAlert) { 
   SendNotification(tmp_str003B);
   } 
   if (EmailAlert) { 
   SendMail(tmp_str003B, tmp_str003A);
   } 
   tmp_str003C = Is_00F0;
   if (GlobalVariableSet(tmp_str003C, 1) == 0) {
   tmp_str003D = "Se ha producido un error al actualizar la variable global" + Is_00F0;
   tmp_str003D = tmp_str003D + " con valor ";
   Gi_0025 = _Digits;
   tmp_str003D = tmp_str003D + DoubleToString(NormalizeDouble(1, Gi_0025), Gi_0025);
   tmp_str003D = tmp_str003D + ". Error ";
   tmp_str003D = tmp_str003D + ErrorDescription(GetLastError());
   tmp_str003E = tmp_str003D;
   Is_0070 = tmp_str003D;
   tmp_str0040 = _Symbol + "(";
   tmp_str0040 = tmp_str0040 + func_1087(_Period);
   tmp_str0040 = tmp_str0040 + ")";
   tmp_str0040 = tmp_str0040 + ": ";
   tmp_str0040 = tmp_str0040 + tmp_str003D;
   tmp_str003F = tmp_str0040;
   if (PopupAlert) { 
   Alert(tmp_str003F);
   } 
   else { 
   Print(tmp_str003E);
   } 
   if (PushAlert) { 
   SendNotification(tmp_str003F);
   } 
   if (EmailAlert != false) {
   SendMail(tmp_str003F, tmp_str003E);
   }}
   else{
   GlobalVariablesFlush();
   }
   tmp_str0040 = Is_00B0;
   Gd_0025 = 0;
   if (GlobalVariableGet(tmp_str0040, Gd_0025) != true) { 
   Gd_0025 = 0;
   } 
   Gd_0026 = (Gd_0025 + 1);
   tmp_str0041 = Is_00B0;
   if (GlobalVariableSet(tmp_str0041, Gd_0026) == 0) {
   tmp_str0042 = "Se ha producido un error al actualizar la variable global" + Is_00B0;
   tmp_str0042 = tmp_str0042 + " con valor ";
   Gi_0028 = _Digits;
   tmp_str0042 = tmp_str0042 + DoubleToString(NormalizeDouble(Gd_0026, Gi_0028), Gi_0028);
   tmp_str0042 = tmp_str0042 + ". Error ";
   tmp_str0042 = tmp_str0042 + ErrorDescription(GetLastError());
   tmp_str0043 = tmp_str0042;
   Is_0070 = tmp_str0042;
   tmp_str0045 = _Symbol + "(";
   tmp_str0045 = tmp_str0045 + func_1087(_Period);
   tmp_str0045 = tmp_str0045 + ")";
   tmp_str0045 = tmp_str0045 + ": ";
   tmp_str0045 = tmp_str0045 + tmp_str0042;
   tmp_str0044 = tmp_str0045;
   if (PopupAlert) { 
   Alert(tmp_str0044);
   } 
   else { 
   Print(tmp_str0043);
   } 
   if (PushAlert) { 
   SendNotification(tmp_str0044);
   } 
   if (EmailAlert != false) {
   SendMail(tmp_str0044, tmp_str0043);
   }}
   else{
   GlobalVariablesFlush();
   }
   tmp_str0045 = Is_00D0;
   Gd_0028 = 0;
   if (GlobalVariableGet(tmp_str0045, Gd_0028) != true) { 
   Gd_0028 = 0;
   } 
   tmp_str0046 = (string)Li_FFF8;
   tmp_str0046 = Is_0110 + tmp_str0046;
   tmp_str0047 = tmp_str0046;
   if (GlobalVariableSet(tmp_str0047, Gd_0028) == 0) {
   tmp_str0046 = "Se ha producido un error al actualizar la variable global" + tmp_str0046;
   tmp_str0046 = tmp_str0046 + " con valor ";
   Gi_002A = _Digits;
   tmp_str0046 = tmp_str0046 + DoubleToString(NormalizeDouble(Gd_0028, Gi_002A), Gi_002A);
   tmp_str0046 = tmp_str0046 + ". Error ";
   tmp_str0046 = tmp_str0046 + ErrorDescription(GetLastError());
   tmp_str0048 = tmp_str0046;
   Is_0070 = tmp_str0046;
   tmp_str004A = _Symbol + "(";
   tmp_str004A = tmp_str004A + func_1087(_Period);
   tmp_str004A = tmp_str004A + ")";
   tmp_str004A = tmp_str004A + ": ";
   tmp_str004A = tmp_str004A + tmp_str0046;
   tmp_str0049 = tmp_str004A;
   if (PopupAlert) { 
   Alert(tmp_str0049);
   } 
   else { 
   Print(tmp_str0048);
   } 
   if (PushAlert) { 
   SendNotification(tmp_str0049);
   } 
   if (EmailAlert != false) {
   SendMail(tmp_str0049, tmp_str0048);
   }}
   else{
   GlobalVariablesFlush();
   }
   tmp_str004A = Is_0160;
   if (GlobalVariableSet(tmp_str004A, 1) == 0) { 
   tmp_str004B = "Se ha producido un error al actualizar la variable global" + Is_0160;
   tmp_str004B = tmp_str004B + " con valor ";
   Gi_002B = _Digits;
   tmp_str004B = tmp_str004B + DoubleToString(NormalizeDouble(1, Gi_002B), Gi_002B);
   tmp_str004B = tmp_str004B + ". Error ";
   tmp_str004B = tmp_str004B + ErrorDescription(GetLastError());
   tmp_str004C = tmp_str004B;
   Is_0070 = tmp_str004B;
   tmp_str004E = _Symbol + "(";
   tmp_str004E = tmp_str004E + func_1087(_Period);
   tmp_str004E = tmp_str004E + ")";
   tmp_str004E = tmp_str004E + ": ";
   tmp_str004E = tmp_str004E + tmp_str004B;
   tmp_str004D = tmp_str004E;
   if (PopupAlert) { 
   Alert(tmp_str004D);
   } 
   else { 
   Print(tmp_str004C);
   } 
   if (PushAlert) { 
   SendNotification(tmp_str004D);
   } 
   if (EmailAlert == false) return; 
   SendMail(tmp_str004D, tmp_str004C);
   return ;
   } 
   GlobalVariablesFlush();
   
}

void OnDeinit(const int reason)
{
   string tmp_str0000;
   string tmp_str0001;
   string tmp_str0002;

   if (reason != 5 && reason != 6 && reason != 7 && reason != 3 && reason != 9) { 
   tmp_str0000 = (string)Ii_0064;
   Gi_0000 = 0;
   if (GlobalVariablesTotal() > 0) { 
   do { 
   tmp_str0001 = GlobalVariableName(Gi_0000);
   if (StringFind(tmp_str0001, tmp_str0000, 0) >= 0) { 
   tmp_str0002 = GlobalVariableName(Gi_0000);
   GlobalVariableDel(tmp_str0002);
   Gi_0000 = Gi_0000 - 1;
   } 
   Gi_0000 = Gi_0000 + 1;
   } while (Gi_0000 < GlobalVariablesTotal()); 
   }} 
   Comment("");
   EventKillTimer();
}


bool func_1082()
{
   string tmp_str0000;
   string tmp_str0001;
   string tmp_str0002;
   string tmp_str0003;
   string tmp_str0004;
   int Li_FFF8;
   bool Lb_FFFF;
   double Ld_FFF0;

   if (TypeOrders == 0) { 
   tmp_str0000 = Is_00A0;
   Gd_0000 = 0;
   if (GlobalVariableGet(tmp_str0000, Gd_0000) != true) { 
   Gd_0000 = 0;
   } 
   Li_FFF8 = (int)Gd_0000;
   if (Li_FFF8 == 0) { 
   Lb_FFFF = true;
   return Lb_FFFF;
   } 
   if (Li_FFF8 <= 0) return false; 
   tmp_str0001 = Is_00E0;
   Gd_0001 = 0;
   if (GlobalVariableGet(tmp_str0001, Gd_0001) != true) { 
   Gd_0001 = 0;
   } 
   Gb_0002 = Gd_0001;
   if (Gb_0002) return false; 
   Lb_FFFF = true;
   return Lb_FFFF;
   } 
   Gi_0002 = 0;
   Gi_0003 = 1;
   Gb_0004 = false;
   if (OrdersTotal() >= 1) {
   do { 
   if (OrderSelect((Gi_0003 - 1), 0, 0) == true && OrderMagicNumber() == Ii_0064) {
   if (Gi_0002 == 0) {
   if (OrderType() == OP_BUY || OrderType() == OP_BUYLIMIT || OrderType() == OP_BUYSTOP) {
   
   Gb_0004 = true;
   break;
   }}
   if (Gi_0002 == 1) {
   if (OrderType() == OP_SELL || OrderType() == OP_SELLLIMIT || OrderType() == OP_SELLSTOP) {
   
   Gb_0004 = true;
   break;
   }}}
   Gi_0003 = Gi_0003 + 1;
   } while (Gi_0003 <= OrdersTotal()); 
   }
   else Gb_0004 = false;
   
   if (Gb_0004) { 
   Lb_FFFF = false;
   return Lb_FFFF;
   } 
   if (UseSpreadProtect != true) { 
   Gb_0005 = true;
   } 
   else { 
   if ((MarketInfo(_Symbol, MODE_SPREAD) > SpreadMax)) { 
   Gb_0005 = false;
   } 
   else { 
   Gb_0005 = true;
   }} 
   if (Gb_0005 != true) { 
   Lb_FFFF = false;
   return Lb_FFFF;
   } 
   tmp_str0002 = Is_00A0;
   Gd_0006 = 0;
   if (GlobalVariableGet(tmp_str0002, Gd_0006) != true) { 
   Gd_0006 = 0;
   } 
   Gi_0007 = (int)Gd_0006;
   if (Gi_0007 > 0) { 
   tmp_str0003 = Is_00E0;
   Gd_0007 = 0;
   if (GlobalVariableGet(tmp_str0003, Gd_0007) != true) { 
   Gd_0007 = 0;
   } 
   Gb_0008 = Gd_0007;
   if (Gb_0008) { 
   Lb_FFFF = false;
   return Lb_FFFF;
   }} 
   tmp_str0004 = Is_00C0;
   Gd_0008 = 0;
   if (GlobalVariableGet(tmp_str0004, Gd_0008) != true) { 
   Gd_0008 = 0;
   } 
   Ld_FFF0 = NormalizeDouble(Gd_0008, _Digits);
   if (PriceBidBuys) { 
   Gd_0009 = Bid;
   } 
   else { 
   Gd_0009 = Ask;
   } 
   if ((Gd_0009 < Ld_FFF0)) return false; 
   Lb_FFFF = true;
   return Lb_FFFF;
   
   Lb_FFFF = false;
   
   return Lb_FFFF;
}

bool func_1083()
{
   string tmp_str0000;
   string tmp_str0001;
   string tmp_str0002;
   string tmp_str0003;
   string tmp_str0004;
   int Li_FFF8;
   bool Lb_FFFF;
   double Ld_FFF0;

   if (TypeOrders == 0) { 
   tmp_str0000 = Is_00B0;
   Gd_0000 = 0;
   if (GlobalVariableGet(tmp_str0000, Gd_0000) != true) { 
   Gd_0000 = 0;
   } 
   Li_FFF8 = (int)Gd_0000;
   if (Li_FFF8 == 0) { 
   Lb_FFFF = true;
   return Lb_FFFF;
   } 
   if (Li_FFF8 <= 0) return false; 
   tmp_str0001 = Is_00F0;
   Gd_0001 = 0;
   if (GlobalVariableGet(tmp_str0001, Gd_0001) != true) { 
   Gd_0001 = 0;
   } 
   Gb_0002 = Gd_0001;
   if (Gb_0002) return false; 
   Lb_FFFF = true;
   return Lb_FFFF;
   } 
   Gi_0002 = 1;
   Gi_0003 = 1;
   Gb_0004 = false;
   if (OrdersTotal() >= 1) {
   do { 
   if (OrderSelect((Gi_0003 - 1), 0, 0) == true && OrderMagicNumber() == Ii_0064) {
   if (Gi_0002 == 0) {
   if (OrderType() == OP_BUY || OrderType() == OP_BUYLIMIT || OrderType() == OP_BUYSTOP) {
   
   Gb_0004 = true;
   break;
   }}
   if (Gi_0002 == 1) {
   if (OrderType() == OP_SELL || OrderType() == OP_SELLLIMIT || OrderType() == OP_SELLSTOP) {
   
   Gb_0004 = true;
   break;
   }}}
   Gi_0003 = Gi_0003 + 1;
   } while (Gi_0003 <= OrdersTotal()); 
   }
   else Gb_0004 = false;
   
   if (Gb_0004) { 
   Lb_FFFF = false;
   return Lb_FFFF;
   } 
   if (UseSpreadProtect != true) { 
   Gb_0005 = true;
   } 
   else { 
   if ((MarketInfo(_Symbol, MODE_SPREAD) > SpreadMax)) { 
   Gb_0005 = false;
   } 
   else { 
   Gb_0005 = true;
   }} 
   if (Gb_0005 != true) { 
   Lb_FFFF = false;
   return Lb_FFFF;
   } 
   tmp_str0002 = Is_00B0;
   Gd_0006 = 0;
   if (GlobalVariableGet(tmp_str0002, Gd_0006) != true) { 
   Gd_0006 = 0;
   } 
   Gi_0007 = (int)Gd_0006;
   if (Gi_0007 > 0) { 
   tmp_str0003 = Is_00F0;
   Gd_0007 = 0;
   if (GlobalVariableGet(tmp_str0003, Gd_0007) != true) { 
   Gd_0007 = 0;
   } 
   Gb_0008 = Gd_0007;
   if (Gb_0008) { 
   Lb_FFFF = false;
   return Lb_FFFF;
   }} 
   tmp_str0004 = Is_00D0;
   Gd_0008 = 0;
   if (GlobalVariableGet(tmp_str0004, Gd_0008) != true) { 
   Gd_0008 = 0;
   } 
   Ld_FFF0 = NormalizeDouble(Gd_0008, _Digits);
   if ((Bid > Ld_FFF0)) return false; 
   Lb_FFFF = true;
   return Lb_FFFF;
   
   Lb_FFFF = false;
   
   return Lb_FFFF;
}

int func_1084(double Fa_d_00, int Fa_i_01, double Fa_d_02, int Fa_i_03, int Fa_i_04, int Fa_i_05, string Fa_s_06, int Fa_i_07)
{
   string tmp_str0000;
   string tmp_str0001;
   string tmp_str0002;
   string tmp_str0003;
   string Ls_FFF0;
   double Ld_FFE8;
   double Ld_FFE0;
   double Ld_FFD8;
   int Li_FFD4;
   int Li_FFD0;
   int Li_FFCC;
   int Li_FFC8;
   int Li_FFFC;

   Ld_FFE8 = 0;
   Ld_FFE0 = 0;
   Ld_FFD8 = 0;
   Li_FFD4 = 0;
   do { 
   RefreshRates();
   if (IsTradeContextBusy() || IsTradeAllowed() == false) { 
   do { 
   Sleep(30);
   }while (IsTradeContextBusy() || !IsTradeAllowed()) ;
   } 
   Li_FFD0 = -1;
   if (Fa_i_01 == 0) {
   if ((Fa_d_02 >= NormalizeDouble((Ask + NormalizeDouble((NormalizeDouble(NormalizeDouble((MarketInfo(_Symbol, MODE_STOPLEVEL) * _Point), _Digits), _Digits) * _Point), _Digits)), _Digits)) 
   && (Fa_d_02 >= NormalizeDouble((Ask + NormalizeDouble((MarketInfo(_Symbol, MODE_SPREAD) * _Point), _Digits)), _Digits))) {
   Li_FFD0 = 4;
   Ld_FFD8 = Fa_d_02;
   }
   else{
   if ((Fa_d_02 <= NormalizeDouble((Ask - NormalizeDouble((NormalizeDouble(NormalizeDouble((MarketInfo(_Symbol, MODE_STOPLEVEL) * _Point), _Digits), _Digits) * _Point), _Digits)), _Digits)) && (Fa_d_02 <= NormalizeDouble((Ask - NormalizeDouble((MarketInfo(_Symbol, MODE_SPREAD) * _Point), _Digits)), _Digits))) {
   Li_FFD0 = 2;
   Ld_FFD8 = Fa_d_02;
   }
   else{
   Li_FFD0 = 0;
   Ld_FFD8 = Ask;
   }}}
   else{
   if (Fa_i_01 == 1) { 
   if ((Fa_d_02 <= NormalizeDouble((Bid - NormalizeDouble((NormalizeDouble(NormalizeDouble((MarketInfo(_Symbol, MODE_STOPLEVEL) * _Point), _Digits), _Digits) * _Point), _Digits)), _Digits)) && (Fa_d_02 <= NormalizeDouble((Bid - NormalizeDouble((MarketInfo(_Symbol, MODE_SPREAD) * _Point), _Digits)), _Digits))) { 
   Li_FFD0 = 5;
   Ld_FFD8 = Fa_d_02;
   } 
   else { 
   if ((Fa_d_02 >= NormalizeDouble((Bid + NormalizeDouble((NormalizeDouble(NormalizeDouble((MarketInfo(_Symbol, MODE_STOPLEVEL) * _Point), _Digits), _Digits) * _Point), _Digits)), _Digits)) && (Fa_d_02 >= NormalizeDouble((Bid + NormalizeDouble((MarketInfo(_Symbol, MODE_SPREAD) * _Point), _Digits)), _Digits))) { 
   Li_FFD0 = 3;
   Ld_FFD8 = Fa_d_02;
   } 
   else { 
   Li_FFD0 = 1;
   Ld_FFD8 = Bid;
   }}}} 
   if (Fa_i_01 == 0) {
   if (Fa_i_03 != 0) { 
   Ld_FFE8 = (Ld_FFD8 - NormalizeDouble((Fa_i_03 * _Point), _Digits));
   } 
   if (Fa_i_04 != 0) {
   Ld_FFE0 = (Ld_FFD8 + NormalizeDouble((Fa_i_04 * _Point), _Digits));
   }}
   else{
   if (Fa_i_01 == 1) { 
   if (Fa_i_03 != 0) { 
   Ld_FFE8 = (Ld_FFD8 + NormalizeDouble((Fa_i_03 * _Point), _Digits));
   } 
   if (Fa_i_04 != 0) { 
   Ld_FFE0 = (Ld_FFD8 - NormalizeDouble((Fa_i_04 * _Point), _Digits));
   }}} 
   Li_FFCC = OrderSend(_Symbol, Li_FFD0, Fa_d_00, Ld_FFD8, 0, Ld_FFE8, Ld_FFE0, Fa_s_06, Fa_i_05, 0, Fa_i_07);
   if (Li_FFCC < 1) { 
   Sleep(200);
   } 
   else { 
   Li_FFFC = Li_FFCC;
   return Li_FFFC;
   } 
   Li_FFD4 = Li_FFD4 + 1;
   } while (Li_FFD4 <= 5); 
   Gi_0004 = GetLastError();
   Li_FFC8 = Gi_0004;
   tmp_str0000 = "Error al abrir la orden. Error: " + ErrorDescription(Gi_0004);
   tmp_str0000 = tmp_str0000 + " Type: ";
   tmp_str0001 = (string)Fa_i_01;
   tmp_str0000 = tmp_str0000 + tmp_str0001;
   tmp_str0000 = tmp_str0000 + " Volumen: ";
   tmp_str0001 = (string)Fa_d_00;
   tmp_str0000 = tmp_str0000 + tmp_str0001;
   tmp_str0000 = tmp_str0000 + " Price: ";
   tmp_str0001 = (string)Fa_d_02;
   tmp_str0000 = tmp_str0000 + tmp_str0001;
   tmp_str0000 = tmp_str0000 + " SL: ";
   tmp_str0001 = (string)Ld_FFE8;
   tmp_str0000 = tmp_str0000 + tmp_str0001;
   tmp_str0000 = tmp_str0000 + " TP: ";
   tmp_str0001 = (string)Ld_FFE0;
   tmp_str0000 = tmp_str0000 + tmp_str0001;
   tmp_str0001 = tmp_str0000;
   Is_0070 = tmp_str0000;
   tmp_str0003 = _Symbol + "(";
   tmp_str0003 = tmp_str0003 + func_1087(_Period);
   tmp_str0003 = tmp_str0003 + ")";
   tmp_str0003 = tmp_str0003 + ": ";
   tmp_str0003 = tmp_str0003 + tmp_str0000;
   tmp_str0002 = tmp_str0003;
   if (PopupAlert) { 
   Alert(tmp_str0002);
   } 
   else { 
   Print(tmp_str0001);
   } 
   if (PushAlert) { 
   SendNotification(tmp_str0002);
   } 
   if (EmailAlert == false) return -1; 
   SendMail(tmp_str0002, tmp_str0001);
   
   Li_FFFC = -1;
   
   return Li_FFFC;
}

void func_1086()
{
   string tmp_str0000;
   string tmp_str0001;
   string tmp_str0002;
   string tmp_str0003;
   string tmp_str0004;
   string tmp_str0005;
   string tmp_str0006;
   string tmp_str0007;
   string Ls_FFF0;

   tmp_str0000 = Ls_FFF0 + "---------------------------------------------------------";
   tmp_str0000 = tmp_str0000 + "\n";
   Ls_FFF0 = tmp_str0000;
   tmp_str0000 = tmp_str0000 + "Spread ";
   tmp_str0000 = tmp_str0000 + DoubleToString(NormalizeDouble(MarketInfo(_Symbol, MODE_SPREAD), 0), 0);
   tmp_str0000 = tmp_str0000 + " - StopLevel ";
   tmp_str0000 = tmp_str0000 + DoubleToString(NormalizeDouble(NormalizeDouble(NormalizeDouble((MarketInfo(_Symbol, MODE_STOPLEVEL) * _Point), _Digits), _Digits), 0), 0);
   tmp_str0000 = tmp_str0000 + "\n";
   Ls_FFF0 = tmp_str0000;
   tmp_str0000 = tmp_str0000 + "---------------------------------------------------------";
   tmp_str0000 = tmp_str0000 + "\n";
   Ls_FFF0 = tmp_str0000;
   tmp_str0000 = tmp_str0000 + "Profit: ";
   Gi_0001 = 2;
   Gd_0002 = 0;
   Gi_0003 = OrdersTotal();
   if (Gi_0003 >= 1) { 
   do { 
   if (OrderSelect((Gi_0003 - 1), 0, 0) == true && OrderMagicNumber() == Ii_0064) { 
   Gd_0004 = OrderProfit();
   Gd_0004 = (Gd_0004 + OrderCommission());
   Gd_0002 = ((Gd_0004 + OrderSwap()) + Gd_0002);
   } 
   Gi_0003 = Gi_0003 - 1;
   } while (Gi_0003 >= 1); 
   } 
   tmp_str0000 = tmp_str0000 + DoubleToString(NormalizeDouble(NormalizeDouble(NormalizeDouble(Gd_0002, 2), 2), Gi_0001), Gi_0001);
   tmp_str0000 = tmp_str0000 + "\n";
   Ls_FFF0 = tmp_str0000;
   tmp_str0000 = tmp_str0000 + "Órdenes abiertas hoy: ";
   Gi_0004 = 0;
   Gi_0005 = HistoryTotal();
   if (Gi_0005 >= 0) { 
   do { 
   if (OrderSelect((Gi_0005 - 1), 0, 1) == true && OrderMagicNumber() == Ii_0064) { 
   Gl_0006 = OrderOpenTime();
   tmp_str0001 = TimeToString(TimeCurrent(), 1);
   tmp_str0001 = tmp_str0001 + " ";
   tmp_str0001 = tmp_str0001 + "00:00";
   if (Gl_0006 < StringToTime(tmp_str0001)) break; 
   tmp_str0002 = OrderComment();
   if (StringFind(tmp_str0002, "to #", 0) < 0) { 
   if (OrderType() == OP_BUY || OrderType() == OP_SELL) { 
   
   Gi_0004 = Gi_0004 + 1;
   }}} 
   Gi_0005 = Gi_0005 - 1;
   } while (Gi_0005 >= 0); 
   } 
   Gi_0007 = OrdersTotal();
   if (Gi_0007 >= 0) { 
   do { 
   if (OrderSelect((Gi_0007 - 1), 0, 0) == true && OrderMagicNumber() == Ii_0064) { 
   tmp_str0003 = OrderComment();
   if (StringFind(tmp_str0003, "to #", 0) < 0) { 
   if (OrderType() == OP_BUY || OrderType() == OP_SELL) { 
   
   Gi_0004 = Gi_0004 + 1;
   }}} 
   Gi_0007 = Gi_0007 - 1;
   } while (Gi_0007 >= 0); 
   } 
   tmp_str0004 = (string)Gi_0004;
   tmp_str0000 = tmp_str0000 + tmp_str0004;
   tmp_str0000 = tmp_str0000 + "\n";
   Ls_FFF0 = tmp_str0000;
   tmp_str0004 = tmp_str0000 + "---------------------------------------------------------";
   tmp_str0004 = tmp_str0004 + "\n";
   Ls_FFF0 = tmp_str0004;
   if ((TPMonth != 0)) { 
   Ls_FFF0 = Ls_FFF0 + "PROFIT MENSUAL ACTIVADO \n";
   tmp_str0004 = Ls_FFF0 + "Balance inicial: ";
   Gi_0008 = 2;
   tmp_str0005 = Is_0130;
   Gd_0009 = 0;
   if (GlobalVariableGet(tmp_str0005, Gd_0009) != true) { 
   Gd_0009 = 0;
   } 
   tmp_str0004 = tmp_str0004 + DoubleToString(NormalizeDouble(Gd_0009, Gi_0008), Gi_0008);
   tmp_str0004 = tmp_str0004 + "\n";
   Ls_FFF0 = tmp_str0004;
   tmp_str0004 = tmp_str0004 + "Equity: ";
   tmp_str0004 = tmp_str0004 + DoubleToString(NormalizeDouble(AccountEquity(), 2), 2);
   tmp_str0004 = tmp_str0004 + "\n";
   Ls_FFF0 = tmp_str0004;
   tmp_str0004 = tmp_str0004 + "Objetivo: ";
   tmp_str0004 = tmp_str0004 + DoubleToString(NormalizeDouble(TPMonth, 2), 2);
   tmp_str0004 = tmp_str0004 + "% \n";
   Ls_FFF0 = tmp_str0004;
   tmp_str0004 = tmp_str0004 + "Profit actual: ";
   Gi_000A = 6;
   Gd_000B = (AccountEquity() * 100);
   tmp_str0006 = Is_0130;
   Gd_000C = 0;
   if (GlobalVariableGet(tmp_str0006, Gd_000C) != true) { 
   Gd_000C = 0;
   } 
   tmp_str0004 = tmp_str0004 + DoubleToString(NormalizeDouble(((Gd_000B / Gd_000C) - 100), Gi_000A), Gi_000A);
   tmp_str0004 = tmp_str0004 + " \n";
   Ls_FFF0 = tmp_str0004;
   tmp_str0004 = Is_0150;
   Gd_000B = 0;
   if (GlobalVariableGet(tmp_str0004, Gd_000B) != true) { 
   Gd_000B = 0;
   } 
   if ((Gd_000B == Month())) { 
   tmp_str0007 = Ls_FFF0 + "---------------------------------------------------------";
   tmp_str0007 = tmp_str0007 + "\n";
   Ls_FFF0 = tmp_str0007;
   Ls_FFF0 = tmp_str0007 + "EA PARALIZADO POR ALCANZAR EL PROFIT MENSUAL.\n";
   Ls_FFF0 = Ls_FFF0 + "SERÁ INICIADO EL DÍA 1 DEL PRÓXIMO MES\n";
   }} 
   tmp_str0007 = Ls_FFF0 + "      --------- log status ---------   ";
   tmp_str0007 = tmp_str0007 + "\n";
   Ls_FFF0 = tmp_str0007;
   Ls_FFF0 = tmp_str0007 + Is_0070;
   Comment(Ls_FFF0);
}

string func_1087(int Fa_i_00)
{
   string tmp_str0000;

   returned_i = Fa_i_00;
   if (returned_i >= 1 && returned_i <= 43200) { 
   if (returned_i == 1) {
   
   tmp_str0000 = "M1";
   return tmp_str0000;
   }
   if (returned_i == 5) {
   
   tmp_str0000 = "M5";
   return tmp_str0000;
   }
   if (returned_i == 15) {
   
   tmp_str0000 = "M15";
   return tmp_str0000;
   }
   if (returned_i == 30) {
   
   tmp_str0000 = "M30";
   return tmp_str0000;
   }
   if (returned_i == 60) {
   
   tmp_str0000 = "H1";
   return tmp_str0000;
   }
   if (returned_i == 240) {
   
   tmp_str0000 = "H4";
   return tmp_str0000;
   }
   if (returned_i == 1440) {
   
   tmp_str0000 = "D1";
   return tmp_str0000;
   }
   if (returned_i == 10080) {
   
   tmp_str0000 = "W1";
   return tmp_str0000;
   }
   if (returned_i == 43200) {
   
   tmp_str0000 = "MN";
   return tmp_str0000;
   }} 
   tmp_str0000 = func_1087(_Period);
   
   return tmp_str0000;
}

int func_1095(int Fa_i_00)
{
   int Li_FFFC;

   returned_i = Fa_i_00;
   if (returned_i > 5) return (int)4294967295; 
   
   Li_FFFC = 16711680;
   return Li_FFFC;
   
   Li_FFFC = 255;
   return Li_FFFC;
   
   Li_FFFC = 16711680;
   return Li_FFFC;
   
   Li_FFFC = 16711680;
   return Li_FFFC;
   
   Li_FFFC = 255;
   return Li_FFFC;
   
   Li_FFFC = 255;
   return Li_FFFC;
   
   Li_FFFC = (int)4294967295;
   
   return Li_FFFC;
}

int func_1097(int Fa_i_00)
{
   int Li_FFFC;

   returned_i = Fa_i_00;
   if (returned_i > 5) return (int)4294967295; 
   
   Li_FFFC = 16711680;
   return Li_FFFC;
   
   Li_FFFC = 255;
   return Li_FFFC;
   
   Li_FFFC = 16711680;
   return Li_FFFC;
   
   Li_FFFC = 255;
   return Li_FFFC;
   
   Li_FFFC = 16711680;
   return Li_FFFC;
   
   Li_FFFC = 255;
   return Li_FFFC;
   
   Li_FFFC = (int)4294967295;
   
   return Li_FFFC;
}

bool func_1098(int Fa_i_00)
{
   string tmp_str0000;
   string tmp_str0001;
   string tmp_str0002;
   string tmp_str0003;
   string tmp_str0004;
   string tmp_str0005;
   string tmp_str0006;
   string tmp_str0007;
   double Ld_FFF0;
   int Li_FFEC;
   double Ld_FFE0;
   int Li_FFDC;
   bool Lb_FFFF;
   int Li_FFD8;

   Ld_FFF0 = 0;
   Li_FFEC = 0;
   do { 
   if (IsTradeContextBusy() || IsTradeAllowed() == false) { 
   do { 
   Sleep(30);
   }while (IsTradeContextBusy() || !IsTradeAllowed()) ;
   } 
   RefreshRates();
   Gd_0000 = (OrderLots() / 100);
   Ld_FFE0 = NormalizeDouble((Gd_0000 * Fa_i_00), 2);
   Li_FFDC = OrderTicket();
   Gi_0000 = func_1095(OrderType());
   if (OrderClose(OrderTicket(), Ld_FFE0, OrderClosePrice(), 0, Gi_0000)) { 
   tmp_str0000 = (string)Li_FFDC;
   Gi_0002 = ObjectsTotal(-1);
   if (Gi_0002 >= 0) { 
   do { 
   tmp_str0001 = ObjectName(Gi_0002);
   if (ObjectType(tmp_str0001) == 1) { 
   tmp_str0002 = ObjectName(Gi_0002);
   if (StringFind(tmp_str0002, tmp_str0000, 0) >= 0) { 
   tmp_str0003 = ObjectName(Gi_0002);
   ObjectDelete(tmp_str0003);
   }} 
   Gi_0002 = Gi_0002 - 1;
   } while (Gi_0002 >= 0); 
   } 
   Lb_FFFF = true;
   return Lb_FFFF;
   } 
   Sleep(200);
   Li_FFEC = Li_FFEC + 1;
   } while (Li_FFEC <= 10); 
   Gi_0003 = GetLastError();
   Li_FFD8 = Gi_0003;
   tmp_str0004 = "Error al cerrar la orden. Error: " + ErrorDescription(Gi_0003);
   tmp_str0004 = tmp_str0004 + " Ticket ";
   tmp_str0004 = tmp_str0004 + IntegerToString(OrderTicket(), 0, 32);
   tmp_str0005 = tmp_str0004;
   Is_0070 = tmp_str0004;
   tmp_str0007 = _Symbol + "(";
   tmp_str0007 = tmp_str0007 + func_1087(_Period);
   tmp_str0007 = tmp_str0007 + ")";
   tmp_str0007 = tmp_str0007 + ": ";
   tmp_str0007 = tmp_str0007 + tmp_str0004;
   tmp_str0006 = tmp_str0007;
   if (PopupAlert) { 
   Alert(tmp_str0006);
   } 
   else { 
   Print(tmp_str0005);
   } 
   if (PushAlert) { 
   SendNotification(tmp_str0006);
   } 
   if (EmailAlert == false) return false; 
   SendMail(tmp_str0006, tmp_str0005);
   
   Lb_FFFF = false;
   
   return Lb_FFFF;
}

void func_1100()
{
   string tmp_str0000;
   string tmp_str0001;
   string tmp_str0002;
   string tmp_str0003;
   int Li_FFFC;

   Gi_0000 = 1;
   Gi_0001 = -1;
   if (OrdersTotal() >= 1) {
   do { 
   if (OrderSelect((Gi_0000 - 1), 0, 0) == true && OrderMagicNumber() == Ii_0064) {
   if (OrderType() == OP_BUY || OrderType() == OP_SELL) {
   
   Gi_0001 = OrderType();
   break;
   }}
   Gi_0000 = Gi_0000 + 1;
   } while (Gi_0000 <= OrdersTotal()); 
   }
   else Gi_0001 = -1;
   
   if (Gi_0001 == -1) return; 
   do { 
   Li_FFFC = OrdersTotal();
   if (Li_FFFC > 0) { 
   do { 
   if (OrderSelect((Li_FFFC - 1), 0, 0) == true && OrderMagicNumber() == Ii_0064) { 
   if (OrderType() != OP_BUY && OrderType() != OP_SELL) {
   Gi_0002 = func_1097(OrderType());
   if (!OrderDelete(OrderTicket(), Gi_0002)) {
   tmp_str0000 = "Error al eliminar la orden pendiente. Error: " + ErrorDescription(GetLastError());
   tmp_str0000 = tmp_str0000 + " Función: ";
   tmp_str0000 = tmp_str0000 + "orderDelete";
   tmp_str0001 = tmp_str0000;
   Is_0070 = tmp_str0000;
   tmp_str0003 = _Symbol + "(";
   tmp_str0003 = tmp_str0003 + func_1087(_Period);
   tmp_str0003 = tmp_str0003 + ")";
   tmp_str0003 = tmp_str0003 + ": ";
   tmp_str0003 = tmp_str0003 + tmp_str0000;
   tmp_str0002 = tmp_str0003;
   if (PopupAlert) { 
   Alert(tmp_str0002);
   } 
   else { 
   Print(tmp_str0001);
   } 
   if (PushAlert) { 
   SendNotification(tmp_str0002);
   } 
   if (EmailAlert != false) {
   SendMail(tmp_str0002, tmp_str0001);
   }}}
   else{
   if (func_1098(100)) { 
   tmp_str0003 = "Se ha cerrado la orden con ticket " + IntegerToString(OrderTicket(), 0, 32);
   tmp_str0003 = tmp_str0003 + " con un profit de ";
   tmp_str0003 = tmp_str0003 + DoubleToString(NormalizeDouble(OrderProfit(), 2), 2);
   tmp_str0003 = tmp_str0003 + ".";
   Print(tmp_str0003);
   }}} 
   Li_FFFC = Li_FFFC - 1;
   } while (Li_FFFC > 0); 
   } 
   Sleep(1000);
   Gi_0003 = 1;
   Gi_0004 = -1;
   if (OrdersTotal() >= 1) {
   do { 
   if (OrderSelect((Gi_0003 - 1), 0, 0) == true && OrderMagicNumber() == Ii_0064) {
   if (OrderType() == OP_BUY || OrderType() == OP_SELL) {
   
   Gi_0004 = OrderType();
   break;
   }}
   Gi_0003 = Gi_0003 + 1;
   } while (Gi_0003 <= OrdersTotal()); 
   }
   else Gi_0004 = -1;
   
   } while (Gi_0004 != -1); 
   
}

void func_1110()
{
   string tmp_str0000;
   string tmp_str0001;
   string tmp_str0002;
   string tmp_str0003;
   string tmp_str0004;
   string tmp_str0005;
   string tmp_str0006;
   string tmp_str0007;
   string tmp_str0008;
   string tmp_str0009;
   string tmp_str000A;
   string tmp_str000B;
   string tmp_str000C;
   string tmp_str000D;
   string tmp_str000E;
   string tmp_str000F;
   string tmp_str0010;
   string tmp_str0011;
   string tmp_str0012;
   string tmp_str0013;
   string tmp_str0014;
   string tmp_str0015;

   tmp_str0000 = TimeToString(TimeCurrent(), 1);
   tmp_str0000 = tmp_str0000 + " ";
   tmp_str0000 = tmp_str0000 + IniRango;
   tmp_str0001 = TimeToString(TimeCurrent(), 1);
   tmp_str0001 = tmp_str0001 + " ";
   tmp_str0001 = tmp_str0001 + EndRango;
   Gi_0003 = iHighest(_Symbol, 0, 2, iBarShift(_Symbol, 0, StringToTime(tmp_str0000), false), iBarShift(_Symbol, 0, StringToTime(tmp_str0001), false));
   returned_double = NormalizeDouble(High[Gi_0003], _Digits);
   tmp_str0002 = Is_00C0;
   if (GlobalVariableSet(tmp_str0002, returned_double) == 0) {
   tmp_str0003 = "Se ha producido un error al actualizar la variable global" + Is_00C0;
   tmp_str0003 = tmp_str0003 + " con valor ";
   Gi_0007 = _Digits;
   tmp_str0003 = tmp_str0003 + DoubleToString(NormalizeDouble(returned_double, Gi_0007), Gi_0007);
   tmp_str0003 = tmp_str0003 + ". Error ";
   tmp_str0003 = tmp_str0003 + ErrorDescription(GetLastError());
   tmp_str0004 = tmp_str0003;
   Is_0070 = tmp_str0003;
   tmp_str0006 = _Symbol + "(";
   tmp_str0006 = tmp_str0006 + func_1087(_Period);
   tmp_str0006 = tmp_str0006 + ")";
   tmp_str0006 = tmp_str0006 + ": ";
   tmp_str0006 = tmp_str0006 + tmp_str0003;
   tmp_str0005 = tmp_str0006;
   if (PopupAlert) { 
   Alert(tmp_str0005);
   } 
   else { 
   Print(tmp_str0004);
   } 
   if (PushAlert) { 
   SendNotification(tmp_str0005);
   } 
   if (EmailAlert != false) {
   SendMail(tmp_str0005, tmp_str0004);
   }}
   else{
   GlobalVariablesFlush();
   }
   tmp_str0006 = TimeToString(TimeCurrent(), 1);
   tmp_str0006 = tmp_str0006 + " ";
   tmp_str0006 = tmp_str0006 + IniRango;
   tmp_str0007 = TimeToString(TimeCurrent(), 1);
   tmp_str0007 = tmp_str0007 + " ";
   tmp_str0007 = tmp_str0007 + EndRango;
   Gi_000A = iLowest(_Symbol, 0, 1, iBarShift(_Symbol, 0, StringToTime(tmp_str0006), false), iBarShift(_Symbol, 0, StringToTime(tmp_str0007), false));
   returned_double = NormalizeDouble(Low[Gi_000A], _Digits);
   tmp_str0008 = Is_00D0;
   if (GlobalVariableSet(tmp_str0008, returned_double) == 0) {
   tmp_str0009 = "Se ha producido un error al actualizar la variable global" + Is_00D0;
   tmp_str0009 = tmp_str0009 + " con valor ";
   Gi_000E = _Digits;
   tmp_str0009 = tmp_str0009 + DoubleToString(NormalizeDouble(returned_double, Gi_000E), Gi_000E);
   tmp_str0009 = tmp_str0009 + ". Error ";
   tmp_str0009 = tmp_str0009 + ErrorDescription(GetLastError());
   tmp_str000A = tmp_str0009;
   Is_0070 = tmp_str0009;
   tmp_str000C = _Symbol + "(";
   tmp_str000C = tmp_str000C + func_1087(_Period);
   tmp_str000C = tmp_str000C + ")";
   tmp_str000C = tmp_str000C + ": ";
   tmp_str000C = tmp_str000C + tmp_str0009;
   tmp_str000B = tmp_str000C;
   if (PopupAlert) { 
   Alert(tmp_str000B);
   } 
   else { 
   Print(tmp_str000A);
   } 
   if (PushAlert) { 
   SendNotification(tmp_str000B);
   } 
   if (EmailAlert != false) {
   SendMail(tmp_str000B, tmp_str000A);
   }}
   else{
   GlobalVariablesFlush();
   }
   Gb_000E = false;
   Gi_000F = 14917376;
   tmp_str000C = TimeToString(TimeCurrent(), 1);
   tmp_str000C = tmp_str000C + " ";
   tmp_str000C = tmp_str000C + EndRango;
   tmp_str000D = Is_00D0;
   Gd_0011 = 0;
   if (GlobalVariableGet(tmp_str000D, Gd_0011) != true) { 
   Gd_0011 = 0;
   } 
   tmp_str000E = TimeToString(TimeCurrent(), 1);
   tmp_str000E = tmp_str000E + " ";
   tmp_str000E = tmp_str000E + IniRango;
   tmp_str000F = Is_00C0;
   Gd_0014 = 0;
   if (GlobalVariableGet(tmp_str000F, Gd_0014) != true) { 
   Gd_0014 = 0;
   } 
   tmp_str0010 = (string)DayOfYear();
   tmp_str0010 = "Rec_" + tmp_str0010;
   if (ObjectFind(0, tmp_str0010) >= 0) { 
   ObjectDelete(0, tmp_str0010);
   } 
   func_1112(0, tmp_str0010, 0, StringToTime(tmp_str000E), Gd_0014, StringToTime(tmp_str000C), Gd_0011, Gi_000F, 0, 1, false, true, Gb_000E, true, 0);
   Gd_0016 = DayOfYear();
   tmp_str0011 = Is_0090;
   if (GlobalVariableSet(tmp_str0011, Gd_0016) == 0) { 
   tmp_str0012 = "Se ha producido un error al actualizar la variable global" + Is_0090;
   tmp_str0012 = tmp_str0012 + " con valor ";
   Gi_0018 = _Digits;
   tmp_str0012 = tmp_str0012 + DoubleToString(NormalizeDouble(Gd_0016, Gi_0018), Gi_0018);
   tmp_str0012 = tmp_str0012 + ". Error ";
   tmp_str0012 = tmp_str0012 + ErrorDescription(GetLastError());
   tmp_str0013 = tmp_str0012;
   Is_0070 = tmp_str0012;
   tmp_str0015 = _Symbol + "(";
   tmp_str0015 = tmp_str0015 + func_1087(_Period);
   tmp_str0015 = tmp_str0015 + ")";
   tmp_str0015 = tmp_str0015 + ": ";
   tmp_str0015 = tmp_str0015 + tmp_str0012;
   tmp_str0014 = tmp_str0015;
   if (PopupAlert) { 
   Alert(tmp_str0014);
   } 
   else { 
   Print(tmp_str0013);
   } 
   if (PushAlert) { 
   SendNotification(tmp_str0014);
   } 
   if (EmailAlert == false) return; 
   SendMail(tmp_str0014, tmp_str0013);
   return ;
   } 
   GlobalVariablesFlush();
   
}

bool func_1112(long Fa_l_00, string Fa_s_01, int Fa_i_02, long Fa_l_03, double Fa_d_04, long Fa_l_05, double Fa_d_06, int Fa_i_07, int Fa_i_08, int Fa_i_09, bool FuncArg_Boolean_0000000A, bool FuncArg_Boolean_0000000B, bool FuncArg_Boolean_0000000C, bool FuncArg_Boolean_0000000D, long Fa_l_0E)
{
   string tmp_str0000;
   bool Lb_FFFF;

   if (Fa_l_03 == 0) { 
   Fa_l_03 = TimeCurrent();
   } 
   if (Fa_d_04 == 0) { 
   Fa_d_04 = SymbolInfoDouble(NULL, SYMBOL_BID);
   } 
   if (Fa_l_05 == 0) { 
   long Ll_FFAC[10];
   CopyTime(NULL, _Period, (int)Fa_l_03, 10, Ll_FFAC);
   Fa_l_05 = Ll_FFAC[0];
   ArrayFree(Ll_FFAC);
   } 
   if (Fa_d_06 == 0) { 
   Gd_0005 = (SymbolInfoDouble(NULL, SYMBOL_POINT) * 300);
   Fa_d_06 = (Fa_d_04 - Gd_0005);
   } 
   if (ObjectCreate(Fa_l_00, Fa_s_01, OBJ_RECTANGLE, Fa_i_02, Fa_l_03, Fa_d_04, Fa_l_05, Fa_d_06) != true) { 
   tmp_str0000 = ": failed to create a rectangle! Name: " + Fa_s_01;
   tmp_str0000 = tmp_str0000 + "  Error code = ";
   Print("RectangleCreate", tmp_str0000, GetLastError());
   Lb_FFFF = false;
   return Lb_FFFF;
   } 
   ObjectSetInteger(Fa_l_00, Fa_s_01, 6, Fa_i_07);
   ObjectSetInteger(Fa_l_00, Fa_s_01, 7, Fa_i_08);
   ObjectSetInteger(Fa_l_00, Fa_s_01, 8, Fa_i_09);
   ObjectSetInteger(Fa_l_00, Fa_s_01, 9, FuncArg_Boolean_0000000B);
   ObjectSetInteger(Fa_l_00, Fa_s_01, 1000, FuncArg_Boolean_0000000C);
   ObjectSetInteger(Fa_l_00, Fa_s_01, 17, FuncArg_Boolean_0000000C);
   ObjectSetInteger(Fa_l_00, Fa_s_01, 208, FuncArg_Boolean_0000000D);
   ObjectSetInteger(Fa_l_00, Fa_s_01, 207, Fa_l_0E);
   ObjectSetInteger(Fa_l_00, Fa_s_01, 1025, Fa_i_07);
   Lb_FFFF = true;
   
   return Lb_FFFF;
}

bool func_1116(string Fa_s_00)
{
   string tmp_str0000;
   string tmp_str0001;
   long Ll_FFF0;
   long Ll_FFE8;
   bool Lb_FFFF;

   Ll_FFF0 = 0;
   Ll_FFE8 = 0;
   Gi_0000 = StringLen(Fa_s_00);
   if (Gi_0000 != 5) { 
   Lb_FFFF = false;
   return Lb_FFFF;
   } 
   if (StringFind(Fa_s_00, ":", 0) != 2) { 
   Lb_FFFF = false;
   return Lb_FFFF;
   } 
   tmp_str0000 = StringSubstr(Fa_s_00, 0, 2);
   Ll_FFF0 = StringToInteger(tmp_str0000);
   if (Ll_FFF0 < 0 || Ll_FFF0 > 23) { 
   
   Lb_FFFF = false;
   return Lb_FFFF;
   } 
   if (Ll_FFF0 == 0 && StringSubstr(Fa_s_00, 0, 2) != "00") { 
   Lb_FFFF = false;
   return Lb_FFFF;
   } 
   tmp_str0001 = StringSubstr(Fa_s_00, 3, 2);
   Ll_FFE8 = StringToInteger(tmp_str0001);
   if (Ll_FFE8 < 0 || Ll_FFE8 > 59) { 
   
   Lb_FFFF = false;
   return Lb_FFFF;
   } 
   if (Ll_FFE8 != 0) return true; 
   if (StringSubstr(Fa_s_00, 3, 2) == "00") return true; 
   Lb_FFFF = false;
   return Lb_FFFF;
   
   Lb_FFFF = true;
   
   return Lb_FFFF;
}

void func_1128()
{
   string tmp_str0000;
   string tmp_str0001;
   string tmp_str0002;
   string tmp_str0003;
   string tmp_str0004;
   string tmp_str0005;
   string tmp_str0006;
   string tmp_str0007;
   string tmp_str0008;
   string tmp_str0009;
   string tmp_str000A;
   string tmp_str000B;
   string tmp_str000C;

   tmp_str0000 = Is_00E0;
   Gd_0000 = 0;
   if (GlobalVariableGet(tmp_str0000, Gd_0000) != true) { 
   Gd_0000 = 0;
   } 
   Gb_0001 = Gd_0000;
   if (Gb_0001) { 
   tmp_str0001 = Is_00C0;
   Gd_0001 = 0;
   if (GlobalVariableGet(tmp_str0001, Gd_0001) != true) { 
   Gd_0001 = 0;
   } 
   if ((Bid <= NormalizeDouble((Gd_0001 - NormalizeDouble((SL * _Point), _Digits)), _Digits))) { 
   Gi_0002 = 0;
   Gi_0003 = 1;
   Gb_0004 = false;
   if (OrdersTotal() >= 1) {
   do { 
   if (OrderSelect((Gi_0003 - 1), 0, 0) == true && OrderMagicNumber() == Ii_0064) {
   if (Gi_0002 == 0) {
   if (OrderType() == OP_BUY || OrderType() == OP_BUYLIMIT || OrderType() == OP_BUYSTOP) {
   
   Gb_0004 = true;
   break;
   }}
   if (Gi_0002 == 1) {
   if (OrderType() == OP_SELL || OrderType() == OP_SELLLIMIT || OrderType() == OP_SELLSTOP) {
   
   Gb_0004 = true;
   break;
   }}}
   Gi_0003 = Gi_0003 + 1;
   } while (Gi_0003 <= OrdersTotal()); 
   }
   else Gb_0004 = false;
   
   if (Gb_0004 != true) { 
   tmp_str0002 = Is_00E0;
   if (GlobalVariableSet(tmp_str0002, 0) == 0) {
   tmp_str0003 = "Se ha producido un error al actualizar la variable global" + Is_00E0;
   tmp_str0003 = tmp_str0003 + " con valor ";
   Gi_0006 = _Digits;
   tmp_str0003 = tmp_str0003 + DoubleToString(NormalizeDouble(0, Gi_0006), Gi_0006);
   tmp_str0003 = tmp_str0003 + ". Error ";
   tmp_str0003 = tmp_str0003 + ErrorDescription(GetLastError());
   tmp_str0004 = tmp_str0003;
   Is_0070 = tmp_str0003;
   tmp_str0006 = _Symbol + "(";
   tmp_str0006 = tmp_str0006 + func_1087(_Period);
   tmp_str0006 = tmp_str0006 + ")";
   tmp_str0006 = tmp_str0006 + ": ";
   tmp_str0006 = tmp_str0006 + tmp_str0003;
   tmp_str0005 = tmp_str0006;
   if (PopupAlert) { 
   Alert(tmp_str0005);
   } 
   else { 
   Print(tmp_str0004);
   } 
   if (PushAlert) { 
   SendNotification(tmp_str0005);
   } 
   if (EmailAlert != false) {
   SendMail(tmp_str0005, tmp_str0004);
   }}
   else{
   GlobalVariablesFlush();
   }}}} 
   tmp_str0006 = Is_00F0;
   Gd_0006 = 0;
   if (GlobalVariableGet(tmp_str0006, Gd_0006) != true) { 
   Gd_0006 = 0;
   } 
   Gb_0007 = Gd_0006;
   if (Gb_0007 == false) return; 
   tmp_str0007 = Is_00D0;
   Gd_0007 = 0;
   if (GlobalVariableGet(tmp_str0007, Gd_0007) != true) { 
   Gd_0007 = 0;
   } 
   if ((Bid < NormalizeDouble((Gd_0007 + NormalizeDouble((SL * _Point), _Digits)), _Digits))) return; 
   Gi_0008 = 1;
   Gi_0009 = 1;
   Gb_000A = false;
   if (OrdersTotal() >= 1) {
   do { 
   if (OrderSelect((Gi_0009 - 1), 0, 0) == true && OrderMagicNumber() == Ii_0064) {
   if (Gi_0008 == 0) {
   if (OrderType() == OP_BUY || OrderType() == OP_BUYLIMIT || OrderType() == OP_BUYSTOP) {
   
   Gb_000A = true;
   break;
   }}
   if (Gi_0008 == 1) {
   if (OrderType() == OP_SELL || OrderType() == OP_SELLLIMIT || OrderType() == OP_SELLSTOP) {
   
   Gb_000A = true;
   break;
   }}}
   Gi_0009 = Gi_0009 + 1;
   } while (Gi_0009 <= OrdersTotal()); 
   }
   else Gb_000A = false;
   
   if (Gb_000A) return; 
   tmp_str0008 = Is_00F0;
   if (GlobalVariableSet(tmp_str0008, 0) == 0) { 
   tmp_str0009 = "Se ha producido un error al actualizar la variable global" + Is_00F0;
   tmp_str0009 = tmp_str0009 + " con valor ";
   Gi_000C = _Digits;
   tmp_str0009 = tmp_str0009 + DoubleToString(NormalizeDouble(0, Gi_000C), Gi_000C);
   tmp_str0009 = tmp_str0009 + ". Error ";
   tmp_str0009 = tmp_str0009 + ErrorDescription(GetLastError());
   tmp_str000A = tmp_str0009;
   Is_0070 = tmp_str0009;
   tmp_str000C = _Symbol + "(";
   tmp_str000C = tmp_str000C + func_1087(_Period);
   tmp_str000C = tmp_str000C + ")";
   tmp_str000C = tmp_str000C + ": ";
   tmp_str000C = tmp_str000C + tmp_str0009;
   tmp_str000B = tmp_str000C;
   if (PopupAlert) { 
   Alert(tmp_str000B);
   } 
   else { 
   Print(tmp_str000A);
   } 
   if (PushAlert) { 
   SendNotification(tmp_str000B);
   } 
   if (EmailAlert == false) return; 
   SendMail(tmp_str000B, tmp_str000A);
   return ;
   } 
   GlobalVariablesFlush();
   
}

bool func_1135()
{
   string tmp_str0000;
   string tmp_str0001;
   string tmp_str0002;
   string tmp_str0003;
   bool Lb_FFFF;

   if (MaxOrdersDay == 0) { 
   Lb_FFFF = true;
   return Lb_FFFF;
   } 
   Gi_0000 = 0;
   Gi_0001 = HistoryTotal();
   if (Gi_0001 >= 0) { 
   do { 
   if (OrderSelect((Gi_0001 - 1), 0, 1) == true && OrderMagicNumber() == Ii_0064) { 
   Gl_0002 = OrderOpenTime();
   tmp_str0000 = TimeToString(TimeCurrent(), 1);
   tmp_str0000 = tmp_str0000 + " ";
   tmp_str0000 = tmp_str0000 + "00:00";
   if (Gl_0002 < StringToTime(tmp_str0000)) break; 
   tmp_str0001 = OrderComment();
   if (StringFind(tmp_str0001, "to #", 0) < 0) { 
   if (OrderType() == OP_BUY || OrderType() == OP_SELL) { 
   
   Gi_0000 = Gi_0000 + 1;
   }}} 
   Gi_0001 = Gi_0001 - 1;
   } while (Gi_0001 >= 0); 
   } 
   Gi_0003 = OrdersTotal();
   if (Gi_0003 >= 0) { 
   do { 
   if (OrderSelect((Gi_0003 - 1), 0, 0) == true && OrderMagicNumber() == Ii_0064) { 
   tmp_str0002 = OrderComment();
   if (StringFind(tmp_str0002, "to #", 0) < 0) { 
   if (OrderType() == OP_BUY || OrderType() == OP_SELL) { 
   
   Gi_0000 = Gi_0000 + 1;
   }}} 
   Gi_0003 = Gi_0003 - 1;
   } while (Gi_0003 >= 0); 
   } 
   if (Gi_0000 >= MaxOrdersDay) { 
   Lb_FFFF = false;
   return Lb_FFFF;
   } 
   tmp_str0003 = Is_0100;
   Gd_0004 = 0;
   if (GlobalVariableGet(tmp_str0003, Gd_0004) != true) { 
   Gd_0004 = 0;
   } 
   Gi_0005 = (int)Gd_0004;
   if (Gi_0005 != DayOfYear()) return true; 
   Lb_FFFF = false;
   return Lb_FFFF;
   
   Lb_FFFF = true;
   
   return Lb_FFFF;
}

bool func_1139()
{
   string tmp_str0000;
   string tmp_str0001;
   string tmp_str0002;
   string tmp_str0003;
   string tmp_str0004;
   string tmp_str0005;
   string tmp_str0006;
   string tmp_str0007;
   string tmp_str0008;
   string tmp_str0009;
   string tmp_str000A;
   string tmp_str000B;
   string tmp_str000C;
   string tmp_str000D;
   string tmp_str000E;
   bool Lb_FFFF;

   Gi_0000 = HistoryTotal();
   Gb_0002 = false;
   if (Gi_0000 >= 0) {
   do { 
   if (OrderSelect((Gi_0000 - 1), 0, 1) == true && OrderMagicNumber() == Ii_0064) {
   Gl_0001 = OrderOpenTime();
   tmp_str0000 = TimeToString(TimeCurrent(), 1);
   tmp_str0000 = tmp_str0000 + " ";
   tmp_str0000 = tmp_str0000 + "00:00";
   if (Gl_0001 < StringToTime(tmp_str0000)) break; 
   tmp_str0001 = OrderComment();
   if (StringFind(tmp_str0001, "[tp]", 0) >= 0) {
   Gb_0002 = true;
   break;
   }}
   Gi_0000 = Gi_0000 - 1;
   } while (Gi_0000 >= 0); 
   }
   else Gb_0002 = false;
   
   if (Gb_0002 == false) return false; 
   tmp_str0002 = Is_0100;
   Gd_0003 = 0;
   if (GlobalVariableGet(tmp_str0002, Gd_0003) != true) { 
   Gd_0003 = 0;
   } 
   if ((Gd_0003 != DayOfYear())) { 
   Gi_0004 = 1;
   if (OrdersTotal() >= 1) { 
   do { 
   if (OrderSelect((Gi_0004 - 1), 0, 0) == true && OrderMagicNumber() == Ii_0064 && OrderType() != OP_BUY && OrderType() != OP_SELL) { 
   Gi_0005 = func_1097(OrderType());
   if (!OrderDelete(OrderTicket(), Gi_0005)) {
   tmp_str0003 = (string)OrderTicket();
   tmp_str0003 = "Error al eliminar la orden pendiente " + tmp_str0003;
   tmp_str0003 = tmp_str0003 + ". Error: ";
   tmp_str0003 = tmp_str0003 + ErrorDescription(GetLastError());
   tmp_str0004 = tmp_str0003;
   Is_0070 = tmp_str0003;
   tmp_str0006 = _Symbol + "(";
   tmp_str0006 = tmp_str0006 + func_1087(_Period);
   tmp_str0006 = tmp_str0006 + ")";
   tmp_str0006 = tmp_str0006 + ": ";
   tmp_str0006 = tmp_str0006 + tmp_str0003;
   tmp_str0005 = tmp_str0006;
   if (PopupAlert) { 
   Alert(tmp_str0005);
   } 
   else { 
   Print(tmp_str0004);
   } 
   if (PushAlert) { 
   SendNotification(tmp_str0005);
   } 
   if (EmailAlert != false) {
   SendMail(tmp_str0005, tmp_str0004);
   }}
   else{
   tmp_str0006 = (string)OrderTicket();
   Gi_0006 = ObjectsTotal(-1);
   if (Gi_0006 >= 0) { 
   do { 
   tmp_str0007 = ObjectName(Gi_0006);
   if (ObjectType(tmp_str0007) == 1) { 
   tmp_str0008 = ObjectName(Gi_0006);
   if (StringFind(tmp_str0008, tmp_str0006, 0) >= 0) { 
   tmp_str0009 = ObjectName(Gi_0006);
   ObjectDelete(tmp_str0009);
   }} 
   Gi_0006 = Gi_0006 - 1;
   } while (Gi_0006 >= 0); 
   }}} 
   Gi_0004 = Gi_0004 + 1;
   } while (Gi_0004 <= OrdersTotal()); 
   } 
   Gd_0007 = DayOfYear();
   tmp_str000A = Is_0100;
   if (GlobalVariableSet(tmp_str000A, Gd_0007) == 0) {
   tmp_str000B = "Se ha producido un error al actualizar la variable global" + Is_0100;
   tmp_str000B = tmp_str000B + " con valor ";
   Gi_0009 = _Digits;
   tmp_str000B = tmp_str000B + DoubleToString(NormalizeDouble(Gd_0007, Gi_0009), Gi_0009);
   tmp_str000B = tmp_str000B + ". Error ";
   tmp_str000B = tmp_str000B + ErrorDescription(GetLastError());
   tmp_str000C = tmp_str000B;
   Is_0070 = tmp_str000B;
   tmp_str000E = _Symbol + "(";
   tmp_str000E = tmp_str000E + func_1087(_Period);
   tmp_str000E = tmp_str000E + ")";
   tmp_str000E = tmp_str000E + ": ";
   tmp_str000E = tmp_str000E + tmp_str000B;
   tmp_str000D = tmp_str000E;
   if (PopupAlert) { 
   Alert(tmp_str000D);
   } 
   else { 
   Print(tmp_str000C);
   } 
   if (PushAlert) { 
   SendNotification(tmp_str000D);
   } 
   if (EmailAlert != false) {
   SendMail(tmp_str000D, tmp_str000C);
   }}
   else{
   GlobalVariablesFlush();
   }} 
   Lb_FFFF = true;
   return Lb_FFFF;
   
   Lb_FFFF = false;
   
   return Lb_FFFF;
}

void func_1143(int Fa_i_00, int Fa_i_01, int Fa_i_02)
{
   string tmp_str0000;
   string tmp_str0001;
   string tmp_str0002;
   string tmp_str0003;
   string tmp_str0004;
   string tmp_str0005;
   string tmp_str0006;
   int Li_FFFC;
   double Ld_FFF0;
   double Ld_FFE8;
   double Ld_FFE0;
   double Ld_FFD8;

   Li_FFFC = OrdersTotal();
   if (Li_FFFC < 0) return; 
   do { 
   if (OrderSelect(Li_FFFC, 0, 0) == true && OrderMagicNumber() == Ii_0064) { 
   if (OrderType() == OP_BUY) { 
   Gd_0000 = OrderStopLoss();
   Gi_0001 = Fa_i_01 + Fa_i_02;
   Ld_FFF0 = NormalizeDouble((Gd_0000 + NormalizeDouble((Gi_0001 * _Point), _Digits)), _Digits);
   Gd_0001 = OrderOpenPrice();
   if ((Bid >= (Gd_0001 + NormalizeDouble((Fa_i_00 * _Point), _Digits))) && (OrderClosePrice() >= Ld_FFF0)) { 
   Ld_FFE8 = 0;
   if ((OrderStopLoss() == 0)) { 
   Gd_0002 = OrderOpenPrice();
   Gi_0003 = Fa_i_00 - Fa_i_01;
   Ld_FFE8 = NormalizeDouble((Gd_0002 + NormalizeDouble((Gi_0003 * _Point), _Digits)), _Digits);
   } 
   else { 
   Gd_0003 = OrderStopLoss();
   Ld_FFE8 = NormalizeDouble((Gd_0003 + NormalizeDouble((Fa_i_01 * _Point), _Digits)), _Digits);
   } 
   if (OrderModify(OrderTicket(), OrderOpenPrice(), Ld_FFE8, OrderTakeProfit(), OrderExpiration(), 16711680) != true) { 
   tmp_str0000 = (string)OrderTicket();
   tmp_str0000 = "Error al modificar el stop loss para la operación " + tmp_str0000;
   tmp_str0000 = tmp_str0000 + ". Error: ";
   tmp_str0000 = tmp_str0000 + ErrorDescription(GetLastError());
   tmp_str0001 = tmp_str0000;
   Is_0070 = tmp_str0000;
   tmp_str0003 = _Symbol + "(";
   tmp_str0003 = tmp_str0003 + func_1087(_Period);
   tmp_str0003 = tmp_str0003 + ")";
   tmp_str0003 = tmp_str0003 + ": ";
   tmp_str0003 = tmp_str0003 + tmp_str0000;
   tmp_str0002 = tmp_str0003;
   if (PopupAlert) { 
   Alert(tmp_str0002);
   } 
   else { 
   Print(tmp_str0001);
   } 
   if (PushAlert) { 
   SendNotification(tmp_str0002);
   } 
   if (EmailAlert) { 
   SendMail(tmp_str0002, tmp_str0001);
   }}}} 
   if (OrderType() == OP_SELL) { 
   Gd_0007 = OrderStopLoss();
   Gi_0008 = Fa_i_01 + Fa_i_02;
   Ld_FFE0 = NormalizeDouble((Gd_0007 - NormalizeDouble((Gi_0008 * _Point), _Digits)), _Digits);
   Gd_0009 = OrderOpenPrice();
   if ((Ask < (Gd_0009 - NormalizeDouble((Fa_i_00 * _Point), _Digits)))) { 
   Gd_000A = OrderStopLoss();
   if (OrderStopLoss() == 0
   || (Gd_000A > (Ask + NormalizeDouble((Gi_0008 * _Point), _Digits)))) {
   
   Ld_FFD8 = 0;
   if ((OrderStopLoss() == 0)) { 
   Gd_0008 = OrderOpenPrice();
   Gi_000B = Fa_i_00 - Fa_i_01;
   Ld_FFD8 = NormalizeDouble((Gd_0008 - NormalizeDouble((Gi_000B * _Point), _Digits)), _Digits);
   } 
   else { 
   Ld_FFD8 = NormalizeDouble((Ask + NormalizeDouble((Fa_i_01 * _Point), _Digits)), _Digits);
   } 
   if (OrderModify(OrderTicket(), OrderOpenPrice(), Ld_FFD8, OrderTakeProfit(), OrderExpiration(), 255) != true) { 
   tmp_str0003 = (string)OrderTicket();
   tmp_str0003 = "Error al modificar el stop loss para la operación " + tmp_str0003;
   tmp_str0003 = tmp_str0003 + ". Error: ";
   tmp_str0003 = tmp_str0003 + ErrorDescription(GetLastError());
   tmp_str0004 = tmp_str0003;
   Is_0070 = tmp_str0003;
   tmp_str0006 = _Symbol + "(";
   tmp_str0006 = tmp_str0006 + func_1087(_Period);
   tmp_str0006 = tmp_str0006 + ")";
   tmp_str0006 = tmp_str0006 + ": ";
   tmp_str0006 = tmp_str0006 + tmp_str0003;
   tmp_str0005 = tmp_str0006;
   if (PopupAlert) { 
   Alert(tmp_str0005);
   } 
   else { 
   Print(tmp_str0004);
   } 
   if (PushAlert) { 
   SendNotification(tmp_str0005);
   } 
   if (EmailAlert) { 
   SendMail(tmp_str0005, tmp_str0004);
   }}}}}} 
   Li_FFFC = Li_FFFC - 1;
   } while (Li_FFFC >= 0); 
   
}

void func_1144()
{
   string tmp_str0000;

   ChartSetInteger(0, 21, 3283968);
   ChartSetInteger(0, 22, 16777215);
   ChartSetInteger(0, 17, 0);
   ChartSetInteger(0, 28, 65280);
   ChartSetInteger(0, 29, 255);
   ChartSetInteger(0, 25, 65280);
   ChartSetInteger(0, 26, 255);
   ChartSetInteger(0, 2, 1);
   ChartSetInteger(0, 0, 1);
   tmp_str0000 = "EAPASSING";
   if (ObjectFind(0, tmp_str0000) >= 0) { 
   ObjectDelete(0, tmp_str0000);
   } 
   if (!ObjectCreate(0, tmp_str0000, OBJ_LABEL, 0, 0, 0)) return; 
   Gl_0000 = ChartGetInteger(0, 106, 0) / 2;
   Gi_0000 = (int)Gl_0000;
   ObjectSetInteger(0, tmp_str0000, 102, Gi_0000);
   ObjectSetInteger(0, tmp_str0000, 103, 5);
   ObjectSetInteger(0, tmp_str0000, 101, 3);
   ObjectSetString(0, tmp_str0000, 999, "EAPASSING  ");
   ObjectSetString(0, tmp_str0000, 1001, "Arial");
   ObjectSetInteger(0, tmp_str0000, 100, 10);
   ObjectSetDouble(0, tmp_str0000, 13, 0);
   ObjectSetInteger(0, tmp_str0000, 1011, 3);
   ObjectSetInteger(0, tmp_str0000, 6, 14917376);
   ObjectSetInteger(0, tmp_str0000, 9, 0);
   ObjectSetInteger(0, tmp_str0000, 1000, 0);
   ObjectSetInteger(0, tmp_str0000, 17, 0);
   ObjectSetInteger(0, tmp_str0000, 208, 1);
   ObjectSetInteger(0, tmp_str0000, 207, 0);
   
}

void func_1146()
{
   string tmp_str0000;
   string tmp_str0001;
   string tmp_str0002;
   string tmp_str0003;
   string tmp_str0004;
   string tmp_str0005;
   string tmp_str0006;
   string tmp_str0007;
   string tmp_str0008;
   string tmp_str0009;
   string tmp_str000A;
   string tmp_str000B;
   string tmp_str000C;
   string tmp_str000D;
   string tmp_str000E;
   string tmp_str000F;
   string tmp_str0010;
   string tmp_str0011;
   string tmp_str0012;
   string tmp_str0013;
   string tmp_str0014;
   string tmp_str0015;
   string tmp_str0016;
   string tmp_str0017;
   string tmp_str0018;
   double Ld_FFF8;

   if (GlobalVariableCheck(Is_0130) != true) { 
   returned_double = AccountBalance();
   tmp_str0000 = Is_0130;
   if (GlobalVariableSet(tmp_str0000, returned_double) == 0) {
   tmp_str0001 = "Se ha producido un error al actualizar la variable global" + Is_0130;
   tmp_str0001 = tmp_str0001 + " con valor ";
   Gi_0002 = _Digits;
   tmp_str0001 = tmp_str0001 + DoubleToString(NormalizeDouble(returned_double, Gi_0002), Gi_0002);
   tmp_str0001 = tmp_str0001 + ". Error ";
   tmp_str0001 = tmp_str0001 + ErrorDescription(GetLastError());
   tmp_str0002 = tmp_str0001;
   Is_0070 = tmp_str0001;
   tmp_str0004 = _Symbol + "(";
   tmp_str0004 = tmp_str0004 + func_1087(_Period);
   tmp_str0004 = tmp_str0004 + ")";
   tmp_str0004 = tmp_str0004 + ": ";
   tmp_str0004 = tmp_str0004 + tmp_str0001;
   tmp_str0003 = tmp_str0004;
   if (PopupAlert) { 
   Alert(tmp_str0003);
   } 
   else { 
   Print(tmp_str0002);
   } 
   if (PushAlert) { 
   SendNotification(tmp_str0003);
   } 
   if (EmailAlert != false) {
   SendMail(tmp_str0003, tmp_str0002);
   }}
   else{
   GlobalVariablesFlush();
   }
   Gd_0002 = Month();
   tmp_str0004 = Is_0140;
   if (GlobalVariableSet(tmp_str0004, Gd_0002) == 0) { 
   tmp_str0005 = "Se ha producido un error al actualizar la variable global" + Is_0140;
   tmp_str0005 = tmp_str0005 + " con valor ";
   Gi_0004 = _Digits;
   tmp_str0005 = tmp_str0005 + DoubleToString(NormalizeDouble(Gd_0002, Gi_0004), Gi_0004);
   tmp_str0005 = tmp_str0005 + ". Error ";
   tmp_str0005 = tmp_str0005 + ErrorDescription(GetLastError());
   tmp_str0006 = tmp_str0005;
   Is_0070 = tmp_str0005;
   tmp_str0008 = _Symbol + "(";
   tmp_str0008 = tmp_str0008 + func_1087(_Period);
   tmp_str0008 = tmp_str0008 + ")";
   tmp_str0008 = tmp_str0008 + ": ";
   tmp_str0008 = tmp_str0008 + tmp_str0005;
   tmp_str0007 = tmp_str0008;
   if (PopupAlert) { 
   Alert(tmp_str0007);
   } 
   else { 
   Print(tmp_str0006);
   } 
   if (PushAlert) { 
   SendNotification(tmp_str0007);
   } 
   if (EmailAlert == false) return; 
   SendMail(tmp_str0007, tmp_str0006);
   return ;
   } 
   GlobalVariablesFlush();
   return ;
   } 
   if (TPMonth == 0) return; 
   Gi_0004 = Month();
   tmp_str0008 = Is_0140;
   Gd_0005 = 0;
   if (GlobalVariableGet(tmp_str0008, Gd_0005) != true) { 
   Gd_0005 = 0;
   } 
   Gi_0006 = (int)Gd_0005;
   if (Gi_0004 != Gi_0006) { 
   returned_double = AccountBalance();
   tmp_str0009 = Is_0130;
   if (GlobalVariableSet(tmp_str0009, returned_double) == 0) {
   tmp_str000A = "Se ha producido un error al actualizar la variable global" + Is_0130;
   tmp_str000A = tmp_str000A + " con valor ";
   Gi_0008 = _Digits;
   tmp_str000A = tmp_str000A + DoubleToString(NormalizeDouble(returned_double, Gi_0008), Gi_0008);
   tmp_str000A = tmp_str000A + ". Error ";
   tmp_str000A = tmp_str000A + ErrorDescription(GetLastError());
   tmp_str000B = tmp_str000A;
   Is_0070 = tmp_str000A;
   tmp_str000D = _Symbol + "(";
   tmp_str000D = tmp_str000D + func_1087(_Period);
   tmp_str000D = tmp_str000D + ")";
   tmp_str000D = tmp_str000D + ": ";
   tmp_str000D = tmp_str000D + tmp_str000A;
   tmp_str000C = tmp_str000D;
   if (PopupAlert) { 
   Alert(tmp_str000C);
   } 
   else { 
   Print(tmp_str000B);
   } 
   if (PushAlert) { 
   SendNotification(tmp_str000C);
   } 
   if (EmailAlert != false) {
   SendMail(tmp_str000C, tmp_str000B);
   }}
   else{
   GlobalVariablesFlush();
   }
   Gd_0008 = Month();
   tmp_str000D = Is_0140;
   if (GlobalVariableSet(tmp_str000D, Gd_0008) == 0) {
   tmp_str000E = "Se ha producido un error al actualizar la variable global" + Is_0140;
   tmp_str000E = tmp_str000E + " con valor ";
   Gi_000A = _Digits;
   tmp_str000E = tmp_str000E + DoubleToString(NormalizeDouble(Gd_0008, Gi_000A), Gi_000A);
   tmp_str000E = tmp_str000E + ". Error ";
   tmp_str000E = tmp_str000E + ErrorDescription(GetLastError());
   tmp_str000F = tmp_str000E;
   Is_0070 = tmp_str000E;
   tmp_str0011 = _Symbol + "(";
   tmp_str0011 = tmp_str0011 + func_1087(_Period);
   tmp_str0011 = tmp_str0011 + ")";
   tmp_str0011 = tmp_str0011 + ": ";
   tmp_str0011 = tmp_str0011 + tmp_str000E;
   tmp_str0010 = tmp_str0011;
   if (PopupAlert) { 
   Alert(tmp_str0010);
   } 
   else { 
   Print(tmp_str000F);
   } 
   if (PushAlert) { 
   SendNotification(tmp_str0010);
   } 
   if (EmailAlert != false) {
   SendMail(tmp_str0010, tmp_str000F);
   }}
   else{
   GlobalVariablesFlush();
   }} 
   Gi_000A = Month();
   tmp_str0011 = Is_0150;
   Gd_000B = 0;
   if (GlobalVariableGet(tmp_str0011, Gd_000B) != true) { 
   Gd_000B = 0;
   } 
   Gi_000C = (int)Gd_000B;
   if (Gi_000A == Gi_000C) return; 
   Gd_000C = (AccountEquity() * 100);
   tmp_str0012 = Is_0130;
   Gd_000D = 0;
   if (GlobalVariableGet(tmp_str0012, Gd_000D) != true) { 
   Gd_000D = 0;
   } 
   Ld_FFF8 = ((Gd_000C / Gd_000D) - 100);
   if ((Ld_FFF8 < TPMonth)) return; 
   tmp_str0013 = "Alcanzado el profit mensual del " + DoubleToString(NormalizeDouble(Ld_FFF8, 2), 2);
   tmp_str0013 = tmp_str0013 + "%, se cierra todo y no se opera hasta el mes siguiente.";
   Alert(tmp_str0013);
   func_1100();
   Gd_000C = Month();
   tmp_str0014 = Is_0150;
   if (GlobalVariableSet(tmp_str0014, Gd_000C) == 0) { 
   tmp_str0015 = "Se ha producido un error al actualizar la variable global" + Is_0150;
   tmp_str0015 = tmp_str0015 + " con valor ";
   Gi_000F = _Digits;
   tmp_str0015 = tmp_str0015 + DoubleToString(NormalizeDouble(Gd_000C, Gi_000F), Gi_000F);
   tmp_str0015 = tmp_str0015 + ". Error ";
   tmp_str0015 = tmp_str0015 + ErrorDescription(GetLastError());
   tmp_str0016 = tmp_str0015;
   Is_0070 = tmp_str0015;
   tmp_str0018 = _Symbol + "(";
   tmp_str0018 = tmp_str0018 + func_1087(_Period);
   tmp_str0018 = tmp_str0018 + ")";
   tmp_str0018 = tmp_str0018 + ": ";
   tmp_str0018 = tmp_str0018 + tmp_str0015;
   tmp_str0017 = tmp_str0018;
   if (PopupAlert) { 
   Alert(tmp_str0017);
   } 
   else { 
   Print(tmp_str0016);
   } 
   if (PushAlert) { 
   SendNotification(tmp_str0017);
   } 
   if (EmailAlert == false) return; 
   SendMail(tmp_str0017, tmp_str0016);
   return ;
   } 
   GlobalVariablesFlush();
   
}

void func_1151()
{
   string tmp_str0000;
   string tmp_str0001;
   string tmp_str0002;
   string tmp_str0003;
   int Li_FFFC;
   double Ld_FFF0;

   if (TipoSL == 0) return; 
   if (SL == 0) return; 
   Li_FFFC = OrdersTotal();
   if (Li_FFFC < 0) return; 
   do { 
   if (OrderSelect((Li_FFFC - 1), 0, 0) == true && OrderMagicNumber() == Ii_0064) { 
   if (OrderType() == OP_BUY || OrderType() == OP_SELL) { 
   
   Ld_FFF0 = 0;
   if (OrderType() == OP_BUY) {
   Gd_0000 = OrderOpenPrice();
   Ld_FFF0 = NormalizeDouble((Gd_0000 - NormalizeDouble((SL * _Point), _Digits)), _Digits);
   if ((OrderStopLoss() != 0)) {
   if (OrderStopLoss() >= Ld_FFF0) continue;
   }}
   else{
   if (OrderType() == OP_SELL) {
   Gd_0001 = OrderOpenPrice();
   Ld_FFF0 = NormalizeDouble((Gd_0001 + NormalizeDouble((SL * _Point), _Digits)), _Digits);
   if ((OrderStopLoss() != 0)) {
   if (OrderStopLoss() <= Ld_FFF0) continue;
   }}}
   if (OrderModify(OrderTicket(), OrderOpenPrice(), Ld_FFF0, OrderTakeProfit(), OrderExpiration(), 4294967295) != true) { 
   tmp_str0000 = (string)OrderTicket();
   tmp_str0000 = "Error al modificar la orden " + tmp_str0000;
   tmp_str0000 = tmp_str0000 + ". Error: ";
   tmp_str0000 = tmp_str0000 + ErrorDescription(GetLastError());
   tmp_str0001 = tmp_str0000;
   Is_0070 = tmp_str0000;
   tmp_str0003 = _Symbol + "(";
   tmp_str0003 = tmp_str0003 + func_1087(_Period);
   tmp_str0003 = tmp_str0003 + ")";
   tmp_str0003 = tmp_str0003 + ": ";
   tmp_str0003 = tmp_str0003 + tmp_str0000;
   tmp_str0002 = tmp_str0003;
   if (PopupAlert) { 
   Alert(tmp_str0002);
   } 
   else { 
   Print(tmp_str0001);
   } 
   if (PushAlert) { 
   SendNotification(tmp_str0002);
   } 
   if (EmailAlert) { 
   SendMail(tmp_str0002, tmp_str0001);
   }}}} 
   Li_FFFC = Li_FFFC - 1;
   } while (Li_FFFC >= 0); 
   
}

void func_1154(int Fa_i_00, int Fa_i_01)
{
   string tmp_str0000;
   string tmp_str0001;
   string tmp_str0002;
   string tmp_str0003;
   string tmp_str0004;
   string tmp_str0005;
   string tmp_str0006;
   int Li_FFFC;
   bool Lb_FFFB;
   double Ld_FFF0;

   Li_FFFC = 1;
   if (OrdersTotal() < 1) return; 
   do { 
   if (OrderSelect((Li_FFFC - 1), 0, 0) == true && OrderMagicNumber() == Ii_0064 && OrderSymbol() == _Symbol) { 
   if (OrderType() == OP_BUY || OrderType() == OP_SELL) { 
   
   Lb_FFFB = false;
   Ld_FFF0 = 0;
   if (OrderType() == OP_BUY
   && (OrderClosePrice() - OrderOpenPrice() >= NormalizeDouble((Fa_i_00 * _Point), _Digits))) {
   Gd_0002 = OrderOpenPrice();
   Ld_FFF0 = NormalizeDouble((Gd_0002 + NormalizeDouble((Fa_i_01 * _Point), _Digits)), _Digits);
   if (Ld_FFF0 > OrderStopLoss()) {
   Lb_FFFB = true;
   }}
   else{
   if (OrderType() == OP_SELL) {
   Gd_0003 = OrderOpenPrice();
   Gd_0003 = (Gd_0003 - OrderClosePrice());
   if ((Gd_0003 >= NormalizeDouble((Fa_i_00 * _Point), _Digits))) {
   Gd_0005 = OrderOpenPrice();
   Ld_FFF0 = NormalizeDouble((Gd_0005 - NormalizeDouble((Fa_i_01 * _Point), _Digits)), _Digits);
   if ((OrderStopLoss() != 0) == false || (Ld_FFF0 >= OrderStopLoss()) == false) {
   
   Lb_FFFB = true;
   }}}}
   if (Lb_FFFB) { 
   Gd_0006 = NormalizeDouble(OrderStopLoss(), _Digits);
   if ((Gd_0006 == NormalizeDouble(Ld_FFF0, _Digits)) != true) { 
   if (!OrderModify(OrderTicket(), OrderOpenPrice(), Ld_FFF0, OrderTakeProfit(), OrderExpiration(), 4294967295)) {
   tmp_str0000 = "Error al modificar la orden a breakeven con ticket " + IntegerToString(OrderTicket(), 0, 32);
   tmp_str0000 = tmp_str0000 + ". Error: ";
   tmp_str0000 = tmp_str0000 + ErrorDescription(GetLastError());
   tmp_str0001 = tmp_str0000;
   Is_0070 = tmp_str0000;
   tmp_str0003 = _Symbol + "(";
   tmp_str0003 = tmp_str0003 + func_1087(_Period);
   tmp_str0003 = tmp_str0003 + ")";
   tmp_str0003 = tmp_str0003 + ": ";
   tmp_str0003 = tmp_str0003 + tmp_str0000;
   tmp_str0002 = tmp_str0003;
   if (PopupAlert) { 
   Alert(tmp_str0002);
   } 
   else { 
   Print(tmp_str0001);
   } 
   if (PushAlert) { 
   SendNotification(tmp_str0002);
   } 
   if (EmailAlert != false) {
   SendMail(tmp_str0002, tmp_str0001);
   }}
   else{
   tmp_str0003 = "StopLoss a breakeven para la orden con ticket " + IntegerToString(OrderTicket(), 0, 32);
   tmp_str0003 = tmp_str0003 + ", breakeven ";
   Gi_0009 = _Digits;
   tmp_str0003 = tmp_str0003 + DoubleToString(NormalizeDouble(Ld_FFF0, Gi_0009), Gi_0009);
   tmp_str0003 = tmp_str0003 + ", cotización ";
   Gi_0009 = _Digits;
   tmp_str0003 = tmp_str0003 + DoubleToString(NormalizeDouble(OrderClosePrice(), Gi_0009), Gi_0009);
   tmp_str0004 = tmp_str0003;
   Is_0070 = tmp_str0003;
   tmp_str0006 = _Symbol + "(";
   tmp_str0006 = tmp_str0006 + func_1087(_Period);
   tmp_str0006 = tmp_str0006 + ")";
   tmp_str0006 = tmp_str0006 + ": ";
   tmp_str0006 = tmp_str0006 + tmp_str0003;
   tmp_str0005 = tmp_str0006;
   if (PopupAlert) { 
   Alert(tmp_str0005);
   } 
   else { 
   Print(tmp_str0004);
   } 
   if (PushAlert) { 
   SendNotification(tmp_str0005);
   } 
   if (EmailAlert) { 
   SendMail(tmp_str0005, tmp_str0004);
   }}}}}} 
   Li_FFFC = Li_FFFC + 1;
   } while (Li_FFFC <= OrdersTotal()); 
   
}

