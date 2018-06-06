function score=RPM_Loss(RPM,Pressure,Comp_Status,av_time,buffer_time,sample_rate)
% returns the rpm difference on compressor side when the compressor changes

if(nargin<4)
    sample_rate=1;
end
% status
    nr_events=size(Comp_Status,2)-1;
    diff_data1=[];
    diff_data2=[];
    diff_data3=[];
    buffer_time=buffer_time*sample_rate;
    av_time=av_time*sample_rate;
    for event=2:nr_events
        compSwitch=Comp_Status(:,event);
            %def
            start_time=(compSwitch(2))*sample_rate;
            
            L=length(RPM);

            %if within data and not 0
            if(compSwitch(1)==0) %if turned off
            if(RPM(start_time)~=0)
                if(0<start_time-av_time &&start_time+buffer_time+av_time<length(RPM))
                    data1=mean(RPM(start_time-av_time:start_time)./Pressure(start_time-av_time:start_time));
                    data2=mean(RPM(start_time+buffer_time:start_time+av_time+buffer_time)./Pressure(start_time+buffer_time:start_time+av_time+buffer_time));
                    diff_data1=[diff_data1 (data2/data1)]; 
                     
                      % debug
%                         plot(Comp_RPM);
%                         hold on
%                         event
%                         plot(start_time-buffer_time:start_time,Comp_RPM(start_time-buffer_time:start_time),'Linewidth',2);
%                         plot(start_time+buffer_time:start_time+2*buffer_time,Comp_RPM(start_time+buffer_time:start_time+2*buffer_time),'Linewidth',2);
%                         hold off
%                         pause(0.5)
                end
            end
            end
    end
    score=diff_data1;
    if(isempty(score))
        score=0;
    end
end