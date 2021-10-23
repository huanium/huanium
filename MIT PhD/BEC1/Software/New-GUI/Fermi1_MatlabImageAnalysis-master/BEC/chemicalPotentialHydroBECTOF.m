function [analysis] = chemicalPotentialHydroBECTOF(params, widths,widthCis,Omegas,excludeIdx,TOFthreshold,varargin)
    %OUTPUTS
    %TF: thomas-Fermi radius in microns
    %mu: kHz
    %mu confidence interval
    %speed of sound (micron/ms)
    %trap freq (rad/s)

    p = inputParser;
    
    p.addParameter('Axis','Z');
    p.addParameter('FromBoseFit',true);
    p.addParameter('camPix',2.49);%2.48
    p.parse(varargin{:});
    
    axis  = p.Results.Axis;
    FromBoseFit  = p.Results.FromBoseFit;
    pixel= p.Results.camPix;
    
    if(strcmp(axis,'X'))
        omega = Omegas(1);
    elseif(strcmp(axis,'Y'))
        omega = Omegas(2);
    elseif(strcmp(axis,'Z'))
        omega = Omegas(3);
    end
    
    

    mask = true(length(params),1);
    mask(excludeIdx) = false;
    %find nans in data or ci
    %nanMask = ~isnan(widthCis(:,1));
    %mask=mask.*nanMask;
    %nanMask = ~isnan(widthCis(:,2));
    %mask=mask.*nanMask;
    nanMask = ~isnan(widths);
    mask=logical(mask.*nanMask);
    
    idx = find(params<TOFthreshold);
    mask(idx) = false;
    
    %Constants
    mass=mNa;
    
    if(FromBoseFit) %widths given in meters already
        [xData, yData] = prepareCurveData(params/1000, widths'*1e6 );
        widthCis = widthCis*1e6/pixel;
    else %widths given in pixel size
        [xData, yData] = prepareCurveData(params/1000, widths'*pixel ); %convert to micron
    end
    
    %

    lb      = [0.1]; 
    pGuess  = [2];
    ub      = [100];
    hydroXvals = 0:0.000001:max(xData(mask));
    hydroArray = HydroBECTOF(hydroXvals,Omegas,'Axis',axis);
    fitfun = @(p,x) 10^6*sqrt(2*p(1)*10^3*PlanckConst./(mass*omega^2)).*interp1(hydroXvals,hydroArray,x);
    weighted_deviations = @(p) (fitfun(p,xData(mask))-yData(mask))./((widthCis(mask,2)-widthCis(mask,1))./2);
     weighted_deviations = @(p) (fitfun(p,xData(mask))-yData(mask));
%     figure(123)
%     clf;
%     plot(xData,yData,'.','MarkerSize',20);
%     hold on
%     plot(hydroXvals,fitfun(pGuess,hydroXvals));
%     hold off
    optio = optimoptions(@lsqnonlin,'Algorithm','trust-region-reflective','Display','off','MaxFunctionEvaluations',100);
    [param_fit,~,resid,~,~,~,J]=lsqnonlin(weighted_deviations,pGuess,lb,ub,optio);

    if(isempty(resid))
        tempCi = NaN(1,2);
    else
        tempCi = nlparci(param_fit,resid,'jacobian',J);
    end

    plot(hydroXvals,fitfun(param_fit,hydroXvals),'LineWidth',2);
    hold on;
    errorbar(xData(mask),yData(mask),yData(mask)-widthCis(mask,1)*pixel,widthCis(mask,1)*pixel-yData(mask),'.','MarkerSize',20);
    errorbar(xData(~mask),yData(~mask),yData(~mask)-widthCis(~mask,1)*pixel,widthCis(~mask,1)*pixel-yData(~mask),'.','MarkerSize',20);
    hold off
    legend('Width(\mum) vs. time(ms)','Location','Best'  );
    trapfreq=omega/2/pi;
    title({['\mu(kHz) = ', num2str(param_fit,2),' [', num2str(tempCi(1),2),' - ', num2str(tempCi(2),2),'];  c(\mum/ms) = ',num2str(1000*sqrt(1000*param_fit*PlanckConst/mass),2) '; F(Hz) = ', num2str(trapfreq) ]; ...
          ['TF radius (\mum) = ', num2str(fitfun(param_fit,0),2)]});
    % Label axes
    xlabel time(s)
    ylabel width(\mum)
    grid on
    ylim([0.1*min(fitfun(param_fit,hydroXvals)),1.2*max(yData(mask))]);
    analysis = struct;
    analysis.TF = fitfun(param_fit,0);
    analysis.TFinTOF=fitfun(param_fit, params/1000);
    analysis.chemicalPot = param_fit;
    analysis.chemicalPotCi = tempCi;
    analysis.speedOfSound = 1000*sqrt(1000*param_fit*PlanckConst/mass);
    analysis.Omegas = Omegas;
    

end
