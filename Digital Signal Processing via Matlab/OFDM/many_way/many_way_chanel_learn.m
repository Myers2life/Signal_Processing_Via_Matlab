global dt t f df N T
close all
clear Eb_N0 Pe
k=input('取样点数＝2^k, k取13左右');
if isempty(k), k=13; end
z=input('每个信号取样点数＝2^z, z<k');
if isempty(z), z=3; end
aa=input('滚降系数=[0.5]');
if aa==[],aa=0.5;end
N=2^k;
L=2^z;M=N/L;
Rb=2; %码速率是2Mb/s
Ts=1/Rb; %码元间隔
dt=Ts/L; %时域采样间隔
df=1/(N*dt); %频域采样间隔
T=N*dt; %截短时间
Bs=N*df/2; %系统带宽
f=[-Bs+df/2:df:Bs]; %频域横坐标
t=[-T/2+dt/2:dt:T/2]; %时域横坐标
g=sin(pi*t/Ts).*cos(pi*t*aa/Ts)./[pi*t/Ts.*(1-4*t.^2*aa^2/Ts^2)]; %升余弦脉冲波形
GG=t2f(g);GG=abs(GG); %升余弦脉冲的傅式变换
GT=sqrt(GG);GR=GT; %最佳系统的发送接收滤波器的傅式变换
for l1=1:20;
Eb_N0(l1)=(l1-1); %Eb/N0 in dB
eb_n0(l1)=10^(Eb_N0(l1)/10);
Eb=1; 
n0=Eb/eb_n0(l1); %信道的噪声谱密度 
sita=n0*Bs; %信道中噪声功率
n_err=0; %误码计数
for l2=1:5; 
dm=Ts/2;
C=abs(1-0.5*exp(-j*2*pi*f*dm));%多径信道
b=sign(randn(1,M));
s=zeros(1,N); %产生冲激序列
s(L/2:L:N)=b/dt;
SS=t2f(s);
S=SS.*GG.*C; %信道的傅式变化
a=f2t(S);a=real(a); %不加噪声的输出
n_ch=sqrt(sita)*randn(size(t)); %信道噪声
N_CH=t2f(n_ch);
nr=real(f2t(N_CH.*GR)); %输出噪声
sr=a+nr; %接收信号
y=sr(L/2:L:N); %取样
bb=sign(y); %判决
n_err=n_err+length(find(bb~=b));%错误累计 
end
Pe(l1)=n_err/(M*l2);
semilogy(Eb_N0,Pe,'black'); %Pe~Eb/N0曲线画图
xlabel('Eb/N0');ylabel('Pe');title('Pe~Eb/N0曲线');
eb_n0=10.^(Eb_N0/10);
hold on
semilogy(Eb_N0,0.5*erfc(sqrt(eb_n0)));
axis([0,15,1e-3,1])
xlabel('Eb/N0')
ylabel('Pe')
legend('实际的','理论的')
end