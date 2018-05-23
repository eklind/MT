%% Testing Pinch_Detection 

%% High tension
Compressor_Clutch=[0 1 0 1 0 1 0 1 0;1 40 60 70 90 100 120 130 150];
 Drive_RPM=movmean(hampel(T61.g_1Hz_Data.Drive_RPM.data(1:Compressor_Clutch(2,end)),5),5);
 Discharge_Pressure=movmean(hampel(T61.g_1Hz_Data.Compressor_Discharge_Pressure.data(1:Compressor_Clutch(2,end)),5),5);
[score_max,score_mean,score_median]=Pinch_Detection(Drive_RPM,Compressor_Clutch,Discharge_Pressure);
 
%% Normal tension
 Compressor_Clutch=[0 1 0 1 0 1 0 1 0;1 30 50 60 80 90 110 120 140];
  Drive_RPM=movmean(hampel(T60.g_1Hz_Data.Drive_RPM.data(1:Compressor_Clutch(2,end)),5),5);
 Discharge_Pressure=movmean(hampel(T60.g_1Hz_Data.Compressor_Discharge_Pressure.data(1:Compressor_Clutch(2,end)),5),5);
 [score_max,score_mean,score_median]=Pinch_Detection(Drive_RPM,Compressor_Clutch,Discharge_Pressure);
 
 %% Low tension
 Compressor_Clutch=[1 0 1 0 1 0 1 0;1 10 20 40 50 70 80 100];
 Drive_RPM=movmean(hampel(T59.g_1Hz_Data.Drive_RPM.data(1:Compressor_Clutch(2,end)),5),5);
 Discharge_Pressure=movmean(hampel(T59.g_1Hz_Data.Compressor_Discharge_Pressure.data(1:Compressor_Clutch(2,end)),5),5);
 [score_max,score_mean,score_median]=Pinch_Detection(Drive_RPM,Compressor_Clutch,Discharge_Pressure);
 
 %% slightly high from T40
  Compressor_Clutch=[0 1 1;1 24 420];
 Drive_RPM=hampel(T40.g_1Hz_Data.Drive_RPM.data(1:Compressor_Clutch(2,end)),5);
 Discharge_Pressure=hampel(T40.g_1Hz_Data.Compressor_Discharge_Pressure.data(1:Compressor_Clutch(2,end)),5);
 [score_max,score_mean,score_median]=Pinch_Detection(Drive_RPM,Compressor_Clutch,Discharge_Pressure);
 
  %% slightly high from T41
  Compressor_Clutch=[1 0 0;1 4 420];
 Drive_RPM=hampel(T41.g_1Hz_Data.Drive_RPM.data(1:Compressor_Clutch(2,end)),5);
 Discharge_Pressure=hampel(T41.g_1Hz_Data.Compressor_Discharge_Pressure.data(1:Compressor_Clutch(2,end)),5);
 [score_max,score_mean,score_median]=Pinch_Detection(Drive_RPM,Compressor_Clutch,Discharge_Pressure);