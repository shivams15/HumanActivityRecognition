% MAE 527 Final Project: Activity Classification
% Author: Shivam

% function that rotates the gesture by a given angle
function [pnt] = rotate(pnt0,phi)
N = size(pnt0(:,1));
G = mean(pnt0);
pnt = pnt0;
for i = 1:N
    pnt(i,1) = G(1,1) + (pnt0(i,1) - G(1,1))*cos(phi) - (pnt0(i,2) - G(1,2))*sin(phi);
    pnt(i,2) = G(1,2) + (pnt0(i,1) - G(1,1))*sin(phi) + (pnt0(i,2) - G(1,2))*cos(phi);    
end
end