%信号分析
%% 第五章 信号时差域相关分析
%相关函数  inv(x(t)x(t-tao))/||x||*||y||
s=xcorr(y,'unbiased');%无偏
%% 第六章 幅值域分析
%概率密度，概率分布
%相片直方图分析   R,G,B    Gray=0.299R+0.587G+0.114B
n=histogram(Y);   %信号直方图
pdf=histogram(y)/length(y);
%概率密度  归一化
cdfplot  %画分布曲线
%直方图均衡 T()  把概率分布曲线改成直线
I=rgb2gray(inag);
J=histeq(I);