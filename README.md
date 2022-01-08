# 最強ＥＡ 　Ｖ９ 取扱説明書

## １）本ＥＡの特徴

・RSIにトレンドラインを引いて、ブレイクアウトを検出する独自のインジケータ　ＲＳＩ＿ＢＲＥＡＫＯＵＴと、未来予想型のインジケータRotation180degreesを軸とした、エセトレンドフォロー型逆張り投資手法となっています。

・ポジションニングは一定間隔に指値注文を積み増す、マーチンゲール手法を取っています。ナンピンロット係数にてポジションの積み上げを計算します。逆指値側にも注文を積み増すことが出来ます。

・注文には有効期限が設けられており、有効期限を過ぎて確定しなかった注文は取り消されます。

・個別注文に対する決済は、一定ＰＩＰＳもしくは、トレイリングストップにて実行します。トレイリングストップはスイッチでＯＮ／ＯＦＦできます。

・イグジットはサインが出てから、含み益が生じている場合のみ一斉に決済を行います。イグジットはスイッチでＯＮ／ＯＦＦできます。

・個別の注文に対して損失が発生している場合は、損失限定のトレイリング注文が発動します。トレイリングストップはスイッチでＯＮ／ＯＦＦできます。

・相場のボラティリティに合わせて、指値・逆指値の注文幅および、利益確定、損切りのトレイリング値幅が変動しますので、相場の状況に合わせたエントリー、ロスカットが可能です（ＶＥＲ．９最新版）

 ・パラメータの最適化によって、取引通貨、時間足に対して、最も利益が確保できる設定値を求めます。

## ２）インストール方法

最強ＥＡは下記のファイルで成り立っています。

インジケータ　→　INDICATORフォルダ  ---> rsi_breakout.mq4
エキスパートアドバイザ　→　EXPERTフォルダ --->  saokyo_ea_ver9.6.mq4
 
すべてコンパイル前のソースファイルになっていますので、メタトレーダのエディタにてコンパイルをお願いいたします。
 
## ３）パラメータ設定について

設定パラメータは下記です。

extern int MagicNumber = 20170302;//マジックＮｏ．（適当に設定してください）
extern bool EachTickMode = False;//意味なし（変更不要）
extern double Lots = 0.01; //ロットサイズ
extern double  LotMultiple  = 1.2;  //ナンピンロット係数α　注文は（α＋１）倍で生成します
  
//ポジション
extern int Slippage = 3; 
extern bool Use_limitorder = True;//逆指値スイッチ
extern bool Use_stoporder = True;//指値スイッチ
extern bool UseT_S = True;//利益確保のTS注文スイッチ
extern bool UseT_L = True;//損失確定のTS注文スイッチ
extern bool Use_close = True;//イグジットサイン発動スイッチ
extern bool UseDuration = True; //ポジション保有時間強制決済スイッチ
extern int expiration = 200;  	//エントリー有効時間
extern int maxDuration = 200;　//ポジション保有時間
extern int nPeriod_RSI=14;//RSI　基準数
extern int nPeriod_MA=45;//RSI　ボリンジャー基準数
extern int nPeriod_MA2=45;//RSI　移動平均基準数
extern double margin = 1.2;//ブレイクアウトマージン
extern int min_gap = 7;//トレンドライン検出用ギャップ（誤判定、発生頻度の調整用）

extern int TrailingStop = 1;       	//利益確保のトレイル幅（ピプス）
extern int L_TrailingStop = 1;       	//損失確定のトレイル幅（ピプス）
extern int space = 490;              	//ナンピン幅（ピプス）
extern int space_r = 355;　　　　　　　　//逆指値ナンピン幅（ピプス）
extern int multi = 2;　//指値のナンピン数　
extern int multi_r = 2;　//逆指値のナンピン数　

## ４）最適化について

最適化パラメータは、ＳＥＴフォルダに保存しているものを、そのまま読み込んで使用いただくことを推奨いたします。
使用の際には、必ずバックテストを実施し、プロフィットが得られるかの確認をお願いいたします。
もしもプロフィットが得られない場合には、ストラテジーテスターにて最適化をお願いいたします。

## ５）開発者紹介

Author:motochan
【ご挨拶】
　サラリーマンの傍らで、ＦＸをやっています。
初心者のためのテクニカル講座という分かりやすさを重視したブログを開設中
　http://1969681.blog66.fc2.com/

# rsi_breakout

## 1 License Agreement
 The information contained in this information is protected by copyright law. No part of this information may be copied or reproduced in any form or by any means. Resale is also strictly prohibited.

## 2 Development Background
 The background to the development of RSI Breakout is that I actually first created MT-BREAKOUT, which detects breakouts by adding a support-resistance line to the price. In system trading, the most important factor is that trends and ranges move completely differently. It is important to identify this, and it is often not possible to judge by price alone. Divergence is commonly referred to as an indicator, and how do you detect it? This indicator was created after much worrying about this.

## 3 Features
 This is an original indicator that generates a buy/sell sign when the RSI, a technical indicator, breaks the breakout line formed by the lower support line and upper resistance line.

## 3.1 About MT Breakout Method
 The MT Breakout Method is a method of detecting breakouts by assuming future breaklines as expected lines based on past support and resistance levels. (MT is the initials of the author, by the way.)

## 3.1.1 Contents of the chart
 The lower and upper support lines consist of two parts: the entity line and the forecast line. IMG_20210315_191753.jpg

## 3.1.2 Entity Line
 An entity line is a trend line calculated from past performance. The highs and lows that form a trendline are the maximum (minimum) values in a certain interval, which in the MT Breakout Method is defined by the maximum point of deviation from the moving average. The MT Breakout Method defines it as the point of maximum divergence from the moving average. The line of maximum divergence is formed by connecting the highest and lowest prices, respectively. The trend line is calculated recursively from past stock prices (established facts), and is not a forecast for the future.

## 3.1.3 Forecast Line
 A forecast line is an extension of a real line. A trend line is the same line connecting the highest and lowest prices, and has the characteristic of being easily formed on the extension of an interval trend line. This line determines the assumed future range by extending from the interval trend line.

## 3.2 Calculation Method
 This section explains the specific method for calculating breakouts from time series data. For the high and low prices, we ignore the whiskers and basically use the closing price for the calculation. IMG_20210315_191858.jpg

## 3.2.1 Calculating a Moving Average
 Moving averages are averages calculated based on the number of base days in the past with stock price data including the current day. There are several moving averages available, but the MT breakout method uses an exponential smoothing moving average. As long as you know the divergence rate, i.e., it doesn't matter what it is, it has the characteristic of being less prone to damashi.

## 3.2.2 Calculating the Rate of Deviation
 The rate of deviation indicates the deviation from the moving average, and the deviation is the largest. In other words, it is the point where the standard deviation is the largest (smallest).

## 3.2.3 Calculating the maximum (minimum) point
 Groups are generated for the upper and lower sides of the moving average, respectively. Since stock prices have a habit of returning to the moving average once the deviation reaches the maximum (small), the stock price will repeatedly move above, below, above, and below the moving average. By connecting the largest (smallest) deviation in the upper group with the smallest deviation in the lower group, we can draw a support line and resistance line for the interval. In this way, it is easy to create support and resistance lines at the points where the divergence ratio is at its maximum and minimum.

## 3.3 Trading Rules
 In a trading method that uses breakouts, the fact that a breakout occurs is the trigger. The RSI Breakout will also display signs that follow this trading rule. Buy If the predicted resistance line is broken above If the upper resistance line is broken, a buy point Sell When the price breaks below the predicted support line If the lower support line is broken, sell point IMG_20210315_191913.jpg

# 4 Setting Values
 The following are the arguments for the RSI Breakout.

//---- input parameters extern int Limit=200; most recent buffer extern int nLine=3; Number of most recent lines extern int nPeriod_RSI=14; RSI base value extern int nPeriod_MA=50; RSI moving average extern int MA_Method=1; Moving average calculation method extern double margin = 1; Gap to RSI for breakout decision extern int min_gap = 2; Minimum time gap for consecutive breakouts extern double offset = 10; Amount of vertical displacement relative to the RSI moving average The return values are as follows

SetIndexBuffer(0,mov_rsi); RSI moving average SetIndexBuffer(1,RSI); RSI SetIndexBuffer(2,buf1); high line past SetIndexBuffer(3,buf2); low line past SetIndexBuffer(4,buf3); high line future SetIndexBuffer(5,buf4); low price line future SetIndexBuffer(6,buf5); buy sign SetIndexBuffer(7,buf6); sell sign

## 4.1 Setting method
 (1) Number of lines limit is the max number of array variables used to calculate the RSI moving average, and nLine is the number of trend lines displayed. If you want to display many lines as an indicator, increase nLine. If you want to make RSI or MA longer, increase Limit appropriately. Basically, as long as the indicator display does not go wrong, you are good to go. If you want to use it in an EA, you can use Limit=200 and nLine=2 in order to speed up the optimization calculation.

 (2) Parameters for RSI Breakout nPeriod_RSI is the base number for RSI calculation. nPeriod_Ma and MA_Method are the base number of the move calculation and the move calculation method. Please refer to the help of the function iMAOnArray. margin is the break distance from the trendline when the signal is sent out.

* min_gap is the minimum interval for detecting maxima (minima), below which the trendline is ignored.
* The smaller the value, the more finely defined the trendline is, and the larger the value, the more roughly defined it is.
* Since this is just a computer calculation, you can set it according to the image of the trendline you should seek.
* Finally, there is offset, which is the value used to slide the moving average up or down when calculating the moving average for the RSI value.
* If you set offset to positive (upward), the lower support line will be emphasized.
* If offset is set to negative (downward), the upper resistance line will be emphasized.
* Since the way of capturing peaks changes slightly, please optimize the parameters when you incorporate it into your EA.
* There is still a lot of room for improvement in the current peak detection algorithm. IMG_20210315_191930.jpg

# 5 How to use
The download is a source file, which you can download to your indicator folder and then compile and use. Incorporate it into your Expert Advisor system and perform parameter optimization of the set values. The most powerful EA using this indicator is now available

# 6 Developer
 Introduction Author:motochan

## Greetings
 I'm a salaried worker and I'm also a forex trader. I have a blog called "Technical Course for Beginners" that focuses on ease of understanding.

