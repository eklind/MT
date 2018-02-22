function trendStruct=findDataTrends(sensor_series)

time=sensor_series(1,:);
values=sensor_series(2,:);

%trendStruct.riseTime=0
trendStruct.variance=std(values);
trendStruct.mean=mean(values);
trendStruct.min=min(values);
trendStruct.max=max(values);
%tendStruct.
...

end

