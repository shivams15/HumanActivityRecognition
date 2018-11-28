% MAE 527 Final Project: Activity Classification
% Author: Shivam

% Sigmoid function
function [a] = sigmoid(x)
a = 1./(1+exp(-x));
end