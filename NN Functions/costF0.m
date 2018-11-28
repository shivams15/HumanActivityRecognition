% MAE 527 Final Project: Activity Classification
% Author: Shivam

% Returns the cost function
function [J] = costF0(thetaV,F,R0,N,lambda)
Jr = 0;
for i = 1:length(N)-1
    theta{i} = reshape(thetaV(1:N(i+1)*(N(i)+1)),N(i+1),N(i)+1);
    thetaV(1:N(i+1)*(N(i)+1)) = [];
    Jr = Jr + 0.5*lambda*sum(sum(theta{i}(:,2:end).^2));
end
[a,z] = forProp(F,theta);
J = R0.*log(a{length(a)}) + (1-R0).*log(1-a{length(a)});
J = (Jr - sum(J(:)))/length(F(:,1));
end