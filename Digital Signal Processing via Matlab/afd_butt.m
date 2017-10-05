function [b,a]=afd_butt(Wp,Ws,Rp,As);
% Analog Lowpass Filter Design: Butterworth
%ģ���ͨ�˲�����ƣ�������˹��
%������������������������������������������������
%[b,a]�ֱ���H(s)�ķ�ĸ���ӵ�ϵ��
if Wp<=0
    error('Passband edge must be larger than 0')
end
if Ws<=Wp
    error('Stopband edge must be larger than Passband edge')
end
N=ceil((log10((10^(Rp/10)-1)/(10^(As/10)-1)))/(2*log10(Wp/Ws)));%ceil ���ȡ��
fprintf('\n*** Butterworth Filter Order = %2.0f \n',N)
OmegaC=Wp/((10^(Rp/10)-1)^(1/(2*N)));
[b,a]=u_buttap(N,OmegaC);%�����Զ��庯������ֱ���Ͱ�����˹�˲���