function SS_index=Find_Longest_SS_v2(data,factor,number,plotting)
%checks when speed and Discharge pressure is semi-constant

%Input: struct, factor is how much it can differ, number is how many that
%needs to be the same

L=length(data);

current_index_start=0;
current_index_stop=0;
current_mean=0;
started_sequence=false;

%data=smooth(data,20); %extra smoothing

SS_index=[];
for i=3:length(data)-3
    
   %start a new sequence
   if(started_sequence==false)
       if(data(i)>10)
           current_mean=mean(data(i-2:i)); %starting mean of 3 values
           current_index_start=i; %start to count
           current_index_stop=i;
           started_sequence=true;
       end
   end
   
   
  if(started_sequence==true)
       %if sequence ends
       if(abs(current_mean-data(i))<factor||...
               abs(current_mean-data(i))<factor||...
               abs(current_mean-data(i))<factor)
           current_index_stop=i; %update stop index
           
           max_index_start=current_index_start;
           max_index_stop=current_index_stop;
       else
          if(current_index_stop-current_index_start>=number)
              %if enough, store index
              SS_index=[SS_index; current_index_start current_index_stop]
          end
           started_sequence=false;
           i=i+2;
       end
  end
end
%enter last indexing
if(started_sequence==true)
    SS_index=[SS_index; current_index_start current_index_stop]
end

if(plotting==true&&size(SS_index,1)>0)
    plot(data,'b-')
    hold on
   for i=1:size(SS_index,1)
      plot(SS_index(i,1):SS_index(i,2),data(SS_index(i,1):SS_index(i,2)),'r*--') 
   end
    
end
end