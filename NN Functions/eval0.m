% MAE 527 Final Project: Activity Classification
% Author: Shivam

% Evaluates the performace of the NN over a given labelled dataset
function [A,M] = eval0(F0,theta,p)
[Q,~] =  forProp(F0,theta);
[~,H] = max(Q{length(Q)});
M = zeros(3,3); % stores the confusion matrix
for i = 1:length(F0(:,1))
    if i < p(1)
        M(1,H(i)) = M(1,H(i)) + 1;
    elseif i < p(2)
        M(2,H(i)) = M(2,H(i)) + 1;
    else
        M(3,H(i)) = M(3,H(i)) + 1;
    end
end
A = 100*trace(M)/sum(sum(M,2)); % Percentage accuracy
%M = 100*M./sum(M,2);
M = array2table(M','VariableNames',{'Walking','Upstairs','Downstairs'},'RowNames',{'Walking','Upstairs','Downstairs'});
end