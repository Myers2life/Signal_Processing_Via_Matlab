%滤波器指标
wp=0.2*pi;
ws=0.3*pi;
Rp=1;
As=15;
%模拟滤波器指标
T=1;
OmegaP=(2/T)*tan(wp/2);
OmegaS=(2/T)*tan(ws/2);
N=ceil((log10((10^(Rp/10)-1)/(10^(As/10)-1)))/(2*log10(OmegaP/OmegaS)));%ceil 向大去整
fprintf('\n*** Butterworth Filter Order =%2.0f\n',N)
OmegaC=OmegaP/((10^(Rp/10)-1)^(1/(2*N)));%截止频率
wn=2*atan((OmegaC*T)/2);
[b,a]=butter(N,wn)
[b0,B,A]=dir2cas(b,a)
