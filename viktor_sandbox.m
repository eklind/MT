clear data
clc
data = make_data_struct();


%%
t_lf = data.LF.Time__sec_-data.LF.Time__sec_(1);
t_hf = data.HF.Time__sec_;
fs= data.HF.Sampling_Rate_Hz;
laser = data.HF.Belt_Displacement;


comp_rpm = data.LF.Comp_RPM;

N=5; %ds factor
fs_ds=fs/N;
% acc_xyz = [data.HF.Accelerometer_X_Axis data.HF.Accelerometer_Y_Axis data.HF.Accelerometer_Z_Axis];
% acc_xyz_ds =downsample(acc_xyz,N);
% t_hf_ds = downsample(t_hf,N);

clear acc_xyc
% clear t_hf
clear data

%%
laser_noise = laser(5900000:5950000);
t = t_hf(5900000:5950000);

%% 
noise_no_outliers = hampel(laser_noise,6);  

spectrogram(noise_no_outliers,[],[],[],10000)
%%
% t=0:(1/10000):size(laser_noise,2);
%%
f60=db2mag(-23); f120=db2mag(-41); f180=db2mag(-29); f240=db2mag(-40);
f300=db2mag(-46); f360=db2mag(-45); f420= db2mag(-45.9);

s1=f60*sin(60*2*pi*t+pi);
s2=f120*sin(2*60*2*pi*t+pi);
s3=f180*sin(3*60*2*pi*t+pi);
s4=f240*sin(4*60*2*pi*t+pi);
s5=f300*sin(5*60*2*pi*t+pi);
s6=f360*sin(6*60*2*pi*t+pi);
s7=f420*sin(7*60*2*pi*t+pi);
s=[s1' s2' s3' s4' s5' s6' s7'];
S=0.345;
hold on

for i=1:7
    clf
    hold on
    plot(noise_no_outliers)
    S = S+s(:,i);
    plot(S)
    axis([0 1000 0.2 0.5])
    pause(1)
    
end


% plot(S);

legend('reconstructed noise','real noise')
%%
S_cancel = noise_no_outliers + S;
figure()
plot(S_cancel)
hold on
plot(noise_no_outliers)

%%
laser_no_ol = hampel(laser,6);
N=size(laser_no_ol,2)/2;
FT = fft(laser_no_ol);
FT=FT(1:N);
FT2=[];
for j=1:N
    if abs(FT(j))<500
        FT2(j)=complex(0,imag(FT(j)));
    else
        FT2(j)=FT(j);
    end
end

plot(laser_no_ol)
hold on
FT2_shift = FT2*complex(-3,0);
new_sig= ifft(FT2_shift,2*N);
plot(abs(new_sig))

%% ========================================================================

data0 = make_data_struct();%95
% data1 = make_data_struct();%125
% data2 = make_data_struct();%150
% data3 = make_data_struct();%175
% data4 = make_data_struct();%200


%% LP filter
B=fir2(100,[0 0.05 0.07 1],[1 1 0 0]);
% B=[0.5 0.5]


%% l_lim:u_lim
l_lim = 200; %s
u_lim = 250; %S
l_lim=l_lim*10000+1;
u_lim=u_lim*10000+1;
% Low tension ===========================================
t0 = data0.HF.Time__sec_(l_lim:u_lim)';

raw_acc0 = [data0.HF.Accelerometer_X_Axis(l_lim:u_lim)'...
    data0.HF.Accelerometer_Y_Axis(l_lim:u_lim)' data0.HF.Accelerometer_Z_Axis(l_lim:u_lim)'];
acc_xyz0 = filtfilt(B,1,raw_acc0);
mag_xyz0 = vecnorm(acc_xyz0,2,2);

% intermediate low Tension ===========================================
t1 = data1.HF.Time__sec_(l_lim:u_lim)';

raw_acc1 = [data1.HF.Accelerometer_X_Axis(l_lim:u_lim)'...
    data1.HF.Accelerometer_Y_Axis(l_lim:u_lim)' data1.HF.Accelerometer_Z_Axis(l_lim:u_lim)'];
acc_xyz1 = filtfilt(B,1,raw_acc1);
mag_xyz1 = vecnorm(acc_xyz1,2,2);

% intermediate high Tension ===========================================
t2 = data2.HF.Time__sec_(l_lim:u_lim)';

raw_acc2 = [data2.HF.Accelerometer_X_Axis(l_lim:u_lim)'...
    data2.HF.Accelerometer_Y_Axis(l_lim:u_lim)' data2.HF.Accelerometer_Z_Axis(l_lim:u_lim)'];
acc_xyz2 = filtfilt(B,1,raw_acc2);
mag_xyz2 = vecnorm(acc_xyz2,2,2);


% High Tension ========================================================
t3 = data3.HF.Time__sec_(l_lim:u_lim)';

raw_acc3 = [data3.HF.Accelerometer_X_Axis(l_lim:u_lim)'...
    data3.HF.Accelerometer_Y_Axis(l_lim:u_lim)' data3.HF.Accelerometer_Z_Axis(l_lim:u_lim)'];
acc_xyz3 = filtfilt(B,1,raw_acc3);
mag_xyz3 = vecnorm(acc_xyz3,2,2);

% Highest Tension ========================================================
t4 = data4.HF.Time__sec_(l_lim:u_lim)';

raw_acc4 = [data4.HF.Accelerometer_X_Axis(l_lim:u_lim)'...
    data4.HF.Accelerometer_Y_Axis(l_lim:u_lim)' data4.HF.Accelerometer_Z_Axis(l_lim:u_lim)'];
acc_xyz4 = filtfilt(B,1,raw_acc4);
mag_xyz4 = vecnorm(acc_xyz4,2,2);
clc
%%

% acc_x0=vecnorm(acc_xyz0,2,2);
% acc_x1=vecnorm(acc_xyz1,2,2);
% acc_x2=vecnorm(acc_xyz2,2,2);
% acc_x3=vecnorm(acc_xyz3,2,2);
% acc_x4=vecnorm(acc_xyz4,2,2);

acc_x0=acc_xyz0(:,1);
acc_x1=acc_xyz1(:,1);
acc_x2=acc_xyz2(:,1);
acc_x3=acc_xyz3(:,1);
acc_x4=acc_xyz4(:,1);


% B = firpm(50,[0 0.4 0.5 0.7 1],[0 0 1 0 0]);
% filt_acc_x = filter(B,1,acc_x);

%%
m0 = statistical_metrics(abs(acc_x0),1000);
m1 = statistical_metrics(abs(acc_x1),1000);
m2 = statistical_metrics(abs(acc_x2),1000);
m3 = statistical_metrics(abs(acc_x3),1000);
m4 = statistical_metrics(abs(acc_x4),1000);

% % stats_k = [m.kurtosis m1.kurtosis m2.kurtosis];
% % stats_m = [m.mean m1.mean m2.mean];
% % stats_sk = [m.skew m1.skew m2.skew];
% % stats_v = [m.var m1.var m2.var];
% 
% [~,pca_k] = pca(stats_k);
% [~,pca_m] = pca(stats_m);
% [~,pca_sk] = pca(stats_sk);
% [~,pca_v] = pca(stats_v);

stats_0 = [m0.kurtosis m0.mean m0.skew m0.var];
stats_1 = [m1.kurtosis m1.mean m1.skew m1.var];
stats_2 = [m2.kurtosis m2.mean m2.skew m2.var];
stats_3 = [m3.kurtosis m3.mean m3.skew m3.var];
stats_4 = [m4.kurtosis m4.mean m4.skew m4.var];
%%
figure(1)
for k=1:500
    
hold on
scatter3(stats_0(k,1),stats_0(k,2),stats_0(k,3),'b')
scatter3(stats_1(k,1),stats_1(k,2),stats_1(k,3),'r')
scatter3(stats_2(k,1),stats_2(k,2),stats_2(k,3),'y')
scatter3(stats_3(k,1),stats_3(k,2),stats_3(k,3),'g')
scatter3(stats_4(k,1),stats_4(k,2),stats_4(k,3),'k')
% legend('95','125','150','175','200')
grid on
pause(0.01)
end



% re-project metrics exp(-||x_j-x_k||^2)
% kpca0=kernelpca_tutorial(stats_0',2);
% kpca1=kernelpca_tutorial(stats_1',2);
% kpca2=kernelpca_tutorial(stats_2',2);
% kpca3=kernelpca_tutorial(stats_3',2);
% kpca4=kernelpca_tutorial(stats_4',2);
%%
% hold on
% scatter(kpca0(1,:),kpca0(2,:))
% scatter(kpca1(1,:),kpca1(2,:))
% scatter(kpca2(1,:),kpca2(2,:))
% scatter(kpca3(1,:),kpca3(2,:))
% scatter(kpca4(1,:),kpca4(2,:))
% legend('T=95','T=125','T=150','T=175','T=200')




[~,pca_0] = pca(stats_0);
[~,pca_1] = pca(stats_1);
[~,pca_2] = pca(stats_2);
[~,pca_3] = pca(stats_3);
[~,pca_4] = pca(stats_4);

comp12_0=pca_0(:,1:2);
comp12_1=pca_1(:,1:2);
comp12_2=pca_2(:,1:2);
comp12_3=pca_3(:,1:2);
comp12_4=pca_4(:,1:2);
hold on
scatter(comp12_0(:,1),comp12_0(:,2));
scatter(comp12_1(:,1),comp12_1(:,2));
scatter(comp12_2(:,1),comp12_2(:,2));
scatter(comp12_3(:,1),comp12_3(:,2));
scatter(comp12_4(:,1),comp12_4(:,2));
%
legend('T=95','T=125','T=150','T=175','T=200');


%%
% plot(m.kurtosis)
% % plot(m.kurtosis)
% hold on
% plot(m1.kurtosis)
% plot(m2.kurtosis)
% legend('T=95','T=150','T=200');
% plot(m2.kurtosis)


scatter3(m0.kurtosis,m0.skew,m0.var)
hold on
scatter3(m1.kurtosis,m1.skew,m1.var)
scatter3(m2.kurtosis,m2.skew,m2.var)
legend('T=95','T=150','T=200')

% scatter3(m.kurtosis,m1.kurtosis,m2.kurtosis)
% hold on
% scatter3(m.skew,m1.skew,m2.skew)
% scatter3(m.var,m1.var,m2.var)
% scatter3(m.mean,m1.mean,m2.mean)




%%
figure(1)
    spectrogram(filt_acc_x,[],[],[],10000);

figure(2)
    spectrogram(acc_x,[],[],[],10000);



