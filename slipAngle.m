% Using the engineering solution in "The Stretching and Slipping of
% Belts and Fibers on Pulleys" to calculate slip angles
% Asumes two pulleys with same diameter 
clear all
clc

% Physical parameters
D1=0.254; %m
% v1=1:1:30; %m/s
v1=25; 
mu=0.6; %Friction coeff
T_init=22:100; %N
M=2; %Nm
r1=D1/2; %Pully radius
k=25e3; %Belt stiffness factor 
w1=v1/(pi*D1)*2*pi; %rad/s
G=0.5; %Mass flow rate kg/s

% Solution Coefficients
A=M/(2*r1*k);
B=T_init/k;
C=G*w1*r1/k;


% Slip angle
beta=(1./mu)*log((B+A-C)./(B-A-C)); %rad
beta_deg= beta.*180/pi %deg

plot(T_init,beta_deg,'-o')
grid on
axis equal


