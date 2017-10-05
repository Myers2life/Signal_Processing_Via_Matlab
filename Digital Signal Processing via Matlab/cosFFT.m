cosn1=cosdemo(32,0.000625);
cosn2=cosdemo(32,0.005);
cosn3=cosdemo(32,0.0046875);
cosn4=cosdemo(32,0.004);
cosn5=cosdemo(64,0.00625);
%cosn={[cosn1];[cosn2];cosn3;cosn4;cosn5};
cosn={cosn1,cosn2,cosn3,cosn4,cosn5};
%以上产生一个元胞数组，
%cosn{1,1}访问的是数据，cosn（1,1）访问的是第一个数据的类型
subn=1;%画图区分区域的控制变量
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
subplot(5,2,1);    title('F=50,N=32,T=0.00625 时域');
subplot(5,2,2);    title('F=50,N=32,T=0.00625 频域');
subplot(5,2,3);    title('F=50,N=32,T=0.005 时域');
subplot(5,2,4);    title('F=50,N=32,T=0.005 频域');
subplot(5,2,5);    title('F=50,N=32,T=0.0046875 时域');
subplot(5,2,6);    title('F=50,N=32,T=0.0046875  频域');
subplot(5,2,7);   title('F=50,N=32,T=0.004 时域');
subplot(5,2,8);   title('F=50,N=32,T=0.004  频域');
subplot(5,2,9);   title('F=50,N=32,T=0.000625 时域');
subplot(5,2,10);   title('F=50,N=32,T=0.000625  频域');




