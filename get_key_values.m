function [out,removed]=get_key_values(data,window_size)
%takes data of dimension m x 1 and outputs a struct with key values
%returns removed number of values
%[size_1,size_2]=size(data);
L=length(data);
removed=mod(L,window_size);
data=data(1:end-removed,1); %remove for even windowing
for i=1:1
out.reshaped=reshape(data,[length(data)/window_size window_size])
out.mean=mean(out.reshaped); %first moment of shunks
out.var=var(out.reshaped); %second moment of shunks
out.skew=skewness(out.reshaped); %third moment of shunks
out.kurtosis=kurtosis(out.reshaped); %fourth moment of shunks
end