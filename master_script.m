function [Score,Warning]= master_script(struct,window)

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
t_LF=Make_Time_Vector(struct,struct.LF.Sampling_Rate_Hz,window);
numbers=size(t_LF,1);

% 
Total_Score=0;
slip_score =0;
acc_freq_score =0;
% ========= Define Limits =========
        T_diff_drive=1;
        T_diff_comp=1;
        Pinch_lim=1.23; %ok
        RPM_loss_lim=0.98;
        Slip_lim=1.24; %<1.24 is lower tension
        acc_freq_lim=1.023; %1.022-1.026 lower is lower tension

%write to log file
fileID = fopen('logfile.txt','w');

%store number of switches
if(length(struct.LF.Comp_Status(1,:))>1)
    compOn=sum(struct.LF.Comp_Status(1,2:end));
    compOff=length(struct.LF.Comp_Status(1,2:end))-compOn;
else
    compOn=0;
    compOff=0;
end

%Slip in Temperature
%      try
     Score.Temp_Diff_drive=Slip_Detection_Temperature(struct.LF.Drive_Belt_Surface_Temp,...
         struct.LF.Comp_Status,30,1);
     
         formatSpec = 'Temp diff in drive belt: %4.4f \n';
         fprintf(fileID,formatSpec,Score.Temp_Diff_drive);
%     catch 
%         formatSpec='Error in temp diff drive \n';
%         fprintf(fileID,formatSpec);
%      end
%Slip in Temperature
%     try
     Score.Temp_diff_comp=Slip_Detection_Temperature(struct.LF.Compressor_Belt_Temp,...
         struct.LF.Comp_Status,30,1);
        formatSpec = 'Temp diff in compressor belt: %4.4f \n';
        fprintf(fileID,formatSpec,Score.Temp_diff_comp);
%     catch 
%         formatSpec='Error in temp diff comp \n';
%         fprintf(fileID,formatSpec);
%     end
    
%detecting decrease in rpm when load is added
%     try
     Score.Pinch= Pinch_Detection(struct.LF.Drive_RPM,...
         struct.LF.Comp_Status,...
         struct.LF.Compressor_Discharge_Pressure);
     
        formatSpec='Pinch is %4.2f \n';
        fprintf(fileID,formatSpec,Score.Pinch);
%     catch 
%         formatSpec='Error in pinch \n';
%         fprintf(fileID,formatSpec);
%     end
 
 %reduction in rpm in compressor event
%      try
     Score.RPM_Loss=RPM_Loss(struct.LF.Comp_RPM,...
         struct.LF.Compressor_Discharge_Pressure,struct.LF.Comp_Status,5,3,...
         struct.LF.Sampling_Rate_Hz);
     
         formatSpec = 'Temp diff in rpm loss: %4.4f \n';
         fprintf(fileID,formatSpec,Score.RPM_Loss);
%     catch 
%         formatSpec='Error in rpm loss \n';
%         fprintf(fileID,formatSpec);
%      end
    
%Kurtosis when load is added
%     try
     [~,~,~,~,~,Score.Kurtosis]= KurtImpAcc(struct.HF.Time__sec_,...
         struct.LF.Comp_Status,...
         struct.LF.Compressor_Discharge_Pressure,...
         struct.HF.Accelerometer_Z_Axis);
     
        formatSpec='Kurtosis is %4.2f \n';
        fprintf(fileID,formatSpec,Score.Kurtosis);
%      catch 
%          formatSpec='Error in Kurtosis \n';
%          fprintf(fileID,formatSpec);
%     end
    
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
         Score.Slip(:,i)=Slip_Detection_RPM(struct.LF.Drive_RPM(t_LF(i,1):t_LF(i,2)),...
             struct.LF.Comp_RPM(t_LF(i,1):t_LF(i,2))); 
         
         formatSpec = 'Slip from RPM %4.4f \n';
         fprintf(fileID,formatSpec,Score.Slip(i));
     catch 
         formatSpec='Error in slip RPM \n';
         fprintf(fileID,formatSpec);
     end
    
    %Frequency relationship from accelerometer z
        Score.Acc_Freq(i)=Belt_Tension_Frequency(struct.HF.Accelerometer_Z_Axis(t_HF(i,1):t_HF(i,2)),...
        struct.LF.Drive_RPM(t_LF(i,1):t_LF(i,2)),2500,100,30);
       %Score.Acc_Freq(i)=Frequency_Ratio(struct.HF.Accelerometer_Z_Axis(t_HF(i,1):t_HF(i,2)),...
    
        formatSpec='RPM difference is %4.4f \n';
        fprintf(fileID,formatSpec,Score.Acc_Freq(i));
%     catch
%         formatSpec='Error in Acc_Freq \n';
%         fprintf(fileID,formatSpec);
%     end

    
    % ========Check hard limits and assign points =========================
   
    slip_score = slip_score +( min(Score.Slip(:,i))>=Slip_lim);
    acc_freq_score = acc_freq_score + (Score.Acc_Freq(i) >= acc_freq_lim);

    
    

    %/////////////////////////////////
    %-------Other Warnings------------------%
    %/////////////////////////////////
    
    %warn for high drive belt temperature
%     try
        Warning.Drive_Belt_Temperature(i)=belt_life_est(struct.LF.Drive_Belt_Surface_Temp(t_LF(i,1):t_LF(i,2)));
        
        formatSpec='Loss of drive belt life is %4.2f \n';
        fprintf(fileID,formatSpec,Warning.Drive_Belt_Temperature(i));
%     catch
%         formatSpec='Error in drive belt temp warning \n';
%         fprintf(fileID,formatSpec);
%     end
    
    %warn for high compressor belt temperature
%     try
        Warning.Comp_Belt_Temperature(i)=belt_life_est(struct.LF.Compressor_Belt_Temp(t_LF(i,1):t_LF(i,2)));
        
        formatSpec='Loss of drive belt life is %4.2f\n';
        fprintf(fileID,formatSpec,Warning.Comp_Belt_Temperature(i));
%     catch
%         formatSpec='Error in comp belt temp warning';
%         fprintf(fileID,formatSpec);
%     end
    
      %warn for high pulley temperature
%     try
        Warning.Pulley_Surface_Temp(i)=belt_life_est(struct.LF.Pulley_Surface_Temp(t_LF(i,1):t_LF(i,2)));
        
        formatSpec='Loss of drive belt life is %4.2f\n';
        fprintf(fileID,formatSpec,Warning.Pulley_Surface_Temp(i));
%     catch
%         formatSpec='Error in comp belt temp warning';
%         fprintf(fileID,formatSpec);
%     end

    % Close log sequence
    formatSpec='/------End------/ \n\n';
    fprintf(fileID,formatSpec);
       
    
end
 
    
    Limits=[T_diff_drive; T_diff_comp;Pinch_lim;RPM_loss_lim];
    Calculated_val=[nanmedian(Score.Temp_Diff_drive); nanmedian(Score.Temp_diff_comp);
        min(Score.Pinch); min(Score.RPM_Loss)];      
    % Test Limits
   Limit_compare=Calculated_val <= Limits;
   %Sum Scores
   partial_score = sum(Limit_compare) + (slip_score+acc_freq_score)/numbers;
   Total_Score = Total_Score + partial_score + Score.Kurtosis*(Score.Kurtosis>=0);

%------------ debugging/plotting results-------------------
    disp(Total_Score)
    
    
    subplot(2,5,1)
    hold on
    ylabel('slip\_RPM(tension)')
    plot(nanmedian(Score.Slip,1),'*-')
    
    subplot(2,5,2)
    hold on
    ylabel('Tension Frequency Ratio') %note scaling
    plot(Score.Acc_Freq,'*-')          
    
    subplot(2,5,3)
    hold on
    ylabel('Temperature diff in drive belt')
    plot(mean(Score.Temp_Diff_drive),'*-')
    
    subplot(2,5,4)
    hold on
    ylabel('Temperature diff in comp belt')
    plot(mean(Score.Temp_diff_comp),'*-')


    
    subplot(2,5,5)
    hold on
%     try
        plot(Score.Kurtosis,'*-')
%     catch
%     end
    ylabel('Kurtosis')
    
    subplot(2,5,6)
    hold on
%     try
        plot(mean(Score.Pinch),'*-')
%     catch
%     end
    ylabel('Pinch')
    
    subplot(2,5,7)
    hold on
%     try
        plot(mean(Score.RPM_Loss),'*-')
%     catch
%     end
    ylabel('RPM\_Loss')
    
    subplot(2,5,8)
    hold on
    plot(Warning.Pulley_Surface_Temp,'*-')
    ylabel('Life Reduction Drive Belt')
    ylim([0 1])    
    
    subplot(2,5,9)
    hold on
    plot(Warning.Drive_Belt_Temperature,'*-')
    ylabel('Life Reduction Drive Belt')
    ylim([0 1])
    
    subplot(2,5,10)  
    hold on
    plot(Warning.Comp_Belt_Temperature,'*-')
    ylabel('Life Reduction of pulley bearings')
    xlabel('Sequence')
    ylim([0 1])
    


fclose(fileID);
end

