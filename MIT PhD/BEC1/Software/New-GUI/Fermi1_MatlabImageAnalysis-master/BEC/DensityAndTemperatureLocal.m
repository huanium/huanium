function analysis = DensityAndTemperatureLocal(Bose_XZ, BEC_X,BEC_Z, axialPixel)
%Changes: Na local density for En, at the center of every axialPixel input,
%setting y=z=0
%Inputs: Bose and BEC bimodal fit structures from TOF
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
    axialCoord=axialPixel*2.5; %micron


    %%%%%%%%%%%%  Define constants for Na %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    omegabar = (omegaX*omegaY*omegaZ)^(1/3);
    a_s=52*aBohr; %Sodium F=1 scattering length, away from FB resonance
    prefactorEn=hbar^2/2/mReduced*(6*pi^2)^(2/3); %prefer REDUCED MASS, not Boson mass
    Nc = (2*chemicalPotential).^(2.5)/(15*hbar^2*sqrt(mNa)*omegabar^3*a_s);
    beta=1/kB/temp;
    lambdaDB= PlanckConst/sqrt(2*pi*mNa*kB*temp)*10^6;    %lambda is de Broglie wavelength in um
    
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
    

    
%%%%%%%%%%%%%%  total density Na along y=z=0 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    density=n_Na(axialCoord,0,0)*1e12;%in cm^-3
    densityC = f_BEC(axialCoord,0,0)*Nc*1e12;
    densityT = f_Therm(axialCoord,0,0)*NThermalBosons*1e12;

    
%%%%%%%%%%%%% local T/Tc for homogeneous gas
    %Outside of BEC, T/Tc in a homogeneous gas, x = density (m^-3), tempK =
    %Temperature measured from thermal wings in Kelvin, x is density in
    %m^-3.  Stringari pg. 469, kBTc=2pi hbar^2/m *(n/PolyLog(3/2,1))^(2/3)
    
    localToverTcfunThermal=@(tempK,x) tempK./(hbar^2*3.313/mNa*x.^(2/3)/kB); 
    localToverTcfunFrac = @(x) (max(0,1-x(1)./(x(1)+x(2)))).^(2/3);

    %From Stringari "Theory of BEC in trappged gases" pg 469, the
    %result for an ideal homogeneous gas
    localToverTc =localToverTcfunThermal(temp,(density*1e6));
    localToverTcFrac        = localToverTc;

    for idx = 1:length(axialCoord)
        if(densityC(idx)>0)
            localToverTcFrac(idx)=localToverTcfunFrac([densityC(idx) densityT(idx)]);
        end
    end
    

    % Plot per box
    figure(555); clf;
    subplot(1,3,1);
    hold on;
    xlabel(['Axial Coord (micron)']);
    ylabel('Density (cm^{-3})');
    title(['Density, T/T_{C} = ',num2str(ToverTcGlobal,2),' \mu(kHz) = ',num2str(chemicalPotential/PlanckConst/1000,2) ]);
    plot(axialCoord, densityC,'-','LineWidth',2);
    plot(axialCoord, densityT,'-','LineWidth',2);
    plot(axialCoord, density,'-','LineWidth',2);
% %     errorbar(1:numBoxes, density,sqrt(VarLow),sqrt(VarHigh),'.','MarkerSize',20);
    ax = gca;
    ax.ColorOrderIndex = 1;
    legend('BEC density/box','Therm density/box','Total density/box','Location', 'Best');
%     xticks(1:ceil(numBoxes/4):numBoxes)
    hold off;
    
    figure(555);
    subplot(1,3,2);hold on;
    xlabel(['Axial Coord (micron)']);
    ylabel('local T/T_C');
    title(['T/T_C per box for ' num2str(Nc,2) ' BEC atoms and ' num2str(NThermalBosons,2) ' thermal atoms']);
    plot(axialCoord,  localToverTc,'-','LineWidth',2.5);
    plot(axialCoord,  localToverTcFrac,'-','LineWidth',1.5);
    plot([min(axialCoord),max(axialCoord)],[ToverTcGlobal, ToverTcGlobal],'-.','LineWidth',1.5);
    legend('local T/T_C','cond frac T/T_C',strcat('Global T/T_C = ',num2str(ToverTcGlobal,2)) ,'Location', 'Best');
    hold off;
    
    subplot(1,3,3);hold on;
    plot(localToverTc, densityC./density,'.','MarkerSize',20);
    plot(localToverTcFrac, densityC./density,'.','MarkerSize',20);
    plot(0:.1:max(localToverTcFrac),heaviside(1-[0:.1:max(localToverTcFrac)].^1.5).*(1-[0:.1:max(localToverTcFrac)].^1.5),'LineWidth',2);
    title('Condensate fraction vs T/Tc');
    legend('T/Tc from homogeneous eqn.','T/Tc from computed nc/n','1-(T/Tc)^{1.5}');
    xlabel('T/Tc');ylabel('n_c/n');
    
    
    
    analysis = struct;
    analysis.densityC               = densityC;
    analysis.densityT               = densityT;
    analysis.densityCombined        = density;  %From n_Na, combined
    analysis.globalToverTc          = ToverTcGlobal;
    analysis.Nc                     = Nc;
    analysis.Nt                     = NThermalBosons;        
    analysis.localToverTc           = localToverTc;
    analysis.ToverTcfrac            = localToverTcFrac;
    analysis.chemicalPotential      = chemicalPotential;
    analysis.temperature            = temp;
end


