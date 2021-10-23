function [densityT] = thermal3DdensityRunAnalysis(FermionSigma, NaData,numBoxes,boxWidth,camera)

%Inputs-----------------------------------------
%NaData must have the field "xwidths" and "ywidths" which are gaussian
%widths defined by exp(-x/xw^2). Needs the fields .analysis.fitIntegratedGaussX.param(:,4)
%FermionSigma is the pixel extent of the analysis region

%Select camera = 'z' or 'y' to get the correct coordinates
%Outputs----------------------------------------
%densityT is the total Na (thermal) density, 3D, in cm^-3


    %Calculate average density per marquee box
    %Use <n3D> = Integral over volume (n3D*f3D)=N* Integral over volume(f3D*f3D)
    %where n3D is the density (number N per vol) and
    %f3D is the distribution function ==n3D/N
% Choose camera    
    if camera=='z'
        micronPerPixel=2.5; %camera magnification
    elseif camera=='y'
        micronPerPixel=2.48;
    else
        fprintf('Warning: please choose "z" or "y" camera');
        return
    end
    %%%%%%%%%%%% Na properties from fitting %%%%%%%%%%%%%%%%%%%%%%%%

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
    ylim=2*FermionSigma*micronPerPixel; %radius in micron
    
    %%%%%%%%%%%%%% Na Properties %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Needs the fitBimodal properies
    BECanalysisData=struct;
    BECanalysisData.trapFreqZ=47; BECanalysisData.trapFreqY=41; %Trap freq in Hz
    BECanalysisData.trapFreqX=12.6;
    omegabar=2*pi*(BECanalysisData.trapFreqX*BECanalysisData.trapFreqY*BECanalysisData.trapFreqZ)^(1/3);

    
    %Cloud sizes 
    if camera == 'z' %(using the best SNR fits from the x width)
       
        %Thermal gaussian portion-from x fits, and scaling to y and z widths
        %xw, yw, zw defined as exp(-x^2/xw^2), without the normal factor of 2

        xw=micronPerPixel*mean(NaData.analysis.fitIntegratedGaussX.param(:,4));
        
        yw=micronPerPixel*mean(NaData.analysis.fitIntegratedGaussY.param(:,4));
        zw=sqrt(yw*xw*BECanalysisData.trapFreqX*BECanalysisData.trapFreqY)/BECanalysisData.trapFreqZ;

    else
        %Y-cam ,(using the best SNR fits from the lab z= camera x width, and lab x=camera y width)
        
        %Thermal gaussian portion-from x fits, and scaling to y and z widths
        %xw, yw, zw defined as exp(-x^2/xw^2), without the normal factor of 2

        zw=micronPerPixel*mean(NaData.analysis.fitIntegratedGaussX.param(:,4));
        xw=micronPerPixel*mean(NaData.analysis.fitIntegratedGaussY.param(:,4));
        yw=sqrt(xw*zw*BECanalysisData.trapFreqX*BECanalysisData.trapFreqZ)/BECanalysisData.trapFreqY;

   
    end
    %%%%%%%%%%%%%%%%% End of Na properties %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %%%%%%%%%%%%%%%%% Begin profile analysis %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %thermal density distribution function, norm to 1
    ftherm=@(x,y,z) 1/(xw*yw*zw*pi^1.5)*exp(-x.^2/xw^2-y.^2/yw^2-z.^2/zw^2);
    
    
    %Check to make sure function is normalized to 1
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

    densityT=zeros(1,numBoxes);
    gtherm=@(x,y,z) ftherm(x,y,z).^2;

    figure(555); clf;
    hold on;
    %Density will be in units of /cm^3

    %Boxes along lab x-direction
    for i=0:numBoxes-1
        densityT(i+1)=integral3(gtherm, i*boxsize/2,(i+1)*boxsize/2,-ylim,ylim,-ylim,ylim)/integral3(ftherm, i*boxsize/2,(i+1)*boxsize/2,-ylim,ylim,-ylim,ylim);
    end

    xlabel('Density box number (20 pix/box)');
    ylabel('Density (cm^{-3})');
    title('Density per box for typical BEC parameters');
    plot(1:numBoxes, densityT,'g.','MarkerSize',20);
    plot([1,numBoxes],[ftherm(0,0,0), ftherm(0,0,0)])
    legend('Thermal density','nt3Dpeak');

    hold off;
end