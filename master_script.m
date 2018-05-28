function master_script(struct,window)
clf
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

t_HF=Make_Time_Vector(struct,2500,window);
t_LF=Make_Time_Vector(struct,1,window);
numbers=size(t_LF,1);

 %write to log file
 fileID = fopen('logfile.txt','w');
for i=1:numbers
    %for every partition, call all functions for prediction

    %----Low Tension------------------%
    %----Slip_Ratio---------%
    [~,LowTension.Slip,~]=Slip_Detection_RPM(struct.LF.Drive_RPM(t_LF(i,1):t_LF(i,2)),struct.LF.Comp_RPM(t_LF(i,1):t_LF(i,2))); 

    %----High Tension------------------%
    
    
    %------Warnings---------%
    Drive_Belt.Temperature=belt_life_est(struct.LF.Drive_Belt_Surface_Temp(t_LF(i,1):t_LF(i,2)));
    Comp_Belt.Temperature=belt_life_est(struct.LF.Compressor_Belt_Temp(t_LF(i,1):t_LF(i,2)));


   
    %log file
    formatSpec = '/-----%4.0f-------/\n Slip is %4.2f \n Loss of drive belt life is %4.2f \n Loss of drive belt life is %4.2f\n /------End------/ \n';
    fprintf(fileID,formatSpec,i,LowTension.Slip,Drive_Belt.Temperature,Comp_Belt.Temperature)
    

    % debugging/plotting results
    subplot(3,3,1)
    hold on
    title('slip\_RPM')
    plot(i,LowTension.Slip,'r*')
    subplot(3,3,7)
    hold on
    title('Drive\_Belt.Temperature')
    plot(i,Drive_Belt.Temperature,'r*')
        subplot(3,3,8)  
    hold on
    title('Comp\_Belt.Temperature')
    plot(i,Comp_Belt.Temperature,'r*')
end
end