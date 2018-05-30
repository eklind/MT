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

%% frequency
f={'t1','t2','t3','t4','t5','t6','t7','t8','t9','t10','t11'};
style={'.-','.-','.-','.-','.-','*-','*-','*-','*-','*-','*-'};
fs=2500;
scale=100;
fftdata=[];

topFreq=1200;
lowFreq=1;

%topFreq=19.8; %nothing
%lowFreq=19.4;

%topFreq=15.88;
%lowFreq=15.36; %rms increase with lower tension

%topFreq=26;
%lowFreq=19;

%topFreq=13;
%lowFreq=9;
%topFreq=25; %decreasing with lower tension(comp)
%lowFreq=24.3;
%topFreq=20.5; %decreasing with lower tension(mot)
%lowFreq=19;
%topFreq=60;
%lowFreq=58;

%topFreq=13; %all 1.263(no), 1.258(low), 1.257(high)
%lowFreq=9;

%topFreq=26; %1.261:1.264(no) 1.258(low) ,1.257:1.255(high)
%lowFreq=18;

%topFreq=16; %1.1:1.06(no), 1.11:0.9652(low) ,1.017:1.013(high)
%lowFreq=14;

n_peaks=2;
remove=10;
%high 50:350
%no 50:250
%low 120:240
T.High=340:400;
T.Low=160:220;
T.No=120:220; %worked for 10 seconds

time=T.High;
data_current=dataHigh;
for i=11:-1:1
    %z and y best
    av_speed(i)=mean(data_current(i).LF.Comp_RPM(time));
    av_pressure(i)=mean(data_current(i).LF.Compressor_Discharge_Pressure(time));
    av_I(i)=mean(data_current(i).LF.VFD_Current_Output(time));
    fftdata(i,:)=abs(fft(data_current(i).HF.Accelerometer_Z_Axis(time(1)*fs:time(end)*fs),fs*scale));
    %fftdata(i,:)=abs(fft(data_current(i).HF.Belt_Displacement(time(1)*fs:time(end)*fs),fs*scale));
    fftdata(i,1:1)=0;
    L=length(fftdata(i,1:end/2));
    f_vec=[1:L]/scale;
    %range=[0.95*scale:1.05*scale]*25;
    x=(f_vec(lowFreq*scale:topFreq*scale));
    %x=(f_vec(lowFreq*scale:topFreq*scale));
    %x=(f_vec(lowFreq*scale:topFreq*scale)*60);
    fdata=fftdata(i,lowFreq*scale:topFreq*scale)/(scale*length(time(1)*fs:time(end)*fs));
    %hold off
    
    plot(x,fdata,style{i});
     hold on
     rmsVal(i)=rms(fdata);
    % plot(peak(1,:),peak(2,:),'o')
    for n=1:n_peaks
        [M_temp,I_temp]=max(fdata);  %prev peak(2) and peak(1)
        peak(1,n)=x(I_temp); %frequency
        peak(2,n)=M_temp; %magnitude
        if(I_temp-remove<1)
            fdata(1:I_temp+remove)=0;
        end
        if (I_temp+remove>length(fdata))
                fdata(I_temp-remove:end)=0;
        end      
        if(I_temp+remove<=length(fdata)&&I_temp-remove>=1)
            
            i;
            fdata(I_temp-remove:I_temp+remove)=0;
        end
    end
     
     p(i)=(peak(1,1)/peak(1,2));
     if(p(i)<1)
         %p(i)=1/p(i);
     end
end 
legend(f);
%
%clf
%plot(1:11,p,'.-')


%%
legend(f)
Z=fftdata(:,1:L);
[X,Y]=meshgrid(1:11,f_vec');

surf(X,Y,Z')
xlabel('Tension');
ylabel('Frequency'); 

%%
for i=1:1
hold off
plot(dataNo(i).LF.Drive_RPM(1:250),style{i})
hold on
%plot(dataHigh(i).LF.VFD_Voltage_Output(1:250).*dataHigh(i).LF.Compressor_Suction_Pressure(1:250)./10  ,style{i}) %3.95???
plot(dataNo(i).LF.VFD_Voltage_Output(1:250)*3.95)
%plot(dataHigh(i).LF.VFD_Current_Output(1:250)*100)
%plot(dataNo(i).LF.Compressor_Discharge_Pressure(1:250)./dataHigh(i).LF.Compressor_Suction_Pressure(1:250)*148)
plot((dataNo(i).LF.Cond_Air_Out(1:250)-dataNo(i).LF.Cond_Air_In (1:250))*100);
 
legend(f{i}); 
%pause()
end 

%%

hold off
plot(dataLow(1).LF.Drive_RPM,style{i})
hold on
%plot(dataHigh(i).LF.VFD_Voltage_Output(1:250).*dataHigh(i).LF.Compressor_Suction_Pressure(1:250)./10  ,style{i}) %3.95???
plot(dataLow(1).LF.VFD_Voltage_Output*3.95)
%plot(dataHigh(i).LF.VFD_Current_Output(1:250)*100)
%plot(dataNo(i).LF.Compressor_Discharge_Pressure(1:250)./dataHigh(i).LF.Compressor_Suction_Pressure(1:250)*148)
plot((dataLow(1).LF.Evap_Air_Out-dataLow(1).LF.Evap_Air_In ));
plot((dataLow(1).LF.Evap_Air_Out./dataLow(1).LF.Evap_Air_In )*1000);
plot((dataLow(1).LF.Condenser_Refrigerant_In)*10);
plot((dataLow(1).LF.Evaporator_Refrigerant_Out)*10);
plot((dataLow(1).LF.Evaporator_Refrigerant_In)*10);
legend(f{i}); 
%pause()
%%
for i=1:11
hold on
%plot(dataNo(i).LF.Compressor_Discharge_Pressure(1:240),style{i})
plot(dataLow(i).LF.Compressor_Discharge_Pressure(1:220),style{i})
plot(dataHigh(i).LF.Compressor_Discharge_Pressure(1:400),style{i})
end
legend(f);