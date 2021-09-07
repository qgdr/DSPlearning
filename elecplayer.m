%电子琴制作
%% 电子琴
Fs=22050;
dt=1/Fs;
T=1;
N=T/dt;
t=linspace(0,T,N);
x=0.3*sin(2*pi*247*t);
plot(app.UIAxes,t,x);
axis(app.UIAxes,[0,0.01,-0.5,0.5]);
sound(x,Fs);
%247 262 294 330 349 392 440 494 523
%信号幅值调制 包络，基音泛音

A=linspace(0,0.9,4400);
D=linspace(0.9,0.8,1100);
S=linspace(0.8,0.8,9000);
R=linspace(0.8,0,7550);
adsr=[A,D,S,R];
Fs=22050;
plot(t,adsr)
%% 数字信号发生器
%不想做了
v1=get(handles.slider1,'Value');
s1=sprintf('%f',v1);%数字2字符串
set(handles.edit1,'String',s1);

s1=get(handles.edit1,'String');
v1=str2double(s1);
set(handles.slider1,'Value',v1);

%时间发生