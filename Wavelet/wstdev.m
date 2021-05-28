function [LL_std,LH_std,HL_std,HH_std] = wstdev(LL,LH,HL,HH)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

%% Std of Wavelet
LL_std = std2(LL);
LH_std = std2(LH);
HL_std = std2(HL);
HH_std = std2(HH);


end

