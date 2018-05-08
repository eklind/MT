function tension=tension_est_laser(data)
%data=belt tension distance
%tension= estimated tension based on current settings

%from config 2018-05-08
data2=mean(data)+0.6995;
data3=data2*152.95;
tension=data3+30;

end
