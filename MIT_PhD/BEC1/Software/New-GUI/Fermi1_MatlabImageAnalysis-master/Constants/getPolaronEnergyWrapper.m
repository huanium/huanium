function [Ep_m92_att,Ep_m72_att,Ep_m72_rep,Efb_m7_thry,Eb_exp] = getPolaronEnergyWrapper(Bfield,bosonDensity)


    ResPos = 89.8;
    ResDelta = 8.8;
    aBackgraound = -730;
    fbParam92 = [ResPos,ResDelta,aBackgraound];
    % Tiemann values
    ResPos = 110.3;
    ResDelta = 17.05;
    aBackgraound = -710;
    % fitted values
    
    ResPos = 111.6;
    ResDelta = 20.1;
    aBackgraound = -710;
    fbParam72 = [ResPos,ResDelta,aBackgraound];

    [~,~,~,Ep_m92_att,~,~,~]                = Ep_analytic(Bfield,fbParam92,bosonDensity);
    [~,~,~,Ep_m72_att,~,Ep_m72_rep,~,~,~]   = Ep_analytic(Bfield,fbParam72,bosonDensity);
    [Eb_exp,Efb_m7_thry,~,~,~,~,~]                = fb_molecules_m72(Bfield);
    
    Ep_m92_att = real(Ep_m92_att);
    Ep_m72_att = real(Ep_m72_att);
    Ep_m72_rep = real(Ep_m72_rep);
    Efb_m7_thry = real(Efb_m7_thry);
end