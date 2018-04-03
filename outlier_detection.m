function [signal_filled,nr_outliers]= outlier_detection(signal,values,lower_lim,upper_lim)
%Outlier detection
%signal to modify
%values to fill
len=length(signal);
signal_filled=zeros(length(signal),1);
%initialize
signal_filled(1)=signal(1);
nr_outliers=0;
for i=2:len
    val=0;
    u_l=0;
    l_l=0;
    %evaluate values
    if(nargin>1)
        val=ismember(signal(i),values);
    end
    %evaluate lower limit
    if(nargin>2)
        l_l=signal(i)<=lower_lim;
    end
    %evaluate upper limit
    if(nargin>3)
        u_l=signal(i)>=upper_lim;
    end
    %if any is true,replace with value with previous
    if(val||u_l||l_l)
           signal_filled(i)=signal_filled(i-1);
           nr_outliers=nr_outliers+1;
   else
       %insert real value
       signal_filled(i)=signal(i);
   end
end
end