function analysis = extractDensityAndTemperaturePureThermal(GaussX,GaussY,GaussZ,atomNumber,KData,analysisBoxInPixel,numBoxes)
%Requires inputs: 
%GaussXYZ structures with temperature, CI, and gaussian width (um) from Ycam TOF
%atom number in real units (not "bare N count")
%Outputs:
    micronPerPixel=2.48;
   
    h=6.62607004e-34;
    hbar=h/(2*pi);
    aBohr=5.2917721067e-11; %Bohr radius in meter
    a_s=52*aBohr; %Sodium F=1 scattering length, away from FB resonance
    amu=1.6605402e-27; 
    mass=23*amu; %23 Na, 40 K
    kB=1.38064852e-23; %boltzmann
    
    analysisBoxInMuMeter=analysisBoxInPixel*micronPerPixel; %in micron, horizontal box dimension
    FermionSigma = mean(KData.analysis.fitIntegratedGaussY.param(:,4));
    ylim=2*FermionSigma*micronPerPixel; %radius in micron
    
    
        omegaX = 2*pi*12.6;
        omegaY = 2*pi*41;
        omegaZ = 2*pi*101;
        
        
        
        waistX = GaussX.GaussianWidth;
        waistZ = GaussZ.GaussianWidth;
        
        dX = (GaussX.temperatureCI(2) - GaussX.temperatureCI(1))/2;
        dZ = (GaussZ.temperatureCI(2) - GaussZ.temperatureCI(1))/2;
        waistY = (dX*waistX*omegaX/omegaY+dZ*waistZ*omegaZ/omegaY)/(dX+dZ);
        
           

    %thermal density distribution function, norm to 1, units of um^-3
    f_Therm=@(x,y,z) 1/(waistX*waistY*waistZ*pi^1.5)*exp(-x.^2/waistX^2-y.^2/waistY^2-z.^2/waistZ^2);
        
    %Average density for distribution from -xlim, xlim, -ylim, ylim,
    %-zlim,zlim
    densityT=zeros(1,numBoxes);
    %The number density N*f_Therm(x,y,z), multiplied by the probability density
    %function f(x,y,z), with units um^-6
    g_Therm=@(x,y,z) atomNumber*f_Therm(x,y,z).^2;

    
    %Density will be in units of /cm^3, thus necessitating a conversion
    %factor of (10^4)^3

    
    %Boxes along lab x-direction
    %compute mean density per box
    for idx=0:numBoxes-1
        densityT(idx+1)=1e12*integral3(g_Therm, idx*analysisBoxInMuMeter/2,(idx+1)*analysisBoxInMuMeter/2,-ylim,ylim,-ylim,ylim)/integral3(f_Therm, idx*analysisBoxInMuMeter/2,(idx+1)*analysisBoxInMuMeter/2,-ylim,ylim,-ylim,ylim);
    end
    
    VarianceT=zeros(size(densityT));
    % compute variance of each box from mean density
    for idx=0:numBoxes-1
        display(idx)
        g_ThermVar=@(x,y,z) (1e12*atomNumber.*f_Therm(x,y,z)-densityT(idx+1)).^2.*f_Therm(x,y,z);

        if(densityT(idx+1)>0)
            VarianceT(idx+1)=integral3(g_ThermVar, idx*analysisBoxInMuMeter/2,(idx+1)*analysisBoxInMuMeter/2,-ylim,ylim,-ylim,ylim)/integral3(f_Therm, idx*analysisBoxInMuMeter/2,(idx+1)*analysisBoxInMuMeter/2,-ylim,ylim,-ylim,ylim);
        else
            VarianceT(idx+1)=0;
        end
    end
    
    
    figure(555); clf;
    hold on;
    xlabel(['Density box number (' num2str(analysisBoxInPixel) ' pix/box)']);
    ylabel('Density (cm^{-3})');
    %title(['Density per box for T/T_{C} = ',num2str(numberAnalysis.ToverTcGlobal,2),' \mu(kHz) = ',num2str(chemicalPotential/h/1000,2) ]);
    errorbar(1:numBoxes, densityT,sqrt(VarianceT),'.','MarkerSize',20);
    ax = gca;
    ax.ColorOrderIndex = 1;
    plot([1,numBoxes],[1e12*atomNumber*f_Therm(0,0,0), 1e12*atomNumber*f_Therm(0,0,0)],'LineWidth',2)
    legend('Avg. Therm density/box','3D Thermal peak density','Location', 'Best');
    xticks(1:numBoxes)
    hold off;
    
    %local density approximation for Tc in a uniform region, x is density
    %in cm^-3.  Reference PHYSICAL REVIEW LETTERS120, 050405 (2018)
    localTcFun = @(x) 0.436/(2*mass)*hbar^2*(6*pi^2*x*10^6).^(2/3);
    %Compute local Tc in units of nK
    localTc    = localTcFun(densityT)/kB*10^9;
    
    
    figure(556); clf;
    
    subplot(2,1,1);
    hold on;
    xlabel(['Density box number (' num2str(analysisBoxInPixel) ' pix/box)']);
    ylabel('local T_C (nK)');
    plot(1:numBoxes,localTc,'bo','markerFaceColor','b');
    ax = gca;
    ax.ColorOrderIndex = 1;
    xticks(1:numBoxes)
    subplot(2,1,2);
    plot(1:numBoxes, (GaussX.temperature+GaussZ.temperature)/2./localTc,'ro','MarkerFaceColor','r');
    xlabel(['Density box number (' num2str(analysisBoxInPixel) ' pix/box)']);
    ylabel('local T/T_C');
    title(strcat('Temperature (nK) = ',num2str((GaussX.temperature+GaussZ.temperature)/2)));
    hold off;
    
    analysis = struct;
    analysis.densityT       = densityT;
    analysis.stdT           = sqrt(VarianceT);
    analysis.localTc   = localTc;
end