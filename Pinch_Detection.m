function [score_max,score_mean,score_median]=Pinch_Detection(Drive_RPM,Compressor_Clutch,Discharge_Pressure)
%1x RPM vector
%2xn vector for clutch status(boolean,time)
%,Discharge_Pressure
L=size(Compressor_Clutch,2); %Number off events
score_vec=[]; %initial score [-100:100]
for i=1:L-1
%looping through compressor clutch events
event_startTime=Compressor_Clutch(2,i);
event_stopTime=Compressor_Clutch(2,i+1);

%if clutch on
if(Compressor_Clutch(1,i)==1)
    %if clutch later off
    if(Compressor_Clutch(1,i+1)==0)
        %start,stop and minimum value
        [min_val,min_index]=min(Drive_RPM(event_startTime:event_stopTime));
        init_val=Drive_RPM(event_startTime);
        end_val=Drive_RPM(event_stopTime);

        %load factor, high means high load->drop is less bad
        %load_factor=mean(Discharge_Pressure(event_startTime:event_stopTime));
        load_factor=Discharge_Pressure(event_stopTime)/115 %115 from no load
        
        %ratio between bottom and before compressor change again
        ratio=min_val/end_val;

        %normalize with Compressor Discharge Pressure to compensate for load
        %score_tmp=mean_pressure-(ratio*mean_pressure);
        score_tmp=100*(1-ratio^4)/(load_factor);
        score_vec=[score_vec score_tmp];
    end
end
end
score_vec
score_max=max(score_vec);
score_mean=mean(score_vec);
score_median=median(score_vec);
end
