function x=f2t(X)

global dt df t f T N

%x=f2t(X)

%x为时域的取样值矢量

%X为x的傅氏变换

%X与x长度相同并为2的整幂

%本函数需要一个全局变量dt(时域取样间隔)

X=[X(N/2+1:N),X(1:N/2)];

x=ifft(X)/dt;