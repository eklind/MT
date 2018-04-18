function [x, P] = linearUpdate(x, P, y, H, R)
%LINEARPREDICTION calculates mean and covariance of predicted state
%   density using a linear Gaussian model.
%
%Input:
%   x           [n x 1] Prior mean
%   P           [n x n] Prior covariance
%   y           [m x 1] Measurement
%   H           [m x n] Measurement model matrix
%   R           [m x m] Measurement noise covariance
%
%Output:
%   x           [n x 1] updated state mean
%   P           [n x n] updated state covariance
%

% Your code here
%According to the Kalman filter equations

S=H*P*H'+R; %Inovation covariance 
K=P*H'*inv(S); %Kalman Gain
V=y-H*x;  % Inovation 
x=x+K*V;  % Update of state 
P=P-K*S*K'; % Update of state covariance

end