function V_a_f=filter_for_lastone(V,FFSS)
%�˲���ָ��
wp=0.01*pi;
ws=0.05*pi;
Rp=1;
As=15;
%ģ���˲���ָ��
T=1/FFSS;
OmegaP=(2/T)*tan(wp/2);
OmegaS=(2/T)*tan(ws/2);
%N=ceil((log10((10^(Rp/10)-1)/(10^(As/10)-1)))/(2*log10(OmegaP/OmegaS)))%ceil ���ȥ��
[N,Wn]=buttord(wp,ws,Rp,As,'s');

%���ְ�����˹�˲������
Wn=Wn/pi
[b,a]=butter(N,Wn);
%����Ϊֹ�������˲��������ɣ�b,a�ֱ��������˲�����ĸ���ӵ�ϵ��
V_a_f=filter(b,a,V);