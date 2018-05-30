function [cond,kurt, start_time, e] = KurtImpAcc(t,compStatus, disP, accz)
%Takes HF time, compressor status and compressor discharege pressure and accelerometer data
% and calculates the kurtosis value of the impulse response. 
% Assumes fs=1Hz for disharge pressure
fs=1/mean(diff(t));
compStatus=compStatus(:,2:end);
comp_on = compStatus(2,compStatus(1,:)==1); % Compressor-on times
N=size(comp_on,2); %Number of times compressor goes on 

%time window to look for lokal minimum in pressure
t_before=1;
t_after=5;
e=6*fs;%Time to monitor the impulse respones [s]
b=2; %window shift [negative]


%Find the time index when the compressor discharge pressure is lowest
% and the extract the corresponding accelerometer data
if(N)
    if(comp_on(1,1)>=2)
        for i=1:N
            t1=comp_on(i)-t_before;
            t2=comp_on(i)+t_after;
            [~,start_time(i)] = min(disP(t1:t2)); 
            start_time(i) = (t1+start_time(i)-b)*fs;
            impAcc(:,(i)) = accz(start_time(i):(start_time(i)+e));
%             normAcc(:,(i)) = accz((start_time(i)-10*fs):(start_time(i)+e-10*fs));
        end
        kurt = kurtosis(impAcc); %[1xN]
%         norm_kurt=kurtosis(normAcc);
        kurt=kurt-3.1770; %Calculate difference from a normal dist.
%         kurt=kurt-3;
        kurt=kurt.^2; %square the difference
    else
        kurt=0;
    end
else
    kurt=0;
end

if max(kurt) > 3
       cond = 3;
elseif mean(kurt)>=1
       cond = 2;
elseif (1>=mean(kurt))&&(mean(kurt)>=0.5)
       cond = 1;
    elseif mean(kurt)<0.5
       cond=0;
else
    cond = -1;
end

end









