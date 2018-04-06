%% 

Fs = 1000;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = 1500;             % Length of signal
t = (0:L-1)*T;        % Time vector

S = 0.7*sin(2*pi*50*t) + sin(2*pi*120*t);
X = S + 2*randn(size(t));

plot(1000*t(1:50),X(1:50))
title('Signal Corrupted with Zero-Mean Random Noise')
xlabel('t (milliseconds)')
ylabel('X(t)')

%% FT
Y = fft(X,L);
f = Fs*(0:(L-1))/L;


% Two sided and single-sided spectrum
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);





%%
K=2*0.157/0.454/39.37; %lbs/inch
L=300/25.4; %inch
F=70;   %hz

T=0.0104*K*L^2*F^2 %lbs



