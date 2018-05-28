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

%write to log file
fileID = fopen('logfile.txt','w');

Compnr=0; %clutch init status
Kurtosis_Calltime=0;
Pinch_Detection_Calltime=0;
Slip_Temp_Detection_Calltime=0;

    
L=length(struct.LF.Time);
for i=1:L
    if(i==struct.LF.Comp_Status(2,Compnr+1))%if clutch switches
        Compnr=Compnr+1;
        if(struct.LF.Comp_Clutch(1,Compnr)==1) %compressor turns on
            Kurtosis_Calltime=i+3;
            Pinch_Detection_Calltime=i+10;
            Slip_Temp_Detection_Calltime=i+10;
        else %compressor turns off
            Slip_Temp_Detection_Calltime=i+10;
        end
    end
    
    %if any function should be called
     if(mod(i,window)==0)%make analysis independent of compressor clutch
        formatSpec = '/-----Time %4.0f-------/\n';
        fprintf(fileID,formatSpec,i);
        %warn for high drive belt temperature
        try
            Temperature_Drive_Belt=belt_life_est(struct.LF.Drive_Belt_Surface_Temp(i-window:i));

            formatSpec='Loss of drive belt life is %4.2f \n';
            fprintf(fileID,formatSpec,Temperature_Drive_Belt.Temperature);
        catch
            formatSpec='Function not implemented or error \n';
            fprintf(fileID,formatSpec);
        end
        %warn for high compressor belt temperature
        try
            Temperature.Comp_Belt=belt_life_est(struct.LF.Compressor_Belt_Temp(i-window:i));

            formatSpec='Loss of drive belt life is %4.2f\n';
            fprintf(fileID,formatSpec,Temperature.Comp_Belt);
        catch
            formatSpec='Function not implemented or error';
            fprintf(fileID,formatSpec);
        end
    end
    if(i==Kurtosis_Calltime)
       %Kurtosis when load is added
%     try
%      kurt= KurtImpAcc(struct.HF.Time__sec_(t_LF(i,1):t_LF(i,2)),...
%          struct.LF.Comp_Status,...
%          struct.LF.Compressor_Discharge_Pressure(t_LF(i,1):t_LF(i,2)),...
%          struct.HF.Accelerometer_Z_Axis(t_HF(i,1):t_HF(i,2)));
%      
%         formatSpec='Kurtosis is %4.2f \n';
%         fprintf(fileID,formatSpec,kurt(i));
%      catch 
%          formatSpec='Function not implemented or error \n';
%          fprintf(fileID,formatSpec);
%      end
    end
    if(i==Pinch_Detection_Calltime)
       %call function 
    end
    if(i==Slip_Temp_Detection_Calltime)
       %call function 
    end
    
   
end
end


% for i=1:numbers
%     %For every partition, call all functions for prediction
%     %In the real system this could be the collected data for some time
%     
%     %/////////////////////////////////
%     %-------Tension------------------%
%     %/////////////////////////////////
%     
%    
%      %Slip in Temperature
%      try
%      Temp_diff_drive=Slip_Detection_Temperature(struct.LF.Drive_Belt_Surface_Temp(t_LF(i,1):t_LF(i,2)),...
%          struct.LF.Comp_Status,2,5);
%      
%          formatSpec = 'Slip is %4.4f \n';
%          fprintf(fileID,formatSpec,Temp_diff_drive(i));
%     catch 
%         formatSpec='Function not implemented or error \n';
%         fprintf(fileID,formatSpec);
%     end
%      
%     try
%      Temp_diff_comp=Slip_Detection_Temperature(struct.LF.Compressor_Belt_Temp(t_LF(i,1):t_LF(i,2)),...
%          struct.LF.Comp_Status,2,5);
%         formatSpec = 'Temp diff in compressor belt: %4.4f \n';
%          fprintf(fileID,formatSpec,Temp_diff_comp(i));
%     catch 
%         formatSpec='Function not implemented or error \n';
%         fprintf(fileID,formatSpec);
%     end
%      
%     %Slip from RPM
%     try
%          Tension.Slip(i)=Slip_Detection_RPM(struct.LF.Drive_RPM(t_LF(i,1):t_LF(i,2)),...
%              struct.LF.Comp_RPM(t_LF(i,1):t_LF(i,2))); 
%          
%          formatSpec = 'Temp diff in drive belt %4.4f \n';
%          fprintf(fileID,formatSpec,Tension.Slip(i));
%     catch 
%         formatSpec='Function not implemented or error \n';
%         fprintf(fileID,formatSpec);
%     end
%     
%     %frequency relationship from accelerometer z
%     try
%         Tension.Freq(i)=Belt_Tension_Frequency(struct.HF.Accelerometer_Z_Axis(t_HF(i,1):t_HF(i,2)),...
%         struct.LF.Drive_RPM(t_LF(i,1):t_LF(i,2)),2500,100,15);
%     
%         formatSpec='RPM difference is %4.2f \n';
%         fprintf(fileID,formatSpec,Tension.Freq(i));
%     catch
%         formatSpec='Function not implemented or error \n';
%         fprintf(fileID,formatSpec);
%     end
%     
%     %detecting decrease in rpm when load is added
%     try
%      Tension.Pinch= Pinch_Detection(struct.LF.Drive_RPM(t_LF(i,1):t_LF(i,2)),...
%          struct.LF.Comp_Status,...
%          struct.LF.Compressor_Discharge_Pressure(t_LF(i,1):t_LF(i,2)));
%      
%         formatSpec='Pinch is %4.2f \n';
%         fprintf(fileID,formatSpec,Tension.Pinch);
%     catch 
%         formatSpec='Function not implemented or error \n';
%         fprintf(fileID,formatSpec);
%     end
%     
%     
% 
%     %/////////////////////////////////
%     %-------Other Warnings------------------%
%     %/////////////////////////////////
%     
%     
% 
%     % Close log sequence
%     formatSpec='/------End------/ \n\n';
%     fprintf(fileID,formatSpec);
%        
%     
% 
%     
% end
% %------------ debugging/plotting results-------------------
%     subplot(4,3,1)
%     hold on
%     title('Temperature diff in drive belt')
%     ylabel('dtemp')
%     plot(Temp_diff_drive,'*-')
%     
%     subplot(4,3,2)
%     hold on
%     title('Temperature diff in comp belt')
%     ylabel('dtemp')
%     plot(Temp_diff_comp,'*-')
% 
%     subplot(4,3,4)
%     hold on
%     title('LowTension.Freq')
%     ylabel('Ratio')
%     plot(Tension.Freq,'*-')
%     
%     subplot(4,3,7)
%     hold on
%     title('Kurtosis')
%     try
%         plot(kurt,'*-')
%     catch
%     end
%     ylabel('Kurtosis')
%     
%     subplot(4,3,8)
%     hold on
%     title('Pinch')
%     try
%         plot(Tension.Pinch,'*-')
%     catch
%     end
%     ylabel('Pinch')
%     
%     subplot(4,3,10)
%     hold on
%     title('Drive\_Belt.Temperature')
%     plot(Temperature.Drive_Belt,'*-')
%     ylabel('Life Reduction')
%     ylim([0 1])
%     
%     subplot(4,3,11)  
%     hold on
%     title('Comp\_Belt.Temperature')
%     plot(Temperature.Comp_Belt,'*-')
%     ylabel('Life Reduction')
%     xlabel('Sequence')
%     ylim([0 1])
%     
%         subplot(4,3,12)
%     hold on
%     title('slip\_RPM')
%     plot(Tension.Slip,'*-')
% 
% fclose(fileID);
% end