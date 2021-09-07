%第1章 计算机测量仪器系统
%% 计算机视频信号采集与分析
vid=videoinput('winvideo',1,'YUY2_640x480');
set(vid,'ReturnedColorSpace','rgb');
preview(vid);
start(vid);
%% 采样定理
%脉冲信号p(t)*连续信号x(t)
%Fs>2*F
%% 声音信号采集分析
%用声卡进行声音信号采集
Fs=11025;
obj=audiorecorder(Fs,16,1);
disp('Start speaking.');
recordblocking(obj,4);
disp('End of recorfing');
%stop(x);
myspeech=getaudiodata(obj);
plot(myspeech)
set(gca,'color',[0.95,0.95,0]);
%生成信号音乐
soundsc(myspeech,2*Fs)%变声
%生成定频率信号
Fs=11025;
omega=300;
s=2;
t=linspace(0,s,s*Fs);
x=0.6*sin(2*pi*omega*t);
plot(t,x)
axis([0,0.01,-0.35,0.35]);
sound(x,Fs)
%% matlab编程实现
%sinc丑帽小波
tic;
x=-8:0.5:8;
y=x;
[X,Y]=meshgrid(x,y);
R=sqrt(X.^2+Y.^2)+eps;
z=sin(R)./R;
mesh(z);
toc;
%stem()到坐标轴的竖线
%% GUI界面
guide%不用了
%% Arduino




