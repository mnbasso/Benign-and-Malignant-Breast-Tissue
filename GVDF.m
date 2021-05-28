function [out] = GVDF(I,win_size)

% Generalized vector directional filter (GVDF)
%   This filter removes noise in colour images using vector image
%   processing
%   This filter uses vector angles to filter the image

%% GVDF sliding window

tic;

ksize = floor(win_size(1)./2);
I_pad = padarray(I,[ksize ksize],0,'both');

m = win_size(1);
n = win_size(2);

row_max = size(I_pad,1)-m+1;
col_max = size(I_pad,2)-n+1;

out = zeros([row_max, col_max, 3]);

for i = 1:row_max
    for j = 1:col_max
        
        Temp = I_pad(i:i+m-1,j:j+n-1,:);
        vectors = reshape(Temp,[],3);
        
        [avg_vector] = distance_sum_angle(vectors);
        avg_vector = reshape(avg_vector,1,1,3);
        out(i,j,:) = avg_vector;
        
    end
end

out = uint8(out);

toc;

end

