function pr1()
%11差分方程
a=[1,-1,0.9];
b=1;
x=impseq(0,-20,120);%冲激序列
n=-20:120;
h=filter(b,a,x);%求X的冲激响应

end

