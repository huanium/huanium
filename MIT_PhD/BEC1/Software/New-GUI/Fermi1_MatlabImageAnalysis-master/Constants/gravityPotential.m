function Ugrav = gravityPotential(element,height)
    if strcmp(element,'Na')
        m = mNa;
    elseif strcmp(element,'K')
        m = mK;
    else
        error('unknown element, only K and Na allowed')
    end
    g = 9.80665;
    Ugrav = m*g*height;
end