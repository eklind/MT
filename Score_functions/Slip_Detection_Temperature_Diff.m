function [score_max,score_mean,score_median]=Slip_Detection_Temperature_Diff(Temp,Compressor_Clutch,settleTime)
%Slip detection for compressor of motor side

L=size(Compressor_Clutch,2); %Number off events
stoptime=Compressor_Clutch(2,end);
score_vec=[]; %initial score [-100:100]
for i=2:L-1
        %looping through compressor clutch events
        event_startTime=Compressor_Clutch(2,i);
        event_stopTime=Compressor_Clutch(2,i)+settleTime;
        
        max_diff=max(abs(diff(Temp(event_startTime:event_stopTime))));
        %ratio between bottom and before compressor change again
        
        
        %higher score from larger difference
        score_tmp=max_diff;
        score_vec=[score_vec score_tmp];

end
score_max=max(score_vec);
score_mean=mean(score_vec);
score_median=median(score_vec);
end

%for debugging
%plot(Temp)
%hold on
%plot(event_startTime:event_stopTime-1,Temp(event_startTime:event_stopTime))