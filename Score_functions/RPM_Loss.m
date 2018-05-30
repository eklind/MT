function score=RPM_Loss(Comp_RPM,Comp_Status,time)
% returns the rpm difference on compressor side when the compressor changes
% status
    nr_events=size(Comp_Status,2)-1;
    diff_data1=[];
    diff_data2=[];
    diff_data3=[];
    for event=2:nr_events
        compSwitch=Comp_Status(:,event)

            %def
            start_time=(compSwitch(2));
            
            buffer_time=time;
            L=length(Comp_RPM);

            %if within data
            if(buffer_time<start_time &&start_time+buffer_time<start_time+2*buffer_time)
                data1=mean(Comp_RPM(start_time-buffer_time:start_time));
                data2=mean(Comp_RPM(start_time+buffer_time:start_time+2*buffer_time));
                 diff_data1=[diff_data1 abs(data1-data2)]; 
            end

    end
    score=diff_data1;
end