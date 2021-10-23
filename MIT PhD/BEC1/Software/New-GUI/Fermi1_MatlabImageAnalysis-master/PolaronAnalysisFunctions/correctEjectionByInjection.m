function ejectionData = correctEjectionByInjection(ejectionData,injectionData,varargin)
    
    p = inputParser;
    p.addParameter('initialStateImpuity',0.1);
    p.parse(varargin{:});
    initialStateImpuity = p.Results.initialStateImpuity;
    
    if(isstruct(injectionData))
        % filter updsample and interpolate injection
        normFreqCut = 40;
        TFratio = ejectionData.BEC_TF_fromTOF/injectionData.BEC_TF_fromTOF;
        freqMask = injectionData.FreqMesh(:,1)>normFreqCut;
        temp = injectionData.FancyKTransferMatrix(freqMask,:);
        norm = mean(temp(:));

        FreqMesh = injectionData.FreqMesh();
        PixelMesh = TFratio*injectionData.PixelMesh();
        Transfer = injectionData.FancyKTransferMatrix(:,:)-norm;
        Transfer(freqMask,:) = zeros(size(temp));
        
        freqMask = or(injectionData.FreqMesh(:,1)>15,injectionData.FreqMesh(:,1)<-15);
        Transfer(freqMask,1:11) = zeros(size(Transfer(freqMask,1:11)));
        Transfer(freqMask,end-10) = zeros(size(Transfer(freqMask,end-10)));

        [m,n] = size(Transfer);
        SGfiltered =[];
        for idx=1:m
            SGfiltered(idx,:)=sgolayfilt(Transfer(idx,:),2,9);
        end

        %zero pad before upsampling
        SGfiltered(end+1,:) = zeros(1,n);
        FreqMesh(end+1,:)   = 1000*ones(1,n);
        PixelMesh(end+1,:)  = PixelMesh(end,:);
        PixelAxis           = injectionData.PixelMesh(1,:);

        InterPolPixel = ejectionData.PixelMesh(1,:);
        InterPolFreq  = ejectionData.FreqMesh(:,1);

        [interPolPixelMesh, interPolFreqMesh] = meshgrid(InterPolPixel,InterPolFreq);
        upsampledTransferCorrection = griddata(FreqMesh,PixelMesh,SGfiltered,interPolFreqMesh,interPolPixelMesh,'cubic');

        freqMask = interPolFreqMesh(:,1)>normFreqCut;
        temp = upsampledTransferCorrection(freqMask,:);
        upsampledTransferCorrection(freqMask,:) = zeros(size(temp));

        %% do correction
        injectionCorrectedTransfer = ejectionData.SuperFancyTransfer + initialStateImpuity*upsampledTransferCorrection;
    else
        injectionCorrectedTransfer = ejectionData.FancyKTransferMatrix;
    end
    FreqMesh  = ejectionData.FreqMesh();
    PixelMesh = ejectionData.PixelMesh();

    normFreqCut = -5;
    freqMask = FreqMesh(:,1)<normFreqCut;
    temp = injectionCorrectedTransfer(freqMask,:);
    norm = mean(temp(:));
%     norm=0.0436;
    ejectionData.norm = norm;
    ejectionData.injectionCorrectedScaledTransfer = (injectionCorrectedTransfer-norm);%/(1-2*norm);

    plot2DMatrixWithSlider(PixelMesh,FreqMesh,ejectionData.injectionCorrectedScaledTransfer);

end

