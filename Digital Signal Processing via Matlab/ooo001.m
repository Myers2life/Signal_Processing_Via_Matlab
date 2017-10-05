
b=[0.0181,0.0543,0.0543,0.0181];
a=[1.000,-1.76,1.1829,-0.2781];
A=[1 1 1] ;B=[1];
a=A;b=B;
impz(b,a);
figure
zplane(b,a)
title('零极点分布图')
legend('零点','极点')
figure;
k=512;
w=0:pi/k,pi;
w=0:pi/k:pi;
h=freqz(b,a,w);
subplot(2,1,1);plot(w/pi,abs(h))
subplot(2,1,2);
plot(w/pi,angle(h))

num1=0:9;
num2=0:9;
num3=conv(num1,num2);
figure;
plot(num3)
stem(num3)