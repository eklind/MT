%load data
data=tension;

%Belt parameters
belt.span=    446;      %[mm]
belt.width=   1;      %[strands or mm] 
belt.mass=  157*2;      %[g/m]

%pulley sizes
pulley_ten=8*0.254;
pulley_comp=8*0.254;

%hz
sampling_freq=1000;

belt 

%calculate
belt.nat_freq=frequency_estimator(data,sampling_freq)
belt.tension=tension_estimator(belt.nat_freq,belt.span,belt.width,belt.mass,pulley_ten,pulley_comp)

%% estimate

%Tl=tension_estimator(belt.loose_frequency,belt.span,belt.width,belt.mass,0.254*8,0.254*8)
%Tn=tension_estimator(belt.normal_frequency,belt.span,belt.width,belt.mass)
%Tt=tension_estimator(belt.tensioned_frequency,belt.span,belt.width,belt.mass)
%T=tension_estimator(belt.freq,belt.span,belt.width,belt.mass,0.254*8,0.254*10)
