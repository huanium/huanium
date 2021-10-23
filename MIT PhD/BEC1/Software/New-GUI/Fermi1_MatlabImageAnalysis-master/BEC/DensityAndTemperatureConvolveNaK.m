function analysis = DensityAndTemperatureConvolveNaK(Bose_XZ, BEC_X,BEC_Y,BEC_Z,KData,boxWidths,boxHeigths,varargin)
%Changes: convolve Na density with K Gaussian density to get the average
%overlap density for En
%Inputs: Bose and BEC bimodal fit structures from TOF, KData specifying
%K -9/2 gaussian waists defined as e^(-1/2), analysis box size in pixels
    %Chemical potential is given in kHz (BEC_X, BEC_Y, BEC_Z)
    %Temperature is given in Kelvin (Bose_XZ)
    %Statistical variance is computed from in-situ images of the BEC,
    %'xTFpixZcam'
%Outputs: local nBEC, nThermal, nTotal, local T/Tc computed for homogeneous
%gas, global T/Tc, En
%Method: takes chemical potential and computes Nc.  Takes chemical potential
%and temperature to compute in-situ thermal distribution, then computes
%Nthermal.  Absolute temperature is from fitting the wings of TOF to Bose
%function.

    p = inputParser;

    p.addParameter('camera','y');
    p.parse(varargin{:});
    camera  = p.Results.camera;

    if camera=='z'
        micronPerPixel=2.5; %camera magnification
    elseif camera=='y'
        micronPerPixel=2.48;
    else
        error('Error: please choose "z" or "y" camera\n');
    end
    
    if camera == 'y'
        omegaX = BEC_Z.Omegas(1);
        omegaY = BEC_Z.Omegas(2);
        omegaZ = BEC_Z.Omegas(3);
        
        xTF = BEC_X.TF;
        zTF = BEC_Z.TF;
        
        dX = (BEC_X.chemicalPotCi(2) - BEC_X.chemicalPotCi(1))/2;
        dZ = (BEC_Z.chemicalPotCi(2) - BEC_Z.chemicalPotCi(1))/2;
        
        yTF = (xTF*omegaX/omegaY/dX+zTF*omegaZ/omegaY/dZ)/(1/dX+1/dZ);
        
        temp=Bose_XZ.temperature;
        chemicalPotential = PlanckConst*1000*(1/dX*BEC_X.chemicalPot+1/dZ*BEC_Z.chemicalPot)/(1/dX+1/dZ);
    elseif camera == 'z'
        omegaX = BEC_Y.Omegas(1);
        omegaY = BEC_Y.Omegas(2);
        omegaZ = BEC_Y.Omegas(3);
        
        xTF = BEC_X.TF;
        yTF = BEC_Y.TF;
        
        dX = (BEC_X.chemicalPotCi(2) - BEC_X.chemicalPotCi(1))/2;
        dY = (BEC_Y.chemicalPotCi(2) - BEC_Y.chemicalPotCi(1))/2;
        zTF = (1/dX*xTF*omegaX/omegaZ+1/dY*yTF*omegaY/omegaZ)/(1/dX+1/dY);
        
        temp=Bose_XZ.temperature;
        chemicalPotential = PlanckConst*1000*(1/dX*BEC_X.chemicalPot+1/dY*BEC_Y.chemicalPot)/(1/dX+1/dY);
    end
    
%%%%%%%%%%%%  Define constants for Na %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    omegabar = (omegaX*omegaY*omegaZ)^(1/3);
    a_s=52*aBohr; %Sodium F=1 scattering length, away from FB resonance
    prefactorEn=hbar^2/4/mReduced*(6*pi^2)^(2/3); %prefer REDUCED MASS, not Boson mass
    Nc = (2*chemicalPotential).^(2.5)/(15*hbar^2*sqrt(mNa)*omegabar^3*a_s);
    beta=1/kB/temp;
    lambdaDB= PlanckConst/sqrt(2*pi*mNa*kB*temp)*10^6;    %lambda is de Broglie wavelength in um
    [MarqueeBoxesInMuMeter,numBoxes]=getMarqueeBoxes(boxWidths,boxHeigths,micronPerPixel);
    
%%%%%%%%%%%%% Get K parameters assuming Maxwell-Boltzmann distribution
%The TiSa is circular, so the z and the y waists should be roughly equal
%Assume the x-trap frequency is scaled from the measured Na x-trap freq and
%only comes from the 1064 beam, not from the TiSa
    xWaistK=KData(1); %in micron
    yWaistK=KData(2);
    zWaistK=KData(3); 

    fprintf('K x-y-z- Gaussian e^-(1/2) waists are: \n')
    display([xWaistK yWaistK zWaistK])
    %the Gaussian y-width divided by sqrt(2) is the real standard deviation (68% from -zWaistK to zWaistK) (micron)
    
%Input: micron,  Output: micron^-3
    f_K = @(x,y,z) exp(-x.^2/2/xWaistK^2-y.^2/2/yWaistK^2-z.^2/2/zWaistK^2);
% %     normK = 8*integral3(f_KU,0,10*xWaistK,0,10*yWaistK,0,10*zWaistK);
% %     f_K = @(x,y,z) f_KU(x,y,z)/normK;
    
%%%%%%%%%%%%%% Define functions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %The condensate probability density distribution function, normalized to 1 when
    %integrated over all space.  Units of um^-3.  Inputs in um.
    f_BEC=@(x,y,z) 15/(8*pi*xTF*yTF*zTF)*(1-x.^2/xTF^2-y.^2/yTF^2-z.^2/zTF^2).*heaviside(1-x.^2/xTF^2-y.^2/yTF^2-z.^2/zTF^2);
    
    %Thermal density bose distribution function, inputs in meter
    %use n3d_thermal Bose Gas (r) = g_1.5(z)/lambda^3
    %Equation 6 in Naraschewki+Stamper-Kurn (1998)    
    %Input micron, output micron^-3.  Not yet normalized.
    f_ThermU=@(x,y,z) real(PolyLog(1.5,exp(-beta*abs(chemicalPotential-1/2*mNa*10^(-12)*(omegaX^2*x.^2+omegaY^2*y.^2+omegaZ^2*z.^2)))));

    %Normalization of f_Therm so that f_Therm/normBose has integral across 3-space =1
    fprintf('calculating number of thermal Bosons \n')
    normBose=8*integral3(f_ThermU,0,xTF*10,0,yTF*10,0,zTF*10,'RelTol',1e-3);
    NThermalBosons=normBose/lambdaDB^3;

    f_Therm = @(x,y,z) f_ThermU(x,y,z)/normBose;
    
    %local 3D Na density, combined thermals + condensate, in um^-3
    %iintegral across 3-space is Nc+NThermalBosons
    n_Na = @(x,y,z) NThermalBosons*f_Therm(x,y,z)+Nc*f_BEC(x,y,z);
    

    
%%%%%%%%%%%%%%%%  Compute temp functions and properties %%%%%%%%%%%%%%%%%%%%%%
    %Global T/Tc for harmonic trap
    
    %ToverTcGlobal=(1-Nc/(Nc+NThermalBosons))^(1/3);
    Tc=.94*PlanckConst/2/pi*omegabar/kB*(Nc+NThermalBosons).^(1/3);
    ToverTcGlobal=temp/Tc;
    

    
%%%%%%%%%%%%%%  Initialize variables %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    densityC=zeros(1,numBoxes); % includes K distribution convolution
    densityT=zeros(1,numBoxes);
    densityCombined=zeros(1,numBoxes);
    
% %     densityCNa=zeros(1,numBoxes); % doesn't include K distribution convolution
% %     densityTNa=zeros(1,numBoxes);
    
    %<En> of reduced mass, in units of Joules
    EnC = zeros(1,numBoxes);
    %Integrand has units of micron^-2*micron^-3 = micron^-5
    integrand_BEC=@(x,y,z) Nc^(2/3)*f_BEC(x,y,z).^(2/3).*f_K(x,y,z); %obtaining n^(2/3)*f_K
    %<En> of thermals, in joules with input micron
    EnT = zeros(1,numBoxes);
    integrand_Therm=@(x,y,z) NThermalBosons^(2/3)* f_Therm(x,y,z).^(2/3).*f_K(x,y,z); 
    
    %Total Na density
    EnCombined = zeros(1,numBoxes);
    integrand_Na = @(x,y,z) n_Na(x,y,z).^(2/3).*f_K(x,y,z);
    
    
    
%%%%%%%%%%%  Compute densities %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Boxes along lab x-direction
    %Compute mean En (reduced mass) per box, from En extract density
    zMin = 0;
    zMax = 10*zWaistK;

    for idx=1:numBoxes
        fprintf(['Density of MarqueeBox: ' num2str(idx) '/' num2str(numBoxes) '\n'])
        xMin = MarqueeBoxesInMuMeter(idx,1);
        xMax = MarqueeBoxesInMuMeter(idx,1)+MarqueeBoxesInMuMeter(idx,3);
        yMin = MarqueeBoxesInMuMeter(idx,2);
        yMax = MarqueeBoxesInMuMeter(idx,2)+MarqueeBoxesInMuMeter(idx,4);
        display([xMin,xMax])

% %         %Na only average densities, in cm^-3
% %         densityCNa(idx)=1e12*abs(Nc*integral3(f_BEC, xMin,xMax,yMin,yMax,zMin,zMax,'RelTol',1e-5)./(xMax-xMin)./(yMax-yMin)./(zMax-zMin));
% %         densityTNa(idx)=1e12*abs(NThermalBosons*integral3(f_Therm, xMin,xMax,yMin,yMax,zMin,zMax,'RelTol',1e-3)./(xMax-xMin)./(yMax-yMin)./(zMax-zMin));
% %         display([densityCNa(idx) densityTNa(idx)])
        %Denominator is unitless
        denom=integral3(f_K, xMin,xMax,yMin,yMax,zMin,zMax,'RelTol',1e-5);

        
        %compute <En> for condensate, numeratorEnC has units of micron^-2
        numeratorEnC=integral3(integrand_BEC,xMin,xMax,yMin,yMax,zMin,zMax,'RelTol',1e-2);
        EnC(idx)=prefactorEn*1e12*numeratorEnC/denom; %convert to m^-2
        densityC(idx)=1e-6*(EnC(idx)/prefactorEn).^1.5; %densities in units /cm^3
        %compute <En> for thermals
        numeratorEnT=integral3(integrand_Therm,xMin,xMax,yMin,yMax,zMin,zMax,'RelTol',1e-2);
        EnT(idx)=prefactorEn*1e12*numeratorEnT/denom; %convert to m^-2
        densityT(idx)=1e-6*(EnT(idx)/prefactorEn).^1.5;
        %compute <En> for total distribution
        numeratorEnCombined=integral3(integrand_Na,xMin,xMax,yMin,yMax,zMin,zMax,'RelTol',1e-2);
        EnCombined(idx) = prefactorEn*1e12*numeratorEnCombined/denom;
        densityCombined(idx)=1e-6*(EnCombined(idx)/prefactorEn).^1.5;


    end
    densityC(isnan(densityC))=0;
    densityPerBox = densityCombined;
    EnC(isnan(EnC))=0;
% %     densityCNa(isnan(densityC))=0;

    
%%%%%%%%%%%%% local T/Tc for homogeneous gas
    %Outside of BEC, T/Tc in a homogeneous gas, x = density (m^-3), tempK =
    %Temperature measured from thermal wings in Kelvin, x is density in
    %m^-3.  Stringari pg. 469, kBTc=2pi hbar^2/m *(n/PolyLog(3/2,1))^(2/3)
    
    localToverTcfunThermal=@(tempK,x) tempK./(hbar^2*3.313/mNa*x.^(2/3)/kB); 
    localToverTcfunFrac = @(x) (max(0,1-x(1)./(x(1)+x(2)))).^(2/3);

    %From Stringari "Theory of BEC in trappged gases" pg 469, the
    %result for an ideal homogeneous gas
    localToverTcThermal =localToverTcfunThermal(temp,(densityPerBox)*1e6);
    localToverTc        = localToverTcThermal;

    for idx = 1:numBoxes
        if(densityC(idx)>0)
            localToverTc(idx)=localToverTcfunFrac([densityC(idx) densityT(idx)]);
        end
    end
    

    % Plot per box
    figure(555); clf;
    subplot(1,3,1);
    hold on;
    xlabel(['Density box number']);
    ylabel('Density (cm^{-3})');
    title(['Density, T/T_{C} = ',num2str(ToverTcGlobal,2),' \mu(kHz) = ',num2str(chemicalPotential/PlanckConst/1000,2) ]);
    plot(1:numBoxes, densityC,'.','MarkerSize',20);
    plot(1:numBoxes, densityT,'.','MarkerSize',20);
    plot(1:numBoxes, densityPerBox,'.','MarkerSize',20);
% %     errorbar(1:numBoxes, densityPerBox,sqrt(VarLow),sqrt(VarHigh),'.','MarkerSize',20);
    ax = gca;
    ax.ColorOrderIndex = 1;
    legend('BEC density/box','Therm density/box','Total density/box','Location', 'Best');
    xticks(1:ceil(numBoxes/4):numBoxes)
    hold off;
    
    figure(555);
    subplot(1,3,2);hold on;
    xlabel(['Density box number']);
    ylabel('local T/T_C');
    title(['T/T_C per box for ' num2str(Nc,2) ' BEC atoms and ' num2str(NThermalBosons,2) ' thermal atoms']);
    plot(1:numBoxes,  localToverTc,'.','MarkerSize',20);
    ax = gca;
    ax.ColorOrderIndex = 1;
    plot([1,numBoxes],[ToverTcGlobal, ToverTcGlobal],'LineWidth',2);
    legend('local T/T_C',strcat('Global T/T_C = ',num2str(ToverTcGlobal,2)) ,'Location', 'Best');

    xticks(1:ceil(numBoxes/4):numBoxes)
    hold off;
    
    subplot(1,3,3);hold on;
    plot(localToverTc, densityC./densityPerBox,'.','MarkerSize',20);

    plot(localToverTcThermal, densityC./densityPerBox,'.','MarkerSize',20);
    plot(0:.1:max(localToverTc),heaviside(1-[0:.1:max(localToverTc)].^1.5).*(1-[0:.1:max(localToverTc)].^1.5),'LineWidth',2);
    title('Condensate fraction vs T/Tc');
    legend('T/Tc from computed nc/n','T/Tc from homogeneous eqn.','1-(T/Tc)^{1.5}');
    xlabel('T/Tc');ylabel('n_c/n');
    
    
    
    analysis = struct;
    analysis.densityC       = densityC;
    analysis.densityT       = densityT;
    analysis.densityPerBox_quad     = densityPerBox;  %From n_Na, combined
    analysis.globalToverTc  = ToverTcGlobal;
    analysis.Nc             = Nc;
    analysis.Nt             = NThermalBosons;        
    analysis.localToverTc_quad      = localToverTc;
    analysis.localToverTcThermal = localToverTcThermal;
    analysis.chemicalPotential      = chemicalPotential;
    analysis.EnC                    = EnC;
    analysis.EnT                    = EnT;
    analysis.EnCombined             = EnCombined;
    analysis.boxHeights             =   boxHeigths;
    analysis.boxWidths              =   boxWidths;
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
