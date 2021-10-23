function [struct_out] = getDualImagingZcamAnalysis(filepath)
    centerOn = 'none'; 
    recenter = true;

    largeMBwidthX = 250;
    largeMBwidthY = 150;%100;

    smallMBwidthX = 180;%120;
    smallMBwidthY = 60;%40;
    
    %smallMBwidthX = 240;%120;
    %smallMBwidthY = 180;%40;

    countingMBlargeX = smallMBwidthX;
    countingMBlargeY = smallMBwidthY;
    
    countingMBsmallX = 20;
    countingMBsmallY = 10;

    BECoffsetX = -592;
    BECoffsetY = -14;

    averageYCenterK  = 167-20;
    averageYCenterNa = 178-40;%20;

    LineDensityPixelAv = 2;
    measNa = Measurement('Na','plotImage','original','NormType','Box','plotOD',false,...
                    'verbose',false,'storeImages',false,'recenterMarqueeBox',false);
    measNa.settings.LineDensityPixelAveraging   = LineDensityPixelAv; 
    
    measNa.settings.largeMBwidthX = largeMBwidthX;
    measNa.settings.largeMBwidthY = largeMBwidthY;
    
    measNa.settings.smallMBwidthX = smallMBwidthX;
    measNa.settings.smallMBwidthY = smallMBwidthY;
    
    measNa.settings.countingMBlargeX = countingMBlargeX;
    measNa.settings.countingMBlargeY = countingMBlargeY;
    
    measNa.settings.countingMBsmallX = countingMBsmallX;
    measNa.settings.countingMBsmallY = countingMBsmallY;

    measK = Measurement('K','plotImage','original','NormType','Box','plotOD',false,...
                    'verbose',false,'storeImages',false,'recenterMarqueeBox',false);
    measK.settings.LineDensityPixelAveraging    = LineDensityPixelAv; 

    defaultNaBox = [50 50 largeMBwidthX largeMBwidthY ];
    defaultKBox = [21-BECoffsetX 93-BECoffsetY largeMBwidthX largeMBwidthY ];
    measNa.settings.marqueeBox  = defaultNaBox;
    %measNa.settings.normBox     = [60   187   227    19];
    measNa.settings.normBox     = [99    63   168     7];
    measK.settings.marqueeBox   = defaultKBox;  
    %measK.settings.normBox      = [722    53    12   160];
    measK.settings.normBox      = [669    82   198     8];
    
    try
        fig = findall(0,'Type','figure','tag','MyUniqueTag'); % Get the handle.
        fig = fig(1);
        fig.Position = [771 1838 567 291];
    catch
        fig = uifigure('Tag','MyUniqueTag'); 
        fig = findall(0,'Type','figure','tag','MyUniqueTag'); % Get the handle.
        fig.Position = [771 1838 567 291];
    end

    measNa.analysis.lineDensityNaMatrix     = [];
    measNa.analysis.ODimageNaStack          = [];
    measNa.analysis.NcntLarge               = [];
    measNa.analysis.NcntSmall               = [];
    
    measK.analysis.lineDensityKMatrix       = [];
    measK.analysis.ODimageKStack            = []; 
    measK.analysis.NcntLarge                = [];
    measK.analysis.NcntSmall                = [];

    ScanParmater = 0;
    trueIdx = 0;

    % load new images for K and Na
    measNa.loadSPEImageFromFileName(ScanParmater,filepath);
    measK.loadSPEImageFromFileName(ScanParmater,filepath);

    if(measNa.lastImageBad || measK.lastImageBad ) % only do analysis if images were good
        if ~measNa.lastImageBad
            measNa.setLastShotBad;
        end
        if ~measK.lastImageBad
            measK.setLastShotBad;
        end
    else
        figure(842);
        set(gcf, 'Position', [773 1111 560 127])
        figure(4);
        set(gcf, 'Position', [1350 1837 560 240])
        
        %fit Na with large box
        trueIdx = trueIdx+1;
        
        if strcmp(centerOn,'Na')
            % set Na small MB and refit small box
            extraPixel = 5;
            centerImage = measNa.images.ODImages(1,measNa.settings.marqueeBox(4)/2-extraPixel:measNa.settings.marqueeBox(4)/2+extraPixel,measNa.settings.marqueeBox(3)/2-extraPixel:measNa.settings.marqueeBox(3)/2+extraPixel);
            lowODThreshold = mean(centerImage(:));
            measNa.fitIntegratedAsymGaussian( 'last','LowODthreshold',lowODThreshold/3);

            centerX_Na = round(measNa.analysis.fitIntegratedAsymGaussX.peak+measNa.settings.marqueeBox(1));
            centerY_Na = round(measNa.analysis.fitIntegratedAsymGaussY.peak+measNa.settings.marqueeBox(2));

            centerX_K = centerX_Na-BECoffsetX;
            centerY_K = centerY_Na-BECoffsetY;
        elseif strcmp(centerOn,'K')
            extraPixel = 5;
            centerImage = measK.images.ODImages(1,measK.settings.marqueeBox(4)/2-extraPixel:measK.settings.marqueeBox(4)/2+extraPixel,measK.settings.marqueeBox(3)/2-extraPixel:measK.settings.marqueeBox(3)/2+extraPixel);
            lowODThreshold = mean(centerImage(:));
            measK.fitIntegratedAsymGaussian( 'last','LowODthreshold',lowODThreshold/3);

            centerX_K = round(measK.analysis.fitIntegratedAsymGaussX.peak+measK.settings.marqueeBox(1));
            centerY_K = round(measK.analysis.fitIntegratedAsymGaussY.peak+measK.settings.marqueeBox(2));

            centerX_Na = centerX_K+BECoffsetX;
            centerY_Na = centerY_K+BECoffsetY;
        else
            centerX_K = 753;
            centerY_K = 121;

            centerX_Na = 144;
            centerY_Na = 102;
        end
        
        %make Na MB centered and analyze
        if recenter
            measNa.settings.marqueeBox=[min(max(centerX_Na-smallMBwidthX/2,1),1024-smallMBwidthX) ...
                min(max(centerY_Na-smallMBwidthY/2,1),333-smallMBwidthY) ...
                smallMBwidthX smallMBwidthY ];
        else
            measNa.settings.marqueeBox=defaultNaBox;
        end
        
        measNa.flushAllODImages();
        measNa.createODimage('last');
        measNa.createLineDensities();
        %measNa.fitBimodalExcludeCenter('last','BlackedOutODthreshold',0.12,'TFcut',0.8,'useLineDensity',true);
        measNa.fitBimodalExcludeCenter('last','BlackedOutODthreshold',4,'TFcut',0.8,'useLineDensity',true);
        set(gcf, 'Position', [774 1327 560 420])
        measNa.fitIntegratedGaussian('last','useLineDensity',true);

        %make K MB centered and analyze
        if recenter
            measK.settings.marqueeBox=[min(max(centerX_K-smallMBwidthX/2,1),1024-smallMBwidthX) ...
                min(max(centerY_K-smallMBwidthY/2,1),333-smallMBwidthY) ...
                smallMBwidthX smallMBwidthY ];
        else
            measK.settings.marqueeBox=defaultKBox;
        end
        
        
        measK.flushAllODImages();
        measK.createODimage('last');
        measK.createLineDensities();
        measK.fitIntegratedGaussian('last','useLineDensity',true);

        % Do counting
        % Na large box
        measNa.settings.marqueeBox=[min(max(centerX_Na-countingMBlargeX/2,1),1024-countingMBlargeX) ...
            min(max(centerY_Na-countingMBlargeY/2,1),333-countingMBlargeY) ...
            countingMBlargeX countingMBlargeY ];
        measNa.flushAllODImages();
        measNa.createODimage('last');
        measNa.plotODImage('last');
        measNa.bareNcntAverageMarqueeBox;
        measNa.analysis.NcntLarge(end+1) = measNa.analysis.bareNcntAverageMarqueeBoxValues(end);
        % Na small box
        measNa.settings.marqueeBox=[min(max(centerX_Na-countingMBsmallX/2,1),1024-countingMBsmallX) ...
            min(max(centerY_Na-countingMBsmallY/2,1),333-countingMBsmallY) ...
            countingMBsmallX countingMBsmallY ];
        measNa.flushAllODImages();
        measNa.createODimage('last');
        measNa.plotODImage('last');
        measNa.bareNcntAverageMarqueeBox;
        measNa.analysis.NcntSmall(end+1) = measNa.analysis.bareNcntAverageMarqueeBoxValues(end);
        % K small box
        measK.settings.marqueeBox=[min(max(centerX_K-countingMBsmallX/2,1),1024-countingMBsmallX) ...
            min(max(centerY_K-countingMBsmallY/2,1),333-countingMBsmallY) ...
            countingMBsmallX countingMBsmallY ];
        measK.flushAllODImages();
        measK.createODimage('last');
        measK.plotODImage('last');
        measK.bareNcntAverageMarqueeBox;
        measK.analysis.NcntSmall(end+1) = measK.analysis.bareNcntAverageMarqueeBoxValues(end);
        % K large box
        measK.settings.marqueeBox=[min(max(centerX_K-countingMBlargeX/2,1),1024-countingMBlargeX) ...
            min(max(centerY_K-countingMBlargeY/2,1),333-countingMBlargeY) ...
            countingMBlargeX countingMBlargeY ];
        measK.flushAllODImages();
        measK.createODimage('last');
        measK.plotODImage('last');
        set(gcf, 'Position', [1350 1328 560 420])
        measK.bareNcntAverageMarqueeBox;
        measK.analysis.NcntLarge(end+1) = measK.analysis.bareNcntAverageMarqueeBoxValues(end);
        
        measNa.analysis.NcntSmall = abs(measNa.analysis.NcntSmall);
        
        %all TF radii are computed IN PIXEL
        x_TF = measNa.analysis.fitBimodalExcludeCenter.xparam(2) ;
        y_TF = measNa.analysis.fitBimodalExcludeCenter.yparam(2) ;
        ParameterName = {'K Ncnt (small box)',...
                         'Na Ncnt (small box)',...
                         'K Ncnt (full box)' ,...
                         'Na Ncnt (full box)' ,...
                         'TF_x (insitu)',...
                         'TF_y (insitu)',...
                         }; 
        Values = [round(measK.analysis.NcntSmall,3,'significant'),...
                  (round(measNa.analysis.NcntSmall,3,'significant')),...
                  round(measK.analysis.NcntLarge,3,'significant'),...
                  round(measNa.analysis.NcntLarge,3,'significant'),...
                  round(x_TF,3,'significant'),...
                  round(y_TF,3,'significant')]; 
        Units = {'cnts','cnts','cnts','cnts','px','px' }; 
        VariableNames = {'Parameter','Value','Unit'};
        T = table(ParameterName',Values',Units','VariableNames',VariableNames); 

        
        uit = uitable(fig,'Data',T);
        uit.FontSize = 30;
        uit.Position = [1 1 567 291];
        
        figure(619),clf;
        set(gcf, 'Position',[872 1144 912 929])
        plotSummaryImage(measNa,measK)
        
    end
    
    measK.analysis.KGaussianWidthX = measK.analysis.fitIntegratedGaussX.param(end,4);
    measK.analysis.KGaussianWidthY = measK.analysis.fitIntegratedGaussY.param(end,4);
    
    measK.analysis.squared_KGaussianWidthX = measK.analysis.fitIntegratedGaussX.param(end,4).^2;
    measK.analysis.squared_KGaussianWidthY = measK.analysis.fitIntegratedGaussY.param(end,4).^2;
    measK.analysis.squared_widthRatioYoverX = measK.analysis.squared_KGaussianWidthY./measK.analysis.squared_KGaussianWidthX;
    
    measK.analysis.KcountsPerArea = measK.analysis.NcntLarge./(measK.analysis.squared_KGaussianWidthX*measK.analysis.squared_KGaussianWidthY).^(3/2);
    measNa.analysis.TFy = measNa.analysis.fitBimodalExcludeCenter.yparam(end,2);
    measNa.analysis.TFx = measNa.analysis.fitBimodalExcludeCenter.xparam(end,2);
    
    struct_out.K_analysis = measK.analysis; 
    struct_out.K_settings = measK.settings; 
    struct_out.Na_analysis = measNa.analysis; 
    struct_out.Na_settings = measNa.settings; 
    

end


