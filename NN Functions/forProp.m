% MAE 527 Final Project: Activity Classification
% Author: Shivam

% Forward propagation to calculate the activation values of neurons in
% each layer
function [a,z] = forProp(F,theta)
F = F';
f = [ones(size(F(1,:))); F];
for i = 1:length(theta)
    z{i} = theta{i}*f;
    a{i} = tanh(z{i}); % Hyberbolic tangent activation function
    if i ~= length(theta)
        a{i} = [ones(size(a{i}(1,:))); a{i}];
    end
    f = a{i};
end
end