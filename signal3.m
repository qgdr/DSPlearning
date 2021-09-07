%第三章 信号时域分析
%% 波形分析
%示波器
%正弦波  过零检测
%max  min  mean   RMS(有效值)  std(标准差)
%微分信号，积分信号
%%  从摄像头获取图像
vid=videoinput('winvideo',1,'YUY2_640x480');
set(vid,'ReturnedColorSpace','rgb');
preview(vid);
%start(vid);
pause(5);
closepreview(vid);
stop(vid);
delete(vid);
%preview(vid);
%% 调用图像文件
[FileName,PathName]=uigetfile('*.jpg','Select Jpg File');
abc=fullfile(PathName,FileName);
I=imread(abc);
subplot 131;imshow(I);
I1=rgb2gray(I);
subplot 132;imshow(I1);
BW2=edge(I1,'Sobel');%Prewitt,Roberts
subplot 133;imshow(BW2);
%imcrop(file,[position])放置图片之上

