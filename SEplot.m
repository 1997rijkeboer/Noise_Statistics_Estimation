%Author: Mats Rijkeboer & Winay Sewnarain

function [] = SEplot(e,n,dB)
%This function makes a plot of the squared error and the squared noise (the
%target of the squared error), which will tell us something about the
%convergence speed. It also plots the MSD which tells us about the
%stability.

switch nargin
    case 2 % In case only 5 input arguments are given
        dB = 0;
end

subplot(2,1,1) % plot the squared error
plot(e.^2)
hold on
plot(n.^2)
xlabel('Iteration') 
ylabel('Squared error') 
legend({'Obtained error','Noise'},'Location','southeast')

subplot(2,1,2)
MSD = abs(e.^2-n(1:length(e)).^2).^2; % Mean squared deviation of noise and error
if isequal(dB,'dB')
    MSDdB = 10*log10(MSD); % Logaritmic scale
    plot(MSDdB);
    ylabel('MSD [dB]')
else
    plot(MSD);
    ylabel('MSD')
end
xlabel('Iteration') 

end

