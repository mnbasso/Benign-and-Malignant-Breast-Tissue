function [nuclei_features] = nuclei_seg_morph_feat(I)
%nuclei_seg_morph_feat
%   This function segments nuclei from hematoxalin stain after stain
%   deconvolution
%   Also, morphological features are extracted from each nuclei and are
%   averaged

%% k-means segmentation

I = im2uint8(I);

[L,~] = imsegkmeans(I,2);

%% Nuclei Morphological Features

BW = bwpropfilt(~imbinarize(L),'area',[100 100]);

nuclei_features = regionprops('table',BW,I,'ConvexArea','Circularity','Eccentricity','EquivDiameter','MeanIntensity');

nuclei_features = table2struct(varfun(@mean,nuclei_features));

end

