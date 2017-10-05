function V_a_f=filter_for_lastone(V,FFSS)
%滤波器指标
wp=0.01*pi;
ws=0.05*pi;
Rp=1;
As=15;
%模拟滤波器指标
T=1/FFSS;
OmegaP=(2/T)*tan(wp/2);
OmegaS=(2/T)*tan(ws/2);
%N=ceil((log10((10^(Rp/10)-1)/(10^(As/10)-1)))/(2*log10(OmegaP/OmegaS)))%ceil 向大去整
[N,Wn]=buttord(wp,ws,Rp,As,'s');

%数字巴特沃斯滤波器设计
Wn=Wn/pi
[b,a]=butter(N,Wn);
%到此为止，数字滤波器设计完成，b,a分别是数字滤波器分母分子的系数
V_a_f=filter(b,a,V);