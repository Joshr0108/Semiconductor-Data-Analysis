% This produces a graph of charge carrier mobility on temperature
% Data was experimentally produced with a Germanium sample
% Analysis provides temperature at which mobility falls by 20% of room
% temperature
clc; clear; close all;

% Variables
Temperature = [150, 129, 113, 93.1, 69.5, 48.6, 26.3]; % Celsius
absTemperature = Temperature + 273.15; % Convert to Kelvin
mobility = [-0.12952, -0.12681, -0.12781, -0.18153, -0.23108, -0.27011, -0.30036]; % cm^2/Vs

% Assign Variables
T = absTemperature;
u = mobility;

% Generate Smooth Fit Range
tRange = linspace(min(T), max(T), 500);

% Polynomial Fitting
coeffs = polyfit(T, u, 3);
uFit = polyval(coeffs, tRange);

% Compute Mobility at Room Temperature 
roomTemp = min(T);
uRoomTemp = polyval(coeffs, roomTemp);
u80 = 0.8 * uRoomTemp; % 20% drop

% Find Temperature where Mobility Drops to 80% of Room Temperature
T80 = interp1(uFit, tRange, u80, 'linear');

% Plot Mobility vs. Temperature
figure;
plot(T, u, 'ro', 'MarkerSize', 6, 'LineWidth', 1.5); hold on;
plot(tRange, uFit, 'b-', 'LineWidth', 2);
xlabel('Temperature (K)');
ylabel('Mobility (cm^2/Vs)');
title('Mobility vs. Temperature');
grid on;

% Annotate Room Temperature Mobility
plot(roomTemp, uRoomTemp, 'ks', 'MarkerSize', 8, 'MarkerFaceColor', 'k');
text(roomTemp + 15, uRoomTemp+0.01, sprintf('\\bfRoom Temp: %.1f K, %.4f cm^2/Vs', roomTemp, uRoomTemp), 'Color', 'k', 'FontSize', 10, 'FontWeight', 'bold');

% Annotate the Drop Point
plot(T80, u80, 'gs', 'MarkerSize', 8, 'MarkerFaceColor', 'g');
text(T80 + 15, u80, sprintf('\\bfDrop: %.1f K, %.4f cm^2/Vs', T80, u80), 'Color', 'g', 'FontSize', 10, 'FontWeight', 'bold');

legend('Data Points', 'Polynomial Fit', 'Room Temp Mobility', '20% Drop Point');
