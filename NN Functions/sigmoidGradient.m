% MAE 527 Final Project: Activity Classification
% Author: Shivam

% Derivative of the sigmoid function
function [a] = sigmoidGradient(x)
b = sigmoid(x);
a = b.*(1-b);
end