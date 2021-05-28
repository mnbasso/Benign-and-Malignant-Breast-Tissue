function [b] = NormBoxPlot(P,n,verbose)
%% Normalization Validation

ValidationNorm(1:n) = struct('Label','','Mean_Image',[],'Mean_HistNorm',[],'Mean_ReinhardNorm',[],'Mean_MacenkoNorm',[]);

for i = 1:n
    ValidationNorm(i).Label = P(i).Label;
    ValidationNorm(i).Mean_Image = mean2(P(i).Image(:));
    ValidationNorm(i).Mean_HistNorm = mean2(P(i).Image_Norm_Hist(:));
    ValidationNorm(i).Mean_ReinhardNorm = mean2(P(i).Image_Norm_Reinhard(:));
    ValidationNorm(i).Mean_MacenkoNorm = mean2(P(i).Image_Norm_Macenko(:));
end

Norm_Mean_Image = [ValidationNorm.Mean_Image]';
Norm_Mean_HistNorm = [ValidationNorm.Mean_HistNorm]';
Norm_Mean_ReinhardNorm = [ValidationNorm.Mean_ReinhardNorm]';
Norm_Mean_MacenkoNorm = [ValidationNorm.Mean_MacenkoNorm]';

if verbose == 1
    visibility = 'on';
else
    visibility = 'off';
end

%------ BoxPlot
f = figure('visible',visibility);
boxplot([Norm_Mean_Image,Norm_Mean_HistNorm,Norm_Mean_ReinhardNorm,Norm_Mean_MacenkoNorm],'Labels',{'Original','Histogram','Renhard','Macenko'},'Whisker',1);
title('Comparing Different Normalization Methods');
ylabel('Mean Intensity');
xlabel('Normalization Methods');
cd('C:\Users\mnbasso\Desktop\IAMLAB\Code\Data Collected\Normalization Validation');
saveas(f,'Boxplot_Norm_Methods.png');

disp('...Creating Box Plot');
b = true;

end

