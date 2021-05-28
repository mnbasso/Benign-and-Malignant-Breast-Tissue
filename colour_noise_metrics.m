function [Noise_metrics] = colour_noise_metrics(P)

% colour_noise_metrics
%   This function calculates the perfromance of removing noise in colour
%   images

%% Struct with noise metrics

disp('... Image Noise Metrics');

Noise_metrics(1:length(P)) = struct('Name','','Image',[],'Filtered',[],'Entropy_Original',[],'Entropy_Filtered',[],'Sharpness',[]);

for i = 1:length(P)
    
    Noise_metrics(i).Name = P(i).Name;
    Noise_metrics(i).Image = P(i).Image;
    Noise_metrics(i).Filtered = P(i).GVDF;
   
end

%% Entropy

for i = 1:length(P)
    
    q = Noise_metrics(i).Filtered;
    f = Noise_metrics(i).Image;
    
    Noise_metrics(i).Entropy_Original = (entropy(f(:,:,1)) + entropy(f(:,:,2)) + entropy(f(:,:,3)))./3;
    Noise_metrics(i).Entropy_Filtered = (entropy(q(:,:,1)) + entropy(q(:,:,2)) + entropy(q(:,:,3)))./3;
    
end

%% Image Sharpness

for i = 1:length(P)
    
    q = rgb2gray(Noise_metrics(i).Filtered);
    f = rgb2gray(Noise_metrics(i).Image);
    
    Noise_metrics(i).Sharpness = sharpness_metric(f,q);
    
end

end

