%Last edited 4/17/18 to include new fitBimodalExcludeCenter orders of
%parameters
function [densityPerBox, ToverTc, Nc] = condensate3DdensityRunAnalysis(KData,NaData,numBoxes,boxWidth,camera,varargin)
%Last edited 4/2/18 to include T/Tc and Nc calculations
%Inputs-----------------------------------------
%NaData must have the field "fitBimodalExcludeCenter" for the TF and
%gaussian radii

%KData has field ".analysis.fitIntegratedGaussY.param(:,4)" which comes
%from running "fitIntegratedGaussian"

%Select camera = 'z' or 'y' to get the correct coordinates

%Outputs----------------------------------------
%densityPerBox is the total Na (condensate+thermal) density, 3D, in cm^-3
%T/Tc is calculated from the number fraction N/Nc
    p = inputParser;

    p.addParameter('ChemicalPotential',nan);
    p.parse(varargin{:});
    ChemicalPotential  = p.Results.ChemicalPotential;

    %Using Thomas-Fermi approx, calculate average density per marquee box
    %Use <n3D> = Integral over volume (n3D*f3D)=N* Integral over volume(f3D*f3D)
    %where n3D is the density (number N per vol) and
    %f3D is the distribution function ==n3D/N

    %%%%%%%%%%%% BEC properties from fitting %%%%%%%%%%%%%%%%%%%%%%%%
    if camera=='z'
        micronPerPixel=2.5; %camera magnification
    elseif camera=='y'
        micronPerPixel=2.48;
    else
        error('Error: please choose "z" or "y" camera\n');
    end
    %%CONSTANTS%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    h=6.62607004e-34;
    hbar=h/(2*pi);
    aBohr=5.2917721067e-11; %Bohr radius in meter
    a_s=52*aBohr; %Sodium F=1 scattering length, away from FB resonance
    amu=1.6605402e-27; 
    mass=23*amu; %23 Na, 40 K
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Measurement box properties
    boxsize=boxWidth*micronPerPixel; %in micron, horizontal box dimension
    FermionSigma = mean(KData.analysis.fitIntegratedGaussY.param(:,4));
    ylim=2*FermionSigma*micronPerPixel; %radius in micron
    
    %%%%%%%%%%%%%% Na Properties %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Needs the fitBimodal properies
    BECanalysisData=struct;
    BECanalysisData.trapFreqZ=101; 
    BECanalysisData.trapFreqY=41; %Trap freq in Hz
    BECanalysisData.trapFreqX=12.6;
    omegabar=2*pi*(BECanalysisData.trapFreqX*BECanalysisData.trapFreqY*BECanalysisData.trapFreqZ)^(1/3);

    
    %Condensate TF sizes 
    if camera == 'z' %(using the best SNR fits from the x width)
        xTF=micronPerPixel*mean(NaData.analysis.fitBimodalExcludeCenter.xparam(:,2)); %TF x radius in micron
        zTF=xTF*BECanalysisData.trapFreqX/BECanalysisData.trapFreqZ; %Estimate the TF z radius
        yTF=xTF*BECanalysisData.trapFreqX/BECanalysisData.trapFreqY; %Estimate the TF y radius

        %Thermal gaussian portion-from x fits, and scaling to y and z widths
        %xw, yw, zw defined as exp(-x^2/xw^2), without the normal factor of 2

        xw=micronPerPixel*mean(NaData.analysis.fitBimodalExcludeCenter.GaussianWingsX(:,3));
        zw=xw*BECanalysisData.trapFreqX/BECanalysisData.trapFreqZ;
        yw=xw*BECanalysisData.trapFreqX/BECanalysisData.trapFreqY;

        %Chemical potential of BEC and number in condensate
        if isnan(ChemicalPotential)
            chemicalPotential=1/2*mass*(2*pi*BECanalysisData.trapFreqX)^2.*(xTF.^2*10^-12); %in Joules
        else
            chemicalPotential = ChemicalPotential*1000*h;
        end
    else
        %Y-cam ,(using the best SNR fits from the lab z= camera x width, and lab x=camera y width)
        zTF=micronPerPixel*mean(NaData.analysis.fitBimodalExcludeCenter.xparam(:,2)); %TF x radius in micron
        %xTF=micronPerPixel*mean(NaData.analysis.fitBimodalExcludeCenter.yparam(:,4).*NaData.analysis.fitBimodalExcludeCenter.yparam(:,5)); %Estimate the TF y radius
        xTF=zTF*BECanalysisData.trapFreqZ/BECanalysisData.trapFreqX; %Estimate the TF y radius from x, y
        yTF=zTF*BECanalysisData.trapFreqZ/BECanalysisData.trapFreqY; %Estimate the TF y radius from x, y

        %Thermal gaussian portion-from x fits, and scaling to y and z widths
        %xw, yw, zw defined as exp(-x^2/xw^2), without the normal factor of 2

        zw=micronPerPixel*mean(NaData.analysis.fitBimodalExcludeCenter.GaussianWingsX(:,3));
        %xw=micronPerPixel*mean(NaData.analysis.fitBimodalExcludeCenter.yparam(:,5));
        xw=zw*BECanalysisData.trapFreqZ/BECanalysisData.trapFreqX;
        yw=zw*BECanalysisData.trapFreqZ/BECanalysisData.trapFreqY;

        %Chemical potential of BEC and number in condensate using lab
        %Y-coord, the average of the measured z, x coordinates
        if isnan(ChemicalPotential)
            chemicalPotential=1/2*mass*(2*pi*BECanalysisData.trapFreqZ)^2.*(zTF.^2*10^-12); %in Joules
        else
            chemicalPotential = ChemicalPotential*1000*h;
        end
    end
    BECanalysisData.Nc = (2*chemicalPotential).^2.5/(15*hbar^2*sqrt(mass)*omegabar^3*a_s);

    %%%%%%%%%%%%%%%%% End of Na properties %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %%%%%%%%%%%%%%%%% Begin profile analysis %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %Calculate the 3D relative amplitude of the BEC: thermal
    %nc1Dx=nc3D*zTF*yTF*pi/2, and
    %nt1Dx=nt3D*zw*yw*pi
    %Therefore nc3D/nt3D = 2 zw yw nc1D/(zTF yTF nt1D)

    %Fitted ratio between c:t peak density amplitude, 
    %extracted from 1D integrated fits along X, scaled to 3D
    if camera=='z'
        ratio1D=mean(NaData.analysis.fitBimodalExcludeCenter.xparam(:,1)./NaData.analysis.fitBimodalExcludeCenter.GaussianWingsX(:,1));
        ratio3D=mean(ratio1D*zw*yw*2/zTF/yTF);
    else
        %1D density=number/distance, 3D density= number/volume
        %Fitted amplitudes are all 1D densities
        %Take ratio of BEC: thermal amplitudes in 1D, convert to 3D
        ratio1Dz=mean(NaData.analysis.fitBimodalExcludeCenter.xparam(:,1)./NaData.analysis.fitBimodalExcludeCenter.GaussianWingsX(:,1));
        ratio3D=ratio1Dz*xw*yw*2/xTF/yTF; 
        %ratio1Dx=mean(NaData.analysis.fitBimodalExcludeCenter.yparam(:,1)./NaData.analysis.fitBimodalExcludeCenter.yparam(:,2));
        %ratio3Dx=ratio1Dx*yw*zw*2/yTF/zTF;
        %ratio3D=sqrt(ratio3Dz*ratio3Dx);
    end
    %The condensate probability density distribution function, normalized to 1 when
    %integrated over all space.  Units of um^-3.
    f=@(x,y,z) 15/(8*pi*xTF*yTF*zTF)*(1-x.^2/xTF^2-y.^2/yTF^2-z.^2/zTF^2).*heaviside(1-x.^2/xTF^2-y.^2/yTF^2-z.^2/zTF^2);
    %thermal density distribution function, norm to 1
    ftherm=@(x,y,z) 1/(xw*yw*zw*pi^1.5)*exp(-x.^2/xw^2-y.^2/yw^2-z.^2/zw^2);
    
    scaleRatio=f(0,0,0)/ftherm(0,0,0)/ratio3D; %factor that Gaussian 3D peak is smaller than condensate 3D peak 
    
    %Check to make sure function is normalized to 1
%     y=linspace(0,yTF*1.5,10);
% 
%     figure(444);
%     hold on;
%     for yi=1:length(y)
%         %plot(y(yi),integral3(f, -xlim,xlim,-xlim,xlim,-y(yi),y(yi)),'b.');
%         plot(y(yi),integral3(f, -xTF,xTF,-y(yi),y(yi),-y(yi),y(yi)),'b.');
%     end
%     y=linspace(0,yw*5,10);
% 
%     figure(445);
%     hold on;
%     for yi=1:length(y)
%         %plot(y(yi),integral3(f, -xlim,xlim,-xlim,xlim,-y(yi),y(yi)),'b.');
%         plot(y(yi),integral3(ftherm, -20*xw,20*xw,-y(yi),y(yi),-y(yi),y(yi)),'b.');
%     end


    %Average density for distribution from -xlim, xlim, -ylim, ylim,
    %-zlim,zlim

    densityC=zeros(1,numBoxes);
    densityT=densityC;
    %The number density Nc*f(x,y,z), multiplied by the probability density
    %function f(x,y,z), with units um^-6
    g=@(x,y,z) BECanalysisData.Nc*f(x,y,z).^2;
    gtherm=@(x,y,z) BECanalysisData.Nc*scaleRatio*ftherm(x,y,z).^2;

    figure(555); clf;
    hold on;
    %Density will be in units of /cm^3, thus necessitating a conversion
    %factor of (10^4)^3

    %Boxes along lab x-direction
    for i=0:numBoxes-1
        densityC(i+1)=1e12*integral3(g, i*boxsize/2,(i+1)*boxsize/2,-ylim,ylim,-ylim,ylim)/integral3(f, i*boxsize/2,(i+1)*boxsize/2,-ylim,ylim,-ylim,ylim);
        densityT(i+1)=1e12*integral3(gtherm, i*boxsize/2,(i+1)*boxsize/2,-ylim,ylim,-ylim,ylim)/integral3(ftherm, i*boxsize/2,(i+1)*boxsize/2,-ylim,ylim,-ylim,ylim);
    end
    
     %%%%%%%%%%%%%%%%% T over Tc calculation %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %From amplitudes and widths of 1D fit, find the proportional Nc, Nt
    %(not in units of real atom number yet)
    if camera=='z'
        NcTotal=2*8/15*xTF*mean(NaData.analysis.fitBimodalExcludeCenter.xparam(:,1));
        NtTotal = sqrt(pi)*xw*mean(NaData.analysis.fitBimodalExcludeCenter.GaussianWingsX(:,1));
    else 
        NcTotal=2*8/15*zTF*mean(NaData.analysis.fitBimodalExcludeCenter.xparam(:,1));
        NtTotal = sqrt(pi)*zw*mean(NaData.analysis.fitBimodalExcludeCenter.GaussianWingsX(:,1));
    end
    ToverTc=(1-NcTotal./(NcTotal+NtTotal)).^(1/3);

    densityC(isnan(densityC))=0;
    xlabel('Density box number (20 pix/box)');
    ylabel('Density (cm^{-3})');
    title(['Density per box for T/T_{C} = ',num2str(ToverTc),' \mu(kHz) = ',num2str(chemicalPotential/h/1000) ]);
    plot(1:numBoxes, densityC,'.','MarkerSize',20);
    plot(1:numBoxes, densityT,'.','MarkerSize',20);
    plot(1:numBoxes, densityC+densityT,'.','MarkerSize',20);
    ax = gca;
    ax.ColorOrderIndex = 1;
    plot([1,numBoxes],[1e12*BECanalysisData.Nc*f(0,0,0), 1e12*BECanalysisData.Nc*f(0,0,0)],'LineWidth',2)
    plot([1,numBoxes],[1e12*BECanalysisData.Nc*scaleRatio*ftherm(0,0,0), 1e12*BECanalysisData.Nc*scaleRatio*ftherm(0,0,0)],'LineWidth',2)
    legend('Avg. BEC density/box','Avg. Therm density/box','Avg. Total density/box','3D BEC peak density','3D Thermal peak density');
    xticks([1:numBoxes])
    hold off;
    densityPerBox = densityC+densityT;
    Nc=BECanalysisData.Nc;
   

end