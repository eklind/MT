function [out,removed]=get_metrics(data,window_size)
%takes data of dimension m x 1 and outputs a struct with key values
%returns removed number of values

L=length(data);
if(nargin>1)
    removed=mod(L,window_size);
    data=data(1:end-removed,1); %remove for even windowing
else
    removed=0;
    window_size=L;
end
    
%Reshape
out.reshaped=reshape(data,[length(data)/window_size window_size])'

%Statistical moments, time domain
out.mean=mean(out.reshaped); %first moment of shunks
out.var=var(out.reshaped); %second moment of shunks
out.skew=skewness(out.reshaped); %third moment of shunks
out.kurtosis=kurtosis(out.reshaped); %fourth moment of shunks

%trends
%out.trend_linear=diff(data-detrend(data));
out.std=std(out.reshaped);
%rms value
out.rms=rms(out.reshaped);

%moving median
%out.movmad=movmad(out.reshaped,10);

%envelope
[out.env_u,out.env_l]=envelope(out.reshaped);

%approx entropy
out.entropy=approximateEntropy(out.reshaped);

%bandwidth
out.bw= powerbw(out.reshaped)

%pkurtosis
out.pkurtosis=kurtosis(out.reshaped);
