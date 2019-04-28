function plotTTDCurves( time, curves, lw )
%PLOTTTDCURVES Summary of this function goes here
%   Detailed explanation goes here
    [~, numPlot] = size(curves);

    hold on; grid on;
    for i = 1 : numPlot
       plot(time, curves(:,i), 'LineWidth', lw)
    end

end

