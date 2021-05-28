function [stats] = haralick(I)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

%% Struct

stats(1) = struct('Contrast',[],'Correlation',[],'Energy',[],'Entropy',[], 'Homogeneity',[]);

%% Haralick Features

texture_stats = graycoprops(I,'all');

%% Mean Compressed Haralick texture Features

stats.Contrast = mean(texture_stats.Contrast);
stats.Correlation = mean(texture_stats.Correlation);
stats.Energy = mean(texture_stats.Energy);
stats.Entropy = mean(texture_stats.Entropy);
stats.Homogeneity = mean(texture_stats.Homogeneity);

end

