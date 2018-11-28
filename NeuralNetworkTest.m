% MAE 527 Final Project: Activity Classification
% Author: Shivam

clear all;

addpath('NN Functions');

% Importing feature vectors for the test data
load('test.mat');
F = [test{1};test{2};test{3}];

p(1) = length(test{1}(:,1)) + 1;
p(2) = p(1) + length(test{2}(:,1));
n = length(F(:,1));

load('M.mat');
load('S.mat');
load('coeff.mat');
F = (F-M)./S; % Scaling the feature vectors

load('theta.mat'); % Importing weights for the trained neural networkk

% Evaluating the performance on the test set
[A,M] = eval0(F,theta,p);
fprintf('Overall accuracy: %0.2f %% \n \n',A);
disp(M);

