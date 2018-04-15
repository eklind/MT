clear all
clc
% Load raw data

% Read the sampled data, in the following order:
%1=time, 2=rpm1, 3=rpm2, 4=temp1, 5=temp2, 6=laser, 7=pressure,
% 8=AccX, 9=AccY, 10=AccZ
file_name = 'data_struct_table.xlsx';
[lf_data,~,~] = xlsread(file_name,1);
[hf_data,~,~] = xlsread(file_name,2);
[lf_samples,lf_sensors]=size(lf_data);
[hf_samples,hf_sensors]=size(hf_data);

% experiment specific parameters
params = {'Enter nominal motor speed','Enter nominal belt tension on motor side',...
    'Enter nominal belt tension on compressoe side','Enter nominal compressor load',...
    'Enter ambient temperature'};

% Gui for parameter input
dim1=[1 50];
run_param = inputdlg(params,'Enter Run Parameters',dim1);
nom_vel = str2double(run_param{1});
nom_ten_motor = str2double(run_param{2});
nom_ten_comp = str2double(run_param{3});
comp_load = str2double(run_param{4});
amb_temp = str2double(run_param{5});

lf_sensor_list={'Time','Date','Temperature 1','Temperature 2',...
    'Temperature 3','Temperature 4','Temperature 5','Temperature 6',...
    'Temperature 7','Temperature 8','Temperature 9','Temperature 10',...
    'Velocity 1','Velocity 2','Pressure 1','Pressure 2'};
dim2=[0.7 70];
lf_definput={'1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1'};
lf_used_sensors = inputdlg(lf_sensor_list,'Specify what has been measured with low frequency',dim2,lf_definput);
n_lf_sensors = size(lf_used_sensors);

dim3=[1 70];
hf_sensor_list={'Time','Laser','Accelerometer'};
hf_definput={'1','1','1'};
hf_used_sensors = inputdlg(hf_sensor_list,'Specify what has been measured with high frequency',dim2,hf_definput);
n_hf_sensors = size(hf_used_sensors);




% Interpret ths user input
used_lf_sensors_num=[]; 
used_hf_sensors_num=[];
nn=1;
for n=1:n_lf_sensors(1)
    used_lf_sensors_num(n) = str2double(lf_used_sensors{n});
    if used_lf_sensors_num(n)==1
        updated_lf_sensor_list{nn} = lf_sensor_list{n};
        nn=nn+1;
    end
    
end
mm=1;
for m=1:n_hf_sensors(1)
    used_hf_sensors_num(m) = str2double(hf_used_sensors{m});
    if used_hf_sensors_num(m)==1
        updated_hf_sensor_list{mm} = hf_sensor_list{m};
        mm=mm+1;
    end
    
end

%
%===== Does not work right now, need a way to update sensor_list based on
%the user input
% indx = used_sensors_num.*(1:length(used_sensors_num));
% [~,indx ]= nnc((used_sensors_num*(-1)+1));
% updated_sensor_list = lf_sensor_list{indx};



%======================================================================
% Create the top level data structure
OP1 = struct('Nom_motor_RPM',nom_vel,'Nom_Tension_motor',nom_ten_motor,...
    'Nom_Tension_comp',nom_ten_comp,'Compressor_load',comp_load,...
    'Ambient_Temp',amb_temp);
% Create two data structures, for high and low speed sampling.

% High freq. sampling
% HF = struct('time',hf_data(:,1));

% Low freq. sampling
% LF = struct('time',lf_data(:,1),'date',lf_data(:,2));
LF = struct('first',1);

% Velocities
% LF.v1 = 
% LF.v2 =

% Temperatures
% LF.t1 = lf_data(:,3);
% LF.t2 = lf_data(:,4);
% LF.t3 = lf_data(:,5);
% LF.t4 = lf_data(:,6);
% LF.t5 = lf_data(:,7);
% LF.t6 = lf_data(:,8);
% LF.t7 = lf_data(:,8);
% LF.t8 = lf_data(:,3);
% LF.t9 = lf_data(:,3);

% Pressures
% LF.p1 = 
% LF.p2 = 





% Fill the fields with appropiate sensor values
% OP1.t=T;
% OP1.v1 = V;
% OP1.v2 = 1.25*V;
% OP1.temp1 = temp;
% OP1.temp2 = 1.1*temp;
% OP1.laser = laser_disp;

for i=updated_lf_sensor_list
    while j<=lf_samples
    LF.(i{j}) = data(:,j);
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



