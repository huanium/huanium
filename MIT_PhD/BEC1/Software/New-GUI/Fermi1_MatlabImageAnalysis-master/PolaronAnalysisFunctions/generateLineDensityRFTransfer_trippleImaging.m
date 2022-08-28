function [analysis]=generateLineDensityRFTransfer_trippleImaging(ScanList,Na_analysis,K1_analysis,K2_analysis,varargin)
    superSamplingFactor1D = 2;
    useUpsampling = false;


    p = inputParser;
    
    p.addParameter('fullBoxWidth',100);
    p.addParameter('boxHeight',6);
    p.addParameter('BECoffsetX',0);
    p.addParameter('BECoffsetY',0);
    p.addParameter('AtomicRefFreq',530);
    p.addParameter('BEC_TF_fromTOF',26.6);
    p.addParameter('LineDensityFoldCenter',false);
    p.addParameter('LineDensityPixelAveraging',1);
    p.addParameter('bootstrap',false);
    p.addParameter('plotting',false);
    p.addParameter('NaLowTFThresholdX',18);
    p.addParameter('NaHighTFThresholdX',30);
    p.addParameter('NaLowAmpThresholdX',0);
    p.addParameter('NaHighAmpThresholdX',5000);
    p.addParameter('KLowCntsThresholdX',0);
    p.addParameter('KHighCntsThresholdX',5000);
    p.addParameter('RFtime',0);
    
    p.parse(varargin{:});
    
    fullBoxWidth                    = p.Results.fullBoxWidth;
    boxHeight                       = p.Results.boxHeight;
    BECoffsetX                      = p.Results.BECoffsetX;
    BECoffsetY                      = p.Results.BECoffsetY;
    AtomicRefFreq                   = p.Results.AtomicRefFreq;
    BEC_TF_fromTOF                  = p.Results.BEC_TF_fromTOF;
    LineDensityFoldCenter           = p.Results.LineDensityFoldCenter;
    LineDensityPixelAveraging       = p.Results.LineDensityPixelAveraging;
    bootstrap                       = p.Results.bootstrap;
    plotting                        = p.Results.plotting;
    NaLowTFThresholdX               = p.Results.NaLowTFThresholdX;
    NaHighTFThresholdX              = p.Results.NaHighTFThresholdX;
    NaLowAmpThresholdX              = p.Results.NaLowAmpThresholdX;
    NaHighAmpThresholdX             = p.Results.NaHighAmpThresholdX;
    KLowCntsThresholdX              = p.Results.KLowCntsThresholdX;
    KHighCntsThresholdX             = p.Results.KHighCntsThresholdX;
    RFtime                          = p.Results.RFtime;

    analysis = struct;
    params = ScanList.RFK2;
    
    % take care of bad shots
    analyzedImageIdx = 1:length(Na_analysis.parameters);
    imageIdx = 1:length(params);
    
    files= dir(['*spe']);
    filenames = {files.name};
    badShotIdx=[];
    for jdx = imageIdx
        for idx = 1:length(Na_analysis.badShots)
            if strcmp(filenames{(jdx)},Na_analysis.badShots{idx})
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
        %uniqueFreq = unique(Na_analysis.parameters);
        temp = unique(Na_analysis.parameters);
        uniqueFreq = temp(1<histc(Na_analysis.parameters,unique(Na_analysis.parameters)));
        
    else
        [~,bootIdx] = datasample(analyzedImageIdx,length(analyzedImageIdx));
        uniqueFreq = unique(Na_analysis.parameters(bootIdx));
    end
    
    
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
    
    if(LineDensityFoldCenter == true)
        x = (1:effectiveBoxWidth)-0.5;
    else
        x = -(effectiveBoxWidth/2-.5):(effectiveBoxWidth/2-.5);
    end
    y = uniqueFreq-AtomicRefFreq;
    [Xmesh,Ymesh] = meshgrid(x,y);
    
    measK1 = Measurement('K2','imageStartKeyword','K2 m9','sortFilesBy','name','plotImage','original','NormType','Box');
    measK1.settings.LineDensityFoldCenter = LineDensityFoldCenter;
    measK1.settings.LineDensityPixelAveraging = LineDensityPixelAveraging;
    measK1.settings.fudgeWidth = 5;
    measK1.settings.fudgeFilterFreq = 7;
    measK1.settings.superSamplingFactor1D = superSamplingFactor1D;
    measK1.settings.diffToDarkThreshold = -2;
    measK1.settings.normBox = [675   130   173    13];
    
    measK2 = Measurement('K2','imageStartKeyword','K2 m9','sortFilesBy','name','plotImage','original','NormType','Box');
    measK2.settings.LineDensityFoldCenter = LineDensityFoldCenter;
    measK2.settings.LineDensityPixelAveraging = LineDensityPixelAveraging;
    measK2.settings.fudgeWidth = 5;
    measK2.settings.fudgeFilterFreq = 7;
    measK2.settings.superSamplingFactor1D = superSamplingFactor1D;
    measK2.settings.diffToDarkThreshold = -2;
    measK2.settings.normBox = [675   130   173    13];
    
    
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
            imageFileNamesK1 = {};
            imageFileNamesK2 = {};
            for kdx = 1:length(imageIdx)
                imageFileNamesK1{kdx} = [num2str(ScanList.run_id(imageIdx(kdx))), '_2.spe'];
                imageFileNamesK2{kdx} = [num2str(ScanList.run_id(imageIdx(kdx))), '_1.spe'];
            end
            
            if length(imageFileNamesK1)>1
                ReferencePos = [];
                ReferencePos(:,1) = Na_analysis.analysis.fittedGaussianAbsolutePositionX(RefPosIdx);
                ReferencePos(:,2) = Na_analysis.analysis.fittedGaussianAbsolutePositionY(RefPosIdx);

                binaryMask1 = or(NaLowTFThresholdX<Na_analysis.analysis.fitBimodalExcludeCenter.xparam(RefPosIdx,2),...
                                 Na_analysis.analysis.fitBimodalExcludeCenter.xparam(RefPosIdx,2)>NaHighTFThresholdX);
                binaryMask2 = or(NaLowAmpThresholdX<Na_analysis.analysis.NcntLarge(RefPosIdx),...
                                 Na_analysis.analysis.NcntLarge(RefPosIdx)>NaHighAmpThresholdX);
                binaryMask3 = or(KLowCntsThresholdX<K2_analysis.analysis.NcntLarge(RefPosIdx),...
                                 K2_analysis.analysis.NcntLarge(RefPosIdx)>KHighCntsThresholdX);
                binaryMask4 = ScanList.RFtime(RefPosIdx)==RFtime;             
                             
                             
                binaryMask = and(binaryMask1,binaryMask2');
                binaryMask = and(binaryMask,binaryMask3');
                binaryMask = and(binaryMask,binaryMask4);

                measK1.flushAllODImages();
                measK2.flushAllODImages();

                if(round(ReferencePos(1,1)-fullBoxWidth/2-BECoffsetX) <1 || ...
                   round(ReferencePos(1,2)-boxHeight/2-BECoffsetY)<1 || ...   
                    fullBoxWidth+(round(ReferencePos(1,1)-fullBoxWidth/2-BECoffsetX))>1024 ||...
                    boxHeight + (round(ReferencePos(1,2)-boxHeight/2-BECoffsetY)) > 300)
                    disp('abc');
                    binaryMask = binaryMask(2:end);
                    ReferencePos = ReferencePos(2:end,:);
                    imageFileNamesK1 = imageFileNamesK1(2:end);
                    imageFileNamesK2 = imageFileNamesK2(2:end);
                end
                measK1.settings.marqueeBox = [round(ReferencePos(1,1)-fullBoxWidth/2-BECoffsetX),...
                                             round(ReferencePos(1,2)-boxHeight/2-BECoffsetY),...
                                             fullBoxWidth,boxHeight];
                measK1.loadAndAverageSPEImagesFromFileName(freq,imageFileNamesK1,ReferencePos,'badShotImageNames',Na_analysis.badShots,...
                                                'binaryImageSelection',binaryMask);
                                            
                                            
                measK2.settings.marqueeBox = [round(ReferencePos(1,1)-fullBoxWidth/2-BECoffsetX),...
                                             round(ReferencePos(1,2)-boxHeight/2-BECoffsetY),...
                                             fullBoxWidth,boxHeight];
                measK2.loadAndAverageSPEImagesFromFileName(freq,imageFileNamesK2,ReferencePos,'badShotImageNames',Na_analysis.badShots,...
                                                'binaryImageSelection',binaryMask);
                                            
                if ~isempty(measK1.images.ODImages)                          
                    try
                        
                        measK1.fitIntegratedGaussian('last','fitY',false);
                        measK2.fitIntegratedGaussian('last','fitY',false);
                    catch
                        disp('problem: no image loaded')
                    end

                    if(useUpsampling == true)
                        m92LineDensitiesMatrix(idx,:)   = measK2.lineDensities.YintegratedUpsampled(end,:);
                        m72LineDensitiesMatrix(idx,:)   = measK1.lineDensities.YintegratedUpsampled(end,:);

                    else
                        try
                            m92LineDensitiesMatrix(idx,:)   = measK2.lineDensities.Yintegrated(end,:);
                            m72LineDensitiesMatrix(idx,:)   = measK1.lineDensities.Yintegrated(end,:);
                             catch
                           display('could not create line densities, something is seriously wrong') 
                        end
                    end
                    
                  
                    
                    load('cmap.mat')

                    if plotting

                        figure(917),clf
                        s = surf(Ymesh',Xmesh',m92LineDensitiesMatrix');
                        s.EdgeColor = 'none';
                        caxis([0.0,1])
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
                        s = surf(Ymesh',Xmesh',m72LineDensitiesMatrix');
                        s.EdgeColor = 'none';
                        caxis([0.0,0.4])
                        view(2);
                        colormap(cmap)
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


                    end
                end
            end
        end
    end
    analysis.m92Images              = measK2.images.ODImages;
    analysis.m72Images              = measK1.images.ODImages;
    
    analysis.PixelMesh              = Xmesh;
    analysis.FreqMesh               = Ymesh;
    analysis.m92LineDensitiesMatrix = m92LineDensitiesMatrix;
    analysis.m72LineDensitiesMatrix = m72LineDensitiesMatrix;
    analysis.BEC_TF_fromTOF         = BEC_TF_fromTOF;
    analysis.LineDensityPixelAveraging = LineDensityPixelAveraging;
   
    
    figure(917),clf
    s = surf(Ymesh',Xmesh',m92LineDensitiesMatrix');
    s.EdgeColor = 'none';
    caxis([0.0,1])
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
    s = surf(Ymesh',Xmesh',m72LineDensitiesMatrix');
    s.EdgeColor = 'none';
    caxis([0.0,0.4])
    view(2);
    colormap(cmap)
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
    
    
    figure(917);saveas(gcf,'m92ByPixel_vs_kHz','svg')
    figure(918);saveas(gcf,'K_LineDensityReconstruction','svg')

end

