function [P,n] = LoadFiles(Img_dir_images)

% LoadFiles
% In this function data is loaded from dataset path
% Images are sorted into desease class and images and info are placed into struct

%% Display 

disp('...Loading Data');

%% Image Dataset File information

num_img = dir(Img_dir_images);
num_img = num_img(~ismember({num_img.name},{'.','..','.DS_Store'}));

%% Struct of Data

n = length(num_img);
P(1:n) = struct('Name','','Label',[],'Disease','','Image', []);

%% Read query image set into a struct

for i = 1:n
    if contains(num_img(i).name,'benign')
        
        P(i).Name = num_img(i).name;
        P(i).Label = 0;
        P(i).Disease = 'Benign';
        P(i).Image = imread(num_img(i).name);
        
    elseif contains(num_img(i).name,'malignant')
        
        P(i).Name = num_img(i).name;
        P(i).Label = 1;
        P(i).Disease = 'Malignant';
        P(i).Image = imread(num_img(i).name);
        
    else
        
        error('Error: No image found');

    end
end

end


