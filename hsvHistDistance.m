function [HistDistM] = HistDistMacenko(P, TargetImage, n, verbose)

HistDistM = array2table(zeros(1,3),'VariableNames',{'HI_Hue','HI_Sat','HI_Val'});


for i = 1:n
    
    hsvImage = rgb2hsv(P(i).Image_Norm_Macenko);
    hImage = hsvImage(:, :, 1);
    sImage = hsvImage(:, :, 2);
    vImage = hsvImage(:, :, 3);
    
    hsvTargetImage = rgb2hsv(TargetImage);
    hTargetImage = hsvTargetImage(:, :, 1);
    sTargetImage = hsvTargetImage(:, :, 2);
    vTargetImage = hsvTargetImage(:, :, 3);
    
    if verbose == 1
        visibility = 'on';
    else
        visibility = 'off';
    end
    
    figure('visible',visibility);
    subplot(1,3,1);
    [hSource] = histcounts(hImage,255);
    histogram(hImage,255);
    grid on;
    title('Hue Histogram');
    
    hold on
    [hTarget] = histcounts(hTargetImage,255);
    histogram(hTargetImage,255);
    hold off
    
    subplot(1,3,2);
    [sSource] = histcounts(sImage,255);
    histogram(sImage,255);
    grid on;
    title('Saturation Histogram');
    
    hold on
    [sTarget] = histcounts(sTargetImage,255);
    histogram(sTargetImage,255);
    hold off
    
    subplot(1,3,3);
    [vSource] = histcounts(vImage,255);
    histogram(vImage,255);
    grid on;
    title('Value Histogram');
    
    hold on
    [vTarget] = histcounts(vTargetImage,255);
    histogram(vTargetImage,255);
    hold off
    
    HistDistM.HI_Hue(i) = HistInter(hSource,hTarget);
    HistDistM.HI_Sat(i) = HistInter(sSource,sTarget);
    HistDistM.HI_Val(i) = HistInter(vSource,vTarget);


end

GTscroll;

end

