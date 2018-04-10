function [fft_data_n,f] = fft_analyse(data,hz,show_freq,downsample)
%returns frequency data up to Nyquist frequency
%plots data if third input==true

data_filt=outlier_detection(data,0);
%data_filt=detrend(data_filt); 
L=length(data);

%frequency vector and abs fft data
f = hz*(0:(L/2))/L;
f=f';
fft_data=abs(fft(data_filt,L))/L;
fft_data_n=fft_data(1:length(f));

if(show_freq==true)
    subplot(2,1,1)
    stem(f,fft_data(1:length(f)))
    hold on
    ylabel('Magnitude')
    tlt=strcat('Frequency domain of vibration signal, sampled at: ',num2str(hz),'hz');
    title(tlt)
    xlabel('Frequency')
    legend('Vibration data')
    hold off
    
    subplot(2,1,2)
    f2=f(1:downsample:end);
    for(i=0:length(f2)-1)
        fft_data2(i+1)=sum(fft_data(1+i*downsample:(i+1)*downsample));
    end
    stem(f2,fft_data2(1:length(f2)))
    ylabel('Magnitude')
    xlabel('Frequency')
    legend('Vibration data frequencies collected')
end
end