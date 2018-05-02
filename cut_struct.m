function struct_short=cut_struct(struct,s_start,s_stop)

%returns part of struct
%input struct, start index and stop index, scales for HF
struct_short=struct;
LF=struct2cell(struct.LF);
LF=cell2mat(LF(2:end));
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

for i=1:M
struct_short.HF.(namesHF{i+1})=HF(i,fs*(s_start-1)+1:fs*s_stop);    
end

end