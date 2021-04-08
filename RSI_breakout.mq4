//+------------------------------------------------------------------+
//|                                                RSI_breakout.mq4  |
//|                                                        motochan  |
//|                              http://1969681.blog66.fc2.com/      |
//+------------------------------------------------------------------+

#property copyright "motochan1969"
#property link      "http://1969681.blog66.fc2.com/"

#property indicator_separate_window
#property indicator_minimum 0
#property indicator_maximum   100
#property indicator_buffers 8
#property indicator_width1 1
#property indicator_width2 1
#property indicator_width3 1
#property indicator_width4 1
#property indicator_width5 1
#property indicator_width6 1
#property indicator_width7 1
#property indicator_width8 1
#property indicator_color1 Blue
#property indicator_color2 LimeGreen
#property indicator_color3 SteelBlue
#property indicator_color4 Salmon
#property indicator_color5 SteelBlue
#property indicator_color6 Salmon
#property indicator_color7 Cyan
#property indicator_color8 Red

//---- input parameters
extern int Limit=200;
extern int nLine=20;
extern int nPeriod_RSI=14;
extern int nPeriod_MA=25;
extern int MA_Method=1;
extern double margin = 1;
extern int min_gap = 2;
extern double offset = 10;


//---- indicator buffers
double RSI[]; //RSI
double Kairi_buffer[]; //Kairi rate of RSI
double mov_rsi[]; //moving average of RSI
double buf1[]; //upper-line past
double buf2[]; //upper-line future
double buf3[]; //lower-line past
double buf4[]; //lower-line future
double buf5[]; //Sign buy
double buf6[]; //Sign sell


//+------------------------------------------------------------------+
//| Custom indicator initiHi_stackization function                         |
//+------------------------------------------------------------------+
int init()
{
   return(0);
}
//+------------------------------------------------------------------+
//| Custom indicator deinitiHi_stackization function                       |
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
   int i,j,k,ll;
   double rh,rl;
   int  hp1n,hp2n,hp3n,lp1n,lp2n,lp3n; 
   double hp1,hp2,lp1,lp2;  
   int Hi_stack[];
   int Lo_stack[];
   int ii[];

   ArrayResize(ii,nLine*2+10);
   ArrayResize(Hi_stack,nLine*2+10);
   ArrayResize(Lo_stack,nLine*2+10);
   ArrayResize(Lo_stack,nLine*2+10);
   ArrayResize(Lo_stack,nLine*2+10);
   ArrayResize( RSI,1000);
   ArrayResize( Kairi_buffer,1000);
   ArrayResize( mov_rsi,1000);
   ArrayResize( buf1,1000);
   ArrayResize( buf2,1000);
   ArrayResize( buf3,1000);
   ArrayResize( buf4,1000);
   ArrayResize( buf5,1000);
   ArrayResize( buf6,1000);
   
   SetIndexStyle(0,DRAW_LINE);
   SetIndexStyle(1,DRAW_LINE);
   SetIndexStyle(2,DRAW_LINE);
   SetIndexStyle(3,DRAW_LINE);
   SetIndexStyle(4,DRAW_ARROW);
   SetIndexStyle(5,DRAW_ARROW);
   SetIndexStyle(6,DRAW_ARROW);
   SetIndexStyle(7,DRAW_ARROW);
      
   SetIndexBuffer(0,mov_rsi);
   SetIndexBuffer(1,RSI);
   SetIndexBuffer(2,buf1);
   SetIndexBuffer(3,buf2);   
   SetIndexBuffer(4,buf3);
   SetIndexBuffer(5,buf4);   
   SetIndexBuffer(6,buf5);   
   SetIndexBuffer(7,buf6);       
      
   SetIndexArrow(4,158);
   SetIndexArrow(5,158);
   SetIndexArrow(6,233);
   SetIndexArrow(7,234);
   
   SetIndexLabel(0,"mov_rsi");
   SetIndexLabel(1,"rsi");
   SetIndexLabel(2,"buf1");
   SetIndexLabel(3,"buf2");
   SetIndexLabel(4,"buf3");
   SetIndexLabel(5,"buf4");
   SetIndexLabel(6,"buf5");
   SetIndexLabel(7,"buf6");
                                          //
                       
    int counted_bars=IndicatorCounted();
               
    for(i=0; i<1000; i++){
       RSI[i]=iRSI(NULL,0,nPeriod_RSI,PRICE_CLOSE,i+1);
    }

    for(i=0; i<1000; i++){
       mov_rsi[i]=iMAOnArray(RSI,0,nPeriod_MA,0,MA_Method,i)+offset;
    } 

    for(i=0; i<Limit; i++){
      Kairi_buffer[i] = (RSI[i]-mov_rsi[i])/mov_rsi[i];
   }
   
    j=0;   
    for(i=1; j<nLine*2+6; i++){
      if (Kairi_buffer[i] * Kairi_buffer[i+1] <= 0){           
         ii[j] = i;
         j++;
          if(j>2){
        if(ii[j-1]-ii[j-3]<min_gap){
         j=j-2;
         }
      }
    }
    }
          
    if(Kairi_buffer[ii[0]]<0)
     {
      for(ll=0; ll<nLine+6;ll++)
         {
         Hi_stack[ll] = ArrayMaximum(RSI, ii[1+ll*2]-ii[0+ll*2]+1, ii[0+ll*2]+1);
         Lo_stack[ll] = ArrayMinimum(RSI, ii[2+ll*2]-ii[1+ll*2]+1, ii[1+ll*2]+1);
         }
     }
      else
     {
      for(ll=0; ll<nLine+6;ll++)
         {
         Hi_stack[ll] = ArrayMaximum(RSI, ii[2+ll*2]-ii[1+ll*2], ii[1+ll*2]+1);
         Lo_stack[ll] = ArrayMinimum(RSI, ii[1+ll*2]-ii[0+ll*2], ii[0+ll*2]+1);
         }
     }
    
    for(ll=0;ll<nLine;ll++)
    {
    hp1=RSI[Hi_stack[ll]];
    hp2=RSI[Hi_stack[ll+1]];
    hp1n=Hi_stack[ll];
    hp2n=Hi_stack[ll+1];
    hp3n=Hi_stack[ll-1];
        
    if(hp2n!=hp1n) {    rh=((hp2-hp1)/(hp2n-hp1n));}    

    lp1=RSI[Lo_stack[ll]];
    lp2=RSI[Lo_stack[ll+1]];
    lp1n=Lo_stack[ll];
    lp2n=Lo_stack[ll+1];
    lp3n=Lo_stack[ll-1];
            
    if(lp1n!=lp2n){    rl=((lp1-lp2)/(lp2n-lp1n));}    
    
    for(k=0;k<hp2n-hp1n;k++){     buf1[hp1n+k]=hp1+rh*k;}
    for(k=0;k<lp2n-lp1n;k++){     buf2[lp1n+k]=lp1-rl*k;}
    for(k=1;k<=hp1n-hp3n;k++){    buf3[hp1n-k]=hp1-rh*k;}
    for(k=1;k<=lp1n-lp3n;k++){    buf4[lp1n-k]=lp1+rl*k;}
    }
    
    for(i=0; i<Limit; i++){
     buf5[i]=EMPTY_VALUE;
     buf6[i]=EMPTY_VALUE;
    }
            
    for(i=0; i<Limit; i++){
    // SELL 
       if ( buf4[i]>=buf4[i+1] && MathAbs((buf4[i]-buf4[i+1])-(buf4[i-1]-buf4[i]))<0.001 && RSI[i] < buf4[i] && RSI[i+2] > buf4[i+2] && buf4[i+1] - RSI[i+1] > margin){
            buf6[i]=RSI[i];
       } else {
            buf6[i]=EMPTY_VALUE;
       }
    // BUY   
       if ( buf3[i]<=buf3[i+1] && MathAbs((buf3[i]-buf3[i+1])-(buf3[i-1]-buf3[i]))<0.001 && RSI[i]>buf3[i] && RSI[i+2]<buf3[i+2] && RSI[i+1] - buf3[i+1] > margin){
            buf5[i]=RSI[i];
       } else {
            buf5[i]=EMPTY_VALUE;
       }           
    }
   return(0);
}
