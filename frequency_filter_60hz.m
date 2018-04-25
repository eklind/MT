function laser_filtered=frequency_filter_60hz(laser)

Wo = 60/(10000/2);  BW = Wo/35*3;
[b60,a60] = iirnotch(Wo,BW); 
[b120,a120] = iirnotch(2*Wo,BW);
[b180,a180] = iirnotch(3*Wo,BW);
[b240,a240] = iirnotch(4*Wo,BW);
[b300,a300] = iirnotch(5*Wo,BW);
[b360,a360] = iirnotch(6*Wo,BW);
%remove outliers
laser=hampel(laser,5);

% apply filters
laser_filt=filter(b60,a60,laser);
laser_filt_2=filter(b120,a120,laser_filt);
laser_filt_3=filter(b180,a180,laser_filt_2);
laser_filt_4=filter(b240,a240,laser_filt_3);
laser_filt_5=filter(b300,a300,laser_filt_4);
laser_filt_6=filter(b360,a360,laser_filt_5);

%return filtered signal
laser_filtered=laser_filt_6;
end
