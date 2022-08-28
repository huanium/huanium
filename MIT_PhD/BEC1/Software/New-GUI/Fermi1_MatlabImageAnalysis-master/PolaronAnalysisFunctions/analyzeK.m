function K_Densities = analyzeK(params,KSpecies,Na_analysis,numBoxes,BECoffsetX,BECoffsetY,fullBoxWidth,boxHeight)
    
    files= dir([KSpecies '*spe']);
    
    if(length(files)<length(params))
        error(['Error: there are less images (' num2str(length(files)) ') than parameters (' num2str(length(params)) ')'])
    elseif(length(files)>length(params))
        warning(['Warning: there are more images (' num2str(length(files)) ') than parameters (' num2str(length(params)) ') press any key to continue'])
        waitforbuttonpress;
    end


    measK = Measurement(KSpecies,'imageStartKeyword',KSpecies,'sortFilesBy','name','plotImage','original','NormOff' ,false,'NormType','Box');

    measK.settings.GaussianFilterWidth = 2;
    measK.settings.AbbeRadius = 1;


    KcountVsDensity = [];

    for idx = 1:length(params)
        boxWidth = fullBoxWidth;
        trueIdx = idx - length(measK.badShots);
        if(idx == length(params))
            if(trueIdx>length(Na_analysis.parameters))
                trueIdx = length(Na_analysis.parameters);
            end
        end
        measK.settings.marqueeBox = [round(Na_analysis.analysis.fitBimodalExcludeCenter.xparam(trueIdx,3)+Na_analysis.settings.marqueeBox(1)-boxWidth/2-BECoffsetX),...
                                       round(Na_analysis.analysis.fitBimodalExcludeCenter.yparam(trueIdx,3)+Na_analysis.settings.marqueeBox(2)-boxHeight/2-BECoffsetY),...
                                       boxWidth,boxHeight];
        measK.loadNewestSPEImage(params(idx));
        trueIdx = idx - length(measK.badShots);
        measK.createODimage(trueIdx);
        measK.bareNcnt(trueIdx);
        
        if(measK.parameters(trueIdx) ~= Na_analysis.parameters(trueIdx)) 
            warning('Analysis out of sync! press any button to continue')
            waitforbuttonpress;
        end
        
        
        figure(2311),
        imagesc(squeeze(measK.images.absorptionImages(trueIdx,:,:)))
        caxis([0,1.3]);
        hold on
        xpos = Na_analysis.analysis.fitBimodalExcludeCenter.xparam(trueIdx,3)+Na_analysis.settings.marqueeBox(1)-BECoffsetX;
        ypos = Na_analysis.analysis.fitBimodalExcludeCenter.yparam(trueIdx,3)+Na_analysis.settings.marqueeBox(2)-BECoffsetY;
        plot(xpos,ypos,'r.','MarkerSize',20)
        plot([xpos,xpos],[1,length(measK.images.absorptionImages(trueIdx,:,1))],'r','LineWidth',1)
        plot([1,length(measK.images.absorptionImages(trueIdx,1,:))],[ypos,ypos],'r','LineWidth',1)
        title('BEC box tracking sanity check' )
        hold off
        axis equal
        colormap(bone);
        drawnow
        
        
        

        measK.images.ODImages = [];
        measK.images.ODImagesAveraged = [];
        measK.images.ODImagesFiltered = [];
        KcountVsDensity(1,trueIdx) = measK.analysis.bareNcntValues(trueIdx);
        %measK92.plotAbsorptionImage(trueIdx);
        %

        % fit Gaussian to extract size of K cloud
        measK.settings.marqueeBox = Na_analysis.settings.marqueeBox;
        measK.settings.marqueeBox(1) = measK.settings.marqueeBox(1)-BECoffsetX;
        measK.settings.marqueeBox(2) = measK.settings.marqueeBox(2)-BECoffsetY;
        measK.createODimage(trueIdx);
        measK.fitIntegratedGaussian(trueIdx);
        measK.images.ODImages = [];
        measK.images.ODImagesAveraged = [];
        measK.images.ODImagesFiltered = [];

        for jdx = 2:numBoxes
            boxWidth = fullBoxWidth/2;

            measK.settings.marqueeBox = [round(Na_analysis.analysis.fitBimodalExcludeCenter.xparam(trueIdx,3)+Na_analysis.settings.marqueeBox(1)-BECoffsetX+(jdx-1)*boxWidth),...
                                       round(Na_analysis.analysis.fitBimodalExcludeCenter.yparam(trueIdx,3)+Na_analysis.settings.marqueeBox(2)-boxHeight/2-BECoffsetY),...
                                       boxWidth,boxHeight];

            measK.createODimage(trueIdx);
            measK.bareNcnt(trueIdx);
            KcountVsDensity(jdx,trueIdx) = measK.analysis.bareNcntValues(trueIdx);

            %measK92.plotAbsorptionImage(trueIdx);
            %waitforbuttonpress
            measK.settings.marqueeBox = [round(Na_analysis.analysis.fitBimodalExcludeCenter.xparam(trueIdx,3)+Na_analysis.settings.marqueeBox(1)-BECoffsetX-boxWidth/2-(jdx-1)*boxWidth),...
                                       round(Na_analysis.analysis.fitBimodalExcludeCenter.yparam(trueIdx,3)+Na_analysis.settings.marqueeBox(2)-boxHeight/2-BECoffsetY),...
                                       boxWidth,boxHeight];

            measK.createODimage(trueIdx);
            measK.bareNcnt(trueIdx);
            KcountVsDensity(jdx,trueIdx) = KcountVsDensity(jdx,trueIdx) + measK.analysis.bareNcntValues(trueIdx);

            %measK92.plotAbsorptionImage(trueIdx);
            %waitforbuttonpress
            measK.images.ODImages = [];
            measK.images.ODImagesAveraged = [];
            measK.images.ODImagesFiltered = [];
        end


    end
    
    K_Densities = struct;
    K_Densities.parameters = measK.parameters;
    K_Densities.countVsDensity = KcountVsDensity;
    K_Densities.settings = measK.settings;
    K_Densities.analysis = measK.analysis;
    K_Densities.badShots = measK.badShots;


end