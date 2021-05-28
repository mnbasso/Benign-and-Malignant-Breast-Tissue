function [GLCM] = glcm(I,offset,graylim, numlevels,symmetric)

%% GLCM Struct

GLCM(1) = struct('Contrast',[],'Correlation',[],'Energy',[],'Entropy',[], 'Homogeneity',[]);

%% GLCM
    
[glcm,~] = graycomatrix(I, 'Offset',offset, 'GrayLimits', graylim, 'NumLevels',numlevels, 'Symmetric', symmetric);
glcm_stats = graycoprops(glcm,'all');

%% Mean Compressed Haralick texture Features

GLCM.Contrast = mean(glcm_stats.Contrast);
GLCM.Correlation = mean(glcm_stats.Correlation);
GLCM.Energy = mean(glcm_stats.Energy);
GLCM.Entropy = mean(glcm_stats.Entropy);
GLCM.Homogeneity = mean(glcm_stats.Homogeneity);

end

