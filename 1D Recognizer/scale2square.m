% MAE 527 Final Project: Activity Classification
% Author: Shivam

% function that scales the gesture non-uniformly to a unit square and then
% translates the gesture so that the centroid is at the origin
function [pnt] = scale2square(pnt0)
R = range(pnt0);
pnt(:,1) = pnt0(:,1)*1/R(1,1);
pnt(:,2) = pnt0(:,2)*1/R(1,2);
pnt = pnt - mean(pnt);
end