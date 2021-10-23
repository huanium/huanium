function Ugrad = BgradPotential(element,dBdz,height)
    if strcmp(element,'Na')
        muBFactor = 0.5;
    elseif strcmp(element,'K92')
        muBFactor = 1;
    elseif strcmp(element,'K72')
        muBFactor = 1-1/9;
    else
        error('unknown element, only K and Na allowed')
    end
    Ugrad = muBFactor*muBohr*dBdz*height*1e-2;
end