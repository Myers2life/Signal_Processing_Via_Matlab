%%��һ�⡢ͨ����ֹƵ��Ϊ0.2pi,�����ֹƵ��Ϊ0.3pi�����˥����С��50dB��ͨ��˥��������3dB�����һ��FIR�˲���������֤��
wp=0.2*pi; ws=0.3*pi;    %����ָ��
wdelta=ws-wp;           %���ɴ����
M=ceil(3.32*pi/wdelta);  %�˲������ȣ��������������
N=2*M+1;               %���ڳ���
wc=(ws+wp)/2;           %��ֹƵ��
win=hamming(N);        %��Ϊ˥����С��50dB������ѡ������������õ���������ʱ����Ӧ
b=fir1(N-1,wc/pi,win);
n=0:1:N;
[hi t]=impz(b,1,n);%�õ�������Ӧ
[hf w]=freqz(b,1,512);  %�õ�Ƶ����Ӧ

figure(1);
subplot(3,1,1); stem(n,hi);
xlabel('n'); ylabel('Magnitude'); title('impulse response');
subplot(3,1,2); plot(w/pi,20*log10(abs(hf)));
xlabel('Frequency(Hz)'); ylabel('Magnitude(dB)');
title('Frequency response');
subplot(3,1,3); plot(w/pi,180/pi*unwrap(angle(hf)));
xlabel('Frequency(Hz)'); ylabel('Phase(degrees)');
title('Frequency response');
%��֤��
nn=0:50;
x1=sin(nn*0.2*pi); x2=sin(nn*0.8*pi);%���������źţ���Ƶ�͸�Ƶ
in=x1+x2; out=filter(b,1,in); %�˲�����

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
%������Ҫ��Ҫ������ֱ��Ĺ�ʽ��20*log10(abs(hf)),���н���ƺ����ĵ���180/pi*unwrap(angle(hf))��
%������ĳ�����Եõ�ͼ��