clear all; close all;

lgdSize = 30;
tickSize = 25;
axisSize = 30;
TitleSize = 40;
lineW = 8;

%% Load Experimental Data
load('data/RawData.mat')

% %% Calibration Courves Plot
% plotTTDCurves(Calibration.Time, Calibration.Data)
% title('Calibration Curves')
% 
% %% Measurements Couves Plot
% plotTTDCurves(Measurement.Time, Measurement.Data)
% title('Measurement Curves')

%% Prefiltering

% reduce number of curves of measurements
numCurves = 10;

% Shift the data until rapid variations stop
% we remove the 5 first values from measurement and the 8 first from
% Calibration
shift_measurement = 7;
shift_calibration = 4;
% Calibration
timeCalibration = Calibration.Time([shift_calibration : end], :);
filtCalibrationData = Calibration.Data([shift_calibration : end], :);
% Measure 
timeMeasure = Measurement.Time([shift_measurement : end], :);
filtMeasurementData = Measurement.Data([shift_measurement : end], [1 : numCurves]);

% % Remove initial offset (subtract from first value)
% filtCalibrationData = filtCalibrationData - filtCalibrationData(:, 1);
% filtMeasurementData = filtMeasurementData - filtMeasurementData(:, 1);

subplot(2,2,1)
plotTTDCurves(timeMeasure, filtMeasurementData, lineW);
set(gca,'xscale','log')
ax = gca; ax.FontSize = tickSize;
title('Measurement Curves', 'FontSize', TitleSize)
xlabel('log(N)', 'FontSize', axisSize)
ylabel('Optical Density', 'FontSize', axisSize)
xlim([5, 14]);
ylim([0, 0.6]);
%% Estimate TTD
% Based on the first measurement
[L, numCurves] = size(filtMeasurementData);
thresh_levels = 0.2 : 0.05 : 0.4;
TTD = zeros(numCurves, length(thresh_levels));

% estimate values of linear fit for each courve
n = 1;
p = zeros(numCurves, n+1);
TTD1 = zeros(numCurves, 1);

subplot(2,2,2)
hold on; grid on;
for i = 1 : numCurves
    % estimate TTD from each curve
    TTD(i, :) = getTTD(timeMeasure, filtMeasurementData(:,i), thresh_levels);
    plot(thresh_levels, TTD(i, :), 'o', 'LineWidth', lineW);
    % estimate linear fit
    p(i, :) = polyfit(TTD(i, :), thresh_levels, n);
end
%set(gca,'xscale','log');
ax = gca; ax.FontSize = tickSize; 
xlabel('OD (Thresh Levels)', 'FontSize', axisSize)
ylabel('TTD', 'FontSize', axisSize)
title('Estimated TDD', 'FontSize', TitleSize)
xlim([0.19, 0.41]);

%% Plot linear fit regarding each measurement curve
subplot(2,2,3);
hold on; grid on;
%fig_measure = plotTTDCurves(timeMeasure, filtMeasurementData, lineW/2);
for i = 1 : numCurves
    semilogx(TTD(i, :), polyval(p(i, :) ,TTD(i, :)), 'LineWidth', lineW);
end
set(gca,'xscale','log');
ax = gca; ax.FontSize = tickSize;
xlabel('log(N)', 'FontSize', axisSize)
ylabel('Optical Density', 'FontSize', axisSize)
title('Estimated First Order Lines', 'FontSize', TitleSize)
xlim([5, 14]);
ylim([0, 0.6]);

subplot(2,2,4)
plotTTDCurves(timeCalibration, filtCalibrationData, lineW/2);
set(gca,'xscale','log');
ax = gca; ax.FontSize = tickSize;
title('Calibration Curves', 'FontSize', TitleSize)
xlabel('log(N)', 'FontSize', axisSize)
ylabel('Optical Density', 'FontSize', axisSize)
