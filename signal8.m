%第八章 信号的时-频分析简介
%% 时-频分析概念
%时-频图。
%% 短时傅里叶变换（STFT）
%spectrogram函数
Fs=5120;N=32768;
dt=1/Fs;df=500/N;
T=dt*N;
t=linspace(0,T,N);
x=zeros(1,N);
for k=1:8192
    x(k)=sin(2*pi*200*k*dt);
    x(k+8192)=sin(2*pi*400*k*dt);
    x(k+16384)=sin(2*pi*600*k*dt);
    x(k+24576)=sin(2*pi*800*k*dt);
end                          %生成模拟信号
plot(t,x);
axis([1.59,1.61,-1.2,1.2]);
Z=spectrogram(x,1024,512);   %原始数据，长度，步进
P=20*log10(sqrt(Z.*conj(Z)));
X=linspace(0,Fs/2,513);
Y=linspace(0,T,63);
mesh(X,Y,P');
view(15,70);       %视角
%% 测不准原则(Heisenberg)
%delta(t)*delta(f)>=1/(4*pi)
%不同宽度的窗
%时间分辨率与频率分辨率不可兼得
Fs=5120;N=32768;
dt=1/Fs;df=500/N;
T=dt*N;
t=linspace(0,T,N);
x=zeros(1,N);
k=(1:N);
x=sin(2*pi*0.3*k*dt).*sin(2*pi*(500+df*k).*k*dt);
subplot 211;plot(x);
subplot 212;
Z=spectrogram(x,1024,512);
P=sqrt(Z.*conj(Z));
S=size(P);
X=linspace(0,Fs/2,1024/2+1);
Y=linspace(0,dt*N,S(2));
mesh(X,Y,P');view(15,70);

%chirp直接生成扫频信号
Fs=1000;
T=0:0.001:12;
X=chirp(T,1,12,400,'q');        %ft=900发生频率混叠
subplot 211;plot(T,X);
subplot 212;
spectrogram(X,512,256,512,Fs);  %直接画伪彩色图
view(-45,65);
%colormap bone;
%% 信号的小波分析
%Wavelet Families
%连续小波变换 cwt
Fs=1000;
T=0:0.001:12;
x=chirp(T,1,12,400,'q');
%c=cwt(x,1:64,'sym2','plot');
c=cwt(x,1:64,'db10','plot');

%subplot 211;plot(T,x);
%subplot 212;%不行啊
%cwt(x,'bump');    %  cwt改版了
%% 离散小波变换
%wavedec
%waverec
Fs=5120;N=1024;
dt=1/Fs;
k=(1:1024);
x=sin(2*pi*50*k*dt)+0.5*sin(2*pi*1500*k*dt);
subplot 311;plot(x);
[c,l]=wavedec(x,3,'db7');
subplot 312;plot(c);
y=waverec(c,l,'db7');
subplot 313;plot(y);
%% 小波包变换
%wpdec  wprec
Fs=5120;N=1024;
dt=1/Fs;
k=(1:1024);
x=sin(2*pi*50*k*dt)+0.5*sin(2*pi*1500*k*dt);
subplot 311;plot(x);
y=wpdec(x,3,'db7');
subplot 312;plot(y);
z=wprcoef(y,[3,0]);
subplot 313;plot(z);
%% Wavelat Demos
%样例