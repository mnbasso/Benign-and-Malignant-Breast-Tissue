function [wavelet_features] = WaveletAnalysis(C,S,LL,LH,HL,HH,level,wname,show,map,mode)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

%% Plot Wavelet Decomposition

if show == true
    
    % Define colormap and set rescale value
    colormap(map); rv = length(map);
    % Plot wavelet decomposition using square mode
    plotwavelet2(C,S,level,wname,rv,mode);
    suptitle(['Decomposition at level ',num2str(level)]);
    
end

%% Wavelet Energy

[E_ll,E_lh,E_hl,E_hh] = wenergy2(C,S);

%% Wavelet First Order Statistics

for i = 1:level
        
    % Wavelet Second Order Statistics (Haralick)
    
    [LL_stats(i,:)] = table2array(struct2table(glcm(LL{i}, [0 1; -1 1; -1 0; -1 -1],[],8,false)));
    [LH_stats(i,:)] = table2array(struct2table(glcm(LH{i}, [0 1; -1 1; -1 0; -1 -1],[],8,false)));
    [HL_stats(i,:)] = table2array(struct2table(glcm(HL{i}, [0 1; -1 1; -1 0; -1 -1],[],8,false)));
    [HH_stats(i,:)] = table2array(struct2table(glcm(HH{i}, [0 1; -1 1; -1 0; -1 -1],[],8,false)));

end

%% Wavelet Feature Vector

wavelet_features = reshape([E_ll,E_lh,E_hl,E_hh,LL_stats,LH_stats,HL_stats,HH_stats],1,[]);

end