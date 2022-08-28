function du = OBE(t,u,RabiFreq,tRabiFreq,Detuning,tDetuning,T1,T2p,steadyStatePopValue)

% RabiFreq : Time-dependent Rabi frequency [kHz]
% Detuning : Time-dependent Detuning       [kHz]
% T1 : Population decay time               [ms]
% T2p: Polarization decay time             [ms]
% steadyStatePopValue: Steady state population value       [%]

du    = zeros(3,1);

CurrentRabiFreq = interp1(tRabiFreq,RabiFreq,t);
CurrentDetuning = interp1(tDetuning,Detuning,t);

du(1) =   CurrentDetuning * 2 * pi * 10^3 * u(2) - u(1) / (T2p * 10^-3);

du(2) = - CurrentDetuning * 2 * pi * 10^3 * u(1) + CurrentRabiFreq * 2 * pi * 10^3 * u(3) - u(2) / (T2p * 10^-3);

du(3) = - CurrentRabiFreq * 2 * pi * 10^3 * u(2) - (u(3)-steadyStatePopValue) / (T1 * 10^-3);

end