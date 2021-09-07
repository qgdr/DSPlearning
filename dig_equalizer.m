%数字均衡器 digital equalizer
global obj;
global Fs;
global x;
T=10;
f=44100;

%handle;
[FileName,PathName,filterindex]=uigetfile({'*.mp3'},'File Selector');
%set(handle1,'String',FileName);
obj=fullfile(PathName,FileName);        %获得文件名

if exist(obj)==0                       %判断文件是否存在
    disp('No File');
else
    [x,Fs]=audioread(obj,[1,T*f]);         %现在都用audio系列函数读文件
    %s1=sprintf('%f',len);                   [start,finish]可调
    %set(handle2,'String',s1);  
    
    N=T*f;                       %读数据
    T1=N/Fs;
    t=linspace(0,T1,N);
    x1=x(:,1);
    x2=x(:,2);
    %absolute=abs(x);
    %Amax=max(absolute);
    
    subplot 211;plot(t,x1);     %左声道
    max1=max(x1);
    ylim([-max1,max1]);
    subplot 212;plot(t,x2);     %右声道
    max2=max(x2);
    ylim([-max2,max2]);
    soundsc(x,Fs);               %播放
    pause(5);
    
    f=[0 0.0028 0.0057 0.0113 0.0227 0.0454 0.0907 0.1814 0.3628 0.726 1];
    %input
    v1=0;
    v2=0;
    v3=0;
    v4=0;
    v5=1;
    v6=1;
    v7=1;
    v8=1;
    v9=1;
    m=[0 v1 v2 v3 v4 v5 v6 v7 v8 v9 0];
    b=fir2(100,f,m);               %滤波器(均衡器）
    
    
    figure;
    plot(b)
    pause(5);
    
    figure;
    y1=filter(b,1,x1);
    subplot 211;plot(t,y1);
    
    y2=filter(b,1,x2);
    subplot 212;plot(t,y2);
    
    y=[y1,y2];
    soundsc(y1,Fs);
end
%delete(obj);           真他妈给删了
