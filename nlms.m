%Author: Mats Rijkeboer & Winay Sewnarain

function [y, e, W] = nlms(s, d, M, step, eps, returnCoeffs, initCoeffs)
% This function is a wiener filter which minimizes the mean-sqaure error.
%   The filter coefficients are calculated in real time using an iterative
%   approach based on ... . 
%
% %%%% Input arguments %%%%
% s         : Input of the adaptive filter  (interferer/noise/music)
% d         : Desired signal (microphone signal)
% M         : Filter coefficients
% step      : Step size of the algorithm
% eps       : Regularization term (make it small if SNR is small)
% returnCoeffs: Return filter coefficients of every iteration
% initCoeffs: Initial filter coefficients (optional)
% 
% %%%% Output arguments %%%
% y         : Filtered signal s
% e         : minimized error (=noise)
% W         : Filter coefficients of each iteration

switch nargin
    case 5 % In case only 5 input arguments are given
        returnCoeffs = 0; % Do not return filter coefficients of all iterations
        initCoeffs = zeros(M,1); % Make array of zeros of length M (initial filter)
    case 6 % In case no initial filter coefficients are given
        initCoeffs = zeros(M,1); % Make array of zeros of length M (initial filter)
end

% Initialize some stuff
N = length(s)-M+1; % Number of iterations
y = zeros(N,1); % Filter output
e = zeros(N,1); % Error signal
w = initCoeffs; % Initial filter coeffs
X = zeros(M,N); % Initialize X as NxM zeros matrix
if returnCoeffs
    W = zeros(N,M); % Matrix to hold coeffs for each iteration
else
    W = NaN; % W is not used
end

for i = 1:N % Fill x with the time frames and shifted one sample each time
    X(:,i) = s(i:M+i-1);
end

Xk = X; %flip(X); % Flip X to make the newest sample the highest
for n = 1:N % Perform the filtering
    x = Xk(:,n); % Select one frame to filter
    y(n) = dot(x,w); % Dot product of x and w
    e(n) = d(n+M-1)-y(n); % Calculate the error 
    normFactor = 1./(dot(x,x)+eps); % Normalize the error
    w = w + step*normFactor*x'*e(n); % calculate filter
    if returnCoeffs
        W(n,:) = w; % 'save' all filters in W
    end
end

end

