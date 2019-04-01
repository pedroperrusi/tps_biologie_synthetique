clear all; close all;
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

% Plot data again
fig_calibration = plotTTDCurves(timeCalibration, filtCalibrationData);
title('Calibration Curves')

fig_measure = plotTTDCurves(timeMeasure, filtMeasurementData);
title('Measurement Curves')

%% Estimate TTD
% Based on the first measurement
[L, numCurves] = size(filtMeasurementData);
thresh_levels = 0.2 : 0.05 : 0.4;
TTD = zeros(numCurves, length(thresh_levels));

% estimate values of linear fit for each courve
n = 1;
p = zeros(numCurves, n+1);
TTD1 = zeros(numCurves, 1);

figure; hold on; grid on;
for i = 1 : numCurves
    % estimate TTD from each curve
    TTD(i, :) = getTTD(timeMeasure, filtMeasurementData(:,i), thresh_levels);
    semilogx(thresh_levels, TTD(i, :), 'o');
    % estimate linear fit
    p(i, :) = polyfit(TTD(i, :), thresh_levels, n);
end
xlabel('OD')
ylabel('TTD')

%% Plot linear fit regarding each measurement curve
fig_measure = plotTTDCurves(timeMeasure, filtMeasurementData);
title('Measurement Curves')

for i = 1 : numCurves
    plot(TTD(i, :), polyval(p(i, :) ,TTD(i, :)), 'r');
end
