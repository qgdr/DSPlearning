%声音信号采集和频谱分析程序
%使用定时器可连续采样
timer
start
stop
%my_callback_fcn(app)%定时中断函数
            global Z1;global Z2
            Fs=11025;N=8192;
            dt=1/Fs;T=N*dt;
            obj=audiorecorder(Fs,16,1);
            recordblocking(obj,T);
            y=getaudiodata(obj);
            y=y(N/2+1:N);N=4096;
            x=linspace(0,N,N);
            plot(app.UIAxes,x,y,'b','LineWidth',1.5);
            ylim(app.UIAxes,[-Z1,Z1]);
            grid(app.UIAxes);
            P=fft(y,N);
            Pyy=2*sqrt(P.*conj(P))/N;
            f=linspace(0,Fs/2,N/2);
            plot(app.UIAxes2,f,Pyy(1:N/2),'b','LineWidth',1.5);
            ylim(app.UIAxes2,[0,0.1*Z2]);
            grid(app.UIAxes2);
%Timerfunction CreateTimer(app)
            global mytimer;global Z1;global Z2;
            mytimer=timer('StartDelay',1,'Period',2,'TasksToExecute',150,'ExecutionMode','fixedRate');
            mytimer.TimerFcn={@my_callback_fcn};
            Z1=0.1;Z2=0.1;

            