%�˲���ָ��
wp=0.2*pi;
ws=0.3*pi;
Rp=1;
As=15;
%ģ���˲���ָ��
T=1;
OmegaP=(2/T)*tan(wp/2);
OmegaS=(2/T)*tan(ws/2);
%N=ceil((log10((10^(Rp/10)-1)/(10^(As/10)-1)))/(2*log10(OmegaP/OmegaS)))%ceil ���ȥ��
[N,Wn]=buttord(wp,ws,Rp,As,'s')

%���ְ�����˹�˲������
Wn=Wn/pi
[b,a]=butter(N,Wn)
%����Ϊֹ�������˲��������ɣ�b,a�ֱ��������˲�����ĸ���ӵ�ϵ��
[b0,B,A]=dir2cas(b,a)%�˺������˲�����Ϊ�����ͣ���һ���ⲿ������
%�ڱ�Ļ��������п�����Ϊû���������������Ӧ��ע�⵽
%��֤����ʱ��ԭ������һЩ���룬�������ӽ�����Ϊ���о�ȷ�ȵ�����
[db,mag,pha,grd,w]=freqz_m(b,a);
subplot(2,2,1);plot(w/pi,mag);
ylabel('����');xlabel('��/piΪ��λ��Ƶ��');
title('������Ӧ');grid;
axis([0 1 0 1]);
subplot(2,2,3);plot(w/pi,db);title('������ӦdB');grid;
xlabel('��/piΪ��λ��Ƶ��');ylabel('��������/dB');
axis([0 1 -60 10]);
subplot(2,2,2);plot(w/pi,pha);title('��λ��Ӧ'),grid;
axis([0,1 -4 4]);ylabel('��λ');xlabel('��/piΪ��λ��Ƶ��');
subplot(2,2,4);plot(w/pi,grd);title('Ⱥ�ӳ�');grid;
axis([0 1 0 15]);
xlabel('��/piΪ��λ��Ƶ��');ylabel('����');
%������ͨ�������ɴ�������ĵ�Ƶ�źţ��˲�����Ч��
nnn=0:1:20;%����Ĳ���һ����1=fs����Ϊ������˲���ʱ��T=1��
%����ȡ20��Ϊ��0.1*pi��Ƶ��ʱ��һ��������
cos1=cos(0.1*pi*nnn);%ͨ��
cos2=cos(0.25*pi*nnn);%���ɴ�
cos3=cos(0.5*pi*nnn);%���
Cos1=filter(b,a,cos1);
Cos2=filter(b,a,cos2);
Cos3=filter(b,a,cos3);figure
stem(abs(fft(cos3)))
figure
plot(nnn,cos1,'b');hold;plot(nnn,cos2,'r');plot(nnn,cos3,'g');
plot(nnn,Cos1,'b');plot(nnn,Cos2,'r');plot(nnn,Cos3,'g');
grid on
%������ò��ι۲������fft֮���Ƶ��ͼ�ǿ��ǵ���fft����Ƶ��й¶���۲첻����
%�����Ҳ��αȽϺù۲�

nnn=0:0.1:20;%�ı����Ƶ�ʣ��������˲�Ч����һ��
cos1=cos(0.1*pi*nnn);%ͨ��
cos2=cos(0.25*pi*nnn);%���ɴ�
cos3=cos(0.5*pi*nnn);%���
Cos1=filter(b,a,cos1);
Cos2=filter(b,a,cos2);
Cos3=filter(b,a,cos3);figure
stem(abs(fft(cos3)))
figure
plot(nnn,cos1,'b');hold;plot(nnn,cos2,'r');plot(nnn,cos3,'g');
plot(nnn,Cos1,'b');plot(nnn,Cos2,'r');plot(nnn,Cos3,'g');
grid on
