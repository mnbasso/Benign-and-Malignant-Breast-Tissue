function [out] = lbp_color(I,win_size)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

ksize = floor(win_size(1)./2);
I_pad = double(padarray(I,[ksize ksize],'symmetric','both'));

m = win_size(1);
n = win_size(2);

C = round(win_size(1)./2);
F = round((n.*m)./2);

row_max = size(I_pad,1)-m+1;
col_max = size(I_pad,2)-n+1;

out = zeros([row_max, col_max]);

for i = 1:row_max
    for j = 1:col_max
        
        Temp = I_pad(i:i+m-1,j:j+n-1,:);
        Temp = reshape(Temp,[],3);
        
        for k = 1:length(Temp)
            
            Temp_d(k) = sqrt(Temp(k,1).^2 + Temp(k,2).^2 + Temp(k,3).^2);
            
        end
        
        thresh = Temp(F,:);
        thresh_d = sqrt(thresh(1).^2 + thresh(2).^2 + thresh(3).^2);
             
        label = Temp_d-thresh_d;
        label(label>0) = 1;
        label = reshape(uint8(label),m,n);

        out(i,j) = label(C,win_size(1)) + label(win_size(1),win_size(1))*2 + label(win_size(1),C)*4 + label(win_size(1),1)*8 + label(C,1)*16 + label(1,1)*32 + label(1,C)*64 + label(1,win_size(1))*128;

    end
end

out = uint8(out);

end


