%�����˲���ָ��
 wp=0.2*pi;ws=0.3*pi;Rp=1.5;As=25;
 %ת����ģ����ָ��
T=1;Fs=1/T;
omegap=(2/T)*tan(wp/2);
omegas=(2/T)*tan(ws/2);
%ģ�������˹�˲����ļ���
[cs,ds]=afd_buttap(omegap,omegas,Rp,As);
%˫���Ա任
[b,a]=bilinear(cs,ds,Fs);
[C,B,A]=dir2cas(b,a)
[db,mag,pha,grd,w]=freqz_m(b,a);
subplot(2,2,1);plot(w/pi,mag);
ylabel('����');xlabel('��/piΪ��λ��Ƶ��');
title('������Ӧ');grid;
axis([0,0.8 0 1]);
subplot(2,2,3);plot(w/pi,db);title('������ӦdB');grid;
xlabel('��/piΪ��λ��Ƶ��');ylabel('��������/dB');
axis([0 0.8 -60 10]);
subplot(2,2,2);plot(w/pi,pha);title('��λ��Ӧ'),grid;
axis([0,0.8 -4 4]);ylabel('��λ');xlabel('��/piΪ��λ��Ƶ��');
subplot(2,2,4);plot(w/pi,grd);title('Ⱥ�ӳ�');grid;
axis([0 0.8 0 15]);
xlabel('��/piΪ��λ��Ƶ��');ylabel('����');