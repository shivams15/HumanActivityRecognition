% MAE 527 Final Project: Activity Classification
% Author: Shivam

% function that finds the optimal rotation of the unknown gesture and
% returns the corresponding average Mahalanobis distance between the
% gesture and the given template
function [d] = MDmin(pnt,i,phi1,phi2,phid)
d = +Inf;
phi = phi1:phid:phi2;
for j = 1:size(phi,2)
    D = MD(pnt,i,phi(j));
    if D < d
        d = D;
    end
end   
end