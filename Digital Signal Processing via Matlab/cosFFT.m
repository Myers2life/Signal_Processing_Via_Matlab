cosn1=cosdemo(32,0.000625);
cosn2=cosdemo(32,0.005);
cosn3=cosdemo(32,0.0046875);
cosn4=cosdemo(32,0.004);
cosn5=cosdemo(64,0.00625);
%cosn={[cosn1];[cosn2];cosn3;cosn4;cosn5};
cosn={cosn1,cosn2,cosn3,cosn4,cosn5};
%���ϲ���һ��Ԫ�����飬
%cosn{1,1}���ʵ������ݣ�cosn��1,1�����ʵ��ǵ�һ�����ݵ�����
subn=1;%��ͼ��������Ŀ��Ʊ���
for i=1:5
    subplot(5,2,subn);
    subn=subn+1;
    stem(cosn{1,i});
    grid on;
    subplot(5,2,subn);
    stem(abs(fft(cosn{1,i})));
    grid on;
    subn=subn+1;
end
subplot(5,2,1);    title('F=50,N=32,T=0.00625 ʱ��');
subplot(5,2,2);    title('F=50,N=32,T=0.00625 Ƶ��');
subplot(5,2,3);    title('F=50,N=32,T=0.005 ʱ��');
subplot(5,2,4);    title('F=50,N=32,T=0.005 Ƶ��');
subplot(5,2,5);    title('F=50,N=32,T=0.0046875 ʱ��');
subplot(5,2,6);    title('F=50,N=32,T=0.0046875  Ƶ��');
subplot(5,2,7);   title('F=50,N=32,T=0.004 ʱ��');
subplot(5,2,8);   title('F=50,N=32,T=0.004  Ƶ��');
subplot(5,2,9);   title('F=50,N=32,T=0.000625 ʱ��');
subplot(5,2,10);   title('F=50,N=32,T=0.000625  Ƶ��');




