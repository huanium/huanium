function OscAnalysis = singleDampedSine(ana,varargin)
%ana is an analysis object with the relevant cloud positions.  
%Outputs
%    OscAnalysis.unweightedParam, fits means of COM without weights
%     OscAnalysis.param=weightedParam, fits means of COM weighted by
%     inverse variance.  
%Optional inputs

    p = inputParser;

    p.addParameter('fNaStart',.071);
    p.addParameter('fixNa',false);
    p.addParameter('weighting',false);
    p.addParameter('plotting',true);
    p.parse(varargin{:});

    fNaStart                =p.Results.fNaStart;
    weighting               =p.Results.weighting;%whether to perform fit weighted by std error
    fixNa                   =p.Results.fixNa;
    plotting                =p.Results.plotting;
    [t,yvals,ystd]=prepareCurveData( ana.xvalsAveraged,ana.yvalsAveraged,ana.yStdAveraged);
%     ystd=ana.yStdAveraged;
%     ystd=ystd(~isnan(ana.yvalsAveraged));
%     [t,ystd]=prepareCurveData( ana.xvalsAveraged,ana.yStdAveraged);

    %throw out points with huge std
    keepIdx=find(ystd<10*median(ystd));
    t=t(keepIdx);yvals=yvals(keepIdx);ystd=ystd(keepIdx);

    %strong interaction limit, in a0, chosen by hand
    aLim=500;
    
    if plotting
    figure(31);clf;
    hold on;
    errorbar(t,yvals,ystd,'b.','MarkerSize',20,'LineWidth',1,'CapSize',0);
    end
    
    
    %now fit whole curve
    fitfun = @(p,x) p(1)*exp(-x/p(2)).*sin(2*pi*p(3)*x+p(4))+p(5);
    parameterNames = {'Amp1','DampTau1','FreqKHz1','Phase1','offset'};
    %fix tau_Na to be effectively inf
    pGuess= [range(yvals)/2, 100, fNaStart, .8*pi, mean(yvals)];
    lb =    [0              , 0 ,    fNaStart*.5  , 0     ,min(yvals)];
    ub =    [range(yvals), 10000, fNaStart*1.5, 2*pi,     max(yvals)];
    
    if fixNa 


        lb(3)=fNaStart; %freq2
        ub(3)=fNaStart;
        disp('fixing second frequency to fNa!!!');
    end
    
    
    opts = optimoptions('lsqcurvefit','Algorithm','trust-region-reflective','Display','off','MaxFunctionEvaluations',1000);

    [uwparam,~,resid,~,~,~,J] = lsqcurvefit(fitfun,pGuess,t,yvals,lb,ub,opts);

    uwci = nlparci(uwparam,resid,'jacobian',J,'alpha',1-0.68);
%     disp(uwci);
    %Weighted fits, discarding data points with no variance
    if weighting
        goodIdx=find(ystd>0);
        wp = fitnlm(t(goodIdx),yvals(goodIdx),fitfun,uwparam,'Weights',1./ystd(goodIdx).^2);
        weightedParam=wp.Coefficients.Estimate;
        weightedCI=coefCI(wp);

    
    end
    if plotting
    plot(0:.1:max(t), fitfun(uwparam,0:.1:max(t)),'r','LineWidth',2);

    legend('averaged data','fit');

    title(strcat('A1=',num2str(uwparam(1),3), ' Tau1=', num2str(uwparam(2),3),' F1=',...
        num2str(uwparam(3)*1000,3)));

    ylabel('COM (um)'); xlabel('Osc time (ms)');
    end
    
    OscAnalysis=struct;
    OscAnalysis.unweightedParam=uwparam;
    OscAnalysis.unweightedCI=uwci;
    if weighting
        OscAnalysis.param=weightedParam;
        OscAnalysis.CI=weightedCI;
    end

    OscAnalysis.parameterNames= parameterNames;
end