function OscAnalysis = singleDampedSineModel(ana,varargin)
%ana is an analysis object with the relevant cloud positions.  
%Outputs
%    OscAnalysis.unweightedParam, fits means of COM without weights
%     OscAnalysis.param=weightedParam, fits means of COM weighted by
%     inverse variance.  
%Optional inputs

    p = inputParser;
    p.addParameter('fixNa',false);
    p.addParameter('fNaStart',.077);
    p.addParameter('weighting',false);
    p.parse(varargin{:});
    fixNa                   =p.Results.fixNa;
    fNaStart                =p.Results.fNaStart;
    weighting               =p.Results.weighting;%whether to perform fit weighted by std error
    [t,yvals]=prepareCurveData( ana.xvalsAveraged,ana.yvalsAveraged);
    ystd=ana.yStdAveraged;
    ystd=ystd(~isnan(ana.yvalsAveraged));
    
    %throw out points with huge std
    keepIdx=find(ystd<10*median(ystd));
    t=t(keepIdx);yvals=yvals(keepIdx);ystd=ystd(keepIdx);

   
    figure(36);clf;
    hold on;
    errorbar(t,yvals,ystd,'b.','MarkerSize',20,'LineWidth',1,'CapSize',0);

    %now fit whole curve
    fitfun = @(p,x) p(1)*exp(-x/p(2)).*sin(sqrt((2*pi)^2*p(3)^2-1/p(2)^2)*x+p(4))+p(5)
    parameterNamesTemp = {'Amp1','DampTau1','fNaBare','Phase1'};

    %fix tau_Na to be effectively inf
    pGuess= [range(yvals)/2, 200, fNaStart,.8*pi, mean(yvals)];
    lb =    [0              , 0 ,.8*fNaStart, 0     ,min(yvals)];
    ub =    [range(yvals), 10000,1.2*fNaStart,  2*pi,     max(yvals)];
    
    if fixNa
        lb(3)=fNaStart;
        ub(3)=fNaStart;
    end
    opts = optimoptions('lsqcurvefit','Algorithm','trust-region-reflective','Display','off','MaxFunctionEvaluations',1e4);

    [para,~,resid,~,~,~,J] = lsqcurvefit(fitfun,pGuess,t,yvals,lb,ub,opts);
    disp('Sum(residuals^2):');
    disp(sum(resid.^2))
    paraci = nlparci(para,resid,'jacobian',J,'alpha',1-0.68);
%     disp(paraci);
    %Weighted fits, discarding data points with no variance
    if weighting
        goodIdx=find(ystd>0);
        wp = fitnlm(t(goodIdx),yvals(goodIdx),fitfun,para,'Weights',1./ystd(goodIdx).^2);
        weightedParam=wp.Coefficients.Estimate;
        weightedCI=coefCI(wp);
  
    end
    plot(0:.1:max(t), fitfun(para,0:.1:max(t)),'r','LineWidth',2);

    legend('averaged data','fit');

    title(strcat('F2 = ',num2str(1000*sqrt(para(3)^2-1/para(2)^2/(2*pi)^2),3),', A2=',num2str(para(1),3), ' Tau2=', num2str(para(2),3)));

    ylabel('COM (um)'); xlabel('Osc time (ms)');
    
    parameterNames = {'Amp1','DampTau1','FreqKHz1','Phase1','offset'};
    
    uwparam=para;
    uwci=paraci;
    uwparam(3)=sqrt(para(3)^2-1/para(2)^2/(2*pi)^2); %the actual fit freq, not the bare Na freq
    
    OscAnalysis=struct;
    OscAnalysis.unweightedParam=uwparam;
    OscAnalysis.unweightedCI=uwci;
    if weighting
        OscAnalysis.param=weightedParam;
        OscAnalysis.CI=weightedCI;
    end

    OscAnalysis.parameterNames= parameterNames;
end