% The temperature data is experimentally gathered why carrier concentration
% was calculated with other measured variables
% Analysis of data determines the crossover point between intrinsic and
% extrinsic carrier concentration dominance
clc; clear; close all;

% Variables
Temperature = [150, 129, 113, 93.1, 69.5, 48.6, 26.3]; % Celsius
absTemperature = Temperature + 273.15; % Convert to Kelvin
carrierConcentration = [-8.85E+21, -5.46E+21, -3.67E+21, -1.68E+21, -1.04E+21, -8.87E+20, -8.48E+20]; % cm^-3

% Assign Variables
T = absTemperature;
n = carrierConcentration;
log_n = log10(abs(n)); % log10 of abs carrier concentration
inv_T = 1 ./ T; % 1/T

% Polynomial Fitting (Assuming two regions: intrinsic & extrinsic)
coeffs_n = polyfit(inv_T, log_n, 2);
invT_range = linspace(min(inv_T), max(inv_T), 500); % fitting range
log_nFit = polyval(coeffs_n, invT_range);           % fit carrier conc.

% Find the Approximate Crossover Point
[~, idx] = min(abs(diff(log_n))); % Find index where the rate of change is smallest
T_crossover = T(idx); % Approximate equal contribution temperature
invT_crossover = 1 / T_crossover;
log_n_crossover = log10(abs(n(idx))); % Corresponding log10(n)

% Plot log10(Carrier Concentration) vs. 1/T
figure;
hold on;
grid on;

% Shade Extrinsic Region (left of crossover)
fill([min(inv_T), invT_crossover, invT_crossover, min(inv_T)], ...
     [min(log_nFit), min(log_nFit), max(log_nFit), max(log_nFit)], ...
     [0.8 0.8 1], 'FaceAlpha', 0.3, 'EdgeColor', 'none'); % Light blue

% Shade Intrinsic Region (right of crossover)
fill([invT_crossover, max(inv_T), max(inv_T), invT_crossover], ...
     [min(log_nFit), min(log_nFit), max(log_nFit), max(log_nFit)], ...
     [1 0.8 0.8], 'FaceAlpha', 0.3, 'EdgeColor', 'none'); % Light red

% Plot Data Points and Fit
plot(inv_T, log_n, 'ro', 'MarkerSize', 6, 'LineWidth', 1.5);
plot(invT_range, log_nFit, 'b-', 'LineWidth', 2);

% Vertical Line at Crossover Point
plot([invT_crossover, invT_crossover], ylim, 'k--', 'LineWidth', 1.5);

% Annotate the Crossover Point
plot(invT_crossover, log_n_crossover, 'ks', 'MarkerSize', 8, 'MarkerFaceColor', 'r');
text(invT_crossover + 0.00001, log_n_crossover+0.04, sprintf('%.1f K', T_crossover), ...
    'Color', 'k', 'FontSize', 8, 'FontWeight', 'bold');

xlabel('1 / Temperature (1/K)');
ylabel('log_{10}(Carrier Concentration) (cm^{-3})');
title('log_{10}(Carrier Concentration) vs. 1/T');

legend('Intrinsic Region', 'Extrinsic Region', 'Data Points', 'Polynomial Fit', 'Crossover Point');

