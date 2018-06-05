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
data=reshape(data,[window_size length(data)/window_size]);

%Calculate
metric_struct.mean=mean(data,1); %first moment of shunks
metric_struct.var=var(data,0,1); %second moment of shunks
metric_struct.skew=skewness(data,0,1); %third moment of shunks
metric_struct.kurtosis=kurtosis(data,0,1); %fourth moment of shunks

E=sum(data.^2,1);
metric_struct.power=E/length(data); % Signal power
metric_struct.rms=rms(data,1);

end
