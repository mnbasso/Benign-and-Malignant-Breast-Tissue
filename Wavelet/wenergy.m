function [Ell,Elh,Ehl,Ehh] = wenergy(LL,C,S)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

Et = sum(C.^2);
level = size(S,1)-2;

Ell = 100*sum(LL(:).^2)/Et;
Ehl = zeros(1,level);
Elh = Ehl;
Ehh = Ehl;

for k=1:level
    [Ch,Cv,Cd] = detcoef2('all',C,S,k);
    Ehl(k) = 100*sum(Ch(:).^2)/Et;
    Elh(k) = 100*sum(Cv(:).^2)/Et;
    Ehh(k) = 100*sum(Cd(:).^2)/Et;
end

if nargout==2
    Ehl = Ehl + Elh + Ehh;
end

end

