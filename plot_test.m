function plot_test(struct_path)
% %%plot test data
data=struct_path;
%Plot
figure(1)
tlt=strcat('tension motor: ',string(data.Nom_Tension_motor),', tension compressor:',string(data.Nom_Tension_comp));
title(tlt);

%temperature
subplot(5,1,1)
hold on
plot(data.LF.Time_sec,data.LF.Compressor_Belt_Temp)
plot(data.LF.Time_sec,data.LF.Pulley_Surface_Temp)
plot(data.LF.Time_sec,data.LF.Evap_Air_In)
plot(data.LF.Time_sec,data.LF.Drive_Belt_Surface_Temp)
plot(data.LF.Time_sec,data.LF.Cond_Air_In)
plot(data.LF.Time_sec,data.LF.Condenser_Refrigerant_In)
plot(data.LF.Time_sec,data.LF.Evap_Air_Out)
plot(data.LF.Time_sec,data.LF.Cond_Air_Out)
plot(data.LF.Time_sec,data.LF.Evaporator_Refrigerant_In)
plot(data.LF.Time_sec,data.LF.Evaporator_Refrigerant_Out)
legend('Compressor\_Belt\_Temp','Pulley\_Surface\_Temp','Evap\_Air\_In',...
    'Drive\_Belt\_Surface\_Temp','Cond\_Air\_In','Condenser\_Refrigerant\_In',...
    'Evap\_Air\_Out','Cond\_Air_Out','Evaporator\_Refrigerant\_In',...
    'Evaporator\_Refrigerant\_Out');
xlabel('Time');
ylabel('Temp.');
hold off

%rpm
subplot(5,1,2)
plot(data.LF.Time_sec,data.LF.Comp_RPM)
hold on
plot(data.LF.Time_sec,data.LF.Drive_RPM)
legend('Comp\_RPM','Drive\_RPM');
xlabel('Time');
ylabel('RPM');
hold off

%pressure
subplot(5,1,3)
plot(data.LF.Time_sec,data.LF.Compressor_Suction_Pressure)
hold on
plot(data.LF.Time_sec,data.LF.Compressor_Discharge_Pressure)
legend('Compressor\_Suction\_Pressure','Compressor\_Discharge\_Pressure');
xlabel('Time');
ylabel('PSI');
hold off

%displacement
subplot(5,1,4)
plot(data.HF.Time_sec,data.HF.Belt_Displacement)
hold on
legend('Belt\_Displacement');
xlabel('Time');
ylabel('mm');
hold off

%acceleration
subplot(5,1,5)
hold on
legend('X','Y','Z');
xlabel('Time');
ylabel('g');
hold off

end