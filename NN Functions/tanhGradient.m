% MAE 527 Final Project: Activity Classification
% Author: Shivam

% Derivative of the hyperbolic tangent function
function [a] = tanhGradient(x)
b = tanh(x);
a = 1 - b.^2;
end