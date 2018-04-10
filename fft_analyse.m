function [fft_data,f] = fft_analyse(data,hz,show_freq)


data_filt=outlier_detection(data,0);
data_filt=detrend(data_filt); %remove?
%data_filt=smoothdata(data_filt);
L=length(data);

%frequency vector and abs fft data
%L=length(data);
f = hz*(0:(L/2))/L;
f=f';
fft_data=abs(fft(data_filt,L))/L;

%L=hz/2;
%f=linspace(0,hz/2,L);
%f=f';
%fft_data=abs(fft(data_filt,L))/L;

%peaks=200;

%[pks,locs] = findpeaks(fft_data(1:length(f)),'MinPeakDistance',peaks);
%freq=f(locs);
if(show_freq==true)
    stem(f(2:length(f)/2),fft_data(2:length(f)/2))
    hold on
    %plot(f(locs),fft_data(locs),'r*')
    ylabel('Magnitude')
    tlt=strcat('Frequency domain of vibration signal, sampled at: ',num2str(hz),'hz');
    title(tlt)
    xlabel('Frequency')
    legend('Vibration data')
    
    hold off
end


end