function hd = myhd(wc,M);
alpha = (M-1)/2;
n = 0:M-1;
m = n - alpha + eps;						%����һ������С�����������
hd = sin(wc*m) ./ (pi*m);					%�����������Ӧ

end

