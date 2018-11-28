% MAE 527 Final Project: Activity Classification
% Author: Shivam

% function to rotate the gesture so that line joining the centroid and
% starting point is aligned with the x-axis
function [pnt] = rotate0(pnt0)
G = mean(pnt0);
phi = atan2(G(1,2) - pnt0(1,2),G(1,1) - pnt0(1,1));
pnt = rotate(pnt0, -phi);
end