%load data
data=bomps5;

%Belt parameters
belt.span=    446;      %[mm]
belt.width=   1;      %[strands or mm] 
belt.mass=  157*2;      %[g/m]

%pulley sizes
pulley_ten=8*0.254;
pulley_comp=8*0.254;

%hz
sampling_freq=320;



%calculate
[belt.nat_freq,belt.nat_freq_var]=frequency_estimator(data,sampling_freq)
belt.tension=tension_estimator(belt.nat_freq,belt.span,belt.width,belt.mass,pulley_ten,pulley_comp)
belt 
%% estimate

%Tl=tension_estimator(belt.loose_frequency,belt.span,belt.width,belt.mass,0.254*8,0.254*8)
%Tn=tension_estimator(belt.normal_frequency,belt.span,belt.width,belt.mass)
%Tt=tension_estimator(belt.tensioned_frequency,belt.span,belt.width,belt.mass)
%T=tension_estimator(belt.freq,belt.span,belt.width,belt.mass,0.254*8,0.254*10)
