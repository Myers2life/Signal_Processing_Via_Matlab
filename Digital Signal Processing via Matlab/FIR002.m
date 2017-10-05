%%第一题、通带截止频率为0.2pi,阻带截止频率为0.3pi，阻带衰减不小于50dB，通带衰减不大于3dB，设计一个FIR滤波器，并验证。
wp=0.2*pi; ws=0.3*pi;    %性能指标
wdelta=ws-wp;           %过渡带宽度
M=ceil(3.32*pi/wdelta);  %滤波器长度，朝正无穷方向舍入
N=2*M+1;               %窗口长度
wc=(ws+wp)/2;           %截止频率
win=hamming(N);        %因为衰减不小于50dB，所以选择海明窗，这里得到海明窗的时域响应
b=fir1(N-1,wc/pi,win);
n=0:1:N;
[hi t]=impz(b,1,n);%得到脉冲响应
[hf w]=freqz(b,1,512);  %得到频率响应

figure(1);
subplot(3,1,1); stem(n,hi);
xlabel('n'); ylabel('Magnitude'); title('impulse response');
subplot(3,1,2); plot(w/pi,20*log10(abs(hf)));
xlabel('Frequency(Hz)'); ylabel('Magnitude(dB)');
title('Frequency response');
subplot(3,1,3); plot(w/pi,180/pi*unwrap(angle(hf)));
xlabel('Frequency(Hz)'); ylabel('Phase(degrees)');
title('Frequency response');
%验证：
nn=0:50;
x1=sin(nn*0.2*pi); x2=sin(nn*0.8*pi);%假设两个信号，低频和高频
in=x1+x2; out=filter(b,1,in); %滤波过程

figure(2);
subplot(2,2,1); stem(x1);
xlabel('n'); ylabel('Magnitude');
title('x1'); axis([0 50 -1 1]);
subplot(2,2,2); stem(x2);
xlabel('n'); ylabel('Magnitude');
title('x2'); axis([0 50 -1 1]);
subplot(2,2,3); stem(in);
xlabel('n'); ylabel('Magnitude');
title('x1+x2 before filter'); axis([0 50 -2 2]);
subplot(2,2,4); stem(out);
xlabel('n'); ylabel('Magnitude');
title('x1+x2 after filter'); axis([0 50 -1 1]);
%在这题要主要的是求分贝的公式：20*log10(abs(hf)),还有解卷绕函数的调用180/pi*unwrap(angle(hf))。
%从上面的程序可以得到图：