function RFSpec = calculateRFTransfer2D(K72_Densities,K92_Densities,Na_analysis,NaDensityTemp2D,boxWidths,boxHeigths,xvalAtomicReference,varargin)
    p = inputParser;
    
    p.addParameter('spectrum','ejection');
    p.addParameter('BECTFyCutLow',0);
    p.addParameter('BECTFyCutHigh',1000);
    p.addParameter('BECTFxCutLow',0);
    p.addParameter('BECTFxCutHigh',1000);
    p.addParameter('singleAnalysisBox',false);
    p.addParameter('normalize',true);
    p.parse(varargin{:});
    BECTFyCutLow  = p.Results.BECTFyCutLow;
    BECTFyCutHigh  = p.Results.BECTFyCutHigh;
    BECTFxCutLow  = p.Results.BECTFxCutLow;
    BECTFxCutHigh  = p.Results.BECTFxCutHigh;
    spectrum  = p.Results.spectrum;
    singleAnalysisBox  = p.Results.singleAnalysisBox;
    normalize  = p.Results.normalize;
    
    centerX = 0;
    centerY = 0;
    MarqueeBoxes = createMarqueeBoxes(centerX,centerY,boxWidths,boxHeigths);
    numBoxes = length(MarqueeBoxes(:,1))/4;
    
    uniqueFreq = unique(K72_Densities.parameters);
%     m72_yvals = zeros(numBoxes,length(uniqueFreq));
%     m72_error = zeros(numBoxes,length(uniqueFreq));
%     m92_yvals = zeros(numBoxes,length(uniqueFreq));
%     m92_error = zeros(numBoxes,length(uniqueFreq));
%     xvals = zeros(numBoxes,length(uniqueFreq));
%     yvals = zeros(numBoxes,length(uniqueFreq));
%     y_ci = zeros(numBoxes,2,length(uniqueFreq));
    m72_yvals = [];
    m72_error = [];
    m92_yvals = [];
    m92_error = [];
    xvals = [];
    yvals = [];
    y_ci = [];
    
    
    for jdx = 1:length(boxHeigths)
        for kdx = 1:length(boxWidths)
            if(~singleAnalysisBox)
                boxIdx = [(2*kdx-1)+4*length(boxWidths)*(jdx-1),...
                      (2*kdx)+4*length(boxWidths)*(jdx-1),...
                      (2*kdx-1)+4*length(boxWidths)*(jdx-1)+2*length(boxWidths),...
                      (2*kdx)+4*length(boxWidths)*(jdx-1)+2*length(boxWidths)];
            else
                boxIdx = 1;
            end
            
            trueBoxIdx = (jdx-1)*length(boxWidths)+kdx;
            for idx = 1:length(uniqueFreq)
                xvals(trueBoxIdx,idx) = uniqueFreq(idx);
                valuesIdx = find(K72_Densities.parameters==uniqueFreq(idx));
                if(isstruct(Na_analysis))
                    BECcut = find(Na_analysis.analysis.fitBimodalExcludeCenter.yparam(valuesIdx,2)>BECTFyCutLow & ...
                                  Na_analysis.analysis.fitBimodalExcludeCenter.yparam(valuesIdx,2)<BECTFyCutHigh);
                    valuesIdx = valuesIdx(BECcut);
                    BECcut = find(Na_analysis.analysis.fitBimodalExcludeCenter.xparam(valuesIdx,2)>BECTFxCutLow & ...
                                  Na_analysis.analysis.fitBimodalExcludeCenter.xparam(valuesIdx,2)<BECTFxCutHigh);
                    valuesIdx = valuesIdx(BECcut);
                end
                values = K72_Densities.KcountVsDensityAveraged(boxIdx,valuesIdx);
               
                    m72_yvals(trueBoxIdx,idx) = mean(values(:));
                    m72_error(trueBoxIdx,idx) = std(values(:))/sqrt(length(values(:)));
                
%                 valuesIdx = find(K92_Densities.parameters==uniqueFreq(idx));
%                 if(isstruct(Na_analysis))
%                     BECcut = find(Na_analysis.analysis.fitBimodalExcludeCenter.yparam(valuesIdx,2)>BECTFyCut);
%                     valuesIdx = valuesIdx(BECcut);
%                     BECcut = find(Na_analysis.analysis.fitBimodalExcludeCenter.xparam(valuesIdx,2)>BECTFxCut);
%                     valuesIdx = valuesIdx(BECcut);
%                 end
                values = K92_Densities.KcountVsDensityAveraged(boxIdx,valuesIdx);
                
                    m92_yvals(trueBoxIdx,idx) = mean(values(:));
                    m92_error(trueBoxIdx,idx) = std(values(:))/sqrt(length(values(:)));
                
            end
        end
    end
    
    xvals = xvals-xvalAtomicReference;
    if(normalize)
        normalization = zeros(numBoxes,1);
        if(strcmp(spectrum,'ejection'))
            FreqCut = -10;
            for jdx = 1:numBoxes
                idx = find(xvals(jdx,:) < FreqCut & ~isnan(m72_yvals(jdx,:)) & ~isnan(m92_yvals(jdx,:)));
                on92  = sum(m92_yvals(jdx,idx))/length(idx);
                off72 = sum(m72_yvals(jdx,idx))/length(idx);
                normalization(jdx) = off72/on92;
            end
        elseif(strcmp(spectrum,'injection'))
            FreqCut = 50;
            for jdx = 1:numBoxes
                idx = find(xvals(jdx,:) > FreqCut);
                off92  = sum(m92_yvals(jdx,idx))/length(idx);
                on72 = sum(m72_yvals(jdx,idx))/length(idx);
                normalization(jdx) = off92/on72;
            end
        else
            error('unknown spectrum. Choose either injection or ejection');
        end
    else
         normalization = ones(numBoxes,1)*0.0844;
    end
    
    for jdx = 1:numBoxes
        fprintf('creating spectrum: %i/%i\n',jdx,numBoxes);
        funToProp = @(x) (x(1)-normalization(jdx)*x(2))./(x(2)/1.272+0.8699*x(1));
        for idx = 1:length(uniqueFreq)
            if(isnan(m72_yvals(jdx,idx))||isnan(m92_yvals(jdx,idx))) 
                funValue = NaN;
                funCI = [NaN,NaN];
            elseif(m72_error(jdx,idx)~=0&&m92_error(jdx,idx)~=0) 
                 A = generateMCparameters('gaussian',[m72_yvals(jdx,idx),m72_error(jdx,idx)],'numSamples',10000);
                 B = generateMCparameters('gaussian',[m92_yvals(jdx,idx),m92_error(jdx,idx)],'numSamples',10000);
                 if(strcmp(spectrum,'ejection'))   
                     paramMatrix = [A;B];
                 elseif(strcmp(spectrum,'injection'))
                     paramMatrix = [B;A];
                 end
                [funValue,funCI,funSamples] = propagateErrorWithMC(funToProp, paramMatrix);
            else
                if(strcmp(spectrum,'ejection'))   
                     funValue = funToProp([m72_yvals(jdx,idx),m92_yvals(jdx,idx)]);
                elseif(strcmp(spectrum,'injection'))
                     funValue = funToProp([m92_yvals(jdx,idx),m72_yvals(jdx,idx)]);
                end
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