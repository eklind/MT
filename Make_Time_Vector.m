function time_vec=Make_Time_Vector(struct,fs,window)

L=size(struct.LF.Time,2); %length in seconds of struct
number=ceil(L/window); %chunks

time_vec=zeros(number,2); %start and stop index for all chunks
current_index=1;
for i=1:number %for all chunks
    if(current_index+window*fs<L*fs) %full structs
        time_vec(i,1)=current_index;
        time_vec(i,2)=current_index+window*fs;
        
        current_index=current_index+window*fs;
    else
        time_vec(i,1)=current_index;
        time_vec(i,2)=L*fs; %last index in struct
    end
end
end