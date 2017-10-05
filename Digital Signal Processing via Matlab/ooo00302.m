%模拟滤波器指标
fp=0.2*1000;
Rp=1;
fs=300;
As=25;
T=0.001;%T=1ms
Fs=1/T;
%模拟滤波器原型设计
[cs,ds]=afd_butt(fp*2*pi,fs*2*pi,Rp,As);
%先采用冲击响应不变法
%[b,a]=imp_invr(cs,ds,Ts)%此函数为自定义函数，写的有点问题，据说impinvar可代替之
[b,a]=impinvar(cs,ds,Fs);
%采用双线性变换法
[b2,a2]=bilinear(cs,ds,Fs)
mag=freqz(b,a);

figure;
[db,mag,pha,grd,w]=freqz_m(b,a);
plot(w/pi,mag);
ylabel('幅度');xlabel('以/pi为单位的频率');title('幅度响应');
[db2,mag2,pha2,grd2,w2]=freqz_m(b2,a2);
hold on;grid on;
plot(w2/pi,mag2,'r');
legend('冲击响应不变法','双线性变换法')

figure
plot((0:length(db)-1)/length(db),db);
grid on;hold on;
plot((0:length(db2)-1)/length(db2),db2,'r');
legend('冲击响应不变法','双线性变换法')
axis([0 1 -50 0])
line([0.3571 0.3571],[-50 0])
%图上，0.4*pi时，双线性变换法设计的滤波器其衰减为6db左右
%在数字域的频率，wp=0.4*pi ， ws=0.6*pi(对冲击响应不变法来说罢)
%在双线性变换法中，数字域和时域非线性关系，结果可能不一样
%按理说不对啊这个结果……
%到cs、ds模拟滤波器设计。结果还是正确的
%冲击响应不变法产生的滤波器是符合要求的
%双线性变换法产生的不对
%验证如下
figure
t=0:T:0.05;
y=cos(200*pi*t);
Y=filter(b2,a2,y)
plot(t,Y);
Y2=filter(b,a,y)
hold on;grid on;
plot(t,Y2)
%经验证，他们对200Hz信号滤波效果是一样的……
%不懂
%是不是双线性变换法数字域与频域对应关系与前边的有所不同?
%是因为存在一个预畸变的过程？
%大概是这个样子的额
% 2*atan(200*2*pi/(2/T))/pi=0.3571
%而在0.3571这个点，刚好可以满足Rp=1的要求



