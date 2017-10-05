%滤波器指标
wp=0.2*pi;
ws=0.3*pi;
Rp=1;
As=15;
%模拟滤波器指标
T=1;
OmegaP=(2/T)*tan(wp/2);
OmegaS=(2/T)*tan(ws/2);
%N=ceil((log10((10^(Rp/10)-1)/(10^(As/10)-1)))/(2*log10(OmegaP/OmegaS)))%ceil 向大去整
[N,Wn]=buttord(wp,ws,Rp,As,'s')

%数字巴特沃斯滤波器设计
Wn=Wn/pi
[b,a]=butter(N,Wn)
%到此为止，数字滤波器设计完成，b,a分别是数字滤波器分母分子的系数
[b0,B,A]=dir2cas(b,a)%此函数将滤波器变为级联型，是一个外部函数，
%在别的机器上运行可能因为没有这个函数而出错，应该注意到
%验证运行时和原书结果有一些出入，但基本接近，认为是有精确度的问题
[db,mag,pha,grd,w]=freqz_m(b,a);
subplot(2,2,1);plot(w/pi,mag);
ylabel('幅度');xlabel('以/pi为单位的频率');
title('幅度响应');grid;
axis([0 1 0 1]);
subplot(2,2,3);plot(w/pi,db);title('幅度响应dB');grid;
xlabel('以/pi为单位的频率');ylabel('对数幅度/dB');
axis([0 1 -60 10]);
subplot(2,2,2);plot(w/pi,pha);title('相位响应'),grid;
axis([0,1 -4 4]);ylabel('相位');xlabel('以/pi为单位的频率');
subplot(2,2,4);plot(w/pi,grd);title('群延迟');grid;
axis([0 1 0 15]);
xlabel('以/pi为单位的频率');ylabel('样本');
%产生对通带、过渡带、阻带的单频信号，滤波，看效果
nnn=0:1:20;%这里的步长一定是1=fs，因为在设计滤波器时设T=1。
%至于取20是为了0.1*pi角频率时有一整个波形
cos1=cos(0.1*pi*nnn);%通带
cos2=cos(0.25*pi*nnn);%过渡带
cos3=cos(0.5*pi*nnn);%阻带
Cos1=filter(b,a,cos1);
Cos2=filter(b,a,cos2);
Cos3=filter(b,a,cos3);figure
stem(abs(fft(cos3)))
figure
plot(nnn,cos1,'b');hold;plot(nnn,cos2,'r');plot(nnn,cos3,'g');
plot(nnn,Cos1,'b');plot(nnn,Cos2,'r');plot(nnn,Cos3,'g');
grid on
%这里采用波形观察而不是fft之后的频谱图是考虑到做fft后有频谱泄露，观察不明显
%而正弦波形比较好观察

nnn=0:0.1:20;%改变抽样频率，将看到滤波效果不一样
cos1=cos(0.1*pi*nnn);%通带
cos2=cos(0.25*pi*nnn);%过渡带
cos3=cos(0.5*pi*nnn);%阻带
Cos1=filter(b,a,cos1);
Cos2=filter(b,a,cos2);
Cos3=filter(b,a,cos3);figure
stem(abs(fft(cos3)))
figure
plot(nnn,cos1,'b');hold;plot(nnn,cos2,'r');plot(nnn,cos3,'g');
plot(nnn,Cos1,'b');plot(nnn,Cos2,'r');plot(nnn,Cos3,'g');
grid on
