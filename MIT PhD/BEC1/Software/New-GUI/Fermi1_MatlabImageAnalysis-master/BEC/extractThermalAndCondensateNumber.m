function [analysis] = extractThermalAndCondensateNumber(Na_run,excludeIdxThermal,excludeIdxBEC,TOFthreshold,varargin)
    %Inputs: Na run structure, index of excluded params, minimum TOF to be
    %analyzed, and camera
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
    
    resCross = 6*pi*(589e-9/2/pi)^2;
    ClebschGordanFactor = 2.4; %from 5/9/18 calibration of F1 imaging
    
    analysis = struct;
    
    mask = true(length(Na_run.parameters),1);
    
    %find nans in data or ci
    nanMask = ~isnan(Na_run.analysis.fitBimodalExcludeCenter.GaussianWingsXci(:,1,2));
    mask=mask.*nanMask;
    nanMask = ~isnan(Na_run.analysis.fitBimodalExcludeCenter.GaussianWingsXci(:,1,1));
    mask=mask.*nanMask;
    nanMask = ~isnan(Na_run.analysis.fitBimodalExcludeCenter.GaussianWingsXci(:,3,2));
    mask=mask.*nanMask;
    nanMask = ~isnan(Na_run.analysis.fitBimodalExcludeCenter.GaussianWingsXci(:,3,1));
    mask=logical(mask.*nanMask);
    nanMask = ~isnan(Na_run.analysis.fitBimodalExcludeCenter.GaussianWingsYci(:,1,2));
    mask=mask.*nanMask;
    nanMask = ~isnan(Na_run.analysis.fitBimodalExcludeCenter.GaussianWingsYci(:,1,1));
    mask=mask.*nanMask;
    nanMask = ~isnan(Na_run.analysis.fitBimodalExcludeCenter.GaussianWingsYci(:,3,2));
    mask=mask.*nanMask;
    nanMask = ~isnan(Na_run.analysis.fitBimodalExcludeCenter.GaussianWingsYci(:,3,1));
    mask=logical(mask.*nanMask);
    
    idx = find(Na_run.parameters<TOFthreshold);
    mask(idx) = false;
    

    GaussAmp = [Na_run.analysis.fitBimodalExcludeCenter.GaussianWingsX(mask,1);Na_run.analysis.fitBimodalExcludeCenter.GaussianWingsY(mask,1)];
    GaussAmpError = [(Na_run.analysis.fitBimodalExcludeCenter.GaussianWingsXci(mask,1,2)-Na_run.analysis.fitBimodalExcludeCenter.GaussianWingsXci(mask,1,1))/2;(Na_run.analysis.fitBimodalExcludeCenter.GaussianWingsYci(mask,1,2)-Na_run.analysis.fitBimodalExcludeCenter.GaussianWingsYci(mask,1,1))/2];
    GaussWidthPx = [Na_run.analysis.fitBimodalExcludeCenter.GaussianWingsX(mask,3);Na_run.analysis.fitBimodalExcludeCenter.GaussianWingsY(mask,3)];
    GaussWidthError = [(Na_run.analysis.fitBimodalExcludeCenter.GaussianWingsXci(mask,3,2)-Na_run.analysis.fitBimodalExcludeCenter.GaussianWingsXci(mask,3,1))/2;(Na_run.analysis.fitBimodalExcludeCenter.GaussianWingsYci(mask,3,2)-Na_run.analysis.fitBimodalExcludeCenter.GaussianWingsYci(mask,3,1))/2];
    
    manualMask = true(length(GaussAmp),1);
    manualMask(excludeIdxThermal) = false;
    GaussAmp = GaussAmp(manualMask);
    GaussAmpError = GaussAmpError(manualMask);
    GaussWidthPx = GaussWidthPx(manualMask);
    GaussWidthError = GaussWidthError(manualMask);
    
    analysis.N_thermal = 2*ClebschGordanFactor*10^(-12)*micronPerPixel^2/resCross*sqrt(pi)*sum(GaussAmp.*1./GaussAmpError.*GaussWidthPx.*1./GaussWidthError)/sum(1./GaussAmpError.*1./GaussWidthError);
    analysis.N_thermalError = 2*std(ClebschGordanFactor*10^(-12)*micronPerPixel^2/resCross*sqrt(pi)*GaussAmp.*GaussWidthPx,1);

    figure(492),clf;
    plot([Na_run.parameters(mask),Na_run.parameters(mask)],ClebschGordanFactor*10^(-12)*micronPerPixel^2/resCross*sqrt(pi)*GaussAmp.*GaussWidthPx,'.','MarkerSize',20);
    
    mask = true(length(Na_run.parameters),1);
    
    %find nans in data or ci
    nanMask = ~isnan(Na_run.analysis.fitBimodalExcludeCenter.xci(:,1,1));
    mask=mask.*nanMask;
    nanMask = ~isnan(Na_run.analysis.fitBimodalExcludeCenter.xci(:,1,2));
    mask=mask.*nanMask;
    nanMask = ~isnan(Na_run.analysis.fitBimodalExcludeCenter.xci(:,2,1));
    mask=mask.*nanMask;
    nanMask = ~isnan(Na_run.analysis.fitBimodalExcludeCenter.xci(:,2,2));
    mask=logical(mask.*nanMask);
    nanMask = ~isnan(Na_run.analysis.fitBimodalExcludeCenter.yci(:,1,1));
    mask=mask.*nanMask;
    nanMask = ~isnan(Na_run.analysis.fitBimodalExcludeCenter.yci(:,1,2));
    mask=mask.*nanMask;
    nanMask = ~isnan(Na_run.analysis.fitBimodalExcludeCenter.yci(:,2,1));
    mask=mask.*nanMask;
    nanMask = ~isnan(Na_run.analysis.fitBimodalExcludeCenter.yci(:,2,2));
    mask=logical(mask.*nanMask);
    
    idx = find(Na_run.parameters<TOFthreshold);
    mask(idx) = false;
    
    BECamp = [Na_run.analysis.fitBimodalExcludeCenter.xparam(mask,1);Na_run.analysis.fitBimodalExcludeCenter.yparam(mask,1)];
    BECampError = [(Na_run.analysis.fitBimodalExcludeCenter.xci(mask,1,2)-Na_run.analysis.fitBimodalExcludeCenter.xci(mask,1,1))/2;(Na_run.analysis.fitBimodalExcludeCenter.yci(mask,1,2)-Na_run.analysis.fitBimodalExcludeCenter.yci(mask,1,1))/2];
    BEC_TFpx = [Na_run.analysis.fitBimodalExcludeCenter.xparam(mask,2);Na_run.analysis.fitBimodalExcludeCenter.yparam(mask,2)];
    BEC_TF_Error = [(Na_run.analysis.fitBimodalExcludeCenter.xci(mask,2,2)-Na_run.analysis.fitBimodalExcludeCenter.xci(mask,2,1))/2;(Na_run.analysis.fitBimodalExcludeCenter.yci(mask,2,2)-Na_run.analysis.fitBimodalExcludeCenter.yci(mask,2,1))/2];
    
    % for debugging:
    BECamp.*BEC_TFpx
    
    manualMask = true(length(BECamp),1);
    manualMask(excludeIdxBEC) = false;
    BECamp = BECamp(manualMask);
    BECampError = BECampError(manualMask);
    BEC_TFpx = BEC_TFpx(manualMask);
    BEC_TF_Error = BEC_TF_Error(manualMask);
    
    
    analysis.N_BEC = ClebschGordanFactor*10^(-12)*micronPerPixel^2/resCross*16/15*sum(BECamp.*1./BECampError.*BEC_TFpx.*1./BEC_TF_Error)/sum(1./BECampError.*1./BEC_TF_Error);
    analysis.N_BEC_Error = std(ClebschGordanFactor*10^(-12)*micronPerPixel^2/resCross*16/15*BECamp.*BEC_TFpx,1);
    
    figure(492)
    hold on
    params = [Na_run.parameters(mask),Na_run.parameters(mask)];
    plot(params(manualMask),ClebschGordanFactor*10^(-12)*micronPerPixel^2/resCross*16/15*BECamp.*BEC_TFpx,'.','MarkerSize',20);
    ax = gca;
    ax.ColorOrderIndex = 1;
    plot([min(Na_run.parameters(mask)),max(Na_run.parameters(mask))],[analysis.N_thermal,analysis.N_thermal],'LineWidth',2);
    plot([min(Na_run.parameters(mask)),max(Na_run.parameters(mask))],[analysis.N_BEC,analysis.N_BEC],'LineWidth',2);
    hold off
    legend('Thermal','BEC','Location','Best');
    ylabel('width*amplitude');
    xlabel('TOF (ms)');
    
    
    funToProp = @(x) (1-x(1)/(x(1)+x(2)))^(1/3);
    A = generateMCparameters('gaussian',[analysis.N_BEC,analysis.N_BEC_Error],'numSamples',10000);
    B = generateMCparameters('gaussian',[analysis.N_thermal,analysis.N_thermalError],'numSamples',10000);
    paramMatrix = [A;B];
    [funValue,funCI,~] = propagateErrorWithMC(funToProp, paramMatrix);
    
    analysis.ToverTcGlobal = funValue;
    analysis.ToverTcGlobalCI = funCI;
    
end