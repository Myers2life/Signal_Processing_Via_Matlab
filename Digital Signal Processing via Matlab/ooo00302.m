%ģ���˲���ָ��
fp=0.2*1000;
Rp=1;
fs=300;
As=25;
T=0.001;%T=1ms
Fs=1/T;
%ģ���˲���ԭ�����
[cs,ds]=afd_butt(fp*2*pi,fs*2*pi,Rp,As);
%�Ȳ��ó����Ӧ���䷨
%[b,a]=imp_invr(cs,ds,Ts)%�˺���Ϊ�Զ��庯����д���е����⣬��˵impinvar�ɴ���֮
[b,a]=impinvar(cs,ds,Fs);
%����˫���Ա任��
[b2,a2]=bilinear(cs,ds,Fs)
mag=freqz(b,a);

figure;
[db,mag,pha,grd,w]=freqz_m(b,a);
plot(w/pi,mag);
ylabel('����');xlabel('��/piΪ��λ��Ƶ��');title('������Ӧ');
[db2,mag2,pha2,grd2,w2]=freqz_m(b2,a2);
hold on;grid on;
plot(w2/pi,mag2,'r');
legend('�����Ӧ���䷨','˫���Ա任��')

figure
plot((0:length(db)-1)/length(db),db);
grid on;hold on;
plot((0:length(db2)-1)/length(db2),db2,'r');
legend('�����Ӧ���䷨','˫���Ա任��')
axis([0 1 -50 0])
line([0.3571 0.3571],[-50 0])
%ͼ�ϣ�0.4*piʱ��˫���Ա任����Ƶ��˲�����˥��Ϊ6db����
%���������Ƶ�ʣ�wp=0.4*pi �� ws=0.6*pi(�Գ����Ӧ���䷨��˵��)
%��˫���Ա任���У��������ʱ������Թ�ϵ��������ܲ�һ��
%����˵���԰�����������
%��cs��dsģ���˲�����ơ����������ȷ��
%�����Ӧ���䷨�������˲����Ƿ���Ҫ���
%˫���Ա任�������Ĳ���
%��֤����
figure
t=0:T:0.05;
y=cos(200*pi*t);
Y=filter(b2,a2,y)
plot(t,Y);
Y2=filter(b,a,y)
hold on;grid on;
plot(t,Y2)
%����֤�����Ƕ�200Hz�ź��˲�Ч����һ���ġ���
%����
%�ǲ���˫���Ա任����������Ƶ���Ӧ��ϵ��ǰ�ߵ�������ͬ?
%����Ϊ����һ��Ԥ����Ĺ��̣�
%�����������ӵĶ�
% 2*atan(200*2*pi/(2/T))/pi=0.3571
%����0.3571����㣬�պÿ�������Rp=1��Ҫ��



