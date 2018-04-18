function speed_info=vel_diff(rpm1,rpm2,ratio,filter)

if(nargin<3)
    ratio=1;
end
if(nargin>3)
%apply movmean
rpm1=movmean(rpm1,filter);
rpm2=movmean(rpm2,filter);
end

speed_info.diff=rpm1-rpm2;
speed_info.frac=rpm1./rpm2;
speed_info.mean_diff=mean(speed_info.diff);
speed_info.mean_frac=mean(speed_info.frac);
speed_info.cum_diff=cumsum(rpm1)-ratio*cumsum(rpm2);
end