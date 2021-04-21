%Author: Mats Rijkeboer & Winay Sewnarain

function freqPlot(y, Fs)
% Function to make time and frequency plot
%   Detailed explanation goes here

% Time Domain signal
tint = (length(y)-1)/Fs;                % length of speech signal in seconds
t = linspace(0, tint, length(y));   

% Frequancy domain
N = length(t);
Y = fftshift(fft(y));   % Fourier Transform and shift center
dF = Fs/N;                      % hertz
f = -Fs/2:dF:Fs/2-dF;           % hertz

% Plot
plot(f,abs(Y)/N)
title('Noise PSD')
ylabel('Intensity')%[arb units]
xlabel('Frequency [Hz]')

end

