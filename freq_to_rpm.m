function freq_in_rpm = freq_to_rpm(f,ratio)
%f: frequency [1/s]
%ratio: relation between rpm desired and point of frequency measurement

%freq_in_rpm: Corresponding speed
freq_in_rpm=(0.5*f*60)/ratio
end