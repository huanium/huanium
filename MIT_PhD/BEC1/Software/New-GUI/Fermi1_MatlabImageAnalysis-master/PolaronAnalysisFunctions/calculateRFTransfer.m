function RFSpec = calculateRFTransfer(K72_Densities,K92_Densities,numBoxes,xvalAtomicReference,varargin)
    p = inputParser;

    p.addParameter('BECTFyCut',0);
    p.addParameter('minKcut',-10);
    p.addParameter('normalize',true);
    p.parse(varargin{:});
    BECTFyCut  = p.Results.BECTFyCut;
    minKcut  = p.Results.minKcut;
    normalize  = p.Results.normalize;

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
            m72_yvals(jdx,idx) = mean(K72_Densities.countVsDensity(jdx,valuesIdx));
            m72_error(jdx,idx) = std(K72_Densities.countVsDensity(jdx,valuesIdx))/sqrt(length(K72_Densities.countVsDensity(jdx,valuesIdx)));
            m92_yvals(jdx,idx) = mean(K92_Densities.countVsDensity(jdx,valuesIdx));
            m92_error(jdx,idx) = std(K92_Densities.countVsDensity(jdx,valuesIdx))/sqrt(length(K92_Densities.countVsDensity(jdx,valuesIdx)));
        end
    end
    xvals = xvals-xvalAtomicReference;
    normalization = zeros(numBoxes,1);
    FreqCut = -10;
    if(normalize)
        for jdx = 1:numBoxes
            idx = find(xvals(jdx,:) < FreqCut & ~isnan(m72_yvals(jdx,:)) & ~isnan(m92_yvals(jdx,:)));
            on92  = sum(m92_yvals(jdx,idx))/length(idx);
            off72 = sum(m72_yvals(jdx,idx))/length(idx);
            normalization(jdx) = off72/on92;
        end
    else
        normalization = ones(numBoxes,1)*0.0844;
    end
    
    for jdx = 1:numBoxes
        funToProp = @(x) (x(1)-normalization(jdx)*x(2))./(x(2)/1.272+0.8699*x(1));
        for idx = 1:length(uniqueFreq)
            if(isnan(m72_yvals(jdx,idx))||isnan(m92_yvals(jdx,idx))) 
                funValue = NaN;
                funCI = [NaN,NaN];
            elseif(m72_error(jdx,idx)~=0&&m72_error(jdx,idx)~=0) 
                A = generateMCparameters('gaussian',[m72_yvals(jdx,idx),m72_error(jdx,idx)],'numSamples',10000);
                B = generateMCparameters('gaussian',[m92_yvals(jdx,idx),m92_error(jdx,idx)],'numSamples',10000);
                paramMatrix = [A;B];
                
                [funValue,funCI,funSamples] = propagateErrorWithMC(funToProp, paramMatrix);
                fprintf(strcat('i = ',num2str(idx), ' j = ', num2str(jdx),'\n'));
            else
                funValue = funToProp([m72_yvals(jdx,idx),m92_yvals(jdx,idx)]);
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