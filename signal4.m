%第四章 信号的频域分析
%% 方波分解合成
N=1024;T=2;
x=linspace(0,T,N);
n=1;
y1=sin(n*2*pi*x);
subplot 411;plot(x,y1);
n=3;
y2=y1+1/n*sin(n*2*pi*x);
subplot 412;plot(x,y2);
n=5;
y3=y2+1/n*sin(n*2*pi*x);
subplot 413;plot(x,y3);
n=7;
y4=y3+1/n*sin(n*2*pi*x);
subplot 414;plot(x,y4);
%% 快速傅里叶变换
Fs=5120;N=1024;
dt=1/5120;
T=dt*N;
t=linspace(0,T,N);
x=10*sin(2*pi*100*t)+10/3*sin(3*2*pi*100*t);
plot(t,x)
y=fft(x,N);
a=real(y);b=imag(y);%实频谱，虚频谱
figure;
subplot 211;plot(a);
subplot 212;plot(b);
A1=abs(y);          %幅值图
Q1=angle(y)*180/pi; %相位谱
figure;
subplot 211;plot(A1);
subplot 212;plot(Q1);
%显示真实频谱
f=linspace(0,Fs/2,N/2);
A1=abs(y)/(N/2);
Q1=angle(y)*180/pi;
subplot 211;plot(f,A1(1:N/2));
subplot 212;plot(f,Q1(1:N/2));
%% 分贝
Fs=5120;N=1024;
dt=1/Fs;T=dt*N;
t=linspace(0,T,N);
x=10*sin(2*pi*100*t)+sin(3*2*pi*100*t);
y=fft(x,N);
f=linspace(0,Fs/2,N/2);
A1=abs(y)/(N/2);
A2=A1.^2;
P2=20*log10(A2);%分贝dB=20log(P)
subplot 211;plot(f,A2(1:N/2));
subplot 212;plot(f,P2(1:N/2));axis([0,3000,-150,50]);
%方波功率谱
x=square(2*pi*100*t);
y=fft(x,N);
f=linspace(0,Fs/2,N/2);
A1=abs(y)/(N/2);
A2=A1.^2;
P2=20*log10(A2);%分贝dB=20log(P)
subplot 211;plot(f,A2(1:N/2));
subplot 212;plot(f,P2(1:N/2));axis([0,3000,-150,50]);
%% 数字信号频谱计算方法
%信号的截断
%截断信号有能量泄露
Fs=40960;N=8192;
dt=1/Fs;T=dt*N;
t=linspace(0,T,N);
x=10*sin(2*pi*100*t)+sin(3*2*pi*100*t);
y=fft(x,8*N);
f=linspace(0,Fs/2,N*4);
A1=abs(y)/(N*4);
A2=A1.^2;
P2=20*log10(A2);%分贝dB=20log(P)
plot(f,A1(1:N*4));
%subplot 211;
plot(f,A2(1:N*4));
%subplot 212;
plot(f,P2(1:N*4));axis([0,3000,-150,50]);
%方波功率谱
x=square(2*pi*100*t);
y=fft(x,N*4);
f=linspace(0,Fs/2,N*2);
A1=abs(y)/(N*2);
A2=A1.^2;
plot(f,A1(1:N*2));axis([0,20,0,0.5]);
P2=20*log10(A2);%分贝dB=20log(P)
subplot 211;plot(f,A2(1:N*2));axis([0,100,-0.02,0.12]);
subplot 212;plot(f,P2(1:N*2));axis([0,3000,-150,50]);
%信号整周期截断，避免能量泄露
%离散傅里叶变换DFT
%栅栏效应
%窗函数 window designer
