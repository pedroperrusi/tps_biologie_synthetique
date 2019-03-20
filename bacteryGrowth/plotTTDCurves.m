function [ fig ] = plotTTDCurves( time, curves )
%PLOTTTDCURVES Summary of this function goes here
%   Detailed explanation goes here
    [~, numPlot] = size(curves);

    fig = figure; hold on; grid on;
    for i = 1 : numPlot
       semilogx(time, curves(:,i), 'LineWidth', 2)
    end
    xlabel('log(N)')
    ylabel('Optical Density')

end

