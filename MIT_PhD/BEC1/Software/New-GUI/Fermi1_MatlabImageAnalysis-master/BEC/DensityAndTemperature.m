function analysis = DensityAndTemperature(GaussX,GaussZ,BEC_X,BEC_Y,BEC_Z,KData,analysisBoxInPixel,numBoxes,xTFpixZcam,varargin)
%Inputs: Gaussian and BEC bimodal fit structures from TOF, KData specifying
%integration limits, analysis box size in pixels, and number of boxes to
%analyze, and z-cam distribution for xTF (measured in situ, in pixels)

%Outputs: local nBEC, nThermal, nTotal, local T/Tc computed for homogeneous
%gas, global T/Tc

%7/2/18: an update to the "extractDensityAndTemperatureBose" that incorporates the
%error from a distribution of BEC sizes/xTF radii into the varianceC
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
    
    hbar=PlanckConst/(2*pi);
    a_s=52*aBohr; %Sodium F=1 scattering length, away from FB resonance
    
    analysisBoxInMuMeter=analysisBoxInPixel*micronPerPixel; %in micron, horizontal box dimension
    FermionSigma = mean(KData.analysis.fitIntegratedGaussY.param(:,4));
    ylim=FermionSigma/sqrt(2)*micronPerPixel; 
    
    if camera == 'y'
        omegaX = BEC_Z.Omegas(1);
        omegaY = BEC_Z.Omegas(2);
        omegaZ = BEC_Z.Omegas(3);
        
        xTF = BEC_X.TF;
        zTF = BEC_Z.TF;
        
        dX = (BEC_X.chemicalPotCi(2) - BEC_X.chemicalPotCi(1))/2;
        dZ = (BEC_Z.chemicalPotCi(2) - BEC_Z.chemicalPotCi(1))/2;
        yTF = (xTF*omegaX/omegaY/dX+zTF*omegaZ/omegaY/dZ)/(1/dX+1/dZ);

        
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
        
        
        chemicalPotential = PlanckConst*1000*(1/dX*BEC_X.chemicalPot+1/dY*BEC_Y.chemicalPot)/(1/dX+1/dY);
    end
    omegabar = (omegaX*omegaY*omegaZ)^(1/3);
    
    Nc = (2*chemicalPotential).^(2.5)/(15*hbar^2*sqrt(mNa)*omegabar^3*a_s);
    
    %The condensate probability density distribution function, normalized to 1 when
    %integrated over all space.  Units of um^-3.  Inputs in um.
    f_BEC=@(x,y,z) 15/(8*pi*xTF*yTF*zTF)*(1-x.^2/xTF^2-y.^2/yTF^2-z.^2/zTF^2).*heaviside(1-x.^2/xTF^2-y.^2/yTF^2-z.^2/zTF^2);
    
    %Thermal density bose distribution function, inputs in meter
    %use n3d_thermal Bose Gas (r) = g_1.5(z)/lambda^3
    %lambda is de Broglie wavelength in m
    %Equation 6 in Naraschewki+Stamper-Kurn (1998)

    %classical temperature from Gaussian fits
    temp=(GaussX.temperature/range(GaussX.temperatureCI)+GaussZ.temperature/range(GaussZ.temperatureCI))/(1/range(GaussX.temperatureCI)+1/range(GaussZ.temperatureCI))/1e9;
    beta=1/kB/temp;
    lambdaDB= PlanckConst/sqrt(2*pi*mNa*kB*temp);
    f_Therm=@(x,y,z) real(PolyLog(1.5,exp(-beta*abs(chemicalPotential-1/2*mNa*(omegaX^2*x.^2+omegaY^2*y.^2+omegaZ^2*z.^2)))));
    
    %Normalization of f_Therm so that f_Therm/normBose has integral across 3-space =1
    intLimit=GaussX.GaussianWidth*10*1e-6;%integration limits in meter
    normBose=integral3(f_Therm,-intLimit,intLimit,-intLimit,intLimit,-intLimit,intLimit,'AbsTol',1e-13);
    NThermalBosons=normBose/lambdaDB^3;
    
    %Global T/Tc for harmonic trap
    %ToverTcGlobal=(1-Nc/(Nc+NThermalBosons))^(1/3);
    Tc=.94*PlanckConst/2/pi*omegabar/kB*(Nc+NThermalBosons).^(1/3);
    ToverTcGlobal=temp/Tc;
    %Average density for distribution from -xlim, xlim, -ylim, ylim,
    %-zlim,zlim
    densityC=zeros(1,numBoxes);
    densityT=densityC;
    %The number density Nc*f(x,y,z), multiplied by the probability density
    %function f(x,y,z), with units um^-6
    g_BEC=@(x,y,z) Nc*f_BEC(x,y,z).^2;
    
    %Thermal polylog^2, in units of m^-6, inputs in meters.  Recall,
    %integral(f_Therm/lambdaDB^3)=total number of bosons
    g_Therm=@(x,y,z) f_Therm(x,y,z).*f_Therm(x,y,z);

    

    
    %Boxes along lab x-direction
    %compute mean density per box in /cm^3

    VarianceCInt=zeros(1,numBoxes); %variance of C density from finite size integration
    VarianceT=zeros(1,numBoxes); %variance of T density from finite size integration
    %%%%%%%%% for computing std CSize, the statistical error from BEC fluctuation %%%%%%%%%%%%%
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
    figure(4);clf;

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % compute variance of each BEC box from mean density
    for idx=0:numBoxes-1
    %%for idx=48:51
        display(idx);
        %BEC Density will be in units of /cm^3, thus necessitating a conversion
        %factor of (10^4)^3 from microns^-3
        %Thermal Density will be in units of /cm^3, thus necessitating a conversion
        %factor of (10^-2)^3 from m^-3
        densityC(idx+1)=1e12*integral3(g_BEC, idx*analysisBoxInMuMeter/2,(idx+1)*analysisBoxInMuMeter/2,0,ylim,0,ylim,'RelTol',1e-4,'AbsTol',1e-13)/integral3(f_BEC, idx*analysisBoxInMuMeter/2,(idx+1)*analysisBoxInMuMeter/2,0,ylim,0,ylim,'RelTol',1e-4,'AbsTol',1e-13);
        densityT(idx+1)=1e-6*1/lambdaDB^3*integral3(g_Therm, idx*analysisBoxInMuMeter/2e6,(idx+1)*analysisBoxInMuMeter/2e6,0,ylim/10^6,0,ylim/10^6,'RelTol',1e-4,'AbsTol',1e-13)/integral3(f_Therm, idx*analysisBoxInMuMeter/2e6,(idx+1)*analysisBoxInMuMeter/2e6,0,ylim/10^6,0,ylim/10^6,'RelTol',1e-4,'AbsTol',1e-13);
         
        nCarray=cell(1,length(xTFm));
        NcTemp=zeros(size(xTFm));
        densityCarr=zeros(1,length(xTFm));
        %create nC from distribution of different xTF radii measured by
        %zcam
        for jdx=1:length(xTFm)
            ftemp=@(x,y,z)15./(8*pi.*xTFm(jdx)*yTFm(jdx)*zTFm(jdx)).*(1-x.^2/xTFm(jdx).^2-y.^2/yTFm(jdx)^2-z.^2/zTFm(jdx)^2).*heaviside(1-x.^2/xTFm(jdx).^2-y.^2/yTFm(jdx)^2-z.^2/zTFm(jdx)^2);
            NcTemp(jdx)=  mNa^2*omegaX^5*xTFm(jdx).^5/(15*hbar^2*omegabar^3*a_s);
% %             %NcTempTotal=NcTempTotal+NcTemp;
            nCarray{jdx}=@(x,y,z)ftemp(x,y,z)*NcTemp(jdx);
            
            gC=@(x,y,z)nCarray{jdx}(x,y,z).*ftemp(x,y,z);
            denom=integral3(ftemp, idx*analysisBoxInMuMeter/2e6,(idx+1)*analysisBoxInMuMeter/2e6,0,ylim/1e6,0,ylim/1e6);
            if(denom<eps)
                densityCarr(jdx)=0;
            else
                densityCarr(jdx)=integral3(gC, idx*analysisBoxInMuMeter/2e6,(idx+1)*analysisBoxInMuMeter/2e6,0,ylim/1e6,0,ylim/1e6)/denom;
            end
        end
        densityCarr(isnan(densityCarr))=0;

        %subplot(ceil(sqrt(numBoxes)),ceil(sqrt(numBoxes)),idx+1);
        hist(densityCarr/1e6); hold on;
        ylabel('N images'); xlabel('density cm^{-3}');
        title(strcat('Box ', num2str(idx+1)'));
        densitySorted=sort(densityCarr)/1e6; %in cm^-3
        densityCmedian(idx+1)=median(densitySorted);
        densityCLB(idx+1)=densitySorted(lowIdx);
        densityCUB(idx+1)=densitySorted(highIdx);
        plot([densityCmedian(idx+1) densityCmedian(idx+1)], [0 length(xTFm)/5],'g-');
        plot([densityCLB(idx+1) densityCLB(idx+1)],[0 length(xTFm)/5],'r-');
        plot([densityCUB(idx+1) densityCUB(idx+1)], [0 length(xTFm)/5],'r-');
        drawnow;
    end
    densityC(isnan(densityC))=0;
    %calculate variances without taking into account BEC size fluctuation,
    %only the integration size
    for idx=0:numBoxes-1
    %%for idx=48:51
        if(densityC(min(numBoxes,idx+2))>0)
            g_BEC=@(x,y,z) (1e12*Nc.*f_BEC(x,y,z)-densityC(idx+1)).^2.*f_BEC(x,y,z);
            VarianceCInt(idx+1)=integral3(g_BEC, idx*analysisBoxInMuMeter/2,(idx+1)*analysisBoxInMuMeter/2,0,ylim,0,ylim,'RelTol',1e-4,'AbsTol',1e-13)/integral3(f_BEC, idx*analysisBoxInMuMeter/2,(idx+1)*analysisBoxInMuMeter/2,0,ylim,0,ylim,'RelTol',1e-4,'AbsTol',1e-13);
        elseif(densityC(idx+1)==0)
            %h_Therm inputs in meter, output in cm^-6*f_Therm
            h_Therm=@(x,y,z) (g_Therm(x,y,z)/lambdaDB^6/10^12-densityT(idx+1)^2).*f_Therm(x,y,z);
            VarianceT(idx+1) =  integral3(h_Therm,idx*analysisBoxInMuMeter/2e6,(idx+1)*analysisBoxInMuMeter/2e6,0,ylim/10^6,0,ylim/10^6,'RelTol',1e-4,'AbsTol',1e-13)/integral3(f_Therm,idx*analysisBoxInMuMeter/2e6,(idx+1)*analysisBoxInMuMeter/2e6,0,ylim/10^6,0,ylim/10^6,'RelTol',1e-4,'AbsTol',1e-13);
        end

    end
    VarianceCInt(isnan(VarianceCInt))=0;
    % Get errors by adding variances
    VarCHigh=(VarianceCInt+(densityCUB-densityCmedian).^2);
    VarCLow=(VarianceCInt+(densityCLB-densityCmedian).^2);
    
    
    figure(555); clf;
    subplot(1,3,1);
    hold on;
    xlabel(['Density box number (' num2str(analysisBoxInPixel) ' pix/box)']);
    ylabel('Density (cm^{-3})');
    title(['Density, T/T_{C} = ',num2str(ToverTcGlobal,2),' \mu(kHz) = ',num2str(chemicalPotential/PlanckConst/1000,2) ]);

    
    errorbar(1:numBoxes,densityC,sqrt(VarCLow),sqrt(VarCHigh),'b.','MarkerSize',20');
    errorbar(1:numBoxes, densityT, sqrt(VarianceT),'g.','MarkerSize',20);

    plot(1:numBoxes, densityC+densityT,'r.','MarkerSize',20);
    ax = gca;
    ax.ColorOrderIndex = 1;

    legend('Avg. BEC density/box','Avg. Therm density/box','Avg. Total density/box','Location', 'Best');
    xticks(1:numBoxes)
    hold off;
    
    
    %%%%%%%%%%%%%%% get local T/Tc assuming LDA %%%%%%%%%%%%%%%
    %inside BEC, estimate T/Tc from condensate fraction
    localToverTcfun = @(x) (max(0,1-x(1)./(x(1)+x(2)))).^(2/3);
    %Outside of BEC, T/Tc in a homogeneous gas, x = density (m^-3), tempK
    %is temperature measured from thermal wings in Kelvin, x is density in
    %m^-3
    localToverTcfunThermal=@(tempK,x) tempK./(hbar^2*3.313/mNa*x.^(2/3)/kB); %From Stringari "Theory of BEC in trappged gases" pg 469
    localToverTc    = zeros(numBoxes,1);
    localToverTcCi =  zeros(numBoxes,2);

   for idx=1:numBoxes
    %%for idx=49:52
        if(densityC(idx)>0)
            localToverTc(idx)=localToverTcfun([densityC(idx) densityT(idx)]);
            localToverTcCi(idx,1)=localToverTcfun([densityC(idx)+sqrt(VarCLow(idx)) densityT(idx)]);
            localToverTcCi(idx,2)=localToverTcfun([max(0,densityC(idx)-sqrt(VarCHigh(idx))) densityT(idx)]);
        else
            localToverTc(idx) = localToverTcfunThermal(temp,(densityT(idx))*10^6);
            localToverTcCi(idx,1)=localToverTcfunThermal(temp, (densityT(idx)+sqrt(VarianceT(idx)))*10^6);
            localToverTcCi(idx,2)=localToverTcfunThermal(temp, (densityT(idx)-sqrt(VarianceT(idx)))*10^6);        
        end
    end
    figure(555);
    subplot(1,3,2);hold on;
    xlabel(['Density box number (' num2str(analysisBoxInPixel) ' pix/box)']);
    ylabel('local T/T_C');
    title(['T/T_C per box for ' num2str(Nc,2) ' BEC atoms and ' num2str(NThermalBosons,2) ' thermal atoms']);
    errorbar(1:numBoxes,  localToverTc,localToverTc-localToverTcCi(:,1),localToverTcCi(:,2)-localToverTc,'.','MarkerSize',20);
    ax = gca;
    ax.ColorOrderIndex = 1;
    plot([1,numBoxes],[ToverTcGlobal, ToverTcGlobal],'LineWidth',2);
    plot([ceil(BEC_X.TF/2.48/analysisBoxInPixel*2) ceil(BEC_X.TF/2.48/analysisBoxInPixel*2)] ,[0 1]);
    legend('local T/T_C',strcat('Global T/T_C = ',num2str(ToverTcGlobal,2)),'BEC edge' ,'Location', 'Best');

    xticks(1:numBoxes)
    hold off;
    densityPerBox = densityC+densityT;
    
    subplot(1,3,3);hold on;
    plot(localToverTcfunThermal(temp,densityPerBox*10^6), densityC./densityPerBox,'bo','MarkerFaceColor','b');
    plot(0:.1:max(localToverTc),heaviside(1-[0:.1:max(localToverTc)].^1.5).*(1-[0:.1:max(localToverTc)].^1.5),'r');
    title('Condensate fraction vs T/Tc');
    legend('nc/n from data vs T/Tc (localToverTcfunThermal)','1-(T/Tc)^{1.5}');
    xlabel('T/Tc');ylabel('n_c/n');
    analysis = struct;
    analysis.densityPerBox  = densityPerBox;
    analysis.densityC       = densityC;
    analysis.densityCLowErr = sqrt(VarCLow);
    analysis.densityCHighErr= sqrt(VarCHigh);
    analysis.densityT       = densityT;
    analysis.stdT           = sqrt(VarianceT);
    analysis.localToverTc   = localToverTc;
    analysis.localToverTcCi = localToverTcCi;
    analysis.globalToverTc  = ToverTcGlobal;
    analysis.Nc             = Nc;
    analysis.Nt             = NThermalBosons;              
end