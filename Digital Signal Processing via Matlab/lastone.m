fs=8000;           %ȡ��Ƶ��
duration=6;         %¼��ʱ��
fprintf('Press any key to start %g seconds of recording...\n',duration);
pause;
fprintf('Recording...\n');
y=wavrecord(duration*fs,fs);         %duration*fs ���ܵĲ�������
fprintf('Finished recording.\n');
fprintf('Press any key to play the recording...\n');
pause;
wavplay(y,fs);
wavwrite(y,'xhello.wav')