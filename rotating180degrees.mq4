//+------------------------------------------------------------------+
//|                                           rotating 180 degrees   |
//|                                                        motochan  |
//|                                   http://1969681.blog66.fc2.com/ |
//+------------------------------------------------------------------+

#property copyright "motochan1969"
#property link      "http://1969681.blog66.fc2.com/"

#property indicator_chart_window
#property indicator_buffers 4
#property indicator_color1 Red
#property indicator_width1 1
#property indicator_style1 0
#property indicator_color2 Yellow
#property indicator_width2 1
#property indicator_style2 0
#property indicator_color3 Cyan
#property indicator_width3 1
#property indicator_style3 0
#property indicator_color4 Red
#property indicator_width4 1
#property indicator_style4 0


//---- input parameters
extern int Length=75; //反転の期間長さ
extern int Shift = 1; //チャートシフト　
extern int nPeriod_MA=20; //移動平均
extern int MA_Method=0; //移動平均計算方法
extern int R180D_hantei = 20;//180度回転トレンド判定用の時間軸シフト
extern int R180D_space = 100;//180度回転判定レベル


double buf1[]; // 反転チャート
double buf2[]; //　移動平均線
double buf3[]; //　long(buy)
double buf4[]; // short(sell)


//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
   SetIndexBuffer(0,buf1);
   SetIndexShift(0,Length-Shift);
   SetIndexStyle(0,DRAW_LINE);
   
   SetIndexBuffer(1,buf2);
   SetIndexShift(1,59);
   SetIndexStyle(1,DRAW_LINE);
   
   SetIndexStyle(2,DRAW_ARROW);
   SetIndexBuffer(2,buf3);
   SetIndexArrow(2,233);
      
   SetIndexStyle(3,DRAW_ARROW);
   SetIndexBuffer(3,buf4);    
   SetIndexArrow(3,234);
      
   return(0);
  }

//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int start()
  {

   int i;
   int counted_bars=IndicatorCounted();
      
   for(i=counted_bars-1;i>Length;i--){
      buf1[i]=EMPTY_VALUE;
      buf2[i]=EMPTY_VALUE;
      buf3[i]=EMPTY_VALUE;
      buf4[i]=EMPTY_VALUE;
         }

   for(i=Length+ nPeriod_MA;i>=0;i--){    
       if (i<Length) buf1[i]=Close[Shift]+(Close[Shift]-Close[Length+Shift-i]);
       else buf1[i] = Close[i-Length+Shift];
   }
   
   for(i=0; i<Length ; i++){
      buf2[i]=iMAOnArray(buf1,0,nPeriod_MA,0,MA_Method,i);
   } 

   i=0;
   if (buf2[R180D_hantei] - Close[i] >  R180D_space  * Point)    buf3[i]=Close[i];
   if (Close[i]- buf2[R180D_hantei] > R180D_space  * Point)    buf4[i]=Close[i];
      
   return(0);
   
      
  }
//+------------------------------------------------------------------+