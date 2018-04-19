function data= plot_test()
% %%plot test data
data=TDMS_getStruct();
%Plot
figure(1)
%tlt=strcat('tension motor: ',string(data.Nom_Tension_motor),', tension compressor:',string(data.Nom_Tension_comp));
%title(tlt);

%temperature
subplot(5,1,1)
hold on
plot(data.g_1Hz_Data.Time__sec_.data,data.g_1Hz_Data.Compressor_Belt_Temp.data)
plot(data.g_1Hz_Data.Time__sec_.data,data.g_1Hz_Data.Pulley_Surface_Temp.data)
plot(data.g_1Hz_Data.Time__sec_.data,data.g_1Hz_Data.Evap_Air_In.data)
plot(data.g_1Hz_Data.Time__sec_.data,data.g_1Hz_Data.Drive_Belt_Surface_Temp.data)
plot(data.g_1Hz_Data.Time__sec_.data,data.g_1Hz_Data.Cond_Air_In.data)
plot(data.g_1Hz_Data.Time__sec_.data,data.g_1Hz_Data.Condenser_Refrigerant_In.data)
plot(data.g_1Hz_Data.Time__sec_.data,data.g_1Hz_Data.Evap_Air_Out.data)
plot(data.g_1Hz_Data.Time__sec_.data,data.g_1Hz_Data.Cond_Air_Out.data)
plot(data.g_1Hz_Data.Time__sec_.data,data.g_1Hz_Data.Evaporator_Refrigerant_In.data)
plot(data.g_1Hz_Data.Time__sec_.data,data.g_1Hz_Data.Evaporator_Refrigerant_Out.data)
legend('Compressor\_Belt\_Temp','Pulley\_Surface\_Temp','Evap\_Air\_In',...
    'Drive\_Belt\_Surface\_Temp','Cond\_Air\_In','Condenser\_Refrigerant\_In',...
    'Evap\_Air\_Out','Cond\_Air_Out','Evaporator\_Refrigerant\_In',...
    'Evaporator\_Refrigerant\_Out');
xlabel('Time');
ylabel('Temp.');
hold off

%rpm
subplot(5,1,2)
plot(data.g_1Hz_Data.Time__sec_.data,data.g_1Hz_Data.Comp_RPM.data)
hold on
plot(data.g_1Hz_Data.Time__sec_.data,data.g_1Hz_Data.Drive_RPM.data)
legend('Comp\_RPM','Drive\_RPM');
xlabel('Time');
ylabel('RPM');
hold off

%pressure
subplot(5,1,3)
plot(data.g_1Hz_Data.Time__sec_.data,data.g_1Hz_Data.Compressor_Suction_Pressure.data)
hold on
plot(data.g_1Hz_Data.Time__sec_.data,data.g_1Hz_Data.Compressor_Discharge_Pressure.data)
legend('Compressor\_Suction\_Pressure','Compressor\_Discharge\_Pressure');
xlabel('Time');
ylabel('PSI');
hold off

%displacement
subplot(5,1,4)
plot(data.g_1kHz_Data.Time__sec_.data,data.g_1kHz_Data.Belt_Displacement.data)
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