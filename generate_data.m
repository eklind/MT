
%%Creating constant white noise, 4 values, 1000 points
temp_mean=20;
rpm_motor_mean=1000;
rpm_comp_mean=1000;
tension_mean=120;

t=1:1000;
temp=temp_mean*ones(1,1000)+5*randn(1,1000);
rpm.motor=rpm_motor_mean*ones(1,1000)+5*randn(1,1000);
rpm.comp=rpm_comp_mean*ones(1,1000)+5*randn(1,1000);
tension=tension_mean*ones(1,1000)+5*randn(1,1000);

A=[t;temp;rpm.motor;rpm.comp;tension]';
filename='dummy_data.xlsx';
xlswrite(filename,A)
