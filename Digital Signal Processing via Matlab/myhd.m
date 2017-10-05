function hd = myhd(wc,M);
alpha = (M-1)/2;
n = 0:M-1;
m = n - alpha + eps;						%加入一个无穷小量，避免除零
hd = sin(wc*m) ./ (pi*m);					%求得理想冲击响应

end

