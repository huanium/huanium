function [analysis]=generateLineDensityRFTransfer(params,Na_analysis,varargin)
    superSamplingFactor1D = 2;
    useUpsampling = false;


    p = inputParser;
    
    p.addParameter('spectrum','ejection');
    p.addParameter('RabiFreq_kHz',11000);
    p.addParameter('GaussSigma_us',62.5);
    p.addParameter('fullBoxWidth',100);
    p.addParameter('boxHeight',6);
    p.addParameter('BECoffsetX',0);
    p.addParameter('BECoffsetY',0);
    p.addParameter('AtomicRefFreq',530);
    p.addParameter('BEC_TF_fromTOF',26.6);
    p.addParameter('LineDensityFoldCenter',false);
    p.addParameter('LineDensityPixelAveraging',1);
    p.addParameter('NaInsituCI',0.68);
    p.addParameter('KdensityReconLowerCut',-5);
    p.addParameter('KdensityReconUpperCut',125);
    p.addParameter('PolaronMaxPeakesitmate',35);
    p.addParameter('bootstrap',false);
    p.addParameter('plotting',false);
    p.addParameter('offM92parameter',0.13);
    p.addParameter('m92Tom72ImagingConversion',1.53);
    p.addParameter('m92lowerFreq',-200);
    p.addParameter('m92upperFreq',-10);
    p.addParameter('NaLowTFThresholdX',18);
    p.addParameter('NaHighTFThresholdX',30);
    p.addParameter('NaLowAmpThresholdX',0);
    p.addParameter('NaHighAmpThresholdX',5000);
    
    
    p.parse(varargin{:});
    
    Rabi                            = 2*pi*p.Results.RabiFreq_kHz;
    sigma                           = p.Results.GaussSigma_us*1e-6;
    spectrum                        = p.Results.spectrum;
    fullBoxWidth                    = p.Results.fullBoxWidth;
    boxHeight                       = p.Results.boxHeight;
    BECoffsetX                      = p.Results.BECoffsetX;
    BECoffsetY                      = p.Results.BECoffsetY;
    AtomicRefFreq                   = p.Results.AtomicRefFreq;
    BEC_TF_fromTOF                  = p.Results.BEC_TF_fromTOF;
    LineDensityFoldCenter           = p.Results.LineDensityFoldCenter;
    LineDensityPixelAveraging       = p.Results.LineDensityPixelAveraging;
    NaInsituCI                      = p.Results.NaInsituCI;
    KdensityReconLowerCut           = p.Results.KdensityReconLowerCut;
    KdensityReconUpperCut           = p.Results.KdensityReconUpperCut;
    PolaronMaxPeakesitmate          = p.Results.PolaronMaxPeakesitmate;
    bootstrap                       = p.Results.bootstrap;
    plotting                        = p.Results.plotting;
    offM92parameter                 = p.Results.offM92parameter;
    m92Tom72ImagingConversion       = p.Results.m92Tom72ImagingConversion;
    m92lowerFreq                    = p.Results.m92lowerFreq;
    m92upperFreq                    = p.Results.m92upperFreq;
    NaLowTFThresholdX               = p.Results.NaLowTFThresholdX;
    NaHighTFThresholdX              = p.Results.NaHighTFThresholdX;
    NaLowAmpThresholdX              = p.Results.NaLowAmpThresholdX;
    NaHighAmpThresholdX              = p.Results.NaHighAmpThresholdX;
    
    m92parameter = 1.272;
    m72parameter = 0.8699;

    analysis = struct;
        
    
    % take care of bad shots
    analyzedImageIdx = 1:length(Na_analysis.parameters);
    imageIdx = 1:length(params);
    
    files= dir(['Na' '*spe']);
    filenames = {files.name};
    for jdx = 1:length(files)
        numbers = regexp(files(jdx).name,'\d*','Match');
        extendedFilenames{jdx} = [files(jdx).name(1:end-strlength(numbers(end))-4),sprintf('%010d',str2double(numbers{end})),'.spe'];
    end
    [~,sortidx] = sort(extendedFilenames);
    badShotIdx=[];
    for jdx = imageIdx
        for idx = 1:length(Na_analysis.badShots)
            if strcmp(filenames{sortidx(jdx)},Na_analysis.badShots{idx})
                badShotIdx(end+1) = jdx;
            end
        end
    end
    imageWithBadShots = imageIdx;
    imageWithBadShots(badShotIdx) = NaN;

    trueAnalyzedImageIdx = [];
    for idx = imageIdx
        if ~isnan(imageWithBadShots(idx))
            trueAnalyzedImageIdx(end+1) = idx;
        end
    end

    
    if ~bootstrap
        uniqueFreq = unique(Na_analysis.parameters);
    else
        [~,bootIdx] = datasample(analyzedImageIdx,length(analyzedImageIdx));
        uniqueFreq = unique(Na_analysis.parameters(bootIdx));
    end
    
    %mask = uniqueFreq>0;
    %uniqueFreq = uniqueFreq(mask);
    
    RFTransferFun = @(m72,m92) (m72-offM92parameter*m92)./(m92/m92parameter+m72parameter*m72);
    
    
    if(LineDensityFoldCenter == true)
        effectiveBoxWidth = round(fullBoxWidth/2);
    else
        effectiveBoxWidth = fullBoxWidth;
    end
    if(useUpsampling == true)
        effectiveBoxWidth = superSamplingFactor1D*effectiveBoxWidth;
    end
    effectiveBoxWidth = floor(effectiveBoxWidth/LineDensityPixelAveraging);
    
    m72LineDensitiesMatrix = zeros(length(uniqueFreq),effectiveBoxWidth);
    m92LineDensitiesMatrix = zeros(length(uniqueFreq),effectiveBoxWidth);
    KTransferMatrix = zeros(length(uniqueFreq),effectiveBoxWidth);
    FreqIntegratedMatrix = zeros(length(uniqueFreq),effectiveBoxWidth);
    AreaKShotToShot = zeros(length(uniqueFreq),1);
    
    if(LineDensityFoldCenter == true)
        x = (1:effectiveBoxWidth)-0.5;
    else
        x = -(effectiveBoxWidth/2-.5):(effectiveBoxWidth/2-.5);
    end
    y = uniqueFreq-AtomicRefFreq;
    [Xmesh,Ymesh] = meshgrid(x,y);
    
    
    measM72 = Measurement('K1','imageStartKeyword','K1 m7','sortFilesBy','name','plotImage','original','NormType','Shell');
    measM72.settings.normBoxOffset = 10;
    %measM72.settings.normBox = Na_analysis.settings.normBox;
    measM72.settings.LineDensityFoldCenter = LineDensityFoldCenter;
    measM72.settings.LineDensityPixelAveraging = LineDensityPixelAveraging;
    measM72.settings.fudgeWidth = 5;
    measM72.settings.fudgeFilterFreq = 7;
    measM72.settings.superSamplingFactor1D = superSamplingFactor1D;
    measM72.settings.diffToDarkThreshold = -2;
        
    measM92 = Measurement('K2','imageStartKeyword','K2 m9','sortFilesBy','name','plotImage','original','NormType','Shell');
    measM92.settings.normBoxOffset = 10;
    measM92.settings.normBox = measM72.settings.normBox;
    measM92.settings.LineDensityFoldCenter = LineDensityFoldCenter;
    measM92.settings.LineDensityPixelAveraging = LineDensityPixelAveraging;
    measM92.settings.fudgeWidth = 5;
    measM92.settings.fudgeFilterFreq = 7;
    measM92.settings.superSamplingFactor1D = superSamplingFactor1D;
    measM92.settings.diffToDarkThreshold = -2;
    
    
    for idx = 1:length(uniqueFreq)
        freq = uniqueFreq(idx);
        fprintf(['--------- analyzing freq = ' num2str(freq-AtomicRefFreq) ' ----------\n'])
        if ~bootstrap
            imageIdx = trueAnalyzedImageIdx(find(Na_analysis.parameters==freq));
            RefPosIdx = find(Na_analysis.parameters==freq);
            if(length(RefPosIdx) ~= length(imageIdx))
                fprintf('there are %i reference positions for %i images \n',length(RefPosIdx),length(imageIdx))
            end
        else
            imageIdx = trueAnalyzedImageIdx(bootIdx(find(Na_analysis.parameters(bootIdx)==freq)));
            RefPosIdx = bootIdx(find(Na_analysis.parameters((bootIdx))==freq));
            if(length(RefPosIdx) ~= length(imageIdx))
                fprintf('there are %i reference positions for %i images \n',length(RefPosIdx),length(imageIdx))
            end
        end
        
        if(isempty(imageIdx))
            error(['no images with freqency ' num2str(freq)])
        else
            moveFilesForAnalysis;
            
            ReferencePos = [];
            ReferencePos(:,1) = Na_analysis.analysis.fittedGaussianAbsolutePositionX(RefPosIdx);
            ReferencePos(:,2) = Na_analysis.analysis.fittedGaussianAbsolutePositionY(RefPosIdx);
            
            binaryMask1 = or(NaLowTFThresholdX<Na_analysis.analysis.fitBimodalExcludeCenter.xparam(RefPosIdx,2),...
                             Na_analysis.analysis.fitBimodalExcludeCenter.xparam(RefPosIdx,2)>NaHighTFThresholdX);
            binaryMask2 = or(NaLowAmpThresholdX<Na_analysis.analysis.bareNcntAverageMarqueeBoxValues,...
                             Na_analysis.analysis.bareNcntAverageMarqueeBoxValues>NaHighAmpThresholdX);
            binaryMask = or(binaryMask1,binaryMask2);
            
            
            measM72.settings.marqueeBox = [round(ReferencePos(1,1)-fullBoxWidth/2-BECoffsetX),...
                                         round(ReferencePos(1,2)-boxHeight/2-BECoffsetY),...
                                         fullBoxWidth,boxHeight];
            measM72.loadAndAverageSPEImages(freq,imageIdx,ReferencePos,'badShotImageNames',Na_analysis.badShots,...
                                            'binaryImageSelection',binaryMask);

            
            measM92.settings.marqueeBox = [round(ReferencePos(1,1)-fullBoxWidth/2-BECoffsetX),...
                                         round(ReferencePos(1,2)-boxHeight/2-BECoffsetY),...
                                         fullBoxWidth,boxHeight];
            measM92.loadAndAverageSPEImages(freq,imageIdx,ReferencePos,'badShotImageNames',Na_analysis.badShots,...
                                            'binaryImageSelection',binaryMask);
                                        
            measM92.fitIntegratedGaussian('last','fitY',false);
                                        
            if(useUpsampling == true)
                m72LineDensitiesMatrix(idx,:)   = measM72.lineDensities.YintegratedUpsampled(idx,:);
                m92LineDensitiesMatrix(idx,:)   = measM92.lineDensities.YintegratedUpsampled(idx,:);
                KTransferMatrix(idx,:)          = RFTransferFun(measM72.lineDensities.YintegratedUpsampled(idx,:),measM92.lineDensities.YintegratedUpsampled(idx,:));
            
            else
                try
                    m72LineDensitiesMatrix(idx,:)   = measM72.lineDensities.Yintegrated(idx,:);
                    m92LineDensitiesMatrix(idx,:)   = measM92.lineDensities.Yintegrated(idx,:);
                    KTransferMatrix(idx,:)          = RFTransferFun(measM72.lineDensities.Yintegrated(idx,:),measM92.lineDensities.Yintegrated(idx,:));
                catch
                   display('could not create line densities, something is seriously wrong') 
                end
            end
            
            
            
            %stolen from Zoe
            mask = and(y>KdensityReconLowerCut,y<KdensityReconUpperCut);
            freqIntegrated = trapz(y(mask),m72LineDensitiesMatrix(mask,:),1); %integrate over frequency
            FreqIntegratedMatrix(idx,:) = freqIntegrated./(KdensityReconUpperCut-KdensityReconLowerCut);
            
            KtotalPerPixel              = (m92LineDensitiesMatrix(idx,:)/m92parameter+m72parameter*m72LineDensitiesMatrix(idx,:));
            AreaKShotToShot(idx)        = trapz(KtotalPerPixel);
            AreaKFreqInt                = trapz(freqIntegrated);
            ShotToShotAreaNorm          = AreaKShotToShot/AreaKFreqInt;
            NormMatrix                  = ShotToShotAreaNorm*freqIntegrated;
            
            epsilon = 0.01;
            FancyKTransferMatrix        = (m72LineDensitiesMatrix-offM92parameter*m92LineDensitiesMatrix)./(NormMatrix+epsilon);
            
            load('cmap.mat')
            
            if plotting
                figure(915),clf
                s = surf(Ymesh',Xmesh',KTransferMatrix');
                s.EdgeColor = 'none';
                caxis([-0.05,0.7])
                view(2);
                colormap(cmap)
                hold on
                l = plot([y(1),y(end)],[BEC_TF_fromTOF,BEC_TF_fromTOF]./LineDensityPixelAveraging,'w--','LineWidth',1.5);
                set(l,'ZData',[1,1]);  
                l = plot([y(1),y(end)],[-BEC_TF_fromTOF,-BEC_TF_fromTOF]./LineDensityPixelAveraging,'w--','LineWidth',1.5);
                set(l,'ZData',[1,1]);  
                hold off
                xlabel('\nu (kHz)')
                ylabel('position (px)' )
                title( 'Transfered fraction' );
                ylim([x(1),x(end)])
                xlim([min(uniqueFreq)-AtomicRefFreq,max(uniqueFreq)-AtomicRefFreq])
                colorbar
                set(gca,'FontSize', 14);
                set(gca, 'FontName', 'Arial')
                pos = get(gcf,'Position');
                set(gcf,'Position',[pos(1),pos(2),768, 420]);

                figure(916),clf
                s = surf(Ymesh',Xmesh',m72LineDensitiesMatrix');
                s.EdgeColor = 'none';
                caxis([0.0,0.3])
                view(2);
                colormap(cmap)
                hold on
                l = plot([y(1),y(end)],[BEC_TF_fromTOF,BEC_TF_fromTOF]./LineDensityPixelAveraging,'w--','LineWidth',1.5);
                set(l,'ZData',[1,1]);  
                l = plot([y(1),y(end)],[-BEC_TF_fromTOF,-BEC_TF_fromTOF]./LineDensityPixelAveraging,'w--','LineWidth',1.5);
                set(l,'ZData',[1,1]);  
                hold off
                xlabel('\nu (kHz)')
                ylabel('position (px)' )
                title( 'F=9/2 m_F = -7/2');
                ylim([x(1),x(end)])
                xlim([min(uniqueFreq)-AtomicRefFreq,max(uniqueFreq)-AtomicRefFreq])
                colorbar
                set(gca,'FontSize', 14);
                set(gca, 'FontName', 'Arial')
                pos = get(gcf,'Position');
                set(gcf,'Position',[pos(1),pos(2),768, 420]);

                figure(917),clf
                s = surf(Ymesh',Xmesh',m92LineDensitiesMatrix');
                s.EdgeColor = 'none';
                caxis([0.0,0.6])
                view(2);
                colormap(cmap)
                xlabel('\nu (kHz)')
                ylabel('position (px)' )
                title( 'F=9/2 m_F = -9/2');
                ylim([x(1),x(end)])
                xlim([min(uniqueFreq)-AtomicRefFreq,max(uniqueFreq)-AtomicRefFreq])
                colorbar
                set(gca,'FontSize', 14);
                set(gca, 'FontName', 'Arial')
                pos = get(gcf,'Position');
                set(gcf,'Position',[pos(1),pos(2),768, 420]);

                figure(918),clf
                s = surf(Ymesh',Xmesh',(m92LineDensitiesMatrix'/m92parameter+m72parameter*m72LineDensitiesMatrix'));
                s.EdgeColor = 'none';
                caxis([0.0,0.7])
                view(2);
                colormap(cmap)
                xlabel('\nu (kHz)')
                ylabel('position (px)' )
                title( '|0> + |1>');
                ylim([x(1),x(end)])
                xlim([min(uniqueFreq)-AtomicRefFreq,max(uniqueFreq)-AtomicRefFreq])
                colorbar
                set(gca,'FontSize', 14);
                set(gca, 'FontName', 'Arial')
                pos = get(gcf,'Position');
                set(gcf,'Position',[pos(1),pos(2),768, 420]);


                figure(919),clf
                plot(x,freqIntegrated,'LineWidth',2);
                set(gca,'FontSize', 14);
                set(gca, 'FontName', 'Arial')
                pos = get(gcf,'Position');
                set(gcf,'Position',[pos(1),pos(2),768, 420]);
                title('K density from freq integration')
                xlabel('position (px)')

                figure(920),clf
                s = surf(Ymesh',Xmesh',FreqIntegratedMatrix');
                s.EdgeColor = 'none';
                %caxis([0.0,25])
                view(2);
                colormap(cmap)
                xlabel('\nu (kHz)')
                ylabel('position (px)' )
                title( 'K Freq Integrated Density');
                ylim([x(1),x(end)])
                xlim([min(uniqueFreq)-AtomicRefFreq,max(uniqueFreq)-AtomicRefFreq])
                colorbar
                set(gca,'FontSize', 14);
                set(gca, 'FontName', 'Arial')
                pos = get(gcf,'Position');
                set(gcf,'Position',[pos(1),pos(2),768, 420]);

                figure(924),clf
                s = surf(Ymesh',Xmesh',FancyKTransferMatrix');
                s.EdgeColor = 'none';
                caxis([0.0,0.7])
                view(2);
                colormap(cmap)
                hold on
                l = plot([y(1),y(end)],[BEC_TF_fromTOF,BEC_TF_fromTOF]./LineDensityPixelAveraging,'w--','LineWidth',1.5);
                set(l,'ZData',[1,1]);  
                l = plot([y(1),y(end)],[-BEC_TF_fromTOF,-BEC_TF_fromTOF]./LineDensityPixelAveraging,'w--','LineWidth',1.5);
                set(l,'ZData',[1,1]);  
                hold off
                xlabel('\nu (kHz)')
                ylabel('position (px)' )
                title( 'Transfer');
                ylim([x(1),x(end)])
                xlim([min(uniqueFreq)-AtomicRefFreq,max(uniqueFreq)-AtomicRefFreq])
                colorbar
                set(gca,'FontSize', 14);
                set(gca, 'FontName', 'Arial')
                pos = get(gcf,'Position');
                set(gcf,'Position',[pos(1),pos(2),768, 420]);
            end
        end
    end
    analysis.m72Images              = measM72.images.ODImages;
    analysis.m92Images              = measM92.images.ODImages;
    
    
    
    
    if(strcmp(spectrum,'ejection'))
        transferImageSimple = @(m72,m92) ((m72-offM92parameter*m92));
        mask = and(uniqueFreq-AtomicRefFreq>-70,uniqueFreq-AtomicRefFreq<-10);

        freqIntegratedBelowAtomicLineDensity = squeeze(mean(transferImageSimple(m72LineDensitiesMatrix(mask,:),m92LineDensitiesMatrix(mask,:)),1)); %integrate over frequency
        filteredFreqIntegratedBelowAtomicLineDensity = sgolayfilt([0,0,0,0,0,0,0,0,0,0,sum(freqIntegratedBelowAtomicLineDensity,1),0,0,0,0,0,0,0,0,0,0],2,11);
        filteredFreqIntegratedBelowAtomicLineDensity = filteredFreqIntegratedBelowAtomicLineDensity(11:end-10);
        
        meanTotal = trapz(squeeze(mean(m92LineDensitiesMatrix(:,:)/m92parameter+m72parameter*m72LineDensitiesMatrix(:,:),1)));
        normMatrix = [];
        shotToShotVector= [];
        for idx = 1:length(uniqueFreq)
            normMatrix(idx,:) = trapz(m92LineDensitiesMatrix(idx,:)/m92parameter+m72parameter*m72LineDensitiesMatrix(idx,:))/meanTotal.*filteredFreqIntegratedBelowAtomicLineDensity;
            shotToShotVector(idx) = trapz(m92LineDensitiesMatrix(idx,:)/m92parameter+m72parameter*m72LineDensitiesMatrix(idx,:))/meanTotal;
        end
        %create line density from 9/2 images below atomic (1ms later)
        mask = and(uniqueFreq-AtomicRefFreq>m92lowerFreq,uniqueFreq-AtomicRefFreq<m92upperFreq);
        %m92BasedKLinedensity = (squeeze(mean(m92LineDensitiesMatrix(mask,:).*shotToShotVector(mask)',1))); %integrate over frequency
        m92BasedKLinedensity = (squeeze(mean(m92LineDensitiesMatrix(mask,:),1))); %integrate over frequency
    else
        transferImageSimple = @(m72,m92) ((m72-offM92parameter*m92));
        mask = and(uniqueFreq-AtomicRefFreq>45,uniqueFreq-AtomicRefFreq<200);

        freqIntegratedBelowAtomicLineDensity = squeeze(mean(transferImageSimple(m72LineDensitiesMatrix(mask,:),m92LineDensitiesMatrix(mask,:)),1)); %integrate over frequency
        filteredFreqIntegratedBelowAtomicLineDensity = sgolayfilt([0,0,0,0,0,0,0,0,0,0,sum(freqIntegratedBelowAtomicLineDensity,1),0,0,0,0,0,0,0,0,0,0],2,11);
        filteredFreqIntegratedBelowAtomicLineDensity = filteredFreqIntegratedBelowAtomicLineDensity(11:end-10);
        
        meanTotal = trapz(squeeze(mean(m92LineDensitiesMatrix(:,:)/m92parameter+m72parameter*m72LineDensitiesMatrix(:,:),1)));
        normMatrix = [];
        shotToShotVector= [];
        for idx = 1:length(uniqueFreq)
            normMatrix(idx,:) = trapz(m92LineDensitiesMatrix(idx,:)/m92parameter+m72parameter*m72LineDensitiesMatrix(idx,:))/meanTotal.*filteredFreqIntegratedBelowAtomicLineDensity;
            shotToShotVector(idx) = trapz(m92LineDensitiesMatrix(idx,:)/m92parameter+m72parameter*m72LineDensitiesMatrix(idx,:))/meanTotal;
        end
        %create line density from 9/2 images below atomic (1ms later)
        mask = and(uniqueFreq-AtomicRefFreq>m92lowerFreq,uniqueFreq-AtomicRefFreq<m92upperFreq);
        %m92BasedKLinedensity = (squeeze(mean(m92LineDensitiesMatrix(mask,:).*shotToShotVector(mask)',1))); %integrate over frequency
        m92BasedKLinedensity = (squeeze(mean(m92LineDensitiesMatrix(mask,:),1))); %integrate over frequency
    end
    preFactor = sqrt(pi)*sigma/2*Rabi^2;
    
    transferLineDensity = @(m72,m92,freqIntegratedBelowAtomicImage) (m72-offM92parameter*m92-freqIntegratedBelowAtomicImage);
    true_m72LineDensity = transferLineDensity(m72LineDensitiesMatrix(:,:),m92LineDensitiesMatrix(:,:),normMatrix(:,:));
    
    true_m72LineDensityShotToShotCorrected = true_m72LineDensity.*shotToShotVector';
    
    %contact fitting
    contactArray = [];
    figure(771),clf;
    for idx = 1:length(true_m72LineDensityShotToShotCorrected(1,:))
        m72 = true_m72LineDensityShotToShotCorrected(:,idx);
        m72Filtered = sgolayfilt(m72,2,25);
        
        [maxValue,maxIdx] = max(m72Filtered);
        %             display(idx);
        [~,halfWidthIdx] = min(abs(maxValue/1.5-m72Filtered(maxIdx:end)));
        halfWidthIdx = halfWidthIdx+maxIdx;
        if(halfWidthIdx<length(y))
            
            maskContact = and(y>y(halfWidthIdx),y<KdensityReconUpperCut);
        else
            maskContact = and(y>5,y<KdensityReconUpperCut);
        end
        
        
        fitfunContact = @(p,x) p(1)*(x).^(-3/2);
        
        pGuess = [22];
        lb = [0];
        ub = [100];
        parameterNames = {'Contact'};
        
        weighted_deviations = @(p) (fitfunContact(p,y(maskContact))-m72(maskContact));
        
        optio = optimoptions(@lsqnonlin,'Algorithm','trust-region-reflective','Display','off','MaxFunctionEvaluations',100);
        try
            [paramContact,~,resid,~,~,~,J]=lsqnonlin(weighted_deviations,pGuess,lb,ub,optio);
        catch
            paramContact = 0;
        end
        paramContact = real(paramContact);
        contactArray(idx) = paramContact;
        hold on
        plot(y,m72)
        plot(y,m72Filtered)
        plot(y(maskContact),fitfunContact(paramContact,y(maskContact)),'LineWidth',2)
        hold off
        drawnow;
        pause(0.5);
    end
    
    analysticalContactTail =  1/preFactor*(1000*2*pi)^(3/2)*contactArray.*integral(@(x) (x).^(-3/2),1000*2*pi*KdensityReconUpperCut,inf);
    
    mask = and(uniqueFreq-AtomicRefFreq>KdensityReconLowerCut,uniqueFreq-AtomicRefFreq<KdensityReconUpperCut);
    KLineDensityUpToCutOff = 1/preFactor*(squeeze(trapz(1000*2*pi*uniqueFreq(mask),true_m72LineDensity(mask,:),1))); %integrate over frequency
    reconstructedKLineDensity = KLineDensityUpToCutOff+analysticalContactTail;
    %filter reconstructed one
    filteredReconstructedKLineDensity = sgolayfilt([0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,reconstructedKLineDensity,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],2,11);
    filteredReconstructedKLineDensity = filteredReconstructedKLineDensity(20+1:end-20);
    
    if(strcmp(spectrum,'ejection'))
        %stiched Line density
        stichedKLineDensity = max(m92BasedKLinedensity,filteredReconstructedKLineDensity);
        
    else
        stichedKLineDensity = m92BasedKLinedensity;
    end
    
    
    
    % save things in analysis struct
    analysis.freqIntegratedBelowAtomicLineDensity           = freqIntegratedBelowAtomicLineDensity;
    analysis.filteredFreqIntegratedBelowAtomicLineDensity   = filteredFreqIntegratedBelowAtomicLineDensity;
    analysis.analysticalContactTail                         = analysticalContactTail;
    analysis.reconstructedKLineDensity                      = reconstructedKLineDensity;
    analysis.filteredReconstructedKLineDensity              = filteredReconstructedKLineDensity;
    analysis.m92BasedKLinedensity                           = m92BasedKLinedensity;
    analysis.stichedKLineDensity                            = stichedKLineDensity;
    analysis.shotToShotVector                               = shotToShotVector;
    
    %finally get transfer
    LineDensityWithShotToShotMatrix = shotToShotVector'*stichedKLineDensity;
    analysis.SuperFancyTransfer = true_m72LineDensity./LineDensityWithShotToShotMatrix;
    
    analysis.PixelMesh              = Xmesh;
    analysis.FreqMesh               = Ymesh;
    analysis.m92LineDensitiesMatrix = m92LineDensitiesMatrix;
    analysis.m72LineDensitiesMatrix = m72LineDensitiesMatrix;
    analysis.FreqIntegratedMatrix   = FreqIntegratedMatrix;
    analysis.KTransferMatrix        = KTransferMatrix;
    analysis.FancyKTransferMatrix   = FancyKTransferMatrix;
    analysis.BEC_TF_fromTOF         = BEC_TF_fromTOF;
    analysis.LineDensityPixelAveraging = LineDensityPixelAveraging;
    
    
    transferImage = @(m72,m92,freqIntegratedBelowAtomicImage) (m72-0.2*m92);
    
    mask = and(y>KdensityReconLowerCut,y<KdensityReconUpperCut);
    analysis.freqIntegratedImage = 1/preFactor*squeeze(trapz(1000*2*pi*y(mask),transferImage(analysis.m72Images(mask,:,:),analysis.m92Images(mask,:,:)),1)); %integrate over frequency
    
    mask = and(y>KdensityReconLowerCut,y<5);
    analysis.freqIntegratedAtomicImage = 1/preFactor*squeeze(trapz(1000*2*pi*y(mask),transferImage(analysis.m72Images(mask,:,:),analysis.m92Images(mask,:,:)),1)); %integrate over frequency
   
    mask = and(y>PolaronMaxPeakesitmate,y<KdensityReconUpperCut);
    analysis.freqIntegratedAbovePolaronImage = 1/preFactor*squeeze(trapz(1000*2*pi*y(mask),transferImage(analysis.m72Images(mask,:,:),analysis.m92Images(mask,:,:)),1)); %integrate over frequency
    
    mask = and(y>5,y<PolaronMaxPeakesitmate);
    analysis.freqIntegratedBetweenAtomicPolaron = 1/preFactor*squeeze(trapz(1000*2*pi*y(mask),transferImage(analysis.m72Images(mask,:,:),analysis.m92Images(mask,:,:)),1)); %integrate over frequency


    figure(1214),clf;
    subplot(4,1,1);
    imagesc(analysis.freqIntegratedImage);
    title('integrated all frequencies');
    axis equal
    colormap(flipud(bone));
    caxis([-0.00,0.05]);
    colorbar
    subplot(4,1,2);
    imagesc(analysis.freqIntegratedAtomicImage);
    title('integrated around atomic');
    axis equal
    colormap(flipud(bone));
    caxis([-0.00,0.05]);
    colorbar
    subplot(4,1,3);
    imagesc(analysis.freqIntegratedBetweenAtomicPolaron);
    title('integrated between atomic and polaron');
    axis equal
    colormap(flipud(bone));
    caxis([-0.00,0.05]);
    colorbar
    subplot(4,1,4);
    imagesc(analysis.freqIntegratedAbovePolaronImage);
    title('integrated from polaron');
    axis equal
    colormap(flipud(bone));
    caxis([-0.00,0.05]);
    colorbar
    
    figure(915),clf
    s = surf(Ymesh',Xmesh',KTransferMatrix');
    s.EdgeColor = 'none';
    caxis([-0.05,0.7])
    view(2);
    colormap(cmap)
    hold on
    l = plot([y(1),y(end)],[BEC_TF_fromTOF,BEC_TF_fromTOF]./LineDensityPixelAveraging,'w--','LineWidth',1.5);
    set(l,'ZData',[1,1]);
    l = plot([y(1),y(end)],[-BEC_TF_fromTOF,-BEC_TF_fromTOF]./LineDensityPixelAveraging,'w--','LineWidth',1.5);
    set(l,'ZData',[1,1]);
    hold off
    xlabel('\nu (kHz)')
    ylabel('position (px)' )
    title( 'Transfered fraction' );
    ylim([x(1),x(end)])
    xlim([min(uniqueFreq)-AtomicRefFreq,max(uniqueFreq)-AtomicRefFreq])
    colorbar
    set(gca,'FontSize', 14);
    set(gca, 'FontName', 'Arial')
    pos = get(gcf,'Position');
    set(gcf,'Position',[pos(1),pos(2),768, 420]);
    
    figure(916),clf
    s = surf(Ymesh',Xmesh',m72LineDensitiesMatrix');
    s.EdgeColor = 'none';
    caxis([0.0,0.3])
    view(2);
    colormap(cmap)
    hold on
    l = plot([y(1),y(end)],[BEC_TF_fromTOF,BEC_TF_fromTOF]./LineDensityPixelAveraging,'w--','LineWidth',1.5);
    set(l,'ZData',[1,1]);
    l = plot([y(1),y(end)],[-BEC_TF_fromTOF,-BEC_TF_fromTOF]./LineDensityPixelAveraging,'w--','LineWidth',1.5);
    set(l,'ZData',[1,1]);
    hold off
    xlabel('\nu (kHz)')
    ylabel('position (px)' )
    title( 'F=9/2 m_F = -7/2');
    ylim([x(1),x(end)])
    xlim([min(uniqueFreq)-AtomicRefFreq,max(uniqueFreq)-AtomicRefFreq])
    colorbar
    set(gca,'FontSize', 14);
    set(gca, 'FontName', 'Arial')
    pos = get(gcf,'Position');
    set(gcf,'Position',[pos(1),pos(2),768, 420]);
    
    figure(917),clf
    s = surf(Ymesh',Xmesh',m92LineDensitiesMatrix');
    s.EdgeColor = 'none';
    caxis([0.0,0.6])
    view(2);
    colormap(cmap)
    xlabel('\nu (kHz)')
    ylabel('position (px)' )
    title( 'F=9/2 m_F = -9/2');
    ylim([x(1),x(end)])
    xlim([min(uniqueFreq)-AtomicRefFreq,max(uniqueFreq)-AtomicRefFreq])
    colorbar
    set(gca,'FontSize', 14);
    set(gca, 'FontName', 'Arial')
    pos = get(gcf,'Position');
    set(gcf,'Position',[pos(1),pos(2),768, 420]);
    
    figure(918),clf
    s = surf(Ymesh',Xmesh',(m92LineDensitiesMatrix'/m92parameter+m72parameter*m72LineDensitiesMatrix'));
    s.EdgeColor = 'none';
    caxis([0.0,0.7])
    view(2);
    colormap(cmap)
    xlabel('\nu (kHz)')
    ylabel('position (px)' )
    title( '|0> + |1>');
    ylim([x(1),x(end)])
    xlim([min(uniqueFreq)-AtomicRefFreq,max(uniqueFreq)-AtomicRefFreq])
    colorbar
    set(gca,'FontSize', 14);
    set(gca, 'FontName', 'Arial')
    pos = get(gcf,'Position');
    set(gcf,'Position',[pos(1),pos(2),768, 420]);
    
    
    figure(919),clf
    plot(LineDensityPixelAveraging*x,analysticalContactTail,'LineWidth',1.5);
    hold on
    plot(LineDensityPixelAveraging*x,KLineDensityUpToCutOff,'LineWidth',1.5);
    plot(LineDensityPixelAveraging*x,reconstructedKLineDensity,'LineWidth',1.5);
    plot(LineDensityPixelAveraging*x,filteredReconstructedKLineDensity,'LineWidth',1.5);
    plot(LineDensityPixelAveraging*x,m92BasedKLinedensity,'LineWidth',1.5);
    plot(LineDensityPixelAveraging*x,stichedKLineDensity,'LineWidth',1.5);
    plot([BEC_TF_fromTOF,BEC_TF_fromTOF],[-1,1],'k--');
    plot(-[BEC_TF_fromTOF,BEC_TF_fromTOF],[-1,1],'k--');
    hold off
    ylim([-0.01,0.6])
    title('The story of the K line density')
    legend('Contact tail','freq integrated -7/2','reconstructed','filtered reconstructed','below atomic average -9/2','stiched')
    xlabel('position (px)')
    
    
    figure(924),clf
    s = surf(Ymesh',Xmesh',analysis.SuperFancyTransfer');
    s.EdgeColor = 'none';
    caxis([0.0,0.7])
    view(2);
    colormap(cmap)
    hold on
    l = plot([y(1),y(end)],[BEC_TF_fromTOF,BEC_TF_fromTOF]./LineDensityPixelAveraging,'w--','LineWidth',1.5);
    set(l,'ZData',[1,1]);
    l = plot([y(1),y(end)],[-BEC_TF_fromTOF,-BEC_TF_fromTOF]./LineDensityPixelAveraging,'w--','LineWidth',1.5);
    set(l,'ZData',[1,1]);
    hold off
    xlabel('\nu (kHz)')
    ylabel('position (px)' )
    title( 'Transfer');
    ylim([x(1),x(end)])
    xlim([min(uniqueFreq)-AtomicRefFreq,max(uniqueFreq)-AtomicRefFreq])
    colorbar
    set(gca,'FontSize', 14);
    set(gca, 'FontName', 'Arial')
    pos = get(gcf,'Position');
    set(gcf,'Position',[pos(1),pos(2),768, 420]);
    
    
       
    figure(915);saveas(gcf,'TransferByPixel_vs_kHz','svg')
    figure(916);saveas(gcf,'m72ByPixel_vs_kHz','svg')
    figure(917);saveas(gcf,'m92ByPixel_vs_kHz','svg')
    figure(918);saveas(gcf,'sumByPixel_vs_kHz','svg')
    figure(919);saveas(gcf,'K_LineDensityReconstruction','svg')
    figure(924);saveas(gcf,'FancyTransferFromFreqIntK_vs_En','svg')
    
    figure(915);saveas(gcf,'TransferByPixel_vs_kHz','fig')
    figure(916);saveas(gcf,'m72ByPixel_vs_kHz','fig')
    figure(917);saveas(gcf,'m92ByPixel_vs_kHz','fig')
    figure(918);saveas(gcf,'sumByPixel_vs_kHz','fig')
    figure(919);saveas(gcf,'K_LineDensityReconstruction','fig')
    figure(924);saveas(gcf,'FancyTransferFromFreqIntK_vs_En','fig')

    plot2DMatrixWithSlider(analysis.PixelMesh,analysis.FreqMesh,analysis.SuperFancyTransfer);

end

