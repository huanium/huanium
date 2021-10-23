function spectrum = ThreeLvLSpectrumFunction(p,x,t)

    timestep = 1;
    times = 0:timestep:t;

    Omega_PE_0  = 2*pi*p(1); %MHz
    Omega_ME_0  = 2*pi*p(2); %MHz
    
    delta_2Photon = 2*pi*p(3);
    
    freqCenter = 2*pi*p(4);
    amplitude = p(5);
    offset = p(6);
    

    Omega_PE = @(t) Omega_PE_0;
    Omega_ME = @(t) Omega_ME_0;

    detunings = 2*pi*x;
    polaronEndState = [];
    
    
    Omega_PE = @(t) Omega_PE_0;
    Omega_ME = @(t) Omega_ME_0;

    for idx = 1:length(detunings)
        stateTimeVec = ThreeLvlSolverEngine(Omega_PE,Omega_ME,times,'delta_1Photon',detunings(idx)-freqCenter,'delta_2Photon',delta_2Photon);
        polaronEndState(idx) = abs(stateTimeVec(end,2)).^2;
    end

    spectrum = offset+amplitude*polaronEndState;
    
end