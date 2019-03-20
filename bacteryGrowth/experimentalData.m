clear all; close all;
%% Load Experimental Data
load('data/RawData.mat')

%% Calibration Courves Plot
plotTTDCurves(Calibration.Time, Calibration.Data)
title('Calibration Curves')

%% Measurements Couves Plot
plotTTDCurves(Measurement.Time, Measurement.Data)
title('Measurement Curves')

%% Prefiltering
% we remove the 5 first values from measurement and the 8 first from
% Calibration

% Calibration
timeCalibration = Calibration.Time([8 : end], :);
filtCalibrationData = Calibration.Data([8 : end], :);

% Measure 
timeMeasure = Measurement.Time([5 : end], :);
filtMeasurementData = Measurement.Data([5 : end], :);

% Plot data again
plotTTDCurves(timeCalibration, filtCalibrationData)
title('Calibration Curves')

plotTTDCurves(timeMeasure, filtMeasurementData)
title('Measurement Curves')

%% Estimate TTD
low_thresh_level = 0.3; % Optical density threshold level
indexes = find(Measurement.Data == low_thresh_level);