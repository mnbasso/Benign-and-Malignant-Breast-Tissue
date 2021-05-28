function [features] = feature_extraction(P)
%feature_extraction
%   In this function, different feature extraction metrics will be gathered

tic;

disp('...Feature Extraction');

%% Feature Struct

features(1:length(P)) = struct('Name','','Image',[]);

for i = 1:length(P)
    
    features(i).Name = P(i).Name;
    features(i).Image = P(i).GVDF;
    
end

%% Histogram Features

disp('...Histogram Based Features');
for i = 1:length(P)
    
    [features(i).Histogram] = hist_features(rgb2gray(features(i).Image));
    
end

%% GLCM

disp('...GLCM Features');
for i = 1:length(P)
    
    I = rgb2gray(features(i).Image);
    [features(i).GLCM] = table2array(struct2table(glcm(I,[0 1; -1 1; -1 0; -1 -1],[], 9,false)));
    
end

%% Wavelet Transform

% disp('...Wavelet Transform Features');
% 
% level = 3;
% wname = 'sym2';
% show = false;
% 
% for i = 1:length(P)
%     
%     % Image pre-processing
%     I = rgb2gray(features(i).Image);
%     
%     % 2-D Wavelet Decomposition
%     [c,s] = wavedec2(I,level,wname);
%     
%     for k = 1:level
%         
%         LL{k} = appcoef2(c,s,wname,k); % approx
%         [LH{k}, HL{k}, HH{k}] = detcoef2('all',c,s,k); % detail
%         
%     end
%     
%     [features(i).wavelet_features] = WaveletAnalysis(c,s,LL,LH,HL,HH,level,wname,show,gray,'tree');
%         
% end

%% LBP

disp('...LBP Features');
for i = 1:length(P)
    
    [features(i).LBP] = lbp_color(P(i).Image,[3,3]);
    [features(i).LBP_features] = table2array(struct2table(glcm(features(i).LBP,[0 1; -1 1; -1 0; -1 -1],[], 9,false)));

end

toc;
end

