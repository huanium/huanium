function OscAnalysis = twoDampedSines(ana,varargin)
%ana is an analysis object with the relevant cloud positions.  
%Outputs
%    OscAnalysis.unweightedParam, fits means of COM without weights
%     OscAnalysis.param=weightedParam, fits means of COM weighted by
%     inverse variance.  If inverse variance = inf (only one data point),
%     does not use this data point
%Optional inputs
%If 'BEC' selected, gets COM from fitBimodalExcludeCenter.  If 'Gauss'
%selected, uses Gaussian peak position.  Else uses the true COM.
%If 'RemoveLinear' is true, fits a linear slope to the timeseries and
%subtracts off the line to take care of long-term machine drifts.
%Fits up to t= HighTCut in ms, or all data if unspecified
    p = inputParser;
    p.addParameter('COMtype','BEC'); 
    p.addParameter('RemoveLinear','true'); 
    p.addParameter('HighTCut',[]);
    p.addParameter('DoubleSine',false);
    p.parse(varargin{:});
    COMtype                 = p.Results.COMtype;
    RemoveLinear            = p.Results.RemoveLinear;
    HighTCut                = p.Results.HighTCut;
    DoubleSine              = p.Results.DoubleSine;
    
    pixelToMicron=2.5;
    if strcmp('BEC',COMtype)
        try
            y=pixelToMicron*ana.analysis.fitBimodalExcludeCenter.yparam(:,3)';
            disp('Using BEC parabola peak position for LS');

        catch
            warning('No fitBimodalExcludeCenter field exists');
        end
    elseif strcmp('Gauss',COMtype)
        y=pixelToMicron*ana.analysis.fitIntegratedGaussY.param(:,3)';
        disp('Using Gaussian peak position for LS');
    else
        y=pixelToMicron*ana.analysis.COMY;
        disp('Using true center-of-mass for LS');
    end
    if RemoveLinear
        figure(33);clf; hold on;
        plot(1:length(y),y,'.');
        
        linFit=polyfit(1:length(y),y,1);
        plot(linFit(2)+linFit(1)*[1:length(y)],'LineWidth',2);
        title(strcat('remove slope: ',num2str(linFit(1))));
        xlabel('Shot #');ylabel('y (um)');
        y=y-linFit(1)*(1:length(y));
    end
    traw=ana.parameters; %time in ms

    if ~isempty(HighTCut)
        keepIdx=find(traw<HighTCut);
        traw=traw(keepIdx);
        y=y(keepIdx);
    end

    [t,~,idx]=unique(traw);
    yvals=accumarray(idx,y,[],@mean);
    ystd=accumarray(idx,y,[],@std);
    [t, yvals]=prepareCurveData(t,yvals);
    
    if DoubleSine
        fitfun = @(p,x) p(1)*exp(-x/p(2)).*sin(2*pi*p(3)*x+p(4))+ ...
            p(5)*exp(-x/p(6)).*sin(2*pi*p(7)*x+p(8)) + p(9);
        parameterNames = {'Amp1','DampTau1','FreqKHz1','Phase1','Amp2','DampTau2',...
            'FreqKHz2','Phase2','offset'};
        pGuess= [range(yvals)/4, 50, 0.11, 0,    range(yvals)/2, 10, 0.25, 0, mean(yvals)];
        lb =    [0               0      0 0     0               0   0      0 min(yvals)];
        ub =    [range(yvals)/2, 1000, .5, 2*pi, range(yvals)/2, 1000, .5, 2*pi, max(yvals)];
    else %fit only single decaying sine
            fitfun = @(p,x) p(1)*exp(-x/p(2)).*sin(2*pi*p(3)*x+p(4))+p(5);
            parameterNames = {'Amp1','DampTau1','FreqKHz1','Phase1','offset'};
            pGuess= [range(yvals)/2, 50, 0.1, 0, mean(yvals)];
            lb = [0 0 0 0 min(yvals)];
            ub = [range(yvals)/2, 1000 .5, 2*pi, max(yvals)];
    end
    

    opts = optimoptions('lsqcurvefit','Algorithm','trust-region-reflective','Display','off','MaxFunctionEvaluations',1000);
    [uwparam,~,resid,~,~,~,J] = lsqcurvefit(fitfun,pGuess,t,yvals,lb,ub,opts);
    
    %Weighted fits, discarding data points with no variance
    goodIdx=find(ystd>0);
    wp = fitnlm(t(goodIdx),yvals(goodIdx),fitfun,uwparam,'Weight',1./ystd(goodIdx).^2);
    weightedParam=wp.Coefficients.Estimate;
    weightedCI=coefCI(wp);
    if(isempty(resid))
        uwci = NaN(4,2);
    else
        uwci = nlparci(uwparam,resid,'jacobian',J,'alpha',1-0.68);
    end
    disp(parameterNames);
    disp(uwparam);
    disp(weightedParam');
    
    
    
    
    
    
    figure(32);clf;
%     plot(traw, y,'o')
    hold on;
    errorbar(t,yvals,ystd,'b.','MarkerSize',20,'LineWidth',1,'CapSize',0);
    plot(1:.1:max(t), fitfun(uwparam,1:.1:max(t)),'LineWidth',2);
    plot(1:.1:max(t(goodIdx)), fitfun(weightedParam,1:.1:max(t(goodIdx))),'LineWidth',2);
    legend('averaged data','fit','weighted fit');
    if DoubleSine
        title(strcat('Freq1 (Hz) = ', num2str(weightedParam(3)*1000,3), ', Tau1 (ms) = ', ...
        num2str(weightedParam(2),3), ', Freq2 (Hz) = ', num2str(weightedParam(7)*1000,3),...
        ', Tau2 (ms) = ', num2str(weightedParam(6),3)));
    else
    title(strcat('Freq (Hz) = ', num2str(weightedParam(3)*1000,3), ', Tau (ms) = ', ...
        num2str(weightedParam(2),3)));
    end
    ylabel('COM (um)'); xlabel('Osc time (ms)');

    
    OscAnalysis=struct;
    OscAnalysis.unweightedParam=uwparam;
    OscAnalysis.unweightedCI=uwci;
    OscAnalysis.param=weightedParam;
    OscAnalysis.CI=weightedCI;
    OscAnalysis.parameterNames= parameterNames;
end