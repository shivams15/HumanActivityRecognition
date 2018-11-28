% MAE 527 Final Project: Activity Classification
% Author: Shivam

clear all;

addpath('1D Recognizer');

% Generating motion templates from the training data
for j = 1:3
    X = cell(7,1);
    Y = X;
    for i = [1,2,3,4]
        name = sprintf('Data/sub%d/%d/kinematics.mat',i,j);
        load(name);
        ac = sqrt(acc(:,1).^2 + acc(:,2).^2 + acc(:,3).^2);
        v = sqrt(vel(:,1).^2 + vel(:,2).^2 + vel(:,3).^2);
        x = [at_f,velmag_f,pos(:,3),vel(:,3),v,pos(:,2),ac];
        y = [time,time,time,time,time,pos(:,3),time];
        for k = 1:length(motionStart)
            for l = 1:length(x(1,:))
                a = x(:,l);
                b = y(:,l);
                A = [a(motionStart(k):motionEnd(k),1), b(motionStart(k):motionEnd(k),1)];
                B = resample1(A);
                B = scale2square(B);
                X{l,1} = [X{l,1}, B(:,1)];
                Y{l,1} = [Y{l,1}, B(:,2)];
            end
        end
    end
    for l = 1:length(x(1,:))
        Xm{l,1}(:,j) = mean(X{l,1},2);
        Ym{l,1}(:,j) = mean(Y{l,1},2);
        for i = 1:96
            G = [X{l,1}(i,:);Y{l,1}(i,:)]';
            C{l}(2*(j-1)+1:2*j,2*(i-1)+1:2*i) = cov(G);
        end
    end
end

for l = 1:length(x(1,:))
    dlmwrite(sprintf('Templates/%d_x.txt',l),Xm{l,1});
    dlmwrite(sprintf('Templates/%d_y.txt',l),Ym{l,1});
    dlmwrite(sprintf('Templates/%d_C.txt',l),C{l});
end