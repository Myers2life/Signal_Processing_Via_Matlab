function X=t2f(x)

global dt df N t f T

%X=t2f(x)

%x为时域的取样值矢量

%X为x的傅氏变换

%X与x长度相同,并为2的整幂。　

%本函数需要一个全局变量dt(时域取样间隔)

H=fft(x);

X=[H(N/2+1:N),H(1:N/2)]*dt;