clear all; close all;
%% Load Experimental Data
load('data/RawData.mat')

%% Calibration Courves Plot
plotExpData(Calibration)

%% Measurements Couves Plot
plotExpData(Measurement)

%% Estimate TTD
low_thresh_level = 0.3; % Optical density threshold level
indexes = find(Measurement.Data == low_thresh_level);