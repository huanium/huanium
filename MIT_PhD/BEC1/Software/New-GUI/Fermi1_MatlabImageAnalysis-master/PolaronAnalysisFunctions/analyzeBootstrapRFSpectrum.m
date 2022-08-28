function analysisSummary = analyzeBootstrapRFSpectrum(RFSpec,analyzeIdx,varargin)
    p = inputParser;
    
    p.addParameter('spectrum','ejection');
    p.addParameter('plotting',true);
    p.addParameter('peakThresholdLeft',0.2);
    p.addParameter('peakThresholdRight',0.3);
    p.addParameter('contactThreshold',0.15);
    p.addParameter('contactNoiseFloor',150);
    p.addParameter('peakFinder',4);
    p.addParameter('pauseEachRun',false);
    p.addParameter('a_scat',[0 0]); %initial and final state scattering length, meter
    
    p.parse(varargin{:});
    
    spectrum            = p.Results.spectrum;
    plotting            = p.Results.plotting;
    peakThresholdLeft   = p.Results.peakThresholdLeft;
    peakThresholdRight  = p.Results.peakThresholdRight;
    contactThreshold    = p.Results.contactThreshold;
    contactNoiseFloor   = p.Results.contactNoiseFloor;
    peakFinder          = p.Results.peakFinder;
    pauseEachRun        = p.Results.pauseEachRun;
    a_scat              = p.Results.a_scat;
    
    if(plotting)
        figure(125);
        clf;
    end
    numPlot = 1;
    for jdx = analyzeIdx
        %fprintf('analyzing spectrum: %i/%i\n',numPlot,length(analyzeIdx));
        xvals = [];
        yvals = [];
        y_ci = [];
        y_ci_temp = [];
        y_ci_temp2 = [];
        
        xvals = real(RFSpec.xvals(jdx,:));
        yvals = real(RFSpec.yvals(jdx,:));
        
        nanMask = ~isnan(yvals);
        xvals = xvals(nanMask);
        yvals = yvals(nanMask);
        
        y_ci_temp(1,:) = real(RFSpec.y_ci(jdx,1,nanMask));
        y_ci_temp(2,:) = real(RFSpec.y_ci(jdx,2,nanMask));
        
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
        
        
        uniqueFreq = unique(xvals);
        xvalsAveraged = zeros(1,length(uniqueFreq));
        yvalsAveraged = zeros(1,length(uniqueFreq));
        yStdAveraged  = zeros(1,length(uniqueFreq));
        y_ciAveraged  = zeros(2,length(uniqueFreq));
        for idx = 1:length(uniqueFreq)
            xvalsAveraged(idx) = uniqueFreq(idx);
            valuesIdx = find(xvals(:)==uniqueFreq(idx));
            yvalsAveraged(idx) = mean(yvals(valuesIdx));
            stdError = std(yvals(valuesIdx))/sqrt(length(yvals(valuesIdx)));
            if(stdError>0)
                yStdAveraged(idx) = stdError;
            else
                yStdAveraged(idx) = 0.3;
            end
            
        end
        y_ciAveraged(1,:) = yvalsAveraged-yStdAveraged;
        y_ciAveraged(2,:) = yvalsAveraged+yStdAveraged;
        
        
        % filter signal:
        samplingFreq = 1;
        cutoffFreq=0.01;%0.007;
        w=2*pi*cutoffFreq;% convert to radians per second
        nyquivstFreq=samplingFreq/2; 
        order = 7; 

        [b14, a14]=butter(order,(w/nyquivstFreq),'low');
        lowPassfiltered=filtfilt(b14,a14,[0,0,0,0,0,yvalsAveraged,0,0,0,0,0]);
        lowPassfiltered = lowPassfiltered(6:end-5);
        mask = find(xvalsAveraged>-20);

        [maxYfiltered,maxYidxfiltered] = max(lowPassfiltered(mask));
        maxYidxfiltered = maxYidxfiltered + length(xvalsAveraged)-length(mask);
        %maxYfiltered = yvalsAveraged(maxYidxfiltered);
        
        
        % find central peak region from filtered data
        idxBelow = find(lowPassfiltered(:)<peakThresholdLeft*maxYfiltered);
        distance = maxYidxfiltered-idxBelow;
        posMask = distance>0;
        distance(~posMask)= NaN;
        [~,closestIdx]=min(distance);
        lowPeakCut = idxBelow(closestIdx);
        lowPeakCutFreq = xvalsAveraged(lowPeakCut);
        

        idxAbove = find(lowPassfiltered(:)<peakThresholdRight*maxYfiltered);
        distance = maxYidxfiltered-idxAbove;
        negMask = distance<0;
        distance(~negMask)= NaN;
        [~,closestIdx]=max(distance);
        highPeakCut = idxAbove(closestIdx);
        highPeakCutFreq = xvalsAveraged(highPeakCut);
        if isempty(highPeakCutFreq)
            highPeakCutFreq=contactNoiseFloor;
        end
        if(sum(isnan(distance))==length(distance))
            highPeakCutFreq=contactNoiseFloor;
        end
        
        if peakFinder==4
            % fancy fitting
            %fitfun = @(p,x) p(1)+p(2)*heaviside(x - p(3) - p(4)).*(x - p(3) - p(4)).^p(5)./(x - p(3)).^p(6);
            %parameterNames = {'offset','amp','peak1','peak2','exponent','exponent2' };

            %pGuess  = [  0   1     xvalsAveraged(maxYidxfiltered)/2  abs(xvalsAveraged(maxYidxfiltered))/2,0.5,.5];
            %lb      = [ 0 0,    -50, 0,0.01,0.01];
            %ub      = [  0 inf, 50, 100,5,5];
            
            partfun = @(p,x) 2*p(2)./(1+exp(p(4).*(x-p(3))));             
            fitfun = @(p,x) p(1)./partfun(p,x).*exp(-4*log(2)*(2*((x-p(3))./partfun(p,x)).^2));
            parameterNames = {'amp','sigma 1','peakPos','asym'};
            
            if(strcmp(spectrum,'ejection'))
                pGuess  = [  5 max(abs(xvalsAveraged(maxYidxfiltered))/2,3)  xvalsAveraged(maxYidxfiltered) -0.04*max(abs(xvalsAveraged(maxYidxfiltered))/2,3)];
                lb      = [ 0 0,  -50, -1];
                ub      = [   150 75, 50, 0];
            elseif(strcmp(spectrum,'injection'))
                pGuess  = [  5 max(abs(xvalsAveraged(maxYidxfiltered))/2,3)  xvalsAveraged(maxYidxfiltered) 0.04*max(abs(xvalsAveraged(maxYidxfiltered))/2,3)];
                lb      = [ 0 0,  -50, 0];
                ub      = [   150 150, 50, 1];
            end
            
%             partfun = @(p,x) 2*p(3)./(1+exp(p(4).*(x-p(2))));             
%             fitfun = @(p,x) 1./partfun(p,x).*exp(-4*log(2)./(2*p(1)^2)*(2*((x-p(2))./partfun(p,x)).^2));
%             parameterNames = {'sigma 1','peakPos','sigma 2','asym'};
% 
%             pGuess  = [50  xvalsAveraged(maxYidxfiltered)  50,-0.05];
%             lb      = [0,  -50, 0    -1];
%             ub      = [inf, 50, inf    0];
            
            
            if(isempty(lowPeakCutFreq)||isempty(highPeakCutFreq))
                peakMask = find(xvals>xvalsAveraged(maxYidxfiltered)-5 & xvals<xvalsAveraged(maxYidxfiltered)+5);
            else
                peakMask = find(xvals>lowPeakCutFreq-2 & xvals<highPeakCutFreq+2);
            end
            mask2 = find(xvals>xvalsAveraged(maxYidxfiltered)-3 & xvals<xvalsAveraged(maxYidxfiltered)+3);
            if(length(mask2)>length(peakMask))
                peakMask = mask2;
            end
            
            weighted_deviations = @(p) (fitfun(p,xvals(peakMask))-yvals(peakMask)); 

            
            optio = optimoptions(@lsqnonlin,'Algorithm','trust-region-reflective','Display','off','MaxFunctionEvaluations',100);
            
            [paramPeak,~,resid,~,~,~,J]=lsqnonlin(weighted_deviations,pGuess,lb,ub,optio);
            try
                ciPeak = nlparci(paramPeak,resid,'jacobian',J);
            catch
                ciPeak = [NaN;NaN];
            end
            
            valsforPeak = xvalsAveraged(1):0.001:xvalsAveraged(end);
            
            [fittedPeakValue,fittedPeakIdx] = max(fitfun(paramPeak,valsforPeak));
            
            peakValue(jdx) = fittedPeakValue;
            peakPos(jdx) = valsforPeak(fittedPeakIdx);
            
            if plotting
                dummyMeas = Measurement(' ');
                dummyMeas.printFitReport(parameterNames,paramPeak,ciPeak)

                figure(124),clf;
                plot(xvals,yvals,'.');
                hold on

                    %plot(xvalsAveraged,yvalsAveraged,'.','MarkerSize',20);
                    plot(xvalsAveraged,lowPassfiltered,'LineWidth',2);
                    plot(xvalsAveraged(maxYidxfiltered),lowPassfiltered(maxYidxfiltered),'.','MarkerSize',20);
                    plot(xvalsAveraged(highPeakCut),lowPassfiltered(highPeakCut),'.','MarkerSize',20);
                    plot(xvalsAveraged(lowPeakCut),lowPassfiltered(lowPeakCut),'.','MarkerSize',20);
                    plot(valsforPeak,fitfun(paramPeak,valsforPeak),'LineWidth',2);
                hold off
            end
            
            
        elseif peakFinder==3
            % x^3 fitting
            fitfun = @(p,x) 10^(-1)*p(4)+10^(-2)*p(3)*x+10^(-3)*p(2)*x.^2+10^(-5)*p(1)*x.^3;
            parameterNames = {'a (x^3)','b (x^2)','c (x^1)','d (x^0)'};

            pGuess = [5   -2.8    3    2];
            lb = [0,-100,-100,-100];
            ub = [100,100,100,100];
            
            if(isempty(lowPeakCutFreq)||isempty(highPeakCutFreq))
                peakMask = find(xvals>xvalsAveraged(maxYidxfiltered)-5 & xvals<xvalsAveraged(maxYidxfiltered)+5);
            else
                peakMask = find(xvals>lowPeakCutFreq & xvals<highPeakCutFreq);
            end
            mask2 = find(xvals>xvalsAveraged(maxYidxfiltered)-3 & xvals<xvalsAveraged(maxYidxfiltered)+3);
            if(length(mask2)>length(peakMask))
                peakMask = mask2;
            end
            
            weighted_deviations = @(p) (fitfun(p,xvals(peakMask))-yvals(peakMask)); 

            
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
            % x^2 fitting
            fitfun = @(p,x) p(3)+p(2).*(p(1)-x).^2;
            parameterNames = {'Peak Pos','slope','peakHeight'};

            pGuess = [xvalsAveraged(maxYidxfiltered),-1,maxYfiltered];
            lb = [0,-100,0];
            ub = [100,0,1];
            
            if(isempty(lowPeakCutFreq)||isempty(highPeakCutFreq))
                peakMask = find(xvals>xvalsAveraged(maxYidxfiltered)-5 & xvals<xvalsAveraged(maxYidxfiltered)+5);
            else
                peakMask = find(xvals>lowPeakCutFreq & xvals<highPeakCutFreq);
            end
            mask2 = find(xvals>xvalsAveraged(maxYidxfiltered)-5 & xvals<xvalsAveraged(maxYidxfiltered)+5);
            if(length(mask2)>length(peakMask))
                peakMask = mask2;
            end
            weighted_deviations = @(p) (fitfun(p,xvals(peakMask))-yvals(peakMask)); 
            
            optio = optimoptions(@lsqnonlin,'Algorithm','trust-region-reflective','Display','off','MaxFunctionEvaluations',100);
            
            [paramPeak,~,resid,~,~,~,J]=lsqnonlin(weighted_deviations,pGuess,lb,ub,optio);
            
            peakValue(jdx) = paramPeak(3);
            peakPos(jdx) = paramPeak(1);
            ciPeak = nlparci(paramPeak,resid,'jacobian',J);
        elseif(peakFinder ==1)
            % piecewise x^2 fitting
            fitfun = @(p,x) p(4)+heaviside(p(1)-x).*p(2).*(p(1)-x).^2+heaviside(x-p(1)).*p(3)*p(2).*(p(1)-x).^2;
            parameterNames = {'Peak Pos','slope1','slope2','peakHeight'};

            pGuess = [xvalsAveraged(maxYidxfiltered),-0.005,1,maxYfiltered];
            lb = [-15,-100,0,0];
            ub = [100,0,1,1];
            
            if(isempty(lowPeakCutFreq)||isempty(highPeakCutFreq))
                peakMask = find(xvals>xvalsAveraged(maxYidxfiltered)-5 & xvals<xvalsAveraged(maxYidxfiltered)+5);
            else
                peakMask = find(xvals>lowPeakCutFreq & xvals<highPeakCutFreq);
            end
            mask2 = find(xvals>xvalsAveraged(maxYidxfiltered)-3 & xvals<xvalsAveraged(maxYidxfiltered)+3);
            if(length(mask2)>length(peakMask))
                peakMask = mask2;
            end
            
            weighted_deviations = @(p) (fitfun(p,xvals(peakMask))-yvals(peakMask));         
            optio = optimoptions(@lsqnonlin,'Algorithm','trust-region-reflective','Display','off','MaxFunctionEvaluations',100);
            
            [paramPeak,~,resid,~,~,~,J]=lsqnonlin(weighted_deviations,pGuess,lb,ub,optio);
            
            peakValue(jdx) = paramPeak(4);
            peakPos(jdx) = paramPeak(1);
            

            %reject peak positions which have railed to the lower bound
            if round(peakPos(jdx))==lb(1)
                peakPos(jdx)=0;
                fprintf('Peak pos failed\n');
            end
            
            try
                ciPeak = nlparci(paramPeak,resid,'jacobian',J);
            catch
                ciPeak = [NaN;NaN];
            end
            
        else
            error('peakfinder only supports quadratic fit (choose 2), qubic fit (choose 3), or hybrid quadratic (choose 1)');
        end
        %Guess peak position for width fitting and contact fitting
        peakPosG(jdx)=max(peakPos(jdx),0);
        if(plotting)
            fprintf('Peak Position: %.1f kHz \n',peakPos(jdx));
            dummyMeas = Measurement(' ');
        end
        
        
        
        %% width
        if peakFinder==4
            valsforPeak = xvalsAveraged(1):0.1:xvalsAveraged(end);
            fitFunYvals = fitfun(paramPeak,valsforPeak);
            
            [fittedPeakValue,fittedPeakIdx] = max(fitFunYvals);
            
            spectrumArea = 0;
            
            
            partfun = @(p,x) 2*p(2)./(1+exp(p(4).*(x-p(3))));             
            fitfun = @(p,x) p(1)./partfun(p,x).*exp(-4*log(2)*(2*((x-p(3))./partfun(p,x)).^2));
            parameterNames = {'amp','sigma 1','peakPos','asym'};
            
            if(strcmp(spectrum,'ejection'))
                pGuess  = [  paramPeak(1) paramPeak(2)  paramPeak(3) paramPeak(4)];
                lb      = [ 0 0,  -50, -1];
                ub      = [   150 150, 50, 0];
            elseif(strcmp(spectrum,'injection'))
                pGuess  = [  paramPeak(1) paramPeak(2)  paramPeak(3) paramPeak(4)];
                lb      = [ 0 0,  -50, 0];
                ub      = [   150 150, 50, 1];
            end
            
            peakMask = find(xvals>-15 & xvals<valsforPeak(fittedPeakIdx)+10);
            mask2 = find(xvals>xvalsAveraged(maxYidxfiltered)-5 & xvals<xvalsAveraged(maxYidxfiltered)+5);
            if(length(mask2)>length(peakMask))
                peakMask = mask2;
            end
            
            weighted_deviations = @(p) (fitfun(p,xvals(peakMask))-yvals(peakMask)); 
            optio = optimoptions(@lsqnonlin,'Algorithm','trust-region-reflective','Display','off','MaxFunctionEvaluations',100);
            [paramPeak,~,resid,~,~,~,J]=lsqnonlin(weighted_deviations,pGuess,lb,ub,optio);
            
            [fittedPeakValue,fittedPeakIdx] = max(fitfun(paramPeak,valsforPeak));
            
            peakValue(jdx) = fittedPeakValue;
            peakPos(jdx) = valsforPeak(fittedPeakIdx);
                
            
            
            fitFunYvals = fitfun(paramPeak,valsforPeak);
            zeroMask1 = find(fitFunYvals(1:fittedPeakIdx)>0.01);
            if isempty(zeroMask1)
                display('huh' );
            end
            sortedYvalsAveraged = fliplr(sort(yvalsAveraged));
            maxYAveraged = median(sortedYvalsAveraged(1:3));
            
            
            leftWidth = peakPos(jdx)-interp1(fitFunYvals(zeroMask1),valsforPeak(zeroMask1),0.5*maxYAveraged);

            
            if plotting
                dummyMeas = Measurement(' ');
                dummyMeas.printFitReport(parameterNames,paramPeak,ciPeak)

                figure(1123),clf;
                plot(xvals,yvals,'.');
                hold on

                    %plot(xvalsAveraged,yvalsAveraged,'.','MarkerSize',20);
                    plot(xvalsAveraged,lowPassfiltered,'LineWidth',2);
                    plot(xvalsAveraged(maxYidxfiltered),lowPassfiltered(maxYidxfiltered),'.','MarkerSize',20);
                    plot(xvalsAveraged(highPeakCut),lowPassfiltered(highPeakCut),'.','MarkerSize',20);
                    plot(xvalsAveraged(lowPeakCut),lowPassfiltered(lowPeakCut),'.','MarkerSize',20);
                    plot(valsforPeak,fitfun(paramPeak,valsforPeak),'LineWidth',2);
                    plot([peakPos(jdx)-leftWidth,peakPos(jdx)-leftWidth],[0,0.8],'k--','LineWidth',1.5);
                hold off
            end
            
            if(strcmp(spectrum,'ejection'))
                pGuess  = [  paramPeak(1) paramPeak(2)  paramPeak(3) paramPeak(4)];
                lb      = [ 0 0,  -50, -1];
                ub      = [   150 150, 50, 0];
            elseif(strcmp(spectrum,'injection'))
                pGuess  = [  paramPeak(1) paramPeak(2)  paramPeak(3) paramPeak(4)];
                lb      = [ 0 0,  -50, 0];
                ub      = [   150 150, 50, 1];
            end
            
            peakMask = find(xvals>valsforPeak(fittedPeakIdx)-15 & xvals<highPeakCutFreq);
            mask2 = find(xvals>xvalsAveraged(maxYidxfiltered)-5 & xvals<highPeakCutFreq);
            if(length(mask2)>length(peakMask))
                peakMask = mask2;
            end
            
            weighted_deviations = @(p) (fitfun(p,xvals(peakMask))-yvals(peakMask)); 
            optio = optimoptions(@lsqnonlin,'Algorithm','trust-region-reflective','Display','off','MaxFunctionEvaluations',100);
            [paramPeak,~,resid,~,~,~,J]=lsqnonlin(weighted_deviations,pGuess,lb,ub,optio);
            
            fitFunYvals = fitfun(paramPeak,valsforPeak);
            zeroMask2 = find(fitFunYvals(fittedPeakIdx:end)>0.001);
            rightWidth = interp1(fitFunYvals(fittedPeakIdx-1+zeroMask2),valsforPeak(fittedPeakIdx-1+zeroMask2),0.5*maxYAveraged)-peakPos(jdx);
            if isnan(rightWidth)
                [~ ,tempIdx] = max(fitfun(paramPeak,valsforPeak));
                rightWidth = valsforPeak(tempIdx);
            end
            
            if isnan(leftWidth)
                [~ ,tempIdx] = max(fitfun(paramPeak,valsforPeak));
                leftWidth = valsforPeak(tempIdx);
            end
            FWHM = rightWidth+leftWidth;
            if plotting
                dummyMeas = Measurement(' ');
                dummyMeas.printFitReport(parameterNames,paramPeak,ciPeak)

                figure(1124),clf;
                plot(xvals,yvals,'.');
                hold on
                    %plot(xvalsAveraged,yvalsAveraged,'.','MarkerSize',20);
                    plot(xvalsAveraged,lowPassfiltered,'LineWidth',2);
                    plot(xvalsAveraged(maxYidxfiltered),lowPassfiltered(maxYidxfiltered),'.','MarkerSize',20);
                    plot(xvalsAveraged(highPeakCut),lowPassfiltered(highPeakCut),'.','MarkerSize',20);
                    plot(xvalsAveraged(lowPeakCut),lowPassfiltered(lowPeakCut),'.','MarkerSize',20);
                    plot(valsforPeak,fitfun(paramPeak,valsforPeak),'LineWidth',2);
                    plot([peakPos(jdx)+rightWidth,peakPos(jdx)+rightWidth],[0,0.8],'k--','LineWidth',1.5);
                    plot([27,27],[0,0.8],'k.-','LineWidth',1.5);
                hold off
            end
        else
            spectrumArea = 0;
            sFitVals = xvalsAveraged(1):0.1:peakPosG(jdx);
            try
                leftWidth = peakPosG(jdx)-interp1(fitfun(paramPeak,sFitVals),sFitVals,0.5*peakValue(jdx));
            catch
                leftWidth = 0;
            end
            sFitVals = 0.0001:0.1:xvalsAveraged(end);
            try
                rightWidth = interp1(fitfunContact(paramContact,sFitVals),sFitVals,0.5*peakValue(jdx))-peakPosG(jdx);
            catch
                rightWidth = 0;
            end
            if(isnan(rightWidth))
                rightWidth = 0;
            end
        end
        %% Contact
        if peakFinder==4
            valsforPeak = xvalsAveraged(1):0.1:xvalsAveraged(end);
            fitFunYvals = fitfun(paramPeak,valsforPeak);
            [~,fittedPeakIdx] = max(fitFunYvals);
            if(strcmp(spectrum,'ejection'))
                contactIdx = fittedPeakIdx-1+find(fitFunYvals(fittedPeakIdx:end)<contactThreshold & valsforPeak(fittedPeakIdx:end)<contactNoiseFloor);
                maskContact = find(xvals>0 & xvals>valsforPeak(contactIdx(1)) & xvals<valsforPeak(contactIdx(end)));
            elseif(strcmp(spectrum,'injection'))
                contactIdx = find(fitFunYvals(1:fittedPeakIdx)<contactThreshold & valsforPeak(1:fittedPeakIdx)>-contactNoiseFloor);
                maskContact = find(xvals<0 & xvals>valsforPeak(contactIdx(1)) & xvals<valsforPeak(contactIdx(end)));
            end
            
        else
            %find closest to peak value that is below contact threshold
            idxAbove = find(lowPassfiltered(:)<contactThreshold);
            distance = maxYidxfiltered-idxAbove;
            negMask = distance<0;
            distance(~negMask)= NaN;
            [~,closestIdx]=max(distance);
            ContactCut = idxAbove(closestIdx);
            ContactCutFreq = xvalsAveraged(ContactCut);
            maskContact = find(xvals>ContactCutFreq & xvals>0);
        end
        
        if(strcmp(spectrum,'ejection'))
            fitfunContact = @(p,x) p(1)*(x-0).^(-3/2);
            %%Include final state interactions if the option was chosen
            if abs(a_scat(1))>0
                fitfunContact = @(p,x) p(1)*x.^(-3/2)*(a_scat(1)^-1-a_scat(2)^-1)^2./(a_scat(2)^-2+2*mReduced/hbar*x*1000);
            end
        elseif(strcmp(spectrum,'injection'))
            fitfunContact = @(p,x) p(1)*(-x).^(-3/2);
            %%Include final state interactions if the option was chosen
            if abs(a_scat(1))>0
                fitfunContact = @(p,x) p(1)*(-x).^(-3/2)*(a_scat(1)^-1-a_scat(2)^-1)^2./(a_scat(2)^-2+2*mReduced/hbar*x*1000);
            end
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
            dummyMeas.printFitReport(parameterNames,paramContact,ciContact)
        
            figure(123),clf;
            plot(xvals,yvals,'.');
            hold on
                plot(xvalsAveraged,lowPassfiltered,'LineWidth',2);
                plot(xvalsAveraged(maxYidxfiltered),lowPassfiltered(maxYidxfiltered),'.','MarkerSize',20);
                plot(xvalsAveraged(highPeakCut),lowPassfiltered(highPeakCut),'.','MarkerSize',20);
                if peakFinder==4
                    plot([valsforPeak(contactIdx(1)),valsforPeak(contactIdx(1))],[0,0.8],'k--','LineWidth',1.5);
                    plot([valsforPeak(contactIdx(end)),valsforPeak(contactIdx(end))],[0,0.8],'k--','LineWidth',1.5);
                else
                    plot(xvalsAveraged(ContactCut),lowPassfiltered(ContactCut),'.','MarkerSize',20);
                end
                if peakFinder==4
                    selectedXvals = valsforPeak(contactIdx(1)):0.01:valsforPeak(contactIdx(end));
                    plot(selectedXvals,fitfunContact(paramContact,selectedXvals),'LineWidth',2)
                else
                    selectedXvals = xvalsAveraged(ContactCut):0.1:xvalsAveraged(end);
                    plot(selectedXvals,fitfunContact(paramContact,selectedXvals),'LineWidth',2)
                end
            hold off
        end
        
        %% plotting and saving
        %
        if(plotting)
            figure(125);
            subplot(ceil(length(analyzeIdx)/3),3,numPlot)
           
            
            plot(xvals,yvals,'.');
            hold on
            selectedXvals = min(xvals(peakMask)):0.1:max(xvals(peakMask));
            plot(selectedXvals,fitfun(paramPeak,selectedXvals),'LineWidth',2,'Color',[255,51,51]/255);
            
            if peakFinder==4
                selectedXvals = valsforPeak(contactIdx(1)):0.01:valsforPeak(contactIdx(end));
                plot(selectedXvals,fitfunContact(paramContact,selectedXvals),'LineWidth',2,'Color',[255,51,51]/255)
            else
                selectedXvals = xvalsAveraged(ContactCut):0.1:xvalsAveraged(end);
                plot(selectedXvals,fitfunContact(paramContact,selectedXvals),'LineWidth',2,'Color',[255,51,51]/255)
            end

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

        analysisSummary.Contact.paramContact(jdx,:) = paramContact(1);
        analysisSummary.Contact.ciContact(jdx,:,:) = ciContact';
        analysisSummary.area(jdx) = spectrumArea;

%         display(paramContact(1))
        xlim([-100,350])
        drawnow
        
    end
    if(pauseEachRun)
        waitforbuttonpress;
    end
end