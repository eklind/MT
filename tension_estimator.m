function belt_tension=tension_estimator(f,S,W,M,spd,lpd)
% If pulley diameters spd and lpd are entered, S in used as distance
% between pulley centers
%Installation tension 200lbs
%Suggested tension 135-185lbs

% Formula:
% T = 4 x M x W x Se2 x fe2 x 10e-9
% Where:
% T = Belt span tension (Newtons)
% M* = Belt mass constant (g/m) 
% W = Belt width (mm) or number of belt strands 
% S = Length of the span to be measured (mm) 
% f  = Natural frequency of the belt (Hz)
% 
% *Units of mass constant M for synchronous belts is g/(m)(mm) or g/10 cm2 
% along the belt pitch line . Constant M for V-belts represents the 
% weight in grams of a 1 meter length of belting with a correction factor 
% applied to compensate for internal bending resistance 
if (nargin>5)
    S=sqrt(S^2 - ((lpd-spd)^2)/4);
end

belt_tension = (4 * M * W * (S^2) * (f^2) * 10^-9)*0.224808943;

end