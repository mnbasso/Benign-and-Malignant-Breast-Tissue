function [avg_vector] = distance_sum_angle(vectors)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here


vectors = double(vectors);

for i = 1:length(vectors)
    
    ref = vectors(i,:);
    
    idx = ones(1,length(vectors))';
    idx(i,:) = 0;
    idx = idx.*(1:length(vectors))';
    idx(idx==0) = [];
    
    x = vectors(idx,:);
    
    for k = 1:length(x)
        
        vect = x(k,:);
        
        num = ref(1)*vect(1) + ref(2)*vect(2) + ref(3)*vect(3);
        den = sqrt((ref(1)).^2 + (ref(2)).^2 + (ref(3)).^2) .* sqrt((vect(1)).^2 + (vect(2)).^2 + (vect(3)).^2) ;
        
        d(k,:,i) = acos(num./den);
        
    end
    
    d_sum(i,:) = real(sum(d(:,:,i)));
    
end

[~,I] = sort(d_sum);

m = floor(length(vectors)/2)+1;

avg_vector = mean(vectors(I(1:m),:),1);

end

