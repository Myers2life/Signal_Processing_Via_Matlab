function xn3=covn_fft(xn1,xn2)
M=length(xn1);
N=length(xn2);
xn1=[xn1,zeros(1,N-1)];
xn2=[xn2,zeros(1,M-1)];
Xn1=fft(xn1);
Xn2=fft(xn2);
Xn3=Xn1.*Xn2;%要注意到这里是点乘
xn3=ifft(Xn3);


