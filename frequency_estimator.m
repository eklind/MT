function nat_freq = frequency_estimator(data,hz)
%plot(f,fft_data(1:length(f)))
%algorithm: 
%find where a wave starts
%remove 3 periods in beginning
%find when to stop(2 periods before end)
%add all the results from windowed periods and take a mean

%TODO:
%some problems when outliers are present

L=length(data);
data_filt=outlier_detection(data,0);
data_filt=detrend(data_filt); %remove?
%data_filt=smoothdata(data_filt);

%frequency vector and abs fft data
f = hz*(0:(L/2))/L;
f=f';
fft_data=abs(fft(data_filt,L))/L;

%Find peaks and indices
d=cumsum(data-mean(data));
[pks_per,locs_per] = findpeaks(d); %index of periods
new_signal=pks_per(1:end-1)-pks_per(2:end);
[pks_max,locs_max] = findpeaks(new_signal); %index of peaks
ind_peaks=pks_max>0; % logical index for peaks in locs_max
pks_peak=pks_max(ind_peaks);
locs_peak=locs_max(ind_peaks); %index of the peaks in pks_per

%% Repeat for all periods
fft_avg=zeros(length(data_filt),1);
for i=1:length(locs_peak)-1
    if(i>20)
        break;
    end
    start_ind=locs_per(locs_peak(i)+2);
    stop_ind=locs_per(locs_peak(i+1)-1);
    data_part=data_filt(start_ind:stop_ind);
    fft_data_cut=abs(fft(data_part,L))/L;
    fft_avg=fft_avg+fft_data_cut;
end
fft_avg=fft_avg/length(locs_peak);
[val_m,ind_m]=max(fft_avg);
%hold on
%plot(locs_per,pks_per,'*r')
%plot(locs_per(locs_max),pks_per(locs_max),'*g')

% Plotting
subplot(3,1,1)
mag1=sum(fft_data(1:length(f)))
plot(f,fft_data(1:length(f))/mag1)
hold on
mag2=sum(fft_avg(1:length(f)))
plot(f,fft_avg(1:length(f))/mag2)
hold off
ylabel('magnitude')
xlabel('frequency')
legend('all data','cut data')

subplot(3,1,2)
plot(data-mean(data))
ylabel('magnitude')
xlab=strcat('sample at: ',num2str(hz),'hz')
xlabel(xlab)

subplot(3,1,3)
plot(d)%cumsum
hold on
plot(locs_per(locs_peak),pks_per(locs_peak),'*g')
hold off




%return
nat_freq=f(ind_m);
end