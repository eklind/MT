%Ratios
comp_vs_motor=1/2; %ratio between pulleys

%Sensor mean
mean.temp=20;
mean.rpm_motor=0;
mean.rpm_comp=0;
mean.tension=120;
mean.vibration=0;

%Sensor accuracy
acc.temp=1;
acc.rpm_motor=50;
acc.rpm_comp=50;
acc.tension=5;
acc.vibration=5;

%Sampled time
t=0:0.1:3600; %6 minutes
x=t/10000;

%Data trends
trend.temp=sin(2*pi*5*x) + 2*sin(2*pi*12*x);
trend.rpm_motor=min(1000,1*t)+50*sin(2*pi*10*x);
trend.rpm_comp=(min(1000,1*t)+50*sin(2*pi*10*x))/comp_vs_motor;
trend.tension=sin(2*pi*10*x);
trend.vibration=sin(2*pi*12*x)+sin(2*pi*5*x)+sin(2*pi*50*x);

%%Creating constant white noise, 4 values, 1000 points
temp=mean.temp*ones(1,length(t))+acc.temp*randn(1,length(t))+trend.temp;
rpm.motor=mean.rpm_motor*ones(1,length(t))+acc.rpm_motor*randn(1,length(t))+trend.rpm_motor;
rpm.comp=mean.rpm_comp*ones(1,length(t))+acc.rpm_comp*randn(1,length(t))+trend.rpm_comp;
tension=mean.tension*ones(1,length(t))+acc.tension*randn(1,length(t))+trend.tension;
vibration=mean.vibration*ones(1,length(t))+acc.vibration*randn(1,length(t))+trend.vibration;

data=[t;temp;rpm.motor;rpm.comp;tension;vibration]';
save logg.mat data
filename='dummy_data.xlsx';
xlswrite(filename,data);

%plot temperature vs time
subplot(2,3,1);
plot(data(:,1),data(:,2));
xlabel('time');
ylabel('temp');
ax.two=subplot(2,3,2);
plot(data(:,1),data(:,3));
xlabel('time');
ylabel('rpm_{motor}');
ax.three=subplot(2,3,3);
plot(data(:,1),data(:,4));
xlabel('time');
ylabel('rpm_{comp}');
ax.four=subplot(2,3,4);
plot(data(:,1),data(:,5));
xlabel('time');
ylabel('tension');
ax.five=subplot(2,3,5);
plot(data(:,1),data(:,6));
xlabel('time');
ylabel('vibration');
