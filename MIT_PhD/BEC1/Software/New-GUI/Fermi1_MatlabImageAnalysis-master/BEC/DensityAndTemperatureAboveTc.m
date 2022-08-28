function analysis = DensityAndTemperatureAboveTc(Bose_XZ,OmegaX,OmegaY,OmegaZ,KData,boxWidths,boxHeigths,varargin)
%Inputs: Bose and fit structures from TOF, KData specifying
%integration limits, analysis box size in pixels, and number of boxes to
%analyze. 
    %Chemical potential = mu_c at Tc
    %Dalfovo...Stringari: For temperatures higher than Tc
%     the chemical potential is less than mu_c=3/2 hbar*omegaAvg (arithmetic avg), and becomes N dependent, while the
%     population of the lowest state is of the order of 1 instead of N.



    %Temperature is given in Kelvin (Bose_XZ)
%Outputs: local nBEC, nThermal, nTotal, local T/Tc computed for homogeneous
%gas, global T/Tc
%Method: takes chemical potential and computes Nc.  Takes chemical potential
%and temperature to compute in-situ thermal distribution, then computes
%Nthermal.  Absolute temperature is from fitting the wings of TOF to Bose
%function.
%ToverTcCi gives the error estimates 
%   2. Thermal error from one source: finite integration size


        

    p = inputParser;

    p.addParameter('chemicalPot',3/2*mean([OmegaX,OmegaY,OmegaZ])*hbar);
    p.parse(varargin{:});
    chemicalPot  = p.Results.chemicalPot;

    temp=Bose_XZ.temperature;
    micronPerPixel=2.48;
    omegabar = (OmegaX*OmegaY*OmegaZ)^(1/3);
    prefactorEn=hbar^2/2/mNa*(6*pi^2)^(2/3);
    beta=1/kB/temp;
    lambdaDB= PlanckConst/sqrt(2*pi*mNa*kB*temp);    %lambda is de Broglie wavelength in m
    
    [MarqueeBoxesInMuMeter,numBoxes]=getMarqueeBoxes(boxWidths,boxHeigths,micronPerPixel);
    FermionSigma = mean(KData.analysis.fitIntegratedGaussY.param(:,4));
    zlim=FermionSigma/sqrt(2)*micronPerPixel; %the Gaussian z-width divided by sqrt(2) is the real standard deviation (68% from -zlim to zlim) (micron)
    
    
%%%%%%%%%%%%%% Define functions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Thermal density bose distribution function, inputs in meter
    %use n3d_thermal Bose Gas (r) = g_1.5(z)/lambda^3
    %Equation 6 in Naraschewki+Stamper-Kurn (1998)
    
    n_Therm=@(x,y,z) lambdaDB^-3*PolyLog(1.5,exp(-beta*abs(chemicalPot-1/2*mNa*(OmegaX^2*x.^2+OmegaY^2*y.^2+OmegaZ^2*z.^2))));
    NThermalBosons=integral3(n_Therm,0,1000e-6,0,1000e-6,0,1000e-6)*8;
    f_Therm=@(x,y,z) lambdaDB^-3/NThermalBosons*PolyLog(1.5,exp(-beta*abs(chemicalPot-1/2*mNa*(OmegaX^2*x.^2+OmegaY^2*y.^2+OmegaZ^2*z.^2))));

    g_Therm=@(x,y,z) n_Therm(x,y,z).^2.*f_Therm(x,y,z);
    integrand_Therm=@(x,y,z) n_Therm(x,y,z).^(2/3).*f_Therm(x,y,z);

%%%%%%%%%%%%%%%%  Compute temp functions and properties %%%%%%%%%%%%%%%%%%%%%%
    %Global T/Tc for harmonic trap
    ToverTcGlobal=kB*temp/hbar/omegabar*(PolyLog(3,1)/NThermalBosons)^(1/3);
    %ToverTcGlobal=(1-Nc/(Nc+NThermalBosons))^(1/3);
% %     Tc=.94*PlanckConst/2/pi*omegabar/kB*(Nc+NThermalBosons).^(1/3);
% %     ToverTcGlobal=temp/Tc;
    
    %local T/Tc for homogeneous 
    %Outside of BEC, T/Tc in a homogeneous gas, x = density (m^-3), tempK =
    
    %Temperature measured from thermal wings in Kelvin, x is density in
    %m^-3.  Stringari pg. 469, kBTc=2pi hbar^2/m *(n/PolyLog(3/2,1))^(2/3)
    localToverTcfunThermal=@(tempK,x) tempK./(hbar^2*3.313/mNa*x.^(2/3)/kB); 
%     localToverTcfun = @(x) (max(0,1-x(1)./(x(1)+x(2)))).^(2/3);

    %From Stringari "Theory of BEC in trappged gases" pg 469, the
    %result for an ideal homogeneous gas
    localToverTc    = zeros(numBoxes,1);
    localToverTcCi =  zeros(numBoxes,2);
    
%%%%%%%%%%%%%%  Initialize variables %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     densityC=zeros(1,numBoxes);
    densityT=zeros(1,numBoxes);
    
    %<En> of condensate, in units of joules
%     EnC = zeros(1,numBoxes);
%     integrand_BEC=@(x,y,z) Nc^(2/3)*f_BEC(x,y,z).^(5/3); %obtaining n^(2/3)*n
    %<En> of thermals, in joules with input micron
    EnT = zeros(1,numBoxes);

    %BEC Density will be in units of /cm^3, thus necessitating a conversion
    %factor of (10^4)^3 from microns^-3
    %Thermal Density will be in units of /cm^3, thus necessitating a conversion
    %factor of (10^-2)^3 from m^-3
        
    
%%%%%%%%%%%  Compute densities %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Boxes along lab x-direction
    %compute mean density per box in /cm^3
    zMin = 0;
    zMax = zlim;

    for idx=1:numBoxes
        fprintf(['Density of MarqueeBox: ' num2str(idx) '/' num2str(numBoxes) '\n'])
        xMin = MarqueeBoxesInMuMeter(idx,1);
        xMax = MarqueeBoxesInMuMeter(idx,1)+MarqueeBoxesInMuMeter(idx,3);
        yMin = MarqueeBoxesInMuMeter(idx,2);
        yMax = MarqueeBoxesInMuMeter(idx,2)+MarqueeBoxesInMuMeter(idx,4);
        
        
        denomT=integral3(f_Therm,xMin*1e-6,xMax*1e-6,yMin*1e-6,yMax*1e-6,zMin*1e-6,zMax*1e-6);
        %densities in units /cm^3
        
        %compute <En> for thermals
        numeratorEnT=integral3(integrand_Therm,xMin*1e-6,xMax*1e-6,yMin*1e-6,yMax*1e-6,zMin*1e-6,zMax*1e-6);
        EnT(idx)=prefactorEn*numeratorEnT/denomT;
        densityT(idx)=1e-6*(EnT(idx)/prefactorEn).^1.5;
        
      
    end
    densityPerBox=densityT;
    VarT=zeros(1,numBoxes);
    % compute variance of each BEC box from mean density
    for idx=1:numBoxes
        fprintf(['Variance of MarqueeBox: ' num2str(idx) '/' num2str(numBoxes) '\n'])
        xMin = MarqueeBoxesInMuMeter(idx,1);
        xMax = MarqueeBoxesInMuMeter(idx,1)+MarqueeBoxesInMuMeter(idx,3);
        yMin = MarqueeBoxesInMuMeter(idx,2);
        yMax = MarqueeBoxesInMuMeter(idx,2)+MarqueeBoxesInMuMeter(idx,4);

        
        %output in cm^-6
        VarT(idx) =  1e-12*integral3(g_Therm,xMin*1e-6,xMax*1e-6,yMin*1e-6,yMax*1e-6,zMin*1e-6,zMax*1e-6,'RelTol',1e-4,'AbsTol',1e-13)/integral3(f_Therm,xMin*1e-6,xMax*1e-6,yMin*1e-6,yMax*1e-6,zMin*1e-6,zMax*1e-6,'RelTol',1e-4,'AbsTol',1e-13);
        VarT(idx)=VarT(idx)-densityT(idx)^2;    
    end

    
    VarHigh=VarT;
    VarLow=+VarT;
        


    for idx = 1:numBoxes

            localToverTc(idx) = localToverTcfunThermal(temp,(densityT(idx))*10^6);
            localToverTcCi(idx,1)=localToverTcfunThermal(temp, (densityT(idx)+sqrt(VarHigh(idx)))*10^6);
            localToverTcCi(idx,2)=localToverTcfunThermal(temp, (densityT(idx)-sqrt(VarLow(idx)))*10^6);        

    end
    

    % plot per box
    figure(555); clf;
    subplot(1,2,1);
    hold on;
    xlabel(['Density box number']);
    ylabel('Density (cm^{-3})');
    plot(1:numBoxes, densityT,'.','MarkerSize',20);

    errorbar(1:numBoxes, densityPerBox,sqrt(VarLow),sqrt(VarHigh),'.','MarkerSize',20);
    ax = gca;
    ax.ColorOrderIndex = 1;
    legend('BEC density/box','Therm density/box','Total density/box','Location', 'Best');
    xticks(1:numBoxes)
    hold off;
    
    figure(555);
    subplot(1,2,2);hold on;
    xlabel(['Density box number']);
    ylabel('local T/T_C');
    title(['T/T_C per box for ' num2str(NThermalBosons,2) ' thermal atoms']);
    errorbar(1:numBoxes,  localToverTc,localToverTc-localToverTcCi(:,1),localToverTcCi(:,2)-localToverTc,'.','MarkerSize',20);
    ax = gca;
    ax.ColorOrderIndex = 1;
    plot([1,numBoxes],[ToverTcGlobal, ToverTcGlobal],'LineWidth',2);
    legend('local T/T_C',strcat('Global T/T_C = ',num2str(ToverTcGlobal,2)),'BEC edge' ,'Location', 'Best');

    xticks(1:numBoxes)
    hold off;
    

    
    
    
    analysis = struct;

    analysis.densityT       = densityT;
    analysis.globalToverTc  = ToverTcGlobal;

    analysis.Nt             = NThermalBosons;        
    analysis.VarianceHigh_quad      = VarHigh;
    analysis.VarianceLow_quad       =VarLow;
    analysis.VarianceT_quad         = VarT;
    analysis.localToverTc_quad      = localToverTc;
    analysis.localToverTcCi_quad    = localToverTcCi;
    analysis.densityPerBox_quad     = densityPerBox;
    analysis.EnT                    = EnT;
    analysis.boxHeights             =   boxHeigths;
    analysis.boxWidths              =   boxWidths;
    analysis.chemicalPot            = chemicalPot;
end

%helper functions
function [mq,nb]=getMarqueeBoxes(boxWidths,boxHeights,micronPerPixel)
    MarqueeBoxesInPixelRaw = createMarqueeBoxes(0,0,boxWidths,boxHeights);
    MarqueeBoxesInPixel=zeros(length(MarqueeBoxesInPixelRaw)/4,4);
    %only compute non-redundant marquee boxes (one out of four)
    uniqueBoxIdx=1;
    for jdx = 1:length(boxHeights)
        for kdx = 1:length(boxWidths)
            uniqueBox = (2*kdx-1)+4*length(boxWidths)*(jdx-1);
            MarqueeBoxesInPixel(uniqueBoxIdx,:)=MarqueeBoxesInPixelRaw(uniqueBox,:);
            uniqueBoxIdx=uniqueBoxIdx+1;
        end
    end
    mq=MarqueeBoxesInPixel*micronPerPixel; %in micron, horizontal box dimension
    nb = length(mq(:,1));
end
