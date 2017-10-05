%% %OFDMϵͳָ��
clear all;
close all;
carrier_count=200;%���ز���
symbols_per_carrier=12;%00;%ÿ���ز���������
bits_per_symbol=4;%ÿ���ź�������,16QAM����
IFFT_bin_length=1024;%FFT����%����512��任Ч������ô��10��������������Ч���ܺ�
PrefixRatio=1/4;%���������OFDM���ݵı��� 1/6~1/4
GI=PrefixRatio*IFFT_bin_length ;%ÿһ��OFDM������ӵ�ѭ��ǰ׺����Ϊ1/4*IFFT_bin_length  
                                %�������������Ϊ512
% beta=1/32;%����������ϵ��
% GIP=beta*(IFFT_bin_length+GI);%ѭ����׺�ĳ���20
 SNR=15; %�����dB
%% ����źŵĲ���
baseband_out_length=carrier_count * symbols_per_carrier * bits_per_symbol;
                %������ı�����Ŀ200*12*4
baseband_out=round(rand(1,baseband_out_length));%��������ƵĶ����Ʊ�����
%% QAM����
complex_carrier_matrix=QAM16(baseband_out);%������
complex_carrier_matrix=reshape(complex_carrier_matrix',carrier_count,symbols_per_carrier)';
%symbols_per_carrier*carrier_count ����
figure(1);
plot(complex_carrier_matrix,'*r');%16QAM���ƺ�����ͼ
axis([-4, 4, -4, 4]);
grid on
%% %=================������===========================
%% �����Ⱑ�����������ʱ��ֵ����ôһ����鲿��������ô���͡�����������
IFFT_modulation=zeros(symbols_per_carrier,IFFT_bin_length);%��0���IFFT_bin_length IFFT ����
carriers = (1:carrier_count) ;%+ (floor(IFFT_bin_length/4) - floor(carrier_count/2));
%�������û����ΪʲôҪ�ӣ�����ע�͵��ˡ���
conjugate_carriers = IFFT_bin_length - carriers +1;%����Գ����ز�ӳ��  �������Ӧ��IFFT������
%����Գ����ز�ӳ��  �������ݶ�Ӧ��IFFT������
IFFT_modulation(:,carriers ) = complex_carrier_matrix ;%δ��ӵ�Ƶ�ź� �����ز�ӳ���ڴ˴�
IFFT_modulation(:,conjugate_carriers ) = conj(complex_carrier_matrix);%�����ӳ��
%% ���ڹ�������һЩ����
% ����OFDM�����ź�
% s(t)=Re[ >_ Xn* exp(j*2*pi*n*df*t)], t��0��T֮�䣬T=1/df
% ��ֱ���ù���������s(t)һ�������ڲ�����Ϊԭʼ���Σ��Ա�Աȡ�
% 
% Ȼ���N��{Xn}���д��������������
% ���һ�����ֱ�Ӷ�N��{Xn}�м��3N���㣬����4N��IFFT���㣬�õ�4N�㸴�����ֱ��ʵ
% �����鲿��ͼ����s(t)ԭʼ���β����ϡ�
% 
% ������������N��{Xn}���й��������2N��IFFT���㣬�õ�2N��ʵ����������ͼ����
% s(t)ԭʼ���λ������ϡ�
% 
% ������������N��{Xn}���й��������2N���м��2N���㣬����4N��IFFT���㣬�õ�
% 4N��ʵ����������ͼ����s(t)ԭʼ���κܷ��ϡ�
% 
% ��������Ϊ���һ������IFFT�ָ������źţ�������ʡ�������ܹ��ָ������źţ����
% ���൱��Ƶ����������ܹ����õĻָ������źš�
%% �������˵�����ҵ�һ��˼��
%����ʱ��Ϊʵ����x��n����X(k)�ǹ���ԳƵ�
%��֤��

%% Ƶ��ͼ����512�����ز��ķ�ֵͼ�������м��Ƶ����Ϊ�㣬����400���ز�������Գ�
%�ܹ���12���ϣƣģͷ��ţ�����ȡ�ڶ���
figure(2);
stem(0:IFFT_bin_length-1, abs(IFFT_modulation(2,1:IFFT_bin_length)),'b*-')%��һ��OFDM���ŵ�Ƶ��
grid on
axis ([0 IFFT_bin_length -0.5 4.5]);
ylabel('Magnitude');
xlabel('IFFT Bin');
title('OFDM Carrier Frequency Magnitude');

%% ��λͼ
figure(3);
stem(0:IFFT_bin_length-1, (180/pi)*angle(IFFT_modulation(2,1:IFFT_bin_length)),'.')%, 'go')
 hold on
%��֪�������Щ����Щ��������������������ɾ���ˡ���         
% stem(0:carriers-1,
% (180/pi)*angle(IFFT_modulation(2,1:carriers)),'b*-');%��һ��OFDM���ŵ���λ������
% stem(0:conjugate_carriers-1, (180/pi)*angle(IFFT_modulation(2,1:conjugate_carriers)),'b*-');
grid on
ylabel('Phase (degrees)')
xlabel('IFFT Bin')
title('OFDM Carrier Phase')
%% �ϣƣͣĵ��ƣ����ɣƣƣԱ任
signal_after_IFFT=ifft(IFFT_modulation,IFFT_bin_length,2);%���ʵ���ϵõ�����ʱ���źŲ���
figure(4)
%stairs(0:20-1,signal_after_IFFT(2,1:20))
hold on;
plot(0:100-1,signal_after_IFFT(2,1:100));
% Warning: Imaginary parts of complex X and/or Y arguments ignored 
% > In OFDM_mine at 83 
%signal_after_IFFT��һ��12*2048�ľ��󣬼�Ϊ12��OFDM���ţ�������ô���ģ�
%% ����ѭ��ǰ׺������
time_wave_matrix =signal_after_IFFT;
%ʱ���ξ�����Ϊÿ�ز���������������ITTF������N�����ز�ӳ�������ڣ�ÿһ�м�Ϊһ��OFDM����
time_wave_matrix_cp=[signal_after_IFFT(:,IFFT_bin_length*0.75+1:IFFT_bin_length),signal_after_IFFT];
%% ����ͼ����������ͼ��
figure(4);
subplot(2,1,1);
plot(0:IFFT_bin_length-1,time_wave_matrix(2,:));%��һ�����ŵĲ���
axis([-IFFT_bin_length*0.25, IFFT_bin_length, -0.2, 0.2]);
grid on;
ylabel('Amplitude');
xlabel('Time');
title('OFDM Time Signal, One Symbol Period');
subplot(2,1,2);
plot(0:length(time_wave_matrix_cp)-1,time_wave_matrix_cp(2,:));%��һ���������ѭ��ǰ׺��Ĳ���
axis([0, IFFT_bin_length*1.25, -0.2, 0.2]);
grid on;
ylabel('Amplitude');
xlabel('Time');
title('OFDM Time Signal with CP, One Symbol Period');
%% ѭ����׺�ͼӴ�������Ȳ�д�ˣ���̫��
%% ========================���ɷ����źţ������任==================================================
Tx_data=zeros(1,symbols_per_carrier*(IFFT_bin_length+GI));
Tx_data(1:IFFT_bin_length+GI)=time_wave_matrix_cp(1,:);
for i = 1:symbols_per_carrier-1 
    Tx_data((IFFT_bin_length+GI)*i+1:(IFFT_bin_length+GI)*(i+1))=time_wave_matrix_cp(i+1,:);
    %����ת��
end
%�������ʮ��������˳�η���
%%
%=================================================================
temp_time1 = (symbols_per_carrier)*(IFFT_bin_length+GI);%�Ӵ��� ѭ��ǰ׺���׺������ ������λ��
figure (5)
plot(0:temp_time1-1,Tx_data );%ѭ��ǰ׺���׺������ ���͵��źŲ���
grid on
ylabel('Amplitude (volts)')
xlabel('Time (samples)')
title('OFDM Time Signal')
%% %=================�����ź�Ƶ��==================================
%������Ƶ��ΪʲôҪ�ֶΣ������������𣿲����ס���
symbols_per_average = ceil(symbols_per_carrier/5);%��������1/5��10��
avg_temp_time = (IFFT_bin_length+GI)*symbols_per_average;%������10�����ݣ�10������
averages = floor(temp_time1/avg_temp_time);
average_fft(1:avg_temp_time) = 0;%�ֳ�5��
for a = 0:(averages-1)
 subset_ofdm = Tx_data(((a*avg_temp_time)+1):((a+1)*avg_temp_time));%
 subset_ofdm_f = abs(fftshift(fft(subset_ofdm)));%�������źŷֶ���Ƶ��
 average_fft = average_fft + (subset_ofdm_f/averages);%�ܹ������ݷ�Ϊ5�Σ��ֶν���FFT��ƽ�����
end
average_fft_log = 20*log10(average_fft);
figure (6)
%subplot(2,1,1);
plot((0:(avg_temp_time-1))/avg_temp_time, average_fft_log)%��һ��  0/avg_temp_time  :  (avg_temp_time-1)/avg_temp_time
hold on
plot(0:1/IFFT_bin_length:1, -35, 'rd')
grid on
axis([0 1 -40 max(average_fft_log)])
ylabel('Magnitude (dB)')
xlabel('Normalized Frequency (0.5 = fs/2)')
title('OFDM Signal Spectrum without windowing')
%% �ź�Ƶ��
figure(7)
OFDM_F=fftshift(fft(Tx_data));
plot(0:1/length(OFDM_F):1-1/length(OFDM_F),20*log10(abs(OFDM_F)))
title('�򵥴ֱ���OFDMƵ��')
%�򵥴ֱ���OFDMƵ�ס�����֪��Ϊʲô�ϱ�Ҫ�ֶ������ô�鷳��������
%% ����
% 
% Rx_data=Tx_data;
%====================�������============================================
for SNR=1:16
    Tx_signal_power = var(Tx_data);%�����źŹ���
    linear_SNR=10^(SNR/10);%���������
    noise_sigma=Tx_signal_power/linear_SNR;
    noise_scale_factor = sqrt(noise_sigma);%��׼��sigma
    noise=randn(1,((symbols_per_carrier)*(IFFT_bin_length+GI)))*noise_scale_factor;
    %������̬�ֲ���������
    Rx_data=Tx_data+noise;%���յ����źż�����
    
    %noise=wgn(1,length(windowed_Tx_data),noise_sigma,'complex');%������GAUSS�������ź�
    
    %% �����任  ��x_data
    Rx_data_matrix=zeros(symbols_per_carrier,IFFT_bin_length+GI);
    for i=1:symbols_per_carrier;
        Rx_data_matrix(i,:)=Rx_data(1,(i-1)*(IFFT_bin_length+GI)+1:i*(IFFT_bin_length+GI));%�����任
    end
    Rx_data_complex_matrix=Rx_data_matrix(:,GI+1:IFFT_bin_length+GI);%ȥ��ѭ��ǰ׺���õ������źž���
    %% fft OFDM���
    Y1=fft(Rx_data_complex_matrix,IFFT_bin_length,2);%���ʵ���ϵõ�����ʱ���źŲ���
    % Y1(1:5,1:5)==IFFT_modulation(1:5,1:5)
    Rx_carriers=Y1(:,carriers);%��ȥIFFT/FFT�任��ӵ�0��ѡ��ӳ������ز�
    %% ����һ��
    % Rx_phase =angle(Rx_carriers);%�����źŵ���λ
    % Rx_mag = abs(Rx_carriers);%�����źŵķ���
    % figure(7);
    % polar(Rx_phase, Rx_mag,'bd');%�����������»��������źŵ�����ͼ
    % [M, N]=pol2cart(Rx_phase, Rx_mag);
    % Rx_complex_carrier_matrix = complex(M, N);
    % figure(8);
    % plot(Rx_complex_carrier_matrix,'*r');%XY��������źŵ�����ͼ
    % axis([-4, 4, -4, 4]);
    % grid on
    if SNR==15
        figure(8)
        plot(Rx_carriers,'*r');%16QAM����ͼ
        grid on;
        %% �����ź�Ƶ��
        figure(11)
        OFDM_F=fftshift(fft(Tx_data));
        plot(0:1/length(OFDM_F):1-1/length(OFDM_F),20*log10(abs(OFDM_F)))
        title('���յ��ĵ�OFDMƵ��')
        figure(12)
        plot(0:length(Rx_data_matrix)-1,Rx_data_matrix(2,:));%��һ���������ѭ��ǰ׺��Ĳ���
        axis([0, IFFT_bin_length*1.25, -0.2, 0.2]);
        grid on;
        ylabel('Amplitude');
        xlabel('Time');
        title('���յ��ģϣƣģͲ���');
    end
    %% %====================16qam���==================================================
    % Rx_serial_complex_symbols = reshape(Rx_complex_carrier_matrix',size(Rx_complex_carrier_matrix, 1)*size(Rx_complex_carrier_matrix,2),1)' ;
    % Rx_decoded_binary_symbols=demoduqam16(Rx_serial_complex_symbols);
    Rx_bit_data=De_QAM16(Rx_carriers); 
    bit_errors=find(baseband_out~=Rx_bit_data);
    bit_error_count = size(bit_errors,2);
    ber(SNR)=bit_error_count/baseband_out_length   ; 
end 
figure(15);
plot(1:16,10*log10(ber))




