function analysis = extractDensityAndTemperatureBose2D(GaussX,GaussY,GaussZ,BEC_X,BEC_Y,BEC_Z,KData,boxWidths,boxHeigths,varargin)
%Inputs: Gaussian and BEC bimodal fit structures from TOF, KData specifying
%integration limits, analysis box size in pixels, and number of boxes to
%analyze
%Outputs: local nBEC, nThermal, nTotal, local T/Tc computed for homogeneous
%gas, global T/Tc
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
    
    MarqueeBoxesInPixel = createMarqueeBoxes(0,0,boxWidths,boxHeigths);
    MarqueeBoxesInMuMeter=MarqueeBoxesInPixel*micronPerPixel; %in micron, horizontal box dimension
    numBoxes = length(MarqueeBoxesInMuMeter(:,1));
    
    FermionSigma = mean(KData.analysis.fitIntegratedGaussY.param(:,4));
    %zlim=2*FermionSigma*micronPerPixel; %radius in micron
    zlim=FermionSigma/sqrt(2)*micronPerPixel; 
    %the Gaussian z-width divided by sqrt(2) is the real standard deviation (68% from -zlim to zlim) (micron)
    
    
    if camera == 'y'
        omegaX = BEC_Z.Omegas(1);
        omegaY = BEC_Z.Omegas(2);
        omegaZ = BEC_Z.Omegas(3);
        
        xTF = BEC_X.TF;
        zTF = BEC_Z.TF;
        
        dX = (BEC_X.chemicalPotCi(2) - BEC_X.chemicalPotCi(1))/2;
        dZ = (BEC_Z.chemicalPotCi(2) - BEC_Z.chemicalPotCi(1))/2;
        
        yTF = (xTF*omegaX/omegaY/dX+zTF*omegaZ/omegaY/dZ)/(1/dX+1/dZ);
        
        temp=(GaussX.temperature/range(GaussX.temperatureCI)+GaussZ.temperature/range(GaussZ.temperatureCI))/(1/range(GaussX.temperatureCI)+1/range(GaussZ.temperatureCI))/1e9;
    
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
        
        temp=(GaussX.temperature/range(GaussX.temperatureCI)+GaussY.temperature/range(GaussY.temperatureCI))/(1/range(GaussX.temperatureCI)+1/range(GaussY.temperatureCI))/1e9;
    
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

    %temp=(GaussX.temperature+GaussZ.temperature)/2e9; %classical temperature from Gaussian fits
    beta=1/kB/temp;
    lambdaDB= PlanckConst/sqrt(2*pi*mNa*kB*temp);
    f_Therm=@(x,y,z) real(PolyLog(1.5,exp(-beta*abs(chemicalPotential-1/2*mNa*(omegaX^2*x.^2+omegaY^2*y.^2+omegaZ^2*z.^2)))));
    
    %Normalization of f_Therm so that f_Therm/normBose has integral across 3-space =1
    intLimit=GaussX.GaussianWidth*10*1e-6;%integration limits in meter
    fprintf('calculating number of thermal Bosons \n')
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

    
    %BEC Density will be in units of /cm^3, thus necessitating a conversion
    %factor of (10^4)^3 from microns^-3
    %Thermal Density will be in units of /cm^3, thus necessitating a conversion
    %factor of (10^-2)^3 from m^-3
    
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
    end
    densityC(isnan(densityC))=0;
    densityPerBox = densityC+densityT;
    
    
    VarianceC=zeros(1,numBoxes);
    VarianceT=zeros(1,numBoxes);
    % compute variance of each BEC box from mean density
    for idx=1:numBoxes
        fprintf(['Variance of MarqueeBox: ' num2str(idx) '/' num2str(numBoxes) '\n'])
        xMin = MarqueeBoxesInMuMeter(idx,1);
        xMax = MarqueeBoxesInMuMeter(idx,1)+MarqueeBoxesInMuMeter(idx,3);
        yMin = MarqueeBoxesInMuMeter(idx,2);
        yMax = MarqueeBoxesInMuMeter(idx,2)+MarqueeBoxesInMuMeter(idx,4);
        zMin = 0;
        zMax = zlim;
        if(densityC(min(numBoxes,idx+2)>0))
            g_BEC=@(x,y,z) (1e12*Nc.*f_BEC(x,y,z)-densityC(idx)).^2.*f_BEC(x,y,z);
            VarianceC(idx)=integral3(g_BEC, xMin,xMax,yMin,yMax,zMin,zMax,'RelTol',1e-4,'AbsTol',1e-13)/integral3(f_BEC, xMin,xMax,yMin,yMax,zMin,zMax,'RelTol',1e-4,'AbsTol',1e-13);      
        elseif(densityC(idx+1)==0)
            %h_Therm inputs in meter, output in cm^-6*f_Therm
            h_Therm=@(x,y,z) (g_Therm(x,y,z)/lambdaDB^6/10^12-densityT(idx)^2).*f_Therm(x,y,z);
            VarianceT(idx) =  integral3(h_Therm,xMin*1e-6,xMax*1e-6,yMin*1e-6,yMax*1e-6,zMin*1e-6,zMax*1e-6,'RelTol',1e-4,'AbsTol',1e-13)/integral3(f_Therm,xMin*1e-6,xMax*1e-6,yMin*1e-6,yMax*1e-6,zMin*1e-6,zMax*1e-6,'RelTol',1e-4,'AbsTol',1e-13);
        end
    end
    VarianceC(isnan(VarianceC))=0;
    
    
    %Outside of BEC, T/Tc in a homogeneous gas, x = density (m^-3), tempK =
    
    %Temperature measured from thermal wings in Kelvin, x is density in
    %m^-3
    localToverTcfunThermal=@(tempK,x) tempK./(hbar^2*3.313/mNa*x.^(2/3)/kB); 
    %From Stringari "Theory of BEC in trappged gases" pg 469, the
    %result for an ideal homogeneous gas
    localToverTc    = zeros(numBoxes,1);
    localToverTcCi =  zeros(numBoxes,2);
    for idx = 1:numBoxes
        localToverTcfun = @(x) (max(0,1-x(1)./(x(1)+densityT(idx)))).^(2/3);
        if(sqrt(VarianceC(idx))>0)
            A = generateMCparameters('gaussian',[densityC(idx),sqrt(VarianceC(idx))],'numSamples',10000);
            paramMatrix = [A];
            [localToverTc(idx),localToverTcCi(idx,:),~] = propagateErrorWithMC(localToverTcfun, paramMatrix, 'plot', true);
        elseif(sqrt(VarianceC(idx))==0 && densityC(idx)>0)
            localToverTc(idx) = localToverTcfun(densityC(idx));
            localToverTcCi(idx,:) = [localToverTc(idx),localToverTc(idx)];
        else
            localToverTc(idx) = localToverTcfunThermal(temp,(densityC(idx)+densityT(idx))*10^6);
            localToverTcCi(idx,:) = [localToverTc(idx),localToverTc(idx)];
        end
    end
    localToverTcCi = real(localToverTcCi);
    
    
    % quadrant averaging
    trueBoxNumber = length(MarqueeBoxesInPixel(:,1))/4;
    for jdx = 1:length(boxHeigths)
        for kdx = 1:length(boxWidths)
            boxIdx = [(2*kdx-1)+4*length(boxWidths)*(jdx-1),...
                  (2*kdx)+4*length(boxWidths)*(jdx-1),...
                  (2*kdx-1)+4*length(boxWidths)*(jdx-1)+2*length(boxWidths),...
                  (2*kdx)+4*length(boxWidths)*(jdx-1)+2*length(boxWidths)];
            trueBoxIdx = (jdx-1)*length(boxWidths)+kdx;
            densityC_quad(trueBoxIdx)       = mean(densityC(boxIdx));
            densityT_quad(trueBoxIdx)       = mean(densityT(boxIdx));
            VarianceC_quad(trueBoxIdx)      = mean(VarianceC(boxIdx));
            VarianceT_quad(trueBoxIdx)      = mean(VarianceT(boxIdx));
            localToverTc_quad(trueBoxIdx)   = mean(localToverTc(boxIdx));
            localToverTcCi_quad(trueBoxIdx,:) = mean(localToverTcCi(boxIdx,:));
            densityPerBox_quad(trueBoxIdx)  = mean(densityPerBox(boxIdx));
        end
    end
    
    % plot per box
    figure(555); clf;
    subplot(1,3,1);
    hold on;
    xlabel(['Density box number']);
    ylabel('Density (cm^{-3})');
    title(['Density, T/T_{C} = ',num2str(ToverTcGlobal,2),' \mu(kHz) = ',num2str(chemicalPotential/PlanckConst/1000,2) ]);
    errorbar(1:trueBoxNumber, densityC_quad,sqrt(VarianceC_quad),'.','MarkerSize',20);
    errorbar(1:trueBoxNumber, densityT_quad, sqrt(VarianceT_quad),'.','MarkerSize',20);

    plot(1:trueBoxNumber, densityPerBox_quad,'.','MarkerSize',20);
    ax = gca;
    ax.ColorOrderIndex = 1;
    legend('Avg. BEC density/box','Avg. Therm density/box','Avg. Total density/box','Location', 'Best');
    xticks(1:numBoxes)
    hold off;
    
    figure(555);
    subplot(1,3,2);hold on;
    xlabel(['Density box number']);
    ylabel('local T/T_C');
    title(['T/T_C per box for ' num2str(Nc,2) ' BEC atoms and ' num2str(NThermalBosons,2) ' thermal atoms']);
    errorbar(1:trueBoxNumber,  localToverTc_quad,localToverTc_quad'-localToverTcCi_quad(:,1),localToverTcCi_quad(:,2)-localToverTc_quad','.','MarkerSize',20);
    ax = gca;
    ax.ColorOrderIndex = 1;
    plot([1,trueBoxNumber],[ToverTcGlobal, ToverTcGlobal],'LineWidth',2);
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
    analysis.stdC           = sqrt(VarianceC);
    analysis.densityT       = densityT;
    analysis.stdT           = sqrt(VarianceT);
    analysis.localToverTc   = localToverTc;
    analysis.localToverTcCi = localToverTcCi;
    analysis.globalToverTc  = ToverTcGlobal;
    analysis.Nc             = Nc;
    analysis.Nt             = NThermalBosons;        
    
    analysis.densityC_quad       = densityC_quad;
    analysis.densityT_quad       = densityT_quad;
    analysis.VarianceC_quad      = VarianceC_quad;
    analysis.VarianceT_quad      = VarianceT_quad;
    analysis.localToverTc_quad   = localToverTc_quad;
    analysis.localToverTcCi_quad = localToverTcCi_quad;
    analysis.densityPerBox_quad  = densityPerBox_quad;
    analysis.chemicalPotential   = chemicalPotential;
end