function RFSpec = calculateRFTransferInjection(K72_Densities,K92_Densities,Na_analysis,numBoxes,xvalAtomicReference,varargin)
    p = inputParser;

    p.addParameter('BECTFyCut',0);
    p.addParameter('minKcut',0.1);
    p.parse(varargin{:});
    BECTFyCut  = p.Results.BECTFyCut;
    minKcut  = p.Results.minKcut;


    uniqueFreq = unique(K72_Densities.parameters);
    m72_yvals = zeros(numBoxes,length(uniqueFreq));
    m72_error = zeros(numBoxes,length(uniqueFreq));
    m92_yvals = zeros(numBoxes,length(uniqueFreq));
    m92_error = zeros(numBoxes,length(uniqueFreq));
    xvals = zeros(numBoxes,length(uniqueFreq));
    yvals = zeros(numBoxes,length(uniqueFreq));
    y_ci = zeros(numBoxes,2,length(uniqueFreq));
    for jdx = 1:numBoxes
        for idx = 1:length(uniqueFreq)
            xvals(jdx,idx) = uniqueFreq(idx);
            valuesIdx = find(K72_Densities.parameters==uniqueFreq(idx));
            minKThreshIdx = find(K72_Densities.countVsDensity(jdx,valuesIdx)>minKcut);
            valuesIdx = valuesIdx(minKThreshIdx);
            BECcut = find(Na_analysis.analysis.fitBimodalExcludeCenter.yparam(valuesIdx,3)>BECTFyCut);
            valuesIdx = valuesIdx(BECcut);
            m72_yvals(jdx,idx) = mean(K72_Densities.countVsDensity(jdx,valuesIdx));
            m72_error(jdx,idx) = std(K72_Densities.countVsDensity(jdx,valuesIdx))/sqrt(length(K72_Densities.countVsDensity(jdx,valuesIdx)));
            valuesIdx = find(K92_Densities.parameters==uniqueFreq(idx));
            minKThreshIdx = find(K92_Densities.countVsDensity(jdx,valuesIdx)>minKcut);
            valuesIdx = valuesIdx(minKThreshIdx);
            BECcut = find(Na_analysis.analysis.fitBimodalExcludeCenter.yparam(valuesIdx,3)>BECTFyCut);
            valuesIdx = valuesIdx(BECcut);
            m92_yvals(jdx,idx) = mean(K92_Densities.countVsDensity(jdx,valuesIdx));
            m92_error(jdx,idx) = std(K92_Densities.countVsDensity(jdx,valuesIdx))/sqrt(length(K92_Densities.countVsDensity(jdx,valuesIdx)));
        end
    end
    xvals = xvals-xvalAtomicReference;
    normalization = zeros(numBoxes,1);
    FreqCut = 50;
    for jdx = 1:numBoxes
        idx = find(xvals(jdx,:) > FreqCut);
        off92  = sum(m92_yvals(jdx,idx))/length(idx);
        on72 = sum(m72_yvals(jdx,idx))/length(idx);
        normalization(jdx) = off92/on72;
        %normalization(jdx) = 1;
    end
    
    for jdx = 1:numBoxes
        funToProp = @(x) (x(1)-normalization(jdx)*x(2))./(x(2)/1.33+0.62*x(1));
        for idx = 1:length(uniqueFreq)
            if(m72_error(jdx,idx)~=0) 
                A = generateMCparameters('gaussian',[m72_yvals(jdx,idx),m72_error(jdx,idx)],'numSamples',10000);
                B = generateMCparameters('gaussian',[m92_yvals(jdx,idx),m92_error(jdx,idx)],'numSamples',10000);
                paramMatrix = [B;A];
                
                [funValue,funCI,funSamples] = propagateErrorWithMC(funToProp, paramMatrix);
            else
                funValue = funToProp([m92_yvals(jdx,idx),m72_yvals(jdx,idx)]);
                funCI = [funValue,funValue];
            end
            yvals(jdx,idx)   = funValue;
            y_ci(jdx,:,idx)  = funCI';
        end
    end

    
    
    RFSpec = struct;
    RFSpec.xvals = xvals;
    RFSpec.yvals = yvals;
    RFSpec.y_ci = y_ci;
    
end