% MAE 527 Final Project: Activity Classification
% Author: Shivam

% function that calculates the average Euclidean distance between a
% given template and a gesture rotated by a given angle
function [d] = ED(pnt, i, phi, Xm, Ym)
%pnt = rotate(pnt,phi);
d = 0;
for j = 1:96
    d = d + sqrt((pnt(j,:)- [Xm(j,i),Ym(j,i)])*(pnt(j,:)- [Xm(j,i),Ym(j,i)])')/96;
end
end