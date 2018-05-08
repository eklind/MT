function filtered_struct =data_filt(input_struct)

%Copy the structs so the returned struct will have the same values if
% no fitlering is done
filtered_struct = input_struct;

LF_fields = fieldnames(input_struct.LF);
HF_fields = fieldnames(input_struct.HF);

% ======== Filter instances ===================================
fs = input_struct.HF.Sampling_Rate_Hz;
f_w=5; %filter window
o_w=5; %outlier window

% Butterworth low-pass filter for accelerometer
wc_butt = 800/(0.5*fs); %cut-off at 800hz
[B_butt,A_butt] = butter(9,wc_butt,'low'); 
%===============================================================    

    % ==== Filter RPM signals ===================
    %moving average
    filtered_struct.LF.Drive_RPM = movmean(hampel(input_struct.LF.Drive_RPM,5),5);
    filtered_struct.LF.Comp_RPM = movmean(hampel(input_struct.LF.Comp_RPM,5),5);
    
    % ==== Filter Pressure signals ==============
    %moving average
    filtered_struct.LF.Compressor_Suction_Pressure =movmean(hampel(input_struct.LF.Compressor_Suction_Pressure,5),5);
    filtered_struct.LF.Compressor_Discharge_Pressure =movmean(hampel(input_struct.LF.Compressor_Discharge_Pressure,5),5);
    
    % ==== Filter Temperature signals ===========
    
    %belt system
    %removes outlier and then moving average
    filtered_struct.LF.Compressor_Belt_Temp=movmean(hampel(input_struct.LF.Compressor_Belt_Temp,5),5);
    filtered_struct.LF.Pulley_Surface_Temp=movmean(hampel(input_struct.LF.Pulley_Surface_Temp,5),5);
    filtered_struct.LF.Drive_Belt_Surface_Temp=movmean(hampel(input_struct.LF.Drive_Belt_Surface_Temp,5),5);
    
    %Air temps
    %removes outlier and then moving average
    filtered_struct.LF.Evap_Air_In=movmean(hampel(input_struct.LF.Evap_Air_In,5),5);
    filtered_struct.LF.Evap_Air_Out=movmean(hampel(input_struct.LF.Evap_Air_Out,5),5);
    filtered_struct.LF.Cond_Air_In=movmean(hampel(input_struct.LF.Cond_Air_In,5),5);
    filtered_struct.LF.Cond_Air_Out=movmean(hampel(input_struct.LF.Cond_Air_Out,5),5);
    
    
    %Refrigerant temps
    %removes outlier and then moving average
    filtered_struct.LF.Evaporator_Refrigerant_In=movmean(hampel(input_struct.LF.Evaporator_Refrigerant_In,5),5);
    filtered_struct.LF.Evaporator_Refrigerant_Out=movmean(hampel(input_struct.LF.Evaporator_Refrigerant_Out,5),5);
    filtered_struct.LF.Condenser_Refrigerant_In=movmean(hampel(input_struct.LF.Condenser_Refrigerant_In,5),5);
   
    % ==== Filter Current and Voltage =========
    %removes outlier and then moving average
    if(sum(contains(LF_fields,{'VFD_Voltage_Output','VFD_Current_Output'})))
        filtered_struct.LF.VFD_Voltage_Output=movmean(hampel(input_struct.LF.VFD_Voltage_Output,5),5);
        filtered_struct.LF.VFD_Current_Output=movmean(hampel(input_struct.LF.VFD_Current_Output,5),5);
    end
      
    % ==== Filter Displacement signal ===========
    %No filter yet, add frequency filter
    filtered_struct.HF.Belt_Displacement=frequency_filter_60hz(input_struct.HF.Belt_Displacement);
    
    % ==== Filter Accelerometer signals =========
    %Unfiltered(low noise)
    %X
    filtered_struct.HF.Accelerometer_X_Axis=filtfilt(B_butt,A_butt,input_struct.HF.Accelerometer_X_Axis);
    %Y
    filtered_struct.HF.Accelerometer_Y_Axis=filtfilt(B_butt,A_butt,input_struct.HF.Accelerometer_Y_Axis);
    %Z
    filtered_struct.HF.Accelerometer_Z_Axis=filtfilt(B_butt,A_butt,input_struct.HF.Accelerometer_Z_Axis);
end