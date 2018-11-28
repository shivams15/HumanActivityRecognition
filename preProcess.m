% MAE 527 Final Project: Activity Classification
% Author: Shivam

clear all;

addpath('1D Recognizer');

% Importing templates obtained from the training data
for l = 1:7
    X{l,1} = importdata(sprintf('Templates/%d_x.txt',l));
    Y{l,1} = importdata(sprintf('Templates/%d_y.txt',l));
    L{l,1} = importdata(sprintf('Templates/%d_C.txt',l));
end

% Generating distance-based feature vectors for all training examples 
for j = 1:3
    F{j} = []; 
    for i = [1,2,3,4]
        name = sprintf('Data/sub%d/%d/kinematics.mat',i,j);
        load(name);
        ac = sqrt(acc(:,1).^2 + acc(:,2).^2 + acc(:,3).^2);
        v = sqrt(vel(:,1).^2 + vel(:,2).^2 + vel(:,3).^2);
        x = [at_f,velmag_f,pos(:,3),vel(:,3),v,pos(:,2),ac];
        y = [time,time,time,time,time,pos(:,3),time];
        for k = 1:length(motionStart)
            for m = 1:3
                for l = 1:length(x(1,:))
                    Xm = X{l,1};
                    Ym = Y{l,1};
                    C = L{l,1};
                    a = x(:,l);
                    b = y(:,l);
                    A = [a(motionStart(k):motionEnd(k),1), b(motionStart(k):motionEnd(k),1)];
                    B = resample1(A);
                    B = scale2square(B);
                    d(7*(m-1)+l) = ED(B,m,0,Xm,Ym);
                end
            end
            F{j} = [F{j}; d];
        end
    end
end

% Splitting the dataset into a training set and a test set
for i = 1:3
    s = RandStream('mlfg6331_64');
    N = length(F{i}(:,1));
    D = datasample(s,1:N,floor(0.65*N),'Replace',false);
    train{i} = F{i}(D,:);
    F{i}(D,:) = [];
    test{i} = F{i};
end

save train.mat train;
save test.mat test;
T = [train{1};train{2};train{3}];
M = mean(T);
S = std(T);
[coeff,score,latent,tsquared,explained,mu] = pca((T-M)./S);
save M.mat M;
save S.mat S;
save coeff.mat coeff;