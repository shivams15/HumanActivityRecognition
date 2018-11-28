% MAE 527 Final Project: Activity Classification
% Author: Shivam

clear all;
global n;
global p;

% Importing test data
load('test.mat');
T = test;
F = [T{1};T{2};T{3}];
p(1) = length(T{1}(:,1)) + 1;
p(2) = p(1) + length(T{2}(:,1));
n = length(F(:,1));

load('M.mat');
load('S.mat');
load('coeff.mat');
F = (F-M)./S; % Scaling the feature vectors
F = F*coeff;
F = F(:,1:13); % Selecting the 13 most important principal components

load('I.mat');

% Eliminating features rejected by backward sequential search
for i = 1:length(I)
    F(:,I(i)) = [];
end

% Loading the gmdistribution objects generated during the training of the
% classifier
load('D.mat');

% Evaluating the performance of the Naive Bayes classifier over the test
% set
[A,M] = eval(F,D);
fprintf('Overall accuracy: %0.2f %% \n \n',A);
disp(M);

% Returns the percentage accuracy and the confusion matrix
function [A,M] = eval(F0,D)
global p;
global n;
for i = 1:n
    P(i,:) = ones(1,3);
    for j = 1:length(F0(1,:))
        P(i,1) = P(i,1)*pdf(D{1,j},F0(i,j));
        P(i,2) = P(i,2)*pdf(D{2,j},F0(i,j));
        P(i,3) = P(i,3)*pdf(D{3,j},F0(i,j));
    end
end
P0 = P;
[~,P] = max(P,[],2);
M = zeros(3,3);
for i = 1:n
    if i < p(1)
        M(1,P(i,1)) = M(1,P(i,1)) + 1;
    elseif i < p(2)
        M(2,P(i,1)) = M(2,P(i,1)) + 1;
    else
        M(3,P(i,1)) = M(3,P(i,1)) + 1;
    end
end
A = 100*trace(M)/sum(sum(M,2));
%M = M./sum(M,2);
M = array2table(M','VariableNames',{'Walking','Upstairs','Downstairs'},'RowNames',{'Walking','Upstairs','Downstairs'});
end

