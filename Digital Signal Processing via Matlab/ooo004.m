wp=0.2*pi;ws=0.35*pi;
tr_width=ws-wp;%过渡带
M=ceil(6.6*pi/tr_width)+1
n=[0:M];
wc=(ws+wp)/2;
hd=ideal_lp(wc,M+1);
w_ham=hamming(M+1);
b=fir1(M,wc/pi,w_ham);
h=hd.*w_ham';%加窗之后的冲击响应
[db,mag,pha,grd,w]=freqz_m(b,[1]);
delta_w=2*pi/1000;
Rp=-(min(db(1:1:wp/delta_w+1)))
As=-round(max(db(ws/delta_w+1:1:500)))%最小阻带增益
%以下是画图程序
figure
subplot(2,2,1);stem(n,hd);title('理想冲击响应');
axis([0 M-1 -0.1 0.3]);xlabel('n');ylabel('hd(n)');grid on;
subplot(2,2,2);stem(n,h);title('实际冲击响应');
axis([0 M-1 -0.1 0.3]);xlabel('n');ylabel('h(n)');grid on;
subplot(2,2,3);plot([1:500]/500,pha);title('相位响应');
ylabel('pha');grid on;
subplot(2,2,4);plot([1:500]/500,db);title('幅度响应');
ylabel('decibels');grid on;xlabel('frequency in pi units');
axis([0 1 -100 10]);
%产生对通带、过渡带、阻带的单频信号，滤波，看效果
nnn=0:1:60;%这里的步长一定是1=fs，因为在设计滤波器时设T=1。
%至于取20是为了0.1*pi角频率时有一整个波形
cos1=cos(0.1*pi*nnn);%通带
cos2=cos(0.25*pi*nnn);%过渡带
cos3=cos(0.5*pi*nnn);%阻带
a=1;%下边的代码是从IIR滤波器那抄过来的，所以加a=1
Cos1=filter(b,[1],cos1);
Cos2=filter(b,a,cos2);
Cos3=filter(b,a,cos3);
figure
plot(nnn,cos1,'b');hold;plot(nnn,cos2,'r');plot(nnn,cos3,'g');
plot(nnn,Cos1,'b');plot(nnn,Cos2,'r');plot(nnn,Cos3,'g');
grid on
%这里采用波形观察而不是fft之后的频谱图是考虑到做fft后有频谱泄露，观察不明显
%而正弦波形比较好观察
%上边画出的图被相延迟搞得面目全非啊有木有，老子只画了一个周期的，开始还以为
%全滤掉了呢 ，坑爹啊有木有
figure
stem(abs(fft(cos3)))
hold on;
title('阻带')
stem(abs(fft(Cos3)),'r')
figure
stem(abs(fft(cos2)))
title('过渡')
hold on;
stem(abs(fft(Cos2)),'r')
figure
stem(abs(fft(cos1)))
hold on;
stem(abs(fft(Cos1)),'r')
title('通带')
%这个通带有点问题吧
clc
clear;
figure
hold on;
c=[0:25:250]/250
for M=10:5:60;
    
wp=0.2*pi;ws=0.35*pi;
tr_width=ws-wp;%过渡带
%M=ceil(6.6*pi/tr_width)+1
n=[0:M];
wc=(ws+wp)/2;
hd=ideal_lp(wc,M+1);
w_ham=hamming(M+1);
b=fir1(M,wc/pi,w_ham);
h=hd.*w_ham';%加窗之后的冲击响应
[db,mag,pha,grd,w]=freqz_m(b,[1]);
N=(M-10)/5+1;
plot([1:500]/500,db,'color',[c(N),1-c(N),1-c(N)]);
% if N==1
%     legend('10阶')
% else if N==11
%         legend('60阶')
%     end
% end
%plot([1:500]/500,db,'color',[0.5,0.5,0.5]);
end
legend('10','15','20','25','30','35','40','45','50','55','60')
grid on;
title('幅度响应');




