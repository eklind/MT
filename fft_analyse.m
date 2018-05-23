function [fft_data,f,peak] = fft_analyse(data,hz,show_plot,num,n_peaks)
%returns frequency data up to Nyquist frequency
%plots data if third input==true
%if number(even or power of 2) in entered, scales the fft to that amount of values
%data_filt=outlier_detection(data,0);
data_filt=data-mean(data);
%data_filt=detrend(data_filt); 
L=length(data);

%frequency vector and abs fft data
f = hz*(0:(L/2))/L;
f=f';
%fft_data=2*abs(fft(data_filt,L))/(L);
%fft_data_n=fft_data(1:length(f));
if(nargin<3)
   show_plot=true; 
end
if(nargin<4||num>length(data))
    num=length(data);
end
if(nargin<5)
    n_peaks=1;
end
%frequency resolution
res_hz=hz/num;
%do transformation
fft_data=2*abs(fft(data_filt,num))/(num);
%zero up to 5 hz
fft_data(1)=0;
%fft_data(1:floor(5*res_hz))=0;
%get frequency vector
f=(hz/length(fft_data))*(0:length(fft_data)/2);

%prepare output(first half of frequency
%f=f(1:end);
%fft_data=fft_data(1:num/2+1); 

%return n_peaks largest peaks
fft_data_max=fft_data(1:num/2);
for n=1:n_peaks
    [M_temp,I_temp]=max(fft_data_max);  %prev peak(2) and peak(1)
    peak(1,n)=f(I_temp); %frequency
    peak(2,n)=M_temp; %magnitude
    fft_data_max(I_temp)=0;
end

if(show_plot==true)
    %plot1
%     subplot(2,1,1)
%     figure
    plot(f(1:end),fft_data(1:length(f)),'linewidth',1);
    hold on
    plot(peak(1,:),peak(2,:),'*')
    ylabel('Magnitude')
    tlt=strcat('|Frequency domain, sampled at: ',num2str(hz),'hz|','|resolution:',num2str(res_hz),'hz|','|peak at:',num2str(peak(1,1)),'hz|');
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