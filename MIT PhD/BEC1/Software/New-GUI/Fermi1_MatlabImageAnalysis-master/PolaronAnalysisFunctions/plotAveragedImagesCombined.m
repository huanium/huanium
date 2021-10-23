function plotAveragedImagesCombined(freq,params,Na_analysis,fullBoxWidth,boxHeight,BECoffsetX,BECoffsetY,analysisBox)
    imageIdx = find(params==freq);
    if(isempty(imageIdx))
        display(['no images with freqency ' num2str(freq)])
    else
       % imageIdx = imageIdx(1);
    moveFilesForAnalysis;
    Species = 'K1'; 
    meas1 = Measurement(Species,'imageStartKeyword',Species,'sortFilesBy','name','plotImage','original','NormOff' ,false,'NormType','Box');
    meas1.settings.normBox = Na_analysis.settings.normBox;
    meas1.settings.marqueeBox = [round(Na_analysis.analysis.fittedGaussianAbsolutePositionX(imageIdx(1))-fullBoxWidth/2-BECoffsetX),...
                                           round(Na_analysis.analysis.fittedGaussianAbsolutePositionY(imageIdx(1))-boxHeight/2-BECoffsetY),...
                                           fullBoxWidth,boxHeight];
    meas1.settings.GaussianFilterWidth = 2;
    meas1.settings.AbbeRadius = 1;
    meas1.loadAndAverageSPEImages(freq,imageIdx);
    Species = 'K2'; 
    meas2 = Measurement(Species,'imageStartKeyword',Species,'sortFilesBy','name','plotImage','original','NormOff' ,false,'NormType','Box');
    meas2.settings.normBox = Na_analysis.settings.normBox;
    meas2.settings.marqueeBox = [round(Na_analysis.analysis.fittedGaussianAbsolutePositionX(imageIdx(1))-fullBoxWidth/2-BECoffsetX),...
                                           round(Na_analysis.analysis.fittedGaussianAbsolutePositionY(imageIdx(1))-boxHeight/2-BECoffsetY),...
                                           fullBoxWidth,boxHeight];
    meas2.settings.GaussianFilterWidth = 2;
    meas2.settings.AbbeRadius = 1;
    meas2.loadAndAverageSPEImages(freq,imageIdx);
    Species = 'Na'; 
    meas3 = Measurement(Species,'imageStartKeyword',Species,'sortFilesBy','name','plotImage','original','NormOff' ,false,'NormType','Box');
    meas3.settings.normBox = Na_analysis.settings.normBox;
    meas3.settings.marqueeBox = [round(Na_analysis.analysis.fittedGaussianAbsolutePositionX(imageIdx(1))-fullBoxWidth/2),...
                                           round(Na_analysis.analysis.fittedGaussianAbsolutePositionY(imageIdx(1))-boxHeight/2),...
                                           fullBoxWidth,boxHeight];
    meas3.settings.GaussianFilterWidth = 2;
    meas3.settings.AbbeRadius = 1;
    meas3.loadAndAverageSPEImages(freq,imageIdx);
    %%
    centerX = meas3.settings.marqueeBox(3)/2;
    centerY = meas3.settings.marqueeBox(4)/2;
    lowOD = -0.1;
    highOD = 1.5;
    
    
    figure(1),clf;
    subplot(3,1,1);
    imagesc(squeeze(meas1.images.ODImages(1,:,:)));
    colormap(flipud(bone));
    caxis([lowOD,highOD]);
    
    axis equal
    hold on
    for idx = 1:analysisBox.numBoxes
        if idx == 1
            rectangle('Position',[centerX-analysisBox.boxWidth/2,centerY-analysisBox.boxHeight/2,analysisBox.boxWidth,analysisBox.boxHeight],'LineWidth',1,'LineStyle','-','EdgeColor','r');
        else
            rectangle('Position',[centerX+(idx-1)*analysisBox.boxWidth/2,centerY-analysisBox.boxHeight/2,analysisBox.boxWidth/2,analysisBox.boxHeight],'LineWidth',1,'LineStyle','-','EdgeColor','r');
            rectangle('Position',[centerX-analysisBox.boxWidth/2-(idx-1)*analysisBox.boxWidth/2,centerY-analysisBox.boxHeight/2,analysisBox.boxWidth/2,analysisBox.boxHeight],'LineWidth',1,'LineStyle','-','EdgeColor','r');
        end
    end
    hold off
    colorbar
    subplot(3,1,2);
    imagesc(squeeze(meas2.images.ODImages(1,:,:)));
    colormap(flipud(bone));
    caxis([lowOD,highOD]);
    
    axis equal
    hold on
    for idx = 1:analysisBox.numBoxes
        if idx == 1
            rectangle('Position',[centerX-analysisBox.boxWidth/2,centerY-analysisBox.boxHeight/2,analysisBox.boxWidth,analysisBox.boxHeight],'LineWidth',1,'LineStyle','-','EdgeColor','r');
        else
            rectangle('Position',[centerX+(idx-1)*analysisBox.boxWidth/2,centerY-analysisBox.boxHeight/2,analysisBox.boxWidth/2,analysisBox.boxHeight],'LineWidth',1,'LineStyle','-','EdgeColor','r');
            rectangle('Position',[centerX-analysisBox.boxWidth/2-(idx-1)*analysisBox.boxWidth/2,centerY-analysisBox.boxHeight/2,analysisBox.boxWidth/2,analysisBox.boxHeight],'LineWidth',1,'LineStyle','-','EdgeColor','r');
        end
    end
    hold off
    colorbar
    subplot(3,1,3);
    imagesc(squeeze(meas3.images.ODImages(1,:,:)));
    colormap(flipud(bone));
    caxis([lowOD,highOD]);
    
    axis equal
    hold on
    for idx = 1:analysisBox.numBoxes
        if idx == 1
            rectangle('Position',[centerX-analysisBox.boxWidth/2,centerY-analysisBox.boxHeight/2,analysisBox.boxWidth,analysisBox.boxHeight],'LineWidth',1,'LineStyle','-','EdgeColor','r');
        else
            rectangle('Position',[centerX+(idx-1)*analysisBox.boxWidth/2,centerY-analysisBox.boxHeight/2,analysisBox.boxWidth/2,analysisBox.boxHeight],'LineWidth',1,'LineStyle','-','EdgeColor','r');
            rectangle('Position',[centerX-analysisBox.boxWidth/2-(idx-1)*analysisBox.boxWidth/2,centerY-analysisBox.boxHeight/2,analysisBox.boxWidth/2,analysisBox.boxHeight],'LineWidth',1,'LineStyle','-','EdgeColor','r');
        end
    end
    hold off
    colorbar
    end
end