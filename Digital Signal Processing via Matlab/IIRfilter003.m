%数字滤波器指标
 wp=0.2*pi;ws=0.3*pi;Rp=1.5;As=25;
 %转换成模拟域指标
T=1;Fs=1/T;
omegap=(2/T)*tan(wp/2);
omegas=(2/T)*tan(ws/2);
%模拟巴特沃斯滤波器的计算
[cs,ds]=afd_buttap(omegap,omegas,Rp,As);
%双线性变换
[b,a]=bilinear(cs,ds,Fs);
[C,B,A]=dir2cas(b,a)
[db,mag,pha,grd,w]=freqz_m(b,a);
subplot(2,2,1);plot(w/pi,mag);
ylabel('幅度');xlabel('以/pi为单位的频率');
title('幅度响应');grid;
axis([0,0.8 0 1]);
subplot(2,2,3);plot(w/pi,db);title('幅度响应dB');grid;
xlabel('以/pi为单位的频率');ylabel('对数幅度/dB');
axis([0 0.8 -60 10]);
subplot(2,2,2);plot(w/pi,pha);title('相位响应'),grid;
axis([0,0.8 -4 4]);ylabel('相位');xlabel('以/pi为单位的频率');
subplot(2,2,4);plot(w/pi,grd);title('群延迟');grid;
axis([0 0.8 0 15]);
xlabel('以/pi为单位的频率');ylabel('样本');