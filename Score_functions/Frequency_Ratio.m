function score_vec= Frequency_Ratio(Accelerometer_Z_Axis,rpm,fs,scale,remove)
%fs=2500;
%scale=100;
fftdata=[];

%finds the relationships between frequency peaks in a frequency interval 

    f_drive=mean(rpm)/60;
    f_center=94;
    f_range=[f_center-0.5 f_center+0.5];
    n_peaks=2;
    
    peak=zeros(2,1);
    fftdata=abs(fft(Accelerometer_Z_Axis(1:end),fs*scale));
    %fftdata(i,1:5)=0;
    L=length(fftdata(1:end/2));
    f_vec=[1:L]/scale;
    x=(f_vec(f_range(1)*scale:f_range(2)*scale));
    fdata=fftdata(f_range(1)*scale:f_range(2)*scale);
    
    [M_temp,I_temp]=max(fdata);  %prev peak(2) and peak(1)
    peak(1,1)=x(I_temp); %frequency
    peak(2,1)=M_temp; %magnitude
    %handle index out of bounds
    
    score_vec=abs(f_drive./peak(1,1));
end

