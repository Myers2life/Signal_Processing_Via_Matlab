%����ʵ��ʵ�������
%1��д��DFT��������֤����ȷ��
xx=1:8;
XXFFT=fft(xx);
subplot(2,1,1)
stem(abs(XXFFT))
XXDFT=DFT(xx);
subplot(2,1,2)
stem(abs(XXDFT))
%2�����ǲ��ͷ����ǲ���ʱ���Ƶ������
figure
xcn=1:4;
xcn=[xcn,5-xcn];%���ǲ�
xdn=4:-1:1;
xdn=[xdn,5-xdn];%�����ǲ�
subplot(2,2,1)
title('���ǲ�');
stem(xcn)
subplot(2,2,2)
stem(xdn)
title('�����ǲ�');
subplot(2,2,3)
stem(abs(fft(xcn)))
subplot(2,2,4)
stem(abs(fft(xdn)))
%��Ϊ��������ǲ�һ���ģ�absʹȻ
figure
subplot(2,1,1)
stem(fft(xcn))
title('���ǲ�');
subplot(2,1,2)
stem(fft(xdn))
title('�����ǲ�');
%3�������ź�Ƶ��
cosFFT
%����һ��M�ļ������������źŵ�Ƶ��
%4��FFT��DFT����ʱ��ıȽ�
cosn5=cosdemo(64,0.00625);
tic
DFT(cosn5);
toc
tic
fft(cosn5);
toc
%5�����
%conv_fft��һ����FFTʵ�ֵľ��
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



