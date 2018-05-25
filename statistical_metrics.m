function metric_struct= statistical_metrics(data,window_size)
%Takes data series and outputs a struct with the four statistical moments
%window_size is optional if one wants to look at metrics over window_size
L=size(data,1);
if(nargin>1)
    removed=mod(L,window_size);
    data=data(1:end-removed,1); %remove for even windowing
else
    removed=0;
    window_size=L;
end

%Reshape
data=reshape(data,[length(data)/window_size window_size]);

%Calculate
metric_struct.mean=mean(data,2); %first moment of shunks
metric_struct.var=var(data,0,2); %second moment of shunks
metric_struct.skew=skewness(data,0,2); %third moment of shunks
metric_struct.kurtosis=kurtosis(data,0,2); %fourth moment of shunks

E=sum(data.^2,2);
metric_struct.power=E/length(data); % Signal power
metric_struct.rms=rms(data);

end
