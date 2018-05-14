%tension_est_acc_x

%% Import all files in map
search_path="C:\Users\jonat\Documents\Thesis\MT\HighLoad\*.tdms";
folder_path = "C:\Users\jonat\Documents\Thesis\MT\HighLoad\";
d=dir(search_path);
Nd = length(d);
clearvars data;
for i=1:Nd
    path(i)=folder_path + d(i).name;
end
for j=1:Nd
    data(j)= make_data_struct(char(path(j)),'1');
end



%% 
[X,Y]=meshgrid(xgrid,ygrid);

surf(X,Y,Z')
xlabel('Tension');
ylabel('Octaves');

%% frequency
f={'t1','t2','t3','t4','t5','t6','t7','t8','t9','t10','t11'};
style={'.-','.-','.-','.-','.-','*-','*-','*-','*-','*-','*-'};
fs=2500;
scale=100;
fftdata=[];
topFreq=1250;
%high 50:350
%no 50:250
%low 120:240


for i=1:1:11
    %z and y best
    av_speed(i)=mean(dataNo(i).LF.Drive_RPM(50:250));
    fftdata(i,:)=abs(fft(dataNo(i).HF.Accelerometer_Z_Axis(50*fs:250*fs),fs*scale));
    fftdata(i,1:5)=0;
    L=length(fftdata(i,1:end/2));
    f_vec=[1:L]/scale;
    plot(f_vec(1:topFreq*scale)*60/av_speed(i),fftdata(i,1:topFreq*scale),style{i});
    
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