function score =Slip_Detection_RPM(Drive_RPM,Comp_RPM)
%Compares the rpm on motor and compressor side

%remove when drive speed is too low
Drive_RPM=Drive_RPM(Drive_RPM>600);
Comp_RPM=Comp_RPM(Drive_RPM>600);

%remove when compressor speed is too low
Drive_RPM=Drive_RPM(Comp_RPM>750);
Comp_RPM=Comp_RPM(Comp_RPM>750);

if(isempty(Comp_RPM)||isempty(Drive_RPM))
    ratio=1; 
    ratio_scaled=1;
else
    ratio=Comp_RPM./Drive_RPM; 
end
tension=ratio*144.7+10000*(ratio-1.244); %deviation from normal tension
    score=median(tension);
end