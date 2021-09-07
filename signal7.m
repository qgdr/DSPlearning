%第七章 信号的数字滤波
%% 滤波
%fft();
%逆变换ifft();
%分片滤波，头尾失真（暂态效应）
%% z变换
%离散
%高斯平滑滤波器
%h=guass(n);
%% FIR滤波器
%有限脉冲响应滤波器
f=[0,0.2,0.25,1];
m=[1,1,0.2,0];
b=fir2(20,f,m);%实际滤波器
[h,w]=freqz(b,1,128);
subplot 211;plot(f,m,w/pi,abs(h));
subplot 212;impz(b,1);
%% 加窗
N=61;
w1=window(@hamming,N);
subplot 311;
plot(w1,'linewidth',2);
w2=window(@blackmanharris,N);
subplot 312;plot(w2);
w3=window(@tukeywin,N,0.5);
subplot 313;plot(w3);
%% 滤波实现
%fir1,filter freqz()
N=48;
b=fir1(N,[0.35,0.65],blackman(N+1));
freqz(b,1,512);
%% filter函数
Fs=2048;dt=1/Fs;
T=1;N=T/dt;
t=(0:N-1)/N;
x1=sin(2*pi*50*t)+sin(2*pi*300*t)+sin(2*pi*500*t);
subplot 311;plot(t,x1);axis([0,0.1,-2,2]);
P=fft(x1,N);
Pyy=2*sqrt(P.*conj(P))/N;
f=linspace(0,Fs/2,N/2);
subplot 312;plot(f,Pyy(1:N/2));
b=fir1(48,0.1);
%b=fir1(48,[0.2,0.4]);
%b=fir1(48,0.4,'high');
x2=filter(b,1,x1);
subplot 313;plot(t,x2);axis([0,0.1,-2,2]);
%% fir2
%f=[0,0.2,0.3,0.4,1];
%m=[1 1 0.7 0 0];
f=[0 0.2 0.2 1];
m=[1 1 0 0];
b=fir2(48,f,m);
[h,w]=freqz(b,1,128);
subplot 211;plot(f,m,w/pi,abs(h));
x2=filter(b,1,x1);
subplot 212;
plot(t,x2);axis([0,0.1,-2,2]);
%% firls最小二乘
f=[0 0.2 0.4 0.6 0.8 0.9];
a=[1 1 0.6 0.4 0.2 0];
b=firls(24,f,a);
[h,w]=freqz(b,1,512,2);
plot(w,abs(h));%得到的窗并不好
%% 对比
f=[(0:0.1:0.6),1];
m=[1 1 0 0 0 1 1 0];
b=firls(48,f,m);
[h,w]=freqz(b,1,128);
subplot 211;
plot(f,m,w/pi,abs(h));
subplot 212;
b=fir2(48,f,m);
[h,w]=freqz(b,1,128);
plot(f,m,w/pi,abs(h));
%% IIR滤波
Fc=1;
Fs=1;
N=2;
Wn=Fc;
[b,a]=butter(N,Wn,'s');%模拟滤波器，N阶，Wn截止频率，
[h,f]=freqs(b,a);      %freqs 
subplot 211;
plot(f,abs(h));
[bz,az]=bilinear(b,a,Fs);%归一化
[h1,f1]=freqz(bz,az,512,Fs,'whole');
subplot 212;
plot(f1,abs(h1));
%避免频率混叠
%巴特沃斯滤波器  切比雪夫滤波器1、2  椭圆滤波器
%cheby1,cheby2,ellip
Fs=2048;dt=1/Fs;
T=1;N=T/dt;
t=(0:N-1)/N;
x1=sin(2*pi*50*t)+sin(2*pi*300*t)+sin(2*pi*500*t);
subplot 311;plot(t,x1);axis([0,0.1,-2,2]);
P=fft(x1,N);
Pyy=2*sqrt(P.*conj(P))/N;
f=linspace(0,Fs/2,N/2);
subplot 312;plot(f,Pyy(1:N/2));
[b,a]=ellip(8,1,60,0.1,'low');%这就是椭圆滤波器了
x2=filter(b,a,x1);            %
subplot 313;plot(t,x2);axis([0 0.1 -2 2]);
%% 其他滤波器
%1，陷波滤波器  Notch filter  (带阻滤波器，非常窄)
%iirnotch
Fs=200;T=2;dt=1/Fs;
N=T/dt;t=linspace(0,T,N);
y=sin(2*pi*5*t)+sin(2*pi*50*t);
f=50;                %陷波位置
subplot 311;plot(t,y);
wo=f*2/Fs;bw=wo/20;
[b,a]=iirnotch(wo,bw);%bw品质参数
%[b,a]=iirpeak(wo,bw);
[h,w]=freqz(b,a);
subplot 312;
plot(w*Fs/(2*pi),abs(h));
z=filter(b,a,y);
subplot 313;plot(t,z);
%2，尖峰滤波器 Peak filter
[~,~]=iirpeak(wo,bw);%行113
%3，梳状滤波器 Comb filter
Fs=600;fo=60;q=15;
bw=(fo*2/Fs)/q;
[~,~]=iircomb(Fs/fo,bw,'notch');%谐波阻拦
[b,a]=iircomb(Fs/fo,bw,'peak'); %谐波通过
%4，半带滤波器 firhalfband
%5，希尔伯特全通滤波器90d相移滤波器
hilbert(x);
%用于包络检测
%% 其他调制解调方法
%1，幅度
%ammod%调制
%amdemod%解调
Fs=44100;
Fc=400;
dt=1/Fs;
T=1;
N=T/dt;
t=(0:N-1)/N;
dev=pi;
x1=sin(2*pi*10*t)+1.3;
subplot 311;plot(t,x1);axis([0 0.2 -2.5 2.5]);
y1=ammod(x1,Fc,Fs);
%y1=fmmod(x1,Fc,Fs,200);   %Fc载波，Fs采样频率
%y1=pmmod(x1,Fc,Fs,dev);
subplot 312;plot(t,y1);axis([0 0.2 -2.5 2.5]);
y2=amdemod(y1,Fc,Fs);     %spfirst里也有一个，那个不对，路径移到底端
%y2=fmdemod(y1,Fc,Fs,200);
%y2=pmdemod(y1,Fc,Fs,dev);
subplot 313;plot(t,y2);axis([0 0.2 -2.5 2.5]);
%2，频率
%fmmod
%fmdemod
%3，相位
%pmmod
%pmdemod
%% Matlab 滤波器设计工具
%fdesign.? => fvtool   %?:lowpass,highpass,bandpass,bandstop,hilbert;
d=fdesign.lowpass('Fp,Fst,Ap,Ast',0.1,0.25,1,60);
Hd=design(d,'equiripple');
%fvtool(Hd);
Fs=2048;dt=1/Fs;T=1;
N=T/dt;t=(0:N-1)/N;
x1=sin(2*pi*50*t)+sin(2*pi*300*t)+sin(2*pi*500*t);
subplot 211;plot(t,x1);axis([0 0.1 -2 2]);
x2=filter(Hd,x1);   %卷积
subplot 212;plot(t,x2);axis([0 0.1 -2 2]);