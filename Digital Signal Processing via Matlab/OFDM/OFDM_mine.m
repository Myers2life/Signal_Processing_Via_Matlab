%% %OFDM系统指标
clear all;
close all;
carrier_count=200;%子载波数
symbols_per_carrier=12;%00;%每子载波含符号数
bits_per_symbol=4;%每符号含比特数,16QAM调制
IFFT_bin_length=1024;%FFT点数%鉴于512点变换效果不怎么好10倍过采样，波形效果很好
PrefixRatio=1/4;%保护间隔与OFDM数据的比例 1/6~1/4
GI=PrefixRatio*IFFT_bin_length ;%每一个OFDM符号添加的循环前缀长度为1/4*IFFT_bin_length  
                                %即保护间隔长度为512
% beta=1/32;%窗函数滚降系数
% GIP=beta*(IFFT_bin_length+GI);%循环后缀的长度20
 SNR=15; %信噪比dB
%% 随机信号的产生
baseband_out_length=carrier_count * symbols_per_carrier * bits_per_symbol;
                %所输入的比特数目200*12*4
baseband_out=round(rand(1,baseband_out_length));%输出待调制的二进制比特流
%% QAM调制
complex_carrier_matrix=QAM16(baseband_out);%列向量
complex_carrier_matrix=reshape(complex_carrier_matrix',carrier_count,symbols_per_carrier)';
%symbols_per_carrier*carrier_count 矩阵
figure(1);
plot(complex_carrier_matrix,'*r');%16QAM调制后星座图
axis([-4, 4, -4, 4]);
grid on
%% %=================过采样===========================
%% 有问题啊，计算出来的时域值有那么一点点虚部分量，怎么解释………………
IFFT_modulation=zeros(symbols_per_carrier,IFFT_bin_length);%添0组成IFFT_bin_length IFFT 运算
carriers = (1:carrier_count) ;%+ (floor(IFFT_bin_length/4) - floor(carrier_count/2));
%后边这半句没看懂为什么要加，所以注释掉了……
conjugate_carriers = IFFT_bin_length - carriers +1;%共轭对称子载波映射  共轭复数对应的IFFT点坐标
%共轭对称子载波映射  复数数据对应的IFFT点坐标
IFFT_modulation(:,carriers ) = complex_carrier_matrix ;%未添加导频信号 ，子载波映射在此处
IFFT_modulation(:,conjugate_carriers ) = conj(complex_carrier_matrix);%共轭复数映射
%% 关于过采样的一些解释
% 对于OFDM基带信号
% s(t)=Re[ >_ Xn* exp(j*2*pi*n*df*t)], t在0－T之间，T=1/df
% 先直接用过采样画出s(t)一个周期内波形作为原始波形，以便对比。
% 
% 然后对N点{Xn}进行处理，分三种情况。
% 情况一：如果直接对N点{Xn}中间插3N个零，进行4N点IFFT运算，得到4N点复数，分别对实
% 部、虚部作图，与s(t)原始波形不符合。
% 
% 情况二：如果对N点{Xn}进行共轭处理，进行2N点IFFT运算，得到2N点实数，对其作图，与
% s(t)原始波形基本符合。
% 
% 情况三：如果对N点{Xn}进行共轭处理，再在2N点中间插2N个零，进行4N点IFFT运算，得到
% 4N点实数，对其作图，与s(t)原始波形很符合。
% 
% 所以我认为情况一对于用IFFT恢复基带信号，不大合适。情况二能够恢复基带信号，情况
% 三相当于频域过采样，能够更好的恢复基带信号。
%% 关于这个说法的我的一点思考
%对于时域为实数的x（n）其X(k)是共轭对称的
%求证明

%% 频域图，即512个子载波的幅值图，其中中间高频部分为零，还有400个载波，共轭对称
%总共有12个ＯＦＤＭ符号，这里取第二个
figure(2);
stem(0:IFFT_bin_length-1, abs(IFFT_modulation(2,1:IFFT_bin_length)),'b*-')%第一个OFDM符号的频谱
grid on
axis ([0 IFFT_bin_length -0.5 4.5]);
ylabel('Magnitude');
xlabel('IFFT Bin');
title('OFDM Carrier Frequency Magnitude');

%% 相位图
figure(3);
stem(0:IFFT_bin_length-1, (180/pi)*angle(IFFT_modulation(2,1:IFFT_bin_length)),'.')%, 'go')
 hold on
%不知道后边这些做了些神马，不明觉厉，但还是删掉了……         
% stem(0:carriers-1,
% (180/pi)*angle(IFFT_modulation(2,1:carriers)),'b*-');%第一个OFDM符号的相位？？？
% stem(0:conjugate_carriers-1, (180/pi)*angle(IFFT_modulation(2,1:conjugate_carriers)),'b*-');
grid on
ylabel('Phase (degrees)')
xlabel('IFFT Bin')
title('OFDM Carrier Phase')
%% ＯＦＭＤ调制，即ＩＦＦＴ变换
signal_after_IFFT=ifft(IFFT_modulation,IFFT_bin_length,2);%这个实际上得到的是时域信号采样
figure(4)
%stairs(0:20-1,signal_after_IFFT(2,1:20))
hold on;
plot(0:100-1,signal_after_IFFT(2,1:100));
% Warning: Imaginary parts of complex X and/or Y arguments ignored 
% > In OFDM_mine at 83 
%signal_after_IFFT是一个12*2048的矩阵，即为12个OFDM符号（我是这么理解的）
%% 加入循环前缀作保护
time_wave_matrix =signal_after_IFFT;
%时域波形矩阵，行为每载波所含符号数，列ITTF点数，N个子载波映射在其内，每一行即为一个OFDM符号
time_wave_matrix_cp=[signal_after_IFFT(:,IFFT_bin_length*0.75+1:IFFT_bin_length),signal_after_IFFT];
%% 画个图看看（波形图）
figure(4);
subplot(2,1,1);
plot(0:IFFT_bin_length-1,time_wave_matrix(2,:));%第一个符号的波形
axis([-IFFT_bin_length*0.25, IFFT_bin_length, -0.2, 0.2]);
grid on;
ylabel('Amplitude');
xlabel('Time');
title('OFDM Time Signal, One Symbol Period');
subplot(2,1,2);
plot(0:length(time_wave_matrix_cp)-1,time_wave_matrix_cp(2,:));%第一个符号添加循环前缀后的波形
axis([0, IFFT_bin_length*1.25, -0.2, 0.2]);
grid on;
ylabel('Amplitude');
xlabel('Time');
title('OFDM Time Signal with CP, One Symbol Period');
%% 循环后缀和加窗处理就先不写了，不太懂
%% ========================生成发送信号，并串变换==================================================
Tx_data=zeros(1,symbols_per_carrier*(IFFT_bin_length+GI));
Tx_data(1:IFFT_bin_length+GI)=time_wave_matrix_cp(1,:);
for i = 1:symbols_per_carrier-1 
    Tx_data((IFFT_bin_length+GI)*i+1:(IFFT_bin_length+GI)*(i+1))=time_wave_matrix_cp(i+1,:);
    %并串转换
end
%结果就是十二个符号顺次发出
%%
%=================================================================
temp_time1 = (symbols_per_carrier)*(IFFT_bin_length+GI);%加窗后 循环前缀与后缀不叠加 发送总位数
figure (5)
plot(0:temp_time1-1,Tx_data );%循环前缀与后缀不叠加 发送的信号波形
grid on
ylabel('Amplitude (volts)')
xlabel('Time (samples)')
title('OFDM Time Signal')
%% %=================发送信号频谱==================================
%这里求频谱为什么要分段？数据量过大吗？不明白……
symbols_per_average = ceil(symbols_per_carrier/5);%符号数的1/5，10行
avg_temp_time = (IFFT_bin_length+GI)*symbols_per_average;%点数，10行数据，10个符号
averages = floor(temp_time1/avg_temp_time);
average_fft(1:avg_temp_time) = 0;%分成5段
for a = 0:(averages-1)
 subset_ofdm = Tx_data(((a*avg_temp_time)+1):((a+1)*avg_temp_time));%
 subset_ofdm_f = abs(fftshift(fft(subset_ofdm)));%将发送信号分段求频谱
 average_fft = average_fft + (subset_ofdm_f/averages);%总共的数据分为5段，分段进行FFT，平均相加
end
average_fft_log = 20*log10(average_fft);
figure (6)
%subplot(2,1,1);
plot((0:(avg_temp_time-1))/avg_temp_time, average_fft_log)%归一化  0/avg_temp_time  :  (avg_temp_time-1)/avg_temp_time
hold on
plot(0:1/IFFT_bin_length:1, -35, 'rd')
grid on
axis([0 1 -40 max(average_fft_log)])
ylabel('Magnitude (dB)')
xlabel('Normalized Frequency (0.5 = fs/2)')
title('OFDM Signal Spectrum without windowing')
%% 信号频谱
figure(7)
OFDM_F=fftshift(fft(Tx_data));
plot(0:1/length(OFDM_F):1-1/length(OFDM_F),20*log10(abs(OFDM_F)))
title('简单粗暴的OFDM频谱')
%简单粗暴的OFDM频谱……不知道为什么上边要分段求得那么麻烦…………
%% 噪声
% 
% Rx_data=Tx_data;
%====================添加噪声============================================
for SNR=1:16
    Tx_signal_power = var(Tx_data);%发送信号功率
    linear_SNR=10^(SNR/10);%线性信噪比
    noise_sigma=Tx_signal_power/linear_SNR;
    noise_scale_factor = sqrt(noise_sigma);%标准差sigma
    noise=randn(1,((symbols_per_carrier)*(IFFT_bin_length+GI)))*noise_scale_factor;
    %产生正态分布噪声序列
    Rx_data=Tx_data+noise;%接收到的信号加噪声
    
    %noise=wgn(1,length(windowed_Tx_data),noise_sigma,'complex');%产生复GAUSS白噪声信号
    
    %% 串并变换  Ｒx_data
    Rx_data_matrix=zeros(symbols_per_carrier,IFFT_bin_length+GI);
    for i=1:symbols_per_carrier;
        Rx_data_matrix(i,:)=Rx_data(1,(i-1)*(IFFT_bin_length+GI)+1:i*(IFFT_bin_length+GI));%串并变换
    end
    Rx_data_complex_matrix=Rx_data_matrix(:,GI+1:IFFT_bin_length+GI);%去除循环前缀，得到有用信号矩阵
    %% fft OFDM解调
    Y1=fft(Rx_data_complex_matrix,IFFT_bin_length,2);%这个实际上得到的是时域信号采样
    % Y1(1:5,1:5)==IFFT_modulation(1:5,1:5)
    Rx_carriers=Y1(:,carriers);%除去IFFT/FFT变换添加的0，选出映射的子载波
    %% 分析一把
    % Rx_phase =angle(Rx_carriers);%接收信号的相位
    % Rx_mag = abs(Rx_carriers);%接收信号的幅度
    % figure(7);
    % polar(Rx_phase, Rx_mag,'bd');%极坐标坐标下画出接收信号的星座图
    % [M, N]=pol2cart(Rx_phase, Rx_mag);
    % Rx_complex_carrier_matrix = complex(M, N);
    % figure(8);
    % plot(Rx_complex_carrier_matrix,'*r');%XY坐标接收信号的星座图
    % axis([-4, 4, -4, 4]);
    % grid on
    if SNR==15
        figure(8)
        plot(Rx_carriers,'*r');%16QAM星座图
        grid on;
        %% 接收信号频谱
        figure(11)
        OFDM_F=fftshift(fft(Tx_data));
        plot(0:1/length(OFDM_F):1-1/length(OFDM_F),20*log10(abs(OFDM_F)))
        title('接收到的的OFDM频谱')
        figure(12)
        plot(0:length(Rx_data_matrix)-1,Rx_data_matrix(2,:));%第一个符号添加循环前缀后的波形
        axis([0, IFFT_bin_length*1.25, -0.2, 0.2]);
        grid on;
        ylabel('Amplitude');
        xlabel('Time');
        title('接收到的ＯＦＤＭ波形');
    end
    %% %====================16qam解调==================================================
    % Rx_serial_complex_symbols = reshape(Rx_complex_carrier_matrix',size(Rx_complex_carrier_matrix, 1)*size(Rx_complex_carrier_matrix,2),1)' ;
    % Rx_decoded_binary_symbols=demoduqam16(Rx_serial_complex_symbols);
    Rx_bit_data=De_QAM16(Rx_carriers); 
    bit_errors=find(baseband_out~=Rx_bit_data);
    bit_error_count = size(bit_errors,2);
    ber(SNR)=bit_error_count/baseband_out_length   ; 
end 
figure(15);
plot(1:16,10*log10(ber))




