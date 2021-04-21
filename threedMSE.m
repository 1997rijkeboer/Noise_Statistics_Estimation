function [step, M] = threedMSE(s,d,n,eps)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
rangeM = [6 12 24 31 32 33 34 60 80 100];%6:15:320; % The range of fiter coefficients to test
stepRange = 0.1:0.1:0.5;%0.03:0.01:0.1; % The range of step sizes to test
MSE = zeros(length(rangeM),length(stepRange));
i=0;

for M = rangeM
    initCoeffs = zeros(1,M); % Initial filter coefficients
    i=i+1;
    j=0;
    for step = stepRange
        j=j+1;
       [~, e, ~] = nlms(s, d, M, step, eps, 0, initCoeffs); % Use normalized wiener filter
       %[~, e, ~] = tlms(s, d, M, step, 0, initCoeffs); % Use normalized wiener filter
       MSE(i,j) = mean(e.^2);
    end
end

%target(1:length(rangeM),1:length(stepRange)) = mean(n.^2);

surf(stepRange,rangeM,MSE)
hold on
%surf(stepRange,rangeM,target)
xlabel('Step size')
ylabel('M') 
zlabel('MSE')
%legend({'Obtained MSE','Noise squared error'},'Location','northeast')

[A, B] = min(MSE);
[~, C] = min(A);
step = stepRange(C);
M = rangeM(B(C));
end

