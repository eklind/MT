function score_vec=Slip_Detection_Temperature(Temp,Compressor_Clutch,settleTime,averageTime)
%Slip detection for compressor or motor side using temperatures

L=size(Compressor_Clutch,2); %Number off events
stoptime=Compressor_Clutch(2,end);
score_vec=[]; %initial score [-100:100]
for i=2:L
        %looping through compressor clutch events
        event_startTime=Compressor_Clutch(2,i);

        %start,stop and minimum value
        if(event_startTime-averageTime<=0)
            init_val=mean(Temp(1:event_startTime));
        else
            init_val=mean(Temp(event_startTime-averageTime:event_startTime));
        end
        
        if(event_startTime+averageTime+settleTime<=stoptime)
            end_val=mean(Temp(event_startTime+settleTime:event_startTime+averageTime+settleTime));
        else
            end_val=mean(Temp(event_startTime+settleTime:stoptime));
        end
        %ratio between bottom and before compressor change again
        ratio=init_val/end_val;
        
        %higher score from larger difference
        score_tmp=10000*(ratio-1)^2;
        score_vec=[score_vec score_tmp];
end
end


% for debugging

% plot(Temp)
% hold on
% plot(event_startTime+settleTime:event_startTime+averageTime+settleTime,Temp(event_startTime+settleTime:event_startTime+averageTime+settleTime))
% plot(event_startTime-averageTime:event_startTime,Temp(event_startTime-averageTime:event_startTime)