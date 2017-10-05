[y,Fs]=wavread('xiong.wav');
fs=8000;
y_f=filter_for_lastone(y,Fs);
plot(y);hold on;
plot(y_f,'r')
figure;
stem(abs(fft(y)));
hold on;
stem(abs(fft(y_f)),'r');
wavplay(y,fs);
wavplay(y_f,fs);

