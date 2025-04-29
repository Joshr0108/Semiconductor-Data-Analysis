% This script uses measures I-V data from different diodes A -> J
% Linear region must be manually determined to ensure accuracy without
% excessively complicated code
% Linear region is then used to fit a line and calculate ideality factor

%% Plot Log(I) vs V to determine linear Region
clc; clear; close all;

i = 1;

diodeArea = [0.04,  0.04, 0.14, 0.14, 0.14, 0.14, 1.00, 1.40, 0.1, 0.1];
fileName = sprintf('Diode %c.csv', 'A' + i-1);
data = readtable(fileName);
data = data(3:end,:);
    
V = data.Volts;
I = data.millianps * 1e-3;
J = I ./ (diodeArea(i)*1e-6);
    
figure; semilogy(V, I);
    
%% Fit the line to graph, calulate and save graph
% Linear region bounds, Use graph from part 1 to determine limits
lowerLim = 1.73;
upperLim = 1.96;
vRange = (V >= lowerLim) & (V <= upperLim);
vFit = V(vRange);
iFit = log10(I(vRange));
jFit = mean(J(vRange));

% Perform Linear fit on log(I)
coeffs = polyfit(vFit, iFit, 1);
m = coeffs(1);                              % Slope of Log(I) vs. V

% Calculate Ideality Factor
T = mean(data.Centigrade(vRange)) + 273.15; % Mean Temperature (K)
q = 1.602e-19;                              % Electron Charge
k = 1.381e-23;                              % Botlzmann Constant

% Compute Ideality Factor
n = (q / (k * T)) * (1 / (m*log(10)));

% Plot the data and fitted line
figure;
semilogy(V, I, 'b', 'lineWidth', 1.5); hold on;
semilogy(vFit, 10.^polyval(coeffs, vFit), 'r--', LineWidth=1.5);
xlabel('Voltage (V)');
ylabel('Log(Current) (A)')
title(sprintf('Diode I-V Characteristics (%.2fV - %.2fV)', lowerLim, upperLim));
legend('Measured Data', 'Linear Fit ');
grid on;

% Add text to graph with gradient and ideality factor
graphText = sprintf('Gradient: %.4f\nIdeality Factor: %.4f\nCurrent Density: %.4f', m, n, jFit);
text(0.05, 0.95, graphText, 'Units', 'normalized', 'HorizontalAlignment','left','VerticalAlignment','top');

% Save the graph created
graphName = sprintf('Graph%c', 'A' + i -1);
saveas(gcf, [graphName '.png']);

