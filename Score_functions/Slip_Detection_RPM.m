function [score_max,score_mean,score_median] =Slip_Detection_RPM(Drive_RPM,Comp_RPM);
%remove when drive speed is too low
Drive_RPM=Drive_RPM(Drive_RPM>600);
Comp_RPM=Comp_RPM(Drive_RPM>600);

%remove when compressor speed is too low
Drive_RPM=Drive_RPM(Comp_RPM>750);
Comp_RPM=Comp_RPM(Comp_RPM>750);

ratio=Comp_RPM./Drive_RPM; 
ratio_scaled=ratio/1.19;
score_max=max(ratio_scaled);
score_mean=mean(ratio_scaled);
score_median=median(ratio_scaled);
end