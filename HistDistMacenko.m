function [HistDistM] = HistDistMacenko(P, TargetImage, n)

HistDistM = array2table(zeros(n,3),'VariableNames',{'HI_Hue','HI_Sat','HI_Val'});


for i = 1:n
    
    hsvImage = rgb2hsv(P(i).Image_Norm_Macenko);
    hImage = hsvImage(:, :, 1);
    sImage = hsvImage(:, :, 2);
    vImage = hsvImage(:, :, 3);
    
    hsvTargetImage = rgb2hsv(TargetImage);
    hTargetImage = hsvTargetImage(:, :, 1);
    sTargetImage = hsvTargetImage(:, :, 2);
    vTargetImage = hsvTargetImage(:, :, 3);
    
    
    [hSource] = histcounts(hImage,255);
    [hTarget] = histcounts(hTargetImage,255);
    [sSource] = histcounts(sImage,255);
    [sTarget] = histcounts(sTargetImage,255);
    [vSource] = histcounts(vImage,255);
    [vTarget] = histcounts(vTargetImage,255);
    
%     figure('visible',visibility);
%     subplot(1,3,1);
%     histogram(hImage,255);
%     grid on;
%     title('Hue Histogram');
%     
%     hold on
%     histogram(hTargetImage,255);
%     hold off
%     
%     subplot(1,3,2);
%     histogram(sImage,255);
%     grid on;
%     title('Saturation Histogram');
%     
%     hold on
%     histogram(sTargetImage,255);
%     hold off
%     
%     subplot(1,3,3);
%     histogram(vImage,255);
%     grid on;
%     title('Value Histogram');
%     
%     hold on
%     histogram(vTargetImage,255);
%     hold off
    
    HistDistM.HI_Hue(i) = HistInter(hSource,hTarget);
    HistDistM.HI_Sat(i) = HistInter(sSource,sTarget);
    HistDistM.HI_Val(i) = HistInter(vSource,vTarget);

end

end

