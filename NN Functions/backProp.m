% MAE 527 Final Project: Activity Classification
% Author: Shivam

% Function that backpropagates the errors from the output layer to the
% hidden layers of the neural network
function [d] = backProp(theta,a,z,R0)
d{length(a)} = (a{length(a)} - R0);
for i = (length(a)-1):-1:1
    if i == length(a) - 1
        d{i} = (theta{i+1}'*d{i+1}).*tanhGradient([ones(size(z{i}(1,:)));z{i}]);
    else
        d{i} = (theta{i+1}'*d{i+1}(2:end,:)).*tanhGradient([ones(size(z{i}(1,:)));z{i}]);
    end
end
end