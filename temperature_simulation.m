test=make_data_struct
%initial values
%%
tension=300; %---------Change this to the tension of the test-------------

%%
%clear
clf
tension_contribution=[];
air_contribution=[];
speed_contribution=[];

%generated signals
    % drive_rpm=1200*zeros(1,length(t));
    % drive_rpm(ceil(60/fs):floor(2000/fs))=1;
    % air_temp=24*ones(1,length(t));

% signals from test
%drive_rpm=test.LF.Drive_RPM;
drive_rpm=test.LF.VFD_Voltage_Output*3.9;
air_temp=test.LF.Cond_Air_In;



%simulation
    %sim_length=length(drive_rpm); %seconds
sim_length=length(test.LF.Time__sec_);

fs=1/test.LF.Sampling_Rate_Hz;   %sample time
    %t=linspace(0,sim_length,sim_length/fs);
t=linspace(0,sim_length,sim_length);
    %pulley_temp=air_temp(1);
pulley_temp=test.LF.Pulley_Surface_Temp(1);

pulley_temperature=pulley_temp;


%design parameters
material_factor=0.00020; %how fast the temperatures are changing in the pulley
speed_factor=0.30; %how much heat that developes from the speed
air_factor=0.01; %how mush heat that is added or removed from the air
air=300; % heat that is added or removed from air without pulley moving
tension_factor=0.0001; %how much heat that developes from the tension


%run
for i=2:length(drive_rpm)
    %difference between pulley and air
    temp_diff=air_temp(i-1)-pulley_temperature(i-1);

    %tension contribution
    tension_contribution(i)=tension_factor*tension*drive_rpm(i);

    %air cooling
    air_contribution(i)=air_factor*(drive_rpm(i)+air)*temp_diff;

    %speed contribution
    speed_contribution(i)=speed_factor*drive_rpm(i);

    %total
    pulley_temperature(i)=pulley_temperature(i-1)+fs*material_factor*(speed_contribution(i)+air_contribution(i)+tension_contribution(i));

    %output
    if(drive_rpm(i)*tension_factor~=0)
        tension_est(i)=((((test.LF.Pulley_Surface_Temp(i)-test.LF.Pulley_Surface_Temp(i-1))/(fs*material_factor))-speed_contribution(i)-air_contribution(i)))/(drive_rpm(i)*tension_factor);
    else
        tension_est(i)=0;
    end
end

%

subplot(2,2,1)
hold on
plot(t,pulley_temperature,'.-')
plot(test.LF.Pulley_Surface_Temp)
%plot(pulley_temperature-test.LF.Pulley_Surface_Temp)
legend('model','test', 'diff')

subplot(2,2,2)
plot(t,test.LF.Drive_RPM)
hold on
plot(t,test.LF.VFD_Voltage_Output*3.9)
legend('drive rpm','estimated from voltage')

subplot(2,2,3)
%plot(t,test.LF.Cond_Air_In-test.LF.Pulley_Surface_Temp)
plot(t,tension_est)
ylim([0 1000])
legend('tension estimate')

subplot(2,2,4)
plot(t,test.LF.Pulley_Surface_Temp)
hold on
plot(t,test.LF.Compressor_Belt_Temp)
plot(t,test.LF.Drive_Belt_Surface_Temp)
legend('pulley temp','comp temp', 'drive temp')


%% plot
plot(t,drive_rpm,'.-')

%% 
plot(t,speed_contribution,'.-')
hold on
plot(t,air_contribution,'.-')
plot(t,tension_contribution,'.-')
plot(t,speed_contribution+air_contribution+tension_contribution,'.-')
legend('speed','air','tension','sum')


%% backup values

material_factor=0.00010;
speed_factor=0.30;
air_factor=0.01;
air=300;
tension_factor=0.0001; %0.00005 for t124