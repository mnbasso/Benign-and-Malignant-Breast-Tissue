function [LL_L1,LH_L1,HL_L1,HH_L1] = L1norm_wavelet(LL,LH,HL,HH)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here


%% L1-norm

[m,n] = size(LL);

LL_L1 = sum(LL(:))./(m.*n);
LH_L1 = sum(LH(:))./(m.*n);
HL_L1 = sum(HL(:))./(m.*n);
HH_L1 = sum(HH(:))./(m.*n);

end

