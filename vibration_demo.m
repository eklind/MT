%vib_data=xlsread('vibration_data.xlsx','A:A');
Fs=1000;
L=14819;
t=0.001:0.001:L/1000;
% vibr_data=double(table2array(vibrationdata));
fft_vibr_data=fft(vibr_data)
f = Fs*(0:(L/2))/L;
Lf=length(f);
v=(abs(fft_vibr_data))


%Plot time
%plot(t,vibr_data)

%Plot frequency
plot(f(2:end),v(2:Lf))
xlabel('f (Hz)')
ylabel('|vibr(f)|')

