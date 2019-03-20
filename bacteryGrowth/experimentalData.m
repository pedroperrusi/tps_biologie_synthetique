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
% we remove the 5 first values from measurement and the 8 first from
% Calibration

shift_measurement = 7;
shift_calibration = 5;
% Calibration
timeCalibration = Calibration.Time([shift_calibration : end], :);
filtCalibrationData = Calibration.Data([shift_calibration : end], :);

% Measure 
timeMeasure = Measurement.Time([shift_measurement : end], :);
filtMeasurementData = Measurement.Data([shift_measurement : end], :);

% Plot data again
fig_calibration = plotTTDCurves(timeCalibration, filtCalibrationData)
title('Calibration Curves')

fig_measure = plotTTDCurves(timeMeasure, filtMeasurementData)
title('Measurement Curves')

%% Estimate TTD
low_thresh_level = 0.2; % Optical density threshold level
high_thresh_level = 0.4; % Optical density threshold level
idx_low = find(filtMeasurementData == low_thresh_level);
idx_high = find(filtMeasurementData == high_thresh_level);
