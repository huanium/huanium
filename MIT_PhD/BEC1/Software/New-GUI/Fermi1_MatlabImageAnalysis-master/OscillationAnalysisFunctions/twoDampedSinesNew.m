function OscAnalysis = twoDampedSinesNew(ana,varargin)
%ana is an analysis object with the relevant cloud positions.  
%Outputs
%    OscAnalysis.unweightedParam, fits means of COM without weights
%     OscAnalysis.param=weightedParam, fits means of COM weighted by
%     inverse variance.  
%Optional inputs

    p = inputParser;

    p.addParameter('fKStart',.125);
    p.addParameter('fNaStart',.071);
    p.addParameter('beating',false);
    p.addParameter('weighting',false);
    p.addParameter('aIB',0);
    p.addParameter('fixNa',false);
    p.addParameter('fixK',false);

    p.addParameter('plotting',false);
    p.addParameter('tau2',[]); %if empty, second sine has no decay
    p.addParameter('discardOutliers',false); %if empty, second sine has no decay
    p.addParameter('specialCase',false);%allows guessing parameters by hand
    p.parse(varargin{:});

    fKStart                 =p.Results.fKStart;
    fNaStart                =p.Results.fNaStart;
    beating                 =p.Results.beating; %gives different initial positions
    weighting               =p.Results.weighting;%whether to perform fit weighted by std error
    aIB                     =p.Results.aIB;%whether to perform fit weighted by std error
    fixNa                   =p.Results.fixNa; %whether to fix the 2nd frequency at strong interactions
    fixK                    =p.Results.fixK;
    plotting                =p.Results.plotting;
    tau2                    =p.Results.tau2;
    discardOutliers         =p.Results.discardOutliers;
    specialCase             =p.Results.specialCase;
        
    if isempty(tau2)
        tau2=100;
        tau2ub=1e3;
        tau2lb=0;
    else
        tau2ub=tau2;
        tau2lb=tau2;
    end

    [t,yvals]=prepareCurveData( ana.xvalsAveraged,ana.yvalsAveraged);

    ystd=ana.yStdAveraged;
    ystd=ystd(~isnan(ana.yvalsAveraged));
% %         %fix 3500a0 by throwing out noisy stuff by hand
% %     if aIB==3500
% %         t=t(1:68);yvals=yvals(1:68);ystd=ystd(1:68);
% %     end
    %throw out points with huge std
    keepIdx=find(ystd<5*median(ystd));
    t=t(keepIdx);yvals=yvals(keepIdx);ystd=ystd(keepIdx);
    if discardOutliers %past 3 standard deviations, throw away
        keep=find(abs(yvals)<=3*std(yvals));
        disp('Throwing out points!');
        t=t(keep); 
        yvals=yvals(keep);
        ystd=ystd(keep);
    end
    %strong interaction limit, in a0, chosen by hand
    aLim=200;
    
    figure(32);clf;
    hold on;
    errorbar(t,yvals,ystd,'b.','MarkerSize',20,'LineWidth',1,'CapSize',0);
    
    %first fit last half of data with one sine wave
    if abs(aIB)<500
        [ ~, cutoff ] = min( abs( t-50 ) );
    else
        [ ~, cutoff ] = min( abs( t-20 ) );
    end
    
    fitprelim=@(p,x) p(1)*sin(2*pi*p(2)*x+p(3));
    if abs(aIB)>aLim
        lastFreq=fNaStart;
    else
        lastFreq=fKStart;
    end
    pGuessPrelim=[range(yvals(cutoff:end))/2, lastFreq,pi];
    opts = optimoptions('lsqcurvefit','Algorithm','trust-region-reflective','Display','off','MaxFunctionEvaluations',1000);
    lower=[0  lastFreq 0];
    upper=[range(yvals)  lastFreq 2*pi];
    paramPrelim = lsqcurvefit(fitprelim,pGuessPrelim,t(cutoff:end),yvals(cutoff:end),lower,upper,opts);
    
    
    %next fit first half of data with decaying sine, after subtracting out
    %previous fit

    remnant=yvals(1:cutoff)-fitprelim(paramPrelim,t(1:cutoff));
    % amp, decay tau, freq, phase
    fitRemnant=@(p,x) p(1)*exp(-x/p(2)).*sin(2*pi*p(3)*x+p(4));
    pGuessRemnant=[range(remnant)/2 t(cutoff)/2 fKStart .8*pi];
    lower=[0 0 fKStart*.8 0];
    upper=[range(remnant) t(cutoff) fKStart*1.2 2*pi];
    paramRemnant=lsqcurvefit(fitRemnant,pGuessRemnant,t(1:cutoff),remnant,lower,upper,opts);
    
    %now fit whole curve
    fitfun = @(p,x) p(1)*exp(-x/p(2)).*sin(2*pi*p(3)*x+p(4))+ ...
        p(5)*exp(-x/p(6)).*sin(2*pi*p(7)*x+p(8)) + p(9);
    parameterNames = {'Amp1','DampTau1','FreqKHz1','Phase1','Amp2','DampTau2',...
        'FreqKHz2','Phase2','offset'};
    %fix tau_Na to be from Na fit
    pGuess= [paramRemnant(1), paramRemnant(2), paramRemnant(3), paramRemnant(4), paramPrelim(1)*1.5, tau2, paramPrelim(2), paramPrelim(3), mean(yvals)];
    lb =    [0              , 0 ,    paramRemnant(3)*.5  , 0     ,0               ,tau2lb   ,0      ,paramPrelim(3)-.5 ,min(yvals)];
    ub =    [range(yvals), 1000, paramRemnant(3)*1.5, 2*pi,        range(yvals)/2, tau2ub, .5, paramPrelim(3)+.5, max(yvals)];
    
    if fixNa & abs(aIB)>aLim &~beating %pure Na freq locking
        ub(2)=paramRemnant(2)*3; %short decay time for K freq
% %         ub(2)=1; %short decay time for K freq

% %         pGuess(2)=1;
        lb(3)=.8*fKStart; %cannot let the 1st freq be too low
        lb(5)=paramPrelim(1); %amp2
        pGuess(7)=fNaStart; %freq2
        lb(7)=fNaStart; %freq2
        ub(7)=fNaStart;
        disp('fixing second frequency to fNa!!!');
    elseif fixNa & abs(aIB)<=aLim &~beating %pure K frequency
        pGuess([1 3 4])=paramPrelim;
        pGuess(2)=100;
        pGuess(7)=fNaStart; %freq2
        lb(7)=fNaStart; %freq2
        ub(7)=fNaStart;
        pGuess(5) = 0.001; %no amplitude in f2
        lb(5)=0.001;
        ub(5)=0.001;
    end
    if fixK
        pGuess(3)=fKStart;
        ub(3)=fKStart;
        lb(3)=fKStart;
    end
    %special cases
    if specialCase
        pGuess=[71.8820    5    0.1250    3.0333   33.3470   57.6747    0.0770    2.0905    9.2199];
        
        lb=-100*ones(size(pGuess));
        ub=1e3*ones(size(pGuess));
        lb(3)=fKStart; %cannot let the 1st freq be too low
        lb(5)=paramPrelim(1); %amp2
        lb(6)=tau2; ub(6)=tau2; lb(7)=fNaStart; ub(7)=fNaStart;
        
%         pGuess=[15    50    0.1250    2    .001   99.7027    0.0666    1.2221    0.1200];
%         lb(3)=.5*fKStart;
%         lb(5)=.001;ub(5)=.001;
        disp('special case, params by hand');
    end
    if beating
        if aIB==-260
            pGuess=[15 100 fKStart -3 10 tau2 .113 -1 0];

        elseif aIB==500
            pGuess=[30 50 fKStart -1 20 tau2 .11 0 -1];
        elseif aIB==740
            pGuess=[45 10 .105 -1.7 3.8 tau2 fNaStart -1.67 -.12];
            pGuess=[30 25 .12 -1.7 3.8 tau2 fNaStart -1.67 -.12];
            lb=[];ub=[];
            lb(2)=10;

        else %-500a0
            pGuess=[15 57 fKStart .455 11 tau2 .113 -2.4 .07];
        end
        disp('special case for beating!!!');

    end

    [uwparam,~,resid,~,~,~,J] = lsqcurvefit(fitfun,pGuess,t,yvals,lb,ub,opts);
    disp('Sum(residuals^2):');
    disp(sum(resid.^2));
    uwci = nlparci(uwparam,resid,'jacobian',J,'alpha',1-0.68);
%     disp(uwci);
    %Weighted fits, discarding data points with no variance
    if weighting
        goodIdx=find(ystd>0);
        wp = fitnlm(t(goodIdx),yvals(goodIdx),fitfun,uwparam,'Weights',1./ystd(goodIdx).^2);
        weightedParam=wp.Coefficients.Estimate;
        weightedCI=coefCI(wp);

    
    end
    
    
    
    

    plot(0:.1:max(t), fitfun(uwparam,0:.1:max(t)),'r','LineWidth',2);

    legend('averaged data','fit');
    if plotting
        plot(0:.1:max(t), fitprelim(paramPrelim,0:.1:max(t)),'--','LineWidth',1.5);
        plot(0:.1:max(t), fitRemnant(paramRemnant,0:.1:max(t)),'--','LineWidth',1.5);

    end
    title(strcat('F1 = ', num2str(uwparam(3)*1000,3), ', Tau1 = ', ...
        num2str(uwparam(2),3), ', A1=', num2str(uwparam(1)),', F2 = ', num2str(uwparam(7)*1000,3),...
        ', Tau2 = ', num2str(uwparam(6),3), ', A2=', num2str(uwparam(5))));

    ylabel('COM (um)'); xlabel('Osc time (ms)');
    
    disp('tau ub - tau');
    disp(num2str(ub(2)-uwparam(2)));
    OscAnalysis=struct;
    OscAnalysis.unweightedParam=uwparam;
    OscAnalysis.unweightedCI=uwci;
    if weighting
        OscAnalysis.param=weightedParam;
        OscAnalysis.CI=weightedCI;
    end
    OscAnalysis.paramRemnant=paramRemnant;
    OscAnalysis.paramPrelim=paramPrelim;
    OscAnalysis.parameterNames= parameterNames;
end