%% Simulate Pi Pulse

SimulatePiPulse = OBESolver;
SimulatePiPulse.FreqOffSetSpectrum = 0; %kHz
SimulatePiPulse.cRabiFreq = 13; %kHz
SimulatePiPulse.AdjustSquarePulseTimeToPiCriterium;
SimulatePiPulse.timePulse = 11*SimulatePiPulse.timePulse;
SimulatePiPulse.Span        = 50; %kHz
SimulatePiPulse.NfSpectrum  = 101; %number of points to simulate
SimulatePiPulse.T1          = 10000; %ms
SimulatePiPulse.T2p         = 10000; %ms
hold on
SimulatePiPulse.GenerateSpectrum('SquarePulse');
hold off
%% Simulate Gaussian Pulse 
SimulateGaussianPulse = OBESolver;
SimulateGaussianPulse.FreqOffSetSpectrum = 0; %kHz
SimulateGaussianPulse.gaussianPulseSigma = 0.250; %ms
SimulateGaussianPulse.timePulse = 8*SimulateGaussianPulse.gaussianPulseSigma;
SimulateGaussianPulse.AdjustGaussianPulseRabiFrequencyToPiCriterium;
SimulateGaussianPulse.cRabiFreq = 13;
SimulateGaussianPulse.Span        = 2; %kHz
SimulateGaussianPulse.NfSpectrum  = 51; %number of points to simulate
SimulateGaussianPulse.T1          = 1000; %ms
SimulateGaussianPulse.T2p         = 0.1; %ms
SimulateGaussianPulse.GenerateSpectrum('GaussianPulse');
%% Rabi Osci Square Pulse (also off resonant)
SimulatePiPulse = OBESolver;
SimulatePiPulse.FreqOffSetSpectrum = 0; %kHz
SimulatePiPulse.cRabiFreq = 13;%kHz
SimulatePiPulse.T1          = 10000; %ms
SimulatePiPulse.T2p         = 10000; %ms
SimulatePiPulse.cDetuning    = 20; %kHz

numPoints = 200;
OffResRabi1 = zeros(1,numPoints);
for idx = 1:numPoints
    SimulatePiPulse.timePulse = 0.001*idx;
    SimulatePiPulse.Solve('SquarePulse' );
    OffResRabi1(idx) = 0.5*(SimulatePiPulse.Overlap+1);
end

figure(331);
clf;
plot(OffResRabi1)
ylabel('Population transfer')
xlabel('time (us)')
%just for fun show evolution of Bloch vector
SimulatePiPulse.Plot

%% Rabi Osci Gaussian Pulse (also off resonant)

SimulateGaussianPulse = OBESolver;
SimulateGaussianPulse.FreqOffSetSpectrum = 0; %kHz
SimulateGaussianPulse.cRabiFreq = 13;
SimulateGaussianPulse.T1          = 10000; %ms
SimulateGaussianPulse.T2p         = 10000; %ms
SimulateGaussianPulse.cDetuning   = 10; %kHz
SimulateGaussianPulse.T1          = 1000; %ms
SimulateGaussianPulse.T2p         = 1000; %ms

numPoints = 200;
OffResRabi1 = zeros(1,numPoints);
for idx = 1:numPoints
    SimulateGaussianPulse.gaussianPulseSigma = 0.001*idx;
    SimulateGaussianPulse.timePulse = 8*SimulateGaussianPulse.gaussianPulseSigma;
    SimulateGaussianPulse.Solve('GaussianPulse' );
    OffResRabi1(idx) = 0.5*(SimulateGaussianPulse.Overlap+1);
end

figure(331);
clf;
plot(OffResRabi1)
ylabel('Population transfer')
xlabel('Gaussian sigma (us)')
%just for fun show evolution of Bloch vector
SimulatePiPulse.

%% Rabi Osci Square Pulse (also off resonant)
SimulatePiPulse = OBESolver;
SimulatePiPulse.FreqOffSetSpectrum = 0; %kHz
SimulatePiPulse.cRabiFreq   = 13;%kHz
SimulatePiPulse.T1          = 0.1; %ms
SimulatePiPulse.T2p         = 0.005; %ms

numPoints = 200;
OffResRabi1 = zeros(1,numPoints);
for idx = 1:numPoints
    SimulatePiPulse.timePulse = 0.0005*(idx-0.99);
    SimulatePiPulse.Solve('SquarePulse' );
    OffResRabi1(idx) = 0.5*(SimulatePiPulse.Overlap+1);
end

SimulatePiPulse.FreqOffSetSpectrum = 0; %kHz
SimulatePiPulse.cRabiFreq   = 13;%kHz
SimulatePiPulse.T1          = 1000; %ms
SimulatePiPulse.T2p         = 1000; %ms
numPoints = 200;
OffResRabi2 = zeros(1,numPoints);
for idx = 1:numPoints
    SimulatePiPulse.timePulse = 0.0005*(idx-0.99);
    SimulatePiPulse.Solve('SquarePulse' );
    OffResRabi2(idx) = 0.5*(SimulatePiPulse.Overlap+1);
end

SimulatePiPulse.cDetuning = 6; %kHz
SimulatePiPulse.cRabiFreq   = 13;%kHz
SimulatePiPulse.T1          = 1000; %ms
SimulatePiPulse.T2p         = 1000; %ms
numPoints = 200;
OffResRabi3 = zeros(1,numPoints);
for idx = 1:numPoints
    SimulatePiPulse.timePulse = 0.0005*(idx-0.99);
    SimulatePiPulse.Solve('SquarePulse' );
    OffResRabi3(idx) = 0.5*(SimulatePiPulse.Overlap+1);
end

SimulatePiPulse.cDetuning = 10; %kHz
SimulatePiPulse.cRabiFreq   = 13;%kHz
SimulatePiPulse.T1          = 1000; %ms
SimulatePiPulse.T2p         = 1000; %ms
numPoints = 200;
OffResRabi4 = zeros(1,numPoints);
for idx = 1:numPoints
    SimulatePiPulse.timePulse = 0.0005*(idx-0.99);
    SimulatePiPulse.Solve('SquarePulse' );
    OffResRabi4(idx) = 0.5*(SimulatePiPulse.Overlap+1);
end

SimulatePiPulse.cDetuning = 15; %kHz
SimulatePiPulse.cRabiFreq   = 13;%kHz
SimulatePiPulse.T1          = 1000; %ms
SimulatePiPulse.T2p         = 1000; %ms
numPoints = 200;
OffResRabi5 = zeros(1,numPoints);
for idx = 1:numPoints
    SimulatePiPulse.timePulse = 0.0005*(idx-0.99);
    SimulatePiPulse.Solve('SquarePulse' );
    OffResRabi5(idx) = 0.5*(SimulatePiPulse.Overlap+1);
end
%%
figure(331);
clf;

hold on
%plot(linspace(0,1,length(OffResRabi2)),OffResRabi2,'LineWidth',2)
%plot(linspace(0,1,length(OffResRabi3)),OffResRabi3,'LineWidth',2)
%plot(linspace(0,1,length(OffResRabi4)),OffResRabi4,'LineWidth',2)
%plot(linspace(0,1,length(OffResRabi5)),OffResRabi5,'LineWidth',2)
plot(linspace(0,1,length(OffResRabi1)),OffResRabi1,'k','LineWidth',2)
hold off
ylabel('Population transfer')
xlabel('time')
set(gca,'FontSize', 14);
set(gca, 'FontName', 'Arial')
box on
ylim([0,1])
%just for fun show evolution of Bloch vector
%SimulatePiPulse.Plot
%ylim([0,1])