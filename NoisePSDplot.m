%Author: Mats Rijkeboer & Winay Sewnarain

function [] = NoisePSDplot(e,n,Fs)
%This function makes PSD plot of real and estimated noise
%
subplot(2,2,1)
freqPlot(n, Fs) % Real noise PSD
title('Real noise PSD')
subplot(2,2,2)
freqPlot(e, Fs) % Estimated noise PSD;
title('Estimated noise PSD')
subplot(2,2,[3,4])
freqPlot(e, Fs) % Real noise PSD
hold on
freqPlot(n, Fs) % Estimated noise PSD;
title('Real and estimated noise PSD')
legend({'Estimated noise PSD','Real noise PSD'},'Location','southeast')
end

