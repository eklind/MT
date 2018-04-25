function plot_comparison(data,data_filt)
%plot the comparison between unfiltered and filtered data
%(currently LF channel)
names=fieldnames(data.LF);
names=names(4:end)
L=length(struct2cell(data.LF));
data=struct2cell(data.LF);
data=cell2mat(data(4:end));
data_filt=struct2cell(data_filt.LF);
data_filt=cell2mat(data_filt(4:end));
for i=1:L-3
    figure(i)
    plot(data(i,:),'.-');
    hold on
    plot(data_filt(i,:));
    legend('raw data', 'filtered data');
    title(names{i});
    hold off
end

end