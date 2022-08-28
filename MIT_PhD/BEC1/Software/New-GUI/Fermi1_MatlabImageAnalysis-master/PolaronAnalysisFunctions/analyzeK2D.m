function K_Densities = analyzeK2D(params,KSpecies,Na_analysis,BECoffsetX,BECoffsetY,boxWidths,boxHeigths,varargin)
    tic
    p = inputParser;
    p.addParameter('diffToDark',40);
    p.parse(varargin{:});
    diffToDark  = p.Results.diffToDark;
    
    files= dir([KSpecies '*spe']);
    
    if(length(files)<length(params))
        error(['Error: there are less images (' num2str(length(files)) ') than parameters (' num2str(length(params)) ')'])
    elseif(length(files)>length(params))
        warning(['Warning: there are more images (' num2str(length(files)) ') than parameters (' num2str(length(params)) ') press any key to continue'])
        waitforbuttonpress;
    end


    measK = Measurement(KSpecies,'imageStartKeyword',KSpecies,'sortFilesBy','name','plotImage','original',...
                        'NormOff' ,false,'NormType','Box','removeBeamIris',false,'plotOD',false,'verbose',false,'storeImages',false);

    measK.settings.GaussianFilterWidth = 2;
    measK.settings.AbbeRadius = 1;
    measK.settings.pixelAveraging = 2;
    measK.settings.diffToDarkThreshold = diffToDark;
    measK.analysis.analysisDurations = [];
    
    KcountVsDensity = [];
    KcountVsDensityAveraged = [];
    
    lastRunTime = toc;
    for idx = 1:length(params)
        trueIdx = idx - length(measK.badShots);
        if(idx == length(params))
            if(trueIdx>length(Na_analysis.parameters))
                trueIdx = length(Na_analysis.parameters);
            end
        end
        %% load image and check if analysis in sync
        centerX = round(Na_analysis.analysis.fittedGaussianAbsolutePositionX(trueIdx)-BECoffsetX);
        centerY = round(Na_analysis.analysis.fittedGaussianAbsolutePositionY(trueIdx)-BECoffsetY);
        
        MarqueeBoxes = createMarqueeBoxes(centerX,centerY,boxWidths,boxHeigths);
        numBoxes = length(MarqueeBoxes(:,1));
        
        measK.settings.marqueeBox = [centerX-100,centerY-20,200,40];
        measK.loadNewestSPEImage(params(idx));
        trueIdx = idx - length(measK.badShots);
        
        if(measK.parameters(trueIdx) ~= Na_analysis.parameters(trueIdx)) 
            warning('Analysis out of sync! press any button to continue')
            waitforbuttonpress;
        end
        
        if(~measK.lastImageBad)
            imageIdx = 1;
            analysisIdx = trueIdx;
            figure(2311),
            imagesc(squeeze(measK.images.absorptionImages(imageIdx,:,:)))
            caxis([0,1.3]);
            hold on
            plot(centerX,centerY,'r.','MarkerSize',20)
            plot([centerX,centerX],[1,length(measK.images.absorptionImages(imageIdx,:,1))],'r','LineWidth',1)
            plot([1,length(measK.images.absorptionImages(imageIdx,1,:))],[centerY,centerY],'r','LineWidth',1)
            for jdx = 1:length(MarqueeBoxes)
                rectangle('Position',MarqueeBoxes(jdx,:),'EdgeColor','r')
            end
            title('BEC box tracking sanity check' )
            hold off
            axis equal
            colormap(bone);
            drawnow

            % fit Gaussian to extract size of K cloud
            measK.fitIntegratedGaussian('last');

            for kdx = 1:numBoxes
                measK.flushAllODImages();

                measK.settings.marqueeBox = MarqueeBoxes(kdx,:);

                measK.createODimage('last');
                measK.bareNcntAverageMarqueeBox();
                KcountVsDensityAveraged(kdx,analysisIdx) = measK.analysis.bareNcntAverageMarqueeBoxValues(analysisIdx);
            end
            measK.flushAllImages();
        end
        % for time optimization only
        currentRunTime = toc;
        lastIterationDuration = currentRunTime-lastRunTime;
        lastRunTime = currentRunTime;
        measK.analysis.analysisDurations(end+1) = lastIterationDuration;        
        figure(233),
        plot(measK.analysis.analysisDurations)
        ylabel('time (s)');
        xlabel('run #');
        drawnow;
    end
    
    K_Densities = struct;
    K_Densities.parameters = measK.parameters;
    K_Densities.KcountVsDensity = KcountVsDensity;
    K_Densities.KcountVsDensityAveraged = KcountVsDensityAveraged;
    K_Densities.settings = measK.settings;
    K_Densities.analysis = measK.analysis;
    K_Densities.badShots = measK.badShots;
    toc
end