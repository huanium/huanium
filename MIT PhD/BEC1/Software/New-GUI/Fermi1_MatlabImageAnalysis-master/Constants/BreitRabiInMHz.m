function Freq=BreitRabiInMHz(B,m1,m2)
    Inuc = 4;
    ahf = -285.7308*10^6;
    gI = .00017649;
    gJ = 2.00229421;
    muB = 927.4009994*10^(-26);

    x = @(B) (gJ - gI)*muB*B/10000/((Inuc + 1/2)*ahf*PlanckConst);
    Energy = @(B,m) -ahf*PlanckConst/4 + gI*muB*m*B/10000 + ahf*PlanckConst*(Inuc + 1/2)/2*sqrt(1 + 4*m*x(B)/(2*Inuc + 1) + x(B).^2);
    RFFreq = @(B,m1,m2) (Energy(B,m1)-Energy(B,m2))/PlanckConst/1000000;
    Freq = RFFreq(B,m1,m2);
end