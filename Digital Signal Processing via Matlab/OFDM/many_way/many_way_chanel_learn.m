global dt t f df N T
close all
clear Eb_N0 Pe
k=input('ȡ��������2^k, kȡ13����');
if isempty(k), k=13; end
z=input('ÿ���ź�ȡ��������2^z, z<k');
if isempty(z), z=3; end
aa=input('����ϵ��=[0.5]');
if aa==[],aa=0.5;end
N=2^k;
L=2^z;M=N/L;
Rb=2; %��������2Mb/s
Ts=1/Rb; %��Ԫ���
dt=Ts/L; %ʱ��������
df=1/(N*dt); %Ƶ��������
T=N*dt; %�ض�ʱ��
Bs=N*df/2; %ϵͳ����
f=[-Bs+df/2:df:Bs]; %Ƶ�������
t=[-T/2+dt/2:dt:T/2]; %ʱ�������
g=sin(pi*t/Ts).*cos(pi*t*aa/Ts)./[pi*t/Ts.*(1-4*t.^2*aa^2/Ts^2)]; %���������岨��
GG=t2f(g);GG=abs(GG); %����������ĸ�ʽ�任
GT=sqrt(GG);GR=GT; %���ϵͳ�ķ��ͽ����˲����ĸ�ʽ�任
for l1=1:20;
Eb_N0(l1)=(l1-1); %Eb/N0 in dB
eb_n0(l1)=10^(Eb_N0(l1)/10);
Eb=1; 
n0=Eb/eb_n0(l1); %�ŵ����������ܶ� 
sita=n0*Bs; %�ŵ�����������
n_err=0; %�������
for l2=1:5; 
dm=Ts/2;
C=abs(1-0.5*exp(-j*2*pi*f*dm));%�ྶ�ŵ�
b=sign(randn(1,M));
s=zeros(1,N); %�����弤����
s(L/2:L:N)=b/dt;
SS=t2f(s);
S=SS.*GG.*C; %�ŵ��ĸ�ʽ�仯
a=f2t(S);a=real(a); %�������������
n_ch=sqrt(sita)*randn(size(t)); %�ŵ�����
N_CH=t2f(n_ch);
nr=real(f2t(N_CH.*GR)); %�������
sr=a+nr; %�����ź�
y=sr(L/2:L:N); %ȡ��
bb=sign(y); %�о�
n_err=n_err+length(find(bb~=b));%�����ۼ� 
end
Pe(l1)=n_err/(M*l2);
semilogy(Eb_N0,Pe,'black'); %Pe~Eb/N0���߻�ͼ
xlabel('Eb/N0');ylabel('Pe');title('Pe~Eb/N0����');
eb_n0=10.^(Eb_N0/10);
hold on
semilogy(Eb_N0,0.5*erfc(sqrt(eb_n0)));
axis([0,15,1e-3,1])
xlabel('Eb/N0')
ylabel('Pe')
legend('ʵ�ʵ�','���۵�')
end