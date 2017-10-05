function complex_qam_data=QAM16(bitdata)
%作4个二进制数据的映射
N=length(bitdata)/4;
X1=reshape(bitdata,4,N)';
complex_qam_data=zeros(1,N);
for i=1:N
    if X1(i,2)
        complex_qam_data(i)=1;
    else
        complex_qam_data(i)=3;
    end%第二位
    if ~X1(i,1)
        complex_qam_data(i)=-complex_qam_data(i);
    end%第一位，符号
    if X1(i,4)
        complex_qam_data(i)=complex_qam_data(i)+j;
    else
        complex_qam_data(i)=complex_qam_data(i)+3j;
    end
    if ~X1(i,3)
        complex_qam_data(i)=conj(complex_qam_data(i));
    end%第三位，虚部符号
end


