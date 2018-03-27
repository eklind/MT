clear all
clc
load noisysignals s1 s2
t=0:0.01:100;

A=sin(t)+0.4;
B=sin(t-400)-0.2;



hold on
plot(t,A)
plot(t,B)

X=s1;
Y=s2;

%%
  %%Get the peak power before filtering
    
    % Get data
%     d = energy.data;

    % Remove mean
%     d = d - ones(length(d),1)*mean(d);
%     x = X'-ones(length(X),1)*mean(X);
    x = X-mean(X);
    y = Y-mean(Y);
    % Sum over three phases I*V
%     P = sum(d(:,2:4).*d(:,5:7),2);
   %% 
    %%Filter
    
    % Filter window size
    N = 1000;
%     P = conv(P, ones(N,1),'valid')/N;

    x = conv(x, ones(N,1),'valid')/N;

    % Filter trace data
%     d = trace;
   % d(sum(isnan(d),2)>0,:) = [];

%     x = d(:,2:7);

%     dx = [zeros(1,6);diff(x)];

%     P = downsample(P,10000*0.012);
%%
    % Synch data
%     f = xcorr(P,sum(dx.^2,2));
    f = xcorr(x,y);
    
    [acor,lag] = xcorr(x,y);
    [~,I] = max(abs(acor));
    timeDiff = abs(lag(I));
    %%
    plot(X(timeDiff:end))
    hold on
    plot(Y)
    
    
    %%
    [~,f] = max(f);
%%
    x(1:f-length(x)) = [];
    x = x(1:length(y));

%%

hold on
plot(t,X)
plot(t,Y)
