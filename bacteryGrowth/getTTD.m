function [ TTD ] = getTTD( time, measure, thresh_levels )
%GETTDD Summary of this function goes here
%   Detailed explanation goes here
    idx_TTD = zeros(1, length(thresh_levels));
    for i = 1 : length(thresh_levels)
        idx_TTD(i) = find(measure > thresh_levels(i), 1);
    end

    TTD = time(idx_TTD);
end

