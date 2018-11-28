% MAE 527 Final Project: Activity Classification
% Author: Shivam

% Returns the output vector for a labelled data point (suitable for cases
% when a sigmoid activation function is used)
function [R0] = RVec(R)
for i = 1:length(R);
    if R(i) == 1
        R0(:,i) = [1;0;0];
    elseif R(i) == 2
        R0(:,i) = [0;1;0];
    else
        R0(:,i) = [0;0;1];
    end
end
end