function filtered_struct =data_filt(input_struct)

%Copy the structs so the returned struct will have the same values if
% no fitlering is done
filtered_struct = input_struct;
% ======== Filter instances ===================================

%Moving mean
k=10;
MA = ones(k)*(1/k); %can be used as moving average

%Kalman rpm parameters
Td=1;
A=[1 Td; 0 0];
H=[1 0];
Q=0.02;
R=1;
x_0=[0;0];
P_0=eye(2);

%===============================================================    

    % ==== Filter RPM signals ===================
    rpm_motor = input_struct.LF.Drive_RPM;
    rpm_comp = input_struct.LF.Comp_RPM;
    
    rpm_motor_filt = kalmanFilter(rpm_motor,rpm_motor(1),P_0,A,Q,H,R);
    rpm_comp_filt = kalmanFilter(rpm_comp,rpm_comp(1),P_0,A,Q,H,R);
    
    filtered_struct.LF.Drive_RPM = rpm_motor_filt;
    filtered_struct.LF.Compressor_RPM = rpm_comp_filt;
    
    % ==== Filter Pressure signals ==============
    P_Suc = input_struct.LF.Compressor_Suction_Pressure;
    P_Dis = input_struct.LF.Compressor_Discharge_Pressure; 
    
    P_Suc_filt = conv(P_Suc,MA);
    P_Dis_filt = conv(P_Dis,MA);
     
    filtered_struct.LF.Compressor_Suction_Pressure = P_Suc_filt;
    filtered_struct.LF.Compressor_Discharge_Pressure = P_Dis_filt;
    
    % ==== Filter Temperature signals ===========
    T_Drive_belt = input_struct.LF.Compressor_Belt_Temp;
    T_Pull = input_struct.LF.Pulley_Surface_Temp;
    T_Pull = input_struct.LF.Pulley_Surface_Temp;
    T_Pull = input_struct.LF.Pulley_Surface_Temp;
    T_Pull = input_struct.LF.Pulley_Surface_Temp;
    T_Pull = input_struct.LF.Pulley_Surface_Temp;
    
    % todo add temperature filters
    
    % ==== Filter Displacement signal ===========
    filtered_struct.HF.Belt_Displacement=input_struct.LF.Belt_Displacement;
    
    % ==== Fitler Accelerometer signals =========
    %X
    filtered_struct.HF.Accelerometer_X_Axis=input_struct.HF.Accelerometer_X_Axis;
    %Y
    filtered_struct.HF.Accelerometer_Y_Axis=input_struct.HF.Accelerometer_Y_Axis;
    %Z
    filtered_struct.HF.Accelerometer_Z_Axis=input_struct.HF.Accelerometer_Z_Axis;




end