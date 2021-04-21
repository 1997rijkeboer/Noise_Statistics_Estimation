%Author: Mats Rijkeboer & Winay Sewnarain

function [time] = monteCarloPlot(u0,n0,h,eps,samp,M,step,filter,dB)
%This function splits the signal into pieces of 'samp' samples and plots
%the squared error and MSD of the average of the estimated error. It also
%return the average time it takes matlab to filter each segment.

% Cut signal in pieces
N = floor(length(u0)/samp);
s = zeros(N,samp);
n = zeros(N,samp);
z = zeros(N,samp);
d = zeros(N,samp);
for i = 1:N
    s(i,:) = u0((i-1)*samp+1:i*samp);
    n(i,:) = n0((i-1)*samp+1:i*samp);
    temp = conv(s(i,:),h);
    z(i,:) = temp(1:samp);
    d(i,:) = z(i,:) + n(i,:); % Add noise with equal power as signal
end

% Filter
L = samp-M+1; % Number of iterations in the filter
e = zeros(N,L);
t = zeros(N,1);
initCoeffs = zeros(1,M); % Initial filter coefficients
if isequal(filter,'nlms')
    for i = 1:N
        tic
        [~, e(i,:), ~] = nlms(s(i,:), d(i,:), M, step, eps, 0, initCoeffs); % Use normalized wiener filter
        t(i) = toc;
    end
elseif isequal(filter,'tlms')
    for i = 1:N
        tic
        [~, e(i,:), ~] = tlms(s(i,:), d(i,:), M, step, 0, initCoeffs); % Use traditional wiener filter
        t(i) = toc;
    end
end
time = mean(t);
    
% Plot
subplot(2,1,1) % plot the squared error
plot(mean(e.^2))
hold on
plot(mean(n(:,M:end).^2))
xlabel('Iteration') 
ylabel('Squared error') 
legend({'Obtained error','Noise'},'Location','northeast')

subplot(2,1,2)
MSD = abs(mean(e.^2)-mean(n(M:end).^2)); % Mean squared deviation of noise and error
if isequal(dB,'dB')
    MSDdB = 10*log10(MSD); % Logaritmic scale
    plot(MSDdB);
    ylabel('Deviation [dB]')
else
    plot(MSD);
    ylabel('Deviation')
end
xlabel('Iteration') 

end

