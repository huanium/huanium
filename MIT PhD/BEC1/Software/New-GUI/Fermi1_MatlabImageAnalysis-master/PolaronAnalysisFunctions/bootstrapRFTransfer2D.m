function RFSpec = bootstrapRFTransfer2D(K72_Densities,K92_Densities,Na_analysis,boxWidths,boxHeigths,xvalAtomicReference,varargin)
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
    
%     m72_yvals = zeros(numBoxes,length(K72_Densities.parameters));
%     m72_error = zeros(numBoxes,length(K72_Densities.parameters));
%     m92_yvals = zeros(numBoxes,length(K72_Densities.parameters));
%     m92_error = zeros(numBoxes,length(K72_Densities.parameters));
%     xvals = zeros(numBoxes,length(K72_Densities.parameters));
%     yvals = zeros(numBoxes,length(K72_Densities.parameters));
%     y_ci = zeros(numBoxes,2,length(K72_Densities.parameters));
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
            
            if(isstruct(Na_analysis))
                BECcut = find(Na_analysis.analysis.fitBimodalExcludeCenter.yparam(:,2)>BECTFyCutLow & ...
                              Na_analysis.analysis.fitBimodalExcludeCenter.yparam(:,2)<BECTFyCutHigh);
                valuesIdx = BECcut;
                BECcut = find(Na_analysis.analysis.fitBimodalExcludeCenter.xparam(valuesIdx,2)>BECTFxCutLow & ...
                              Na_analysis.analysis.fitBimodalExcludeCenter.xparam(valuesIdx,2)<BECTFxCutHigh);
                valuesIdx = valuesIdx(BECcut);
            end
            bootIdx = bootstrp(1,@(x) (x),valuesIdx);
            m72_yvals(trueBoxIdx,:) = mean(K72_Densities.KcountVsDensityAveraged(boxIdx,bootIdx));
            m92_yvals(trueBoxIdx,:) = mean(K92_Densities.KcountVsDensityAveraged(boxIdx,bootIdx))';
            xvals(trueBoxIdx,:) = K92_Densities.parameters(bootIdx);
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
%         fprintf('creating spectrum: %i/%i\n',jdx,numBoxes);
        funToProp = @(x) (x(1)-normalization(jdx)*x(2))./(x(2)/1.272+0.8699*x(1));
        for idx = 1:length(xvals(1,:))
            if(isnan(m72_yvals(jdx,idx))||isnan(m92_yvals(jdx,idx))) 
                funValue = NaN;
                funCI = [NaN,NaN];
%             elseif(m72_error(jdx,idx)~=0&&m92_error(jdx,idx)~=0) 
%                  A = generateMCparameters('gaussian',[m72_yvals(jdx,idx),m72_error(jdx,idx)],'numSamples',10000);
%                  B = generateMCparameters('gaussian',[m92_yvals(jdx,idx),m92_error(jdx,idx)],'numSamples',10000);
%                  if(strcmp(spectrum,'ejection'))   
%                      paramMatrix = [A;B];
%                  elseif(strcmp(spectrum,'injection'))
%                      paramMatrix = [B;A];
%                  end
%                 [funValue,funCI,funSamples] = propagateErrorWithMC(funToProp, paramMatrix);
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
    
    
    

    
    
    [~,sortIdx] = sort(xvals(1,:));
    
    
    RFSpec = struct;
    RFSpec.xvals = xvals(:,sortIdx);
    RFSpec.yvals = yvals(:,sortIdx);
    RFSpec.y_ci = y_ci(:,:,sortIdx);
    
    
%     uniqueFreq = unique(RFSpec.xvals);
%     xvals = zeros(numBoxes,length(uniqueFreq));
%     yvals = zeros(numBoxes,length(uniqueFreq));
%     yStd  = zeros(numBoxes,length(uniqueFreq));
%     y_ci  = zeros(numBoxes,2,length(uniqueFreq));
%     for jdx = 1:length(RFSpec.xvals(:,1))
%         for idx = 1:length(uniqueFreq)
%             xvals(jdx,idx) = uniqueFreq(idx);
%             valuesIdx = find(RFSpec.xvals(jdx,:)==uniqueFreq(idx));
%             yvals(jdx,idx) = mean(RFSpec.yvals(jdx,valuesIdx));
%             if(std(RFSpec.yvals(jdx,valuesIdx))/sqrt(length(RFSpec.yvals(jdx,valuesIdx)))>0)
%                 yStd(jdx,idx) = std(RFSpec.yvals(jdx,valuesIdx))/sqrt(length(RFSpec.yvals(jdx,valuesIdx)));
%             else
%                 yStd(jdx,idx) = 0.3;
%             end
%             
%         end
%     end
%     
%     RFSpec = struct;
%     RFSpec.xvals = xvals;
%     RFSpec.yvals = yvals;
%     RFSpec.y_ci(:,1,:) = yvals-yStd;
%     RFSpec.y_ci(:,2,:) = yvals+yStd;
end