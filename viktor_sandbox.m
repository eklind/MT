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

%%
clear all
clc
% A=load('10Apr_10AM_1000hz_BLE.txt');
A=load('vibr_arm_laser.txt');
l_a=length(A);
k=10;

l_a=floor(l_a/k);
l_a=l_a*k;
% A=A(1:l_a);
% A_prim=reshape(A,k,[]);

f=1000;
t=lazy_sampler(A,f);

MA=inv(k)*ones(k,1);
% A_filt = A_prim'*MA;
% A_filt=reshape(A_filt,[],1);
A_filt = conv(MA,A);

hold on
plot(t,A,'b')
plot(t,A_filt(1:end-k+1),'r')
%%

% for i=k:length(A)    
%     A_s(i-(k-1))=sum(A(i-(k-1):i))/k;
% end
A_s=A_s';

hold on
plot(t,A,'b')
plot(t(1:end-k+1),A_s(1:end),'r')
% plot(t(1:end-k),smoothdata(A(1:end-k)),'g')


%%
A=A_s;
L=length(A);
N=floor(L/2)*2;
A=A(1:N);

Y = fft(A,N);
f = f*(0:(N-1))/N;


% Two sided and single-sided spectrum
P2 = abs(Y/N);
P1 = P2(1:N/2+1);
P1(2:end-1) = 2*P1(2:end-1);
plot(f(2:N/2+1),P1(2:end))
