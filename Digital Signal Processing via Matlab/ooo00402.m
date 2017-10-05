
%%  设计过程
wp1=0.3*pi;  ws1=0.35*pi;
wp2=0.5*pi;  ws2=0.55*pi;
N=50;
n=0:N-1;
wc1=(ws1+wp1)/2; wc2=(ws2+wp2)/2;		
hd=myhd(wc2,N)-myhd(wc1,N);			    %求得理想带通的冲击响应

w_square=boxcar(N);						%得到长度为M的矩形窗
h_square=hd .* w_square';				%利用窗函数截短
w_ham=hamming(N);						%得到长度为M的汉明窗
h_ham=hd .* w_ham';						%利用窗函数截短
w_tri=triang(N);						%得到长度为M的三角窗
h_tri=hd .* w_tri';						%利用窗函数截短
w_bl=blackman(N);						%得到长度为M的blackman窗
h_bl=hd .* w_bl';						%利用窗函数截短

[H_square,w1]=freqz(h_square,[1],1000,'whole');
mag_square=abs(H_square);                                             %幅度
db_square=20*log10((mag_square+eps)/max(mag_square));                 %幅度dB值
[H_ham,w2]=freqz(h_ham,[1],1000,'whole');
mag_ham=abs(H_ham);                                                   %幅度
db_ham=20*log10((mag_ham+eps)/max(mag_ham));                          %幅度dB值
[H_tri,w3]=freqz(h_tri,[1],1000,'whole');
mag_tri=abs(H_tri);                                                   %幅度
db_tri=20*log10((mag_tri+eps)/max(mag_tri));                          %幅度dB值
[H_bl,w4]=freqz(h_bl,[1],1000,'whole');
mag_bl=abs(H_bl);                                                     %幅度
db_bl=20*log10((mag_bl+eps)/max(mag_bl));                             %幅度dB值

% %% 绘图
% % 汉明窗设计全展现
% figure(1)
% subplot(2,2,1); stem(n,hd,'.'); title('理想冲击响应')
% axis([0 N-1 -0.3 0.4]); xlabel('n'); ylabel('hd(n)')
% subplot(2,2,2); stem(n,w_ham,'.');title('汉明窗')
% axis([0 N-1 0 1.1]); xlabel('n'); ylabel('w(n)')
% subplot(2,2,3); stem(n,h_ham,'.');title('实际冲击响应')
% axis([0 N-1 -0.3 0.4]); xlabel('n'); ylabel('h(n)')
% subplot(2,2,4); plot(w2/pi,db_ham);title('幅频响应(dB)');
% axis([0 1 -100 10]); xlabel('f'); ylabel('dB')

%各种窗设计比较
figure(2)
subplot(2,2,1); plot(w1/pi,db_square);title('矩形窗  幅频响应(dB)');
axis([0 1 -100 10]); xlabel('f'); ylabel('dB')
subplot(2,2,2); plot(w2/pi,db_ham);title('汉明窗  幅频响应(dB)');
axis([0 1 -100 10]); xlabel('f'); ylabel('dB')
subplot(2,2,3); plot(w3/pi,db_tri);title('三角窗  幅频响应(dB)');
axis([0 1 -100 10]); xlabel('f'); ylabel('dB')
subplot(2,2,4); plot(w4/pi,db_bl);title('blackman窗  幅频响应(dB)');
axis([0 1 -100 10]); xlabel('f'); ylabel('dB')



