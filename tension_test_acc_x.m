%tension_est_acc_x

%% Import all files in map
search_path="C:\Users\jonat\Documents\Thesis\MT\NoLoad\*.tdms";
folder_path = "C:\Users\jonat\Documents\Thesis\MT\NoLoad\";
d=dir(search_path);
Nd = length(d);
clearvars data;
for i=1:Nd
    path(i)=folder_path + d(i).name;
end
for j=1:Nd
    data(j)= make_data_struct(char(path(j)),'1');
end

%% frequency
f={'t1','t2','t3','t4','t5','t6','t7','t8','t9','t10','t11'};
style={'.-','.-','.-','.-','.-','*-','*-','*-','*-','*-','*-'};
fs=2500;
scale=100;
fftdata=[];
topFreq=100;
lowFreq=1;
%high 50:350
%no 50:250
%low 120:240
T.high=50:350;
T.Low=50:250;
T.No=120:240;

for i=1:1:11
    %z and y best
    av_speed(i)=mean(dataNo(i).LF.Drive_RPM(T.No));
    fftdata(i,:)=abs(fft(dataNo(i).HF.Accelerometer_Y_Axis(T.No(1)*fs:T.No(end)*fs),fs*scale));
    fftdata(i,1:5)=0;
    L=length(fftdata(i,1:end/2));
    f_vec=[1:L]/scale;
    %range=[0.95*scale:1.05*scale]*25;
    % x=(f_vec(1:topFreq*scale)*60/av_speed(i))/1.2340;
    x=(f_vec(lowFreq*scale:topFreq*scale)*60/av_speed(i));
    fdata=fftdata(i,lowFreq*scale:topFreq*scale);
    plot(x,fdata,style{i});
    %axis([1 1.015 0 50000])
    hold on
end
legend(f);


%%
legend(f)
Z=fftdata(:,1:L);
[X,Y]=meshgrid(1:11,f_vec');

surf(X,Y,Z')
xlabel('Tension');
ylabel('Frequency'); 

%%
for i=1:11
hold on
plot(dataNo(i).LF.Drive_RPM(50:250))
end
legend(f);
%%
for i=1:11
hold on
mean(dataNo(i).LF.Drive_RPM(50:250))
end