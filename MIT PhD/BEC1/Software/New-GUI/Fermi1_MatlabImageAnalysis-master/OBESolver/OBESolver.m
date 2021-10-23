classdef OBESolver < handle
    
    properties
        T                   =      [];   % Time Intervalls of Integration tbd
        U                   =      [];   % Time Evolution of the Bloch vector tbd
        cRabiFreq           =      52;   % [kHz]
        timePulse           =   0.010;   % [ms]
        cDetuning           =       0;   % [kHz]
        AdiabSpan           =      50;   % [kHz]
        gaussianPulseSigma  =   0.015;   % [ms]
        startQubit          = [0 0 1];   % Start Qubit
        goalQubit           =[0 0 -1];   % Goal Qubit
        finalQubit          =      [];   % Final Qubit
        Overlap             =      [];   % Overlap of Goal and Final Qubit
        T1                  =     100;   % [ms]
        T2p                 =   0.250;   % [ms]
        steadyStatePopValue =       0;   % [%]
        NtRabiFreq          =    1000;   % Number of time steps for Rabi frequency
        NtDetuning          =    1000;   % Number of time steps for detuning
        tRabiFreq           =      [];   % ---
        RabiFreq            =      [];   % ---
        tDetuning           =      [];   % ---
        Detuning            =      [];   % ---
        SDetunings          =      [];   % ---
        Spectrum            =      [];   % Spectrum of the current pulse
        Span                =     100;   % Span of Spectrum [kHz]
        NfSpectrum          =     100;   % Number of Points in Spectrum
        FreqOffSetSpectrum  =       0; 
        verbose             =    true;
    end
    
    methods
        
        function AdjustSquarePulseTimeToPiCriterium(this)
            this.timePulse     = 1/(2*this.cRabiFreq); 
        end
        
        function AdjustGaussianPulseRabiFrequencyToPiCriterium(this,varargin)
            p = inputParser;
            p.addParamValue('Sigma',this.gaussianPulseSigma);
            parse(p,varargin{:});
            this.gaussianPulseSigma = p.Results.Sigma;
            this.cRabiFreq = fminsearch(@(w) abs(0.5-integral(@(t) w*exp(-((t-this.timePulse/2)/sqrt(2)/this.gaussianPulseSigma).^2),0,this.timePulse)),0);                      
        end
      
        
        function Solve(this,TypeOfPulse,varargin)
            p = inputParser;
            p.addParamValue('Sigma',this.gaussianPulseSigma);
            parse(p,varargin{:});
            this.gaussianPulseSigma = p.Results.Sigma;
            
            switch TypeOfPulse
                case 'SquarePulse'                    
                    this.tRabiFreq  = linspace(0,this.timePulse/10^3,this.NtRabiFreq);
                    this.RabiFreq   = this.cRabiFreq*ones(1,this.NtRabiFreq);
                    
                    this.tDetuning  = linspace(0,this.timePulse/10^3,this.NtRabiFreq);
                    this.Detuning   = this.cDetuning*ones(1,this.NtDetuning);
                    
                    [this.T,this.U] = ode45(@(t,u) OBE(t,u,this.RabiFreq,this.tRabiFreq,this.Detuning,this.tDetuning,this.T1,this.T2p,this.steadyStatePopValue),[0,this.timePulse/10^3],this.startQubit);
                    
                    this.finalQubit     = this.U(end,:);
                    
                    this.Overlap    = dot(this.finalQubit,this.goalQubit);
                    
                case 'GaussianPulse'                    
                    this.tRabiFreq  = linspace(0,this.timePulse/10^3,this.NtRabiFreq);
                    this.RabiFreq   = this.cRabiFreq*this.gaussianPulseSigma/10^3*sqrt(2*pi)*normpdf(this.tRabiFreq,this.timePulse/10^3/2,this.gaussianPulseSigma/10^3);
                    
                    this.tDetuning  = linspace(0,this.timePulse/10^3,this.NtRabiFreq);
                    this.Detuning   = this.cDetuning*ones(1,this.NtDetuning);
                    
                    [this.T,this.U] = ode45(@(t,u) OBE(t,u,this.RabiFreq,this.tRabiFreq,this.Detuning,this.tDetuning,this.T1,this.T2p,this.steadyStatePopValue),[0,this.timePulse/10^3],this.startQubit);
                    
                    this.finalQubit     = this.U(end,:);
                    
                    this.Overlap    = dot(this.finalQubit,this.goalQubit);
                    
                case 'AdiabaticPassage'
                    this.tRabiFreq  = linspace(0,this.timePulse/10^3,this.NtRabiFreq);
                    this.RabiFreq   = this.cRabiFreq*sin(pi*this.tRabiFreq./(10^-3*this.timePulse)).^2;
                    
                    this.tDetuning  = linspace(0,this.timePulse/10^3,this.NtRabiFreq);
                    this.Detuning   = this.cDetuning+this.AdiabSpan*sign(this.tDetuning-this.timePulse/10^3/2).*sqrt(1-sin(pi*this.tDetuning./(10^-3*this.timePulse)).^4);               
                    
                    [this.T,this.U]      = ode45(@(t,u) OBE(t,u,this.RabiFreq,this.tRabiFreq,this.Detuning,this.tDetuning,this.T1,this.T2p,this.steadyStatePopValue),[0,this.timePulse/10^3],this.startQubit);
                    
                    this.finalQubit     = this.U(end,:);
                    
                    this.Overlap    = dot(this.finalQubit,this.goalQubit);
                    
                otherwise
                    warning('Unknown type of pulse has been selected.');
                         
            end
        end
        
        function GenerateSpectrum(this,TypeOfPulse)
            this.Spectrum = [];
            this.SDetunings = [];
            switch TypeOfPulse
                case 'SquarePulse'   
                    this.tRabiFreq  = linspace(0,this.timePulse/10^3,this.NtRabiFreq);
                    this.RabiFreq   = this.cRabiFreq*ones(1,this.NtRabiFreq);
                    
                    this.SDetunings = linspace(-this.Span,this.Span,this.NfSpectrum);
                    
                    for j=1:this.NfSpectrum
                        if(this.verbose)
                            disp(['Generating Spectrum. Current Iteration: ' num2str(j) ' of ' num2str(this.NfSpectrum)]);
                        end
                        this.tDetuning  = linspace(0,this.timePulse/10^3,this.NtRabiFreq);
                        this.Detuning   = (this.SDetunings(j)-this.FreqOffSetSpectrum)*ones(1,this.NtDetuning);

                        [this.T,this.U] = ode45(@(t,u) OBE(t,u,this.RabiFreq,this.tRabiFreq,this.Detuning,this.tDetuning,this.T1,this.T2p,this.steadyStatePopValue),[0,this.timePulse/10^3],this.startQubit);

                        this.finalQubit     = this.U(end,:);

                        this.Overlap    = dot(this.finalQubit,this.goalQubit);
                        
                        this.Spectrum(j)= 0.5*(this.Overlap+1);
                        
                    end
                    if(this.verbose)
                        figure(5);
                        plot(this.SDetunings,this.Spectrum);
                        xlabel('Detuning / kHz');
                        ylabel('Transfer');
                    end
                    
                case 'GaussianPulse'                    
                    this.tRabiFreq  = linspace(0,this.timePulse/10^3,this.NtRabiFreq);
                    this.RabiFreq   = this.cRabiFreq*this.gaussianPulseSigma/10^3*sqrt(2*pi)*normpdf(this.tRabiFreq,this.timePulse/10^3/2,this.gaussianPulseSigma/10^3);
                    
                    this.SDetunings = linspace(-this.Span,this.Span,this.NfSpectrum);
                    
                    for j=1:this.NfSpectrum
                        if(this.verbose)
                            disp(['Generating Spectrum. Current Iteration: ' num2str(j) ' of ' num2str(this.NfSpectrum)]);
                        end
                        this.tDetuning  = linspace(0,this.timePulse/10^3,this.NtRabiFreq);
                        this.Detuning   = (this.SDetunings(j)-this.FreqOffSetSpectrum)*ones(1,this.NtDetuning);
                        
                        [this.T,this.U]      = ode45(@(t,u) OBE(t,u,this.RabiFreq,this.tRabiFreq,this.Detuning,this.tDetuning,this.T1,this.T2p,this.steadyStatePopValue),[0,this.timePulse/10^3],this.startQubit);

                        this.finalQubit     = this.U(end,:);

                        this.Overlap    = dot(this.finalQubit,this.goalQubit);

                        this.Spectrum(j)= 0.5*(this.Overlap+1);
                    end
                    if(this.verbose)
                        figure(5);
                        plot(this.SDetunings,this.Spectrum);
                        xlabel('Detuning / kHz');
                        ylabel('Transfer');
                    end
                    
                case 'AdiabaticPassage'
                    
                    this.tRabiFreq  = linspace(0,this.timePulse/10^3,this.NtRabiFreq);
                    this.RabiFreq   = this.cRabiFreq*sin(pi*this.tRabiFreq./(10^-3*this.timePulse)).^2;
                    
                    this.SDetunings = linspace(-this.Span,this.Span,this.NfSpectrum);
                    
                    for j=1:this.NfSpectrum
                        if(this.verbose)
                            disp(['Generating Spectrum. Current Iteration: ' num2str(j) ' of ' num2str(this.NfSpectrum)]);
                        end
                        this.tDetuning  = linspace(0,this.timePulse/10^3,this.NtRabiFreq);
                        this.Detuning   = this.SDetunings(j)+this.AdiabSpan*sign(this.tDetuning-this.timePulse/10^3/2).*sqrt(1-sin(pi*this.tDetuning./(10^-3*this.timePulse)).^4);                          

                        [this.T,this.U] = ode45(@(t,u) OBE(t,u,this.RabiFreq,this.tRabiFreq,this.Detuning,this.tDetuning,this.T1,this.T2p,this.steadyStatePopValue),[0,this.timePulse/10^3],this.startQubit);

                        this.finalQubit     = this.U(end,:);

                        this.Overlap    = dot(this.finalQubit,this.goalQubit);

                        this.Spectrum(j)= 0.5*(this.Overlap+1);
                    end
                    if(this.verbose)
                        figure(5); clf;
                        plot(this.SDetunings,this.Spectrum);
                        xlabel('Detuning / kHz');
                        ylabel('Transfer');
                    end
                    
                otherwise
                    warning('Unknown type of pulse has been selected.');         
            end
            
        end
            
        
        function Plot(this,varargin)
            if(~isempty(this.T))
                % Start with the Bloch Sphere Representation
                figure(1); clf;
                view(86,6);
                line( [-1 1], [0 0],  [0 0],  'Color', 'b', 'LineStyle', ':');
                line( [0 0],  [-1 1], [0 0],  'Color', 'b', 'LineStyle', ':');
                line( [0 0],  [0 0],  [-1 1], 'Color', 'b', 'LineStyle', '--');
                
                angle = linspace( 0, 2*pi, 200);
                sinA = sin(angle);
                cosA = cos(angle);
                zeroA = zeros(size(angle));
                line( sinA,  cosA,  zeroA, 'Color', 'b', 'LineStyle', ':');
                line( zeroA, sinA,  cosA,  'Color', 'b', 'LineStyle', ':');
                line( sinA,  zeroA, cosA,  'Color', 'b', 'LineStyle', ':');
                
                colormap([1 1 1]);
                hold on;
                plot3(this.U(:,1),this.U(:,2),this.U(:,3),'LineWidth',3);
                xlabel('u');
                ylabel('v');
                zlabel('w');
                title('Bloch Sphere Evolution');
                hold off;
                figure(2); clf;
                hold on;
                plot(this.T,this.U(:,1),'r');
                plot(this.T,this.U(:,2),'b');
                plot(this.T,this.U(:,3),'g');
                xlabel('Time / s');
                ylabel('Population');
                legend('u','v','w');
                title('Temporal Evolution of Coherences and Population');
                hold off;
                figure(3);clf;
                hold on;
                plot(this.tRabiFreq,this.RabiFreq,'r');
                legend('Pulse Amplitude');
                xlabel('Time / s');
                ylabel('Rabi Frequency / kHz ');
                hold off;
                figure(4);clf;
                hold on;
                plot(this.tDetuning,this.Detuning,'b');
                legend('Pulse Detuning');
                xlabel('Time / s');
                ylabel('Detuning / kHz ');
                hold off;
            else
                warning('Dynamics have not yet been simulated.');
            end
        end
        
    end
    
end

