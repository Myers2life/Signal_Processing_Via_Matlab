function X=t2f(x)

global dt df N t f T

%X=t2f(x)

%xΪʱ���ȡ��ֵʸ��

%XΪx�ĸ��ϱ任

%X��x������ͬ,��Ϊ2�����ݡ���

%��������Ҫһ��ȫ�ֱ���dt(ʱ��ȡ�����)

H=fft(x);

X=[H(N/2+1:N),H(1:N/2)]*dt;