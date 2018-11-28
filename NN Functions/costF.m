% MAE 527 Final Project: Activity Classification
% Author: Shivam

% Returns the cost function and its gradient with respect to the weights
function [J,D] = costF(thetaV,F,R0,N,lambda)
Jr = 0;

for i = 1:length(N)-1
    theta{i} = reshape(thetaV(1:N(i+1)*(N(i)+1)),N(i+1),N(i)+1);
    thetaV(1:N(i+1)*(N(i)+1)) = [];
    Jr = Jr + 0.5*lambda*sum(sum(theta{i}(:,2:end).^2)); % Cost function due to regularization
end

[a,z] = forProp(F,theta); % Calculating the activation values of the neurons in each layer using forward propagation

J = R0.*log(a{length(a)}) + (1-R0).*log(1-a{length(a)}); % Cross-entropy cost function
J = (Jr - sum(J(:)))/length(F(:,1)); % Average cost function over all training samples (includes regularization)
d = backProp(theta,a,z,R0); % Backpropagation

a0 = F';
a0 = [ones(size(a0(1,:))); a0];
a = [a0,a];
for i = length(theta):-1:1
    D0{i} = zeros(size(theta{i}));
    for j = 1:length(d{i}(1,:))
        if i == length(theta)
            D0{i} = D0{i} + d{i}(:,j)*a{i}(:,j)';
        else
            D0{i} = D0{i} + d{i}(2:end,j)*a{i}(:,j)';
        end
    end
    D0{i}(:,2:end) = D0{i}(:,2:end) + lambda*theta{i}(:,2:end);
    D0{i} = D0{i}/length(F(:,1));
end

D = [];
for i = 1:length(theta)
    D = [D;D0{i}(:)]; % Gradient of the cost function
end
end
