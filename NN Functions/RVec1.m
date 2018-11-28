% MAE 527 Final Project: Activity Classification
% Author: Shivam

% Returns the output vector for a labelled data point (suitable for cases
% when a tanh activation function is used)
function [R0] = RVec1(R)
for i = 1:length(R);
    if R(i) == 1
        R0(:,i) = [1;-1;-1];
    elseif R(i) == 2
        R0(:,i) = [-1;1;-1];
    else
        R0(:,i) = [-1;-1;1];
    end
end
end