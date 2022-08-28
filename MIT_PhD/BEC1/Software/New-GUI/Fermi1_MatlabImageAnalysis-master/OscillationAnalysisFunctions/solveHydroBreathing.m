function [times,y] = solveHydroBreathing(omegas,modFreq,NCycles,amplitudes,phases,beamRatio)
    phaseY      = phases(1);
    phaseZ      = phases(2);
    ampYdrive   = amplitudes(1);
    ampZdrive   = amplitudes(2);
    times       = 0:0.0001:NCycles/modFreq;


    omegaX = omegas(1);
    omegaY = omegas(2);
    omegaZ = omegas(3);

    Sys = @(t,Y,omegaX,omegaY,omegaZ) ...
        [Y(2);...
        -(1+(1-beamRatio)*ampYdrive*sin(2*pi*modFreq*t + phaseY*pi/180) + beamRatio*ampZdrive*sin(2*pi*modFreq*t + phaseZ*pi/180)) * omegaX^2*Y(1)  + omegaX^2/(Y(1)^2*Y(3)*Y(5));...
        Y(4);...
        -(1+ampYdrive*sin(2*pi*modFreq*t + phaseY*pi/180)) * omegaY^2*Y(3) + omegaY^2/(Y(1)*Y(3)^2*Y(5));...
        Y(6);...
        -(1+ampZdrive*sin(2*pi*modFreq*t + phaseZ*pi/180)) * omegaZ^2*Y(5) + omegaZ^2/(Y(1)*Y(3)*Y(5)^2) ];

    Y0=[1 0 1 0 1 0];

    [~,y] = ode45(@(t,Y) Sys(t,Y,omegaX,omegaY,omegaZ), times, Y0);


end