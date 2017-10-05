function [b,a]=afd_butt(Wp,Ws,Rp,As);
% Analog Lowpass Filter Design: Butterworth
%模拟低通滤波器设计：巴特沃斯型
%————————————————————————
%[b,a]分别是H(s)的分母分子的系数
if Wp<=0
    error('Passband edge must be larger than 0')
end
if Ws<=Wp
    error('Stopband edge must be larger than Passband edge')
end
N=ceil((log10((10^(Rp/10)-1)/(10^(As/10)-1)))/(2*log10(Wp/Ws)));%ceil 向大取整
fprintf('\n*** Butterworth Filter Order = %2.0f \n',N)
OmegaC=Wp/((10^(Rp/10)-1)^(1/(2*N)));
[b,a]=u_buttap(N,OmegaC);%调用自定义函数产生直接型巴特沃斯滤波器