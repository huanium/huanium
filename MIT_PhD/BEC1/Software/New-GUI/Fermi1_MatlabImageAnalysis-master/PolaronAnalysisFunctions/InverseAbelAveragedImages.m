function InverseAbelAveragedImages(freq,params,Na_analysis,fullBoxWidth,boxHeight,BECoffsetX,BECoffsetY)
    imageIdx = find(params==freq);
    if(isempty(imageIdx))
        error(['no images with freqency ' num2str(freq)])
    else
        imageIdx = imageIdx;

        moveFilesForAnalysis;
        RefPosIdx = find(Na_analysis.parameters==freq);
        if(length(RefPosIdx) ~= length(imageIdx))
            fprintf('there are %i reference positions for %i images \n',length(RefPosIdx),length(imageIdx))
        else
            ReferencePos(:,1) = Na_analysis.analysis.fitBimodalExcludeCenter.xparam(RefPosIdx,3);
            ReferencePos(:,2) = Na_analysis.analysis.fitBimodalExcludeCenter.yparam(RefPosIdx,3);

            Species = 'K1'; 
            meas1 = Measurement(Species,'imageStartKeyword',Species,'sortFilesBy','name','plotImage','original','NormOff' ,false,'NormType','Box');
            meas1.settings.normBox = Na_analysis.settings.normBox;
            meas1.settings.marqueeBox = [round(ReferencePos(1,1)+Na_analysis.settings.marqueeBox(1)-fullBoxWidth/2-BECoffsetX),...
                                         round(ReferencePos(1,2)+Na_analysis.settings.marqueeBox(2)-boxHeight/2-BECoffsetY),...
                                         fullBoxWidth,boxHeight];
            meas1.loadAndAverageSPEImages(freq,imageIdx,ReferencePos);

            Species = 'K2'; 
            meas2 = Measurement(Species,'imageStartKeyword',Species,'sortFilesBy','name','plotImage','original','NormOff' ,false,'NormType','Box');
            meas2.settings.normBox = Na_analysis.settings.normBox;
            meas2.settings.marqueeBox = [round(ReferencePos(1,1)+Na_analysis.settings.marqueeBox(1)-fullBoxWidth/2-BECoffsetX),...
                                         round(ReferencePos(1,2)+Na_analysis.settings.marqueeBox(2)-boxHeight/2-BECoffsetY),...
                                         fullBoxWidth,boxHeight];
            meas2.loadAndAverageSPEImages(freq,imageIdx,ReferencePos);

            Species = 'Na'; 
            meas3 = Measurement(Species,'imageStartKeyword',Species,'sortFilesBy','name','plotImage','original','NormOff' ,false,'NormType','Box');
            meas3.settings.normBox = Na_analysis.settings.normBox;
            meas3.settings.marqueeBox = [round(ReferencePos(1,1)+Na_analysis.settings.marqueeBox(1)-fullBoxWidth/2),...
                                         round(ReferencePos(1,2)+Na_analysis.settings.marqueeBox(2)-boxHeight/2),...
                                         fullBoxWidth,boxHeight];
            meas3.loadAndAverageSPEImages(freq,imageIdx,ReferencePos);
            %%
            meas3.fitBimodalExcludeCenter('last','BlackedOutODthreshold',1.8);
            
            
            centerX = meas3.settings.marqueeBox(3)/2;
            centerY = meas3.settings.marqueeBox(4)/2;
            lowOD = -0.1;
            highOD = 0.6;
            
            meas1.averageRadiallyElliptical(1,'BECx',meas3.analysis.fitBimodalExcludeCenter.xparam(3),...
                                              'BECTFx',meas3.analysis.fitBimodalExcludeCenter.xparam(2),...
                                              'BECy',meas3.analysis.fitBimodalExcludeCenter.yparam(3),...
                                              'BECTFy',meas3.analysis.fitBimodalExcludeCenter.yparam(2));
            
            meas1.inverseAbel('last');
            waitforbuttonpress;
            
            meas2.averageRadiallyElliptical(1,'BECx',meas3.analysis.fitBimodalExcludeCenter.xparam(3),...
                                              'BECTFx',meas3.analysis.fitBimodalExcludeCenter.xparam(2),...
                                              'BECy',meas3.analysis.fitBimodalExcludeCenter.yparam(3),...
                                              'BECTFy',meas3.analysis.fitBimodalExcludeCenter.yparam(2));
            meas2.inverseAbel('last');

            figure(1),clf;
            subplot(3,1,1);
            imagesc(squeeze(meas1.images.ODImages(1,:,:)));
            colormap(flipud(bone));
            caxis([lowOD,highOD]);
            axis equal

            subplot(3,1,2);
            imagesc(squeeze(meas2.images.ODImages(1,:,:)));
            colormap(flipud(bone));
            caxis([lowOD,highOD]);
            axis equal

            subplot(3,1,3);
            imagesc(squeeze(meas3.images.ODImages(1,:,:)));
            colormap(flipud(bone));
            highOD = 1.8;
            caxis([lowOD,highOD]);
            axis equal


            figure(2),clf;
            normalization = 0;
            m72 = squeeze(meas1.images.ODImages(1,:,:));
            m92 = squeeze(meas2.images.ODImages(1,:,:));
            Transfer = ((m72-normalization).*m92)./(m92/1.33+0.62*m72);
            imagesc(Transfer);
            colormap(flipud(bone));
            caxis([-0.1,0.6]);
            axis equal
        end

    end
end