function [X, P] = kalmanFilter(Y, x_0, P_0, A, Q, H, R)
%KALMANFILTER Filters measurements sequence Y using a Kalman filter. 
%
%Input:
%   Y           [m x N] Measurement sequence
%   x_0         [n x 1] Prior mean
%   P_0         [n x n] Prior covariance
%   A           [n x n] State transition matrix
%   Q           [n x n] Process noise covariance
%   H           [m x n] Measurement model matrix
%   R           [m x m] Measurement noise covariance
%
%Output:
%   x           [n x N] Estimated state vector sequence
%   P           [n x n x N] Filter error convariance
%

%%Parameters
N = size(Y,2); %Data points

n = length(x_0); %
m = size(Y,1);  %Dimension

%%Data allocation
X = zeros(n,N);
P = zeros(n,n,N);

%Make initial prediction based on prior mean and covariance
[x_hat,P_hat] = linearPrediction(x_0, P_0, A, Q);

%Make initial state and covariance update
[X(:,1), P(:,:,1)] = linearUpdate(x_hat, P_hat, Y(:,1), H, R);
for k=2:N
    %Make prediction and and state and covariance update for every k
    [x_hat,P_hat] = linearPrediction(X(:,k-1), P(:,:,k-1), A, Q);
    [X(:,k), P(:,:,k)] = linearUpdate(x_hat, P_hat, Y(:,k), H, R);
end

end
