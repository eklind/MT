function [kurt,impuls_factor,shape_factor,crest_factor,L_kurt,cond, start_time, e] = KurtImpAcc(t,compStatus, disP, accz)
%Takes HF time, compressor status and compressor discharege pressure and accelerometer data
% and calculates the kurtosis value of the impulse response. 
% Assumes fs=1Hz for disharge pressure
fs=1/mean(diff(t));
compStatus=compStatus(:,2:end);
comp_on = compStatus(2,compStatus(1,:)==1); % Compressor-on times
N=size(comp_on,2); %Number of times compressor goes on 

%Infer LF sample freq
nF=length(disP)/length(accz);
fs_low =nF*fs;
%time window to look for local minimum in pressure

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
            [~,start_time(i)] = min(disP(t1*fs_low:t2*fs_low)); 
            start_time(i)=start_time(i)/fs_low;
            start_time(i) = (t1+start_time(i)-b)*fs;
            impAcc(:,(i)) = accz(start_time(i):(start_time(i)+e));
%             normAcc(:,(i)) = accz((start_time(i)-10*fs):(start_time(i)+e-10*fs));
%             Lth_mom = lmom(impAcc(:,i),4);
            L_kurt(i) = -1;
        end
        kurt = kurtosis(impAcc); %[1xN]
        impuls_factor = max(abs(impAcc))./mean(abs(impAcc));
%         shape_factor = var(impAcc)./mean(abs(impAcc));
        shape_factor = (mean((impAcc-mean(impAcc)).^4))/(mean((impAcc-mean(impAcc)).^4)).^2;
%         log_av = sum(log(abs(impAcc)+1))./log(var(impAcc));
        crest_factor = max(abs(impAcc))./var(impAcc);
        %         norm_kurt=kurtosis(normAcc);
        kurt=kurt-3.1770; 
%           kurt=kurt-2.7;
%         kurt=kurt-3;  %Calculate difference from a normal dist.
        kurt=kurt.^2; %square the difference
    else
        kurt=-1;
        impuls_factor = -1;
        shape_factor = -1;
        crest_factor = -1;
        L_kurt = -1;
        start_time = -1;
        e = -1;
    end
else
    kurt=-1;
    impuls_factor = -1;
    shape_factor = -1;
    crest_factor = -1;
    L_kurt = -1;
    start_time = -1;
    e = -1;
end

if max(kurt) > 3
       cond = 3;
elseif mean(kurt)>=1
       cond = 2;
elseif (1>=mean(kurt))&&(mean(kurt)>=0.5) %1 0.5
       cond = 1;
    elseif (0<=mean(kurt))&&(mean(kurt)<0.5)% 0 0.5
       cond=0;
else
    cond = -1;
end

end









