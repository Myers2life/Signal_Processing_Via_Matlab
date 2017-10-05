function complex_qam_data=QAM16(bitdata)
%��4�����������ݵ�ӳ��
N=length(bitdata)/4;
X1=reshape(bitdata,4,N)';
complex_qam_data=zeros(1,N);
for i=1:N
    if X1(i,2)
        complex_qam_data(i)=1;
    else
        complex_qam_data(i)=3;
    end%�ڶ�λ
    if ~X1(i,1)
        complex_qam_data(i)=-complex_qam_data(i);
    end%��һλ������
    if X1(i,4)
        complex_qam_data(i)=complex_qam_data(i)+j;
    else
        complex_qam_data(i)=complex_qam_data(i)+3j;
    end
    if ~X1(i,3)
        complex_qam_data(i)=conj(complex_qam_data(i));
    end%����λ���鲿����
end


