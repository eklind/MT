function [pks,freq] = fft_analyse(data,hz,show_freq,numPeaks)

L=length(data);
data_filt=outlier_detection(data,0);
data_filt=detrend(data_filt); %remove?
%data_filt=smoothdata(data_filt);

%frequency vector and abs fft data
f = hz*(0:(L/2))/L;
f=f';
fft_data=abs(fft(data_filt,L))/L;

if(nargin>3)
    peaks=numPeaks;
else
    peaks=200;
end
[pks,locs] = findpeaks(fft_data(1:length(f)),'MinPeakDistance',peaks);
freq=f(locs);
if(show_freq==true)
    plot(f,fft_data(1:length(f)))
    hold on
    plot(f(locs),fft_data(locs),'r*')
    ylabel('Magnitude')
    tlt=strcat('Frequency domain of vibration signal, sampled at: ',num2str(hz),'hz')
    title(tlt)
    xlabel('Frequency')
    legend('Vibration data')
    
    hold off
end


end