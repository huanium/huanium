function [analysis]=generateLineDensityRFTransfer_dualIMaging(ScanList,Na_analysis,varargin)
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
    
    
    
    m92LineDensitiesMatrix = zeros(length(uniqueFreq),effectiveBoxWidth);
    AreaKShotToShot = zeros(length(uniqueFreq),1);
    
    if(LineDensityFoldCenter == true)
        x = (1:effectiveBoxWidth)-0.5;
    else
        x = -(effectiveBoxWidth/2-.5):(effectiveBoxWidth/2-.5);
    end
    y = uniqueFreq-AtomicRefFreq;
    [Xmesh,Ymesh] = meshgrid(x,y);
    
    measM92 = Measurement('K2','imageStartKeyword','K2 m9','sortFilesBy','name','plotImage','original','NormType','Box');
    measM92.settings.LineDensityFoldCenter = LineDensityFoldCenter;
    measM92.settings.LineDensityPixelAveraging = LineDensityPixelAveraging;
    measM92.settings.fudgeWidth = 5;
    measM92.settings.fudgeFilterFreq = 7;
    measM92.settings.superSamplingFactor1D = superSamplingFactor1D;
    measM92.settings.diffToDarkThreshold = -2;
    measM92.settings.normBox = [675   130   173    13];
    
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
            imageFileNames = {};
            for kdx = 1:length(imageIdx)
                imageFileNames{kdx} = [num2str(ScanList.run_id(imageIdx(kdx))), '_0.spe'];
            end
            
            if length(imageFileNames)>1
                ReferencePos = [];
                ReferencePos(:,1) = Na_analysis.analysis.fittedGaussianAbsolutePositionX(RefPosIdx);
                ReferencePos(:,2) = Na_analysis.analysis.fittedGaussianAbsolutePositionY(RefPosIdx);

                binaryMask1 = or(NaLowTFThresholdX<Na_analysis.analysis.fitBimodalExcludeCenter.xparam(RefPosIdx,2),...
                                 Na_analysis.analysis.fitBimodalExcludeCenter.xparam(RefPosIdx,2)>NaHighTFThresholdX);
                binaryMask2 = or(NaLowAmpThresholdX<Na_analysis.analysis.bareNcntAverageMarqueeBoxValues(RefPosIdx),...
                                 Na_analysis.analysis.bareNcntAverageMarqueeBoxValues(RefPosIdx)>NaHighAmpThresholdX);
                binaryMask = or(binaryMask1,binaryMask2');

                measM92.flushAllODImages();

                if(round(ReferencePos(1,1)-fullBoxWidth/2-BECoffsetX) <1 || ...
                   round(ReferencePos(1,2)-boxHeight/2-BECoffsetY)<1 || ...   
                    fullBoxWidth+(round(ReferencePos(1,1)-fullBoxWidth/2-BECoffsetX))>1024 ||...
                    boxHeight + (round(ReferencePos(1,2)-boxHeight/2-BECoffsetY)) > 300)
                    disp('abc');
                    binaryMask = binaryMask(2:end);
                    ReferencePos = ReferencePos(2:end,:);
                    imageFileNames = imageFileNames(2:end);
                end
                measM92.settings.marqueeBox = [round(ReferencePos(1,1)-fullBoxWidth/2-BECoffsetX),...
                                             round(ReferencePos(1,2)-boxHeight/2-BECoffsetY),...
                                             fullBoxWidth,boxHeight];
                measM92.loadAndAverageSPEImagesFromFileName(freq,imageFileNames,ReferencePos,'badShotImageNames',Na_analysis.badShots,...
                                                'binaryImageSelection',binaryMask);
                if ~isempty(measM92.images.ODImages)                          
                    try
                        measM92.fitIntegratedGaussian('last','fitY',true);
                    catch
                        disp('problem: no image loaded')
                    end

                    if(useUpsampling == true)
                        m92LineDensitiesMatrix(idx,:)   = measM92.lineDensities.YintegratedUpsampled(end,:);

                    else
                        try
                            m92LineDensitiesMatrix(idx,:)   = measM92.lineDensities.Yintegrated(end,:);
                             catch
                           display('could not create line densities, something is seriously wrong') 
                        end
                    end



                    KtotalPerPixel              = (m92LineDensitiesMatrix(idx,:));
                    AreaKShotToShot(idx)        = trapz(KtotalPerPixel);


                    load('cmap.mat')

                    if plotting

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

                    end
                end
            end
        end
    end
    analysis.m92Images              = measM92.images.ODImages;
    
    analysis.PixelMesh              = Xmesh;
    analysis.FreqMesh               = Ymesh;
    analysis.m92LineDensitiesMatrix = m92LineDensitiesMatrix;
    analysis.BEC_TF_fromTOF         = BEC_TF_fromTOF;
    analysis.LineDensityPixelAveraging = LineDensityPixelAveraging;
   
    
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
    
    
    figure(917);saveas(gcf,'m92ByPixel_vs_kHz','svg')
    figure(919);saveas(gcf,'K_LineDensityReconstruction','svg')

end

