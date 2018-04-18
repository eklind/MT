%kalman_test
data=T4_76_76_7;
plot(data.LF.Comp_RPM)
hold on
plot(data.LF.Drive_RPM*1.25)

%% compressor
Td=1;
A=[1 Td; 0 0]
B=0;
C=1;
D=0;
H=[1 0];
Q=0.002;
R=1;
x_0=[0;0];
P_0=100*eye(2);

[Xcomp,Pcomp]=kalmanFilter(data.LF.Comp_RPM,x_0,P_0,A,Q,H,R);

%% drive
%xdrive,xdrive_d xdrive_dd
%m=2
%n=3
Td=1;
A=[1 Td 0*(Td^2)/2; 0 0 0; 0 0 0]
C=1;
H=[1 0 0];
Q=0.01*eye(3);
R=1*eye(1);
x_0=[0;0;0];
P_0=100*eye(3);
[Xdrive,Pdrive]=kalmanFilter(data.LF.Drive_RPM,x_0,P_0,A,Q,H,R);

%% evaluate filter
plot(data.LF.Comp_RPM*0.8,'r.','Linewidth',1)
hold on
plot(data.LF.Drive_RPM,'b.','Linewidth',1)
plot(Xcomp(1,:)*0.8,'r--','Linewidth',2)
plot(Xdrive(1,:),'b--','Linewidth',2)

plot(Xcomp(1,1:end)*0.8-Xdrive(1,1:end),'g')
legend('comp','drive','compFiltered','driveFiltered','diff')
hold off

%% compare rpm

