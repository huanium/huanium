function DCvalue = getDCValue(xvals,yvals,varargin)
    p = inputParser;
    p.addParameter('fitWeigths',NaN);

    p.parse(varargin{:});
    fitWeigths   = p.Results.fitWeigths;


    fitfun = @(p,x) p(1);
    parameterNames = {'off','slope'};
    pGuess  = [50];
    lb      = [-inf];
    ub      = [inf];
    if isnan(fitWeigths)
        weighted_deviations = @(p) (fitfun(p,xvals(:))-yvals(:)); 
    else
        weighted_deviations = @(p) (fitfun(p,xvals(:))-yvals(:)).*fitWeigths; 
    end
    optio = optimoptions(@lsqnonlin,'Algorithm','trust-region-reflective','Display','off','MaxFunctionEvaluations',100);
    [paramLinear,~,resid,~,~,~,J]=lsqnonlin(weighted_deviations,pGuess,lb,ub,optio);
    try
        ciLinearNa = nlparci(paramLinear,resid,'jacobian',J);
    catch
        ciLinearNa = [NaN;NaN];
    end

    DCvalue = paramLinear(1);
end