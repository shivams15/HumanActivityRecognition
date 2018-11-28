% MAE 527 Final Project: Activity Classification
% Author: Shivam

clear all;
global n;
global p;

% Importing feature vectors for the training data
load('train.mat');

% Taking equal number of samples from each class
s = RandStream('mlfg6331_64');
D = datasample(s,1:length(train{1}(:,1)),120,'Replace',false);
train{1} = train{1}(D,:);

F = [train{1};train{2};train{3}];
p(1) = length(train{1}(:,1)) + 1;
p(2) = p(1) + length(train{2}(:,1));
n = length(F(:,1));

load('M.mat');
load('S.mat');
load('coeff.mat');
F = (F-M)./S;
F = F*coeff; % Generating the principal components for the training data
F = F(:,1:13); % Selecting the 13 most important principal components
I = fselect(F); % Using a backward sequential seach for feature selection
save I.mat I; % I contains the index of features that are rejected

% Eliminating the rejected features
for i = 1:length(I)
    F(:,I(i)) = [];
end

% Fitting a GMM to the training data for each class, assuming the features
% are independent of each other
D = gmfit(F);
save D.mat D;

% Evaluating the performance of the Naive Bayes classifier over the
% training set
[A,M] = eval1(F,D);
fprintf('Overall accuracy: %0.2f %% \n \n',A);
disp(M);

% A backward sequential search routine for feature selection
function [I] = fselect(F)
global n;
global p;
N = length(F(1,:));
D = gmfit(F);
E = eval(F,D);
I = [];
while N > 1
    L = 0;
    for i = 1:N
        f = [F(:,1:i-1),F(:,i+1:N)];
        D = gmfit(f);
        e = eval(f,D);
        if e <= E
            L = i;
            E = e;
        end
    end
    if L == 0
        break;
    else
        N = N - 1;
        I(length(I)+1) = L;
        F(:,L) = [];
    end
end
end

% Function that fits a GMM to the feature vectors for each class
function [D] = gmfit(F0)
global p;
F1 = F0(1:p(1)-1,:);
F2 = F0(p(1):p(2)-1,:);
F3 = F0(p(2):end,:);
for i = 1:length(F0(1,:))
    D{1,i} = fitgmdist(unique(F1(:,i)),1,'Options',statset('MaxIter',1000));
    D{2,i} = fitgmdist(unique(F2(:,i)),1,'Options',statset('MaxIter',1000));
    D{3,i} = fitgmdist(unique(F3(:,i)),1,'Options',statset('MaxIter',1000));
end
end

% Evaluates the number of misclassifications for the selected set of features
function [E] = eval(F0,D)
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
[~,P] = max(P,[],2);
E = 0;
for i = 1:n
    if i < p(1) && P(i,1) ~= 1
        E = E+1;
    end
    if i >= p(1) && i < p(2) && P(i,1) ~= 2
        E = E+1;
    end
    if i >= p(2) && i <= n && P(i,1) ~= 3
        E = E+1;
    end
end
end

% Returns the percentage accuracy and the confusion matrix
function [A,M] = eval1(F0,D)
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


