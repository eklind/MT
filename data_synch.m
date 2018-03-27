function [P] = data_synch(X,Y)
%Filter: synchs the energy log with motion
 
  %%Get the peak power before filtering
    
    % Get data
    d = energy.data;

    % Remove mean
%     d = d - ones(length(d),1)*mean(d);
    x = X-mean(X);
    y = Y-mean(Y);
    % Sum over three phases I*V
%     P = sum(d(:,2:4).*d(:,5:7),2);
    
    %%Filter
    
    % Filter window size
    N = 500;

    x = conv(x, ones(N,1),'valid')/N;

    % Filter trace data
%     d = trace;
   % d(sum(isnan(d),2)>0,:) = [];

%     x = d(:,2:7);

%     dx = [zeros(1,6);diff(x)];

%     P = downsample(P,10000*0.012);

    % Synch data
%     f = xcorr(P,sum(dx.^2,2));
    f = xcorr(X,Y);
    [~,f] = max(f);

    P(1:f-length(P)) = [];
    P = P(1:length(x));





end
