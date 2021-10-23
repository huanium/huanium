function [Transfer,ODunique,averagePixelCountAllImages]=averageSpectrum(Species, params,Na_analysis,fullBoxWidth,boxHeight,BECoffsetX,BECoffsetY,varargin)
%Recreates the column density of K -7/2 state.
%Species is the image keyword, ie 'K1'
%Tracking the center position of the
%cloud from Na_analysis object.
%Returns Transfer, the 2D column density of K, integrated over the entire
%frequency spectrum

%NOTE 11/17/18: the OD unique doesn't quite work, gives lower OD's than
%expected.  Probably something to do with normalization.

    p = inputParser;
    p.addParameter('badShotImageNames',{});
    p.parse(varargin{:});
    badShotImageNames = p.Results.badShotImageNames;
    imageIdx = 1:length(params);
%     imageIdx= find(params>freqCut(1) &params<freqCut(2));
    
    moveFilesForAnalysis;
    RefPosIdx = 1:length(Na_analysis.parameters);
%     if(length(RefPosIdx) ~= length(imageIdx))
%         fprintf('there are %i reference positions for %i images \n',length(RefPosIdx),length(imageIdx))
%     end
    
    ReferencePos(:,1) = Na_analysis.analysis.fittedGaussianAbsolutePositionX(RefPosIdx);
    ReferencePos(:,2) = Na_analysis.analysis.fittedGaussianAbsolutePositionY(RefPosIdx);
    
    
    meas1 = Measurement(Species,'imageStartKeyword',Species,'sortFilesBy','name','plotImage','original','NormOff' ,false,'NormType','Box');
    meas1.settings.normBox = Na_analysis.settings.normBox;
    meas1.settings.marqueeBox = [round(ReferencePos(1,1)-fullBoxWidth/2-BECoffsetX),...
        round(ReferencePos(1,2)-boxHeight/2-BECoffsetY),...
        fullBoxWidth,boxHeight];
    meas1.settings.diffToDarkThreshold = 5;
    rawImages=meas1.loadAndAverageSPEImages(1,imageIdx,ReferencePos,'badShotImageNames',badShotImageNames);
    averagePixelCountAllImages=meas1.analysis.bareNcntAverageMarqueeBoxValues;
    %throw away the useless layer of zeros in rawImages
    rawImages=rawImages(:,:,:,2:end);
    
    darkField=squeeze(rawImages(:,:,3,:));
    brightField=squeeze(rawImages(:,:,2,:));
    probeAtom=squeeze(rawImages(:,:,1,:));
    
        %sort the list in ascending frequencies
    goodFreq=params(imageIdx);
    ascendingFreq=unique(goodFreq);
    if ascendingFreq(1) ==-1
        ascendingFreq=ascendingFreq(2:end);
    end
    darkFieldUnique = zeros([size(darkField,1) size(darkField,2) length(ascendingFreq)]);
    brightFieldUnique = zeros([size(darkField,1) size(darkField,2) length(ascendingFreq)]);
    probeAtomUnique = zeros([size(darkField,1) size(darkField,2) length(ascendingFreq)]);
    ODunique = zeros([size(darkField,1) size(darkField,2) length(ascendingFreq)]);

    for jdx=1:length(ascendingFreq)
        goodIdx=find(Na_analysis.parameters==ascendingFreq(jdx));
        darkFieldUnique(:,:,jdx) = mean(darkField(:,:,goodIdx),3);
        brightFieldUnique(:,:,jdx) = mean(brightField(:,:,goodIdx),3);
        probeAtomUnique(:,:,jdx) = mean(probeAtom(:,:,goodIdx),3);
        NormImage=(probeAtomUnique(:,:,jdx)-darkFieldUnique(:,:,jdx))./(brightFieldUnique(:,:,jdx)-darkFieldUnique(:,:,jdx));
        mask = NormImage<0;
        NormImage(mask) = meas1.settings.lowThreshold;
        ODunique(:,:,jdx)=-log(NormImage);
    end
    
    
    badIdx=isnan(ODunique);
    ODunique(badIdx)=0;
    Transfer = trapz(ascendingFreq,ODunique,3); %integrate over frequency
    
    figure(11),clf;

    subplot(3,1,1);
    imagesc(ODunique(ReferencePos(1,2)-boxHeight/2:ReferencePos(1,2)+boxHeight/2,ReferencePos(1,1)-fullBoxWidth/2:ReferencePos(1,1)+fullBoxWidth/2));
    
    colormap(flipud(bone));
%     caxis([-10,60]);
    colorbar
    axis equal
    title('OD for average');

    subplot(3,1,2);hold on;
    plot(1:fullBoxWidth+1,sum(ODunique(ReferencePos(1,2)-boxHeight/2:ReferencePos(1,2)+boxHeight/2,ReferencePos(1,1)-fullBoxWidth/2:ReferencePos(1,1)+fullBoxWidth/2)));
    title('y-integrated');
    xlabel('x pixel');
    ylabel(' line density');
    display([ReferencePos(1,2)-boxHeight/2,ReferencePos(1,2)+boxHeight/2,ReferencePos(1,1)-fullBoxWidth/2,ReferencePos(1,1)+fullBoxWidth/2])
    subplot(3,1,3);hold on;
    plot(1:boxHeight+1,sum(ODunique(ReferencePos(1,2)-boxHeight/2:ReferencePos(1,2)+boxHeight/2,ReferencePos(1,1)-fullBoxWidth/2:ReferencePos(1,1)+fullBoxWidth/2),2));
    title('x-integrated');
    xlabel('y pixel');
    ylabel(' line density');
    
end