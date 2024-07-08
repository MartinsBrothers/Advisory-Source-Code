//+------------------------------------------------------------------+
//|                                                      ProjectName |
//|                                      Copyright 2018, CompanyName |
//|                                       http://www.companyname.net |
//+------------------------------------------------------------------+
#property copyright "CopyRight 2020 @eafxsinais";
#property link "https://t.me/SoftechFX_Robot";
#property version "";
#property strict
#property description "https://t.me/SoftechFX_Robot Mínimo 1000€ Lote 0.01\nPares Recomendados: XAUUSD e EURUSD\nTelegram: @suportefxsinais\nTimeFrame: M1 e M5";

struct MTLicenseInfo {
public:
   bool              m_0;
   string            m_1;
   string            m_13;
   string            m_25;
   string            m_37;
   int               m_49;
   int               m_53;
   int               m_57;
   int               m_61;
   int               m_65;
   int               m_69;
   string            m_73;
   string            m_85;
};
#import "FxsinaisLib.ex4"

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void MTLic_CheckLicense(MTLicenseInfo&);
string MTLic_GetLicense(string,string,string,string,string);

#import

extern double _FixLot = 0.01; // Lote fixo
extern double TakeProfit = 30; // Take Profit
extern int maxSpread = 50; // Maximo Spread
extern double _Multiplier = 1.5; // Lote Multiplicador
extern double Distancia = 15;
extern double MinProfit = 5;
extern string Amazingforex_Pair = "EURUSD"; // Trade Pairs
extern string _hedgeSwitchl = "========= Controle Hedge  ==========="; // ========= Controle Hedge  ===========
extern bool _hedgeSwitch = true; // Usar Hedge
extern bool _hedgeAmortizar = true; // Usar Amortizacao
extern double DDPercent = 100; // Lote Percentual Hedge
extern double _DDHedge = 60; // A partir DD%
extern int TakeHedge = 6000; // Take Profit
extern int _TSHedge = 15; // Distancia Minima
extern string News_Filter_Setting = "====== Filtro de Noticias ======"; // == Filtro de Noticias ==
extern bool Activate_News_Filter = true; // Ativar Filtro de Noticias
extern ENUM_BASE_CORNER Text_Corner = CORNER_RIGHT_LOWER;
extern int AfterNewsStop = 60; // Não Opera após (Minutos)
extern int BeforeNewsStop = 60; // Não Opera antes (Minutos)
extern bool NewsLight; // Habilitar Baixo Impacto
extern bool NewsMedium; // Habilitar Medio Impacto
extern bool NewsHard = true; // Habilitar Alto Impacto
extern int offset = 3; // Time Zone, GMT (for news)
extern string NewsSymb = "USD,EUR,GBP,CHF,CAD,AUD,NZD,JPY"; // Ativos para filtros (vazio - apenas ativo atual)
extern bool DrawFaixa = true; // Desenhar faixa no grafico
extern bool DrawLines = true; // Desenhar lines no grafico
extern bool Next; // Desenhar apenas novas noticias
extern bool Signal; // Sinal aproximação de noticia
extern string Note = "Add the following link to Option > Expert Advisors ";
extern string Link = "http://ec.forexprostools.com/?columns=exc_currency";



double I_d_0;
double I_d_1;
double I_d_2;
double I_d_3;
bool I_b_0;
bool I_b_1;
double I_d_4;
int I_i_0;
int I_i_1;
int I_i_2;
int I_i_3;
double I_d_5;
int G_i_4;
int I_i_5;
int I_i_6;
int I_i_7;
string I_s_0;
int I_i_8;
string G_s_1;
int I_i_9;
int I_i_10;
int I_i_11;
int G_i_12;
string I_s_2;
bool I_b_2;
bool I_b_3;
bool I_b_4;
int I_i_13;
int I_i_14;
double G_d_6;
double G_d_7;
bool G_b_5;
double I_d_8;
double I_d_9;
double G_d_10;
double G_d_11;
double I_d_12;
bool I_b_7;
bool I_b_8;
bool I_b_9;
string I_s_3;
long G_l_0;
long I_l_1;
long I_l_2;
long G_l_3;
int G_i_16;
int G_i_17;
int G_i_18;
long G_l_4;
int G_i_19;
int G_i_20;
int G_i_21;
string G_s_4;
int G_i_22;
int G_i_23;
long G_l_5;
long G_l_6;
int G_i_24;
long G_l_7;
string G_s_6;
int G_i_25;
int G_i_26;
string G_s_7;
long G_l_8;
long G_l_9;
long G_l_10;
bool G_b_10;
int G_i_27;
int G_i_28;
int G_i_29;
int G_i_30;
int G_i_31;
int G_i_32;
int G_i_33;
int G_i_34;
int G_i_35;
int G_i_36;
string I_s_8;
int G_i_37;
int G_i_38;
int G_i_39;
int G_i_40;
int G_i_41;
int G_i_42;
int G_i_43;
int G_i_44;
double G_d_13;
double I_d_14;
int G_i_45;
int I_i_46;
double G_d_15;
int G_i_47;
int G_i_48;
int I_i_49;
int G_i_50;
int G_i_51;
long I_l_12;
int G_i_52;
int G_i_53;
int G_i_54;
int G_i_55;
int G_i_56;
int G_i_57;
int G_i_58;
double G_d_20;
double G_d_21;
double I_d_22;
int G_i_59;
int G_i_60;
int G_i_61;
int G_i_62;
int G_i_63;
int G_i_64;
int G_i_65;
int G_i_66;
int G_i_67;
int G_i_68;
int G_i_69;
int G_i_70;
int G_i_71;
int G_i_72;
int G_i_73;
int G_i_74;
int G_i_75;
int G_i_76;
int G_i_77;
int G_i_78;
double G_d_23;
int G_i_79;
int G_i_80;
int G_i_81;
int G_i_82;
long G_l_13;
long G_l_14;
int G_i_83;
double G_d_24;
int G_i_84;
int G_i_85;
int G_i_86;
int G_i_87;
int G_i_88;
int G_i_89;
double G_d_25;
double G_d_26;
int G_i_90;
int G_i_91;
int G_i_92;
double G_d_27;
int G_i_93;
int G_i_94;
double G_d_28;
int G_i_95;
double G_d_29;
double G_d_30;
long I_l_16;
int G_i_97;
double G_d_32;
int G_i_98;
int G_i_99;
double G_d_33;
int G_i_100;
int G_i_101;
int G_i_102;
double G_d_34;
bool I_b_21;
int I_i_103;
string G_s_9;
string G_s_10;
int G_i_106;
string G_s_11;
string I_s_12;
string G_s_13;
int I_i_108;
double I_d_35;
int I_i_109;
int I_i_110;
int I_i_111;
int I_i_112;
double I_d_36;
double I_d_37;
double I_d_38;
double I_d_39;
double I_d_40;
double I_d_41;
double I_d_42;
double G_d_43;
double I_d_44;
double I_d_45;
double I_d_46;
double I_d_47;
double I_d_48;
double I_d_49;
double I_d_50;
int I_i_113;
double I_d_51;
double I_d_52;
double I_d_53;
int I_i_114;
string I_s_14;
string I_s_15;
string I_s_16;
string I_s_17;
string I_s_18;
string I_s_19;
string I_s_20;
string I_s_21;
int I_i_115;
double I_d_54;
int I_i_116;
int G_i_117;
double I_d_55;
double I_d_56;
int G_i_118;
double G_d_57;
double I_d_58;
double I_d_59;
double I_d_60;
double I_d_61;
int I_i_119;
string I_s_22;
string I_s_23;
int I_i_120;
bool G_b_24;
double G_d_62;
double I_d_63;
double I_d_64;
int G_i_121;
double I_d_65;
double I_d_66;
double I_d_67;
string I_s_24;
bool G_b_25;
double G_d_68;
double I_d_69;
bool I_b_26;
int I_i_122;
bool I_b_27;
double G_d_70;
double G_d_71;
bool G_b_29;
double G_d_75;
double G_d_76;
double G_d_77;
bool G_b_32;
double I_d_78;
double G_d_82;
int I_i_127;
double I_d_83;
double I_d_84;
bool I_b_34;
double G_d_87;
double G_d_89;
double G_d_90;
double G_d_91;
double G_d_92;
double G_d_94;
double I_d_95;
double I_d_96;
double I_d_97;
double I_d_98;
bool I_b_40;
double G_d_102;
int I_i_132;
string G_s_25;
int G_i_134;
int G_i_135;
int G_i_136;
int G_i_137;
int G_i_138;
int G_i_139;
int G_i_140;
int G_i_141;
int G_i_142;
int G_i_143;
int G_i_144;
int G_i_145;
double G_d_103;
int G_i_146;
int G_i_147;
int G_i_148;
int G_i_149;
long G_l_17;
long G_l_18;
int G_i_150;
double G_d_104;
int G_i_151;
int G_i_152;
int G_i_153;
int G_i_154;
double G_d_105;
long G_l_22;
long I_l_23;
long G_l_24;
int I_i_155;
int I_i_156;
int G_i_157;
string G_s_26;
long G_l_25;
int G_i_159;
long G_l_26;
string G_s_27;
string G_s_28;
string G_s_29;
string G_s_30;
string G_s_31;
string G_s_32;
long G_l_27;
int G_i_165;
long G_l_28;
int G_i_166;
string G_s_33;
long G_l_29;
int G_i_168;
long G_l_30;
int G_i_169;
long G_l_31;
int G_i_170;
string G_s_34;
long G_l_32;
long G_l_33;
string G_s_35;
int I_i_172;
int G_i_175;
string G_s_36;
long G_l_34;
int G_i_177;
long G_l_35;
string G_s_37;
int G_i_178;
int G_i_179;
int G_i_180;
int G_i_181;
int G_i_182;
int G_i_183;
int G_i_184;
int G_i_185;
int G_i_186;
int G_i_187;
int G_i_188;
long G_l_36;
int G_i_189;
long G_l_37;
int G_i_191;
int G_i_193;
long G_l_38;
int G_i_195;
long G_l_39;
int I_i_196;
int G_i_197;
long G_l_40;
long G_l_41;
int G_i_199;
long G_l_42;
int G_i_200;
long G_l_43;
long G_l_44;
int G_i_202;
long G_l_45;
int G_i_203;
long G_l_46;
long G_l_47;
double G_d_107;
int I_i_205;
int G_i_206;
int G_i_207;
long G_l_48;
long G_l_49;
double G_d_109;
int G_i_208;
int G_i_209;
string I_s_49;
string I_s_50;
string I_s_51;
string I_s_52;
int I_i_210;
int I_i_211;
int I_i_212;
string I_s_53;
string I_s_54;
int I_i_213;
string I_s_55;
string I_s_56;
string I_s_57;
string I_s_58;
double I_d_110;
int I_i_214;
int I_i_215;
string I_s_59;
string I_s_60;
string I_s_61;
string I_s_62;
int I_i_216;
string I_s_63;
bool I_b_48;
string I_s_64;
string I_s_65;
int I_i_217;
bool I_b_49;
long I_l_50;
int G_i_218;
int G_i_219;
long G_l_51;
long G_l_52;
double G_d_111;
char G_c_1;
short Return_Short_00000000;
char G_c_3;
char G_c_5;
char G_c_7;
char G_c_9;
int G_i_221;
int G_i_222;
char G_c_11;
char G_c_13;
char G_c_16;
int G_i_223;
long G_l_53;
double G_d_112;
double G_d_113;
long G_l_55;
long G_l_56;
double G_d_114;
double G_d_117;
double G_d_118;
double G_d_119;
double G_d_120;
double G_d_123;
double G_d_125;
int G_i_388;
int G_i_390;
long G_l_57;
int G_i_391;
long G_l_58;
double G_d_131;
string I_s_379[350];
string I_s_380[];
string I_s_381[4][1000];
MTLicenseInfo Input_Struct_00000080;
double returned_double;
string Global_ReturnedString;
int init() {
   I_s_49 = "OH3";
   I_s_50 = "EA Ouro Hedge 3.0";
   I_s_51 = "t.me/suportefxsinais";
   I_s_52 = "54.91.116.77";
   I_i_210 = 0;
   I_i_211 = 0;
   I_i_212 = 0;
   I_s_53 = "MIANtXq5PcILtqJjOl6hNc7584DzcLln";
   I_s_54 = "";
   I_i_205 = 0;
   I_i_213 = 0;
   I_l_2 = TimeCurrent();
   I_s_55 = "https://t.me/suportefxsinais";
   I_s_56 = "https://fxsinais.com/eaouro";
   I_s_57 = "";
   I_s_58 = "New";
   I_i_3 = 0;
   I_d_2 = 0.01;
   I_d_3 = 1.5;
   I_d_110 = 10000;
   I_b_0 = true;
   I_b_1 = true;
   I_b_21 = true;
   I_d_4 = 25;
   I_i_214 = 0;
   I_i_0 = 15;
   I_i_2 = 2;
   I_i_46 = 123333;
   I_l_16 = 0;
   I_d_9 = 0;
   I_d_12 = 0;
   I_l_12 = 0;
   I_b_9 = false;
   I_i_215 = 0;
   I_s_59 = "https://t.me/suportefxsinais";
   I_s_60 = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
   I_i_114 = 0;
   I_b_26 = true;
   I_i_116 = 70;
   I_i_119 = 50;
   I_i_115 = 1;
   I_s_61 = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
   I_d_0 = 10;
   I_d_1 = 5;
   I_i_120 = 4000;
   I_i_122 = 20;
   I_i_10 = 1234567;
   I_s_62 = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
   I_b_34 = true;
   I_d_83 = 12;
   I_i_127 = 1;
   I_i_108 = 1;
   I_s_0 = "";
   I_i_9 = 0;
   I_i_11 = 0;
   I_s_24 = "Telegram : @suportefxsinais";
   I_b_40 = true;
   I_b_27 = true;
   I_i_216 = 20;
   I_s_63 = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
   I_b_48 = false;
   I_s_64 = "00:00";
   I_s_65 = "23:59";
   I_d_97 = 0;
   I_d_95 = 0;
   I_d_84 = 0;
   I_i_132 = 0;
   I_i_49 = 0;
   I_i_217 = 12;
   I_d_51 = 0;
   I_d_63 = 0;
   I_d_64 = 0;
   I_d_65 = 0;
   I_d_66 = 0;
   I_i_109 = 0;
   I_i_110 = 0;
   I_b_49 = true;
   I_s_15 = "MONDAY";
   I_s_16 = "TUESDAY";
   I_s_17 = "WEDNESDAY";
   I_s_18 = "THURSDAY";
   I_s_19 = "FRIDAY";
   I_s_20 = "SATURDAY";
   I_s_21 = "SUNDAY";
   I_d_49 = 0;
   I_d_45 = 0;
   I_d_46 = 0;
   I_d_50 = 0;
   I_i_113 = 0;
   I_d_35 = 0;
   I_d_42 = 0;
   I_d_47 = 0;
   I_d_54 = 0;
   I_d_36 = 0;
   I_d_37 = 0;
   I_d_38 = 0;
   I_d_39 = 0;
   I_d_40 = 0;
   I_d_41 = 0;
   I_d_69 = 0;
   I_d_78 = 0;
   I_d_96 = 0;
   I_d_98 = 0;
   I_d_44 = 0;
   I_d_48 = 0;
   I_i_103 = 0;
   I_i_111 = 0;
   I_i_112 = 0;
   I_d_60 = 0;
   I_d_61 = 0;
   I_d_55 = 0;
   I_d_56 = 0;
   I_d_58 = 0;
   I_d_59 = 0;
   I_i_8 = 0;
   I_d_67 = 0;
   I_d_52 = 0;
   I_d_53 = 0;
   I_i_5 = 255;
   I_i_6 = 16711680;
   I_i_7 = 65280;
   I_i_196 = 2;
   I_i_155 = 86400;
   I_b_2 = false;
   I_b_3 = false;
   I_b_4 = false;
   I_i_13 = 0;
   I_i_14 = 0;
   I_i_156 = 0;
   I_i_172 = 0;
   I_l_23 = 0;
   I_b_8 = false;
   I_l_50 = 0;
   string S_s_509;
   string S_s_510;
   string S_s_511;
   string S_s_512;
   string S_s_513;
   string S_s_482;
   string S_s_483;
   string S_s_484;
   string S_s_485;
   string S_s_486;
   string S_s_487;
   string S_s_488;
   string S_s_489;
   string S_s_490;
   string S_s_491;
   string S_s_492;
   int L_i_39;
   int L_i_15;
   bool L_b_0;
   int L_i_47;
   MQLSetInteger(15, 65001);
   func_1022();
   I_d_0 = Distancia;
   I_d_1 = MinProfit;
   I_d_2 = _FixLot;
   I_d_3 = _Multiplier;
   I_b_0 = _hedgeSwitch;
   I_b_1 = _hedgeAmortizar;
   I_d_4 = _DDHedge;
   I_i_0 = _TSHedge;
   if (StringFind(_Symbol, "XAUUSD", 0) > -1 || StringFind(_Symbol, "GOLD", 0) > -1) {
      Print("XAU");
      I_i_2 = 2;
      if (I_i_3 == 1) {
         I_d_2 = 0.03;
         I_d_3 = 1.5;
         I_b_0 = true;
         I_b_1 = true;
         I_d_4 = 25;
         I_d_0 = 10;
         I_d_1 = 5;
      }
   }
   if (StringFind(_Symbol, "EURUSD", 0) > -1) {
      I_i_2 = 2;
      if (I_i_3 == 1) {
         I_d_2 = 0.01;
         I_d_3 = 1.5;
         I_b_0 = true;
         I_b_1 = true;
         I_d_4 = 25;
         I_d_0 = 15;
         I_d_1 = 7.5;
      }
   }
   L_i_39 = 1;
   L_i_15 = 25;
   S_s_509 = WindowExpertName();
   S_s_510 = "Name";
   ObjectDelete(S_s_510);
   ObjectCreate(0, S_s_510, OBJ_LABEL, 0, 0, 0, 0, 0, 0, 0);
   ObjectSet(S_s_510, OBJPROP_CORNER, Text_Corner);
   ObjectSet(S_s_510, OBJPROP_XDISTANCE, 5);
   ObjectSet(S_s_510, OBJPROP_YDISTANCE, 25);
   ObjectSetText(S_s_510, S_s_509, 10, "Arial Black", 16748574);
   L_i_39 = 1 + 1;
   G_i_4 = L_i_39 * 25;
   S_s_511 = "Broker Time : Loading";
   S_s_512 = "BrokerTime";
   ObjectDelete(S_s_512);
   ObjectCreate(0, S_s_512, OBJ_LABEL, 0, 0, 0, 0, 0, 0, 0);
   ObjectSet(S_s_512, OBJPROP_CORNER, Text_Corner);
   ObjectSet(S_s_512, OBJPROP_XDISTANCE, 5);
   ObjectSet(S_s_512, OBJPROP_YDISTANCE, G_i_4);
   ObjectSetText(S_s_512, S_s_511, 10, "Arial Black", 16748574);
   L_i_39 = L_i_39 + 1;
   G_i_4 = L_i_39 * 25;
   S_s_513 = (string)Activate_News_Filter;
   S_s_513 = "News Filter Activation : " + S_s_513;
   S_s_482 = "NewsFilter";
   ObjectDelete(S_s_482);
   ObjectCreate(0, S_s_482, OBJ_LABEL, 0, 0, 0, 0, 0, 0, 0);
   ObjectSet(S_s_482, OBJPROP_CORNER, Text_Corner);
   ObjectSet(S_s_482, OBJPROP_XDISTANCE, 5);
   ObjectSet(S_s_482, OBJPROP_YDISTANCE, G_i_4);
   ObjectSetText(S_s_482, S_s_513, 10, "Arial Black", 16748574);
   L_i_39 = L_i_39 + 1;
   if (Activate_News_Filter == true) {
      G_i_4 = L_i_39 * 25;
      S_s_483 = "News : Loading";
      S_s_484 = "News";
      ObjectDelete(S_s_484);
      ObjectCreate(0, S_s_484, OBJ_LABEL, 0, 0, 0, 0, 0, 0, 0);
      ObjectSet(S_s_484, OBJPROP_CORNER, Text_Corner);
      ObjectSet(S_s_484, OBJPROP_XDISTANCE, 5);
      ObjectSet(S_s_484, OBJPROP_YDISTANCE, G_i_4);
      ObjectSetText(S_s_484, S_s_483, 10, "Arial Black", 16748574);
      L_i_39 = L_i_39 + 1;
      G_i_4 = L_i_39 * 25;
      S_s_485 = (string)NewsHard;
      S_s_485 = "High Impact News Filter: " + S_s_485;
      S_s_486 = "StrongNews";
      ObjectDelete(S_s_486);
      ObjectCreate(0, S_s_486, OBJ_LABEL, 0, 0, 0, 0, 0, 0, 0);
      ObjectSet(S_s_486, OBJPROP_CORNER, Text_Corner);
      ObjectSet(S_s_486, OBJPROP_XDISTANCE, 5);
      ObjectSet(S_s_486, OBJPROP_YDISTANCE, G_i_4);
      ObjectSetText(S_s_486, S_s_485, 10, "Arial Black", I_i_5);
      L_i_39 = L_i_39 + 1;
      G_i_4 = L_i_39 * 25;
      S_s_487 = (string)NewsMedium;
      S_s_487 = "Medium Impact News Filter: " + S_s_487;
      S_s_488 = "MediumNews";
      ObjectDelete(S_s_488);
      ObjectCreate(0, S_s_488, OBJ_LABEL, 0, 0, 0, 0, 0, 0, 0);
      ObjectSet(S_s_488, OBJPROP_CORNER, Text_Corner);
      ObjectSet(S_s_488, OBJPROP_XDISTANCE, 5);
      ObjectSet(S_s_488, OBJPROP_YDISTANCE, G_i_4);
      ObjectSetText(S_s_488, S_s_487, 10, "Arial Black", I_i_6);
      L_i_39 = L_i_39 + 1;
      G_i_4 = L_i_39 * 25;
      S_s_489 = (string)NewsLight;
      S_s_489 = "Low Impact News Filter: " + S_s_489;
      S_s_490 = "LowNews";
      ObjectDelete(S_s_490);
      ObjectCreate(0, S_s_490, OBJ_LABEL, 0, 0, 0, 0, 0, 0, 0);
      ObjectSet(S_s_490, OBJPROP_CORNER, Text_Corner);
      ObjectSet(S_s_490, OBJPROP_XDISTANCE, 5);
      ObjectSet(S_s_490, OBJPROP_YDISTANCE, G_i_4);
      ObjectSetText(S_s_490, S_s_489, 10, "Arial Black", I_i_7);
      L_i_39 = L_i_39 + 1;
   }
   L_b_0 = true;
   G_i_4 = StringLen(_Symbol);
   I_s_0 = StringSubstr(_Symbol, 6, (G_i_4 - 6));
   I_i_8 = 0;
   if (Amazingforex_Pair != "") {
      I_i_8 = 1;
      ArrayResize(I_s_380, 1, 0);
      G_i_4 = I_i_8 - 1;
      I_s_380[G_i_4] = Amazingforex_Pair;
   }
   I_i_9 = I_i_10;
   I_i_11 = I_i_10;
   G_i_12 = StringLen(NewsSymb);
   if (G_i_12 > 1) {
      I_s_2 = NewsSymb;
   } else {
      I_s_2 = _Symbol;
   }
   I_b_2 = NewsHard;
   I_b_3 = NewsMedium;
   I_b_4 = NewsLight;
   I_i_13 = BeforeNewsStop;
   I_i_14 = AfterNewsStop;
   S_s_491 = _Symbol;
   G_d_6 = 0;
   G_d_7 = MarketInfo(S_s_491, MODE_DIGITS);
   if ((G_d_7 == 3) && StringFind(S_s_491, "XAU", 0) == -1 && StringFind(S_s_491, "GOLD", 0) == -1) {
      G_d_6 = 0.01;
   } else {
      if ((G_d_7 == 4) || (G_d_7 == 5)) {
         G_d_6 = 0.0001;
      } else {
         if ((G_d_7 == 2) || (G_d_7 == 3)) {
            G_d_6 = 0.1;
         } else {
            if ((G_d_7 == 1)) {
               G_d_6 = 1;
            } else {
               G_d_6 = 1;
            }
         }
      }
   }
   I_d_9 = (I_i_0 * G_d_6);
   S_s_492 = _Symbol;
   G_d_10 = 0;
   G_d_11 = MarketInfo(S_s_492, MODE_DIGITS);
   if ((G_d_11 == 3) && StringFind(S_s_492, "XAU", 0) == -1 && StringFind(S_s_492, "GOLD", 0) == -1) {
      G_d_10 = 0.01;
   } else {
      if ((G_d_11 == 4) || (G_d_11 == 5)) {
         G_d_10 = 0.0001;
      } else {
         if ((G_d_11 == 2) || (G_d_11 == 3)) {
            G_d_10 = 0.1;
         } else {
            if ((G_d_11 == 1)) {
               G_d_10 = 1;
            } else {
               G_d_10 = 1;
            }
         }
      }
   }
   I_d_12 = (I_i_2 * G_d_10);
   if (IsTesting() && Activate_News_Filter) {
      func_1057();
   }
   I_b_8 = true;
   I_b_9 = false;
   L_i_47 = 0;
   return 0;
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void start() {
   string S_s_509;
   string S_s_510;
   string S_s_511;
   string S_s_512;
   string S_s_513;
   string S_s_482;
   string S_s_483;
   string S_s_484;
   string S_s_485;
   string S_s_486;
   string S_s_487;
   string S_s_488;
   string S_s_489;
   string S_s_490;
   string S_s_491;
   string S_s_492;
   string S_s_493;
   string S_s_494;
   string S_s_495;
   string S_s_496;
   string S_s_497;
   string S_s_498;
   string S_s_420;
   string S_s_421;
   string S_s_422;
   string S_s_423;
   string S_s_424;
   string S_s_425;
   string S_s_426;
   string S_s_427;
   string S_s_428;
   string S_s_429;
   string S_s_430;
   string S_s_431;
   string S_s_432;
   string S_s_433;
   string S_s_434;
   string S_s_435;
   string S_s_436;
   string S_s_437;
   string S_s_438;
   string S_s_439;
   string S_s_440;
   string S_s_441;
   string S_s_442;
   string S_s_443;
   string S_s_444;
   string S_s_445;
   string S_s_446;
   string S_s_447;
   string S_s_448;
   string S_s_449;
   string S_s_450;
   string S_s_451;
   string S_s_452;
   string S_s_453;
   string S_s_454;
   string S_s_455;
   string S_s_456;
   string S_s_457;
   string S_s_458;
   string S_s_459;
   string S_s_460;
   string S_s_461;
   string S_s_462;
   string S_s_463;
   string S_s_464;
   string S_s_465;
   string S_s_466;
   string S_s_467;
   double L_d_10;
   bool L_b_1;
   bool L_b_2;
   bool L_b_3;
   double L_d_1;
   double L_d_2;
   double L_d_3;
   int L_i_3;
   double L_d_4;
   bool L_b_4;
   double L_d_5;
   double L_d_6;
   int L_i_4;
   double L_d_7;
   bool L_b_5;
   bool L_b_6;
   int L_i_5;
   int L_i_24;
   int L_i_7;
   double L_d_8;
   int L_i_8;
   int L_i_9;
   int L_i_10;
   int L_i_11;
   int L_i_12;
   int L_i_13;
   bool L_b_7;
   bool L_b_8;
   bool L_b_9;
   bool L_b_10;
   int L_i_14;
   int L_i_15;
   string L_s_7;
   int L_i_16;
   int L_i_17;
   int L_i_42;
   if (Input_Struct_00000080.m_25 == "") {
      I_s_3 = "fully-licensed version";
   }
   if (Input_Struct_00000080.m_69 > 0) {
      func_1025();
   }
   if (IsOptimization() != true) {
      func_1026();
   }
   L_d_10 = 0;
   if (Activate_News_Filter && AfterNewsStop > 0) {
      if (IsTesting()) {
         G_i_16 = AfterNewsStop * 60;
         G_i_17 = BeforeNewsStop * 60;
         G_i_18 = 14400;
         G_l_4 = TimeCurrent();
         G_i_19 = ArraySize(I_s_379);
         G_i_20 = 0;
         if (ArraySize(I_s_379) > 0) {
            do {
               S_s_510 = StringSubstr(I_s_379[G_i_20], 0, StringFind(I_s_379[G_i_20], "|", 0));
               G_l_5 = StringToTime(S_s_510);
               G_l_6 = G_i_18;
               G_l_6 = G_l_5 + G_l_6;
               G_l_6 = G_l_6 - G_l_4;
               G_i_24 = -G_i_16;
               G_l_7 = G_i_24;
               if (G_l_6 > G_l_7) {
                  S_s_511 = StringSubstr(I_s_379[G_i_20], 0, StringFind(I_s_379[G_i_20], "|", 0));
                  G_l_8 = StringToTime(S_s_511);
                  G_l_9 = G_i_18;
                  G_l_9 = G_l_8 + G_l_9;
                  G_l_9 = G_l_9 - G_l_4;
                  G_l_10 = G_i_17;
                  if (G_l_9 < G_l_10) {
                     G_b_10 = true;
                     break;
                  }
               }
               G_i_20 = G_i_20 + 1;
            } while (G_i_20 < G_i_19);
         } else G_b_10 = false;
         G_i_27 = I_i_10;
         G_i_28 = 1;
         G_i_29 = 0;
         G_i_30 = 0;
         G_i_30 = 0;
         if (OrdersTotal() > 0) {
            do {
               if (OrderSelect(G_i_30, 0, 0) && OrderSymbol() == _Symbol && OrderMagicNumber() == G_i_27 && OrderType() == G_i_28) {
                  G_i_29 = G_i_29 + 1;
               }
               G_i_30 = G_i_30 + 1;
            } while (G_i_30 < OrdersTotal());
         }
         G_i_31 = G_i_29;
         G_i_32 = I_i_10;
         G_i_33 = 0;
         G_i_34 = 0;
         G_i_35 = 0;
         G_i_35 = 0;
         if (OrdersTotal() > 0) {
            do {
               if (OrderSelect(G_i_35, 0, 0) && OrderSymbol() == _Symbol && OrderMagicNumber() == G_i_32 && OrderType() == G_i_33) {
                  G_i_34 = G_i_34 + 1;
               }
               G_i_35 = G_i_35 + 1;
            } while (G_i_35 < OrdersTotal());
         }
         G_i_36 = G_i_31 + G_i_34;
         if (G_b_10 != false && G_i_36 == 0) {
            I_b_8 = false;
         } else {
            I_b_8 = true;
         }
      } else {
         G_l_22 = TimeCurrent() - I_l_23;
         G_l_24 = I_i_155;
         if (G_l_22 >= G_l_24) {
            Comment("News Loading...");
            Print("News Loading...");
            func_1036();
            I_l_23 = TimeCurrent();
            Comment("");
         }
         WindowRedraw();
         if (DrawLines) {
            L_i_15 = 0;
            if (I_i_156 > 0) {
               do {
                  G_i_157 = L_i_15;
                  S_s_512 = I_s_381[0, L_i_15];
                  S_s_482 = StringSubstr(S_s_512, 14, 4);
                  S_s_483 = StringSubstr(S_s_512, 11, 2);
                  S_s_484 = StringSubstr(S_s_512, 8, 2);
                  S_s_485 = StringSubstr(S_s_512, 5, 2);
                  S_s_486 = StringSubstr(S_s_512, 0, 4);
                  S_s_513 = StringConcatenate(S_s_486, ".", S_s_485, ".", S_s_484, " ", S_s_483, ":", S_s_482);
                  G_l_25 = StringToTime(S_s_513);
                  G_i_159 = offset * 3600;
                  G_l_26 = G_i_159;
                  S_s_487 = TimeToString((G_l_25 + G_l_26), 2);
                  S_s_487 = S_s_487 + "_";
                  S_s_487 = S_s_487 + I_s_381[1, L_i_15];
                  S_s_487 = S_s_487 + "_";
                  S_s_487 = S_s_487 + I_s_381[3, L_i_15];
                  L_s_7 = StringSubstr(S_s_487, 0, 63);
                  if (I_s_381[3, L_i_15] != "" && ObjectFind(L_s_7) == 0) {
                  } else {
                     if (StringFind(I_s_2, I_s_381[1, L_i_15], 0) < 0) {
                     } else {
                        G_i_187 = L_i_15;
                        S_s_488 = I_s_381[0, L_i_15];
                        S_s_490 = StringSubstr(S_s_488, 14, 4);
                        S_s_491 = StringSubstr(S_s_488, 11, 2);
                        S_s_492 = StringSubstr(S_s_488, 8, 2);
                        S_s_493 = StringSubstr(S_s_488, 5, 2);
                        S_s_494 = StringSubstr(S_s_488, 0, 4);
                        S_s_489 = StringConcatenate(S_s_494, ".", S_s_493, ".", S_s_492, " ", S_s_491, ":", S_s_490);
                        G_l_36 = StringToTime(S_s_489);
                        G_i_189 = offset * 3600;
                        G_l_37 = G_i_189;
                        G_l_37 = G_l_36 + G_l_37;
                        if (G_l_37 < TimeCurrent() && Next) {
                        } else {
                           L_i_42 = (int)4294967295;
                           if (I_b_2 && StringFind(I_s_381[2, L_i_15], "High", 0) >= 0) {
                              L_i_42 = I_i_5;
                           }
                           if (I_b_3 && StringFind(I_s_381[2, L_i_15], "Moderate", 0) >= 0) {
                              L_i_42 = I_i_6;
                           }
                           if (I_b_4 && StringFind(I_s_381[2, L_i_15], "Low", 0) >= 0) {
                              L_i_42 = I_i_7;
                           }
                           if (L_i_42 == (int)4294967295) {
                           } else {
                              if (I_s_381[3, L_i_15] != "") {
                                 G_i_193 = L_i_15;
                                 S_s_495 = I_s_381[0, L_i_15];
                                 S_s_497 = StringSubstr(S_s_495, 14, 4);
                                 S_s_498 = StringSubstr(S_s_495, 11, 2);
                                 S_s_420 = StringSubstr(S_s_495, 8, 2);
                                 S_s_421 = StringSubstr(S_s_495, 5, 2);
                                 S_s_422 = StringSubstr(S_s_495, 0, 4);
                                 S_s_496 = StringConcatenate(S_s_422, ".", S_s_421, ".", S_s_420, " ", S_s_498, ":", S_s_497);
                                 G_l_38 = StringToTime(S_s_496);
                                 G_i_195 = offset * 3600;
                                 G_l_39 = G_i_195;
                                 ObjectCreate(0, L_s_7, OBJ_VLINE, 0, (G_l_38 + G_l_39), 0, 0, 0, 0, 0);
                                 ObjectSet(L_s_7, OBJPROP_COLOR, 42495);
                                 ObjectSet(L_s_7, OBJPROP_STYLE, I_i_196);
                                 ObjectSetInteger(0, L_s_7, 9, 1);
                                 if (DrawFaixa) {
                                    G_i_197 = L_i_15;
                                    S_s_423 = I_s_381[0, L_i_15];
                                    S_s_425 = StringSubstr(S_s_423, 14, 4);
                                    S_s_426 = StringSubstr(S_s_423, 11, 2);
                                    S_s_427 = StringSubstr(S_s_423, 8, 2);
                                    S_s_428 = StringSubstr(S_s_423, 5, 2);
                                    S_s_429 = StringSubstr(S_s_423, 0, 4);
                                    S_s_424 = StringConcatenate(S_s_429, ".", S_s_428, ".", S_s_427, " ", S_s_426, ":", S_s_425);
                                    G_l_40 = StringToTime(S_s_424);
                                    G_l_41 = G_i_195;
                                    G_l_41 = G_l_40 + G_l_41;
                                    G_i_199 = AfterNewsStop * 60;
                                    G_l_42 = G_i_199;
                                    G_l_42 = G_l_41 + G_l_42;
                                    G_i_200 = L_i_15;
                                    S_s_430 = I_s_381[0, L_i_15];
                                    S_s_432 = StringSubstr(S_s_430, 14, 4);
                                    S_s_433 = StringSubstr(S_s_430, 11, 2);
                                    S_s_434 = StringSubstr(S_s_430, 8, 2);
                                    S_s_435 = StringSubstr(S_s_430, 5, 2);
                                    S_s_436 = StringSubstr(S_s_430, 0, 4);
                                    S_s_431 = StringConcatenate(S_s_436, ".", S_s_435, ".", S_s_434, " ", S_s_433, ":", S_s_432);
                                    G_l_43 = StringToTime(S_s_431);
                                    G_l_44 = G_i_195;
                                    G_l_44 = G_l_43 + G_l_44;
                                    G_i_202 = BeforeNewsStop * 60;
                                    G_l_45 = G_i_202;
                                    G_l_45 = G_l_44 - G_l_45;
                                    G_i_203 = L_i_15;
                                    S_s_437 = I_s_381[0, L_i_15];
                                    S_s_439 = StringSubstr(S_s_437, 14, 4);
                                    S_s_440 = StringSubstr(S_s_437, 11, 2);
                                    S_s_441 = StringSubstr(S_s_437, 8, 2);
                                    S_s_442 = StringSubstr(S_s_437, 5, 2);
                                    S_s_443 = StringSubstr(S_s_437, 0, 4);
                                    S_s_438 = StringConcatenate(S_s_443, ".", S_s_442, ".", S_s_441, " ", S_s_440, ":", S_s_439);
                                    G_l_46 = StringToTime(S_s_438);
                                    G_l_47 = G_i_195;
                                    G_l_47 = G_l_46 + G_l_47;
                                    S_s_444 = (string)G_l_47;
                                    S_s_444 = "News" + S_s_444;
                                    ObjectCreate(0, S_s_444, OBJ_RECTANGLE, 0, 0, 0, 0, 0, 0, 0);
                                    ObjectSet(S_s_444, OBJPROP_STYLE, 0);
                                    ObjectSet(S_s_444, OBJPROP_COLOR, L_i_42);
                                    ObjectSet(S_s_444, OBJPROP_BACK, 1);
                                    ObjectSet(S_s_444, OBJPROP_TIME1, G_l_45);
                                    ObjectSet(S_s_444, OBJPROP_PRICE1, ((_Point * 20000) + High[1]));
                                    ObjectSet(S_s_444, OBJPROP_TIME2, G_l_42);
                                    G_d_107 = (_Point * 20000);
                                    ObjectSet(S_s_444, OBJPROP_PRICE2, (Low[1] - G_d_107));
                                 }
                              }
                           }
                        }
                     }
                  }
                  L_i_15 = L_i_15 + 1;
               } while (L_i_15 < I_i_156);
            }
         }
         L_i_16 = 0;
         L_d_10 = 0;
         L_i_16 = 0;
         if (I_i_156 > 0) {
            do {
               L_i_17 = 0;
               if (I_b_2 && StringFind(I_s_381[2, L_i_16], "High", 0) >= 0) {
                  L_i_17 = 1;
               }
               if (I_b_3 && StringFind(I_s_381[2, L_i_16], "Moderate", 0) >= 0) {
                  L_i_17 = 2;
               }
               if (I_b_4 && StringFind(I_s_381[2, L_i_16], "Low", 0) >= 0) {
                  L_i_17 = 3;
               }
               if (L_i_17 != 0) {
                  G_l_27 = TimeCurrent();
                  G_i_165 = I_i_13 * 60;
                  G_l_28 = G_i_165;
                  G_l_28 = G_l_27 + G_l_28;
                  G_i_166 = L_i_16;
                  S_s_445 = I_s_381[0, L_i_16];
                  S_s_447 = StringSubstr(S_s_445, 14, 4);
                  S_s_448 = StringSubstr(S_s_445, 11, 2);
                  S_s_449 = StringSubstr(S_s_445, 8, 2);
                  S_s_450 = StringSubstr(S_s_445, 5, 2);
                  S_s_451 = StringSubstr(S_s_445, 0, 4);
                  S_s_446 = StringConcatenate(S_s_451, ".", S_s_450, ".", S_s_449, " ", S_s_448, ":", S_s_447);
                  G_l_29 = StringToTime(S_s_446);
                  G_i_168 = offset * 3600;
                  G_l_30 = G_i_168;
                  G_l_30 = G_l_29 + G_l_30;
                  if (G_l_28 > G_l_30) {
                     G_l_30 = TimeCurrent();
                     G_i_169 = I_i_14 * 60;
                     G_l_31 = G_i_169;
                     G_l_31 = G_l_30 - G_l_31;
                     G_i_170 = L_i_16;
                     S_s_452 = I_s_381[0, L_i_16];
                     S_s_454 = StringSubstr(S_s_452, 14, 4);
                     S_s_455 = StringSubstr(S_s_452, 11, 2);
                     S_s_456 = StringSubstr(S_s_452, 8, 2);
                     S_s_457 = StringSubstr(S_s_452, 5, 2);
                     S_s_458 = StringSubstr(S_s_452, 0, 4);
                     S_s_453 = StringConcatenate(S_s_458, ".", S_s_457, ".", S_s_456, " ", S_s_455, ":", S_s_454);
                     G_l_32 = StringToTime(S_s_453);
                     G_l_33 = G_i_168;
                     G_l_33 = G_l_32 + G_l_33;
                     if (G_l_31 < G_l_33 && StringFind(I_s_2, I_s_381[1, L_i_16], 0) >= 0) {
                        L_d_10 = 1;
                        break;
                     }
                  }
                  L_d_10 = 0;
               }
               L_i_16 = L_i_16 + 1;
            } while (L_i_16 < I_i_156);
         }
         if ((L_d_10 == 1) && L_i_16 != I_i_172 && Signal) {
            G_i_175 = L_i_16;
            S_s_459 = I_s_381[0, L_i_16];
            S_s_461 = StringSubstr(S_s_459, 14, 4);
            S_s_462 = StringSubstr(S_s_459, 11, 2);
            S_s_463 = StringSubstr(S_s_459, 8, 2);
            S_s_464 = StringSubstr(S_s_459, 5, 2);
            S_s_465 = StringSubstr(S_s_459, 0, 4);
            S_s_460 = StringConcatenate(S_s_465, ".", S_s_464, ".", S_s_463, " ", S_s_462, ":", S_s_461);
            G_l_34 = StringToTime(S_s_460);
            G_i_177 = offset * 3600;
            G_l_35 = G_i_177;
            G_l_35 = G_l_34 + G_l_35;
            G_l_35 = G_l_35 - TimeCurrent();
            G_i_177 = (int)G_l_35;
            Alert("In ", (G_i_177 / 60), " minutes released news ", I_s_381[1, L_i_16], "_", I_s_381[3, L_i_16]);
            I_i_172 = L_i_16;
         }
         G_i_177 = I_i_10;
         G_i_178 = 1;
         G_i_179 = 0;
         G_i_180 = 0;
         G_i_180 = 0;
         if (OrdersTotal() > 0) {
            do {
               if (OrderSelect(G_i_180, 0, 0) && OrderSymbol() == _Symbol && OrderMagicNumber() == G_i_177 && OrderType() == G_i_178) {
                  G_i_179 = G_i_179 + 1;
               }
               G_i_180 = G_i_180 + 1;
            } while (G_i_180 < OrdersTotal());
         }
         G_i_181 = G_i_179;
         G_i_182 = I_i_10;
         G_i_183 = 0;
         G_i_184 = 0;
         G_i_185 = 0;
         G_i_185 = 0;
         if (OrdersTotal() > 0) {
            do {
               if (OrderSelect(G_i_185, 0, 0) && OrderSymbol() == _Symbol && OrderMagicNumber() == G_i_182 && OrderType() == G_i_183) {
                  G_i_184 = G_i_184 + 1;
               }
               G_i_185 = G_i_185 + 1;
            } while (G_i_185 < OrdersTotal());
         }
         G_i_37 = G_i_181 + G_i_184;
         if ((L_d_10 > 0) && G_i_37 == 0) {
            I_s_8 = "News Time ==> No Trading";
            I_b_8 = false;
         } else {
            I_s_8 = "No News Time ==> Trading Allowed";
            I_b_8 = true;
         }
      }
   }
   if (IsTesting() != true) {
      ObjectSetString(0, "News", 999, I_s_8);
      S_s_466 = "Broker Time: " + TimeToString(TimeCurrent(), 4);
      ObjectSetString(0, "BrokerTime", 999, S_s_466);
   }
   string L_s_1[];
   L_b_1 = false;
   L_b_2 = false;
   L_b_3 = false;
   L_d_1 = 0;
   L_d_2 = 0;
   L_d_3 = 0;
   L_i_3 = 0;
   L_d_4 = 0;
   L_b_4 = false;
   L_d_5 = 0;
   L_d_6 = 0;
   L_i_4 = 0;
   L_d_7 = 0;
   L_b_5 = false;
   L_b_6 = false;
   if (I_b_0) {
      G_i_37 = I_i_10;
      G_i_38 = 0;
      G_i_39 = 0;
      G_i_40 = 0;
      G_i_40 = 0;
      if (OrdersTotal() > 0) {
         do {
            if (OrderSelect(G_i_40, 0, 0) && OrderSymbol() == _Symbol && OrderMagicNumber() == G_i_37 && OrderType() == G_i_38) {
               G_i_39 = G_i_39 + 1;
            }
            G_i_40 = G_i_40 + 1;
         } while (G_i_40 < OrdersTotal());
      }
      G_i_41 = G_i_39;
      G_i_42 = I_i_10;
      G_i_43 = 1;
      G_i_44 = 0;
      G_d_13 = 0;
      G_i_44 = 0;
      if (OrdersTotal() > 0) {
         do {
            if (OrderSelect(G_i_44, 0, 0) && OrderMagicNumber() == G_i_42 && OrderSymbol() == _Symbol && OrderType() == G_i_43) {
               G_d_13 = (G_d_13 + OrderLots());
            }
            G_i_44 = G_i_44 + 1;
         } while (G_i_44 < OrdersTotal());
      }
      if (((G_i_41 + G_d_13) == 0)) {
         G_i_45 = I_i_46;
         G_d_15 = 0;
         G_i_47 = 0;
         G_i_47 = 0;
         if (OrdersTotal() > 0) {
            do {
               if (OrderSelect(G_i_47, 0, 0) && OrderSymbol() == _Symbol && OrderMagicNumber() == G_i_45) {
                  G_d_15 = (G_d_15 + OrderProfit());
               }
               G_i_47 = G_i_47 + 1;
            } while (G_i_47 < OrdersTotal());
         }
         if ((G_d_15 < 0)) {
            Print("Close AlL Geral ");
            G_i_48 = 0;
            I_i_49 = OrdersTotal() - 1;
            if (I_i_49 >= 0) {
               do {
                  if (OrderSelect(I_i_49, 0, 0)) {
                     if (OrderSymbol() == Amazingforex_Pair) {
                        if (OrderMagicNumber() == I_i_46 || OrderMagicNumber() == I_i_10) {
                           if (OrderType() <= OP_SELL) {
                              if (OrderType() == G_i_48 || G_i_48 == 2) {
                                 if (!OrderClose(OrderTicket(), OrderLots(), OrderClosePrice(), 30, 32768)) {
                                    Print("close erro:", GetLastError());
                                 }
                              }
                           } else {
                              if (!OrderDelete(OrderTicket(), 4294967295)) {
                                 Print("delete erro:", GetLastError());
                              }
                           }
                        }
                     }
                  } else {
                     I_i_49 = OrdersTotal() - 1;
                  }
                  I_i_49 = I_i_49 - 1;
               } while (I_i_49 >= 0);
            }
            G_i_50 = 1;
            I_i_49 = OrdersTotal() - 1;
            if (I_i_49 >= 0) {
               do {
                  if (OrderSelect(I_i_49, 0, 0)) {
                     if (OrderSymbol() == Amazingforex_Pair) {
                        if (OrderMagicNumber() == I_i_46 || OrderMagicNumber() == I_i_10) {
                           if (OrderType() <= OP_SELL) {
                              if (OrderType() == G_i_50 || G_i_50 == 2) {
                                 if (!OrderClose(OrderTicket(), OrderLots(), OrderClosePrice(), 30, 32768)) {
                                    Print("close erro:", GetLastError());
                                 }
                              }
                           } else {
                              if (!OrderDelete(OrderTicket(), 4294967295)) {
                                 Print("delete erro:", GetLastError());
                              }
                           }
                        }
                     }
                  } else {
                     I_i_49 = OrdersTotal() - 1;
                  }
                  I_i_49 = I_i_49 - 1;
               } while (I_i_49 >= 0);
            }
            I_l_12 = TimeCurrent();
            I_b_9 = false;
         }
      }
      G_i_51 = I_i_10;
      G_i_52 = 0;
      G_i_53 = 0;
      G_i_54 = 0;
      G_i_54 = 0;
      if (OrdersTotal() > 0) {
         do {
            if (OrderSelect(G_i_54, 0, 0) && OrderSymbol() == _Symbol && OrderMagicNumber() == G_i_51 && OrderType() == G_i_52) {
               G_i_53 = G_i_53 + 1;
            }
            G_i_54 = G_i_54 + 1;
         } while (G_i_54 < OrdersTotal());
      }
      G_i_55 = G_i_53;
      G_i_56 = I_i_10;
      G_i_57 = 1;
      G_i_58 = 0;
      G_d_20 = 0;
      G_i_58 = 0;
      if (OrdersTotal() > 0) {
         do {
            if (OrderSelect(G_i_58, 0, 0) && OrderMagicNumber() == G_i_56 && OrderSymbol() == _Symbol && OrderType() == G_i_57) {
               G_d_20 = (G_d_20 + OrderLots());
            }
            G_i_58 = G_i_58 + 1;
         } while (G_i_58 < OrdersTotal());
      }
      if (((G_i_55 + G_d_20) == 0)) {
         I_l_12 = TimeCurrent();
         I_b_9 = false;
      }
      G_d_21 = AccountEquity();
      G_d_21 = ((G_d_21 / AccountBalance()) * 100);
      if ((NormalizeDouble((100 - G_d_21), 2) > I_d_4)) {
         G_i_59 = I_i_10;
         G_i_60 = 1;
         G_i_61 = 0;
         G_i_62 = 0;
         G_i_62 = 0;
         if (OrdersTotal() > 0) {
            do {
               if (OrderSelect(G_i_62, 0, 0) && OrderSymbol() == _Symbol && OrderMagicNumber() == G_i_59 && OrderType() == G_i_60) {
                  G_i_61 = G_i_61 + 1;
               }
               G_i_62 = G_i_62 + 1;
            } while (G_i_62 < OrdersTotal());
         }
         G_i_63 = I_i_10;
         G_i_64 = 0;
         G_i_65 = 0;
         G_i_66 = 0;
         G_i_66 = 0;
         if (OrdersTotal() > 0) {
            do {
               if (OrderSelect(G_i_66, 0, 0) && OrderSymbol() == _Symbol && OrderMagicNumber() == G_i_63 && OrderType() == G_i_64) {
                  G_i_65 = G_i_65 + 1;
               }
               G_i_66 = G_i_66 + 1;
            } while (G_i_66 < OrdersTotal());
         }
         if (G_i_61 == 0 || G_i_65 == 0) {
            G_i_67 = I_i_10;
            G_i_68 = 1;
            G_i_69 = 0;
            G_i_70 = 0;
            G_i_70 = 0;
            if (OrdersTotal() > 0) {
               do {
                  if (OrderSelect(G_i_70, 0, 0) && OrderSymbol() == _Symbol && OrderMagicNumber() == G_i_67 && OrderType() == G_i_68) {
                     G_i_69 = G_i_69 + 1;
                  }
                  G_i_70 = G_i_70 + 1;
               } while (G_i_70 < OrdersTotal());
            }
            G_i_71 = I_i_46;
            G_i_72 = 0;
            G_i_73 = 0;
            G_i_74 = 0;
            G_i_74 = 0;
            if (OrdersTotal() > 0) {
               do {
                  if (OrderSelect(G_i_74, 0, 0) && OrderSymbol() == _Symbol && OrderMagicNumber() == G_i_71 && OrderType() == G_i_72) {
                     G_i_73 = G_i_73 + 1;
                  }
                  G_i_74 = G_i_74 + 1;
               } while (G_i_74 < OrdersTotal());
            }
            G_i_75 = I_i_10;
            G_i_76 = 1;
            G_i_77 = 0;
            G_i_78 = OrdersTotal() - 1;
            G_i_77 = G_i_78;
            if (G_i_78 >= 0) {
               do {
                  if (OrderSelect(G_i_77, 0, 0) && OrderMagicNumber() == G_i_75 && OrderSymbol() == _Symbol && OrderType() == G_i_76) {
                     G_d_23 = OrderOpenPrice();
                     break;
                  }
                  G_i_77 = G_i_77 - 1;
               } while (G_i_77 >= 0);
            }
            if (G_i_76 == 0) {
               G_d_23 = 0;
            } else {
               G_d_23 = 10000;
            }
            G_i_79 = I_i_46;
            G_i_80 = 0;
            G_i_81 = 0;
            G_i_82 = 0;
            G_i_82 = 0;
            if (OrdersTotal() > 0) {
               do {
                  if (OrderSelect(G_i_82, 0, 0) && OrderMagicNumber() == I_i_10 && OrderSymbol() == _Symbol) {
                     G_l_13 = OrderOpenTime();
                     break;
                  }
                  G_i_82 = G_i_82 + 1;
               } while (G_i_82 < OrdersTotal());
            } else G_l_13 = 0;
            G_l_14 = G_l_13;
            G_i_83 = HistoryTotal() - 1;
            G_i_81 = G_i_83;
            if (G_i_83 >= 0) {
               do {
                  if (OrderSelect(G_i_81, 0, 1) && OrderMagicNumber() == G_i_79 && OrderSymbol() == _Symbol && OrderType() == G_i_80 && OrderOpenTime() > G_l_14) {
                     if (G_i_80 == 0) {
                        G_d_24 = iHigh(_Symbol, _Period, iBarShift(_Symbol, _Period, OrderCloseTime(), false));
                        break;
                     }
                     G_d_24 = iLow(_Symbol, _Period, iBarShift(_Symbol, _Period, OrderCloseTime(), false));
                     break;
                  }
                  G_i_81 = G_i_81 - 1;
               } while (G_i_81 >= 0);
            }
            if (G_i_80 == 0) {
               G_d_24 = 0;
            } else {
               G_d_24 = 10000;
            }
            if (G_i_69 > 0 && G_i_73 == 0 && (Ask <= G_d_23) && (Ask > G_d_24)) {
               Print("Entra Hedge");
               func_1042();
               I_b_9 = true;
            } else {
               G_i_134 = I_i_10;
               G_i_135 = 0;
               G_i_136 = 0;
               G_i_137 = 0;
               G_i_137 = 0;
               if (OrdersTotal() > 0) {
                  do {
                     if (OrderSelect(G_i_137, 0, 0) && OrderSymbol() == _Symbol && OrderMagicNumber() == G_i_134 && OrderType() == G_i_135) {
                        G_i_136 = G_i_136 + 1;
                     }
                     G_i_137 = G_i_137 + 1;
                  } while (G_i_137 < OrdersTotal());
               }
               if (G_i_136 > 0) {
                  G_i_138 = I_i_46;
                  G_i_139 = 1;
                  G_i_140 = 0;
                  G_i_141 = 0;
                  G_i_141 = 0;
                  if (OrdersTotal() > 0) {
                     do {
                        if (OrderSelect(G_i_141, 0, 0) && OrderSymbol() == _Symbol && OrderMagicNumber() == G_i_138 && OrderType() == G_i_139) {
                           G_i_140 = G_i_140 + 1;
                        }
                        G_i_141 = G_i_141 + 1;
                     } while (G_i_141 < OrdersTotal());
                  }
                  if (G_i_140 == 0) {
                     G_i_142 = I_i_10;
                     G_i_143 = 0;
                     G_i_144 = 0;
                     G_i_145 = OrdersTotal() - 1;
                     G_i_144 = G_i_145;
                     if (G_i_145 >= 0) {
                        do {
                           if (OrderSelect(G_i_144, 0, 0) && OrderMagicNumber() == G_i_142 && OrderSymbol() == _Symbol && OrderType() == G_i_143) {
                              G_d_103 = OrderOpenPrice();
                              break;
                           }
                           G_i_144 = G_i_144 - 1;
                        } while (G_i_144 >= 0);
                     }
                     if (G_i_143 == 0) {
                        G_d_103 = 0;
                     } else {
                        G_d_103 = 10000;
                     }
                     if ((Bid < G_d_103)) {
                        G_i_146 = I_i_46;
                        G_i_147 = 1;
                        G_i_148 = 0;
                        G_i_149 = 0;
                        G_i_149 = 0;
                        if (OrdersTotal() > 0) {
                           do {
                              if (OrderSelect(G_i_149, 0, 0) && OrderMagicNumber() == I_i_10 && OrderSymbol() == _Symbol) {
                                 G_l_17 = OrderOpenTime();
                                 break;
                              }
                              G_i_149 = G_i_149 + 1;
                           } while (G_i_149 < OrdersTotal());
                        } else G_l_17 = 0;
                        G_l_18 = G_l_17;
                        G_i_150 = HistoryTotal() - 1;
                        G_i_148 = G_i_150;
                        if (G_i_150 >= 0) {
                           do {
                              if (OrderSelect(G_i_148, 0, 1) && OrderMagicNumber() == G_i_146 && OrderSymbol() == _Symbol && OrderType() == G_i_147 && OrderOpenTime() > G_l_18) {
                                 if (G_i_147 == 0) {
                                    G_d_104 = iHigh(_Symbol, _Period, iBarShift(_Symbol, _Period, OrderCloseTime(), false));
                                    break;
                                 }
                                 G_d_104 = iLow(_Symbol, _Period, iBarShift(_Symbol, _Period, OrderCloseTime(), false));
                                 break;
                              }
                              G_i_148 = G_i_148 - 1;
                           } while (G_i_148 >= 0);
                        }
                        if (G_i_147 == 0) {
                           G_d_104 = 0;
                        } else {
                           G_d_104 = 10000;
                        }
                        if ((Bid < G_d_104)) {
                           G_i_151 = I_i_10;
                           G_i_152 = 0;
                           G_i_153 = 0;
                           G_i_154 = OrdersTotal() - 1;
                           G_i_153 = G_i_154;
                           if (G_i_154 >= 0) {
                              do {
                                 if (OrderSelect(G_i_153, 0, 0) && OrderMagicNumber() == G_i_151 && OrderSymbol() == _Symbol && OrderType() == G_i_152) {
                                    G_d_105 = OrderOpenPrice();
                                    break;
                                 }
                                 G_i_153 = G_i_153 - 1;
                              } while (G_i_153 >= 0);
                           }
                           if (G_i_152 == 0) {
                              G_d_105 = 0;
                           } else {
                              G_d_105 = 10000;
                           }
                           Print("Entra Hedge: ", G_d_105);
                           func_1043();
                           I_b_9 = true;
                        }
                     }
                  }
               }
            }
         }
      }
      G_i_84 = 0;
      G_i_85 = 0;
      G_i_85 = OrdersTotal();
      G_i_86 = 0;
      if (G_i_85 > 0) {
         do {
            if (OrderSelect(G_i_86, 0, 0)) {
               G_i_84 = OrderType();
               if (OrderSymbol() == _Symbol && OrderMagicNumber() == I_i_46) {
                  if (G_i_84 == 0 || G_i_84 == 1) {
                     func_1052(OrderTicket());
                  }
               }
            }
            G_i_86 = G_i_86 + 1;
         } while (G_i_86 < G_i_85);
      }
      if (I_b_1) {
         G_i_87 = I_i_46;
         G_i_88 = 0;
         G_i_89 = 0;
         G_d_25 = 0;
         G_i_89 = 0;
         if (OrdersTotal() > 0) {
            do {
               if (OrderSelect(G_i_89, 0, 0) && OrderMagicNumber() == G_i_87 && OrderSymbol() == _Symbol && OrderType() == G_i_88) {
                  G_d_25 = (G_d_25 + OrderLots());
               }
               G_i_89 = G_i_89 + 1;
            } while (G_i_89 < OrdersTotal());
         }
         G_d_26 = G_d_25;
         G_i_90 = I_i_46;
         G_i_91 = 1;
         G_i_92 = 0;
         G_d_27 = 0;
         G_i_92 = 0;
         if (OrdersTotal() > 0) {
            do {
               if (OrderSelect(G_i_92, 0, 0) && OrderMagicNumber() == G_i_90 && OrderSymbol() == _Symbol && OrderType() == G_i_91) {
                  G_d_27 = (G_d_27 + OrderLots());
               }
               G_i_92 = G_i_92 + 1;
            } while (G_i_92 < OrdersTotal());
         }
         if (((G_d_26 + G_d_27) > 0)) {
            G_i_93 = 0;
            G_i_94 = 0;
            G_i_94 = OrdersTotal();
            G_d_28 = func_1040();
            G_i_95 = 0;
            if (G_i_94 > 0) {
               do {
                  if (OrderSelect(G_i_95, 0, 0)) {
                     G_i_93 = OrderType();
                     if (OrderSymbol() == _Symbol && OrderMagicNumber() == I_i_10) {
                        if (G_i_93 == 0 || G_i_93 == 1) {
                           G_d_29 = OrderProfit();
                           G_d_29 = (G_d_29 - OrderCommission());
                           G_d_29 = (G_d_29 - OrderSwap());
                           if ((G_d_28 > 0) && (G_d_29 < 0)) {
                              G_d_30 = -G_d_29;
                              if ((G_d_28 > G_d_30)) {
                                 Print("#Armotiza:", G_d_28, " | ", -OrderProfit());
                                 G_d_28 = (G_d_28 + G_d_29);
                                 I_l_16 = TimeCurrent();
                                 if (OrderClose(OrderTicket(), OrderLots(), OrderClosePrice(), 30, 32768)) break;
                                 S_s_467 = StringConcatenate("Close Order - Error ", OrderTicket(), " | ", GetLastError());
                                 Print(S_s_467);
                              }
                           }
                        }
                     }
                  }
                  G_i_95 = G_i_95 + 1;
               } while (G_i_95 < G_i_94);
            }
         }
      }
   }
   G_d_32 = AccountEquity();
   G_d_32 = ((AccountEquity() / AccountBalance()) * 100);
   G_i_97 = I_i_46;
   G_i_98 = 1;
   G_i_99 = 0;
   G_d_33 = 0;
   G_i_99 = 0;
   if (OrdersTotal() > 0) {
      do {
         if (OrderSelect(G_i_99, 0, 0) && OrderMagicNumber() == G_i_97 && OrderSymbol() == _Symbol && OrderType() == G_i_98) {
            G_d_33 = (G_d_33 + OrderLots());
         }
         G_i_99 = G_i_99 + 1;
      } while (G_i_99 < OrdersTotal());
   }
   G_i_100 = I_i_46;
   G_i_101 = 0;
   G_i_102 = 0;
   G_d_34 = 0;
   G_i_102 = 0;
   if (OrdersTotal() > 0) {
      do {
         if (OrderSelect(G_i_102, 0, 0) && OrderMagicNumber() == G_i_100 && OrderSymbol() == _Symbol && OrderType() == G_i_101) {
            G_d_34 = (G_d_34 + OrderLots());
         }
         G_i_102 = G_i_102 + 1;
      } while (G_i_102 < OrdersTotal());
   }
   if (G_d_33 > 0 || NormalizeDouble((100 - ((AccountEquity() / AccountBalance()) * 100)), 2) > I_d_4 || (G_d_34 > 0)) {
      ArrayFree(L_s_1);
      return ;
   }
   if (I_b_21 == false && I_b_9) {
      ArrayFree(L_s_1);
      return ;
   }
   L_i_5 = 0;
   I_i_49 = OrdersTotal() - 1;
   if (I_i_49 >= 0) {
      do {
         if (OrderSelect(I_i_49, 0, 0)) {
            if (OrderMagicNumber() == I_i_9 || OrderMagicNumber() == I_i_11) {
               I_i_103 = 0;
               if (I_i_8 > 0) {
                  do {
                     if (OrderSymbol() == I_s_380[I_i_103]) {
                        L_b_1 = true;
                        L_i_24 = 0;
                        if (L_i_5 > 0) {
                           do {
                              if (L_s_1[L_i_24] == OrderSymbol()) {
                                 L_b_1 = false;
                              }
                              L_i_24 = L_i_24 + 1;
                           } while (L_i_24 < L_i_5);
                        }
                        if (L_b_1) {
                           L_i_5 = L_i_5 + 1;
                           ArrayResize(L_s_1, L_i_5, 0);
                           G_i_106 = L_i_5 - 1;
                           L_s_1[G_i_106] = OrderSymbol();
                        }
                     }
                     I_i_103 = I_i_103 + 1;
                  } while (I_i_103 < I_i_8);
               }
            }
         }
         I_i_49 = I_i_49 - 1;
      } while (I_i_49 >= 0);
   }
   I_i_103 = 0;
   if (I_i_8 > 0) {
      do {
         I_s_12 = I_s_380[I_i_103];
         L_b_2 = false;
         if (L_i_5 < I_i_108) {
            L_b_2 = true;
         } else {
            L_i_14 = 0;
            if (L_i_5 > 0) {
               do {
                  if (I_s_12 == L_s_1[L_i_14] && L_i_14 < I_i_108) {
                     L_b_2 = true;
                  }
                  L_i_14 = L_i_14 + 1;
               } while (L_i_14 < L_i_5);
            }
         }
         L_i_7 = (int)MarketInfo(I_s_12, MODE_DIGITS);
         L_d_8 = MarketInfo(I_s_12, MODE_POINT);
         I_d_35 = NormalizeDouble(MarketInfo(I_s_12, MODE_TICKVALUE), L_i_7);
         I_i_109 = 0;
         I_i_110 = 0;
         I_i_111 = 0;
         I_i_112 = 0;
         I_d_36 = 0;
         I_d_37 = 0;
         I_d_38 = 0;
         I_d_39 = 0;
         I_d_40 = 0;
         I_d_41 = 0;
         L_i_8 = 0;
         L_i_9 = 0;
         I_i_49 = 0;
         if (OrdersTotal() > 0) {
            do {
               if (OrderSelect(I_i_49, 0, 0)) {
                  if (OrderSymbol() == I_s_12 && OrderMagicNumber() == I_i_9) {
                     I_i_111 = I_i_111 + 1;
                  }
                  if (OrderSymbol() == I_s_12 && OrderMagicNumber() == I_i_11) {
                     I_i_112 = I_i_112 + 1;
                  }
                  if (OrderSymbol() == I_s_12 && OrderMagicNumber() == I_i_9 && OrderType() == OP_BUY) {
                     I_d_42 = OrderLots();
                     I_i_109 = I_i_109 + 1;
                     G_d_43 = (I_d_36 + OrderProfit());
                     G_d_43 = (G_d_43 + OrderSwap());
                     I_d_36 = (G_d_43 + OrderCommission());
                     I_d_44 = OrderOpenPrice();
                     I_d_45 = OrderStopLoss();
                     I_d_46 = OrderTakeProfit();
                     I_d_14 = I_d_38 + OrderLots();
                     I_d_38 = I_d_14;
                     G_d_43 = (I_d_36 / I_d_14);
                     I_d_40 = NormalizeDouble((G_d_43 / I_d_35), L_i_7);
                  }
                  if (OrderSymbol() == I_s_12 && OrderMagicNumber() == I_i_11 && OrderType() == OP_SELL) {
                     I_i_110 = I_i_110 + 1;
                     I_d_47 = OrderLots();
                     I_d_48 = OrderOpenPrice();
                     I_d_49 = OrderStopLoss();
                     I_d_50 = OrderTakeProfit();
                     I_d_39 = (I_d_39 + OrderLots());
                     G_d_43 = (I_d_37 + OrderProfit());
                     G_d_43 = (G_d_43 + OrderSwap());
                     I_d_37 = (G_d_43 + OrderCommission());
                     G_d_43 = (I_d_37 / I_d_39);
                     I_d_41 = NormalizeDouble((G_d_43 / I_d_35), L_i_7);
                  }
               }
               I_i_49 = I_i_49 + 1;
            } while (I_i_49 < OrdersTotal());
         }
         if ((L_i_7 == 5 || L_i_7 == 3)
               && (I_s_12 == "XAU" || I_s_12 == "XAUUSDcheck" || I_s_12 == "XAUUSD" || I_s_12 == "GOLD" || I_s_12 == "GOLDmicro")) {
            I_i_113 = 10;
         } else {
            I_i_113 = 1;
         }
         if (L_i_7 == 3 && (I_s_12 == "XAU" || I_s_12 == "XAUUSDcheck" || I_s_12 == "XAUUSD" || I_s_12 == "GOLD" || I_s_12 == "GOLDmicro")) {
            I_i_113 = 100;
         } else {
            I_i_113 = 10;
         }
         if ((L_d_8 == 0) == false && I_i_113 != 0) {
            G_d_43 = MarketInfo(I_s_12, MODE_ASK);
            G_d_43 = (G_d_43 - MarketInfo(I_s_12, MODE_BID));
            G_d_43 = (G_d_43 / L_d_8);
            I_d_51 = NormalizeDouble((G_d_43 / I_i_113), 2);
            I_d_52 = MarketInfo(I_s_12, MODE_MINLOT);
            I_d_53 = MarketInfo(I_s_12, MODE_MAXLOT);
            if ((I_d_52 == 0.01)) {
               I_i_114 = 2;
            }
            if ((I_d_52 == 0.1)) {
               I_i_114 = 1;
            }
            if ((I_d_52 == 1)) {
               I_i_114 = 0;
            }
            HideTestIndicators(true);
            if (DayOfWeek() == 1) {
               I_s_14 = I_s_15;
            }
            if (DayOfWeek() == 2) {
               I_s_14 = I_s_16;
            }
            if (DayOfWeek() == 3) {
               I_s_14 = I_s_17;
            }
            if (DayOfWeek() == 4) {
               I_s_14 = I_s_18;
            }
            if (DayOfWeek() == 5) {
               I_s_14 = I_s_19;
            }
            if (DayOfWeek() == 6) {
               I_s_14 = I_s_20;
            }
            if (DayOfWeek() == 7) {
               I_s_14 = I_s_21;
            }
            if (I_i_115 == 0) {
               I_d_54 = 1000;
            }
            if (I_i_115 == 1) {
               I_d_54 = 30;
            }
            G_i_117 = I_i_116 - iHighest(I_s_12, 0, 2, I_i_116, I_i_115);
            G_i_117 = G_i_117 + I_i_115;
            G_d_43 = (G_i_117 * 100);
            I_d_55 = (G_d_43 / I_i_116);
            G_i_117 = I_i_116 - iLowest(I_s_12, 0, 1, I_i_116, I_i_115);
            G_i_117 = G_i_117 + I_i_115;
            G_d_43 = (G_i_117 * 100);
            I_d_56 = (G_d_43 / I_i_116);
            G_i_117 = I_i_115 + 1;
            G_i_118 = I_i_116 - iHighest(I_s_12, 0, 2, I_i_116, G_i_117);
            G_i_118 = G_i_118 + I_i_115;
            G_i_118 = G_i_118 + 1;
            G_d_57 = (G_i_118 * 100);
            I_d_58 = (G_d_57 / I_i_116);
            G_i_118 = I_i_116 - iLowest(I_s_12, 0, 1, I_i_116, G_i_117);
            G_i_118 = G_i_118 + I_i_115;
            G_i_118 = G_i_118 + 1;
            G_d_57 = (G_i_118 * 100);
            I_d_59 = (G_d_57 / I_i_116);
            I_d_60 = (I_d_55 - I_d_56);
            I_d_61 = (I_d_58 - I_d_59);
            if ((I_d_60 > I_i_119) && (I_d_61 < I_i_119)) {
               I_s_22 = "BUY";
            } else {
               I_s_22 = "NOBUY";
            }
            G_i_118 = -I_i_119;
            if ((I_d_60 < G_i_118) && (I_d_61 > G_i_118)) {
               I_s_23 = "SELL";
            } else {
               I_s_23 = "NOSELL";
            }
            if (I_i_120 > 0) {
               G_i_118 = I_i_120 * I_i_113;
               if ((G_i_118 > MarketInfo(I_s_12, MODE_STOPLEVEL))) {
                  G_d_62 = (G_i_118 * L_d_8);
                  I_d_63 = (MarketInfo(I_s_12, MODE_ASK) - G_d_62);
                  G_d_62 = (G_i_118 * L_d_8);
                  I_d_64 = (G_d_62 + MarketInfo(I_s_12, MODE_BID));
               }
            }
            G_i_121 = I_i_120 * I_i_113;
            if (I_i_120 == 0 || (G_i_121 <= MarketInfo(I_s_12, MODE_STOPLEVEL))) {
               I_d_63 = 0;
               I_d_64 = 0;
            }
            if ((TakeProfit > 0)) {
               G_d_62 = (TakeProfit * I_i_113);
               if ((G_d_62 > MarketInfo(I_s_12, MODE_STOPLEVEL))) {
                  G_d_62 = ((TakeProfit * I_i_113) * L_d_8);
                  I_d_65 = (G_d_62 + MarketInfo(I_s_12, MODE_ASK));
                  G_d_62 = ((TakeProfit * I_i_113) * L_d_8);
                  I_d_66 = (MarketInfo(I_s_12, MODE_BID) - G_d_62);
               }
            }
            G_d_62 = (TakeProfit * I_i_113);
            if (TakeProfit == 0 || (G_d_62 <= MarketInfo(I_s_12, MODE_STOPLEVEL))) {
               I_d_65 = 0;
               I_d_66 = 0;
            }
            if (L_b_2 && I_i_111 == 0) {
               L_b_3 = true;
               if (I_s_22 == "BUY") {
                  L_d_1 = AccountFreeMargin();
                  L_d_2 = MarketInfo(I_s_12, MODE_MARGINREQUIRED);
                  I_d_67 = I_d_2;
                  if ((I_d_2 < I_d_52)) {
                     I_d_67 = I_d_52;
                  }
                  if ((I_d_67 > I_d_53)) {
                     I_d_67 = I_d_53;
                  }
                  if ((L_d_1 < (L_d_2 * I_d_67))) {
                     Print("No Enougt Money to Open NextOrder or Volume size is Over Maximum Lot.");
                     ArrayFree(L_s_1);
                     ArrayFree(L_s_1);
                     return ;
                  }
                  L_i_3 = L_i_3 * I_i_113;
                  L_d_4 = MarketInfo(I_s_12, MODE_ASK);
                  I_d_67 = I_d_2;
                  if ((I_d_2 < I_d_52)) {
                     I_d_67 = I_d_52;
                  }
                  if ((I_d_67 > I_d_53)) {
                     I_d_67 = I_d_53;
                  }
                  G_b_24 = (MarketInfo(I_s_12, MODE_SPREAD) >= maxSpread);
                  if (G_b_24) {
                     G_b_24 = false;
                  } else {
                     G_b_24 = true;
                  }
                  if (G_b_24) {
                     if (I_b_8 == true || Activate_News_Filter == 0) {
                        L_i_10 = OrderSend(I_s_12, 0, I_d_67, L_d_4, L_i_3, I_d_63, I_d_65, I_s_24, I_i_9, 0, 16711680);
                     }
                  }
                  ArrayFree(L_s_1);
                  ArrayFree(L_s_1);
                  return ;
               }
            }
            if (L_b_2 && I_i_112 == 0) {
               L_b_4 = true;
               if (I_s_23 == "SELL" && (iVolume(I_s_12, 0, 0) < I_d_54)) {
                  L_d_5 = AccountFreeMargin();
                  L_d_6 = MarketInfo(I_s_12, MODE_MARGINREQUIRED);
                  I_d_67 = I_d_2;
                  if ((I_d_2 < I_d_52)) {
                     I_d_67 = I_d_52;
                  }
                  if ((I_d_67 > I_d_53)) {
                     I_d_67 = I_d_53;
                  }
                  if ((L_d_5 < (L_d_6 * I_d_67))) {
                     Print("No Enougt Money to Open NextOrder or Volume size is Over Maximum Lot.");
                     ArrayFree(L_s_1);
                     ArrayFree(L_s_1);
                     return ;
                  }
                  L_i_4 = L_i_3 * I_i_113;
                  L_d_7 = MarketInfo(I_s_12, MODE_BID);
                  I_d_67 = I_d_2;
                  G_b_25 = I_d_2 < I_d_52;
                  if (G_b_25) {
                     I_d_67 = I_d_52;
                  }
                  G_b_25 = I_d_67 > I_d_53;
                  if (G_b_25) {
                     I_d_67 = I_d_53;
                  }
                  G_b_25 = (MarketInfo(I_s_12, MODE_SPREAD) >= maxSpread);
                  if (G_b_25) {
                     G_b_25 = false;
                  } else {
                     G_b_25 = true;
                  }
                  if (G_b_25) {
                     if (I_b_8 == true || Activate_News_Filter == 0) {
                        L_i_11 = OrderSend(I_s_12, 1, I_d_67, L_d_7, L_i_4, I_d_64, I_d_66, I_s_24, I_i_11, 0, 255);
                     }
                  }
                  ArrayFree(L_s_1);
                  ArrayFree(L_s_1);
                  return ;
               }
            }
            if (I_i_109 > 0) {
               I_d_69 = NormalizeDouble((I_d_42 * I_d_3), I_i_114);
            }
            if (I_b_26) {
               if (I_i_109 > 0 && I_i_109 < I_i_122) {
                  if (I_b_27 != false) {
                     G_d_68 = MarketInfo(I_s_12, MODE_ASK);
                     G_d_70 = (I_d_0 * I_i_113);
                     G_d_70 = (G_d_70 * MarketInfo(I_s_12, MODE_POINT));
                     if ((G_d_68 <= (I_d_44 - G_d_70))) {
                        L_b_5 = true;
                     } else {
                        L_b_5 = false;
                     }
                  } else {
                     L_b_5 = true;
                  }
                  if (L_b_5) {
                     G_d_70 = AccountFreeMargin();
                     G_d_71 = MarketInfo(I_s_12, MODE_MARGINREQUIRED);
                     I_d_67 = I_d_2;
                     if ((I_d_2 < I_d_52)) {
                        I_d_67 = I_d_52;
                     }
                     if ((I_d_67 > I_d_53)) {
                        I_d_67 = I_d_53;
                     }
                     I_d_69 = NormalizeDouble(I_d_67, I_i_114);
                     if ((NormalizeDouble(I_d_67, I_i_114) < I_d_52)) {
                        I_d_69 = I_d_52;
                     }
                     if ((I_d_69 > I_d_53)) {
                        I_d_69 = I_d_53;
                     }
                     if ((I_d_3 < 1.5)) {
                        if (I_i_109 < 20) {
                           returned_double = MathPow(I_d_3, I_i_109);
                           I_d_69 = NormalizeDouble((I_d_69 * returned_double), I_i_114);
                        } else {
                           I_d_69 = NormalizeDouble((I_d_42 * I_d_3), I_i_114);
                        }
                        if ((I_d_69 > I_d_53)) {
                           I_d_69 = I_d_53;
                        }
                        if ((I_d_69 < I_d_52)) {
                           I_d_69 = I_d_52;
                        }
                     } else {
                        if ((I_d_3 >= 1.5)) {
                           if (I_i_109 > 0) {
                              I_d_69 = NormalizeDouble((I_d_42 * I_d_3), I_i_114);
                           }
                           if ((I_d_69 > I_d_53)) {
                              I_d_69 = I_d_53;
                           }
                           if ((I_d_69 < I_d_52)) {
                              I_d_69 = I_d_52;
                           }
                        }
                     }
                     if ((G_d_70 < (G_d_71 * I_d_69))) {
                        Print("No Enougt Money to Open NextOrder or Volume size is Over Maximum Lot.");
                        ArrayFree(L_s_1);
                        ArrayFree(L_s_1);
                        return ;
                     }
                     G_b_29 = (MarketInfo(I_s_12, MODE_SPREAD) >= maxSpread);
                     if (G_b_29) {
                        G_b_29 = false;
                     } else {
                        G_b_29 = true;
                     }
                     if (G_b_29) {
                        if (I_b_8 == true || Activate_News_Filter == 0) {
                           I_d_67 = I_d_2;
                           if ((I_d_2 < I_d_52)) {
                              I_d_67 = I_d_52;
                           }
                           if ((I_d_67 > I_d_53)) {
                              I_d_67 = I_d_53;
                           }
                           I_d_69 = NormalizeDouble(I_d_67, I_i_114);
                           if ((NormalizeDouble(I_d_67, I_i_114) < I_d_52)) {
                              I_d_69 = I_d_52;
                           }
                           if ((I_d_69 > I_d_53)) {
                              I_d_69 = I_d_53;
                           }
                           if ((I_d_3 < 1.5)) {
                              if (I_i_109 < 20) {
                                 returned_double = MathPow(I_d_3, I_i_109);
                                 I_d_69 = NormalizeDouble((I_d_69 * returned_double), I_i_114);
                              } else {
                                 I_d_69 = NormalizeDouble((I_d_42 * I_d_3), I_i_114);
                              }
                              if ((I_d_69 > I_d_53)) {
                                 I_d_69 = I_d_53;
                              }
                              if ((I_d_69 < I_d_52)) {
                                 I_d_69 = I_d_52;
                              }
                           } else {
                              if ((I_d_3 >= 1.5)) {
                                 if (I_i_109 > 0) {
                                    I_d_69 = NormalizeDouble((I_d_42 * I_d_3), I_i_114);
                                 }
                                 if ((I_d_69 > I_d_53)) {
                                    I_d_69 = I_d_53;
                                 }
                                 if ((I_d_69 < I_d_52)) {
                                    I_d_69 = I_d_52;
                                 }
                              }
                           }
                           L_i_12 = OrderSend(I_s_12, 0, I_d_69, MarketInfo(I_s_12, MODE_ASK), (L_i_3 * I_i_113), I_d_45, 0, I_s_24, I_i_9, 0, 16776960);
                        }
                     }
                  }
               }
               if (I_i_110 > 0 && I_i_110 < I_i_122) {
                  if (I_b_27 != false) {
                     G_d_75 = MarketInfo(I_s_12, MODE_BID);
                     G_d_76 = (I_d_0 * I_i_113);
                     if ((G_d_75 >= ((G_d_76 * MarketInfo(I_s_12, MODE_POINT)) + I_d_48))) {
                        L_b_6 = true;
                     } else {
                        L_b_6 = false;
                     }
                  } else {
                     L_b_6 = true;
                  }
                  if (L_b_6) {
                     G_d_76 = AccountFreeMargin();
                     G_d_77 = MarketInfo(I_s_12, MODE_MARGINREQUIRED);
                     I_d_67 = I_d_2;
                     if ((I_d_2 < I_d_52)) {
                        I_d_67 = I_d_52;
                     }
                     if ((I_d_67 > I_d_53)) {
                        I_d_67 = I_d_53;
                     }
                     I_d_78 = NormalizeDouble(I_d_67, I_i_114);
                     if ((NormalizeDouble(I_d_67, I_i_114) < I_d_52)) {
                        I_d_78 = I_d_52;
                     }
                     if ((I_d_78 > I_d_53)) {
                        I_d_78 = I_d_53;
                     }
                     if ((I_d_3 < 1.5)) {
                        if (I_i_110 < 20) {
                           returned_double = MathPow(I_d_3, I_i_110);
                           I_d_78 = NormalizeDouble((I_d_78 * returned_double), I_i_114);
                        } else {
                           if (I_i_110 > 20) {
                              I_d_78 = NormalizeDouble((I_d_47 * I_d_3), I_i_114);
                           }
                        }
                        if ((I_d_78 > I_d_53)) {
                           I_d_78 = I_d_53;
                        }
                        if ((I_d_78 < I_d_52)) {
                           I_d_78 = I_d_52;
                        }
                     }
                     if ((I_d_3 >= 1.5)) {
                        if (I_i_110 > 0) {
                           I_d_78 = NormalizeDouble((I_d_47 * I_d_3), I_i_114);
                        }
                        if ((I_d_78 > I_d_53)) {
                           I_d_78 = I_d_53;
                        }
                        if ((I_d_78 < I_d_52)) {
                           I_d_78 = I_d_52;
                        }
                     }
                     if ((G_d_76 < (G_d_77 * I_d_78))) {
                        Print("No Enougt Money to Open NextOrder or Volume size is Over Maximum Lot.");
                        ArrayFree(L_s_1);
                        ArrayFree(L_s_1);
                        return ;
                     }
                     G_b_32 = (MarketInfo(I_s_12, MODE_SPREAD) >= maxSpread);
                     if (G_b_32) {
                        G_b_32 = false;
                     } else {
                        G_b_32 = true;
                     }
                     if (G_b_32) {
                        if (I_b_8 == true || Activate_News_Filter == 0) {
                           I_d_67 = I_d_2;
                           if ((I_d_2 < I_d_52)) {
                              I_d_67 = I_d_52;
                           }
                           if ((I_d_67 > I_d_53)) {
                              I_d_67 = I_d_53;
                           }
                           I_d_78 = NormalizeDouble(I_d_67, I_i_114);
                           if ((NormalizeDouble(I_d_67, I_i_114) < I_d_52)) {
                              I_d_78 = I_d_52;
                           }
                           if ((I_d_78 > I_d_53)) {
                              I_d_78 = I_d_53;
                           }
                           if ((I_d_3 < 1.5)) {
                              if (I_i_110 < 20) {
                                 returned_double = MathPow(I_d_3, I_i_110);
                                 I_d_78 = NormalizeDouble((I_d_78 * returned_double), I_i_114);
                              } else {
                                 if (I_i_110 > 20) {
                                    I_d_78 = NormalizeDouble((I_d_47 * I_d_3), I_i_114);
                                 }
                              }
                              if ((I_d_78 > I_d_53)) {
                                 I_d_78 = I_d_53;
                              }
                              if ((I_d_78 < I_d_52)) {
                                 I_d_78 = I_d_52;
                              }
                           }
                           if ((I_d_3 >= 1.5)) {
                              if (I_i_110 > 0) {
                                 I_d_78 = NormalizeDouble((I_d_47 * I_d_3), I_i_114);
                              }
                              if ((I_d_78 > I_d_53)) {
                                 I_d_78 = I_d_53;
                              }
                              if ((I_d_78 < I_d_52)) {
                                 I_d_78 = I_d_52;
                              }
                           }
                           L_i_13 = OrderSend(I_s_12, 1, I_d_78, MarketInfo(I_s_12, MODE_BID), (L_i_3 * I_i_113), I_d_49, 0, I_s_24, I_i_11, 0, 16711935);
                        }
                     }
                  }
               }
            }
            G_d_82 = (I_i_127 + I_d_83);
            I_d_84 = (G_d_82 * I_i_113);
            if (I_b_34) {
               I_i_49 = OrdersTotal() - 1;
               if (I_i_49 >= 0) {
                  do {
                     if (OrderSelect(I_i_49, 0, 0) && OrderSymbol() == I_s_12 && OrderMagicNumber() == I_i_10) {
                        if (OrderType() == OP_BUY && I_i_111 == 1) {
                           if ((I_d_83 > 0)) {
                              if ((I_d_83 * I_i_113 > MarketInfo(I_s_12, MODE_STOPLEVEL))) {
                                 if (((MarketInfo(I_s_12, MODE_BID) - OrderOpenPrice()) >= (L_d_8 * I_d_83 * I_i_113))) {
                                    if ((OrderStopLoss() <= (MarketInfo(I_s_12, MODE_BID) - L_d_8 * I_d_84)) || (OrderStopLoss() == 0)) {
                                       G_d_87 = (L_d_8 * I_d_83);
                                       G_d_87 = (G_d_87 * I_i_113);
                                       L_b_7 = OrderModify(OrderTicket(), OrderOpenPrice(), (MarketInfo(I_s_12, MODE_BID) - G_d_87), OrderTakeProfit(), 0, 65280);
                                       ArrayFree(L_s_1);
                                       ArrayFree(L_s_1);
                                       return ;
                                    }
                                 }
                              }
                           }
                        }
                        if (OrderType() == OP_SELL && I_i_112 == 1 && (I_d_83 > 0)) {
                           G_d_89 = (I_d_83 * I_i_113);
                           if ((G_d_89 > MarketInfo(I_s_12, MODE_STOPLEVEL))) {
                              G_d_89 = OrderOpenPrice();
                              G_d_89 = (G_d_89 - MarketInfo(I_s_12, MODE_ASK));
                              G_d_90 = (L_d_8 * I_d_83);
                              if ((G_d_89 >= (G_d_90 * I_i_113))) {
                                 G_d_90 = OrderStopLoss();
                                 G_d_91 = (L_d_8 * I_d_84);
                                 if ((G_d_90 >= (G_d_91 + MarketInfo(I_s_12, MODE_ASK))) || (OrderStopLoss() == 0)) {
                                    G_d_92 = (L_d_8 * I_d_83);
                                    G_d_92 = (G_d_92 * I_i_113);
                                    L_b_8 = OrderModify(OrderTicket(), OrderOpenPrice(), (G_d_92 + MarketInfo(I_s_12, MODE_ASK)), OrderTakeProfit(), 0, 255);
                                    ArrayFree(L_s_1);
                                    ArrayFree(L_s_1);
                                    return ;
                                 }
                              }
                           }
                        }
                     }
                     I_i_49 = I_i_49 - 1;
                  } while (I_i_49 >= 0);
               }
            }
            if (I_i_109 > 0) {
               G_d_94 = (I_d_40 * L_d_8);
               returned_double = NormalizeDouble((MarketInfo(I_s_12, MODE_BID) - G_d_94), L_i_7);
               I_d_95 = returned_double;
               I_d_96 = NormalizeDouble((((I_d_1 * (double)I_i_113) * L_d_8) + returned_double), L_i_7);
               G_d_94 = (MarketInfo(_Symbol, MODE_SPREAD) * _Point);
               I_d_96 = ((G_d_94 * I_i_113) + I_d_96);
            }
            if (I_i_110 > 0) {
               G_d_94 = (I_d_41 * L_d_8);
               returned_double = NormalizeDouble((G_d_94 + MarketInfo(I_s_12, MODE_ASK)), L_i_7);
               I_d_97 = returned_double;
               G_d_94 = ((I_d_1 * I_i_113) * L_d_8);
               I_d_98 = NormalizeDouble((returned_double - G_d_94), L_i_7);
               G_d_94 = (MarketInfo(_Symbol, MODE_SPREAD) * _Point);
               G_d_94 = (G_d_94 * I_i_113);
               I_d_98 = (I_d_98 - G_d_94);
            }
            if (I_b_40 == true && (I_d_1 > 0)) {
               I_i_49 = OrdersTotal() - 1;
               if (I_i_49 >= 0) {
                  do {
                     if (OrderSelect(I_i_49, 0, 0) && OrderSymbol() == I_s_12) {
                        if (OrderMagicNumber() == I_i_11 || OrderMagicNumber() == I_i_11) {
                           if (OrderType() == OP_SELL && I_i_110 > 1 && (I_d_50 == 0)) {
                              L_b_9 = OrderModify(OrderTicket(), OrderOpenPrice(), OrderStopLoss(), I_d_98, 0, 65535);
                           }
                        }
                     }
                     I_i_49 = I_i_49 - 1;
                  } while (I_i_49 >= 0);
               }
            }
            if (I_b_40 == true && (I_d_1 > 0)) {
               I_i_49 = OrdersTotal() - 1;
               if (I_i_49 >= 0) {
                  do {
                     if (OrderSelect(I_i_49, 0, 0) && OrderSymbol() == I_s_12) {
                        if (OrderMagicNumber() == I_i_9) {
                           if (OrderType() == OP_BUY && I_i_109 > 1 && (I_d_46 == 0)) {
                              L_b_10 = OrderModify(OrderTicket(), OrderOpenPrice(), OrderStopLoss(), I_d_96, 0, 65535);
                           }
                        }
                     }
                     I_i_49 = I_i_49 - 1;
                  } while (I_i_49 >= 0);
               }
            }
            G_d_102 = AccountEquity();
            if ((G_d_102 > AccountBalance())) {
               I_i_132 = 16711680;
            } else {
               I_i_132 = 16711935;
            }
            G_d_102 = MarketInfo(I_s_12, MODE_ASK);
            G_d_102 = (G_d_102 - MarketInfo(I_s_12, MODE_BID));
            I_d_51 = (G_d_102 / L_d_8);
         }
         I_i_103 = I_i_103 + 1;
      } while (I_i_103 < I_i_8);
   }
   ArrayFree(L_s_1);
   ArrayFree(L_s_1);
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnDeinit(const int reason) {
   ObjectsDeleteAll(0, "MTlic_", -1, -1);
   Comment("");
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnTimer() {
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void func_1022() {
   Input_Struct_00000080.m_0 = true;
   Input_Struct_00000080.m_25 = "";
   Input_Struct_00000080.m_69 = 1;
   if (Input_Struct_00000080.m_25 == "") {
      I_s_3 = "fully-licensed version";
   }
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void func_1025() {
   int L_i_47;
   int L_i_39;
   string L_s_7;
   L_i_47 = 2;
   L_i_39 = 2;
   if (I_i_212 == 1) {
      L_i_47 = 3;
      L_i_39 = 4;
   }
   L_s_7 = "MTlic_title";
   if (MQLInfoInteger(2) == 4) {
      if (ObjectFind(L_s_7) < 0) {
         ObjectCreate(0, L_s_7, OBJ_LABEL, ChartWindowFind(), 0, 0, 0, 0, 0, 0);
      }
   } else {
      if (ObjectFind(L_s_7) < 0) {
         ObjectCreate(0, L_s_7, OBJ_LABEL, 0, 0, 0, 0, 0, 0, 0);
      }
   }
   ObjectSetInteger(0, L_s_7, 6, 16119285);
   G_i_4 = I_i_211 + 13;
   ObjectSetInteger(0, L_s_7, 102, G_i_4);
   G_i_4 = I_i_210 + 32;
   ObjectSetInteger(0, L_s_7, 103, G_i_4);
   ObjectSetString(0, L_s_7, 999, I_s_50);
   ObjectSetInteger(0, L_s_7, 100, 11);
   ObjectSetInteger(0, L_s_7, 207, 30);
   ObjectSetInteger(0, L_s_7, 101, L_i_47);
   ObjectSetInteger(0, L_s_7, 1011, L_i_39);
   ObjectSetInteger(0, L_s_7, 1000, 0);
   L_s_7 = "MTlic_line2";
   if (MQLInfoInteger(2) == 4) {
      if (ObjectFind(L_s_7) < 0) {
         ObjectCreate(0, L_s_7, OBJ_LABEL, ChartWindowFind(), 0, 0, 0, 0, 0, 0);
      }
   } else {
      if (ObjectFind(L_s_7) < 0) {
         ObjectCreate(0, L_s_7, OBJ_LABEL, 0, 0, 0, 0, 0, 0, 0);
      }
   }
   ObjectSetInteger(0, L_s_7, 6, 16119285);
   G_i_4 = I_i_211 + 13;
   ObjectSetInteger(0, L_s_7, 102, G_i_4);
   G_i_4 = I_i_210 + 8;
   ObjectSetInteger(0, L_s_7, 103, G_i_4);
   ObjectSetString(0, L_s_7, 999, "calculating remaining days...");
   ObjectSetInteger(0, L_s_7, 100, 7);
   ObjectSetInteger(0, L_s_7, 207, 30);
   ObjectSetInteger(0, L_s_7, 101, L_i_47);
   ObjectSetInteger(0, L_s_7, 1011, L_i_39);
   ObjectSetInteger(0, L_s_7, 1000, 0);
   ObjectSetString(0, L_s_7, 999, I_s_3);
   L_s_7 = "MTlic_line1";
   if (MQLInfoInteger(2) == 4) {
      if (ObjectFind(L_s_7) < 0) {
         ObjectCreate(0, L_s_7, OBJ_LABEL, ChartWindowFind(), 0, 0, 0, 0, 0, 0);
      }
   } else {
      if (ObjectFind(L_s_7) < 0) {
         ObjectCreate(0, L_s_7, OBJ_LABEL, 0, 0, 0, 0, 0, 0, 0);
      }
   }
   ObjectSetInteger(0, L_s_7, 6, 16119285);
   G_i_4 = I_i_211 + 13;
   ObjectSetInteger(0, L_s_7, 102, G_i_4);
   G_i_4 = I_i_210 + 20;
   ObjectSetInteger(0, L_s_7, 103, G_i_4);
   ObjectSetString(0, L_s_7, 999, I_s_51);
   ObjectSetInteger(0, L_s_7, 100, 7);
   ObjectSetInteger(0, L_s_7, 207, 30);
   ObjectSetInteger(0, L_s_7, 101, L_i_47);
   ObjectSetInteger(0, L_s_7, 1011, L_i_39);
   ObjectSetInteger(0, L_s_7, 1000, 0);
   ChartRedraw(0);
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void func_1026() {
   string S_s_509;
   string S_s_510;
   string S_s_511;
   S_s_509 = " EA From @suportefxsinais\nhttps://t.me/suportefxsinais\n Telegram : @suportefxsinais\n******************************\n  Broker: " + AccountCompany();
   S_s_509 = S_s_509 + "\n";
   S_s_509 = S_s_509 + "  Brokers Time: ";
   S_s_509 = S_s_509 + TimeToString(TimeCurrent(), 5);
   S_s_509 = S_s_509 + "\n";
   S_s_509 = S_s_509 + "******************************";
   S_s_509 = S_s_509 + "\n";
   S_s_509 = S_s_509 + "  Name: ";
   S_s_509 = S_s_509 + AccountName();
   S_s_509 = S_s_509 + "\n";
   S_s_509 = S_s_509 + "  Account Currency: ";
   S_s_509 = S_s_509 + AccountCurrency();
   S_s_509 = S_s_509 + "\n";
   S_s_509 = S_s_509 + "******************************";
   S_s_509 = S_s_509 + "\n";
   S_s_509 = S_s_509 + "  Account BALANCE: ";
   S_s_509 = S_s_509 + DoubleToString(AccountBalance(), 2);
   S_s_509 = S_s_509 + "\n";
   S_s_509 = S_s_509 + "  Account EQUITY: ";
   S_s_509 = S_s_509 + DoubleToString(AccountEquity(), 2);
   S_s_509 = S_s_509 + "\n";
   S_s_509 = S_s_509 + "  DD%: ";
   G_d_113 = AccountEquity();
   G_d_113 = ((G_d_113 / AccountBalance()) * 100);
   S_s_510 = (string)NormalizeDouble((100 - G_d_113), 2);
   S_s_509 = S_s_509 + S_s_510;
   S_s_509 = S_s_509 + "%";
   S_s_509 = S_s_509 + "\n";
   S_s_509 = S_s_509 + "\nTotalHedge%: ";
   G_i_4 = 0;
   G_i_4 = 0;
   if (OrdersTotal() > 0) {
      do {
         if (OrderSelect(G_i_4, 0, 0) && OrderMagicNumber() == I_i_10 && OrderSymbol() == _Symbol) {
            G_l_55 = OrderOpenTime();
            break;
         }
         G_i_4 = G_i_4 + 1;
      } while (G_i_4 < OrdersTotal());
   } else G_l_55 = 0;
   G_l_56 = G_l_55;
   G_i_207 = I_i_46;
   G_d_11 = 0;
   G_i_209 = 0;
   G_i_209 = 0;
   if (OrdersTotal() > 0) {
      do {
         if (OrderSelect(G_i_209, 0, 0) && OrderSymbol() == _Symbol && OrderMagicNumber() == G_i_207 && OrderOpenTime() >= G_l_56 && OrderOpenTime() > I_l_16) {
            G_d_109 = OrderProfit();
            G_d_109 = (G_d_109 + OrderCommission());
            G_d_11 = ((G_d_109 + OrderSwap()) + G_d_11);
         }
         G_i_209 = G_i_209 + 1;
      } while (G_i_209 < OrdersTotal());
   }
   G_i_209 = 0;
   if (HistoryTotal() > 0) {
      do {
         if (OrderSelect(G_i_209, 0, 1) && OrderSymbol() == _Symbol && OrderMagicNumber() == G_i_207 && OrderOpenTime() >= G_l_56 && OrderOpenTime() > I_l_16) {
            G_d_109 = OrderProfit();
            G_d_109 = (G_d_109 + OrderCommission());
            G_d_11 = ((G_d_109 + OrderSwap()) + G_d_11);
         }
         G_i_209 = G_i_209 + 1;
      } while (G_i_209 < HistoryTotal());
   }
   S_s_510 = (string)G_d_11;
   S_s_509 = S_s_509 + S_s_510;
   S_s_509 = S_s_509 + " | ";
   G_i_208 = 0;
   G_i_208 = 0;
   if (OrdersTotal() > 0) {
      do {
         if (OrderSelect(G_i_208, 0, 0) && OrderMagicNumber() == I_i_10 && OrderSymbol() == _Symbol) {
            G_l_3 = OrderOpenTime();
            break;
         }
         G_i_208 = G_i_208 + 1;
      } while (G_i_208 < OrdersTotal());
   } else G_l_3 = 0;
   S_s_510 = (string)G_l_3;
   S_s_509 = S_s_509 + S_s_510;
   S_s_509 = S_s_509 + "\nTotalHedge Garantido: ";
   S_s_510 = (string)NormalizeDouble(func_1040(), 2);
   S_s_509 = S_s_509 + S_s_510;
   S_s_509 = S_s_509 + " | ";
   S_s_509 = S_s_509 + TimeToString(I_l_12, 3);
   I_i_49 = OrdersTotal() - 1;
   if (I_i_49 >= 0) {
      do {
         if (OrderSelect(I_i_49, 0, 0)) {
            G_d_114 = OrderProfit();
            S_s_511 = S_s_510 + StringConcatenate("\n", OrderTicket(), "|", OrderProfit(), " | ", OrderLots(), " | ", NormalizeDouble((G_d_114 / (OrderLots() * 100)), 2));
            S_s_510 = S_s_511;
         }
         I_i_49 = I_i_49 - 1;
      } while (I_i_49 >= 0);
   }
   S_s_509 = S_s_509 + S_s_510;
   Comment(S_s_509);
   if (IsTesting()) return;
   ObjectCreate(0, "EA_NAME", OBJ_LABEL, 0, 0, 0, 0, 0, 0, 0);
   ObjectSet("EA_NAME", OBJPROP_CORNER, 2);
   ObjectSet("EA_NAME", OBJPROP_XDISTANCE, 400);
   ObjectSet("EA_NAME", OBJPROP_YDISTANCE, 1);
   ObjectSet("EA_NAME", OBJPROP_BACK, 1);
   ObjectSetText("EA_NAME", I_s_59, (I_i_217 + 3), "Impact", I_i_132);
   ObjectSet("EA_NAME", OBJPROP_CORNER, 3);
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void func_1036() {
   string S_s_509;
   string S_s_510;
   string S_s_511;
   string S_s_512;
   string S_s_513;
   string L_s_12;
   int L_i_43;
   int L_i_41;
   int L_i_42;
   S_s_509 = NULL;
   char L_c_12[];
   char L_c_13[];
   S_s_511 = "";
   S_s_512 = "http://ec.forexprostools.com/?columns=exc_currency,exc_importance&importance=1,2,3&calType=week&timeZone=15&lang=1";
   if (WebRequest("GET", S_s_512, S_s_509, NULL, 5000, L_c_12, 0, L_c_13, S_s_510) == -1) {
      Print("WebRequest error, err.code  =", GetLastError());
      S_s_513 = "You must add the address ' http://ec.forexprostools.com/?columns=exc_currency,exc_importance&importance=1,2,3&calType=week&timeZone=15&lang=1";
      S_s_513 = "You must add the address ' http://ec.forexprostools.com/?columns=exc_currency,exc_importance&importance=1,2,3&calType=week&timeZone=15&lang=1' in the list of allowed URL tab 'Advisors' ";
      MessageBox(S_s_513, " Error ", 64);
   } else {
      G_i_4 = FileOpen("news-log.html", 6);
      if (G_i_4 != -1) {
         FileWriteArray(G_i_4, L_c_13, 0, ArraySize(L_c_13));
         FileClose(G_i_4);
         G_i_12 = FileOpen("news-log.html", 5);
         S_s_511 = FileReadString(G_i_12, ArraySize(L_c_13));
         FileClose(G_i_12);
      } else {
         Print("Error in FileOpen. Error code =", GetLastError());
      }
   }
   ArrayFree(L_c_13);
   ArrayFree(L_c_12);
   L_s_12 = S_s_511;
   L_i_43 = StringFind(L_s_12, "pageStartAt>", 0) + 12;
   L_i_41 = StringFind(L_s_12, "</tbody>", 0);
   L_s_12 = StringSubstr(L_s_12, L_i_43, (L_i_41 - L_i_43));
   L_i_43 = 0;
   if (_StopFlag != 0) return;
   do {
      L_i_43 = StringFind(L_s_12, "event_timestamp", L_i_43) + 17;
      L_i_41 = StringFind(L_s_12, "onclick", L_i_43) - 2;
      if (L_i_43 < 17) return;
      if (L_i_41 < 0) return;
      I_s_381[0, I_i_156] = StringSubstr(L_s_12, L_i_43, (L_i_41 - L_i_43));
      L_i_43 = StringFind(L_s_12, "flagCur", L_i_43) + 10;
      L_i_41 = L_i_43 + 3;
      if (L_i_43 < 10) return;
      if (L_i_41 < 3) return;
      I_s_381[1, I_i_156] = StringSubstr(L_s_12, L_i_43, (L_i_41 - L_i_43));
      if (StringFind(I_s_2, I_s_381[1, I_i_156], 0) >= 0) {
         L_i_43 = StringFind(L_s_12, "title", L_i_43) + 7;
         L_i_41 = StringFind(L_s_12, "Volatility", L_i_43) - 1;
         if (L_i_43 < 7) return;
         if (L_i_41 < 0) return;
         I_s_381[2, I_i_156] = StringSubstr(L_s_12, L_i_43, (L_i_41 - L_i_43));
         if (StringFind(I_s_381[2, I_i_156], "High", 0) < 0 || I_b_2) {
            if (StringFind(I_s_381[2, I_i_156], "Moderate", 0) < 0 || I_b_3) {
               if (StringFind(I_s_381[2, I_i_156], "Low", 0) < 0 || I_b_4) {
                  L_i_43 = StringFind(L_s_12, "left event", L_i_43) + 12;
                  L_i_42 = StringFind(L_s_12, "Speaks", L_i_43);
                  L_i_41 = StringFind(L_s_12, "<", L_i_43);
                  if (L_i_43 < 12) return;
                  if (L_i_41 < 0) return;
                  if (L_i_42 < 0 || L_i_42 > L_i_41) {
                     I_s_381[3, I_i_156] = StringSubstr(L_s_12, L_i_43, (L_i_41 - L_i_43));
                  } else {
                     I_s_381[3, I_i_156] = StringSubstr(L_s_12, L_i_43, (L_i_42 - L_i_43));
                  }
                  I_i_156 = I_i_156 + 1;
                  if (I_i_156 == 300) return;
               }
            }
         }
      }
   } while (_StopFlag == 0);
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double func_1040() {
   double L_d_13;
   int L_i_43;
   long L_l_0;
   double L_d_10;
   L_d_13 = 0;
   L_i_43 = 0;
   L_l_0 = 0;
   L_i_43 = 0;
   if (OrdersTotal() > 0) {
      do {
         if (OrderSelect(L_i_43, 0, 0) && OrderSymbol() == _Symbol && OrderMagicNumber() == I_i_46) {
            if (OrderType() == OP_BUY) {
               G_d_113 = OrderStopLoss();
               if ((G_d_113 < OrderOpenPrice())) {
                  G_d_113 = OrderProfit();
                  G_d_113 = (G_d_113 + OrderCommission());
                  L_d_13 = (G_d_113 + OrderSwap());
               } else {
                  G_d_113 = OrderStopLoss();
                  G_d_113 = (G_d_113 - OrderOpenPrice());
                  G_d_113 = ((G_d_113 / _Point) * I_d_35);
                  G_d_113 = (G_d_113 * OrderLots());
                  G_d_6 = -OrderCommission();
                  G_d_6 = (G_d_6 - OrderSwap());
                  G_d_6 = (G_d_113 - G_d_6);
                  G_d_7 = ((Ask - Bid) * I_d_35);
                  G_d_7 = (G_d_7 * OrderLots());
                  L_d_13 = (G_d_6 - G_d_7);
               }
            } else {
               G_d_7 = OrderStopLoss();
               if ((G_d_7 > OrderOpenPrice())) {
                  G_d_7 = OrderProfit();
                  G_d_7 = (G_d_7 + OrderCommission());
                  L_d_13 = (G_d_7 + OrderSwap());
               } else {
                  G_d_7 = OrderOpenPrice();
                  G_d_7 = (G_d_7 - OrderStopLoss());
                  G_d_7 = ((G_d_7 / _Point) * I_d_35);
                  G_d_7 = (G_d_7 * OrderLots());
                  G_d_10 = -OrderCommission();
                  G_d_10 = (G_d_10 - OrderSwap());
                  G_d_10 = (G_d_7 - G_d_10);
                  G_d_11 = ((Ask - Bid) * I_d_35);
                  G_d_11 = (G_d_11 * OrderLots());
                  L_d_13 = (G_d_10 - G_d_11);
               }
            }
            L_l_0 = OrderOpenTime();
         }
         L_i_43 = L_i_43 + 1;
      } while (L_i_43 < OrdersTotal());
   }
   if (_Symbol == "XAUUSD") {
      L_d_13 = (L_d_13 / 10);
   }
   L_i_43 = 0;
   if (HistoryTotal() <= 0) return L_d_13;
   do {
      if (OrderSelect(L_i_43, 0, 1) && OrderSymbol() == _Symbol) {
         if ((OrderMagicNumber() == I_i_46 && OrderCloseTime() > I_l_12)
               || (OrderMagicNumber() == I_i_10 && OrderCloseTime() > I_l_12)) {
            G_d_11 = (L_d_13 + OrderProfit());
            G_d_11 = (G_d_11 + OrderCommission());
            L_d_13 = (G_d_11 + OrderSwap());
         }
      }
      L_i_43 = L_i_43 + 1;
   } while (L_i_43 < HistoryTotal());
   L_d_10 = L_d_13;
   return L_d_13;
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void func_1042() {
   string S_s_509;
   string L_s_12;
   string L_s_13;
   string L_s_14;
   double L_d_12;
   int L_i_45;
   G_i_4 = I_i_10;
   G_i_12 = 1;
   G_i_206 = 0;
   G_i_207 = OrdersTotal() - 1;
   G_i_206 = G_i_207;
   if (G_i_207 >= 0) {
      do {
         if (OrderSelect(G_i_206, 0, 0) && OrderMagicNumber() == G_i_4 && OrderSymbol() == _Symbol && OrderType() == G_i_12) {
            G_d_10 = OrderTakeProfit();
            break;
         }
         G_i_206 = G_i_206 - 1;
      } while (G_i_206 >= 0);
   } else G_d_10 = 0;
   L_d_12 = G_d_10;
   G_d_11 = G_d_10;
   G_i_209 = OrdersTotal();
   G_i_208 = 0;
   G_d_11 = NormalizeDouble(G_d_10, 5);
   G_i_16 = 0;
   if (G_i_209 > 0) {
      do {
         if (OrderSelect(G_i_16, 0, 0)) {
            G_i_208 = OrderType();
            if (OrderSymbol() == _Symbol && OrderMagicNumber() == I_i_10) {
               if (G_i_208 == 0) {
                  bool modify_check = OrderModify(OrderTicket(), OrderOpenPrice(), 0, G_d_11, 0, 4294967295);
               } else {
                  if (G_i_208 == 1) {
                     bool modify_check = OrderModify(OrderTicket(), OrderOpenPrice(), 0, G_d_11, 0, 4294967295);
                  }
               }
            }
         }
         G_i_16 = G_i_16 + 1;
      } while (G_i_16 < G_i_209);
   }
   G_i_219 = I_i_10;
   G_i_19 = 1;
   G_i_20 = 0;
   G_i_21 = OrdersTotal() - 1;
   G_i_20 = G_i_21;
   if (G_i_21 >= 0) {
      do {
         if (OrderSelect(G_i_20, 0, 0) && OrderMagicNumber() == G_i_219 && OrderSymbol() == _Symbol && OrderType() == G_i_19) {
            G_d_117 = OrderTakeProfit();
            break;
         }
         G_i_20 = G_i_20 - 1;
      } while (G_i_20 >= 0);
   } else G_d_117 = 0;
   G_d_111 = (Ask - Bid);
   L_d_12 = (G_d_117 - G_d_111);
   S_s_509 = _Symbol;
   G_d_118 = 0;
   G_d_119 = MarketInfo(S_s_509, MODE_DIGITS);
   if ((G_d_119 == 3) && StringFind(S_s_509, "XAU", 0) == -1 && StringFind(S_s_509, "GOLD", 0) == -1) {
      G_d_118 = 0.01;
   } else {
      if ((G_d_119 == 4) || (G_d_119 == 5)) {
         G_d_118 = 0.0001;
      } else {
         if ((G_d_119 == 2) || (G_d_119 == 3)) {
            G_d_118 = 0.1;
         } else {
            if ((G_d_119 == 1)) {
               G_d_118 = 1;
            } else {
               G_d_118 = 1;
            }
         }
      }
   }
   G_i_222 = I_i_11;
   G_i_27 = 1;
   G_i_28 = 0;
   G_d_123 = 0;
   G_i_28 = 0;
   if (OrdersTotal() > 0) {
      do {
         if (OrderSelect(G_i_28, 0, 0) && OrderMagicNumber() == G_i_222 && OrderSymbol() == _Symbol && OrderType() == G_i_27) {
            G_d_123 = (G_d_123 + OrderLots());
         }
         G_i_28 = G_i_28 + 1;
      } while (G_i_28 < OrdersTotal());
   }
   L_i_45 = OrderSend(_Symbol, 0, NormalizeDouble(((DDPercent / 100) * G_d_123), 2), Ask, I_i_216, L_d_12, ((TakeHedge * G_d_118) + Ask), "Hedge", I_i_46, 0, 32768);
   if (L_i_45 > 0) return;
   G_i_30 = GetLastError();
   L_s_12 = (string)G_i_30;
   L_s_14 = StringConcatenate("Open Buy Hedge - Error ", L_s_12, ": ");
   Print(L_s_14);
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void func_1043() {
   string S_s_509;
   string L_s_12;
   string L_s_13;
   string L_s_14;
   double L_d_12;
   int L_i_45;
   G_i_4 = I_i_10;
   G_i_12 = 0;
   G_i_206 = 0;
   G_i_207 = OrdersTotal() - 1;
   G_i_206 = G_i_207;
   if (G_i_207 >= 0) {
      do {
         if (OrderSelect(G_i_206, 0, 0) && OrderMagicNumber() == G_i_4 && OrderSymbol() == _Symbol && OrderType() == G_i_12) {
            G_d_10 = OrderTakeProfit();
            break;
         }
         G_i_206 = G_i_206 - 1;
      } while (G_i_206 >= 0);
   } else G_d_10 = 0;
   L_d_12 = G_d_10;
   G_d_11 = G_d_10;
   G_i_209 = OrdersTotal();
   G_i_208 = 0;
   G_d_11 = NormalizeDouble(G_d_10, 5);
   G_i_16 = 0;
   if (G_i_209 > 0) {
      do {
         if (OrderSelect(G_i_16, 0, 0)) {
            G_i_208 = OrderType();
            if (OrderSymbol() == _Symbol && OrderMagicNumber() == I_i_10) {
               if (G_i_208 == 0) {
                  bool modify_check = OrderModify(OrderTicket(), OrderOpenPrice(), 0, G_d_11, 0, 4294967295);
               } else {
                  if (G_i_208 == 1) {
                     bool modify_check = OrderModify(OrderTicket(), OrderOpenPrice(), 0, G_d_11, 0, 4294967295);
                  }
               }
            }
         }
         G_i_16 = G_i_16 + 1;
      } while (G_i_16 < G_i_209);
   }
   G_i_219 = I_i_10;
   G_i_19 = 0;
   G_i_20 = 0;
   G_i_21 = OrdersTotal() - 1;
   G_i_20 = G_i_21;
   if (G_i_21 >= 0) {
      do {
         if (OrderSelect(G_i_20, 0, 0) && OrderMagicNumber() == G_i_219 && OrderSymbol() == _Symbol && OrderType() == G_i_19) {
            G_d_117 = OrderTakeProfit();
            break;
         }
         G_i_20 = G_i_20 - 1;
      } while (G_i_20 >= 0);
   } else G_d_117 = 0;
   L_d_12 = ((Ask - Bid) + G_d_117);
   S_s_509 = _Symbol;
   G_d_118 = 0;
   G_d_119 = MarketInfo(S_s_509, MODE_DIGITS);
   if ((G_d_119 == 3) && StringFind(S_s_509, "XAU", 0) == -1 && StringFind(S_s_509, "GOLD", 0) == -1) {
      G_d_118 = 0.01;
   } else {
      if ((G_d_119 == 4) || (G_d_119 == 5)) {
         G_d_118 = 0.0001;
      } else {
         if ((G_d_119 == 2) || (G_d_119 == 3)) {
            G_d_118 = 0.1;
         } else {
            if ((G_d_119 == 1)) {
               G_d_118 = 1;
            } else {
               G_d_118 = 1;
            }
         }
      }
   }
   G_d_120 = (TakeHedge * G_d_118);
   G_i_222 = I_i_9;
   G_i_27 = 0;
   G_i_28 = 0;
   G_d_123 = 0;
   G_i_28 = 0;
   if (OrdersTotal() > 0) {
      do {
         if (OrderSelect(G_i_28, 0, 0) && OrderMagicNumber() == G_i_222 && OrderSymbol() == _Symbol && OrderType() == G_i_27) {
            G_d_123 = (G_d_123 + OrderLots());
         }
         G_i_28 = G_i_28 + 1;
      } while (G_i_28 < OrdersTotal());
   }
   L_i_45 = OrderSend(_Symbol, 1, NormalizeDouble(((DDPercent / 100) * G_d_123), 2), Bid, I_i_216, ((Ask - Bid) + L_d_12), (Bid - G_d_120), "Hedge", I_i_46, 0, 255);
   if (L_i_45 > 0) return;
   G_i_30 = GetLastError();
   L_s_12 = (string)G_i_30;
   L_s_14 = StringConcatenate("Open Sell Stop Order - Error ", L_s_12);
   Print(L_s_14);
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int func_1052(int Fa_i_00) {
   double L_d_13;
   double L_d_14;
   int L_i_47;
   L_d_13 = 0;
   G_i_4 = 0;
   G_i_4 = 0;
   if (OrdersTotal() > 0) {
      do {
         if (OrderSelect(G_i_4, 0, 0) && OrderMagicNumber() == I_i_10 && OrderSymbol() == _Symbol) {
            G_l_55 = OrderOpenTime();
            break;
         }
         G_i_4 = G_i_4 + 1;
      } while (G_i_4 < OrdersTotal());
   } else G_l_55 = 0;
   G_l_56 = G_l_55;
   G_i_207 = I_i_46;
   G_d_11 = 0;
   G_i_209 = 0;
   G_i_209 = 0;
   if (OrdersTotal() > 0) {
      do {
         if (OrderSelect(G_i_209, 0, 0) && OrderSymbol() == _Symbol && OrderMagicNumber() == G_i_207 && OrderOpenTime() >= G_l_56 && OrderOpenTime() > I_l_16) {
            G_d_109 = OrderProfit();
            G_d_109 = (G_d_109 + OrderCommission());
            G_d_11 = ((G_d_109 + OrderSwap()) + G_d_11);
         }
         G_i_209 = G_i_209 + 1;
      } while (G_i_209 < OrdersTotal());
   }
   G_i_209 = 0;
   if (HistoryTotal() > 0) {
      do {
         if (OrderSelect(G_i_209, 0, 1) && OrderSymbol() == _Symbol && OrderMagicNumber() == G_i_207 && OrderOpenTime() >= G_l_56 && OrderOpenTime() > I_l_16) {
            G_d_109 = OrderProfit();
            G_d_109 = (G_d_109 + OrderCommission());
            G_d_11 = ((G_d_109 + OrderSwap()) + G_d_11);
         }
         G_i_209 = G_i_209 + 1;
      } while (G_i_209 < HistoryTotal());
   }
   L_d_14 = G_d_11;
   if (OrderSelect(Fa_i_00, 1, 0) != true) return 0;
   RefreshRates();
   L_d_13 = iClose(_Symbol, _Period, 0);
   if (OrderType() == OP_BUY) {
      if (((OrderStopLoss() + I_d_9) >= L_d_13)) return 0;
      if (((OrderOpenPrice() + I_d_9) >= L_d_13)) return 0;
      if ((I_d_9 <= 0)) return 0;
      if ((I_d_12 <= 0)) return 0;
      G_d_109 = (I_d_12 * 2);
      if (((G_d_109 + OrderOpenPrice()) > L_d_13)) return 0;
      if (((OrderStopLoss() + G_d_109) > L_d_13)) return 0;
      Print("TS Hedge", " Modificar ordem: ", OrderTicket(), " | ", I_d_9);
      G_d_125 = OrderOpenPrice();
      if ((G_d_125 > OrderStopLoss())) {
         if (OrderModify(OrderTicket(), OrderOpenPrice(), (OrderOpenPrice() + I_d_12), OrderTakeProfit(), 0, 4294967295)) return 0;
         Print("TS Hedge", " Erro ao modificar ordem ", OrderTicket());
         return 0;
      }
      if (OrderModify(OrderTicket(), OrderOpenPrice(), (OrderStopLoss() + I_d_12), OrderTakeProfit(), 0, 4294967295)) return 0;
      Print("TS Hedge", " Erro ao modificar ordem ", OrderTicket());
      return 0;
   }
   if (OrderType() != OP_SELL) return 0;
   if (((OrderStopLoss() - I_d_9) <= L_d_13)) return 0;
   if (((OrderOpenPrice() - I_d_9) <= L_d_13)) return 0;
   if ((I_d_9 <= 0)) return 0;
   if ((I_d_12 <= 0)) return 0;
   G_d_117 = (I_d_12 * 2);
   if (((OrderOpenPrice() - G_d_117) < L_d_13)) return 0;
   if (((OrderStopLoss() - G_d_117) < L_d_13)) return 0;
   G_d_111 = OrderOpenPrice();
   if ((G_d_111 < OrderStopLoss())) {
      if (OrderModify(OrderTicket(), OrderOpenPrice(), (OrderOpenPrice() - I_d_12), OrderTakeProfit(), 0, 4294967295)) return 0;
      Print("TS Hedge", " Erro ao modificar ordem", OrderTicket());
      return 0;
   }
   if (OrderModify(OrderTicket(), OrderOpenPrice(), (OrderStopLoss() - I_d_12), OrderTakeProfit(), 0, 4294967295)) return 0;
   Print("TS Hedge", " Erro ao modificar ordem", OrderTicket());
   L_i_47 = 0;
   return 0;
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void func_1057() {
   string S_s_509;
   string S_s_510;
   string S_s_511;
   string S_s_512;
   string S_s_513;
   int L_i_47;
   long L_l_1;
   I_s_379[0] = "2020.01.02 04:55|EUR";
   I_s_379[1] = "2020.01.02 09:30|USD";
   I_s_379[2] = "2020.01.03 04:55|EUR";
   I_s_379[3] = "2020.01.03 11:00|USD";
   I_s_379[4] = "2020.01.03 12:00|USD";
   I_s_379[5] = "2020.01.03 16:00|USD";
   I_s_379[6] = "2020.01.07 06:00|EUR";
   I_s_379[7] = "2020.01.07 11:00|USD";
   I_s_379[8] = "2020.01.08 09:15|USD";
   I_s_379[9] = "2020.01.08 11:30|USD";
   I_s_379[10] = "2020.01.09 09:30|USD";
   I_s_379[11] = "2020.01.10 09:30|USD";
   I_s_379[12] = "2020.01.10 09:30|USD";
   I_s_379[13] = "2020.01.14 08:00|USD";
   I_s_379[14] = "2020.01.14 09:30|USD";
   I_s_379[15] = "2020.01.15 09:30|USD";
   I_s_379[16] = "2020.01.15 11:30|USD";
   I_s_379[17] = "2020.01.16 08:30|EUR";
   I_s_379[18] = "2020.01.16 09:30|USD";
   I_s_379[19] = "2020.01.16 09:30|USD";
   I_s_379[20] = "2020.01.16 09:30|USD";
   I_s_379[21] = "2020.01.16 09:30|USD";
   I_s_379[22] = "2020.01.16 14:00|EUR";
   I_s_379[23] = "2020.01.17 06:00|EUR";
   I_s_379[24] = "2020.01.17 09:30|USD";
   I_s_379[25] = "2020.01.17 11:00|USD";
   I_s_379[26] = "2020.01.20 14:30|EUR";
   I_s_379[27] = "2020.01.21 06:00|EUR";
   I_s_379[28] = "2020.01.21 06:30|USD";
   I_s_379[29] = "2020.01.22 11:00|USD";
   I_s_379[30] = "2020.01.23 08:45|EUR";
   I_s_379[31] = "2020.01.23 08:45|EUR";
   I_s_379[32] = "2020.01.23 08:45|EUR";
   I_s_379[33] = "2020.01.23 08:45|EUR";
   I_s_379[34] = "2020.01.23 09:30|USD";
   I_s_379[35] = "2020.01.23 09:30|EUR";
   I_s_379[36] = "2020.01.23 12:00|USD";
   I_s_379[37] = "2020.01.24 04:30|EUR";
   I_s_379[38] = "2020.01.24 06:30|EUR";
   I_s_379[39] = "2020.01.25 05:00|EUR";
   I_s_379[40] = "2020.01.25 11:00|USD";
   I_s_379[41] = "2020.01.28 09:30|USD";
   I_s_379[42] = "2020.01.28 11:00|USD";
   I_s_379[43] = "2020.01.29 11:00|USD";
   I_s_379[44] = "2020.01.29 11:30|USD";
   I_s_379[45] = "2020.01.29 15:00|USD";
   I_s_379[46] = "2020.01.29 15:00|USD";
   I_s_379[47] = "2020.01.29 15:30|USD";
   I_s_379[48] = "2020.01.30 04:55|EUR";
   I_s_379[49] = "2020.01.30 09:30|USD";
   I_s_379[50] = "2020.01.30 09:30|USD";
   I_s_379[51] = "2020.01.31 06:00|EUR";
   I_s_379[52] = "2020.02.03 04:55|EUR";
   I_s_379[53] = "2020.02.03 11:00|USD";
   I_s_379[54] = "2020.02.03 14:00|EUR";
   I_s_379[55] = "2020.02.05 08:15|EUR";
   I_s_379[56] = "2020.02.05 09:15|USD";
   I_s_379[57] = "2020.02.05 11:00|USD";
   I_s_379[58] = "2020.02.05 11:30|USD";
   I_s_379[59] = "2020.02.06 04:00|EUR";
   I_s_379[60] = "2020.02.06 09:30|USD";
   I_s_379[61] = "2020.02.07 09:30|USD";
   I_s_379[62] = "2020.02.07 09:30|USD";
   I_s_379[63] = "2020.02.11 08:00|USD";
   I_s_379[64] = "2020.02.11 10:00|EUR";
   I_s_379[65] = "2020.02.11 11:00|USD";
   I_s_379[66] = "2020.02.11 11:00|USD";
   I_s_379[67] = "2020.02.12 11:00|USD";
   I_s_379[68] = "2020.02.12 11:30|USD";
   I_s_379[69] = "2020.02.13 09:30|USD";
   I_s_379[70] = "2020.02.13 09:30|USD";
   I_s_379[71] = "2020.02.14 03:00|EUR";
   I_s_379[72] = "2020.02.14 09:30|USD";
   I_s_379[73] = "2020.02.14 09:30|USD";
   I_s_379[74] = "2020.02.18 06:00|EUR";
   I_s_379[75] = "2020.02.19 09:30|USD";
   I_s_379[76] = "2020.02.19 09:30|USD";
   I_s_379[77] = "2020.02.19 15:00|USD";
   I_s_379[78] = "2020.02.20 08:30|EUR";
   I_s_379[79] = "2020.02.20 09:30|USD";
   I_s_379[80] = "2020.02.20 09:30|USD";
   I_s_379[81] = "2020.02.20 12:00|USD";
   I_s_379[82] = "2020.02.21 04:30|EUR";
   I_s_379[83] = "2020.02.21 06:00|EUR";
   I_s_379[84] = "2020.02.21 11:00|USD";
   I_s_379[85] = "2020.02.24 05:00|EUR";
   I_s_379[86] = "2020.02.25 03:00|EUR";
   I_s_379[87] = "2020.02.25 11:00|USD";
   I_s_379[88] = "2020.02.26 09:30|EUR";
   I_s_379[89] = "2020.02.26 11:00|USD";
   I_s_379[90] = "2020.02.26 11:30|USD";
   I_s_379[91] = "2020.02.26 19:00|USD";
   I_s_379[92] = "2020.02.27 05:45|EUR";
   I_s_379[93] = "2020.02.27 09:30|USD";
   I_s_379[94] = "2020.02.27 09:30|USD";
   I_s_379[95] = "2020.02.27 09:30|USD";
   I_s_379[96] = "2020.02.27 11:00|USD";
   I_s_379[97] = "2020.02.28 04:55|EUR";
   I_s_379[98] = "2020.03.02 04:55|EUR";
   I_s_379[99] = "2020.03.02 11:00|USD";
   I_s_379[100] = "2020.03.03 06:00|EUR";
   I_s_379[101] = "2020.03.03 11:00|USD";
   I_s_379[102] = "2020.03.04 09:15|USD";
   I_s_379[103] = "2020.03.04 11:00|USD";
   I_s_379[104] = "2020.03.04 11:30|USD";
   I_s_379[105] = "2020.03.05 09:30|USD";
   I_s_379[106] = "2020.03.06 09:30|USD";
   I_s_379[107] = "2020.03.06 09:30|USD";
   I_s_379[108] = "2020.03.10 17:30|USD";
   I_s_379[109] = "2020.03.11 08:00|USD";
   I_s_379[110] = "2020.03.11 08:30|USD";
   I_s_379[111] = "2020.03.11 10:30|USD";
   I_s_379[112] = "2020.03.12 08:30|USD";
   I_s_379[113] = "2020.03.12 08:30|USD";
   I_s_379[114] = "2020.03.12 08:45|EUR";
   I_s_379[115] = "2020.03.12 08:45|EUR";
   I_s_379[116] = "2020.03.12 08:45|EUR";
   I_s_379[117] = "2020.03.12 08:45|EUR";
   I_s_379[118] = "2020.03.12 09:30|EUR";
   I_s_379[119] = "2020.03.13 15:00|USD";
   I_s_379[120] = "2020.03.15 17:00|USD";
   I_s_379[121] = "2020.03.15 17:00|USD";
   I_s_379[122] = "2020.03.15 17:20|USD";
   I_s_379[123] = "2020.03.15 18:30|USD";
   I_s_379[124] = "2020.03.17 06:00|EUR";
   I_s_379[125] = "2020.03.17 08:30|USD";
   I_s_379[126] = "2020.03.17 08:30|USD";
   I_s_379[127] = "2020.03.17 10:00|USD";
   I_s_379[128] = "2020.03.18 06:00|EUR";
   I_s_379[129] = "2020.03.18 08:30|USD";
   I_s_379[130] = "2020.03.18 10:30|USD";
   I_s_379[131] = "2020.03.19 05:00|EUR";
   I_s_379[132] = "2020.03.19 08:30|USD";
   I_s_379[133] = "2020.03.19 08:30|USD";
   I_s_379[134] = "2020.03.20 10:00|USD";
   I_s_379[135] = "2020.03.24 04:30|EUR";
   I_s_379[136] = "2020.03.24 10:00|USD";
   I_s_379[137] = "2020.03.24 12:05|USD";
   I_s_379[138] = "2020.03.25 05:00|EUR";
   I_s_379[139] = "2020.03.25 08:30|USD";
   I_s_379[140] = "2020.03.25 10:30|USD";
   I_s_379[141] = "2020.03.26 07:00|USD";
   I_s_379[142] = "2020.03.26 08:30|USD";
   I_s_379[143] = "2020.03.26 08:30|USD";
   I_s_379[144] = "2020.03.30 10:00|USD";
   I_s_379[145] = "2020.03.31 03:55|EUR";
   I_s_379[146] = "2020.03.31 05:00|EUR";
   I_s_379[147] = "2020.03.31 10:00|USD";
   I_s_379[148] = "2020.04.01 03:55|EUR";
   I_s_379[149] = "2020.04.01 08:15|USD";
   I_s_379[150] = "2020.04.01 10:00|USD";
   I_s_379[151] = "2020.04.01 10:30|USD";
   I_s_379[152] = "2020.04.02 08:30|USD";
   I_s_379[153] = "2020.04.03 08:30|USD";
   I_s_379[154] = "2020.04.03 08:30|USD";
   I_s_379[155] = "2020.04.03 10:00|USD";
   I_s_379[156] = "2020.04.07 08:00|USD";
   I_s_379[157] = "2020.04.07 10:00|USD";
   I_s_379[158] = "2020.04.08 10:30|USD";
   I_s_379[159] = "2020.04.08 14:00|USD";
   I_s_379[160] = "2020.04.09 07:30|EUR";
   I_s_379[161] = "2020.04.09 08:30|USD";
   I_s_379[162] = "2020.04.09 08:30|USD";
   I_s_379[163] = "2020.04.09 10:00|USD";
   I_s_379[164] = "2020.04.10 08:30|USD";
   I_s_379[165] = "2020.04.15 08:30|USD";
   I_s_379[166] = "2020.04.15 08:30|USD";
   I_s_379[167] = "2020.04.15 10:30|USD";
   I_s_379[168] = "2020.04.16 08:30|USD";
   I_s_379[169] = "2020.04.16 08:30|USD";
   I_s_379[170] = "2020.04.16 08:30|USD";
   I_s_379[171] = "2020.04.17 05:00|EUR";
   I_s_379[172] = "2020.04.21 05:00|EUR";
   I_s_379[173] = "2020.04.21 10:00|USD";
   I_s_379[174] = "2020.04.22 10:30|USD";
   I_s_379[175] = "2020.04.23 03:30|EUR";
   I_s_379[176] = "2020.04.23 08:30|USD";
   I_s_379[177] = "2020.04.23 10:00|USD";
   I_s_379[178] = "2020.04.24 04:00|EUR";
   I_s_379[179] = "2020.04.24 08:30|USD";
   I_s_379[180] = "2020.04.28 10:00|USD";
   I_s_379[181] = "2020.04.29 08:30|USD";
   I_s_379[182] = "2020.04.29 10:00|USD";
   I_s_379[183] = "2020.04.29 10:30|USD";
   I_s_379[184] = "2020.04.29 14:00|USD";
   I_s_379[185] = "2020.04.29 14:00|USD";
   I_s_379[186] = "2020.04.29 14:30|USD";
   I_s_379[187] = "2020.04.30 03:55|EUR";
   I_s_379[188] = "2020.04.30 05:00|EUR";
   I_s_379[189] = "2020.04.30 07:45|EUR";
   I_s_379[190] = "2020.04.30 07:45|EUR";
   I_s_379[191] = "2020.04.30 07:45|EUR";
   I_s_379[192] = "2020.04.30 07:45|EUR";
   I_s_379[193] = "2020.04.30 08:30|USD";
   I_s_379[194] = "2020.04.30 08:30|EUR";
   I_s_379[195] = "2020.05.01 10:00|USD";
   I_s_379[196] = "2020.05.04 03:55|EUR";
   I_s_379[197] = "2020.05.05 10:00|USD";
   I_s_379[198] = "2020.05.06 08:15|USD";
   I_s_379[199] = "2020.05.06 10:30|USD";
   I_s_379[200] = "2020.05.07 08:30|USD";
   I_s_379[201] = "2020.05.07 10:00|EUR";
   I_s_379[202] = "2020.05.08 07:00|EUR";
   I_s_379[203] = "2020.05.08 08:30|USD";
   I_s_379[204] = "2020.05.08 08:30|USD";
   I_s_379[205] = "2020.05.12 08:00|USD";
   I_s_379[206] = "2020.05.12 08:30|USD";
   I_s_379[207] = "2020.05.13 08:30|USD";
   I_s_379[208] = "2020.05.13 09:00|USD";
   I_s_379[209] = "2020.05.13 10:30|USD";
   I_s_379[210] = "2020.05.14 08:30|USD";
   I_s_379[211] = "2020.05.15 04:00|EUR";
   I_s_379[212] = "2020.05.15 08:30|USD";
   I_s_379[213] = "2020.05.15 08:30|USD";
   I_s_379[214] = "2020.05.15 10:00|USD";
   I_s_379[215] = "2020.05.17 19:00|USD";
   I_s_379[216] = "2020.05.19 05:00|EUR";
   I_s_379[217] = "2020.05.19 08:30|USD";
   I_s_379[218] = "2020.05.19 10:00|USD";
   I_s_379[219] = "2020.05.20 05:00|EUR";
   I_s_379[220] = "2020.05.20 10:30|USD";
   I_s_379[221] = "2020.05.20 14:00|USD";
   I_s_379[222] = "2020.05.21 03:30|EUR";
   I_s_379[223] = "2020.05.21 08:30|USD";
   I_s_379[224] = "2020.05.21 08:30|USD";
   I_s_379[225] = "2020.05.21 10:00|USD";
   I_s_379[226] = "2020.05.21 14:30|USD";
   I_s_379[227] = "2020.05.22 07:30|EUR";
   I_s_379[228] = "2020.05.25 02:00|EUR";
   I_s_379[229] = "2020.05.25 04:00|EUR";
   I_s_379[230] = "2020.05.26 10:00|USD";
   I_s_379[231] = "2020.05.26 10:00|USD";
   I_s_379[232] = "2020.05.27 03:30|EUR";
   I_s_379[233] = "2020.05.28 08:30|USD";
   I_s_379[234] = "2020.05.28 08:30|USD";
   I_s_379[235] = "2020.05.28 08:30|USD";
   I_s_379[236] = "2020.05.28 10:00|USD";
   I_s_379[237] = "2020.05.28 11:00|USD";
   I_s_379[238] = "2020.05.29 05:00|EUR";
   I_s_379[239] = "2020.05.29 11:00|USD";
   I_s_379[240] = "2020.06.01 03:55|EUR";
   I_s_379[241] = "2020.06.01 10:00|USD";
   I_s_379[242] = "2020.06.03 03:55|EUR";
   I_s_379[243] = "2020.06.03 08:15|USD";
   I_s_379[244] = "2020.06.03 10:00|USD";
   I_s_379[245] = "2020.06.03 10:30|USD";
   I_s_379[246] = "2020.06.04 07:45|EUR";
   I_s_379[247] = "2020.06.04 07:45|EUR";
   I_s_379[248] = "2020.06.04 07:45|EUR";
   I_s_379[249] = "2020.06.04 07:45|EUR";
   I_s_379[250] = "2020.06.04 08:30|USD";
   I_s_379[251] = "2020.06.04 08:30|EUR";
   I_s_379[252] = "2020.06.05 08:30|USD";
   I_s_379[253] = "2020.06.05 08:30|USD";
   I_s_379[254] = "2020.06.05 10:00|USD";
   I_s_379[255] = "2020.06.08 09:45|EUR";
   I_s_379[256] = "2020.06.08 11:45|EUR";
   I_s_379[257] = "2020.06.09 08:00|USD";
   I_s_379[258] = "2020.06.09 10:00|USD";
   I_s_379[259] = "2020.06.10 08:30|USD";
   I_s_379[260] = "2020.06.10 10:30|USD";
   I_s_379[261] = "2020.06.10 14:00|USD";
   I_s_379[262] = "2020.06.10 14:00|USD";
   I_s_379[263] = "2020.06.10 14:00|USD";
   I_s_379[264] = "2020.06.10 14:30|USD";
   I_s_379[265] = "2020.06.11 08:30|USD";
   I_s_379[266] = "2020.06.11 08:30|USD";
   I_s_379[267] = "2020.06.16 05:00|EUR";
   I_s_379[268] = "2020.06.16 08:30|USD";
   I_s_379[269] = "2020.06.16 08:30|USD";
   I_s_379[270] = "2020.06.16 10:00|USD";
   I_s_379[271] = "2020.06.17 05:00|EUR";
   I_s_379[272] = "2020.06.17 08:30|USD";
   I_s_379[273] = "2020.06.17 10:30|USD";
   I_s_379[274] = "2020.06.17 12:00|USD";
   I_s_379[275] = "2020.06.18 08:30|USD";
   I_s_379[276] = "2020.06.18 08:30|USD";
   I_s_379[277] = "2020.06.19 06:00|EUR";
   I_s_379[278] = "2020.06.19 13:00|USD";
   I_s_379[279] = "2020.06.22 10:00|USD";
   I_s_379[280] = "2020.06.23 03:30|EUR";
   I_s_379[281] = "2020.06.23 10:00|USD";
   I_s_379[282] = "2020.06.24 04:00|EUR";
   I_s_379[283] = "2020.06.24 10:30|USD";
   I_s_379[284] = "2020.06.25 07:30|EUR";
   I_s_379[285] = "2020.06.25 08:30|USD";
   I_s_379[286] = "2020.06.25 08:30|USD";
   I_s_379[287] = "2020.06.25 08:30|USD";
   I_s_379[288] = "2020.06.26 03:00|EUR";
   I_s_379[289] = "2020.06.29 10:00|USD";
   I_s_379[290] = "2020.06.30 05:00|EUR";
   I_s_379[291] = "2020.06.30 10:00|USD";
   I_s_379[292] = "2020.06.30 12:30|USD";
   I_s_379[293] = "2020.07.01 03:55|EUR";
   I_s_379[294] = "2020.07.01 03:55|EUR";
   I_s_379[295] = "2020.07.01 08:10|EUR";
   I_s_379[296] = "2020.07.01 08:15|USD";
   I_s_379[297] = "2020.07.01 10:00|USD";
   I_s_379[298] = "2020.07.01 10:30|USD";
   I_s_379[299] = "2020.07.01 14:00|USD";
   I_s_379[300] = "2020.07.02 08:30|USD";
   I_s_379[301] = "2020.07.02 08:30|USD";
   I_s_379[302] = "2020.07.02 08:30|USD";
   I_s_379[303] = "2020.07.02 09:30|USD";
   I_s_379[304] = "2020.07.04 06:40|EUR";
   I_s_379[305] = "2020.07.06 10:00|USD";
   I_s_379[306] = "2020.07.07 08:00|USD";
   I_s_379[307] = "2020.07.07 10:00|USD";
   I_s_379[308] = "2020.07.08 10:30|USD";
   I_s_379[309] = "2020.07.09 08:30|USD";
   I_s_379[310] = "2020.07.10 08:30|USD";
   I_s_379[311] = "2020.07.14 05:00|EUR";
   I_s_379[312] = "2020.07.14 08:30|USD";
   I_s_379[313] = "2020.07.15 10:30|USD";
   I_s_379[314] = "2020.07.16 07:45|EUR";
   I_s_379[315] = "2020.07.16 07:45|EUR";
   I_s_379[316] = "2020.07.16 07:45|EUR";
   I_s_379[317] = "2020.07.16 07:45|EUR";
   I_s_379[318] = "2020.07.16 08:30|USD";
   I_s_379[319] = "2020.07.16 08:30|USD";
   I_s_379[320] = "2020.07.16 08:30|USD";
   I_s_379[321] = "2020.07.16 08:30|USD";
   I_s_379[322] = "2020.07.16 08:30|EUR";
   I_s_379[323] = "2020.07.17 05:00|EUR";
   I_s_379[324] = "2020.07.17 08:30|USD";
   I_s_379[325] = "2020.07.22 09:15|EUR";
   I_s_379[326] = "2020.07.22 10:00|USD";
   I_s_379[327] = "2020.07.22 10:30|USD";
   I_s_379[328] = "2020.07.23 08:30|USD";
   I_s_379[329] = "2020.07.24 03:30|EUR";
   I_s_379[330] = "2020.07.24 10:00|USD";
   I_s_379[331] = "2020.07.27 04:00|EUR";
   I_s_379[332] = "2020.07.27 08:30|USD";
   I_s_379[333] = "2020.07.28 10:00|USD";
   I_s_379[334] = "2020.07.29 10:00|USD";
   I_s_379[335] = "2020.07.29 10:30|USD";
   I_s_379[336] = "2020.07.29 14:00|USD";
   I_s_379[337] = "2020.07.29 14:00|USD";
   I_s_379[338] = "2020.07.29 14:30|USD";
   I_s_379[339] = "2020.07.30 03:55|EUR";
   I_s_379[340] = "2020.07.30 04:00|EUR";
   I_s_379[341] = "2020.07.30 08:30|USD";
   I_s_379[342] = "2020.07.30 08:30|USD";
   L_i_47 = 0;
   if (ArraySize(I_s_379) <= 0) return;
   do {
      G_i_388 = StringLen(I_s_379[L_i_47]);
      if (G_i_388 > 10) {
         string L_s_15[2];
         StringSplit(I_s_379[L_i_47], 124, L_s_15);
         L_l_1 = StringToTime(L_s_15[0]) + 14400;
         S_s_509 = (string)L_i_47;
         S_s_509 = "DNews" + S_s_509;
         ObjectCreate(0, S_s_509, OBJ_VLINE, 0, L_l_1, 0, 0, 0, 0, 0);
         S_s_510 = (string)L_i_47;
         S_s_510 = "DNews" + S_s_510;
         ObjectSet(S_s_510, OBJPROP_COLOR, 42495);
         S_s_511 = (string)L_i_47;
         S_s_511 = "DNews" + S_s_511;
         ObjectSet(S_s_511, OBJPROP_STYLE, I_i_196);
         S_s_512 = (string)L_i_47;
         S_s_512 = "DNews" + S_s_512;
         ObjectSetInteger(0, S_s_512, 9, 1);
         G_i_390 = AfterNewsStop * 60;
         G_l_57 = G_i_390;
         G_l_57 = L_l_1 + G_l_57;
         G_i_391 = BeforeNewsStop * 60;
         G_l_58 = G_i_391;
         G_l_58 = L_l_1 - G_l_58;
         S_s_513 = (string)L_l_1;
         S_s_513 = "News" + S_s_513;
         ObjectCreate(0, S_s_513, OBJ_RECTANGLE, 0, 0, 0, 0, 0, 0, 0);
         ObjectSet(S_s_513, OBJPROP_STYLE, 0);
         ObjectSet(S_s_513, OBJPROP_COLOR, 255);
         ObjectSet(S_s_513, OBJPROP_BACK, 1);
         ObjectSet(S_s_513, OBJPROP_TIME1, G_l_58);
         ObjectSet(S_s_513, OBJPROP_PRICE1, ((_Point * 20000) + High[1]));
         ObjectSet(S_s_513, OBJPROP_TIME2, G_l_57);
         G_d_131 = (_Point * 20000);
         ObjectSet(S_s_513, OBJPROP_PRICE2, (Low[1] - G_d_131));
         ArrayFree(L_s_15);
      }
      L_i_47 = L_i_47 + 1;
   } while (L_i_47 < ArraySize(I_s_379));
}


//+------------------------------------------------------------------+
