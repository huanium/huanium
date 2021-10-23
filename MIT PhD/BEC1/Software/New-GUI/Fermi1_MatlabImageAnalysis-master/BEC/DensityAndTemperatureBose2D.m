function analysis = DensityAndTemperatureBose2D(Bose_XZ, BEC_X,BEC_Y,BEC_Z,KData,boxWidths,boxHeigths,xTFpixZcam,varargin)
%Inputs: Bose and BEC bimodal fit structures from TOF, KData specifying
%integration limits, analysis box size in pixels, and number of boxes to
%analyze. 
    %Chemical potential is given in kHz (BEC_X, BEC_Y, BEC_Z)
    %Temperature is given in Kelvin (Bose_XZ)
    %Statistical variance is computed from in-situ images of the BEC,
    %'xTFpixZcam'
%Outputs: local nBEC, nThermal, nTotal, local T/Tc computed for homogeneous
%gas, global T/Tc
%Method: takes chemical potential and computes Nc.  Takes chemical potential
%and temperature to compute in-situ thermal distribution, then computes
%Nthermal.  Absolute temperature is from fitting the wings of TOF to Bose
%function.
%ToverTcCi gives the error estimates 
%   1. Condensate error from two sources: finite integration size (VarSysC, ErrSysC)and BEC
%   fluctuations (VarStatC, ErrStatC)
%   2. Thermal error from one source: finite integration size
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
    
%%%%%%%%%%%%  Define constants %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    omegabar = (omegaX*omegaY*omegaZ)^(1/3);
    a_s=52*aBohr; %Sodium F=1 scattering length, away from FB resonance


    Nc = (2*chemicalPotential).^(2.5)/(15*hbar^2*sqrt(mNa)*omegabar^3*a_s);
    % %     sanity check
% %     Nc = 5.29e5 ;
% %     chemicalPotential = 1/2*(15*hbar^2*sqrt(mNa)*Nc*omegabar^3*a_s)^(2/5);
    % %
    beta=1/kB/temp;
    lambdaDB= PlanckConst/sqrt(2*pi*mNa*kB*temp);    %lambda is de Broglie wavelength in m
    intLimit=sqrt(kB*temp*2./mNa./omegaZ^2)*300; %integration limits in meter for calculating thermal number
    MarqueeBoxesInPixelRaw = createMarqueeBoxes(0,0,boxWidths,boxHeigths);
    MarqueeBoxesInPixel=zeros(length(MarqueeBoxesInPixelRaw)/4,4);
    %only compute non-redundant marquee boxes (one out of four)
    uniqueBoxIdx=1;
    for jdx = 1:length(boxHeigths)
        for kdx = 1:length(boxWidths)
            uniqueBox = (2*kdx-1)+4*length(boxWidths)*(jdx-1);
            MarqueeBoxesInPixel(uniqueBoxIdx,:)=MarqueeBoxesInPixelRaw(uniqueBox,:);
            uniqueBoxIdx=uniqueBoxIdx+1;
        end
    end
    MarqueeBoxesInMuMeter=MarqueeBoxesInPixel*micronPerPixel; %in micron, horizontal box dimension
    numBoxes = length(MarqueeBoxesInMuMeter(:,1));
    
    FermionSigma = mean(KData.analysis.fitIntegratedGaussY.param(:,4));
    zlim=FermionSigma/sqrt(2)*micronPerPixel; %the Gaussian z-width divided by sqrt(2) is the real standard deviation (68% from -zlim to zlim) (micron)
    
    
%%%%%%%%%%%%%% Define functions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %The condensate probability density distribution function, normalized to 1 when
    %integrated over all space.  Units of um^-3.  Inputs in um.
    f_BEC=@(x,y,z) 15/(8*pi*xTF*yTF*zTF)*(1-x.^2/xTF^2-y.^2/yTF^2-z.^2/zTF^2).*heaviside(1-x.^2/xTF^2-y.^2/yTF^2-z.^2/zTF^2);
    %Thermal density bose distribution function, inputs in meter
    %use n3d_thermal Bose Gas (r) = g_1.5(z)/lambda^3
    %Equation 6 in Naraschewki+Stamper-Kurn (1998)
    f_Therm=@(x,y,z) real(PolyLog(1.5,exp(-beta*abs(chemicalPotential-1/2*mNa*(omegaX^2*x.^2+omegaY^2*y.^2+omegaZ^2*z.^2)))));
    
    %Normalization of f_Therm so that f_Therm/normBose has integral across 3-space =1
    fprintf('calculating number of thermal Bosons \n')
    normBose=8*integral3(f_Therm,0,omegaZ/omegaX*intLimit,0,omegaZ/omegaY*intLimit,0,intLimit);
    NThermalBosons=normBose/lambdaDB^3;
    % %
% %     NThermalBosons = 1.31e6-Nc
    % %
    %The number density Nc*f(x,y,z), multiplied by the probability density
    %function f(x,y,z), with units um^-6
    g_BEC=@(x,y,z) Nc*f_BEC(x,y,z).^2;
    
    %Thermal polylog^2, in units of m^-6, inputs in meters.  Recall,
    %integral(f_Therm/lambdaDB^3)=total number of bosons
    g_Therm=@(x,y,z) f_Therm(x,y,z).*f_Therm(x,y,z);
    
%%%%%%%%%%%%%%%%  Compute temp functions and properties %%%%%%%%%%%%%%%%%%%%%%
    %Global T/Tc for harmonic trap
    
    %ToverTcGlobal=(1-Nc/(Nc+NThermalBosons))^(1/3);
    Tc=.94*PlanckConst/2/pi*omegabar/kB*(Nc+NThermalBosons).^(1/3);
    ToverTcGlobal=temp/Tc;
    
    %local T/Tc for homogeneous 
    %Outside of BEC, T/Tc in a homogeneous gas, x = density (m^-3), tempK =
    
    %Temperature measured from thermal wings in Kelvin, x is density in
    %m^-3.  Stringari pg. 469, kBTc=2pi hbar^2/m *(n/PolyLog(3/2,1))^(2/3)
    localToverTcfunThermal=@(tempK,x) tempK./(hbar^2*3.313/mNa*x.^(2/3)/kB); 
    localToverTcfun = @(x) (max(0,1-x(1)./(x(1)+x(2)))).^(2/3);

    %From Stringari "Theory of BEC in trappged gases" pg 469, the
    %result for an ideal homogeneous gas
    localToverTc    = zeros(numBoxes,1);
    localToverTcCi =  zeros(numBoxes,2);
    
%%%%%%%%%%%%%%  Initialize variables %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    densityC=zeros(1,numBoxes);
    densityT=densityC;
    %BEC Density will be in units of /cm^3, thus necessitating a conversion
    %factor of (10^4)^3 from microns^-3
    %Thermal Density will be in units of /cm^3, thus necessitating a conversion
    %factor of (10^-2)^3 from m^-3
    
    CI=.68;
    xTFmeanInMicron=mean(xTFpixZcam)*2.5;
    lowIdx=round(length(xTFpixZcam)*(.5-CI/2));
    highIdx=round(length(xTFpixZcam)*(.5+CI/2));
    
    scaleZtoY=xTF/xTFmeanInMicron;
    %array of TF radii in meters from z-cam in situ
    xTFm=xTFpixZcam*2.5e-6*scaleZtoY;
    yTFm=yTF/1e6*xTFpixZcam/mean(xTFpixZcam);
    zTFm=zTF/1e6*xTFpixZcam/mean(xTFpixZcam);

    densityCmedian=zeros(1, numBoxes);
    densityCLB=zeros(size(densityCmedian));
    densityCUB=zeros(size(densityCmedian));    
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

        densityC(idx)=1e12*integral3(g_BEC, xMin,xMax,yMin,yMax,zMin,zMax,'RelTol',1e-4,'AbsTol',1e-13)/integral3(f_BEC, xMin,xMax,yMin,yMax,zMin,zMax,'RelTol',1e-4,'AbsTol',1e-13);
        densityT(idx)=1e-6*1/lambdaDB^3*integral3(g_Therm, xMin*1e-6,xMax*1e-6,yMin*1e-6,yMax*1e-6,zMin*1e-6,zMax*1e-6,'RelTol',1e-4,'AbsTol',1e-13)/integral3(f_Therm, xMin*1e-6,xMax*1e-6,yMin*1e-6,yMax*1e-6,zMin*1e-6,zMax*1e-6,'RelTol',1e-4,'AbsTol',1e-13);
        
        
        %now compute the density from the distribution of zcam in situ xTF
      
        nCarray=cell(1,length(xTFm));
        NcTemp=mNa^2*(omegaX*omegaZ*xTFm.*zTFm).^2.5/(15*hbar^2*omegabar^3*a_s);
        densityCarr=zeros(1,length(xTFm));
        %create nC from distribution of different xTF radii measured by
        %zcam
        for jdx=1:length(xTFm)
            ftemp=@(x,y,z)15./(8*pi.*xTFm(jdx)*yTFm(jdx)*zTFm(jdx)).*(1-x.^2/xTFm(jdx).^2-y.^2/yTFm(jdx)^2-z.^2/zTFm(jdx)^2).*heaviside(1-x.^2/xTFm(jdx).^2-y.^2/yTFm(jdx)^2-z.^2/zTFm(jdx)^2);
            nCarray{jdx}=@(x,y,z)ftemp(x,y,z)*NcTemp(jdx);
            
            gtemp=@(x,y,z)nCarray{jdx}(x,y,z).*ftemp(x,y,z);
            denom=integral3(ftemp, xMin*1e-6,xMax*1e-6,yMin*1e-6,yMax*1e-6,zMin*1e-6,zMax*1e-6);
            if(denom<eps)
                densityCarr(jdx)=0;
            else
                densityCarr(jdx)=integral3(gtemp, xMin*1e-6,xMax*1e-6,yMin*1e-6,yMax*1e-6,zMin*1e-6,zMax*1e-6)/denom;
            end
        end
        densityCarr(isnan(densityCarr))=0;
        figure(4);clf;
        hist(densityCarr/1e6); hold on;
        ylabel('N images'); xlabel('density cm^{-3}');
        title(strcat('Box ', num2str(idx)'));
        densitySorted=sort(densityCarr)/1e6; %in cm^-3
        densityCmedian(idx)=median(densitySorted);
        densityCLB(idx)=densitySorted(lowIdx);
        densityCUB(idx)=densitySorted(highIdx);
        plot([densityCmedian(idx) densityCmedian(idx)], [0 length(xTFm)/5],'g-');
        plot([densityCLB(idx) densityCLB(idx)],[0 length(xTFm)/5],'r-');
        plot([densityCUB(idx) densityCUB(idx)], [0 length(xTFm)/5],'r-');
        drawnow;
    end
    densityC(isnan(densityC))=0;
    densityPerBox = densityC+densityT;
    
    
    VarSysC=zeros(1,numBoxes);
    VarT=zeros(1,numBoxes);
    % compute variance of each BEC box from mean density
    for idx=1:numBoxes
        fprintf(['Variance of MarqueeBox: ' num2str(idx) '/' num2str(numBoxes) '\n'])
        xMin = MarqueeBoxesInMuMeter(idx,1);
        xMax = MarqueeBoxesInMuMeter(idx,1)+MarqueeBoxesInMuMeter(idx,3);
        yMin = MarqueeBoxesInMuMeter(idx,2);
        yMax = MarqueeBoxesInMuMeter(idx,2)+MarqueeBoxesInMuMeter(idx,4);

        if(densityC(min(numBoxes,idx+2))>0 && densityC(idx)>0 )
            g_BEC=@(x,y,z) (1e12*Nc.*f_BEC(x,y,z)-densityC(idx)).^2.*f_BEC(x,y,z);
            VarSysC(idx)=integral3(g_BEC, xMin,xMax,yMin,yMax,zMin,zMax,'RelTol',1e-4,'AbsTol',1e-13)/integral3(f_BEC, xMin,xMax,yMin,yMax,zMin,zMax,'RelTol',1e-4,'AbsTol',1e-13);      
        elseif(densityC(idx)==0)
            %h_Therm inputs in meter, output in cm^-6*f_Therm
            h_Therm=@(x,y,z) (g_Therm(x,y,z)/lambdaDB^6/10^12-densityT(idx)^2).*f_Therm(x,y,z);
            VarT(idx) =  integral3(h_Therm,xMin*1e-6,xMax*1e-6,yMin*1e-6,yMax*1e-6,zMin*1e-6,zMax*1e-6,'RelTol',1e-4,'AbsTol',1e-13)/integral3(f_Therm,xMin*1e-6,xMax*1e-6,yMin*1e-6,yMax*1e-6,zMin*1e-6,zMax*1e-6,'RelTol',1e-4,'AbsTol',1e-13);
        end
    end
    VarSysC(isnan(VarSysC))=0;
    VarCHigh=(VarSysC+(densityCUB-densityCmedian).^2);
    VarCLow=(VarSysC+(densityCLB-densityCmedian).^2);
    
    VarHigh=VarCHigh+VarT;
    VarLow=VarCLow+VarT;
        


    for idx = 1:numBoxes
        if(densityC(idx)>0)
            localToverTc(idx)=localToverTcfun([densityC(idx) densityT(idx)]);
            localToverTcCi(idx,1)=localToverTcfun([densityC(idx)+sqrt(VarHigh(idx)) densityT(idx)]);
            localToverTcCi(idx,2)=localToverTcfun([max(0,densityC(idx)-sqrt(VarLow(idx))) densityT(idx)]);
        else
            localToverTc(idx) = localToverTcfunThermal(temp,(densityT(idx))*10^6);
            localToverTcCi(idx,1)=localToverTcfunThermal(temp, (densityT(idx)+sqrt(VarHigh(idx)))*10^6);
            localToverTcCi(idx,2)=localToverTcfunThermal(temp, (densityT(idx)-sqrt(VarLow(idx)))*10^6);        
        end
    end
    
    densityC_quad=densityC;
    densityT_quad=densityT;
    VarianceHigh_quad=VarHigh;
    VarianceLow_quad=VarLow;
    VarianceT_quad=VarT;
    localToverTc_quad=localToverTc;
    
    localToverTcCi_quad=localToverTcCi;
    densityPerBox_quad=densityPerBox;
    
    % plot per box
    figure(555); clf;
    subplot(1,3,1);
    hold on;
    xlabel(['Density box number']);
    ylabel('Density (cm^{-3})');
    title(['Density, T/T_{C} = ',num2str(ToverTcGlobal,2),' \mu(kHz) = ',num2str(chemicalPotential/PlanckConst/1000,2) ]);
    plot(1:numBoxes, densityC_quad,'.','MarkerSize',20);
    plot(1:numBoxes, densityT_quad,'.','MarkerSize',20);

    errorbar(1:numBoxes, densityPerBox_quad,sqrt(VarianceLow_quad),sqrt(VarianceHigh_quad),'.','MarkerSize',20);
    ax = gca;
    ax.ColorOrderIndex = 1;
    legend('BEC density/box','Therm density/box','Total density/box','Location', 'Best');
    xticks(1:numBoxes)
    hold off;
    
    figure(555);
    subplot(1,3,2);hold on;
    xlabel(['Density box number']);
    ylabel('local T/T_C');
    title(['T/T_C per box for ' num2str(Nc,2) ' BEC atoms and ' num2str(NThermalBosons,2) ' thermal atoms']);
    errorbar(1:numBoxes,  localToverTc_quad,localToverTc_quad-localToverTcCi_quad(:,1),localToverTcCi_quad(:,2)-localToverTc_quad,'.','MarkerSize',20);
    ax = gca;
    ax.ColorOrderIndex = 1;
    plot([1,numBoxes],[ToverTcGlobal, ToverTcGlobal],'LineWidth',2);
    %plot([ceil(BEC_X.TF/2.48/analysisBoxInPixel*2) ceil(BEC_X.TF/2.48/analysisBoxInPixel*2)] ,[0 1]);
    legend('local T/T_C',strcat('Global T/T_C = ',num2str(ToverTcGlobal,2)),'BEC edge' ,'Location', 'Best');

    xticks(1:numBoxes)
    hold off;
    
    subplot(1,3,3);hold on;
    plot(localToverTcfunThermal(temp,densityPerBox_quad*10^6), densityC_quad./densityPerBox_quad,'.','MarkerSize',20);
    plot(0:.1:max(localToverTc_quad),heaviside(1-[0:.1:max(localToverTc_quad)].^1.5).*(1-[0:.1:max(localToverTc_quad)].^1.5),'LineWidth',2);
    title('Condensate fraction vs T/Tc');
    legend('nc/n from data vs T/Tc (localToverTcfunThermal)','1-(T/Tc)^{1.5}');
    xlabel('T/Tc');ylabel('n_c/n');
    
    
    
    analysis = struct;
    analysis.densityPerBox  = densityPerBox;
    analysis.densityC       = densityC;
    analysis.densityT       = densityT;
    analysis.densityCmed    =densityCmedian;
    analysis.localToverTc   = localToverTc;
    analysis.localToverTcCi = localToverTcCi;
    analysis.globalToverTc  = ToverTcGlobal;
    analysis.Nc             = Nc;
    analysis.Nt             = NThermalBosons;        
    
    analysis.densityC_quad          = densityC_quad;
    analysis.densityT_quad          = densityT_quad;
    analysis.VarianceHigh_quad      = VarianceHigh_quad;
    analysis.VarianceLow_quad        =VarianceLow_quad;
    analysis.VarianceT_quad      = VarianceT_quad;
    analysis.localToverTc_quad   = localToverTc_quad;
    analysis.localToverTcCi_quad = localToverTcCi_quad;
    analysis.densityPerBox_quad  = densityPerBox_quad;
    analysis.chemicalPotential   = chemicalPotential;
end