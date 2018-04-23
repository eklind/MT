function data=calibrate_temps(data,air_temp)
%see temp offsets
if(nargin<2)
    air_temp=20;
end
% %system
% Compressor_Belt_Temp_Init=mean(data.g_1Hz_Data.Compressor_Belt_Temp.data(1:10))
% Drive_Belt_Temp_Init=mean(data.g_1Hz_Data.Drive_Belt_Surface_Temp.data(1:10))
% Pulley_Surface_Temp_Init=mean(data.g_1Hz_Data.Pulley_Surface_Temp.data(1:10))
% 
% %in
% Evap_Air_In_Init=mean(data.g_1Hz_Data.Evap_Air_In.data(1:10))
% Cond_Air_In_Init=mean(data.g_1Hz_Data.Cond_Air_In.data(1:10))
% Condenser_Refrigerant_In_Init=mean(data.g_1Hz_Data.Condenser_Refrigerant_In.data(1:10))
% Evaporator_Refrigerant_In_Init=mean(data.g_1Hz_Data.Evaporator_Refrigerant_In.data(1:10))
% %out
% Evap_Air_Out_Init=mean(data.g_1Hz_Data.Evap_Air_Out.data(1:10))
% Cond_Air_Out_Init=mean(data.g_1Hz_Data.Cond_Air_Out.data(1:10))
% Evaporator_Refrigerant_Out_Init=mean(data.g_1Hz_Data.Evaporator_Refrigerant_Out.data(1:10))

%Measurement from an idle test
Compressor_Belt_Temp_Init=25.370023443675528; 
Cond_Air_In_Init=19.660565047788210; 
Cond_Air_Out_Init=18.422639178462910; 
Condenser_Refrigerant_In_Init=19.316996715443360;
Drive_Belt_Temp_Init=24.864449537539420; 
Evap_Air_In_Init=20.539826774261833; 
Evap_Air_Out_Init=20.851394831880530; 
Evaporator_Refrigerant_In_Init=21.114903106445116 ;
Evaporator_Refrigerant_Out_Init=21.168863244753325 ;
Pulley_Surface_Temp_Init=21.529224523437970;

%compensate in data struct
data.g_1Hz_Data.Compressor_Belt_Temp.data=data.g_1Hz_Data.Compressor_Belt_Temp.data-(Compressor_Belt_Temp_Init-air_temp);
data.g_1Hz_Data.Drive_Belt_Surface_Temp.data=data.g_1Hz_Data.Drive_Belt_Surface_Temp.data-(Drive_Belt_Temp_Init-air_temp);
data.g_1Hz_Data.Pulley_Surface_Temp.data=data.g_1Hz_Data.Pulley_Surface_Temp.data-(Pulley_Surface_Temp_Init-air_temp);

data.g_1Hz_Data.Evap_Air_In.data=data.g_1Hz_Data.Evap_Air_In.data-(Evap_Air_In_Init-air_temp);
data.g_1Hz_Data.Cond_Air_In.data=data.g_1Hz_Data.Cond_Air_In.data-(Cond_Air_In_Init-air_temp);
data.g_1Hz_Data.Condenser_Refrigerant_In.data=data.g_1Hz_Data.Condenser_Refrigerant_In.data-(Condenser_Refrigerant_In_Init-air_temp);
data.g_1Hz_Data.Evaporator_Refrigerant_In.data=data.g_1Hz_Data.Evaporator_Refrigerant_In.data-(Evaporator_Refrigerant_In_Init-air_temp);

data.g_1Hz_Data.Evap_Air_Out.data=data.g_1Hz_Data.Evap_Air_Out.data-(Evap_Air_Out_Init-air_temp);
data.g_1Hz_Data.Cond_Air_Out.data=data.g_1Hz_Data.Cond_Air_Out.data-(Cond_Air_Out_Init-air_temp);
data.g_1Hz_Data.Evaporator_Refrigerant_Out.data=data.g_1Hz_Data.Evaporator_Refrigerant_Out.data-(Evaporator_Refrigerant_Out_Init-air_temp);
end