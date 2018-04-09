clear all
clc
% Load raw data

% Read the sampled data, in the following order:
%1=time, 2=rpm1, 3=rpm2, 4=temp1, 5=temp2, 6=laser, 7=pressure

data = readtable('test_table.xlsx');
[n,m]=size(data);




% Create the data structure


ID=input('Enter ID \n','s');
nom_vel = input('Enter nominal motor speed \n');
nom_ten_motor = input('Enter nominal belt tension on motor side \n');
nom_ten_comp = input('Enter nominal belt tension on compressoe side \n');
comp_load = input('Enter nominal compressor load \n');
amb_temp = input('Enter ambient temperature \n');

OP1 = struct('ID',ID,'Nom_motor_RPM',nom_vel,'Nom_Tension_motor',nom_ten_motor,...
    'Nom_Tension_comp',nom_ten_comp,'Compressor_load',comp_load,...
    'Ambient_Temp',amb_temp,'Compressor_Load',1,'Ambient_Temp',20);

%%
% Fill the fields with appropiate sensor values
% OP1.t=T;
% OP1.v1 = V;
% OP1.v2 = 1.25*V;
% OP1.temp1 = temp;
% OP1.temp2 = 1.1*temp;
% OP1.laser = laser_disp;

for i={'t','v1','v2','temp1','temp2','laser'}
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



