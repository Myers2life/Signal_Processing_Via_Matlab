
%%  ��ƹ���
wp1=0.3*pi;  ws1=0.35*pi;
wp2=0.5*pi;  ws2=0.55*pi;
N=50;
n=0:N-1;
wc1=(ws1+wp1)/2; wc2=(ws2+wp2)/2;		
hd=myhd(wc2,N)-myhd(wc1,N);			    %��������ͨ�ĳ����Ӧ

w_square=boxcar(N);						%�õ�����ΪM�ľ��δ�
h_square=hd .* w_square';				%���ô������ض�
w_ham=hamming(N);						%�õ�����ΪM�ĺ�����
h_ham=hd .* w_ham';						%���ô������ض�
w_tri=triang(N);						%�õ�����ΪM�����Ǵ�
h_tri=hd .* w_tri';						%���ô������ض�
w_bl=blackman(N);						%�õ�����ΪM��blackman��
h_bl=hd .* w_bl';						%���ô������ض�

[H_square,w1]=freqz(h_square,[1],1000,'whole');
mag_square=abs(H_square);                                             %����
db_square=20*log10((mag_square+eps)/max(mag_square));                 %����dBֵ
[H_ham,w2]=freqz(h_ham,[1],1000,'whole');
mag_ham=abs(H_ham);                                                   %����
db_ham=20*log10((mag_ham+eps)/max(mag_ham));                          %����dBֵ
[H_tri,w3]=freqz(h_tri,[1],1000,'whole');
mag_tri=abs(H_tri);                                                   %����
db_tri=20*log10((mag_tri+eps)/max(mag_tri));                          %����dBֵ
[H_bl,w4]=freqz(h_bl,[1],1000,'whole');
mag_bl=abs(H_bl);                                                     %����
db_bl=20*log10((mag_bl+eps)/max(mag_bl));                             %����dBֵ

% %% ��ͼ
% % ���������ȫչ��
% figure(1)
% subplot(2,2,1); stem(n,hd,'.'); title('��������Ӧ')
% axis([0 N-1 -0.3 0.4]); xlabel('n'); ylabel('hd(n)')
% subplot(2,2,2); stem(n,w_ham,'.');title('������')
% axis([0 N-1 0 1.1]); xlabel('n'); ylabel('w(n)')
% subplot(2,2,3); stem(n,h_ham,'.');title('ʵ�ʳ����Ӧ')
% axis([0 N-1 -0.3 0.4]); xlabel('n'); ylabel('h(n)')
% subplot(2,2,4); plot(w2/pi,db_ham);title('��Ƶ��Ӧ(dB)');
% axis([0 1 -100 10]); xlabel('f'); ylabel('dB')

%���ִ���ƱȽ�
figure(2)
subplot(2,2,1); plot(w1/pi,db_square);title('���δ�  ��Ƶ��Ӧ(dB)');
axis([0 1 -100 10]); xlabel('f'); ylabel('dB')
subplot(2,2,2); plot(w2/pi,db_ham);title('������  ��Ƶ��Ӧ(dB)');
axis([0 1 -100 10]); xlabel('f'); ylabel('dB')
subplot(2,2,3); plot(w3/pi,db_tri);title('���Ǵ�  ��Ƶ��Ӧ(dB)');
axis([0 1 -100 10]); xlabel('f'); ylabel('dB')
subplot(2,2,4); plot(w4/pi,db_bl);title('blackman��  ��Ƶ��Ӧ(dB)');
axis([0 1 -100 10]); xlabel('f'); ylabel('dB')



