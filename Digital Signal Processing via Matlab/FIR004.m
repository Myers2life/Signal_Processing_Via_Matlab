wp=0.2*pi;ws=0.5*pi;
tr_width=ws-wp;%过渡带
M=ceil(6.6*pi/tr_width)+1
n=[0:M];
wc=(ws+wp)/2;
hd=ideal_lp(wc,M+1);
w_ham=hamming(M+1);
b=fir1(M,wc/pi,w_ham);
h=hd.*w_ham';%加窗之后的冲击响应
[db,mag,pha,grd,w]=freqz_m(b,[1]);
delta_w=2*pi/1000;
Rp=-(min(db(1:1:wp/delta_w+1)))
As=-round(max(db(ws/delta_w+1:1:500)))%最小阻带增益
%以下是画图程序
subplot(2,2,4);plot([1:500]/500,db);title('幅度响应');
ylabel('decibels');grid on;xlabel('frequency in pi units');
axis([0 1 -100 10]);