function LocalRFSpec= getLocalTransfer(LineDensityAnalysis, pixelBinFactor, tempKelvin, orderSG, frameLengthSG,varargin)
    % Inputs: LineDensityAnalysis structure, pixelBinFactor (usu 1 or 2),
    % temperature in Kelvin, polynomial order for SG filter (ie 2 =
    % quadratic), frameLength for SG filter (must be odd integer, ie 17 pixel)
    %GaussianWeightFactor applies to the weights of the SG filter.  
    %Edge point of frame is only exp(-GaussianWeightFactor) as
    %important as the center.  For uniform weighting, choose 0.
    
    p = inputParser;
    p.addParameter('GaussianWeightFactor',1);
    p.addParameter('KProfile',[]);
    p.parse(varargin{:});
    GaussianWeightFactor = p.Results.GaussianWeightFactor;
    KProfile=p.Results.KProfile;        
    pixelCut=50; %reject pixels above this number, and below negative of this
    pixelToMeter=2.5e-6;

    freq=LineDensityAnalysis.FreqMesh(:,1);
    pixel=LineDensityAnalysis.PixelMesh(1,:);
    pixel=pixelBinFactor*(pixel-pixel(end)); 
    %make the zero pixel coordinate the center of the cloud
    %take into account 2x2 binning

    transfer=LineDensityAnalysis.FancyKTransferMatrix;

    goodPixIdx=find(pixel<pixelCut&pixel>-pixelCut); %Index of useful pixels
    pixelCenter=pixel(goodPixIdx); %the useful pixels 
    deltaPix=abs(pixelCenter(2)-pixelCenter(1)); %spacing of pixels
    pixelCenterForDeriv=pixelCenter(1:end-1)+deltaPix/2; %shifted by half a spacing for the derivative

    %  create the exponential part from K profile, let alpha_K=alpha_Na for now
    if isempty(KProfile)
        %use Temperature and Na parameters to estimate K in situ density
        beta=1/(tempKelvin*kB); %temperature
        ratioPolarizability= 2.82; %alphaK: alphaNa for 1064
        waxial=2*pi*13;  %Na trap freq in axial x-direction, rad/s
        expFactor=exp(-beta*ratioPolarizability*mNa*waxial^2/2*(2.5e-6*pixelCenter).^2);
        expFactorPos=exp(beta*ratioPolarizability*mNa*waxial^2/2*(2.5e-6*pixelCenterForDeriv).^2);

    else
        %Recreate 2D K density by fitting an OD image, in x-and-y- real pixels    
        croppedODImage = squeeze(KProfile);
                
        pGuess = [mean([croppedODImage(1,:),croppedODImage(:,1)']),max(max(croppedODImage))-min(min(croppedODImage)),...
            length(croppedODImage)/2,length(croppedODImage(:,1))/2,20,5];   
        % Inital (guess) parameters
%         lb = [-0.05,0.05,0.1*this.settings.marqueeBox(3),0.1*this.settings.marqueeBox(4),1,0.02,-10];
%         ub = [1.2*abs(mean([croppedODImage(1,:),croppedODImage(:,1)'])),1.2*max(max(croppedODImage)),0.9*this.settings.marqueeBox(3),0.9*this.settings.marqueeBox(4),min(this.settings.marqueeBox(4),this.settings.marqueeBox(3)),10,10];
        
        [x,y]=meshgrid(1:length(croppedODImage),1:length(croppedODImage(:,1)));
        pix=zeros(length(croppedODImage(:,1)),length(croppedODImage),2);
        pix(:,:,1)=x;
        pix(:,:,2)=y;
        
        fitfun = @(p,x) p(1)+p(2)*exp( -(...
            ( x(:,:,1) - p(3)).^2/(2*p(5)^2) + ...
            ( x(:,:,2) - p(4)).^2/(2*p(6))^2)  );
        
        % {'Offset', 'Amplitude','Center X','Center Y','WidthX','WidthY'};
        
        opts = optimoptions('lsqcurvefit','Algorithm','trust-region-reflective','Display','off','MaxFunctionEvaluations',1000);
        paramFit = lsqcurvefit(fitfun,pGuess,pix,croppedODImage,[],[],opts);
        figure(4);
        clf;
        subplot(2,1,1);
        imagesc(croppedODImage);
        title('Image')
        colorbar
        caxis([0 max(max(croppedODImage))]);
        subplot(2,1,2);
        imagesc(fitfun(paramFit,pix));
        title('Fitted Gaussian')
        colorbar
        caxis([0 max(max(croppedODImage))]);
        expFactor=exp(-pixelCenter.^2/2/paramFit(5)^2);
        expFactorPos=exp(pixelCenterForDeriv.^2/2/paramFit(5)^2);

    end
    figure(9);clf;plot(pixelCenter,expFactor,'LineWidth',2);
    title('exponential factor from K density');
    %% apply savitzky-golay filter on all frequencies, take derivative

    weightsSG= exp(-([1:frameLengthSG] - ceil(frameLengthSG/2)).^2/floor(frameLengthSG/2)^2*GaussianWeightFactor);


    fprintf(strcat('Order = ', num2str(orderSG),', FrameLength = ', num2str(frameLengthSG), ', Edge weight = ', num2str(weightsSG(1))))
    fprintf('\n');

    sgf=zeros(length(goodPixIdx), length(freq)); %Filtered old transfer
    sgfWithExp=sgf;
    deriv=zeros(length(goodPixIdx)-1, length(freq));

    for idx=1:length(freq)
        sgf(:,idx)=sgolayfilt(transfer(idx,goodPixIdx),orderSG,frameLengthSG,weightsSG);
        sgfWithExp(:,idx)=sgf(:,idx).*expFactor';
        deriv(:,idx)=diff(sgfWithExp(:,idx))/deltaPix/pixelToMeter; 
        %take d/dx of the filtered transfer, units of 1/meter
    end
    %Want EXP(-Beta Mu) d/dx^2 [T * Exp[Beta Mu] ] = EXP(-Beta Mu) 1/2x d/dx [T * Exp[Beta Mu] ]
    if isempty(KProfile)
        localTransfer=-deriv'./pixelCenterForDeriv/pixelToMeter/2.*expFactorPos/ratioPolarizability/beta/.5/mNa/waxial^2;
    else
         localTransfer=-deriv'./pixelCenterForDeriv/pixelToMeter/2.*expFactorPos*(paramFit(5)*2.5e-6)^2;
       
    end
%     figure(3);imagesc(deriv);
%% plot 2 d spectra
    [x,y]=meshgrid(pixel(goodPixIdx),freq);

    plot2DMatrixWithSlider(x,y,sgf')


    figure(19);clf;
    subplot(1,4,1);
    
    s2=surf(x,y,transfer(:,goodPixIdx));
    ylim([-25 250]);
    xlim([min(pixel(goodPixIdx)) max(pixel(goodPixIdx))]);
    caxis([0 .6]);
    s2.EdgeColor='none';
    view(2);
    colormap(parula);
    colorbar;
    title('Transfer I(\omega)');

    subplot(1,4,2);
    s2=surf(x,y,sgf');
    ylim([-25 250]);
    xlim([min(pixel(goodPixIdx)) max(pixel(goodPixIdx))]);
    caxis([0 .6]);
    s2.EdgeColor='none';
    view(2);
    colormap(parula);
    colorbar;
    title('Filtered Transfer I(\omega)');

    subplot(1,4,3);
    s3=surf(x,y,sgfWithExp');
    ylim([-25 250]);
    xlim([min(pixel(goodPixIdx)) max(pixel(goodPixIdx))]);
    caxis([0 4]);
    s3.EdgeColor='none';
    view(2);
    colormap(parula);
    colorbar;
    title('Transfer with exp weight I(\omega)e^{\beta\mu_0 }');

    subplot(1,4,4);
    [x,y]=meshgrid(pixelCenterForDeriv,freq);
    s=surf(x,y,localTransfer);
    ylim([-25 250]);
    xlim([min(pixelCenterForDeriv) max(pixelCenterForDeriv)]);
    s.EdgeColor='none';
    view(2);
    colormap(parula);
    colorbar;
    caxis([0 1]);

    xlabel('Pixel, Axial');
    ylabel('Freq, kHz');
    title('Local Transfer ~ d( I e^{\beta\mu_0 })/dx^2');

    %% plot 1D spectra
    figure(18); clf;hold on
    centerTransfer=transfer(:,goodPixIdx);
    pixIdx=length(pixelCenterForDeriv):-ceil(length(pixelCenterForDeriv)/5):1;

    for idx=1:length(pixIdx)
        subplot(2,length(pixIdx),idx);
        hold on;
        plot(freq,localTransfer(:,pixIdx(idx)),'LineWidth',2);
        xlabel('\omega/2\pi');
        xlim([-25 125]);
%         ylim([0 10]);
        title(strcat('Axial coordinate (pix) = ',num2str(pixelCenter(pixIdx(idx)))));
        ylabel('Local transfer ~ d(I(\omega) e^{\beta\mu_0 })/dx^2');
        subplot(2,length(pixIdx),idx+length(pixIdx));
        plot(freq,centerTransfer(:,pixIdx(idx)),'Linewidth',2);
        ylim([0 .6]);
        xlim([-25 125]);
        ylabel('Old method, transfer I(\omega)');

    end
    LocalRFSpec = struct;
    LocalRFSpec.xPixGrid = x;
    LocalRFSpec.freqGrid = y;
    LocalRFSpec.localTransfer = localTransfer;
end