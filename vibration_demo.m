%range
range=1;
%load 'C:\Acuity Data\29 Mar 2018 11-00-43.txt';
vib_data=xlsread('vibration_data.xlsx','A:A');
Fs=1000;
L=14819;
t=0.001:0.001:L*range/Fs;
vibr_data=double(table2array(vibrationdata));
vibr_data_smoothed=smoothdata(vibr_data);

fft_vibr_data=fft(vibr_data_smoothed(1:end*range),L);
f = Fs*(0:(L/2))/L;
%f=Fs*(0:1)
Lf=length(f);
v=(abs(fft_vibr_data))/L;

%Plot time
figure(1)
plot(t,detrend(vibr_data_smoothed(1:end*range)))
xlabel('time')
ylabel('vibration')

%Plot frequency
figure(2)
plot(f(2:end),v(2:Lf))
xlabel('f (Hz)')
ylabel('|Mag|')

%%
vibr_data_smoothed=smoothdata(vibr_data);
plot(t,vibr_data,'-r',t,vibr_data_smoothed,'-b')
legend('Original Data','Smoothed Data')

%%
fft_vibr_data=fft(vibr_data_smoothed);
v=(abs(fft_vibr_data(2:end)))/length(vibr_data_smoothed);
plot(v)