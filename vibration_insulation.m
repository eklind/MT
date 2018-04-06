% Testing the effect of placing the test rig on vibration insulating pads
% Tests were conducted by jumping from a height of 4dm on the floor aprox 
% 1m from the test rig, 5 times for each case

% Load data
clear all
clc
load 'jumps5_noinsul_500hz.txt'
load 'jumps5_insul_500hz.txt'
no_insul = jumps5_noinsul_500hz;
insul= jumps5_insul_500hz;
clear jumps5_insul_500hz jumps5_noinsul_500hz



%%
fs = 320; %hz
ts=1/fs;
t1=0:ts:(length(no_insul)*ts-ts);
t1=t1';
t2=0:ts:(length(insul)*ts-ts);
t2=t2';

plot(t1,no_insul)
hold on
plot(t2,insul)



