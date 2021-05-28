function [IS] = sharpness_metric(I,grad)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

[N,M] = size(I);

num = ((grad./abs(I)).^2).*I;

IS = sum(num(:))./(N.*M);

end

