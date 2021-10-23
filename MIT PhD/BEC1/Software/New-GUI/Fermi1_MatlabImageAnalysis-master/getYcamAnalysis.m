function [struct_out] = getYcamAnalysis(filepath,varargin)
    isFluoImage = true;

    p = inputParser;
    p.addParameter('marqueeBox',NaN);
    p.addParameter('normBox',NaN);
    p.addParameter('ToF',15);
    p.parse(varargin{:});
    marqueeBox  = p.Results.marqueeBox;
    normBox     = p.Results.normBox;
    ToF         = p.Results.ToF;

    Omegas = 2*pi*[103,12.6,94]; %see breathing oscillations 2020 paper
    omega_bar = geomean(Omegas);
    ScanParmater = 0;


    meas = Measurement('Na','imageStartKeyword','dual','sortFilesBy','name',...
                    'plotImage','original','NormType','Box','plotOD',false,...
                    'verbose',false,'storeImages',false,'recenterMarqueeBox',false);
    meas.settings.avIntPerPixelThreshold    = 0.1;
    meas.settings.LineDensityPixelAveraging = 1; 
    if ~isnan(marqueeBox)
        meas.settings.marqueeBox    = marqueeBox; 
    else
        meas.settings.marqueeBox    = [1,1,1000,1000];
    end
    if ~isnan(normBox)
        meas.settings.normBox       = normBox; 
    else
       fig = uifigure('Tag','MyUniqueTag'); 
    end
    fig = findall(0,'Type','figure','tag','MyUniqueTag'); % Get the handle.
    %fig = fig(1);
    try
        fig.Position = [ 1300        1100         600         700];
    catch
        fig = uifigure('Tag','MyUniqueTag'); 
        fig = findall(0,'Type','figure','tag','MyUniqueTag'); % Get the handle.
        fig.Position = [ 1300        1100         600         700];
    end
    meas.loadSPEImageFromFileName(ScanParmater,filepath,'fluoImage',isFluoImage);
    
    
    if(~meas.lastImageBad)
        meas.fitBimodalExcludeCenter('last','BlackedOutODthreshold',4,'useLineDensity',true);
        set(gcf, 'Position', [725 1340 560 420])
        meas.fitIntegratedGaussian('last','useLineDensity',true);
        figure(842);
        set(gcf, 'Position', [773 1850 560 280])
        figure(4);
        set(gcf, 'Position', [1349 1850 560 280])

        
        a_BB = 52 * aBohr; %should replace with exact value for F=2 Na 
        %horizontal, vertical camera axes correspond to Fermi1 paper convention z, x respectively
        %use x,y to denote horizontal, vertical CAMERA axes

        %all TF radii are computed IN PIXEL
        x_TF_afterToF = meas.analysis.fitBimodalExcludeCenter.xparam(2) * meas.settings.LineDensityPixelAveraging;
        y_TF_afterToF = meas.analysis.fitBimodalExcludeCenter.yparam(2) * meas.settings.LineDensityPixelAveraging;

        %reverse hydrodynamic evolution to get in situ TF radi
        times = 0:0.00001:ToF/1000;
        scalingX = HydroBECTOF(times,Omegas,'Axis','X');
        scalingY = HydroBECTOF(times,Omegas,'Axis','Y');
        x_TFinsitu = x_TF_afterToF/scalingX(end);
        y_TFinsitu = y_TF_afterToF/scalingY(end);

        %chemical potential
        m_per_pixel = 2.45e-6; %last calibrated Feb 2020
        chem_potential_x = 0.5 * mNa * (Omegas(1))^2 * (x_TFinsitu * m_per_pixel)^2 / PlanckConst; %in kHz
        chem_potential_y = 0.5 * mNa * (Omegas(2))^2 * (y_TFinsitu * m_per_pixel)^2 / PlanckConst; %in kHz
        chem_potential_kHz = sqrt(chem_potential_x * chem_potential_y)/1e3; %use the geometric mean
        N_condensate =  (PlanckConst * chem_potential_kHz * 1e3 *2)^(5/2) /(15 * (PlanckConst/2/pi)^2 * mNa^.5 * omega_bar^3 * a_BB);
        %condensed atom number from pp 35, Ketterle Varenna notes

        %append calculations to analysis and output structs
        meas.analysis.meanGaussianRadius  = sqrt(meas.analysis.fitIntegratedGaussY.param(1,4) * meas.analysis.fitIntegratedGaussX.param(1,4)); %in pixel
        meas.analysis.meanFWHM            = sqrt(meas.analysis.widthX.FWHM*meas.analysis.widthY.FWHM);
        
        meas.analysis.xTFinsitu_pix = x_TFinsitu;
        meas.analysis.yTFinsitu_pix = y_TFinsitu;
        meas.analysis.chem_potential_kHz = chem_potential_kHz;
        meas.analysis.N_condensate = N_condensate;
        
        
        ParameterName = {'bare N count','Gaussian radius X' ,'Gaussian radius Y','FWHM X','FWHM Y', 'TF_x (TOF)','TF_y (TOF)', ...
                        'TF_x (insitu)','TF_y (insitu)','chemical potential','N condensate' }; 
        Values = [round(meas.analysis.bareNcntAverageMarqueeBoxValues,3,'significant'),...
                  round(meas.analysis.fitIntegratedGaussX.param(1,4),3,'significant'),...  
                  round(meas.analysis.fitIntegratedGaussY.param(1,4),3,'significant'),...  
                  round(meas.analysis.widthX.FWHM,3,'significant'),...
                  round(meas.analysis.widthY.FWHM,3,'significant'),...
                  round(x_TF_afterToF,3,'significant'),...
                  round(y_TF_afterToF,3,'significant'),...
                  round(x_TFinsitu,3,'significant'),...
                  round(y_TFinsitu,3,'significant'),...
                  round(chem_potential_kHz,3,'significant'),...
                  round(N_condensate,3,'significant')]; 
        Units = {'cnts','px','px','px','px','px','px','um','um','kHz',' '  }; 
        VariableNames = {'Parameter','Value','Unit'};
        T = table(ParameterName',Values',Units','VariableNames',VariableNames); 

        
        uit = uitable(fig,'Data',T);
        uit.FontSize = 45;
        uit.Position = [1 1 600 700];
        %round(var,digit,'significant')
        
    end
    struct_out.analysis = meas.analysis;
    struct_out.settings = meas.settings;
    struct_out.analysis.xTF_afterToF = x_TF_afterToF;
    struct_out.analysis.yTF_afterToF = y_TF_afterToF;
end
