%%Test RPM=500
test500.x_raw=xlsread('AccData\500 RPM.xlsx','N45273 TSR101 - Data','C8:C12146');
test500.y_raw=xlsread('AccData\500 RPM.xlsx','N45273 TSR101 - Data','D8:D12146');
test500.z_raw=xlsread('AccData\500 RPM.xlsx','N45273 TSR101 - Data','E8:E12146');
L500=length(test500.x_raw(1:10000));

%% Structure by dividing all data in shunks
shunks_number=100;
test500.shunks.x=reshape(test500.x_raw(1:L500),[L500/shunks_number shunks_number])
test500.shunks.y=reshape(test500.y_raw(1:L500),[L500/shunks_number shunks_number])
test500.shunks.z=reshape(test500.z_raw(1:L500),[L500/shunks_number shunks_number])
test500.shunks.mean_x=mean(test500.shunks.x); %first moment of shunks
test500.shunks.mean_y=mean(test500.shunks.y); %first moment of shunks
test500.shunks.mean_z=mean(test500.shunks.z); %first moment of shunks
test500.shunks.var_x=var(test500.shunks.x); %second moment of shunks
test500.shunks.var_y=var(test500.shunks.y); %second moment of shunks
test500.shunks.var_z=var(test500.shunks.z); %second moment of shunks
test500.shunks.skew_x=skewness(test500.shunks.x); %third moment of shunks
test500.shunks.skew_y=skewness(test500.shunks.y); %third moment of shunks
test500.shunks.skew_z=skewness(test500.shunks.z); %third moment of shunks
test500.shunks.kurtosis_x=kurtosis(test500.shunks.x); %fourth moment of shunks
test500.shunks.kurtosis_y=kurtosis(test500.shunks.y); %fourth moment of shunks
test500.shunks.kurtosis_z=kurtosis(test500.shunks.z); %fourth moment of shunks
%plot(test500.shunks.mean_x,test500.shunks.kurtosis,'.')

%% Test RPM=750
test750.x_raw=xlsread('AccData\750 RPM.xlsx','N45273 TSR101 - Data','C8:C12146');
test750.y_raw=xlsread('AccData\750 RPM.xlsx','N45273 TSR101 - Data','D8:D12146');
test750.z_raw=xlsread('AccData\750 RPM.xlsx','N45273 TSR101 - Data','E8:E12146');
L750=length(test750.x_raw(1:10000));

%% Structure by dividing all data in shunks
%shunks_number=1000;
test750.shunks.x=reshape(test750.x_raw(1:L750),[L750/shunks_number shunks_number])
test750.shunks.y=reshape(test750.y_raw(1:L500),[L500/shunks_number shunks_number])
test750.shunks.z=reshape(test750.z_raw(1:L500),[L500/shunks_number shunks_number])
test750.shunks.mean_x=mean(test750.shunks.x); %first moment of shunks
test750.shunks.mean_y=mean(test750.shunks.y); %first moment of shunks
test750.shunks.mean_z=mean(test750.shunks.z); %first moment of shunks
test750.shunks.var_x=var(test750.shunks.x); %second moment of shunks
test750.shunks.var_y=var(test750.shunks.y); %second moment of shunks
test750.shunks.var_z=var(test750.shunks.z); %second moment of shunks
test750.shunks.skew_x=skewness(test750.shunks.x); %third moment of shunks
test750.shunks.skew_y=skewness(test750.shunks.y); %third moment of shunks
test750.shunks.skew_z=skewness(test750.shunks.z); %third moment of shunks
test750.shunks.kurtosis_x=kurtosis(test750.shunks.x); %fourth moment of shunks
test750.shunks.kurtosis_y=kurtosis(test750.shunks.y); %fourth moment of shunks
test750.shunks.kurtosis_z=kurtosis(test750.shunks.z); %fourth moment of shunks
%plot(test750.shunks.mean_x,test750.shunks.kurtosis,'.')

%% Test RPM=1020
test1020.x_raw=xlsread('AccData\1020 RPM.xlsx','N45273 TSR101 - Data','C8:C12146');
test1020.y_raw=xlsread('AccData\1020 RPM.xlsx','N45273 TSR101 - Data','D8:D12146');
test1020.z_raw=xlsread('AccData\1020 RPM.xlsx','N45273 TSR101 - Data','E8:E12146');
L1020=length(test1020.x_raw(1:10000));

%% Structure by dividing all data in shunks
%shunks_number=1000;
test1020.shunks.x=reshape(test1020.x_raw(1:L1020),[L1020/shunks_number shunks_number])
test1020.shunks.y=reshape(test1020.y_raw(1:L500),[L500/shunks_number shunks_number])
test1020.shunks.z=reshape(test1020.z_raw(1:L500),[L500/shunks_number shunks_number])
test1020.shunks.mean_x=mean(test1020.shunks.x); %first moment of shunks
test1020.shunks.mean_y=mean(test1020.shunks.y); %first moment of shunks
test1020.shunks.mean_z=mean(test1020.shunks.z); %first moment of shunks
test1020.shunks.var_x=var(test1020.shunks.x); %second moment of shunks
test1020.shunks.var_y=var(test1020.shunks.y); %second moment of shunks
test1020.shunks.var_z=var(test1020.shunks.z); %second moment of shunks
test1020.shunks.skew_x=skewness(test1020.shunks.x); %third moment of shunks
test1020.shunks.skew_y=skewness(test1020.shunks.y); %third moment of shunks
test1020.shunks.skew_z=skewness(test1020.shunks.z); %third moment of shunks
test1020.shunks.kurtosis_x=kurtosis(test1020.shunks.x); %fourth moment of shunks
test1020.shunks.kurtosis_y=kurtosis(test1020.shunks.y); %fourth moment of shunks
test1020.shunks.kurtosis_z=kurtosis(test1020.shunks.z); %fourth moment of shunks
%plot(test1020.shunks.mean_x,test1020.shunks.kurtosis,'.')


%% organize data

%data=[[test500.x; test750.x ;test1020.x ;test1500.x ;test1800.x] [test500.y; test750.y; test1020.y ;test1500.y ;test1800.y] [ test500.z; test750.z ;test1020.z ;test1500.z ;test1800.z] [500*ones(size(test500.x_raw));750*ones(size(test750.x_raw));1020*ones(size(test1020.x_raw));1500*ones(size(test1500.x_raw));1800*ones(size(test1800.x_raw))]];
para1x=[test500.shunks.mean_x';test750.shunks.mean_x';test1020.shunks.mean_x'];
para1y=[test500.shunks.mean_y';test750.shunks.mean_y';test1020.shunks.mean_y'];
para1z=[test500.shunks.mean_z';test750.shunks.mean_z';test1020.shunks.mean_z'];
para2x=[test500.shunks.var_x'; test750.shunks.var_x'; test1020.shunks.var_x'];
para2y=[test500.shunks.var_y'; test750.shunks.var_y'; test1020.shunks.var_y'];
para2z=[test500.shunks.var_z'; test750.shunks.var_z'; test1020.shunks.var_z'];
para3x=[test500.shunks.skew_x'; test750.shunks.skew_x'; test1020.shunks.skew_x'];
para3y=[test500.shunks.skew_y'; test750.shunks.skew_y'; test1020.shunks.skew_y'];
para3z=[test500.shunks.skew_z'; test750.shunks.skew_z'; test1020.shunks.skew_z'];
para4x=[test500.shunks.kurtosis_x'; test750.shunks.kurtosis_x'; test1020.shunks.kurtosis_x'];
para4y=[test500.shunks.kurtosis_y'; test750.shunks.kurtosis_y'; test1020.shunks.kurtosis_y'];
para4z=[test500.shunks.kurtosis_z'; test750.shunks.kurtosis_z'; test1020.shunks.kurtosis_z'];
label=[500*ones(1,shunks_number)';750*ones(1,shunks_number)';1020*ones(1,shunks_number)'];
data=[para1x para1y para1z para2x para2y para2z para3x para3y para3z para4x para4y para4z label];

%% Old 500
test500.mean.x=mean(test500.x_raw);
test500.mean.y=mean(test500.y_raw);
test500.mean.z=mean(test500.z_raw);
test500.mean.x100=mean(reshape(test500.x_raw(1:L500),[10,L500/10]));
test500.mean.y100=mean(reshape(test500.y_raw(1:L500),[10,L500/10]));
test500.mean.z100=mean(reshape(test500.z_raw(1:L500),[10,L500/10]));

test500.x=test500.x_raw -test500.mean.x;
test500.y=test500.y_raw -test500.mean.y;
test500.z=test500.z_raw -test500.mean.z;

test500.rms.x=rms(test500.x);
test500.rms.y=rms(test500.y);
test500.rms.z=rms(test500.z);

test500.var.x=var(test500.x);
test500.var.y=var(test500.y);
test500.var.z=var(test500.z);

test500.norm=norm([test500.x test500.y test500.z]);
for i=1:L500
    test500.norm(i)=norm([test500.x(i) test500.y(i) test500.z(i)]);
end

%% old 750
test750.mean.x=mean(test750.x_raw);
test750.mean.y=mean(test750.y_raw);
test750.mean.z=mean(test750.z_raw);
test750.mean.x100=mean(reshape(test750.x_raw(1:L750),[10,L750/10]));
test750.mean.y100=mean(reshape(test750.y_raw(1:L750),[10,L750/10]));
test750.mean.z100=mean(reshape(test750.z_raw(1:L750),[10,L750/10]));

test750.x=test750.x_raw -test750.mean.x;
test750.y=test750.y_raw -test750.mean.y;
test750.z=test750.z_raw -test750.mean.z;

test750.rms.x=rms(test750.x);
test750.rms.y=rms(test750.y);
test750.rms.z=rms(test750.z);

test750.var.x=var(test750.x);
test750.var.y=var(test750.y);
test750.var.z=var(test750.z);

for i=1:L750
    test750.norm(i)=norm([test750.x(i) test750.y(i) test750.z(i)]);
end
% %% ALSO OLD
% %% Test RPM=1020
% test1020.x_raw=xlsread('AccData\1020 RPM.xlsx','N45273 TSR101 - Data','C8:C12146');
% test1020.y_raw=xlsread('AccData\1020 RPM.xlsx','N45273 TSR101 - Data','D8:D12146');
% test1020.z_raw=xlsread('AccData\1020 RPM.xlsx','N45273 TSR101 - Data','E8:E12146');
% L1020=length(test1020.x_raw(1:10000));
% %%
% test1020.mean.x=mean(test1020.x_raw);
% test1020.mean.y=mean(test1020.y_raw);
% test1020.mean.z=mean(test1020.z_raw);
% test1020.mean.x100=mean(reshape(test1020.x_raw(1:L1020),[10,L1020/10]));
% test1020.mean.y100=mean(reshape(test1020.y_raw(1:L1020),[10,L1020/10]));
% test1020.mean.z100=mean(reshape(test1020.z_raw(1:L1020),[10,L1020/10]));
% 
% test1020.x=test1020.x_raw -test1020.mean.x;
% test1020.y=test1020.y_raw -test1020.mean.y;
% test1020.z=test1020.z_raw -test1020.mean.z;
% 
% test1020.rms.x=rms(test1020.x);
% test1020.rms.y=rms(test1020.y);
% test1020.rms.z=rms(test1020.z);
% 
% test1020.var.x=var(test1020.x);
% test1020.var.y=var(test1020.y);
% test1020.var.z=var(test1020.z);
% 
% for i=1:L1020
%     test1020.norm(i)=norm([test1020.x(i) test1020.y(i) test1020.z(i)]);
% end
% %% Test RPM=1500
% test1500.x_raw=xlsread('AccData\1500 RPM.xlsx','N45273 TSR101 - Data','C8:C12146');
% test1500.y_raw=xlsread('AccData\1500 RPM.xlsx','N45273 TSR101 - Data','D8:D12146');
% test1500.z_raw=xlsread('AccData\1500 RPM.xlsx','N45273 TSR101 - Data','E8:E12146');
% L1500=length(test1500.x_raw(1:10000));
% %%
% test1500.mean.x=mean(test1500.x_raw);
% test1500.mean.y=mean(test1500.y_raw);
% test1500.mean.z=mean(test1500.z_raw);
% test1500.mean.x100=mean(reshape(test1500.x_raw(1:L1500),[10,L1500/10]));
% test1500.mean.y100=mean(reshape(test1500.y_raw(1:L1500),[10,L1500/10]));
% test1500.mean.z100=mean(reshape(test1500.z_raw(1:L1500),[10,L1500/10]));
% 
% test1500.x=test1500.x_raw -test1500.mean.x;
% test1500.y=test1500.y_raw -test1500.mean.y;
% test1500.z=test1500.z_raw -test1500.mean.z;
% 
% test1500.rms.x=rms(test1500.x);
% test1500.rms.y=rms(test1500.y);
% test1500.rms.z=rms(test1500.z);
% 
% test1500.var.x=var(test1500.x);
% test1500.var.y=var(test1500.y);
% test1500.var.z=var(test1500.z);
% 
% for i=1:L1500
%     test1500.norm(i)=norm([test1500.x(i) test1500.y(i) test1500.z(i)]);
% end
% 
% %% Test RPM=1800
% test1800.x_raw=xlsread('AccData\1800 RPM.xlsx','N45273 TSR101 - Data','C8:C12146');
% test1800.y_raw=xlsread('AccData\1800 RPM.xlsx','N45273 TSR101 - Data','D8:D12146');
% test1800.z_raw=xlsread('AccData\1800 RPM.xlsx','N45273 TSR101 - Data','E8:E12146');
% L1800=length(test1800.x_raw(1:9000));
% %%
% test1800.mean.x=mean(test1800.x_raw);
% test1800.mean.y=mean(test1800.y_raw);
% test1800.mean.z=mean(test1800.z_raw);
% test1800.mean.x100=mean(reshape(test1800.x_raw(1:L1800),[10,L1800/10]));
% test1800.mean.y100=mean(reshape(test1800.y_raw(1:L1800),[10,L1800/10]));
% test1800.mean.z100=mean(reshape(test1800.z_raw(1:L1800),[10,L1800/10]));
% 
% test1800.x=test1800.x_raw -test1800.mean.x;
% test1800.y=test1800.y_raw -test1800.mean.y;
% test1800.z=test1800.z_raw -test1800.mean.z;
% 
% test1800.rms.x=rms(test1800.x);
% test1800.rms.y=rms(test1800.y);
% test1800.rms.z=rms(test1800.z);
% 
% test1800.var.x=var(test1800.x);
% test1800.var.y=var(test1800.y);
% test1800.var.z=var(test1800.z);
% 
% for i=1:L1800
%     test1800.norm(i)=norm([test1800.x(i) test1800.y(i) test1800.z(i)]);
% end
% %% 3D-plot
% %[X,Y] = meshgrid(1:0.5:10,1:20);
% %Z = sin(X) + cos(Y);
% plot3(test500.mean.x100,test500.mean.y100,test500.mean.z100,'.')
% hold on
% plot3(test750.mean.x100,test750.mean.y100,test750.mean.z100,'.')
% plot3(test1020.mean.x100,test1020.mean.y100,test1020.mean.z100,'.')
% plot3(test1500.mean.x100,test1500.mean.y100,test1500.mean.z100,'.')
% plot3(test1800.mean.x100,test1800.mean.y100,test1800.mean.z100,'.')