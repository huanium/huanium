NCycles = 10;
phases(1) = 0;
phases(2) = 0;
amplitudes(1) = 0.1;
amplitudes(2) = 0.0;
modFreq = 10; % Hz not radian

omegas(1) = 2*pi*103;
omegas(2) = 2*pi*94;
omegas(3) = 2*pi*10.2;

[times,diffEqSolution] = solveHydroBreathing(omegas,modFreq,NCycles,amplitudes,phases);

figure(27),clf
hold on
plot(times,diffEqSolution(:,1))
plot(times,diffEqSolution(:,3))
plot(times,diffEqSolution(:,5))
hold off


%%

NCycles = 10;
phases(1) = 0;
phases(2) = 0;
amplitudes(1) = 0.1;
amplitudes(2) = 0.0;
modFreq = 10; % Hz not radian

modFreq = 100:0.1:300;
xEndArray = [];
yEndArray = [];
zEndArray = [];

for idx = 1:length(modFreq)
    [times,diffEqSolution] = solveHydroBreathing(omegas,modFreq(idx),NCycles,amplitudes,phases);
    xEndArray(idx) = diffEqSolution(end,1);
    yEndArray(idx) = diffEqSolution(end,3);
    zEndArray(idx) = diffEqSolution(end,5);
end

figure(28),clf
hold on
plot(modFreq,xEndArray)
plot(modFreq,yEndArray)
plot(modFreq,zEndArray)
hold off



