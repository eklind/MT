%kalman_test
%data=T4_76_76_7;
data=TDMS_getStruct();

comprpm=data.g_1Hz_Data.Comp_RPM.data;
driverpm=data.g_1Hz_Data.Drive_RPM.data;

%data.LF.Drive_RPM;
%data.LF.Comp_RPM;

%%
plot(comprpm)
hold on
plot(driverpm*1.25)

%% compressor
Td=1;
A=[1 Td; 0 1];
H=[1 0];
Q=0.02;
R=1;
x_0=[0;0];
fac_drive=cov(comprpm(1:20));
P_0=fac_drive*eye(2);

[Xcomp,Pcomp]=kalmanFilter(comprpm,x_0,P_0,A,Q,H,R);

%% drive
%xdrive,xdrive_d xdrive_dd
%m=2
%n=3
Td=1;
A=[1 Td 1*(Td^2)/2; 0 0 0; 0 0 0];
H=[1 0 0];
Q=0.02*eye(3);
R=1*eye(1);
x_0=[0;0;0];
fac_comp=cov(driverpm(1:20));
P_0=fac_comp*eye(3);
[Xdrive,Pdrive]=kalmanFilter(driverpm,x_0,P_0,A,Q,H,R);

%% evaluate filter

hold on

plot(Xcomp(1,:),'b--','Linewidth',2)
plot(movmean(comprpm,5),'b.-')
plot(comprpm,'b-','Linewidth',1)

%plot(driverpm*1.25,'b-','Linewidth',1)
%plot(Xdrive(1,:)*1.25,'b--','Linewidth',2)
%plot(movmean(driverpm*1.25,5),'b-')


%plot(Xcomp(1,1:end)*0.8-Xdrive(1,1:end),'g')
legend('compKal','compMean','comp','compFiltered','driveFiltered','compmovmean','diff')
hold off

%% compare rpm

%plot(diff(Xcomp(1,200:800)*0.8-Xdrive(1,200:800)),'g')

%%
window=10;
B=statistical_metrics(comprpm',window)
C=statistical_metrics(driverpm',window)

plot(B.mean)
hold on 
plot(C.mean)
hold off


%%
drivetemp=data.g_1Hz_Data.Drive_Belt_Surface_Temp.data;
drivetempfilt=movmean(drivetemp,10);
comptemp=data.g_1Hz_Data.Compressor_Belt_Temp.data;
comptempfilt=movmean(comptemp,10);
pulleytemp=data.g_1Hz_Data.Pulley_Surface_Temp.data;
pulleytempfilt=movmean(pulleytemp,10);
hold on

plot(drivetemp)
plot(drivetempfilt)
plot(comptemp)
plot(comptempfilt)
plot(pulleytemp)
plot(pulleytempfilt)
legend('drive','drive filtered','comp','comp filtered','pulley','pulley filtered');
hold off

%% vibration
vibration=data.g_1kHz_Data.Belt_Displacement.data;

%%
plot(vibration)