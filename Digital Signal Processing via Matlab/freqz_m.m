%������õ���M�ļ�����
function[db,mag,pha,grd,w]=freqz_m(b,a)
%�˲�����ֵ��Ӧ�����ԡ���ԣ�����λ��Ӧ��Ⱥ�ӳ�
%Usage:[db,mag,pha,grd,w]=freqz_m(b,a)         %500���Ӧ[0,pi]
%db ��Է�ֵ��Ӧ�� mag ���Է�ֵ��Ӧ�� pha ��λ��Ӧ�� grd Ⱥ�ӳ���Ӧ��
%w ����Ƶ�ʣ� b ϵͳ����H(z)�ķ�����
%a ϵͳ����H(z)�ķ�ĸ��
[H,w]=freqz(b,a,500);          %500��ķ�Ƶ��Ӧ
mag=abs(H);
db=20*log10(mag/max(mag));
pha=angle(H);
grd=grpdelay(b,a,w);
