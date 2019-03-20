clear all; close all;
%% Load Experimental Data
load('data/RawData.mat')

[n, numPlot] = size(Calibration.Data);

%% Calibration Courves Plot
figure; hold on; grid on;
title('Calibration Courves')
for i = 1 : numPlot
   semilogx(Calibration.Time, Calibration.Data(:,i), 'LineWidth', 2)
end

%% Measurements Couves Plot
[n, numPlot] = size(Measurement.Data);
figure; hold on; grid on;
title('Measurement Courves')
for i = 1 : numPlot
   semilogx(Calibration.Time, Measurement.Data(:,i), 'LineWidth', 2)
end