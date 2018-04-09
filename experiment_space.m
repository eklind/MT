function position = experiment_space(nom_speed, tension1, tension2, comp_load)
% Takes in the nominal motor speed used in the experiment, the measured
% tension on motor side and compressor side and the compressor load. 
% Returns an operation point in the experimet space.
rpm_range=[0 2000]; %[RPM] x
tension_range=[50 250]; %[lbs] y
load_range=[0 10];  %[-] z

x = 0:1:100;
y = 0:1:100;
z = 0:1:100;

average_tension=(tension1+tension2)/2;

rel_rpm_range=rpm_range-rpm_range(1);
rel_speed=(nom_speed-rpm_range(1))/(rel_rpm_range(2)-rel_rpm_range(1));
rel_speed = ceil(rel_speed *100);


rel_tension_range=tension_range-tension_range(1);
rel_tension=(average_tension-tension_range(1))/(rel_tension_range(2)-rel_tension_range(1));
rel_tension = ceil(rel_tension *100);

rel_load_range=load_range-load_range(1);
rel_load=(comp_load-load_range(1))/(rel_load_range(2)-rel_load_range(1));
rel_load = ceil(rel_load *100);

position = [rel_speed rel_tension rel_load];




% fileID = fopen('exp_space.txt','a+');
% x_space = fscanf(fileID,'%d');
% 
% 
% 
% % fprintf(fileID,'%6s %12s\n','x','exp(x)');
% % fprintf(fileID,'%6.2f %12.8f\n',A);
% fclose(fileID);



end