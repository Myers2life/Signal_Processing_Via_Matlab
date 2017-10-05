wp=0.2*pi;ws=0.35*pi;
tr_width=ws-wp;%���ɴ�
M=ceil(6.6*pi/tr_width)+1
n=[0:M];
wc=(ws+wp)/2;
hd=ideal_lp(wc,M+1);
w_ham=hamming(M+1);
b=fir1(M,wc/pi,w_ham);
h=hd.*w_ham';%�Ӵ�֮��ĳ����Ӧ
[db,mag,pha,grd,w]=freqz_m(b,[1]);
delta_w=2*pi/1000;
Rp=-(min(db(1:1:wp/delta_w+1)))
As=-round(max(db(ws/delta_w+1:1:500)))%��С�������
%�����ǻ�ͼ����
figure
subplot(2,2,1);stem(n,hd);title('��������Ӧ');
axis([0 M-1 -0.1 0.3]);xlabel('n');ylabel('hd(n)');grid on;
subplot(2,2,2);stem(n,h);title('ʵ�ʳ����Ӧ');
axis([0 M-1 -0.1 0.3]);xlabel('n');ylabel('h(n)');grid on;
subplot(2,2,3);plot([1:500]/500,pha);title('��λ��Ӧ');
ylabel('pha');grid on;
subplot(2,2,4);plot([1:500]/500,db);title('������Ӧ');
ylabel('decibels');grid on;xlabel('frequency in pi units');
axis([0 1 -100 10]);
%������ͨ�������ɴ�������ĵ�Ƶ�źţ��˲�����Ч��
nnn=0:1:60;%����Ĳ���һ����1=fs����Ϊ������˲���ʱ��T=1��
%����ȡ20��Ϊ��0.1*pi��Ƶ��ʱ��һ��������
cos1=cos(0.1*pi*nnn);%ͨ��
cos2=cos(0.25*pi*nnn);%���ɴ�
cos3=cos(0.5*pi*nnn);%���
a=1;%�±ߵĴ����Ǵ�IIR�˲����ǳ������ģ����Լ�a=1
Cos1=filter(b,[1],cos1);
Cos2=filter(b,a,cos2);
Cos3=filter(b,a,cos3);
figure
plot(nnn,cos1,'b');hold;plot(nnn,cos2,'r');plot(nnn,cos3,'g');
plot(nnn,Cos1,'b');plot(nnn,Cos2,'r');plot(nnn,Cos3,'g');
grid on
%������ò��ι۲������fft֮���Ƶ��ͼ�ǿ��ǵ���fft����Ƶ��й¶���۲첻����
%�����Ҳ��αȽϺù۲�
%�ϱ߻�����ͼ�����ӳٸ����Ŀȫ�ǰ���ľ�У�����ֻ����һ�����ڵģ���ʼ����Ϊ
%ȫ�˵����� ���ӵ�����ľ��
figure
stem(abs(fft(cos3)))
hold on;
title('���')
stem(abs(fft(Cos3)),'r')
figure
stem(abs(fft(cos2)))
title('����')
hold on;
stem(abs(fft(Cos2)),'r')
figure
stem(abs(fft(cos1)))
hold on;
stem(abs(fft(Cos1)),'r')
title('ͨ��')
%���ͨ���е������
clc
clear;
figure
hold on;
c=[0:25:250]/250
for M=10:5:60;
    
wp=0.2*pi;ws=0.35*pi;
tr_width=ws-wp;%���ɴ�
%M=ceil(6.6*pi/tr_width)+1
n=[0:M];
wc=(ws+wp)/2;
hd=ideal_lp(wc,M+1);
w_ham=hamming(M+1);
b=fir1(M,wc/pi,w_ham);
h=hd.*w_ham';%�Ӵ�֮��ĳ����Ӧ
[db,mag,pha,grd,w]=freqz_m(b,[1]);
N=(M-10)/5+1;
plot([1:500]/500,db,'color',[c(N),1-c(N),1-c(N)]);
% if N==1
%     legend('10��')
% else if N==11
%         legend('60��')
%     end
% end
%plot([1:500]/500,db,'color',[0.5,0.5,0.5]);
end
legend('10','15','20','25','30','35','40','45','50','55','60')
grid on;
title('������Ӧ');




