% MAE 527 Final Project: Activity Classification
% Author: Shivam

%function that resamples the gesture using 96 equidistant data points
function [pnt] = resample1(pnt0)
N = length(pnt0(:,1));
L = sum(sqrt(sum((pnt0(2:N,:) - pnt0(1:N-1,:)).^2,2)));
I = L/95;
D = 0;
pnt(1,:) = pnt0(1,:);
n = 2;
i = 2;
while i <= N
    d = distance(pnt0(i,:),pnt0(i-1,:));
    if D+d >= I
        qx = pnt0(i-1,1) + (I-D)/d*(pnt0(i,1)-pnt0(i-1,1));
        qy = pnt0(i-1,2) + (I-D)/d*(pnt0(i,2)-pnt0(i-1,2));
        pnt(n,:) = [qx, qy];
        pnt0 = [pnt0(1:i-1,:); [qx, qy]; pnt0(i:end,:)];
        n = n+1;
        N = N+1;
        D = 0;
    else
        D = D+d;
    end
    i = i+1;
end
if n == 96
    pnt(n,:) = pnt0(end,:);
end
end