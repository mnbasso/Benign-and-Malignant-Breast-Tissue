function [Features] = hist_features(I)
%HIST_FEATURES Summary of this function goes here
%   Detailed explanation goes here

I = uint8(I);
s = size(I);
[counts,Gray_vector] = imhist(I);
Prob = counts./(s(1)*s(2));

%% Mean
Mean = sum(Prob.*Gray_vector);

%% Variance
Variance = sum(Prob.*(Gray_vector-Mean).^2);

%% Skewness
Skewness  = calculateSkewness(Gray_vector,Prob,Mean,Variance);

%% Kurtosis
Kurtosis = calculateKurtosis(Gray_vector,Prob,Mean,Variance);

%% Energy 
Energy = sum(Prob.*Prob);

%% Entropy
Entropy = -nansum(Prob.*log(Prob));
%% Feature Struct

Features = [Mean,Variance,Skewness,Kurtosis,Energy,Entropy];

function Skewness = calculateSkewness(Gray_vector,Prob,Mean,Variance)
% Calculate Skewness
term1    = Prob.*(Gray_vector-Mean).^3;
term2    = sqrt(Variance);
Skewness = term2^(-3)*sum(term1);
end

function Kurtosis = calculateKurtosis(Gray_vector,Prob,Mean,Variance)
% Calculate Kurtosis
term1    = Prob.*(Gray_vector-Mean).^4;
term2    = sqrt(Variance);
Kurtosis = term2^(-4)*sum(term1);
end

end

