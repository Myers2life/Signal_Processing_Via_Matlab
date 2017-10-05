%基础实验实验二程序
%1、写了DFT函数并验证其正确性
xx=1:8;
XXFFT=fft(xx);
subplot(2,1,1)
stem(abs(XXFFT))
XXDFT=DFT(xx);
subplot(2,1,2)
stem(abs(XXDFT))
%2、三角波和反三角波的时域和频域特性
figure
xcn=1:4;
xcn=[xcn,5-xcn];%三角波
xdn=4:-1:1;
xdn=[xdn,5-xdn];%反三角波
subplot(2,2,1)
title('三角波');
stem(xcn)
subplot(2,2,2)
stem(xdn)
title('反三角波');
subplot(2,2,3)
stem(abs(fft(xcn)))
subplot(2,2,4)
stem(abs(fft(xdn)))
%认为这个极性是不一样的，abs使然
figure
subplot(2,1,1)
stem(fft(xcn))
title('三角波');
subplot(2,1,2)
stem(fft(xdn))
title('反三角波');
%3、正弦信号频谱
cosFFT
%这是一个M文件，关于正弦信号的频谱
%4、FFT与DFT运行时间的比较
cosn5=cosdemo(64,0.00625);
tic
DFT(cosn5);
toc
tic
fft(cosn5);
toc
%5、卷积
%conv_fft是一个用FFT实现的卷积
n=0:14
xn=ones(1,15)
hn=(4/5).^n
covn_fft(xn,hn)


xn=ones(1,10);
     n=0:9;
     hn=0.5*sin(0.5*n);
covn_fft(xn,hn)


n=0:9;
xn=1-0.1*n;
hn=0.1*n;
covn_fft(xn,hn)



