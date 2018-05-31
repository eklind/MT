function SS_index=Find_Longest_SS(data,factor)
%checks when speed and Discharge pressure is semi-constant

%Input: struct, factor is how much it can differ
L=length(data);

max_index_start=0;
max_index_stop=-1;
current_index_start=0;
current_index_stop=0;
started_sequence=false;

diff_data=diff(smooth(data,20)); %extra smoothing
is_SS=abs(diff_data)<factor;


for i=1:length(is_SS)
   if(is_SS(i)==1)
       if(started_sequence==false)
           current_index_start=i; %start to count
           started_sequence=true;
       end
       current_index_stop=i;
   else
      if(started_sequence==true)
           %if sequence ends
           if(current_index_stop-current_index_start>max_index_stop-max_index_start)
               max_index_start=current_index_start;
               max_index_stop=current_index_stop;
           end
           started_sequence=false;
      end
   end
   if(current_index_stop-current_index_start>max_index_stop-max_index_start)
       max_index_start=current_index_start;
       max_index_stop=current_index_stop;
   end
end
SS_index=[max_index_start:max_index_stop];
end