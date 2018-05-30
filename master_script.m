function master_script(struct,window)

%-------input data----------
% Time (sec)
% Compressor Belt Temp
% Pulley Surface Temp
% Evap Air In
% Drive Belt Surface Temp
% Cond Air In
% Condenser Refrigerant In
% Evap Air Out
% Cond Air Out
% Evaporator Refrigerant In
% Evaporator Refrigerant Out
% Comp RPM
% Drive RPM
% Compressor Suction Pressure
% Compressor Discharge Pressure
% 
% Time (sec)
% Belt Displacement
% Accelerometer_X_Axis
% Accelerometer_Y_Axis
% Accelerometer_Z_Axis

if(nargin<2)
    window=length(struct.LF.Time);
end

t_HF=Make_Time_Vector(struct,2500,window);
t_LF=Make_Time_Vector(struct,1,window);
numbers=size(t_LF,1);



%write to log file
fileID = fopen('logfile.txt','w');

%store number of switches
if(length(struct.LF.Comp_Status(1,:))>1)
    compOn=sum(struct.LF.Comp_Status(1,2:end))
    compOff=length(struct.LF.Comp_Status(1,2:end))-compOn
else
    compOn=0
    compOff=0
end

%Slip in Temperature
     try
     Score.Temp_Diff_drive=Slip_Detection_Temperature(struct.LF.Drive_Belt_Surface_Temp,...
         struct.LF.Comp_Status,30,1);
     
         formatSpec = 'Temp diff in drive belt: %4.4f \n';
         fprintf(fileID,formatSpec,Score.Temp_Diff_drive);
    catch 
        formatSpec='Error in temp diff drive \n';
        fprintf(fileID,formatSpec);
     end
    try
     Score.Temp_diff_comp=Slip_Detection_Temperature(struct.LF.Compressor_Belt_Temp,...
         struct.LF.Comp_Status,30,1);
        formatSpec = 'Temp diff in compressor belt: %4.4f \n';
        fprintf(fileID,formatSpec,Score.Temp_diff_comp);
    catch 
        formatSpec='Error in temp diff comp \n';
        fprintf(fileID,formatSpec);
    end
    
    %detecting decrease in rpm when load is added
    try
     Score.Pinch= Pinch_Detection(struct.LF.Drive_RPM,...
         struct.LF.Comp_Status,...
         struct.LF.Compressor_Discharge_Pressure);
     
        formatSpec='Pinch is %4.2f \n';
        fprintf(fileID,formatSpec,Score.Pinch);
    catch 
        formatSpec='Error in pinch \n';
        fprintf(fileID,formatSpec);
    end
    
    %Kurtosis when load is added
    try
     Score.Kurtosis= KurtImpAcc(struct.HF.Time__sec_,...
         struct.LF.Comp_Status,...
         struct.LF.Compressor_Discharge_Pressure,...
         struct.HF.Accelerometer_Z_Axis);
     
        formatSpec='Kurtosis is %4.2f \n';
        fprintf(fileID,formatSpec,Score.Kurtosis);
     catch 
         formatSpec='Error in Kurtosis \n';
         fprintf(fileID,formatSpec);
    end
    
for i=1:numbers
    %For every partition, call all functions for prediction
    %In the real system this could be the collected data for some time
    
    %/////////////////////////////////
    %-------Tension------------------%
    %/////////////////////////////////
    
    %log file specification
    formatSpec = '/-----Sequence%4.0f-------/\n';
    fprintf(fileID,formatSpec,i);
     
     
    %Slip from RPM
     try
         Score.Slip(i)=Slip_Detection_RPM(struct.LF.Drive_RPM(t_LF(i,1):t_LF(i,2)),...
             struct.LF.Comp_RPM(t_LF(i,1):t_LF(i,2))); 
         
         formatSpec = 'Slip from RPM %4.4f \n';
         fprintf(fileID,formatSpec,Score.Slip(i));
    catch 
        formatSpec='Error in slip RPM \n';
        fprintf(fileID,formatSpec);
    end
    
    %frequency relationship from accelerometer z
    try
        %Score.Acc_Freq(i)=median(Belt_Tension_Frequency(struct.HF.Accelerometer_Z_Axis(t_HF(i,1):t_HF(i,2)),...
        Score.Acc_Freq(i)=mean(Frequency_Ratio(struct.HF.Accelerometer_Z_Axis(t_HF(i,1):t_HF(i,2)),...
        struct.LF.Drive_RPM(t_LF(i,1):t_LF(i,2)),2500,100,15));
    
        formatSpec='RPM difference is %4.2f \n';
        fprintf(fileID,formatSpec,Score.Acc_Freq(i));
    catch
        formatSpec='Error in Acc_Freq \n';
        fprintf(fileID,formatSpec);
    end
    
    

    %/////////////////////////////////
    %-------Other Warnings------------------%
    %/////////////////////////////////
    
    %warn for high drive belt temperature
    try
        Warning.Drive_Belt_Temperature(i)=belt_life_est(struct.LF.Drive_Belt_Surface_Temp(t_LF(i,1):t_LF(i,2)));
        
        formatSpec='Loss of drive belt life is %4.2f \n';
        fprintf(fileID,formatSpec,Warning.Drive_Belt_Temperature(i));
    catch
        formatSpec='Error in drive belt temp warning \n';
        fprintf(fileID,formatSpec);
    end
    
    %warn for high compressor belt temperature
    try
        Warning.Comp_Belt_Temperature(i)=belt_life_est(struct.LF.Compressor_Belt_Temp(t_LF(i,1):t_LF(i,2)));
        
        formatSpec='Loss of drive belt life is %4.2f\n';
        fprintf(fileID,formatSpec,Warning.Comp_Belt_Temperature(i));
    catch
        formatSpec='Error in comp belt temp warning';
        fprintf(fileID,formatSpec);
    end

    % Close log sequence
    formatSpec='/------End------/ \n\n';
    fprintf(fileID,formatSpec);
       
    

    
end
%------------ debugging/plotting results-------------------

%     ScorePlot=[sum(Score.Temp_Diff_drive) sum(Score.Temp_diff_comp) median(Score.Acc_Freq) ...
%         max(Score.Kurtosis)/10 sum(Score.Pinch) sum(Score.Slip)];
%         plot(ScorePlot);
%     hold on
    
%     plot(1,sum(Score.Temp_Diff_drive),'*')
%     hold on
%     plot(2,sum(Score.Temp_diff_comp),'*')
%     plot(3,median(Score.Acc_Freq),'*')
%     plot(4,max(Score.Kurtosis),'*')
%     plot(5,sum(Score.Pinch),'*')
%     plot(6,sum(Score.Slip),'*')
    
    
%     subplot(4,3,11)  
%     hold on
%     title('Belt.Temperature')
%     plot(Warning.Comp_Belt_Temperature,'*-')
%     plot(Warning.Drive_Belt_Temperature,'*-')
%     ylabel('Life Reduction')
%     xlabel('Sequence')
%     ylim([0 1])
    
subplot(4,3,1)
    hold on
    title('Temperature diff in drive belt')
    ylabel('dtemp')
    plot( Score.Temp_Diff_drive,'*-')
    
    subplot(4,3,2)
    hold on
    title('Temperature diff in comp belt')
    ylabel('dtemp')
    plot(Score.Temp_diff_comp,'*-')

    subplot(4,3,4)
    hold on
    title('Tension.Freq')
    ylabel('Ratio')
    plot(Score.Acc_Freq,'*-')
    
    subplot(4,3,7)
    hold on
    title('Kurtosis')
    try
        plot(Score.Kurtosis,'*-')
    catch
    end
    ylabel('Kurtosis')
    
    subplot(4,3,8)
    hold on
    title('Pinch')
    try
        plot(Score.Pinch,'*-')
    catch
    end
    ylabel('Pinch')
    
    subplot(4,3,10)
    hold on
    title('Drive\_Belt.Temperature')
    plot(Warning.Drive_Belt_Temperature,'*-')
    ylabel('Life Reduction')
    ylim([0 1])
    
    subplot(4,3,11)  
    hold on
    title('Comp\_Belt.Temperature')
    plot(Warning.Comp_Belt_Temperature,'*-')
    ylabel('Life Reduction')
    xlabel('Sequence')
    ylim([0 1])
    
    subplot(4,3,12)
    hold on
    title('slip\_RPM')
    plot(Score.Slip,'*-')

fclose(fileID);
end

