% MAE 527 Final Project: Activity Classification
% Author: Shivam

% function that calculates the average Mahalanobis distance between a
% given template and a gesture rotated by a given angle
function [d] = MD(pnt, i, phi, Xm, Ym, C)
pnt = rotate(pnt,phi);
d = 0;
for j = 1:96
    d = d + sqrt((pnt(j,:)- [Xm(j,i),Ym(j,i)])*inv(C(2*(i-1)+1:2*i,2*(j-1)+1:2*j))*(pnt(j,:)- [Xm(j,i),Ym(j,i)])')/96;
end
end