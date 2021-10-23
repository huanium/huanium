function [struct_out] = getTripleImagingZcamAnalysis_2021(filepathNa,filepathK2,filepathK1)
    centerOn = 'Na'; 
    recenter = true;
    ScanParmater = 0;

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
    averageYCenterNa = 178-20;

    measNa = Measurement('Na','imageStartKeyword','K1','sortFilesBy','name',...
                    'plotImage','original','NormType','Box','plotOD',false,...
                    'verbose',false,'storeImages',false,'recenterMarqueeBox',false);
    
    measNa.settings.largeMBwidthX = largeMBwidthX;
    measNa.settings.largeMBwidthY = largeMBwidthY;
    
    measNa.settings.smallMBwidthX = smallMBwidthX;
    measNa.settings.smallMBwidthY = smallMBwidthY;
    
    measNa.settings.countingMBlargeX = countingMBlargeX;
    measNa.settings.countingMBlargeY = countingMBlargeY;
    
    measNa.settings.countingMBsmallX = countingMBsmallX;
    measNa.settings.countingMBsmallY = countingMBsmallY;            
                
    measK1 = Measurement('K','imageStartKeyword','K1','sortFilesBy','name',...
                    'plotImage','original','NormType','Box','plotOD',false,...
                    'verbose',false,'storeImages',false,'recenterMarqueeBox',false);


    measK2 = Measurement('K','imageStartKeyword','K2','sortFilesBy','name',...
                    'plotImage','original','NormType','Box','plotOD',false,...
                    'verbose',false,'storeImages',false,'recenterMarqueeBox',false);

    defaultNaBox = [21 93 largeMBwidthX largeMBwidthY ];

    defaultNaBox = [50 50 largeMBwidthX largeMBwidthY ];
    defaultKBox = [21-BECoffsetX 70-BECoffsetY largeMBwidthX largeMBwidthY/2 ];
    measNa.settings.marqueeBox  = defaultNaBox;
    measNa.settings.normBox     = [99    63   168     7];
    measK1.settings.marqueeBox   = defaultKBox;
    measK1.settings.normBox      = [669    82   198     8];
    measK2.settings.marqueeBox   = defaultKBox;
    measK2.settings.normBox      = [669    82   198     8];

    try
        fig = findall(0,'Type','figure','tag','MyUniqueTag'); % Get the handle.
        fig = fig(1);
        fig.Position = [771 1838 567 291];
    catch
        fig = uifigure('Tag','MyUniqueTag');
        fig = findall(0,'Type','figure','tag','MyUniqueTag'); % Get the handle.
        fig.Position = [771 1838 567 291];
    end


    TOF = 0.0;

    im = [];

    measNa.analysis.lineDensityNaMatrix     = [];
    measNa.analysis.ODimageNaStack          = [];
    measNa.analysis.NcntLarge               = [];
    measNa.analysis.NcntSmall               = [];

    measK1.analysis.lineDensityKMatrix       = [];
    measK1.analysis.ODimageKStack            = [];
    measK1.analysis.NcntLarge                = [];
    measK1.analysis.NcntSmall                = [];

    measK2.analysis.lineDensityKMatrix       = [];
    measK2.analysis.ODimageKStack            = []; 
    measK2.analysis.NcntLarge                = [];
    measK2.analysis.NcntSmall                = [];

    tic
    trueIdx = 0;
    % load new images for K and Na
    measNa.loadSPEImageFromFileName(ScanParmater,filepathK1);
    measK1.loadSPEImageFromFileName(ScanParmater,filepathK1);
    measK2.loadSPEImageFromFileName(ScanParmater,filepathK2);
    if(measNa.lastImageBad || measK1.lastImageBad || measK2.lastImageBad ) % only do analysis if images were good
        if ~measNa.lastImageBad
            measNa.setLastShotBad;
        end
        if ~measK1.lastImageBad
            measK1.setLastShotBad;
        end
        if ~measK2.lastImageBad
            measK2.setLastShotBad;
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
        elseif strcmp(centerOn,'K2')
            extraPixel = 5;
            centerImage = measK2.images.ODImages(1,measK2.settings.marqueeBox(4)/2-extraPixel:measK2.settings.marqueeBox(4)/2+extraPixel,measK2.settings.marqueeBox(3)/2-extraPixel:measK2.settings.marqueeBox(3)/2+extraPixel);
            lowODThreshold = mean(centerImage(:));
            measK2.fitIntegratedAsymGaussian( 'last','LowODthreshold',lowODThreshold/3);

            centerX_K = round(measK2.analysis.fitIntegratedAsymGaussX.peak+measK2.settings.marqueeBox(1));
            centerY_K = round(measK2.analysis.fitIntegratedAsymGaussY.peak+measK2.settings.marqueeBox(2));

            centerX_Na = centerX_K+BECoffsetX;
            centerY_Na = centerY_K+BECoffsetY;
        elseif strcmp(centerOn,'K1')
            extraPixel = 5;
            centerImage = measK1.images.ODImages(1,measK1.settings.marqueeBox(4)/2-extraPixel:measK1.settings.marqueeBox(4)/2+extraPixel,measK1.settings.marqueeBox(3)/2-extraPixel:measK1.settings.marqueeBox(3)/2+extraPixel);
            lowODThreshold = mean(centerImage(:));
            measK1.fitIntegratedAsymGaussian( 'last','LowODthreshold',lowODThreshold/3);

            centerX_K = round(measK1.analysis.fitIntegratedAsymGaussX.peak+measK1.settings.marqueeBox(1));
            centerY_K = round(measK1.analysis.fitIntegratedAsymGaussY.peak+measK1.settings.marqueeBox(2));

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
            measK2.settings.marqueeBox=[min(max(centerX_K-smallMBwidthX/2,1),1024-smallMBwidthX) ...
                min(max(centerY_K-smallMBwidthY/2,1),333-smallMBwidthY) ...
                smallMBwidthX smallMBwidthY ];
            measK1.settings.marqueeBox=[min(max(centerX_K-smallMBwidthX/2,1),1024-smallMBwidthX) ...
                min(max(centerY_K-smallMBwidthY/2,1),333-smallMBwidthY) ...
                smallMBwidthX smallMBwidthY ];
        else
            measK2.settings.marqueeBox=defaultKBox;
            measK1.settings.marqueeBox=defaultKBox;
        end


        measK1.flushAllODImages();
        measK1.createODimage('last');
        measK1.createLineDensities();
        measK1.fitIntegratedGaussian('last','useLineDensity',true);
        
        
        measK2.flushAllODImages();
        measK2.createODimage('last');
        measK2.createLineDensities();
        measK2.fitIntegratedGaussian('last','useLineDensity',true);

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
        % K1 small box
        measK1.settings.marqueeBox=[min(max(centerX_K-countingMBsmallX/2,1),1024-countingMBsmallX) ...
            min(max(centerY_K-countingMBsmallY/2,1),333-countingMBsmallY) ...
            countingMBsmallX countingMBsmallY ];
        measK1.flushAllODImages();
        measK1.createODimage('last');
        measK1.plotODImage('last');
        measK1.bareNcntAverageMarqueeBox;
        measK1.analysis.NcntSmall(end+1) = measK1.analysis.bareNcntAverageMarqueeBoxValues(end);
        % K1 large box
        measK1.settings.marqueeBox=[min(max(centerX_K-countingMBlargeX/2,1),1024-countingMBlargeX) ...
            min(max(centerY_K-countingMBlargeY/2,1),333-countingMBlargeY) ...
            countingMBlargeX countingMBlargeY ];
        measK1.flushAllODImages();
        measK1.createODimage('last');
        measK1.plotODImage('last');
        set(gcf, 'Position', [1350 1328 560 420])
        measK1.bareNcntAverageMarqueeBox;
        measK1.analysis.NcntLarge(end+1) = measK1.analysis.bareNcntAverageMarqueeBoxValues(end);
        
        
        % K2 small box
        measK2.settings.marqueeBox=[min(max(centerX_K-countingMBsmallX/2,1),1024-countingMBsmallX) ...
            min(max(centerY_K-countingMBsmallY/2,1),333-countingMBsmallY) ...
            countingMBsmallX countingMBsmallY ];
        measK2.flushAllODImages();
        measK2.createODimage('last');
        measK2.plotODImage('last');
        measK2.bareNcntAverageMarqueeBox;
        measK2.analysis.NcntSmall(end+1) = measK2.analysis.bareNcntAverageMarqueeBoxValues(end);
        % K2 large box
        measK2.settings.marqueeBox=[min(max(centerX_K-countingMBlargeX/2,1),1024-countingMBlargeX) ...
            min(max(centerY_K-countingMBlargeY/2,1),333-countingMBlargeY) ...
            countingMBlargeX countingMBlargeY ];
        measK2.flushAllODImages();
        measK2.createODimage('last');
        measK2.plotODImage('last');
        set(gcf, 'Position', [1350 1328 560 420])
        measK2.bareNcntAverageMarqueeBox;
        measK2.analysis.NcntLarge(end+1) = measK2.analysis.bareNcntAverageMarqueeBoxValues(end);
        

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
        Values = [round(measK1.analysis.NcntSmall,3,'significant'),...
            (round(measNa.analysis.NcntSmall,3,'significant')),...
            round(measK1.analysis.NcntLarge,3,'significant'),...
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
        plotSummaryImage_tripple(measNa,measK1,measK2)

    end

    measK1.analysis.KGaussianWidthX = measK1.analysis.fitIntegratedGaussX.param(end,4);
    measK1.analysis.KGaussianWidthY = measK1.analysis.fitIntegratedGaussY.param(end,4);

    measK1.analysis.squared_KGaussianWidthX = measK1.analysis.fitIntegratedGaussX.param(end,4).^2;
    measK1.analysis.squared_KGaussianWidthY = measK1.analysis.fitIntegratedGaussY.param(end,4).^2;
    measK1.analysis.squared_widthRatioYoverX = measK1.analysis.squared_KGaussianWidthY./measK1.analysis.squared_KGaussianWidthX;

    measK1.analysis.KcountsPerArea = measK1.analysis.NcntLarge./(measK1.analysis.squared_KGaussianWidthX*measK1.analysis.squared_KGaussianWidthY).^(3/2);
    
    
    measK2.analysis.KGaussianWidthX = measK2.analysis.fitIntegratedGaussX.param(end,4);
    measK2.analysis.KGaussianWidthY = measK2.analysis.fitIntegratedGaussY.param(end,4);

    measK2.analysis.squared_KGaussianWidthX = measK2.analysis.fitIntegratedGaussX.param(end,4).^2;
    measK2.analysis.squared_KGaussianWidthY = measK2.analysis.fitIntegratedGaussY.param(end,4).^2;
    measK2.analysis.squared_widthRatioYoverX = measK2.analysis.squared_KGaussianWidthY./measK2.analysis.squared_KGaussianWidthX;

    measK2.analysis.KcountsPerArea = measK2.analysis.NcntLarge./(measK2.analysis.squared_KGaussianWidthX*measK2.analysis.squared_KGaussianWidthY).^(3/2);
    
    
    measNa.analysis.TFy = measNa.analysis.fitBimodalExcludeCenter.yparam(end,2);
    measNa.analysis.TFx = measNa.analysis.fitBimodalExcludeCenter.xparam(end,2);

    measK1.analysis.transferSmall = measK1.analysis.NcntSmall/(measK1.analysis.NcntSmall+measK2.analysis.NcntSmall);
    measK1.analysis.transferLarge = measK1.analysis.NcntLarge/(measK1.analysis.NcntLarge+measK2.analysis.NcntLarge);
    
    measK2.analysis.transferSmall = measK2.analysis.NcntSmall/(measK1.analysis.NcntSmall+measK2.analysis.NcntSmall);
    measK2.analysis.transferLarge = measK2.analysis.NcntLarge/(measK1.analysis.NcntLarge+measK2.analysis.NcntLarge);

    struct_out.K1_analysis = measK1.analysis; 
    struct_out.K1_settings = measK1.settings;
    struct_out.K2_analysis = measK2.analysis; 
    struct_out.K2_settings = measK2.settings; 
    struct_out.Na_analysis = measNa.analysis; 
    struct_out.Na_settings = measNa.settings; 

end