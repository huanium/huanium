function [xTFmean,xTFstd,xTFpix] = generateBECvarianceZCam(Na_analysis)
    xTFpixRaw=Na_analysis.analysis.fitBimodalExcludeCenter.xparam(:,2);
    figure(789); clf;
    subplot(3,1,1);

    %check if BEC really grows or shrinks as function of time
    linfit=polyfit(1:length(xTFpixRaw),xTFpixRaw',1);
    hold on;

    plot(xTFpixRaw,'g.','MarkerSize',20);
    plot(1:length(xTFpixRaw), linfit(2)+linfit(1)*(1:length(xTFpixRaw)),'b-');
    ylabel('x TF radius pixel');xlabel('shot #');
    legend(strcat('Slope = ', num2str(linfit(1))));

    %remove outliers outside 95%
    Clevel=.95;
    xTFpixSort=sort(xTFpixRaw);
    highIdx=ceil(length(xTFpixSort)*(.5+Clevel/2));
    lowIdx=floor(length(xTFpixSort)*(.5-Clevel/2));

    xTFpix=xTFpixSort(lowIdx:highIdx);
    xTFmean=mean(xTFpix)*2.5;%micron
    xTFstd=std(xTFpix)*2.5; %micron


    subplot(3,1,2);
    plot(xTFpix,'b.','MarkerSize',20);
    ylabel('x TF radius pix');legend('95% CI, sorted by size');
    subplot(3,1,3);
    hist(xTFpix);
    hold on;plot([mean(xTFpix) mean(xTFpix)], [0 20],'r-');
    plot([mean(xTFpix)-std(xTFpix) mean(xTFpix)-std(xTFpix)], [0 20],'r-');
    plot([mean(xTFpix)+std(xTFpix) mean(xTFpix)+std(xTFpix)], [0 20],'r-');
    ylabel('N occurences'); xlabel('xTF radius pixel');
    title('Distribution, mean, mean+/- std');

    shg;
end

