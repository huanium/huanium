function analysis = extractDensityAndTemperature2D(GaussX,GaussY,GaussZ,BEC_X,BEC_Y,BEC_Z,numberAnalysis,KData,boxWidths,boxHeigths,varargin)

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
    
    FermionSigma = mean(KData.analysis.fitIntegratedGaussY.param(:,4));
    zlim=2*FermionSigma*micronPerPixel; %radius in micron
    numBoxes = length(MarqueeBoxesInMuMeter(:,1));
    
    if camera == 'y'
        omegaX = BEC_Z.Omegas(1);
        omegaY = BEC_Z.Omegas(2);
        omegaZ = BEC_Z.Omegas(3);
        
        xTF = BEC_X.TF;
        zTF = BEC_Z.TF;
        
        dX = (BEC_X.chemicalPotCi(2) - BEC_X.chemicalPotCi(1))/2;
        dZ = (BEC_Z.chemicalPotCi(2) - BEC_Z.chemicalPotCi(1))/2;
        yTF = (1/dX*xTF*omegaX/omegaY+1/dZ*zTF*omegaZ/omegaY)/(1/dX+1/dZ);
        
        waistX = GaussX.GaussianWidth;
        waistZ = GaussZ.GaussianWidth;
        
        dX = (GaussX.temperatureCI(2) - GaussX.temperatureCI(1))/2;
        dZ = (GaussZ.temperatureCI(2) - GaussZ.temperatureCI(1))/2;
        waistY = (1/dX*waistX*omegaX/omegaY+1/dZ*waistZ*omegaZ/omegaY)/(1/dX+1/dZ);
        
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
        
        waistX = GaussX.TF;
        waistY = GaussY.TF;
       
        dX = (GaussX.temperatureCI(2) - GaussX.temperatureCI(1))/2;
        dY = (GaussY.temperatureCI(2) - GaussY.temperatureCI(1))/2;
        waistZ = (1/dX*waistX*omegaX/omegaZ+1/dY*waistY*omegaY/omegaZ)/(1/dX+1/dY);
        
        chemicalPotential = h*1000*(1/dX*BEC_X.chemicalPot+1/dY*BEC_Y.chemicalPot)/(1/dX+1/dY);
    end
    omegabar = (omegaX*omegaY*omegaZ)^(1/3);
    
    Nc = (2*chemicalPotential).^(2.5)/(15*hbar^2*sqrt(mNa)*omegabar^3*a_s);
    scaleRatio = numberAnalysis.N_thermal/numberAnalysis.N_BEC;
    
    %The condensate probability density distribution function, normalized to 1 when
    %integrated over all space.  Units of um^-3.
    f_BEC=@(x,y,z) 15/(8*pi*xTF*yTF*zTF)*(1-x.^2/xTF^2-y.^2/yTF^2-z.^2/zTF^2).*heaviside(1-x.^2/xTF^2-y.^2/yTF^2-z.^2/zTF^2);
    %thermal density distribution function, norm to 1
    f_Therm=@(x,y,z) 1/(waistX*waistY*waistZ*pi^1.5)*exp(-x.^2/waistX^2-y.^2/waistY^2-z.^2/waistZ^2);
    
    %Average density for distribution from -xlim, xlim, -ylim, ylim,
    %-zlim,zlim
    densityC=zeros(1,numBoxes);
    densityT=densityC;
    %The number density Nc*f(x,y,z), multiplied by the probability density
    %function f(x,y,z), with units um^-6
    g_BEC=@(x,y,z) Nc*f_BEC(x,y,z).^2;
    g_Therm=@(x,y,z) Nc*scaleRatio*f_Therm(x,y,z).^2;

    
    %Density will be in units of /cm^3, thus necessitating a conversion
    %factor of (10^4)^3

    
    %Boxes along lab x-direction
    %compute mean density per box in /cm^3
    
    
    for idx=1:numBoxes
        fprintf(['MarqueeBox: ' num2str(idx) '/' num2str(numBoxes) '\n'])
        xMin = MarqueeBoxesInMuMeter(idx,1);
        xMax = MarqueeBoxesInMuMeter(idx,1)+MarqueeBoxesInMuMeter(idx,3);
        yMin = MarqueeBoxesInMuMeter(idx,2);
        yMax = MarqueeBoxesInMuMeter(idx,2)+MarqueeBoxesInMuMeter(idx,4);
        zMin = -zlim;
        zMax = zlim;
        densityC(idx)=1e12*integral3(g_BEC, xMin,xMax,yMin,yMax,zMin,zMax)/integral3(f_BEC, xMin,xMax,yMin,yMax,zMin,zMax);
        densityT(idx)=1e12*integral3(g_Therm, xMin,xMax,yMin,yMax,zMin,zMax)/integral3(f_Therm, xMin,xMax,yMin,yMax,zMin,zMax);
    end
    densityC(isnan(densityC))=0;
    
    VarianceC=zeros(1,numBoxes);
    VarianceT=VarianceC;
%     % compute variance of each box from mean density
%     for idx=0:numBoxes-1
%         display(idx)
%         g_BEC=@(x,y,z) (1e12*Nc.*f_BEC(x,y,z)-densityC(idx+1)).^2.*f_BEC(x,y,z);
%         g_Therm=@(x,y,z) (1e12*Nc*scaleRatio.*f_Therm(x,y,z)-densityT(idx+1)).^2.*f_Therm(x,y,z);
%         if(densityC(min(numBoxes,idx+2))>0)
%             VarianceC(idx+1)=integral3(g_BEC, idx*analysisBoxInMuMeter/2,(idx+1)*analysisBoxInMuMeter/2,-zlim,zlim,-zlim,zlim)/integral3(f_BEC, idx*analysisBoxInMuMeter/2,(idx+1)*analysisBoxInMuMeter/2,-zlim,zlim,-zlim,zlim);
%         else
%             VarianceC(idx+1)=0;
%         end
%         if(densityT(idx+1)>0)
%             VarianceT(idx+1)=integral3(g_Therm, idx*analysisBoxInMuMeter/2,(idx+1)*analysisBoxInMuMeter/2,-zlim,zlim,-zlim,zlim)/integral3(f_Therm, idx*analysisBoxInMuMeter/2,(idx+1)*analysisBoxInMuMeter/2,-zlim,zlim,-zlim,zlim);
%         else
%             VarianceT(idx+1)=0;
%         end
%     end
    VarianceC(isnan(VarianceC))=0;
    
    
    figure(555); clf;
    subplot(1,3,1);
    hold on;
    xlabel(['Density box number']);
    ylabel('Density (cm^{-3})');
    title(['Density per box for T/T_{C} = ',num2str(numberAnalysis.ToverTcGlobal,2),' \mu(kHz) = ',num2str(chemicalPotential/PlanckConst/1000,2) ]);
    errorbar(1:numBoxes, densityC,sqrt(VarianceC),'.','MarkerSize',20);
    errorbar(1:numBoxes, densityT,sqrt(VarianceT),'.','MarkerSize',20);
    plot(1:numBoxes, densityC+densityT,'.','MarkerSize',20);
    ax = gca;
    ax.ColorOrderIndex = 1;
    plot([1,numBoxes],[1e12*Nc*f_BEC(0,0,0), 1e12*Nc*f_BEC(0,0,0)],'LineWidth',2)
    plot([1,numBoxes],[1e12*Nc*scaleRatio*f_Therm(0,0,0), 1e12*Nc*scaleRatio*f_Therm(0,0,0)],'LineWidth',2)
    legend('Avg. BEC density/box','Avg. Therm density/box','Avg. Total density/box','3D BEC peak density','3D Thermal peak density','Location', 'Best');
    xticks(1:numBoxes)
    hold off;
    
    localToverTcfun = @(x) (1-x(1)./(x(1)+x(2))).^(2/3);
    %Outside of BEC, T/Tc in a homogeneous gas, x = density (m^-3), tempK =
    %temperature measured from thermal wings in Kelvin
    localToverTcfunThermal=@(tempK,x) tempK/(hbar^2*3.313/mNa*x.^(2/3)/kB); %From Stringari "Theory of BEC in trapped gases" pg 469
    localToverTc    = zeros(numBoxes,1);
    localToverTcCi =  zeros(numBoxes,2);
    for idx = 1:numBoxes
        
        if(sqrt(VarianceC(idx))>0)
            A = generateMCparameters('gaussian',[densityC(idx),sqrt(VarianceC(idx))],'numSamples',10000);
            B = generateMCparameters('gaussian',[densityT(idx),sqrt(VarianceT(idx))],'numSamples',10000);
            paramMatrix = [A;B];
            [localToverTc(idx),localToverTcCi(idx,:),~] = propagateErrorWithMC(localToverTcfun, paramMatrix);
        elseif(densityC(idx)>0)
            localToverTc(idx) = localToverTcfun([densityC(idx),densityT(idx)]);
            localToverTcCi(idx,:) = [localToverTc(idx),localToverTc(idx)];
        else
            localToverTc(idx) = localToverTcfunThermal((GaussX.temperature+GaussZ.temperature)/2e9,(densityC(idx)+densityT(idx))*10^6);
            localToverTcCi(idx,:) = [localToverTc(idx),localToverTc(idx)];
        end
    end
    
    figure(555);
    subplot(1,3,2);hold on;
    xlabel(['Density box number']);
    ylabel('local T/T_C');
    title(['T/T_C per box for ' num2str(Nc,2) ' BEC atoms and ' num2str(Nc*numberAnalysis.N_thermal/numberAnalysis.N_BEC,2) ' thermal atoms']);
    errorbar(1:numBoxes,  localToverTc,localToverTc-localToverTcCi(:,1),localToverTcCi(:,2)-localToverTc,'.','MarkerSize',20);
    ax = gca;
    ax.ColorOrderIndex = 1;
    plot([1,numBoxes],[numberAnalysis.ToverTcGlobal, numberAnalysis.ToverTcGlobal],'LineWidth',2)
    legend('local T/T_C','Global T/T_C' ,'Location', 'Best');
    xticks(1:numBoxes)
    hold off;
    densityPerBox = densityC+densityT;
    
    subplot(1,3,3);hold on;
    plot(localToverTc, densityC./densityPerBox,'bo','MarkerFaceColor','b');
    plot(0:.1:max(localToverTc),heaviside(1-[0:.1:max(localToverTc)].^1.5).*(1-[0:.1:max(localToverTc)].^1.5),'r');
    title('Condensate fraction vs T/Tc');
    legend('n_c/n from fitted amplitudes','1-(T/Tc)^{1.5}');
    xlabel('T/Tc');ylabel('n_c/n');
    analysis = struct;
    analysis.densityPerBox  = densityPerBox;
    analysis.densityC       = densityC;
    analysis.stdC           = sqrt(VarianceC);
    analysis.densityT       = densityT;
    analysis.stdT           = sqrt(VarianceT);
    analysis.localToverTc   = localToverTc;
    analysis.localToverTcCi = localToverTcCi;
end