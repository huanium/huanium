function [measImage]=generateAverageImageIntegGaussian(params,all_analysis,varargin)
%take fitted integrated gaussian positions, use as reference position, then
%average images with the same parameter values
%Params are the ORIGINAL parameters, not just the 'good image' params

    p = inputParser;
    p.addParameter('species','Na');
    p.addParameter('fullBoxWidth',180);
    p.addParameter('boxHeight',150);
    p.addParameter('BECoffsetX',20);
    p.addParameter('BECoffsetY',20);
    p.addParameter('AtomicRefFreq',0);
    p.addParameter('LineDensityFoldCenter',false);
    p.addParameter('LineDensityPixelAveraging',1);
    p.addParameter('NaInsituCI',0.68);
    p.addParameter('cutOnNa',true); %does the binary mask on images
    p.addParameter('bootstrap',false);
    p.addParameter('MarqueeX',455); %where original marquee box was, relative to fitIntegratedGaussian
    p.addParameter('MarqueeY',130);
    p.addParameter('superSamplingFactor1D',1);

    p.parse(varargin{:});
    species                         =p.Results.species;
    fullBoxWidth                    = p.Results.fullBoxWidth;
    boxHeight                       = p.Results.boxHeight;
    BECoffsetX                      = p.Results.BECoffsetX;
    BECoffsetY                      = p.Results.BECoffsetY;
    AtomicRefFreq                   = p.Results.AtomicRefFreq;
    LineDensityFoldCenter           = p.Results.LineDensityFoldCenter;
    LineDensityPixelAveraging       = p.Results.LineDensityPixelAveraging;
    NaInsituCI                      = p.Results.NaInsituCI;
    bootstrap                       = p.Results.bootstrap;
    MarqueeX                        =p.Results.MarqueeX;
    MarqueeY                        =p.Results.MarqueeY;
    cutOnNa                         =p.Results.cutOnNa;
    superSamplingFactor1D           =p.Results.superSamplingFactor1D;
    
    if cutOnNa
        [~,NaCi,~] = propagateErrorWithMC(@(x) x,all_analysis.analysis.fitBimodalExcludeCenter.xparam(:,2)','plot',false,'CIthreshold', NaInsituCI);
        NaLowTFThresholdX = NaCi(1);
        NaHighTFThresholdX = NaCi(2);
        [~,NaCi,~] = propagateErrorWithMC(@(x) x,all_analysis.analysis.fitBimodalExcludeCenter.xparam(:,1)','plot',false,'CIthreshold', NaInsituCI);
        NaLowAmpThresholdX = NaCi(1);
        NaHighAmpThresholdX = NaCi(2);
    end
    % take care of bad shots
    analyzedImageIdx = 1:length(all_analysis.parameters);
    imageIdx = 1:length(params);
    
    files= dir([species '*spe']);
    filenames = {files.name};
    for jdx = 1:length(files)
        numbers = regexp(files(jdx).name,'\d*','Match');
        extendedFilenames{jdx} = [files(jdx).name(1:end-strlength(numbers(end))-4),sprintf('%010d',str2double(numbers{end})),'.spe'];
    end
    [~,sortidx] = sort(extendedFilenames);
    badShotIdx=[];
    for jdx = imageIdx
        for idx = 1:length(all_analysis.badShots)
            if strcmp(filenames{sortidx(jdx)},all_analysis.badShots{idx})
                badShotIdx(end+1) = jdx;
            end
        end
    end
    imageWithBadShots = imageIdx;
    imageWithBadShots(badShotIdx) = NaN;

    trueAnalyzedImageIdx = []; %why is this not the same number as N(parameters) = total images-N(bad shots)
    for idx = imageIdx
        if ~isnan(imageWithBadShots(idx))
            trueAnalyzedImageIdx(end+1) = idx;
        end
    end

    
    if ~bootstrap
        uniqueFreq = unique(all_analysis.parameters);
    else
        [~,bootIdx] = datasample(analyzedImageIdx,length(analyzedImageIdx));
        uniqueFreq = unique(all_analysis.parameters(bootIdx));
    end
    
    mask = uniqueFreq>0;
    uniqueFreq = uniqueFreq(mask);
    
% %     if(LineDensityFoldCenter == true)
% %         effectiveBoxWidth = round(fullBoxWidth/2);
% %     else
% %         effectiveBoxWidth = fullBoxWidth;
% %     end
% %     if(useUpsampling == true)
% %         effectiveBoxWidth = superSamplingFactor1D*effectiveBoxWidth;
% %     end
% %     effectiveBoxWidth = floor(effectiveBoxWidth/LineDensityPixelAveraging);
% %     
% %     if(LineDensityFoldCenter == true)
% %         x = (1:effectiveBoxWidth)-0.5;
% %     else
% %         x = -(effectiveBoxWidth/2-.5):(effectiveBoxWidth/2-.5);
% %     end
% %     y = uniqueFreq-AtomicRefFreq;
% %     [Xmesh,Ymesh] = meshgrid(x,y);
    
    
    measImage = Measurement(species,'imageStartKeyword',species,'sortFilesBy','name','plotImage','original','NormOff' ,false,'NormType','Box');
    measImage.settings.normBox = all_analysis.settings.normBox;
    measImage.settings.LineDensityFoldCenter = LineDensityFoldCenter;
    measImage.settings.LineDensityPixelAveraging = LineDensityPixelAveraging;
    measImage.settings.fudgeWidth = 5;
    measImage.settings.fudgeFilterFreq = 7;
    measImage.settings.superSamplingFactor1D = superSamplingFactor1D;
    measImage.settings.diffToDarkThreshold = 10;
     
    
    for idx = 1:length(uniqueFreq)
        freq = uniqueFreq(idx);
        
        if ~bootstrap
            imageIdx = trueAnalyzedImageIdx(find(all_analysis.parameters==freq));
            RefPosIdx = find(all_analysis.parameters==freq);
            if(length(RefPosIdx) ~= length(imageIdx))
                fprintf('there are %i reference positions for %i images \n',length(RefPosIdx),length(imageIdx))
            end
        else
            imageIdx = trueAnalyzedImageIdx(bootIdx(find(all_analysis.parameters(bootIdx)==freq)));
            RefPosIdx = bootIdx(find(all_analysis.parameters((bootIdx))==freq));
            if(length(RefPosIdx) ~= length(imageIdx))
                fprintf('there are %i reference positions for %i images \n',length(RefPosIdx),length(imageIdx))
            end
        end
        
        if(isempty(imageIdx))
            error(['no images with freqency ' num2str(freq)])
        else
            moveFilesForAnalysis;
            
            ReferencePos = [];
% %             ReferencePos(:,1) = Na_analysis.analysis.fittedGaussianAbsolutePositionX(RefPosIdx);
            ReferencePos(:,1) = all_analysis.analysis.fitIntegratedGaussX.param(RefPosIdx,3)+MarqueeX;
% %             ReferencePos(:,2) = Na_analysis.analysis.fittedGaussianAbsolutePositionY(RefPosIdx);
            ReferencePos(:,2) = all_analysis.analysis.fitIntegratedGaussY.param(RefPosIdx,3)+MarqueeY;
            if cutOnNa
                binaryMask1 = or(NaLowTFThresholdX<all_analysis.analysis.fitBimodalExcludeCenter.xparam(RefPosIdx,2),...
                                 all_analysis.analysis.fitBimodalExcludeCenter.xparam(RefPosIdx,2)>NaHighTFThresholdX);
                binaryMask2 = or(NaLowAmpThresholdX<all_analysis.analysis.fitBimodalExcludeCenter.xparam(RefPosIdx,1),...
                                 all_analysis.analysis.fitBimodalExcludeCenter.xparam(RefPosIdx,1)>NaHighAmpThresholdX);
                binaryMask = or(binaryMask1,binaryMask2);
            else
                binaryMask=ones(size(RefPosIdx));
            end             
% %             measNa.settings.marqueeBox = [round(ReferencePos(1,1)-fullBoxWidth/2-BECoffsetX),...
% %                                          round(ReferencePos(1,2)-boxHeight/2-BECoffsetY),...
% %                                          fullBoxWidth,boxHeight];
            measImage.settings.marqueeBox = [round(ReferencePos(1,1)-BECoffsetX),...
                                         round(ReferencePos(1,2)-BECoffsetY),...
                                         fullBoxWidth,boxHeight];
%             disp(measImage.settings.marqueeBox);
%             disp(RefPosIdx);
%             waitforbuttonpress;
            if ~isempty(RefPosIdx)>0
            measImage.loadAndAverageSPEImages(freq,imageIdx,ReferencePos,'badShotImageNames',all_analysis.badShots,...
                                            'binaryImageSelection',binaryMask);

            
            
            %%perform operations on averaged image
            measImage.fitBimodalExcludeCenter('last','BlackedOutODthreshold',6.1,'useLineDensity',true);
            measImage.fitIntegratedGaussian('last');
            else
                
            end
%             waitforbuttonpress;
            
        end
    end
    
    
% %     analysis.NaImages              = measNa.images.ODImages;
% %     analysis.averageImage          = squeeze(mean(measNa.images.ODImages,1));
% %     analysis.fitBimodalExcludeCenter=measNa.fitBimodalExcludeCenter;
measImage.flushAllImages;

end

