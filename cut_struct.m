function struct_short=cut_struct(struct,s_start,s_stop)

%returns part of struct
%input struct, start index and stop index, scales for HF
struct_short=struct;
LF=struct2cell(struct.LF);
LF=cell2mat(LF(2:end-1));
HF=struct2cell(struct.HF);
HF=cell2mat(HF(2:end));
namesLF=fieldnames(struct.LF);
namesHF=fieldnames(struct.HF);

N=size(LF,1);
M=size(HF,1);
fs=struct.HF.Sampling_Rate_Hz;
for i=1:N
    struct_short.LF.(namesLF{i+1})=LF(i,s_start:s_stop);
end
%if compressor status needs to be cut
comp_status_temp=[];
for j=1:size(struct.LF.Comp_Status,2)
    if(struct.LF.Comp_Status(2,j)>s_start&&struct.LF.Comp_Status(2,j)<s_stop)
        comp_status_temp=[comp_status_temp struct.LF.Comp_Status(:,j)];
    end
end
comp_status_temp(2,:)=comp_status_temp(2,:)-s_start;
if(comp_status_temp(2,1)~=0)
    if(comp_status_temp(2,1)==1)
        comp_status_temp=[[0;0] comp_status_temp];
    else
       comp_status_temp=[[1;0] comp_status_temp]; 
    end
end
struct_short.LF.Comp_Status=comp_status_temp;

for i=1:M
    struct_short.HF.(namesHF{i+1})=HF(i,fs*(s_start-1)+1:fs*s_stop);    
end

end