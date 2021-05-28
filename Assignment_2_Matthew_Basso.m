% BE8105 - Advanced Medical Image Analysis

% Assignment 2: Computer-Aided Diagnosis for Digital Pathology Images
% Matthew Basso, 500686499

%% Clear, close all, clc

clear;
close all;
clc;

%% Load Dataset

% Adding all folders in assignment 2 to path
addpath(genpath('/Users/matthewbasso/Desktop/MASc Courses/BE8105- Advanced Medical Image Analysis/Assignments/Assignment 2'));

% Dataset directory
Img_dir_images = '/Users/matthewbasso/Desktop/MASc Courses/BE8105- Advanced Medical Image Analysis/Assignments/Assignment 2/BE8105 - Adv. Medical Image Analysis - W2020 - 362020 - 1149 AM/Breast Cancer Images';

[P,n] = LoadFiles(Img_dir_images);

cd('/Users/matthewbasso/Desktop/MASc Courses/BE8105- Advanced Medical Image Analysis/Assignments/Assignment 2/Tools');

%% Pre-processing

disp('...Pre-processing');

for i = 1:length(P)
    
    disp(['...GVDF Image:', num2str(i)]);
    [P(i).GVDF] = GVDF(P(i).Image,[3,3]);
    
end

% Pre-processing Metrics
[Noise_metrics] = colour_noise_metrics(P);

%% Feature Extraction

[features] = feature_extraction(P);

%% Features to Array

features_array = struct('Histogram', {features.Histogram}, 'GLCM', {features.GLCM}, 'LBP_features', {features.LBP_features});
features_array = struct2table(features_array,'AsArray',true);
features_array = table2array(features_array);

%% Save as CSV

label = [P.Label]';
formatOut = 'mm_dd_yy';
date = datestr(now,formatOut);

csvwrite(['features_',date,'.csv'], features_array);
csvwrite(['label_',date,'.csv'], label);

%%

X = categorical({'Original' 'GVDF'});
X = reordercats(X,{'Original' 'GVDF'});

x = mean([Noise_metrics.Entropy_Original]);
y = mean([Noise_metrics.Entropy_Filtered]);

figure
b = bar(X,[x y]);
title('Average Entropy of Original vs GVDF','fontsize',20,'fontweight','bold');
ylabel('Entropy');
set(gca,'FontSize',20)


xtips1 = b(1).XEndPoints;
ytips1 = b(1).YEndPoints;
labels1 = string(b(1).YData);
text(xtips1,ytips1,labels1,'HorizontalAlignment','center',...
    'VerticalAlignment','bottom','fontsize',20,'fontweight','bold')

%% Loading features

features = csvread('features_03_19_20.csv');

%% Plotting Boxplots of features

% Z-score normalization
features_norm = zscore(features);

Label1 = find(~[P.Label]');
Label2 = find([P.Label]');

% Boxplot
figure('DefaultAxesFontSize',18);

label = {'Benign','Malignant'};
grp = [zeros(1,length(Label1)),ones(1,length(Label2))];

subplot(2,3,1)
C = [features_norm(Label1,1) ; features_norm(Label2,1)]';
boxplot(C,grp,'Notch','on','Labels',label,'Whisker',1);
title('Mean Intensity Histogram Features');

subplot(2,3,2)
C = [features_norm(Label1,2) ; features_norm(Label2,2)]';
boxplot(C,grp,'Notch','on','Labels',label,'Whisker',1);
title('Variance Intensity Histogram Features');

subplot(2,3,3)
C = [features_norm(Label1,3) ;features_norm(Label2,3)];
boxplot(C,grp,'Notch','on','Labels',label,'Whisker',1);
title('Skewness Intensity Histogram Features');

subplot(2,3,4)
C = [features_norm(Label1,4) ;features_norm(Label2,4)];
boxplot(C,grp,'Notch','on','Labels',label,'Whisker',1);
title('Kurtosis Intensity Histogram Features');

subplot(2,3,5)
C = [features_norm(Label1,5) ;features_norm(Label2,5)];
boxplot(C,grp,'Notch','on','Labels',label,'Whisker',1);
title('Energy Intensity Histogram Features');

subplot(2,3,6)
C = [features_norm(Label1,6) ;features_norm(Label2,6)];
boxplot(C,grp,'Notch','on','Labels',label,'Whisker',1);
title('Entropy Intensity Histogram Features');

% Boxplot GLCM
figure('DefaultAxesFontSize',16);

subplot(1,5,1)
C = [features_norm(Label1,7) ; features_norm(Label2,7)]';
boxplot(C,grp,'Notch','on','Labels',label,'Whisker',1);
title('Contrast GLCM Features');

subplot(1,5,2)
C = [features_norm(Label1,8) ; features_norm(Label2,8)]';
boxplot(C,grp,'Notch','on','Labels',label,'Whisker',1);
title('Correlation GLCM Features');

subplot(1,5,3)
C = [features_norm(Label1,9) ;features_norm(Label2,9)];
boxplot(C,grp,'Notch','on','Labels',label,'Whisker',1);
title('Energy GLCM Features');

subplot(1,5,4)
C = [features_norm(Label1,10) ;features_norm(Label2,10)];
boxplot(C,grp,'Notch','on','Labels',label,'Whisker',1);
title('Entropy GLCM Features');

subplot(1,5,5)
C = [features_norm(Label1,11) ;features_norm(Label2,11)];
boxplot(C,grp,'Notch','on','Labels',label,'Whisker',1);
title('Homogeneity GLCM Features');

% Boxplot LBP
figure('DefaultAxesFontSize',14);

subplot(1,5,1)
C = [features_norm(Label1,12) ; features_norm(Label2,12)]';
boxplot(C,grp,'Notch','on','Labels',label,'Whisker',1);
title('Contrast LBP-GLCM Features');

subplot(1,5,2)
C = [features_norm(Label1,13) ; features_norm(Label2,13)]';
boxplot(C,grp,'Notch','on','Labels',label,'Whisker',1);
title('Correlation LBP-GLCM Features');

subplot(1,5,3)
C = [features_norm(Label1,14) ;features_norm(Label2,14)];
boxplot(C,grp,'Notch','on','Labels',label,'Whisker',1);
title('Energy LBP-GLCM Features');

subplot(1,5,4)
C = [features_norm(Label1,15) ;features_norm(Label2,15)];
boxplot(C,grp,'Notch','on','Labels',label,'Whisker',1);
title('Entropy LBP-GLCM Features');

subplot(1,5,5)
C = [features_norm(Label1,16) ;features_norm(Label2,16)];
boxplot(C,grp,'Notch','on','Labels',label,'Whisker',1);
title('Homogeneity LBP-GLCM Features');


%% T-Test
featnames = ["Mean_hist","Variance_hist","Skewness_hist","Kurtosis_hist","Energy_hist","Entropy_hist","Contrast_glcm","Correlation_glcm","Energy_glcm","Entropy_glcm","Homogeneity_glcm","Contrast_lbp","Correlation_lbp","Energy_lbp","Entropy_lbp","Homogeneity_lbp"];

% Two Sample t-test
[t_test] = two_sample_ttest(features_norm,featnames,Label1,Label2,1);
