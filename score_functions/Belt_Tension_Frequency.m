function [score_max,score_mean,score_median]= Belt_Tension_Frequency(data,drive_rpm,fs,scale, remove)
%fs=2500;
%scale=100;
fftdata=[];

%topFreq=200;
%lowFreq=1;

    f_center=mean(drive_rpm)/60;
    f_range=[f_center-0.5 f_center+0.5];
    n_peaks=2;
    
    peak=zeros(2,2);
    fftdata=abs(fft(data.HF.Accelerometer_Z_Axis(1:end),fs*scale));
    %fftdata(i,1:5)=0;
    L=length(fftdata(1:end/2));
    f_vec=[1:L]/scale;
    x=(f_vec(f_range(1)*scale:f_range(2)*scale));
    fdata=fftdata(f_range(1)*scale:f_range(2)*scale);
    
    for n=1:n_peaks %2 peaks
        [M_temp,I_temp]=max(fdata);  %prev peak(2) and peak(1)
        peak(1,n)=x(I_temp); %frequency
        peak(2,n)=M_temp; %magnitude
        %handle index out of bounds
        if(I_temp-remove<1)
            fdata(1:I_temp+remove)=0;
        end
        if (I_temp+remove>length(fdata))
                fdata(I_temp-remove:end)=0;
        end      
        if(I_temp+remove<=length(fdata)&&I_temp-remove>=1)
            fdata(I_temp-remove:I_temp+remove)=0;
        end
    end
     
    score_max=60*(peak(1,2)-peak(1,1));
    score_mean=60*(peak(1,2)-peak(1,1));
    score_median=60*(peak(1,2)-peak(1,1));
end

