function stateTimeVec = ThreeLvlSolverEngine(Omega_PE,Omega_ME,times, varargin)
    p = inputParser;
    p.addParameter('delta_1Photon',2*pi*0);
    p.addParameter('delta_2Photon',2*pi*0);
    p.addParameter('lightShift1PhotonPerMhzPE',0);
    p.addParameter('lightShift2PhotonPerMhzPE',0);
    
    p.addParameter('gammaE',2*pi*12);
    p.addParameter('gammaP',2*pi*0);
    p.addParameter('gammaM',2*pi*0);
    
    p.addParameter('plotDetuning',false);

    p.parse(varargin{:});
    
    delta_1Photon   = p.Results.delta_1Photon;
    delta_2Photon   = p.Results.delta_2Photon;
    lightShift1PhotonPerMhzPE   = p.Results.lightShift1PhotonPerMhzPE;
    lightShift2PhotonPerMhzPE   = p.Results.lightShift2PhotonPerMhzPE;
    
    gammaE  = p.Results.gammaE;
    gammaP  = p.Results.gammaP;
    gammaM  = p.Results.gammaM;
    
    plotDetuning  = p.Results.plotDetuning;
    
    if plotDetuning
        figure(971),clf;
        subplot(1,2,1)
        plot(times,(delta_2Photon+lightShift2PhotonPerMhzPE*Omega_PE(times))/2/pi)
        subplot(1,2,2)
        plot(times,(delta_1Photon+lightShift1PhotonPerMhzPE*Omega_PE(times))/2/pi)
    end

    E_Prime = @(t,E,P,M) 1/1i*(((delta_2Photon+lightShift2PhotonPerMhzPE*Omega_PE(t)) + (delta_1Photon+lightShift1PhotonPerMhzPE*Omega_PE(t)) - 1i*gammaE/2)*E+1/2*(Omega_PE(t)*P+Omega_ME(t)*M));
    P_Prime = @(t,E,P,M) 1/1i*( -1i*gammaP/2*P + 1/2*Omega_PE(t)*E);
    M_Prime = @(t,E,P,M) 1/1i*( ((delta_2Photon+lightShift2PhotonPerMhzPE*Omega_PE(t))-1i*gammaM/2)*M + 1/2*Omega_ME(t)*E);


    ThreeLvLSys = @(t,Y)   [E_Prime(t,Y(1),Y(2),Y(3));...
                            P_Prime(t,Y(1),Y(2),Y(3));...
                            M_Prime(t,Y(1),Y(2),Y(3)) ];

    Y0=[0,1,0];

    [~,stateTimeVec] = ode45(@(t,Y) ThreeLvLSys(t,Y), times, Y0);

end