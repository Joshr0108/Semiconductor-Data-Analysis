% This script completes the computation of semiconductor bandgap 
% using the determined ideality factor
clc; clear; close all; Vg=[];

for i = 1:10

    diodeArea = [0.04,  0.04, 0.14, 0.14, 0.14, 0.14, 1.00, 1.40, 0.1, 0.1];
    diodeRange = [1.73, 1.96; 2.5, 2.75; 0.55, 0.71; 0.68, 0.91; 1, 1.22; 
              1.5, 1.64; 2.62, 2.76; 0.49, 0.8; 0.06, 0.26; 0.04, 0.15];
    fileName = sprintf('Diode %c.csv', 'A' + i-1);
    data = readtable(fileName);
    data = data(3:end,:);
        
    if i <9
        V = data.Volts;
    elseif i >8
        V = data.Volts / 7;
    end
    I = data.millianps * 1e-3;
    J = I ./ (diodeArea(i)*1e-6);
        
    % Linear region bounds, Use graph from part 1 to determine limits
    lowerLim = diodeRange(i,1);
    upperLim = diodeRange(i,2);
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
    
    % Compute bandgap
    Vg(i) = 0.5*(upperLim + lowerLim) - (n*k*T*log(jFit/21.59e6))/q;

end