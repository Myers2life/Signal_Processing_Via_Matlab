%本设计用到的M文件函数
function[db,mag,pha,grd,w]=freqz_m(b,a)
%滤波器幅值响应（绝对、相对）、相位响应及群延迟
%Usage:[db,mag,pha,grd,w]=freqz_m(b,a)         %500点对应[0,pi]
%db 相对幅值响应； mag 绝对幅值响应； pha 相位响应； grd 群延迟响应；
%w 采样频率； b 系统函数H(z)的分子项
%a 系统函数H(z)的分母项
[H,w]=freqz(b,a,500);          %500点的幅频响应
mag=abs(H);
db=20*log10(mag/max(mag));
pha=angle(H);
grd=grpdelay(b,a,w);
