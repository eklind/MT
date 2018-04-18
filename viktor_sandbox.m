%% 
clear
clc
data=TDMS_getStruct();
%%
t=data.g_1Hz_Data.Time__sec_.data;
w_motor=data.g_1Hz_Data.Drive_RPM.data;
w_compressor = data.g_1Hz_Data.Comp_RPM.data;
T=1;
A=[1 T];    
Q=1;
R=1;

x_0=0;
P_0=1;
H=[1 0];


[X, P] = kalmanFilter(w_motor, x_0, P_0, A, Q, H, R);