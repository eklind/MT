%% Case
%1000 rpm
timestep=0.001;
time=0:timestep:10
f=1500/2; %half freq
rpm_motor=1000;
d_m=(11*2.54)/100;
d_c=(8*2.54)/100;
d_p=(8*2.54)/100;
volt_to_freq=100;

%motor to compressor
factor=(d_c/d_p)*(d_p/d_m)
rpm_comp=rpm_motor/factor;

%generete input data 
reflector_size=19e-3

%% generete pulses
 N=length(time);
 motor_pulses=zeros(N,1);
 comp_pulses=zeros(N,1);
 len=0;
 len_comp=0;
 for i=1:length(time)
     len=len+(rpm_motor/60)*timestep
     %motor
     if(mod(len,d_m)<reflector_size)
         motor_pulses(i)=1;
     end
     %compressor
     slip=rand(1)*0.5;
     len_comp=len_comp+(rpm_comp/60)*timestep*(1-slip);
     if(mod(len_comp,d_m)<reflector_size)
         comp_pulses(i)=1;
     end
 end
 %% freq converter
indice=find(motor_pulses)
for i=2:length(indice)
    voltage(i-1)=(indice(i)-indice(i-1))*timestep*volt_to_freq;
end
v1=1;
out=zeros(N,1);
for j=1:length(indice)-1
    while v1<indice(j)
        out(v1)=voltage(j);
        v1=v1+1;
    end 
end
% logics