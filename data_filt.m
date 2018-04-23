function filtered_struct =data_filt(input_struct)

%Copy the structs so the returned struct will have the same values if
% no fitlering is done
filtered_struct = input_struct;
% ======== Filter instances ===================================

%Moving mean
k=10;
MA = ones(1,k)*(1/k); %can be used as moving average

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
    %Kalman filter
    rpm_motor = input_struct.LF.Drive_RPM;
    rpm_comp = input_struct.LF.Comp_RPM;
    
    rpm_motor_filt = kalmanFilter(rpm_motor,[rpm_motor(1);0],P_0,A,Q,H,R);
    rpm_comp_filt = kalmanFilter(rpm_comp,[rpm_comp(1);0],P_0,A,Q,H,R);
    
    filtered_struct.LF.Drive_RPM = rpm_motor_filt(1,:);
    filtered_struct.LF.Compressor_RPM = rpm_comp_filt(1,:);
    
    % ==== Filter Pressure signals ==============
    %moving average
    P_Suc = input_struct.LF.Compressor_Suction_Pressure;
    P_Dis = input_struct.LF.Compressor_Discharge_Pressure; 
    
    P_Suc_filt = conv(P_Suc,MA);
    P_Dis_filt = conv(P_Dis,MA);
     
    filtered_struct.LF.Compressor_Suction_Pressure = P_Suc_filt;
    filtered_struct.LF.Compressor_Discharge_Pressure = P_Dis_filt;
    
    % ==== Filter Temperature signals ===========
    %Moving average
    
    %belt system
    Compressor_Belt_Temp = input_struct.LF.Compressor_Belt_Temp;
    Pulley_Surface_Temp = input_struct.LF.Pulley_Surface_Temp;
    Drive_Belt_Surface_Temp = input_struct.LF.Drive_Belt_Surface_Temp;
    filtered_struct.LF.Compressor_Belt_Temp_filt=conv(Compressor_Belt_Temp,MA);
    filtered_struct.LF.Pulley_Surface_Temp_filt=conv(Pulley_Surface_Temp,MA);
    filtered_struct.LF.Drive_Belt_Surface_Temp_filt=conv(Drive_Belt_Surface_Temp,MA);
    
    %Air temps
    Evap_Air_In = input_struct.LF.Evap_Air_In;
    Evap_Air_Out = input_struct.LF.Evap_Air_Out;
    Cond_Air_In = input_struct.LF.Cond_Air_In;
    Cond_Air_Out = input_struct.LF.Cond_Air_Out;
    filtered_struct.LF.Evap_Air_In=conv(Evap_Air_In,MA);
    filtered_struct.LF.Evap_Air_Out=conv(Evap_Air_Out,MA);
    filtered_struct.LF.Cond_Air_In=conv(Cond_Air_In,MA);
    filtered_struct.LF.Cond_Air_Out=conv(Cond_Air_Out,MA);
    
    %Refrigerant temps
    Evaporator_Refrigerant_In=input_struct.LF.Evaporator_Refrigerant_In;
    Evaporator_Refrigerant_Out=input_struct.LF.Evaporator_Refrigerant_Out;
    Condenser_Refrigerant_In=input_struct.LF.Condenser_Refrigerant_In;
    filtered_struct.LF.Evaporator_Refrigerant_In=conv(Evaporator_Refrigerant_In,MA);
    filtered_struct.LF.Evaporator_Refrigerant_Out=conv(Evaporator_Refrigerant_Out,MA);
    filtered_struct.LF.Condenser_Refrigerant_In=conv(Condenser_Refrigerant_In,MA);
   
    % ==== Filter Current =========
    %No filter
    
    % ==== Filter Displacement signal ===========
    %No filter
    filtered_struct.HF.Belt_Displacement=input_struct.HF.Belt_Displacement;
    
    % ==== Filter Accelerometer signals =========
    %No filter
    %X
    filtered_struct.HF.Accelerometer_X_Axis=input_struct.HF.Accelerometer_X_Axis;
    %Y
    filtered_struct.HF.Accelerometer_Y_Axis=input_struct.HF.Accelerometer_Y_Axis;
    %Z
    filtered_struct.HF.Accelerometer_Z_Axis=input_struct.HF.Accelerometer_Z_Axis;



end