function plotExpData( structure )
%PLOTEXPDATA Summary of this function goes here
%   Detailed explanation goes here
    [~, numPlot] = size(structure.Data);

    figure; hold on; grid on;
    title('Calibration Courves')
    for i = 1 : numPlot
       semilogx(structure.Time, structure.Data(:,i), 'LineWidth', 2)
    end
    xlabel('log(N)')
    ylabel('Optical Density')

end

