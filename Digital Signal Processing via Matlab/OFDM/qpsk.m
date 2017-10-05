function [complex_signal_matrix]=qpsk(baseband_out)
%modulation of QPSK,modulate bitdata to QPSK complex signal
convert_matrix = reshape(baseband_out',2,length(baseband_out)/2)' ;%����ת����ÿ����2�������һ������
modulo_baseband = bi2de(convert_matrix,'left-msb');%2500*1��ʮ���ƾ���  ����ÿ���������Ʒ���ת��Ϊһ��10������
carrier_matrix = reshape(modulo_baseband,carrier_count,symbols_per_carrier)';%���� ʱ��-�ز�25*100 ���� 100�����ز�  ÿ�����ز���25��OFDM����
carrier_matrix = [zeros(1,carrier_count); carrier_matrix];% ���һ����ֵ��Ƶĳ�ʼ��λ
for i = 2:(symbols_per_carrier + 1) %��ÿ�����ز��ĵ�һ�����ſ�ʼ����
carrier_matrix(i,:) = rem(carrier_matrix(i,:) + carrier_matrix (i-1,:), 2^bits_per_symbol) ;% ��ֵ��� ����ֱ��룩
end

carrier_matrix = carrier_matrix*((2*pi)/(2^bits_per_symbol));%��λӳ�� ��0��0��=0 -->0;  (0,1)=1 -->90;  (1,0)=2-->180;     (1,1)=3  -->270
[X, Y]=pol2cart(carrier_matrix, ones(size(carrier_matrix,1),size(carrier_matrix,2))); % �ɼ�������������ת�� ��һ����Ϊ��λ �ڶ�����Ϊ����  ���Ⱦ�Ϊ1
complex_signal_matrix = complex(X, Y);