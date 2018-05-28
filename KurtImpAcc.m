function kurt = KurtImpAcc(t,compStatus, disP, accz)
%Takes HF time, compressor status and compressor discharege pressure and accelerometer data
% and calculates the kurtosis value of the impulse response. 
% Assumes fs=1Hz for disharge pressure
fs=1/mean(diff(t));
comp_on = compStatus(2,compStatus(1,:)==1); % Compressor-on times
N=size(comp_on,2); %Number of times compressor goes on 

%time window to look for lokal minimum in pressure
t_before=1;
t_after=5;
e=3*fs;%Time to monitor the impulse respones [s]


%Find the time index when the compressor discharge pressure is lowest
% and the extract the corresponding accelerometer data
if(sum(comp_on)>=1)
    for i=1:N
        t1=comp_on(i)-t_before;
        t2=comp_on(i)+t_after;
        [~,start_time] = min(disP(t1:t2)); 
        start_time = (t1+start_time-1)*fs;
        impAcc(:,(i)) = accz(start_time:(start_time+e));
    end
    kurt = kurtosis(impAcc); %[1xN]
    kurt=kurt-3;
    kurt=kurt.^2;
else
    kurt=0;
end
    



end









