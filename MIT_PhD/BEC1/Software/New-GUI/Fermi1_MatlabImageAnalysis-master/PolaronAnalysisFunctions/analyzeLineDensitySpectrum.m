function analysisSummary = analyzeLineDensitySpectrum(ejectionData,varargin)
    p = inputParser;
    p.addParameter('plotting',true);
    p.addParameter('peakThresholdLeft',0.6);
    p.addParameter('peakThresholdRight',0.6);
    p.addParameter('contactThreshold',0.25);
    p.addParameter('contactNoiseFloorInUnitsOfPeak',4);
    p.addParameter('contactNoiseFloorMinInkHz',40);
    p.addParameter('pauseEachRun',false);
    p.addParameter('a_scat',[0 0]); %initial and final state scattering length, meter
    p.addParameter('bimodalSpectrum',false);
    p.parse(varargin{:});
    
    plotting            = p.Results.plotting;
    peakThresholdLeft   = p.Results.peakThresholdLeft;
    peakThresholdRight  = p.Results.peakThresholdRight;
    contactThreshold    = p.Results.contactThreshold;
    contactNoiseFloorInUnitsOfPeak   = p.Results.contactNoiseFloorInUnitsOfPeak;
    contactNoiseFloorMinInkHz   = p.Results.contactNoiseFloorMinInkHz;
    pauseEachRun        = p.Results.pauseEachRun;
    a_scat              = p.Results.a_scat;
    bimodalSpectrum     = p.Results.bimodalSpectrum;
    atomicSigma         = 2.5; %kHz, gaussian width ~exp(-f^2/atomicSigma^2)
    pregrouped = true;
    if(~isfield(ejectionData,'groupedInjectionCorrectedScaledTransfer'))
        pregrouped = false;
        ejectionData.groupedInjectionCorrectedScaledTransfer = ejectionData.injectionCorrectedScaledTransfer;
        ejectionData.groupedFreqMesh = ejectionData.FreqMesh;
        ejectionData.groupedPixelMesh = ejectionData.PixelMesh;
    end    
    
    [numFreq,numPixel] = size(ejectionData.groupedInjectionCorrectedScaledTransfer());
    
    if(plotting)
        figure(125);
        clf;
    end
    numPlot = 1;
    
    if pregrouped
        maxIdx = numPixel;
    else
        maxIdx = numPixel/2;
    end
    if bimodalSpectrum
        figure(667);clf;hold on;
    end
    for jdx = 1:maxIdx
        if pregrouped
            selectedPixel = jdx;
        else
            selectedPixel = [jdx,numPixel-(jdx-1)];
        end
        xvals = ejectionData.groupedFreqMesh(:,jdx)';
        yvals = sum(ejectionData.groupedInjectionCorrectedScaledTransfer(:,selectedPixel),2)'/length(selectedPixel);
        if bimodalSpectrum %special case of bimodal hump, want to suppress the atomic peak
            figure(667);
            subplot(ceil(sqrt(maxIdx)),floor(sqrt(maxIdx)),jdx);hold on;
            plot(xvals,yvals);
            xlim([-10 30]);
            subtractGaussIdx=find(xvals<atomicSigma);
            funGauss=@(p,x) p*exp(-x.^2/atomicSigma^2);
            opts = optimset('Display','off');
            pGaussParam=lsqcurvefit(funGauss,max(yvals(subtractGaussIdx)),xvals(subtractGaussIdx),yvals(subtractGaussIdx),...
                0,1,opts);
            title(num2str(pGaussParam,3));
%             forceDownNeg=find(xvals>-4 &xvals<=0);
%             yvals(forceDown)=yvals(forceDown).*(-jdx/(maxIdx-1)+maxIdx/(maxIdx-1));
%             yvals(subtractGaussIdx)=yvals(subtractGaussIdx)-(jdx-1)/(maxIdx-1)*funGauss(pGaussParam,xvals(subtractGaussIdx));
            if pGaussParam <= 0.5  
                posAtomic=find(xvals < sqrt(2)*atomicSigma  & xvals > 0);
                negAtomic=find(xvals > -sqrt(2)*atomicSigma  & xvals < 0);

                yvals(negAtomic)=yvals(negAtomic)-funGauss(pGaussParam,xvals(negAtomic));
                oldyvalsPosAtomic=yvals(posAtomic);
                yvals(posAtomic)=NaN;
                [xvals,yvals]=prepareCurveData(xvals,yvals);
                xvals=xvals';
                yvals=yvals';
                
            end
%             yvals(forceDownNeg)=yvals(forceDownNeg).*(-jdx/(maxIdx-1)+maxIdx/(maxIdx-1));
%             yvals(forceDown)=0;
%             yvals(forceDownNeg)=0;
            plot(xvals,yvals,'o','MarkerFaceColor','b');shg;
%             waitforbuttonpress
        end
        
        % filter spectrum for starting parameter:
        samplingFreq = 1;
        cutoffFreq=0.01;%0.007;
        w=2*pi*cutoffFreq;% convert to radians per second
        nyquivstFreq=samplingFreq/2; 
        order = 7; 

        [b14, a14]=butter(order,(w/nyquivstFreq),'low');
        lowPassfiltered=filtfilt(b14,a14,[0,0,0,0,0,yvals,0,0,0,0,0]);
        lowPassfiltered = lowPassfiltered(6:end-5);
        mask = find(xvals>-20);

        [maxYfiltered,maxYidxfiltered] = max(lowPassfiltered(mask));
        maxYidxfiltered = maxYidxfiltered + length(xvals)-length(mask);
        
        % find central peak region from filtered data
        idxBelow = find(lowPassfiltered(:)<peakThresholdLeft*maxYfiltered);
        distance = maxYidxfiltered-idxBelow;
        posMask = distance>0;
        distance(~posMask)= NaN;
        [~,closestIdx]=min(distance);
        lowPeakCut = idxBelow(closestIdx);
        lowPeakCutFreq = xvals(lowPeakCut);
        

        idxAbove = find(lowPassfiltered(:)<peakThresholdRight*maxYfiltered);
        distance = maxYidxfiltered-idxAbove;
        negMask = distance<0;
        distance(~negMask)= NaN;
        [~,closestIdx]=max(distance);
        highPeakCut = idxAbove(closestIdx);
        highPeakCutFreq = xvals(highPeakCut);
        if isempty(highPeakCutFreq)
            highPeakCutFreq=contactNoiseFloorMinInkHz;
        end
        if(sum(isnan(distance))==length(distance))
            highPeakCutFreq=contactNoiseFloorMinInkHz;
        end
        
        partfun = @(p,x) 2*p(2)./(1+exp(p(4).*(x-p(3))));             
        fitfun = @(p,x) p(1)./partfun(p,x).*exp(-4*log(2)*(2*((x-p(3))./partfun(p,x)).^2));
        parameterNames = {'amp','sigma','peakPos','asym'};
        
        minSigma = 10;
        pGuess  = [max(abs(xvals(maxYidxfiltered))/2,minSigma)/3*2.2 max(abs(xvals(maxYidxfiltered))/2,minSigma)  xvals(maxYidxfiltered) -0.01*max(abs(xvals(maxYidxfiltered))/2,3)];
        lb      = [ 0   0,  -50, -0.1];
        ub      = [150 40,  100, 0];
        
        if(isempty(lowPeakCutFreq)||isempty(highPeakCutFreq))
            peakMask = find(xvals>xvals(maxYidxfiltered)-5 & xvals<xvals(maxYidxfiltered)+5);
        else
            peakMask = find(xvals>lowPeakCutFreq-2 & xvals<highPeakCutFreq+2);
        end
        mask2 = find(xvals>xvals(maxYidxfiltered)-3 & xvals<xvals(maxYidxfiltered)+3);
        if(length(mask2)>length(peakMask))
            peakMask = mask2;
        end
        if length(peakMask)<length(pGuess)
            peakMask=find(abs(xvals)<5);
        end
        weighted_deviations = @(p) (fitfun(p,xvals(peakMask))-yvals(peakMask));
        
        optio = optimoptions(@lsqnonlin,'Algorithm','trust-region-reflective','Display','off','MaxFunctionEvaluations',100);
       [paramPeak,~,resid,~,~,~,J]=lsqnonlin(weighted_deviations,pGuess,lb,ub,optio);
      
        try
            ciPeak = nlparci(paramPeak,resid,'jacobian',J);
        catch
            ciPeak = [NaN;NaN];
        end
        
        valsforPeak = xvals(1):0.001:xvals(end);
        
        [fittedPeakValue,fittedPeakIdx] = max(fitfun(paramPeak,valsforPeak));
        
        peakValue(jdx) = fittedPeakValue;
        peakPos(jdx) = valsforPeak(fittedPeakIdx);
        
        if plotting
            dummyMeas = Measurement(' ');
            dummyMeas.printFitReport(parameterNames,paramPeak,ciPeak)
            
            figure(124),clf;
            plot(xvals,yvals,'.');
            hold on
            plot(xvals,lowPassfiltered,'LineWidth',2);
            plot(xvals(maxYidxfiltered),lowPassfiltered(maxYidxfiltered),'.','MarkerSize',20);
            plot(xvals(highPeakCut),lowPassfiltered(highPeakCut),'.','MarkerSize',20);
            plot(xvals(lowPeakCut),lowPassfiltered(lowPeakCut),'.','MarkerSize',20);
            plot(valsforPeak,fitfun(paramPeak,valsforPeak),'LineWidth',2);
            hold off
        end

        %Guess peak position for width fitting and contact fitting
        peakPosG(jdx)=max(peakPos(jdx),0);
        if(plotting)
            fprintf('Peak Position: %.1f kHz \n',peakPos(jdx));
            dummyMeas = Measurement(' ');
        end
        
        %% width
        if bimodalSpectrum & pGaussParam <= 0.5 
            %return yvals to original values
            yvals(negAtomic)=yvals(negAtomic)+funGauss(pGaussParam,xvals(negAtomic));
            yvals(posAtomic)=oldyvalsPosAtomic;
        end
        valsforPeak = xvals(1):0.1:xvals(end);
        fitFunYvals = fitfun(paramPeak,valsforPeak);
        [fittedPeakValue,fittedPeakIdx] = max(fitFunYvals);
        
        pGuess  = [  paramPeak(1) paramPeak(2)  paramPeak(3) paramPeak(4)];
                
        peakMask = find(xvals>-15 & xvals<valsforPeak(fittedPeakIdx)+10);
        mask2 = find(xvals>xvals(maxYidxfiltered)-5 & xvals<xvals(maxYidxfiltered)+5);
        if(length(mask2)>length(peakMask))
            peakMask = mask2;
        end
        
        weighted_deviations = @(p) (fitfun(p,xvals(peakMask))-yvals(peakMask));
        optio = optimoptions(@lsqnonlin,'Algorithm','trust-region-reflective','Display','off','MaxFunctionEvaluations',100);
        [paramPeakL,~,resid,~,~,~,J]=lsqnonlin(weighted_deviations,pGuess,lb,ub,optio);
        
        [fittedPeakValue,fittedPeakIdx] = max(fitfun(paramPeakL,valsforPeak));
        
        peakValue(jdx) = fittedPeakValue;
        peakPos(jdx) = valsforPeak(fittedPeakIdx);
        
        fitFunYvals = fitfun(paramPeakL,valsforPeak);
        zeroMask1 = find(fitFunYvals(1:fittedPeakIdx)>0.01);
        if isempty(zeroMask1)
            display('huh' );
        end
        sortedYvalsAveraged = fliplr(sort(yvals));
        maxYAveraged = median(sortedYvalsAveraged(1:3));
        try
            leftWidth = peakPos(jdx)-interp1(fitFunYvals(zeroMask1),valsforPeak(zeroMask1),0.5*maxYAveraged);
        catch
            leftWidth=0;
            display('Warning! Left width = 0');

        end
     
        if plotting
            dummyMeas = Measurement(' ');
            dummyMeas.printFitReport(parameterNames,paramPeakL,ciPeak)
            
            figure(1123),clf;
            plot(xvals,yvals,'.');
            hold on
            plot(xvals,lowPassfiltered,'LineWidth',2);
            plot(xvals(maxYidxfiltered),lowPassfiltered(maxYidxfiltered),'.','MarkerSize',20);
            plot(xvals(highPeakCut),lowPassfiltered(highPeakCut),'.','MarkerSize',20);
            plot(xvals(lowPeakCut),lowPassfiltered(lowPeakCut),'.','MarkerSize',20);
            plot(valsforPeak,fitfun(paramPeakL,valsforPeak),'LineWidth',2);
            plot([peakPos(jdx)-leftWidth,peakPos(jdx)-leftWidth],[0,0.8],'k--','LineWidth',1.5);
            hold off
        end
        
        pGuess  = [  paramPeak(1) paramPeak(2)  paramPeak(3) paramPeak(4)];
        lb      = [ 0 0,  -50, -1];
        ub      = [   150 150, 50, 0];
        
        
        peakMask = find(xvals>valsforPeak(fittedPeakIdx)-15 & xvals<highPeakCutFreq+3);
        mask2 = find(xvals>xvals(maxYidxfiltered)-5 & xvals<highPeakCutFreq);
        if(length(mask2)>length(peakMask))
            peakMask = mask2;
        end
        if length(peakMask)<length(pGuess)
            peakMask=find(abs(xvals)<5)
        end
        weighted_deviations = @(p) (fitfun(p,xvals(peakMask))-yvals(peakMask));
        optio = optimoptions(@lsqnonlin,'Algorithm','trust-region-reflective','Display','off','MaxFunctionEvaluations',100);
        [paramPeakR,~,resid,~,~,~,J]=lsqnonlin(weighted_deviations,pGuess,lb,ub,optio);
        
        fitFunYvals = fitfun(paramPeakR,valsforPeak);
        zeroMask2 = find(fitFunYvals(fittedPeakIdx:end)>0.001);
        try
        rightWidth = interp1(fitFunYvals(fittedPeakIdx-1+zeroMask2),valsforPeak(fittedPeakIdx-1+zeroMask2),0.5*maxYAveraged)-peakPos(jdx);
        catch
            rightWidth=0;
            display('Warning! Right width = 0');
        end
        if isnan(rightWidth)
            [~ ,tempIdx] = max(fitfun(paramPeakR,valsforPeak));
            rightWidth = valsforPeak(tempIdx);
        end
        
        if isnan(leftWidth)
            [~ ,tempIdx] = max(fitfun(paramPeak,valsforPeak));
            leftWidth = valsforPeak(tempIdx);
        end
        FWHM = rightWidth+leftWidth;
        if plotting
            dummyMeas = Measurement(' ');
            dummyMeas.printFitReport(parameterNames,paramPeakR,ciPeak)
            
            figure(1124),clf;
            plot(xvals,yvals,'.');
            hold on
            plot(xvals,lowPassfiltered,'LineWidth',2);
            plot(xvals(maxYidxfiltered),lowPassfiltered(maxYidxfiltered),'.','MarkerSize',20);
            plot(xvals(highPeakCut),lowPassfiltered(highPeakCut),'.','MarkerSize',20);
            plot(xvals(lowPeakCut),lowPassfiltered(lowPeakCut),'.','MarkerSize',20);
            plot(valsforPeak,fitfun(paramPeakR,valsforPeak),'LineWidth',2);
            plot([peakPos(jdx)+rightWidth,peakPos(jdx)+rightWidth],[0,0.8],'k--','LineWidth',1.5);
            hold off
        end
        
        %% Contact
        
        valsforPeak = xvals(1):0.1:xvals(end);
        fitFunYvals = fitfun(paramPeak,valsforPeak);
        [~,fittedPeakIdx] = max(fitFunYvals);
        
        contactEndFreq = max(contactNoiseFloorMinInkHz,peakPos(jdx)*(contactNoiseFloorInUnitsOfPeak+1));
        
        %contactIdx = fittedPeakIdx-1+find(fitFunYvals(fittedPeakIdx:end)<contactThreshold & valsforPeak(fittedPeakIdx:end)<contactNoiseFloor);
        contactIdx = fittedPeakIdx-1+find(fitFunYvals(fittedPeakIdx:end)<contactThreshold & valsforPeak(fittedPeakIdx:end)<contactEndFreq);
        newThres=contactThreshold;
        while isempty(contactIdx)
            newThres=newThres+0.1;
            contactIdx = fittedPeakIdx-1+find(fitFunYvals(fittedPeakIdx:end)<newThres & valsforPeak(fittedPeakIdx:end)<contactEndFreq);
            display('Warning!  no points for contact fit, increasing contact threshold by 0.1');
        end
        try
           maskContact = find(xvals>0 & xvals>valsforPeak(contactIdx(1)) & xvals<valsforPeak(contactIdx(end)));
        catch
            display('huh?') 
        end
        
        
        fitfunContact = @(p,x) p(1)*(x-0).^(-3/2);
        %%Include final state interactions if the option was chosen
        if abs(a_scat(1))>0
            fitfunContact = @(p,x) p(1)*x.^(-3/2)*(a_scat(1)^-1-a_scat(2)^-1)^2./(a_scat(2)^-2+2*mReduced/hbar*x*1000);
        end
        
        pGuess = [0.5*abs(peakPos(jdx))];
        lb = [0];
        ub = [1000];
        parameterNames = {'Contact'};
        
        weighted_deviations = @(p) (fitfunContact(p,xvals(maskContact))-yvals(maskContact));
        
        optio = optimoptions(@lsqnonlin,'Algorithm','trust-region-reflective','Display','off','MaxFunctionEvaluations',100);
        try
            [paramContact,~,resid,~,~,~,J]=lsqnonlin(weighted_deviations,pGuess,lb,ub,optio);
        catch
            display('here' );
        end
        
        try
            ciContact = nlparci(paramContact,resid,'jacobian',J);
        catch
            ciContact = [NaN;NaN];
        end
        if(plotting)
            %dummyMeas.printFitReport(parameterNames,paramContact,ciContact)
            
            figure(123),clf;
            plot(xvals,yvals,'.');
            hold on
            plot(xvals,lowPassfiltered,'LineWidth',2);
            plot(xvals(maxYidxfiltered),lowPassfiltered(maxYidxfiltered),'.','MarkerSize',20);
            plot(xvals(highPeakCut),lowPassfiltered(highPeakCut),'.','MarkerSize',20);
            
            plot([valsforPeak(contactIdx(1)),valsforPeak(contactIdx(1))],[0,0.8],'k--','LineWidth',1.5);
            plot([valsforPeak(contactIdx(end)),valsforPeak(contactIdx(end))],[0,0.8],'k--','LineWidth',1.5);
            
            selectedXvals = valsforPeak(contactIdx(1)):0.01:valsforPeak(contactIdx(end));
            plot(selectedXvals,fitfunContact(paramContact,selectedXvals),'LineWidth',2)
            
            hold off
        end
        
        %% plotting and saving
        %
        if(plotting)
            figure(125);
            subplot(ceil(maxIdx/3),3,numPlot)
            plot(xvals,yvals,'.');
            hold on
            selectedXvals = min(xvals(peakMask)):0.1:max(xvals(peakMask));
            plot(selectedXvals,fitfun(paramPeak,selectedXvals),'LineWidth',2,'Color',[255,51,51]/255);
            
                selectedXvals = valsforPeak(contactIdx(1)):0.01:valsforPeak(contactIdx(end));
                plot(selectedXvals,fitfunContact(paramContact,selectedXvals),'LineWidth',2,'Color',[255,51,51]/255)
            

            hold off
            ylim([-0.1,0.8])
        end
        numPlot = numPlot+1;
        
        if(plotting)
            fprintf(['Left half width: ' num2str(leftWidth,2) ' kHz; Right half width: ' num2str(rightWidth,2) ' kHz\n']);
        end
        analysisSummary.maxShift.paramPeak(jdx,:) = paramPeak;
        analysisSummary.maxShift.ciPeak(jdx,:,:) = ciPeak';
        
        analysisSummary.Spec.peakPos(jdx) = peakPos(jdx);
        analysisSummary.Spec.peakValue(jdx) = peakValue(jdx);
        analysisSummary.Spec.leftWidth(jdx) = leftWidth;
        analysisSummary.Spec.rightWidth(jdx) = rightWidth;
        analysisSummary.Spec.FWHM(jdx) = FWHM;
        try
            analysisSummary.Contact.paramContact(jdx,:) = paramContact(1);
            analysisSummary.Contact.ciContact(jdx,:,:) = ciContact';
       catch
            analysisSummary.Contact.paramContact(jdx,:) = 0;
            analysisSummary.Contact.ciContact(jdx,:,:) = NaN;
            display('Aborting contact analysis');
        end

%         xlim([-100,350])
        
        if(pauseEachRun)
            waitforbuttonpress;
        end
        drawnow
        
        
    end
    
end