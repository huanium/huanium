function analysisSummary = analyzeRFSpectrumZY(RFSpec,analyzeIdx,varargin)
    p = inputParser;

    p.addParameter('plotting',true);
    p.addParameter('peakThresholdLeft',0.3);
    p.addParameter('peakThresholdRight',0.5);
    p.addParameter('contactThreshold',0.2);
    p.addParameter('lowcut',-5);
    
    p.parse(varargin{:});
    
    plotting  = p.Results.plotting;
    peakThresholdLeft  = p.Results.peakThresholdLeft;
    peakThresholdRight  = p.Results.peakThresholdRight;
    contactThreshold  = p.Results.contactThreshold;
    lowcut  = p.Results.lowcut;
    
    if(plotting)
        figure(613);
        clf;
    end
    numPlot = 1;
    for jdx = analyzeIdx
        fprintf('analyzing spectrum: %i/%i\n',numPlot,length(analyzeIdx));
        xvals = [];
        yvals = [];
        y_ci = [];
        y_ci_temp = [];
        y_ci_temp2 = [];
        
        xvals = RFSpec.xvals(jdx,:);
        yvals = RFSpec.yvals(jdx,:);
        
        nanMask = ~isnan(yvals);
        xvals = xvals(nanMask);
        yvals = yvals(nanMask);
        
        y_ci_temp(1,:) = RFSpec.y_ci(jdx,1,nanMask);
        y_ci_temp(2,:) = RFSpec.y_ci(jdx,2,nanMask);
        
        negMask = yvals>-1;
        xvals = xvals(negMask);
        yvals = yvals(negMask);
        y_ci_temp2(1,:) = y_ci_temp(1,negMask);
        y_ci_temp2(2,:) = y_ci_temp(2,negMask);
        
        
        posMask = yvals<2;
        xvals = xvals(posMask);
        yvals = yvals(posMask);
        y_ci(1,:) = y_ci_temp(1,posMask);
        y_ci(2,:) = y_ci_temp(2,posMask);
        
        % filter signal:
        samplingFreq = 1;
        cutoffFreq=0.005;
        w=2*pi*cutoffFreq;% convert to radians per second
        nyquivstFreq=samplingFreq/2; 
        order = 7; 

        [b14, a14]=butter(order,(w/nyquivstFreq),'low');
        lowPassfiltered=filtfilt(b14,a14,yvals);
        
        %ZY treat spurious filtered signals: if the maximum of the
        %lowPassfiltered comes at the first frequency, set yvals(1)=0 and
        %filter again
        
        [~,idxMaxFiltered]=max(lowPassfiltered);
        if idxMaxFiltered==1
            yvals(1)=0;
            lowPassfiltered=filtfilt(b14,a14,yvals);
            fprintf('Warning: yval(1) forced to 0.  Press a button to continue');
            waitforbuttonpress;
        end
        
        [maxYfiltered,maxYidxfiltered] = max(lowPassfiltered(:));
        
        % find central peak region from filtered data
        idxBelow = find(lowPassfiltered(:)<peakThresholdLeft*maxYfiltered);
        distance = maxYidxfiltered-idxBelow;
        posMask = distance>0;
        distance(~posMask)= NaN;
        [~,closestIdx]=min(distance);
        lowPeakCut = idxBelow(closestIdx);
        

        idxAbove = find(lowPassfiltered(:)<peakThresholdRight*maxYfiltered);
        distance = maxYidxfiltered-idxAbove;
        negMask = distance<0;
        distance(~negMask)= NaN;
        [~,closestIdx]=max(distance);
        highPeakCut = idxAbove(closestIdx);
        

        
        %fit Peak
        fitfun = @(p,x) p(4)+p(3)*x+p(2)*x.^2+p(1)*x.^3;
        parameterNames = {'a (x^3)','b (x^2)','c (x^1)','d (x^0)'};

        pGuess = [0.0000   -0.0009    0.0113    0.2370];
        lb = [-1,-1,-1,-1];
        ub = [1,1,1,1];
        mask = lowPeakCut:highPeakCut;
        if(sum(y_ci(2,mask)-y_ci(1,mask))==0)
            weighted_deviations = @(p) (fitfun(p,xvals(mask))-yvals(mask));
        else
            %avoid divide by zero!  sometimes ci range is zero, then bring it to the mean ci value.
            weights=max( ((y_ci(2,mask)-y_ci(1,mask))./2),mean(((y_ci(2,mask)-y_ci(1,mask))./2)));
            %weighted_deviations = @(p) (fitfun(p,xvals(mask))-yvals(mask))./((y_ci(2,mask)-y_ci(1,mask))./2);
            weighted_deviations = @(p) (fitfun(p,xvals(mask))-yvals(mask))./weights;

        end
        optio = optimoptions(@lsqnonlin,'Algorithm','trust-region-reflective','Display','off','MaxFunctionEvaluations',100);
        try
            [paramPeak,~,resid,~,~,~,J]=lsqnonlin(weighted_deviations,pGuess,lb,ub,optio);
        catch
            warning('paramPeak fit fails');
        end
        ciPeak = nlparci(paramPeak,resid,'jacobian',J);

        funEx1 = @(x) (-x(2)-sqrt((x(2).^2-3*x(1)*x(3))))/(3*x(1));
        funEx2 = @(x) (-x(2)+sqrt((x(2).^2-3*x(1)*x(3))))/(3*x(1));
        %check for bad fit parameters--> complex valued results
        if imag(funEx1(paramPeak(1:3)))~= 0 || imag(funEx2(paramPeak(1:3)))~= 0 
            fprintf('error: imaginary result detected. press a button to continue');
            waitforbuttonpress;
            funEx1 = @(x) (-x(2)-sqrt(abs((x(2).^2-3*x(1)*x(3)))))/(3*x(1));
            funEx2 = @(x) (-x(2)+sqrt(abs((x(2).^2-3*x(1)*x(3)))))/(3*x(1));
        end
        if(fitfun(paramPeak,funEx1(paramPeak(1:3)))>fitfun(paramPeak,funEx2(paramPeak(1:3))))
            peakValue(jdx) = fitfun(paramPeak,funEx1(paramPeak(1:3)));
            peakPos(jdx) = funEx1(paramPeak(1:3));
        else
            peakValue(jdx) = fitfun(paramPeak,funEx2(paramPeak(1:3)));
            peakPos(jdx) = funEx2(paramPeak(1:3));
        end
        if(plotting)
            fprintf('Peak Position: %.1f kHz \n',peakPos(jdx));
            dummyMeas = Measurement(' ');
        end

        
        %find closest to peak value that is below contact threshold
        idxAbove = find(lowPassfiltered(:)<contactThreshold);
        distance = maxYidxfiltered-idxAbove;
        negMask = distance<0;
        distance(~negMask)= NaN;
        [~,closestIdx]=max(distance);
        ContactCut = idxAbove(closestIdx);
        
        mask = ContactCut:length(xvals);

        fitfunContact = @(p,x) 0+p(1)*(x-0).^(-3/2);

        pGuess = [100];
        lb = [0];
        ub = [1000];
        parameterNames = {'Contact'};
        
        if(sum(y_ci(2,mask)-y_ci(1,mask))==0)
            weighted_deviations = @(p) (fitfunContact(p,xvals(mask))-yvals(mask));
        else
            weights=max( ((y_ci(2,mask)-y_ci(1,mask))./2),mean(((y_ci(2,mask)-y_ci(1,mask))./2)));
            %weighted_deviations = @(p) (fitfunContact(p,xvals(mask))-yvals(mask))./((y_ci(2,mask)-y_ci(1,mask))./2);
            weighted_deviations = @(p) (fitfunContact(p,xvals(mask))-yvals(mask))./weights;
        end
        optio = optimoptions(@lsqnonlin,'Algorithm','trust-region-reflective','Display','off','MaxFunctionEvaluations',100);
        try
            [paramContact,~,resid,~,~,~,J]=lsqnonlin(weighted_deviations,pGuess,lb,ub,optio);
        catch
            warning('paramContact fit fails');
        end
        ciContact = nlparci(paramContact,resid,'jacobian',J);
        if(plotting)
            dummyMeas.printFitReport(parameterNames,paramContact,ciContact)
        end
        %
        if(plotting)
            figure(123),clf;
            plot(xvals,lowPassfiltered)
            hold on
                plot(xvals(maxYidxfiltered),lowPassfiltered(maxYidxfiltered),'.','MarkerSize',20);
                plot(xvals(highPeakCut),lowPassfiltered(highPeakCut),'.','MarkerSize',20);
                plot(xvals(lowPeakCut),lowPassfiltered(lowPeakCut),'.','MarkerSize',20);
                plot(xvals(ContactCut),lowPassfiltered(ContactCut),'.','MarkerSize',20);
                plot(xvals,yvals,'.');
            hold off
        end
        
        if(plotting)
            figure(613);
            subplot(ceil(length(analyzeIdx)/3),3,numPlot)
           
            
            errorbar(xvals(:),yvals(:),(yvals(:)-squeeze(y_ci(1,:))'),(squeeze(y_ci(2,:))'-yvals(:)),'.','MarkerSize',20,'LineWidth',1.2,'CapSize',0)
            hold on
        
            plot(xvals(lowPeakCut:highPeakCut),fitfun(paramPeak,xvals(lowPeakCut:highPeakCut)),'LineWidth',2,'Color',[255,51,51]/255)
            sFitVals = xvals(ContactCut):0.1:xvals(end);
            plot(sFitVals,fitfunContact(paramContact,sFitVals),'LineWidth',2,'Color',[255,51,51]/255)

            hold off
            ylim([-0.1,0.8])
        end
        numPlot = numPlot+1;
        sFitVals = xvals(1):0.1:peakPos(jdx);
        
        leftWidth = peakPos(jdx)-interp1(fitfun(paramPeak,sFitVals),sFitVals,0.5*peakValue(jdx));
        sFitVals = 0.0001:0.1:xvals(end);
        rightWidth = interp1(fitfunContact(paramContact,sFitVals),sFitVals,0.5*peakValue(jdx))-peakPos(jdx);
        if(plotting)
            fprintf(['Left half width: ' num2str(leftWidth,2) ' kHz; Right half width: ' num2str(rightWidth,2) ' kHz\n']);
        end
        analysisSummary.maxShift.paramPeak(jdx,:) = paramPeak;
        analysisSummary.maxShift.ciPeak(jdx,:,:) = ciPeak';
        
        analysisSummary.Spec.peakPos(jdx) = peakPos(jdx);
        analysisSummary.Spec.peakValue(jdx) = peakValue(jdx);
        analysisSummary.Spec.leftWidth(jdx) = leftWidth;
        analysisSummary.Spec.rightWidth(jdx) = rightWidth;

        analysisSummary.Contact.paramContact(jdx,:) = paramContact;
        analysisSummary.Contact.ciContact(jdx,:,:) = ciContact';

        
        xlim([-100,350])
        drawnow
    end
end