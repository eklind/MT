function [rpm,mps] = beltfreq_to_rpm(belt_freq, ratio,belt_length, pulley_diameter)
mps=belt_freq*(belt_length*0.0254);
rps=mps/(pulley_diameter*pi*0.0254)/ratio;
rpm=rps*60;
end