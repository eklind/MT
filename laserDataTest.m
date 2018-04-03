clear all
clc
load 'C:\Users\Viktor\Desktop\laserDemo.txt'
s=laserDemo;

f=1000;
dt=1/f;
l=length(s);
t=0:dt:(l*dt-dt);
t=t';
st=[t s];
N=length(s);

S=fft(s,N);

order = 1;     % ridge order
P = [1 1];   % Point on the ridge




%%
s_zero=s-mean(s);
s_norm = normalize(s);

% histogram(s_zero);
histogram(s_norm,400,'normalization','pdf')

% 3rd movement 
s_skw = skewness(s_norm);

% 4th moment
s_norm2 = reshape(s_norm,511,[]);
s_k = kurtosis(s_norm2,[],2);






%%
rpmtrack(s,f,order,P);

plot(t,rpm)

%%
%Example
clear all
clc

  % Generate a vibration signal with 3 harmonic components
    fs = 1000;                        % sample rate
    t = (0:1/fs:6);                   % time vector
    fi = 20 + t.^6.*exp(-t);          % instantaneous frequency
    phi = 2*pi*cumtrapz(t,fi);        % instantaneous phase
    ol = [1 2 3];                     % order list
    amp = [5 10 5];                   % amplitudes
    vib = amp*cos(ol'.*phi);          % vibration signal
    order = 2;                        % ridge order
    P = [3 112.6];                    % point on the ridge
    % Extract the RPM profile and visualize it
    rpmtrack(vib,fs,order,P);

   %% Wavelet test
   
   cwt(s,1000);
