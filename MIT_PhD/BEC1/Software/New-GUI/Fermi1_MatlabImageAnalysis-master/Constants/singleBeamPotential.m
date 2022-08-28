function U = singleBeamPotential(element,lambda,waist,power,posVec)
    if strcmp(element,'Na')
        lambda_D1 = 589.158326e-9;
        lambda_D2 = 589.756661e-9;

        Gamma_D1 = 2 * pi * 9.795e6;
        Gamma_D2 = 2 * pi * 9.765e6;

        CouplingStrengt_D1 = 0.3199;
        CouplingStrengt_D2 = 0.6405;
    elseif strcmp(element,'K')
        lambda_D1 = 770.11e-9;
        lambda_D2 = 766.70e-9;

        Gamma_D1 = 2 * pi * 5.956e6;
        Gamma_D2 = 2 * pi * 6.035e6;

        CouplingStrengt_D1 = 0.3199;
        CouplingStrengt_D2 = 0.6405;
    else
        error('unknown element, only K and Na allowed')
    end
    
    U1 = -3*pi*speedOfLight^2./(2*angularFreq(lambda_D1).^3).*Gamma_D1*CouplingStrengt_D1*...
        (1/(angularFreq(lambda_D1)-angularFreq(lambda))+1/(angularFreq(lambda_D1)+angularFreq(lambda))).*...
        GaussianBeamIntensity(lambda,waist,power,posVec);
    
    U2 = -3*pi*speedOfLight^2./(2*angularFreq(lambda_D2).^3).*Gamma_D2*CouplingStrengt_D2*...
        (1/(angularFreq(lambda_D2)-angularFreq(lambda))+1/(angularFreq(lambda_D2)+angularFreq(lambda))).*...
        GaussianBeamIntensity(lambda,waist,power,posVec);
    
    U = U1+U2;
    
end

