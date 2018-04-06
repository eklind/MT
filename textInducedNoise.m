% Trying to determine the noise of the laser sensor

% Load data
clear all
clc
load 'white_still_10s.txt'
load 'black_still_10s.txt'
load 'steady_black_at_80mm_1000hz.txt'

white = white_still_10s;
black = black_still_10s;
steady = steady_black_at_80mm_1000hz;
clear black_still_10s white_still_10s steady_black_at_80mm_1000hz

%%
fs = 1000; %hz

% [t1,~]=lazy_sampler(white,fs);
% [t2,~]=lazy_sampler(black,fs);
t3 = lazy_sampler(steady,fs);

% plot(t3,steady)

% histogram(steady,500,'normalization','probability')

laser_var = var(steady(1:40000));

%% Calculate variance 

var_w = var(white); %variance at white
var_b = var(black); %variance at black
clear F A B
F = [0 0.2 0.3 1];
A =[1 1 0 0];
B = fir2(50,F,A);
fvtool(B)

black_filt = filtfilt(B,1,black);
white_filt = filtfilt(B,1,white);
plot(t1,white)
hold on
plot(t1,white_filt)

%% filter out 250hz component

Filt1 = fir2(50,[0 0.49 0.51 1],[1 0 0 1]);

steady_filtered=filtfilt(Filt1,1,steady);

subplot(1,2,1)
    plot(t3,steady)
hold on
subplot(1,2,2)
    plot(t3,steady_filtered)


%%
N=length(steady);
f = fs*(0:(N/2)-1)/N;
steady_fft= fft(steady,N);
steady_abs= abs(steady_fft/N);
steady_amp= 2*steady_abs(1:N/2);


% plot(f(2:end),steady_amp(2:end))
plot(f(2:end),steady_amp(2:end))

%%
Filt1 = fir2(50,[0 0.49 0.51 1],[1 0 0 1]);

y=filtfilt(Filt1,1,steady);


