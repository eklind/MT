function score_vec= Belt_Tension_Frequency(Accelerometer_Z_Axis,rpm,fs,scale,remove)
%fs=2500;
%scale=100;
fftdata=[];

%finds the relationships between frequency peaks in a frequency interval 

    f_center=mean(rpm)/60;
    f_range=[floor(f_center)-2 ceil(f_center)+2]; %plus minus 2 hz
    n_peaks=2;
    
    %Accelerometer_Z_Axis=Accelerometer_Z_Axis(Find_Longest_SS(Accelerometer_Z_Axis,20));
    
    peak=zeros(2,2);
    fftdata=abs(fft(Accelerometer_Z_Axis(1:end),fs*scale));
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
        %score_vec=(abs(peak(1,2)./peak(1,1)));
     if (peak(1,2)>peak(1,1))
        score_vec=(abs(peak(1,2)./peak(1,1)));
     else
         score_vec=(abs(peak(1,1)./peak(1,2)));
     end
end

