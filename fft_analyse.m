function [fft_data,f] = fft_analyse(data,hz,show_freq,number)
%returns frequency data up to Nyquist frequency
%plots data if third input==true
%if number(even) in entered, scales the fft to that amount of values

data_filt=outlier_detection(data,0);
%data_filt=detrend(data_filt); 
L=length(data);

%frequency vector and abs fft data
f = hz*(0:(L/2))/L;
f=f';
fft_data=2*abs(fft(data_filt,L))/(L);
%fft_data_n=fft_data(1:length(f));

if(show_freq==true)
    
    if(nargin>3)
        num_plot=3;
        fft_data2=2*abs(fft(data_filt,number))/(number);
        f2=(hz/length(fft_data2))*(0:length(fft_data2)/2);
        
        %prepare output
        f=f2(2:end);
        fft_data=fft_data2(2:number/2+1); 
    else
        num_plot=2;
    end
    
    %plot1
    subplot(1,num_plot,1)
    stem(f(2:end),fft_data(2:length(f)));
    hold on
    ylabel('Magnitude')
    tlt=strcat('Frequency domain of vibration signal, sampled at: ',num2str(hz),'hz');
    title(tlt)
    xlabel('Frequency')
    legend('Vibration data')
    hold off
    
    %plot2
        subplot(1,num_plot,2)
        stem(f2(2:end),fft_data2(2:length(f2)));
        ylabel('Magnitude')
        xlabel('Frequency')
        legend('Vibration data frequencies collected')
     
    %plot3
    subplot(1,num_plot,3)
    bar(f,fft_data);
    
end
end