function [fft_data,f,peak] = fft_analyse(data,hz,show_plot,num)
%returns frequency data up to Nyquist frequency
%plots data if third input==true
%if number(even or power of 2) in entered, scales the fft to that amount of values
data_filt=outlier_detection(data,0);
data_filt=data_filt-mean(data_filt);
%data_filt=detrend(data_filt); 
L=length(data);

%frequency vector and abs fft data
f = hz*(0:(L/2))/L;
f=f';
fft_data=2*abs(fft(data_filt,L))/(L);
%fft_data_n=fft_data(1:length(f));
if(nargin<3)
   show_plot=true; 
end
if(nargin<4||num>length(data))
    num=length(data);
end
%frequency resolution
res_hz=hz/num;
%do transformation
fft_data=2*abs(fft(data_filt,num))/(num);
%get frequency vector
f=(hz/length(fft_data))*(0:length(fft_data)/2);

%prepare output(first half of frequency
f=f(1:end);
fft_data=fft_data(1:num/2+1); 
[peak(2),peak(1)]=max(fft_data); 
peak(1)=f(peak(1));
if(show_plot==true)
    %plot1
    %subplot(2,1,1)
    figure
    plot(f(2:end),fft_data(2:length(f)));
    hold on
    plot(peak(1),peak(2),'*')
    ylabel('Magnitude')
    tlt=strcat('Frequency domain, sampled at: ',num2str(hz),'hz,','resolution:',num2str(res_hz),'hz','peak,',num2str(peak(2)));
    title(tlt)
    xlabel('Frequency')
    legend('Vibration data')
    hold off
    
%     %plot2
%     subplot(2,1,2)
%     plot(data);
%     tlt=strcat('Time domain, sampled at: ',num2str(hz),'hz');
%     title(tlt)
%     ylabel('Amplitude')
%     xlabel('Sample')  
end
end