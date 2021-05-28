function [LL_mean,LH_mean,HL_mean,HH_mean] = wmean(LL,LH,HL,HH)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%% Mean of wavelet coefficients

LL_mean = mean2(LL);
LH_mean = mean2(LH);
HL_mean = mean2(HL);
HH_mean = mean2(HH);

end

