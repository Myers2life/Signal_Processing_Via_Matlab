function x=f2t(X)

global dt df t f T N

%x=f2t(X)

%xΪʱ���ȡ��ֵʸ��

%XΪx�ĸ��ϱ任

%X��x������ͬ��Ϊ2������

%��������Ҫһ��ȫ�ֱ���dt(ʱ��ȡ�����)

X=[X(N/2+1:N),X(1:N/2)];

x=ifft(X)/dt;