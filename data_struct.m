clear all
clc
% Load raw data

% Read the sampled data, in the following order:
%1=time, 2=rpm1, 3=rpm2, 4=temp1, 5=temp2, 6=laser, 7=pressure,
% 8=AccX, 9=AccY, 10=AccZ
file_name = 'test_table.xlsx';
[data,txt,~] = xlsread(file_name);
[n,m]=size(data);

% ID=input('Enter ID \n','s');
params = {'Enter nominal motor speed','Enter nominal belt tension on motor side',...
    'Enter nominal belt tension on compressoe side','Enter nominal compressor load',...
    'Enter ambient temperature'};
dim1=[1 50];

run_param = inputdlg(params,'Enter Run Parameters',dim1);

nom_vel = str2double(run_param{1});
nom_ten_motor = str2double(run_param{2});
nom_ten_comp = str2double(run_param{3});
comp_load = str2double(run_param{4});
amb_temp = str2double(run_param{5});

sensor_list={'Time','Velocity 1','Velocity 2','Temperature 1','Temperature 2',...
    'Laser','Acceleration X','Acceleration Y','Acceleration Z'};
dim2=[1 30];
definput={'1','1','1','1','1','1','0','0','0'};
used_sensors = inputdlg(sensor_list,'Specify what has been measured',dim2,definput);
n_sensors = size(used_sensors);
used_sensors_num=[];
for n=1:n_sensors(1)
    used_sensors_num(n) = str2double(used_sensors{n});
end


%===== Does not work right now, need a way to update sensor_list based on
%the user input
indx = used_sensors_num.*(1:length(used_sensors_num));
[~,indx ]= nnc((used_sensors_num*(-1)+1));
updated_sensor_list = sensor_list{indx};
%======================================================================
% Create the data structure
OP1 = struct('Nom_motor_RPM',nom_vel,'Nom_Tension_motor',nom_ten_motor,...
    'Nom_Tension_comp',nom_ten_comp,'Compressor_load',comp_load,...
    'Ambient_Temp',amb_temp);

%%
% Fill the fields with appropiate sensor values
% OP1.t=T;
% OP1.v1 = V;
% OP1.v2 = 1.25*V;
% OP1.temp1 = temp;
% OP1.temp2 = 1.1*temp;
% OP1.laser = laser_disp;

for i={'t','v1','v2','temp1','temp2','laser','AccX','AccY','AccZ'}
    while j<=m
    OP1.(i{1}) = data(:,j);
    j=j+1;
    end
end
    





%%
% ===== Dummy values ==============
T=1:100;
V=1000*ones(1,100);
temp= 40*ones(1,100);
laser_disp = ones(1,100);
% ============================



