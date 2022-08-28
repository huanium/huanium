function plotAveragedImagesCombined2D(freq,params,Na_analysis,fullBoxWidth,boxHeight,BECoffsetX,BECoffsetY,boxWidths,boxHeigths,varargin)
    p = inputParser;
    p.addParameter('badShotImageNames',{});
    p.parse(varargin{:});
    badShotImageNames = p.Results.badShotImageNames;
    imageIdx = find(params==freq);
    if(isempty(imageIdx))
        error(['no images with freqency ' num2str(freq)])
    else
        imageIdx = imageIdx;

        moveFilesForAnalysis;
        RefPosIdx = find(Na_analysis.parameters==freq);
        if(length(RefPosIdx) ~= length(imageIdx))
            fprintf('there are %i reference positions for %i images \n',length(RefPosIdx),length(imageIdx))
        end
        
        ReferencePos(:,1) = Na_analysis.analysis.fittedGaussianAbsolutePositionX(RefPosIdx);
        ReferencePos(:,2) = Na_analysis.analysis.fittedGaussianAbsolutePositionY(RefPosIdx);

        Species = 'K1'; 
        meas1 = Measurement(Species,'imageStartKeyword',Species,'sortFilesBy','name','plotImage','original','NormOff' ,false,'NormType','Box');
        meas1.settings.diffToDarkThreshold = 10;
        meas1.settings.normBox = Na_analysis.settings.normBox;
        meas1.settings.marqueeBox = [round(ReferencePos(1,1)-fullBoxWidth/2-BECoffsetX),...
                                     round(ReferencePos(1,2)-boxHeight/2-BECoffsetY),...
                                     fullBoxWidth,boxHeight];
        meas1.settings.diffToDarkThreshold = 5;
        meas1.loadAndAverageSPEImages(freq,imageIdx,ReferencePos,'badShotImageNames',badShotImageNames);
        
        Species = 'K2'; 
        meas2 = Measurement(Species,'imageStartKeyword',Species,'sortFilesBy','name','plotImage','original','NormOff' ,false,'NormType','Box');
        meas2.settings.diffToDarkThreshold = 10;
        meas2.settings.normBox = Na_analysis.settings.normBox;
        meas2.settings.marqueeBox = [round(ReferencePos(1,1)-fullBoxWidth/2-BECoffsetX),...
                                     round(ReferencePos(1,2)-boxHeight/2-BECoffsetY),...
                                     fullBoxWidth,boxHeight];
        meas2.loadAndAverageSPEImages(freq,imageIdx,ReferencePos,'badShotImageNames',badShotImageNames);
        
        Species = 'Na'; 
        meas3 = Measurement(Species,'imageStartKeyword',Species,'sortFilesBy','name','plotImage','original','NormOff' ,false,'NormType','Box');
        meas3.settings.diffToDarkThreshold = 10;
        meas3.settings.normBox = Na_analysis.settings.normBox;
        meas3.settings.marqueeBox = [round(ReferencePos(1,1)-fullBoxWidth/2),...
                                     round(ReferencePos(1,2)-boxHeight/2),...
                                     fullBoxWidth,boxHeight];
        meas3.loadAndAverageSPEImages(freq,imageIdx,ReferencePos,'badShotImageNames',badShotImageNames);
        %%
        centerX = meas3.settings.marqueeBox(3)/2;
        centerY = meas3.settings.marqueeBox(4)/2;
        lowOD = -0.01;
        highOD = 0.45;
        MarqueeBoxes = createMarqueeBoxes(centerX,centerY,boxWidths,boxHeigths);

        figure(1),clf;
        subplot(3,1,1);
        imagesc(squeeze(meas1.images.ODImages(1,:,:)));
        colormap(flipud(bone));
        caxis([lowOD,highOD]);
        axis equal
        hold on
        for jdx = 1:length(MarqueeBoxes)
            rectangle('Position',MarqueeBoxes(jdx,:),'EdgeColor','r')
        end

        hold off
        colorbar
        
        subplot(3,1,2);
        imagesc(squeeze(meas2.images.ODImages(1,:,:)));
        colormap(flipud(bone));
        caxis([lowOD,highOD]);
        axis equal
        hold on
        for jdx = 1:length(MarqueeBoxes)
            rectangle('Position',MarqueeBoxes(jdx,:),'EdgeColor','r')
        end
        hold off
        colorbar
        
        subplot(3,1,3);
        imagesc(squeeze(meas3.images.ODImages(1,:,:)));
        colormap(flipud(bone));
        highOD = 2.5;
        caxis([lowOD,highOD]);
        axis equal
        hold on
        for jdx = 1:length(MarqueeBoxes)
            rectangle('Position',MarqueeBoxes(jdx,:),'EdgeColor','r')
        end
        hold off
        colorbar
        
        figure(2),clf;
        normalization = 0;
        m72 = squeeze(meas1.images.ODImages(1,:,:));
        m92 = squeeze(meas2.images.ODImages(1,:,:));
        Transfer = ((m72-normalization).*m92)./(m92/1.33+0.62*m72);
        imagesc(Transfer);
        colormap(flipud(bone));
        caxis([-0.1,0.6]);
        axis equal
        hold on
        for jdx = 1:length(MarqueeBoxes)
            rectangle('Position',MarqueeBoxes(jdx,:),'EdgeColor','r')
        end
        hold off
        colorbar
    end
end