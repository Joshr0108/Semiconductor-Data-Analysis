% This produces a graph of Hall voltage on Temperature
% Data was experimentally produced with a Germanium sample
% Code also determines the temperature variation allowed to maintain 10%
% accuracy of hall voltage
clc; clear; close all;

% Variables
Temperature = [150, 129, 113, 93.1, 69.5, 48.6, 26.3]; % Celsius
absTemperature = Temperature + 273.15; % Convert to Kelvin
hallVoltage = [-3.6e-3, -5.80E-03, -8.70E-03, -1.91E-02, -3.13E-02, -3.68E-02, -3.86E-02]; % Volts
mobility = [-0.12952, -0.12681, -0.12781, -0.18153, -0.23108, -0.27011, -0.30036]; % cm^2/Vs
carrierConcentration = [-8.85E+21, -5.46E+21, -3.67E+21, -1.68E+21, -1.04E+21, -8.87E+20, -8.48E+20]; % cm^-3

% Assign Variables
T = absTemperature;
Vh = hallVoltage;
u = mobility;
n = carrierConcentration;


% Generate Smooth Fit Range
tRange = linspace(min(T), max(T),500);

% Polynomial Fitting
coeffs = polyfit(T, Vh, 3);
VhFit = polyval(coeffs, tRange);

% Compute the +/- 10% tolerance
tRef = [30, 80] + 273.15;
VhRef = polyval(coeffs, tRef);
VhUpper = 1.1 * VhRef;
VhLower = 0.9 * VhRef;

% Calculate the temperatrue at tolerance
tRange30 = interp1(VhFit, tRange, [VhLower(1), VhUpper(1)], 'linear');
tRange80 = interp1(VhFit, tRange, [VhLower(2), VhUpper(2)], 'linear');

% Plot Hall Voltage vs. Temperature
figure;
plot(T, Vh, 'ro', 'MarkerSize', 6, 'LineWidth', 1.5); hold on;
plot(tRange, polyval(coeffs, tRange), 'b-', 'LineWidth', 2);
xlabel('Temperature (K)');
ylabel('Hall Voltage (V)');
title('Hall Voltage vs. Temperature');
grid on;

% Plot reference Points
plot(tRef, VhRef, 'ks', 'MarkerSize', 8, 'MarkerFaceColor', 'k'); % Reference points
plot(tRange80, [VhLower(2),VhUpper(2)], 'kx', 'MarkerSize',8,'MarkerFaceColor', 'k');
plot(tRange30, [VhLower(1),VhUpper(1)], 'kx', 'MarkerSize',8,'MarkerFaceColor', 'k');
yline(VhUpper(1), '--g', 'LineWidth', 1.5); % ±10% for 30°C
yline(VhLower(1), '--g', 'LineWidth', 1.5);
yline(VhUpper(2), '-.m', 'LineWidth', 1.5); % ±10% for 80°C
yline(VhLower(2), '-.m', 'LineWidth', 1.5);
% Add Text Annotations for ±10% Voltage Limits
text(tRef(1)+110, VhUpper(1) - 0.001, sprintf('\\bf%.4f V', VhUpper(1)), 'Color', 'g', 'FontSize', 7);
text(tRef(1)+110, VhLower(1) - 0.001, sprintf('\\bf%.4f V', VhLower(1)), 'Color', 'g', 'FontSize', 7);
text(tRef(2)+60, VhUpper(2) - 0.001, sprintf('\\bf%.4f V', VhUpper(2)), 'Color', 'm', 'FontSize', 7);
text(tRef(2)+60, VhLower(2) - 0.001, sprintf('\\bf%.4f V', VhLower(2)), 'Color', 'm', 'FontSize', 7);
text(tRef(1) + 55, VhRef(1), sprintf('\\bf30°C: %.4f V', VhRef(1)), 'Color', 'k', 'FontSize', 11, 'FontWeight', 'bold', 'HorizontalAlignment', 'right');
text(tRef(2) + 45, VhRef(2), sprintf('\\bf80°C: %.4f V', VhRef(2)), 'Color', 'k', 'FontSize', 11, 'FontWeight', 'bold', 'HorizontalAlignment', 'right');
text(tRange30(1)-15, VhLower(1) + 0.0015, sprintf('\\bf%.1fK', tRange30(1)), 'Color', 'g', 'FontSize', 10, 'FontWeight', 'bold');
text(tRange30(2), VhUpper(1) + 0.002, sprintf('\\bf%.1fK', tRange30(2)), 'Color', 'g', 'FontSize', 10, 'FontWeight', 'bold');
text(tRange80(1)-15, VhLower(2) + 0.0015, sprintf('\\bf%.1fK', tRange80(1)), 'Color', 'm', 'FontSize', 10, 'FontWeight', 'bold');
text(tRange80(2)-15, VhUpper(2) + 0.0015, sprintf('\\bf%.1fK', tRange80(2)), 'Color', 'm', 'FontSize', 10, 'FontWeight', 'bold');

legend('Data Points', 'Polynomial Fit');
