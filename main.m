%Author: Mats Rijkeboer & Winay Sewnarain

%% Clear stuff
close all
clearvars
clc

%% Set parameters
% %%% Audio files: %%% (All Fs = 16kHz)
% - clean_speech
% - clean_speech_2
% - aritificial_nonstat_noise
% - babble_noise
% - Speech_shaped_noise

SNR = -6; % Choose input SNR in dB
M = 33; % Choose filter length
step = 0.2; % Choose (initial) step size
eps = 0.001; % Regularization term
returnCoeffs = 1; % Return filter coefficients of every iteration (1)(needed for plots)
initCoeffs = zeros(1,M); % Initial filter coefficients
samp = 1600; % Length if segments to make Monte Carlo plots
filter = 'nlms'; % Choose which filter to use

%% Make simulated signal
[s,Fs] = audioread('..\..\AudioFiles\clean_speech.wav'); %load clean speech
[n0,~] = audioread('..\..\AudioFiles\aritificial_nonstat_noise.wav'); %load noise
%n0 = rand(length(n0),1);
h=rir(Fs,[19 18 1.6],12,0.9,[20 19 21],[19 18 1.5]); % Make an impulse response
z = conv(s,h); % Make the convolution of s and h
n0(numel(z)) = 0; % Zero pad signals to make same length
n0 = n0(1:length(z)); % Truncate noise to same length as speech
snrat = dot(z,z)/dot(n0,n0); % Calculate snr (not in dB)
SNR2 = 10^(SNR/20); % Calculate SNR (not in dB)
n = n0*sqrt(snrat)/SNR2; % Change noise power to create desired SNR
d = z + n; % Add noise and signal

%% Run the filter function
if isequal(filter,'nlms')
    [y, e, w] = nlms(s, d, M, step, eps, returnCoeffs, initCoeffs); % Use normalized wiener filter
elseif isequal(filter,'tlms')
    [y, e, w] = tlms(s, d, M, step, returnCoeffs, initCoeffs); % Use traditional wiener filter
end

%% Make figures
figure(1); [best_step, best_M] = threedMSE(s,d,n,eps); % Find step size based on MSE (and make 3d plot :p)
figure(2); NoisePSDplot(e,n(M:end),Fs); % Make noise PSD plot of e and n
figure(3); SEplot(e,n(M:end),'ndB') % Plot squared error and MSD of the real and estimated error
figure(4); SEplot(e(9000:9300),n(9000+M-1:9300+M-1),'dB') % Zoomed in version of figure 4
figure(5); t_av = monteCarloPlot(s,n,h,eps,samp,M,step,filter,'dB'); % Plot average squared error of multiple sound samples
figure(6); timeplot(z,d,Fs); % Plot the recieved signal in time domain

%% Performance metrics
NSR0 = snr(n,z); % NSR before filtering
NSR1 = snr(n(M:length(s)),n(M:length(s))-e); % Noise to signal ratio in Db (can't be done for first M samples)
NSR_gain = NSR1-NSR0; % Achieved increase in NSR
samp_time = round(samp*1000/Fs);

%% Play sound
p = audioplayer(e,Fs,16);
play(p)

%% Save figures
saveas(figure(1),'Figures\3dMSE','png')
saveas(figure(2),'Figures\PSD','png')
saveas(figure(3),'Figures\SE','png')
saveas(figure(4),'Figures\SE2','png')
saveas(figure(5),'Figures\MC','png')
saveas(figure(6),'Figures\timeplot','png')

%% Display stuff
delete Figures\Performance.txt
diary Figures\Performance.txt
disp('%%%%%% Input Parameters %%%%%%')
disp(['Filter used: ', filter])
disp(['Input NSR: ', num2str(NSR0),'dB'])
disp(['Filter length: ', num2str(M)])
disp(['Step size: ', num2str(step)])
disp(['MC plot segment length: ', num2str(samp_time),' ms'])
disp('%%%%%%%%%%% Results %%%%%%%%%%')
disp(['Output NSR: ', num2str(round(NSR1)),'dB'])
disp(['NSR gain: ', num2str(round(NSR_gain)),'dB'])
disp(['Optimal filter legnth: ', num2str(best_M)])
disp(['Optimal step size: ', num2str(best_step)])
disp(['Time to filter ', num2str(samp_time),' ms: ', num2str(round(t_av*1000,2)), ' ms'])
diary off
