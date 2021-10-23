function analysisSummary = analyzeRFSpectrum(RFSpec,analyzeIdx,varargin)
    p = inputParser;

    p.addParameter('plotting',true);
    p.addParameter('peakThresholdLeft',0.4);
    p.addParameter('peakThresholdRight',0.6);
    p.addParameter('contactThreshold',0.2);
    p.addParameter('peakFinder',1);
    
    p.parse(varargin{:});
    
    plotting  = p.Results.plotting;
    peakThresholdLeft  = p.Results.peakThresholdLeft;
    peakThresholdRight  = p.Results.peakThresholdRight;
    contactThreshold  = p.Results.contactThreshold;
    peakFinder  = p.Results.peakFinder;
    
    
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
        
        negMask = yvals>-0.5;
        xvals = xvals(negMask);
        yvals = yvals(negMask);
        y_ci_temp2(1,:) = y_ci_temp(1,negMask);
        y_ci_temp2(2,:) = y_ci_temp(2,negMask);
        
        
        posMask = yvals<1;
        xvals = xvals(posMask);
        yvals = yvals(posMask);
        y_ci(1,:) = y_ci_temp(1,posMask);
        y_ci(2,:) = y_ci_temp(2,posMask);
        
        % filter signal:
        samplingFreq = 1;
        cutoffFreq=0.007;
        w=2*pi*cutoffFreq;% convert to radians per second
        nyquivstFreq=samplingFreq/2; 
        order = 7; 

        [b14, a14]=butter(order,(w/nyquivstFreq),'low');
        lowPassfiltered=filtfilt(b14,a14,[0,0,0,0,0,yvals,0,0,0,0,0]);
        lowPassfiltered = lowPassfiltered(6:end-5);
        mask = find(xvals>-5);

        [maxYfiltered,maxYidxfiltered] = max(lowPassfiltered(mask));
        
        maxYidxfiltered = maxYidxfiltered + length(xvals)-length(mask);
        
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
        
        if peakFinder==3
            %fit Peak
            fitfun = @(p,x) 10^(-1)*p(4)+10^(-2)*p(3)*x+10^(-3)*p(2)*x.^2+10^(-5)*p(1)*x.^3;
            parameterNames = {'a (x^3)','b (x^2)','c (x^1)','d (x^0)'};

            pGuess = [5   -2.8    3    2];
            lb = [0,-100,-100,-100];
            ub = [100,100,100,100];
            mask = lowPeakCut:highPeakCut;
            if(length(mask)<10)
                mask = maxYidxfiltered-10:maxYidxfiltered+20;
            end
            %Update
            weights=(y_ci(2,mask)-y_ci(1,mask))/2;
            [~,zeroCIidx]=find(weights==0);
            weights(zeroCIidx)=mean(weights);
            weighted_deviations = @(p) (fitfun(p,xvals(mask))-yvals(mask))./weights;

            
            optio = optimoptions(@lsqnonlin,'Algorithm','trust-region-reflective','Display','off','MaxFunctionEvaluations',100);
            
            [paramPeak,~,resid,~,~,~,J]=lsqnonlin(weighted_deviations,pGuess,lb,ub,optio);
           

            ciPeak = nlparci(paramPeak,resid,'jacobian',J);

            funEx1 = @(x) (-x(2)/10^3-sqrt(((x(2)/10^3).^2-3*x(1)/10^5*x(3)/10^2)))/(3*x(1)/10^5);
            funEx2 = @(x) (-x(2)/10^3+sqrt(((x(2)/10^3).^2-3*x(1)/10^5*x(3)/10^2)))/(3*x(1)/10^5);

            if(fitfun(paramPeak,funEx1(paramPeak(1:3)))>fitfun(paramPeak,funEx2(paramPeak(1:3))))
                peakValue(jdx) = fitfun(paramPeak,funEx1(paramPeak(1:3)));
                peakPos(jdx) = funEx1(paramPeak(1:3));
            else
                peakValue(jdx) = fitfun(paramPeak,funEx2(paramPeak(1:3)));
                peakPos(jdx) = funEx2(paramPeak(1:3));
            end

            if(~isreal(peakValue))
                peakValue(jdx) = maxYfiltered;
                peakPos(jdx) = maxYidxfiltered;
            end
            
        elseif(peakFinder ==2)
            fitfun = @(p,x) p(3)+p(2).*(p(1)-x).^2;
            parameterNames = {'Peak Pos','slope','peakHeight'};

            pGuess = [xvals(maxYidxfiltered),-1,maxYfiltered];
            lb = [0,-100,0];
            ub = [100,0,1];
            mask = lowPeakCut:highPeakCut;
            if(length(mask)<10)
                mask = maxYidxfiltered-10:maxYidxfiltered+20;
            end
            
            %Update
            weights=(y_ci(2,mask)-y_ci(1,mask))/2;
            [~,zeroCIidx]=find(weights==0);
            weights(zeroCIidx)=mean(weights);
            weighted_deviations = @(p) (fitfun(p,xvals(mask))-yvals(mask))./weights;
            
            optio = optimoptions(@lsqnonlin,'Algorithm','trust-region-reflective','Display','off','MaxFunctionEvaluations',100);
            
            [paramPeak,~,resid,~,~,~,J]=lsqnonlin(weighted_deviations,pGuess,lb,ub,optio);
            
            peakValue(jdx) = paramPeak(3);
            peakPos(jdx) = paramPeak(1);
            ciPeak = nlparci(paramPeak,resid,'jacobian',J);
        elseif(peakFinder ==1)
            
            fitfun = @(p,x) p(4)+heaviside(p(1)-x).*p(2).*(p(1)-x).^2+heaviside(x-p(1)).*p(3).*(p(1)-x).^2;
            parameterNames = {'Peak Pos','slope1','slope2','peakHeight'};

            pGuess = [xvals(maxYidxfiltered),-0.005,-0.001,maxYfiltered];
            lb = [0,-100,-100,0];
            ub = [100,0,0,1];
            mask = lowPeakCut:highPeakCut;
            if(length(mask)<10)
                mask = maxYidxfiltered-10:maxYidxfiltered+20;
            end
            
           
            %Update
            weights=(y_ci(2,mask)-y_ci(1,mask))/2;
            [~,zeroCIidx]=find(weights==0);
            weights(zeroCIidx)=mean(weights);
            weighted_deviations = @(p) (fitfun(p,xvals(mask))-yvals(mask))./weights;                
%             if(sum(y_ci(2,mask)-y_ci(1,mask)==0))
%                 weighted_deviations = @(p) (fitfun(p,xvals(mask))-yvals(mask));
%             else
%                 weighted_deviations = @(p) (fitfun(p,xvals(mask))-yvals(mask))./((y_ci(2,mask)-y_ci(1,mask))./2);
%             end
            optio = optimoptions(@lsqnonlin,'Algorithm','trust-region-reflective','Display','off','MaxFunctionEvaluations',100);
            
            [paramPeak,~,resid,~,~,~,J]=lsqnonlin(weighted_deviations,pGuess,lb,ub,optio);
            
            peakValue(jdx) = paramPeak(4);
            peakPos(jdx) = paramPeak(1);
            ciPeak = nlparci(paramPeak,resid,'jacobian',J);
            
        else
            error('peakfinder only supports quadratic fit (choose 2), qubic fit (choose 3), or hybrid quadratic (choose 1)');
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

        fitfunContact = @(p,x) p(2)+p(1)*(x-0).^(-3/2);

        pGuess = [0.5*peakPos(jdx),0];
        lb = [0,-0.1];
        ub = [1000,0.1];
        parameterNames = {'Contact'};
        
        if(sum(y_ci(2,mask)-y_ci(1,mask)==0))
            weighted_deviations = @(p) (fitfunContact(p,xvals(mask))-yvals(mask));
        else
            weighted_deviations = @(p) (fitfunContact(p,xvals(mask))-yvals(mask))./((y_ci(2,mask)-y_ci(1,mask))./2);
        end
        optio = optimoptions(@lsqnonlin,'Algorithm','trust-region-reflective','Display','off','MaxFunctionEvaluations',100);
        [paramContact,~,resid,~,~,~,J]=lsqnonlin(weighted_deviations,pGuess,lb,ub,optio);
        
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
        try
            leftWidth = peakPos(jdx)-interp1(fitfun(paramPeak,sFitVals),sFitVals,0.5*peakValue(jdx));
        catch
            leftWidth = 0;
        end
        sFitVals = 0.0001:0.1:xvals(end);
        try
            rightWidth = interp1(fitfunContact(paramContact,sFitVals),sFitVals,0.5*peakValue(jdx))-peakPos(jdx);
        catch
            rightWidth = 0;
        end
        if(isnan(rightWidth))
            rightWidth = 0;
        end
        if(plotting)
            fprintf(['Left half width: ' num2str(leftWidth,2) ' kHz; Right half width: ' num2str(rightWidth,2) ' kHz\n']);
        end
        analysisSummary.maxShift.paramPeak(jdx,:) = paramPeak;
        analysisSummary.maxShift.ciPeak(jdx,:,:) = ciPeak';
        
        analysisSummary.Spec.peakPos(jdx) = peakPos(jdx);
        analysisSummary.Spec.peakValue(jdx) = peakValue(jdx);
        analysisSummary.Spec.leftWidth(jdx) = leftWidth;
        analysisSummary.Spec.rightWidth(jdx) = rightWidth;

        analysisSummary.Contact.paramContact(jdx,:) = paramContact(1);
        analysisSummary.Contact.ciContact(jdx,:,:) = ciContact';

        
        xlim([-100,350])
        drawnow
    end
end