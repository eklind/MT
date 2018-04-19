function filterd_struct =data_filt(input_struct)

%Copy the structs so the returned struct will have the same values if
% no fitlering is done
filtered_struct = input_struct;
% ======== Filter instances ===================================
k=10;
MA = ones(k)*(1/k); %can be used as moving average

%Kalman parameters
A=[];
Q=[];
R=[];


% and so on.......
%===============================================================    

    % ==== Filter RPM signals ===================
    rpm_motor = input_struct.LF.Drive_RPM;
    rpm_com = input_struct.LF.Comp_RPM;
    
    rpm_motor = kalmanFilt()
    
    filtered_struct.LF.Drive_RPM = rpm_motor__;
    
    % ==== Filter Pressure signals ==============
    P_Suc = input_struct.LF.Compressor_Suction_Pressure;
    P_Dis = input_struct.LF.Compressor_Discharge_Pressure; 
    
    P_Suc__ = conv(P_suc,MA);
     
    filtered_struct.LF.Compressor_Suction_Pressure = P_Suc__;
    
    
    % ==== Filter Temperature signals ===========
    T_Drive_belt = input_struct.LF.Drive_Belt_Surface_Temp;
    T_Pull = input_struct.LF.Pulley_Surface_Temp;
    
    
    % ==== Filter Displacement signal ===========
    
    
    % ==== Fitler Accelerometer signals =========
    
    




end