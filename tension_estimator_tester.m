%setup
%from vibration_analysis

belt.loose_frequency= 58;    %[1/s]
belt.normal_frequency= 65;    %[1/s]
belt.tensioned_frequency= 70;    %[1/s]

belt.span=    300;      %[mm]
belt.width=   1;      %[strands or mm] 
belt.mass=  157*2;      %[g/m]


belt

%% estimate

Tl=tension_estimator(belt.loose_frequency,belt.span,belt.width,belt.mass,0.254*8,0.254*10)
Tn=tension_estimator(belt.normal_frequency,belt.span,belt.width,belt.mass)
Tt=tension_estimator(belt.tensioned_frequency,belt.span,belt.width,belt.mass)