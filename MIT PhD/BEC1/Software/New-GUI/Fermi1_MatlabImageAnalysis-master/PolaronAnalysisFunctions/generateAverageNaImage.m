function [analysis]=generateAverageNaImage(params,Na_analysis,varargin)
    superSamplingFactor1D = 2;
    useUpsampling = false;


    p = inputParser;

    p.addParameter('fullBoxWidth',100);
    p.addParameter('boxHeight',6);
    p.addParameter('BECoffsetX',0);
    p.addParameter('BECoffsetY',0);
    p.addParameter('AtomicRefFreq',530);
    p.addParameter('LineDensityFoldCenter',false);
    p.addParameter('LineDensityPixelAveraging',1);
    p.addParameter('NaInsituCI',0.68);
    p.addParameter('bootstrap',false);

    p.parse(varargin{:});
    
    fullBoxWidth                    = p.Results.fullBoxWidth;
    boxHeight                       = p.Results.boxHeight;
    BECoffsetX                      = p.Results.BECoffsetX;
    BECoffsetY                      = p.Results.BECoffsetY;
    AtomicRefFreq                   = p.Results.AtomicRefFreq;
    LineDensityFoldCenter           = p.Results.LineDensityFoldCenter;
    LineDensityPixelAveraging       = p.Results.LineDensityPixelAveraging;
    NaInsituCI                      = p.Results.NaInsituCI;
    bootstrap                       = p.Results.bootstrap;


    analysis = struct;
    [~,NaCi,~] = propagateErrorWithMC(@(x) x,Na_analysis.analysis.fitBimodalExcludeCenter.xparam(:,2)','plot',false,'CIthreshold', NaInsituCI);
    NaLowTFThresholdX = NaCi(1);
    NaHighTFThresholdX = NaCi(2);
    [~,NaCi,~] = propagateErrorWithMC(@(x) x,Na_analysis.analysis.fitBimodalExcludeCenter.xparam(:,1)','plot',false,'CIthreshold', NaInsituCI);
    NaLowAmpThresholdX = NaCi(1);
    NaHighAmpThresholdX = NaCi(2);
    
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
    
    mask = uniqueFreq>0;
    uniqueFreq = uniqueFreq(mask);
    
    if(LineDensityFoldCenter == true)
        effectiveBoxWidth = round(fullBoxWidth/2);
    else
        effectiveBoxWidth = fullBoxWidth;
    end
    if(useUpsampling == true)
        effectiveBoxWidth = superSamplingFactor1D*effectiveBoxWidth;
    end
    effectiveBoxWidth = floor(effectiveBoxWidth/LineDensityPixelAveraging);
    
    if(LineDensityFoldCenter == true)
        x = (1:effectiveBoxWidth)-0.5;
    else
        x = -(effectiveBoxWidth/2-.5):(effectiveBoxWidth/2-.5);
    end
    y = uniqueFreq-AtomicRefFreq;
    [Xmesh,Ymesh] = meshgrid(x,y);
    
    
    measNa = Measurement('Na','imageStartKeyword','Na','sortFilesBy','name','plotImage','original','NormOff' ,false,'NormType','Box');
    measNa.settings.normBox = Na_analysis.settings.normBox;
    measNa.settings.LineDensityFoldCenter = LineDensityFoldCenter;
    measNa.settings.LineDensityPixelAveraging = LineDensityPixelAveraging;
    measNa.settings.fudgeWidth = 5;
    measNa.settings.fudgeFilterFreq = 7;
    measNa.settings.superSamplingFactor1D = superSamplingFactor1D;
    measNa.settings.diffToDarkThreshold = 10;
     
    
    for idx = 1:length(uniqueFreq)
        freq = uniqueFreq(idx);
        
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
            binaryMask2 = or(NaLowAmpThresholdX<Na_analysis.analysis.fitBimodalExcludeCenter.xparam(RefPosIdx,1),...
                             Na_analysis.analysis.fitBimodalExcludeCenter.xparam(RefPosIdx,1)>NaHighAmpThresholdX);
            binaryMask = or(binaryMask1,binaryMask2);
                         
            measNa.settings.marqueeBox = [round(ReferencePos(1,1)-fullBoxWidth/2-BECoffsetX),...
                                         round(ReferencePos(1,2)-boxHeight/2-BECoffsetY),...
                                         fullBoxWidth,boxHeight];
            measNa.loadAndAverageSPEImages(freq,imageIdx,ReferencePos,'badShotImageNames',Na_analysis.badShots,...
                                            'binaryImageSelection',binaryMask);

            
            
            
        end
    end
    
    
    analysis.NaImages              = measNa.images.ODImages;
    analysis.averageImage          = squeeze(mean(measNa.images.ODImages,1));

end

