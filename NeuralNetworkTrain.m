% MAE 527 Final Project: Activity Classification
% Author: Shivam

clear all;

addpath('NN Functions');

% Importing feature vectors for the training data
load('train.mat');

% Selecting almost equal number of samples from each class 
s = RandStream('mlfg6331_64');
D = datasample(s,1:length(train{1}(:,1)),160,'Replace',false);
train{1} = train{1}(D,:);

F = [train{1};train{2};train{3}];
p(1) = length(train{1}(:,1)) + 1;
p(2) = p(1) + length(train{2}(:,1));
n = length(F(:,1));

load('M.mat');
load('S.mat');
load('coeff.mat');
F = (F-M)./S; % Scaling the feature vectors

R(1:p(1)-1) = 1;
R(p(1):p(2)-1) = 2;
R(p(2):length(F(:,1))) = 3;

% Generating the appropriate output vectors for each training sample
R0 = RVec1(R);

%Initializing the neural network architecture
h = [12 6]; %number of neurons in each hidden layer
N = [length(F(1,:)), h, 3]; % number of neurons in each layer (includes the input and output layer)
N0 = 0;

for i = 2:length(N)
    N0 = N0 + N(i)*(N(i-1) + 1);
end

lambda = 3; % Regularization parameter
load('seed.mat'); % Importing an rng seed to ensure reproducibility
rng(seed);
thetaV = rand(N0,1); % Generating random initial weights for the neural network
theta0 = optim0(thetaV,500,F,R0,N,lambda); % Call to the batch gradient descent function for optimization of the weights

for i = 1:length(N)-1
    theta{i} = reshape(theta0(1:N(i+1)*(N(i)+1)),N(i+1),N(i)+1);
    theta0(1:N(i+1)*(N(i)+1)) = [];
end

% Evaluating the performance of the neural network on the training data
[A,M] = eval0(F,theta,p);
fprintf('Overall accuracy: %0.2f %% \n \n',A);
disp(M);

% Saving the weights for future use
save theta.mat theta

% A gradient descent function for optimizing the weights for the neural
% network
function [theta] = optim0(theta,iter,F1,R01,N,lambda)
costFunc = @(theta) costF(theta,F1,R01,N,lambda); % Function handle that returns cost function and gradient information
alpha = 0.5; % Learning rate
for i = 1:iter
    [J1, D] = costFunc(theta);
    theta = theta - alpha*D; % Gradient descent
end
end

