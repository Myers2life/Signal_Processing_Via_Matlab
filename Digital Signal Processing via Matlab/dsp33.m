% DSP.3.3
% Shuyuan Li 
% Sept. 23, 2013

%% 双线性变换法
%  设计
wp=0.2*pi;
ws=0.3*pi;
Fs=1;T=1/Fs; 
OmegaP=(2/T)*tan(wp/2);
OmegaS=(2/T)*tan(ws/2);
rp=1;rs=15;as=15;
ripple=10^(-rp/20);attn=10^(-rs/20);
[n,wn]=buttord(OmegaP,OmegaS,rp,rs,'s');
[z,p,k]=buttap(n);
[b,a]=zp2tf(z,p,k);
[bt,at]=lp2lp(b,a,wn);
[b,a]=bilinear(bt,at,Fs);
[H,w]=freqz(b,a,1000,'whole');
mag=abs(H);
db=20*log10((mag+eps)/max(mag));
pha=angle(H);

%  绘图
figure(1)

subplot(3,1,1);
plot(w/pi,mag);title('双线性变换法    Magnitude Frequency幅频特性');
xlabel('w(/pi)');ylabel('|H(jw)|');
axis([0,1,0,1.1]);
set(gca,'XTickMode','manual','XTick',[0 0.2 0.3 1]);
set(gca,'YTickMode','manual','YTick',[0 attn ripple 1]);grid

subplot(3,1,2);plot(w/pi,db);title('Magnitude Frequency幅频特性(db)');
xlabel('w(/pi)');ylabel('dB');
axis([0,1,-30,5]);
set(gca,'XTickMode','manual','XTick',[0 0.2 0.3 1]);
set(gca,'YTickMode','manual','YTick',[-60 -as -rp 0]);grid

subplot(3,1,3);plot(w/pi,pha/pi);title('Phase Frequency相频特性');
xlabel('w(/pi)');ylabel('pha(/pi)');
axis([0,1,-1,1]);
set(gca,'XTickMode','manual','XTick',[0 0.2 0.3 1]);grid


%%  冲击响应不变法
%  设计
wp=0.2*pi;
ws=0.3*pi;
Fs=1;T=1/Fs; 
OmegaP=(2/T)*tan(wp/2);
OmegaS=(2/T)*tan(ws/2);
rp=1;rs=15;as=15;
ripple=10^(-rp/20);attn=10^(-rs/20);
[n,wn]=buttord(OmegaP,OmegaS,rp,rs,'s');
[cs,ds]=butter(n,wn,'s');
[b,a]=impinvar(cs,ds,T);   
[H,w]=freqz(b,a,1000,'whole');
mag=abs(H);
db=20*log10((mag+eps)/max(mag));
pha=angle(H);

%  绘图
figure(2)
subplot(3,1,1);
plot(w/pi,mag);title('冲击响应不变法    Magnitude Frequency幅频特性');
xlabel('w(/pi)');ylabel('|H(jw)|');
axis([0,1,0,1.1]);
set(gca,'XTickMode','manual','XTick',[0 0.2 0.3 1]);
set(gca,'YTickMode','manual','YTick',[0 attn ripple 1]);grid

subplot(3,1,2);plot(w/pi,db);title('Magnitude Frequency幅频特性(db)');
xlabel('w(/pi)');ylabel('dB');
axis([0,1,-30,5]);
set(gca,'XTickMode','manual','XTick',[0 0.2 0.3 1]);
set(gca,'YTickMode','manual','YTick',[-60 -as -rp 0]);grid

subplot(3,1,3);plot(w/pi,pha/pi);title('Phase Frequency相频特性');
xlabel('w(/pi)');ylabel('pha(/pi)');
axis([0,1,-1,1]);
set(gca,'XTickMode','manual','XTick',[0 0.2 0.3 1]);grid
