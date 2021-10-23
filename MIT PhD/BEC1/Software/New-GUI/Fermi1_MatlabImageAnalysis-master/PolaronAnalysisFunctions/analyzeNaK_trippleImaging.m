function [Na_analysis,K1_analysis,K2_analysis] = analyzeNaK_trippleImaging(ScanList,varargin)
    tic
    p = inputParser;
    p.addParameter('BlackedOutODthreshold',0.9);
    p.addParameter('useLineDensity',true);
    p.addParameter('BoxSize','default');
    p.addParameter('diffToDark',40.00);
    p.addParameter('LineDensityPixelAv',2);
    p.addParameter('TFcut',1);
    p.parse(varargin{:});
    BlackedOutODthreshold   = p.Results.BlackedOutODthreshold;
    BoxSize                 = p.Results.BoxSize;
    diffToDark              = p.Results.diffToDark;
    useLineDensity          = p.Results.useLineDensity;
    LineDensityPixelAv      = p.Results.LineDensityPixelAv;
    TFcut                   = p.Results.TFcut;

    countingMBlargeX = 180;
    countingMBlargeY = 30;

    countingMBsmallX = 20;
    countingMBsmallY = 10;

    BECoffsetX = -592;
    BECoffsetY = -14;
    
    params = ScanList.RFK2;
    
    if strcmp(BoxSize,'default')
        warning('Marquee box to be selected by hand! Choose BoxSize small or large for greater accuracy in COM or TF fitting. \n');
        marqueeX0=[];
    elseif strcmp(BoxSize,'large')
        fprintf(' ');
        marqueeX0 = 1;
        marqueeY0 = 93;
        marqueeXwidth = 360;
        marqueeYwidth = 22;   
        %marqueeYwidth = 100;   

    else
        error(['Choose marquee box size to be: default for hand-drawn marquee, small for better COM position, or large for better TF fitting']);
    end
    
    
    % check if enough images
    imageStartKeyword = 'Na';
    files= dir([ '*spe']);
    
    if(length(files)<length(params))
        warning(['Error: there are less images (' num2str(length(files)) ') than parameters (' num2str(length(params)) ')'])
    elseif(length(files)>length(params))
        warning(['Warning: there are more images (' num2str(length(files)) ') than parameters (' num2str(length(params)) ') press any key to continue'])
    end


    measNa = Measurement('Na','imageStartKeyword',imageStartKeyword,'sortFilesBy','name','plotImage','original','NormOff' ,false,'NormType','Box','plotOD',false,'verbose',false,'storeImages',false,'recenterMarqueeBox',false);
    
    measNa.settings.diffToDarkThreshold       = diffToDark;
    measNa.settings.GaussianFilterWidth = 2;
    measNa.settings.AbbeRadius = 0.75;
    measNa.analysis.analysisDurations = [];
    measNa.analysis.fittedGaussianAbsolutePositionX = [];
    measNa.analysis.fittedGaussianAbsolutePositionY = [];
    measNa.settings.LineDensityPixelAveraging = LineDensityPixelAv; 
    
    
    measK1 = Measurement('K','imageStartKeyword','K1','sortFilesBy','name',...
                    'plotImage','original','NormType','Box','plotOD',false,...
                    'verbose',false,'storeImages',false,'recenterMarqueeBox',false);


    measK2 = Measurement('K','imageStartKeyword','K2','sortFilesBy','name',...
                    'plotImage','original','NormType','Box','plotOD',false,...
                    'verbose',false,'storeImages',false,'recenterMarqueeBox',false);
    
             
    lastRunTime = toc;
    if ~isempty(marqueeX0)
        measNa.settings.marqueeBox=[marqueeX0 marqueeY0 marqueeXwidth marqueeYwidth ];
       
    end
    defaultBox = measNa.settings.marqueeBox;
    defaultKBox = [measNa.settings.marqueeBox(1)-BECoffsetX measNa.settings.marqueeBox(2)-BECoffsetY measNa.settings.marqueeBox(3) measNa.settings.marqueeBox(4) ];
    
    measNa.settings.marqueeBox     = defaultBox;
    measK1.settings.marqueeBox      = defaultKBox;
    measK2.settings.marqueeBox      = defaultKBox;

    
    measNa.settings.normBox     = [72   173   214    12];
    measK1.settings.normBox      = [669    82   198     8];
    measK2.settings.normBox      = [669    82   198     8];

    
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
    
    for idx = 1:length(params)
        
        measNa.loadSPEImageFromFileName(params(idx),[num2str(ScanList.run_id(idx)), '_2.spe']);
        measK1.loadSPEImageFromFileName(params(idx),[num2str(ScanList.run_id(idx)), '_2.spe']);
        measK2.loadSPEImageFromFileName(params(idx),[num2str(ScanList.run_id(idx)), '_1.spe']);
        
        measNa.settings.marqueeBox = defaultBox;
        measNa.flushAllODImages();
        measNa.createODimage('last');
        
        if(~measNa.lastImageBad && sum(sum(isnan(measNa.images.ODImages(end,:,:))))<defaultBox(3)*defaultBox(4)/2)
            
            
            try
                measNa.fitBimodalExcludeCenter('last','BlackedOutODthreshold',BlackedOutODthreshold,'BlackedOutODthresholdX',BlackedOutODthreshold,'useLineDensity',useLineDensity,'savePlottingInfo',false,'TFcut',TFcut);
            catch
                display('problems');
            end
            measNa.flushAllODImages();
            measNa.createODimage('last');
            extraPixel = 5;
            centerImage = measNa.images.ODImages(1,measNa.settings.marqueeBox(4)/2-extraPixel:measNa.settings.marqueeBox(4)/2+extraPixel,measNa.settings.marqueeBox(3)/2-extraPixel:measNa.settings.marqueeBox(3)/2+extraPixel);
            lowODThreshold = mean(centerImage(:));
            measNa.fitIntegratedAsymGaussian( 'last','LowODthreshold',lowODThreshold/2);
            measNa.analysis.fittedGaussianAbsolutePositionX(end+1) = measNa.analysis.fitIntegratedAsymGaussX.peak+measNa.settings.marqueeBox(1);
            measNa.analysis.fittedGaussianAbsolutePositionY(end+1) = measNa.analysis.fitIntegratedAsymGaussY.peak+measNa.settings.marqueeBox(2);

            centerX_Na = round(measNa.analysis.fittedGaussianAbsolutePositionX(end));
            centerY_Na = round(measNa.analysis.fittedGaussianAbsolutePositionY(end));

            centerX_K = centerX_Na-BECoffsetX;
            centerY_K = centerY_Na-BECoffsetY;
            
            
            % Do counting
            % Na large box
            measNa.settings.marqueeBox=[min(max(centerX_Na-countingMBlargeX/2,1),1024-countingMBlargeX) ...
                min(max(centerY_Na-countingMBlargeY/2,1),333-countingMBlargeY) ...
                countingMBlargeX countingMBlargeY ];
            measNa.flushAllODImages();
            measNa.createODimage('last');
            %measNa.plotODImage('last');
            measNa.bareNcntAverageMarqueeBox;
            measNa.analysis.NcntLarge(end+1) = measNa.analysis.bareNcntAverageMarqueeBoxValues(end);
            % Na small box
            measNa.settings.marqueeBox=[min(max(centerX_Na-countingMBsmallX/2,1),1024-countingMBsmallX) ...
                min(max(centerY_Na-countingMBsmallY/2,1),333-countingMBsmallY) ...
                countingMBsmallX countingMBsmallY ];
            measNa.flushAllODImages();
            measNa.createODimage('last');
            %measNa.plotODImage('last');
            measNa.bareNcntAverageMarqueeBox;
            measNa.analysis.NcntSmall(end+1) = measNa.analysis.bareNcntAverageMarqueeBoxValues(end);
            % K1 small box
            measK1.settings.marqueeBox=[min(max(centerX_K-countingMBsmallX/2,1),1024-countingMBsmallX) ...
                min(max(centerY_K-countingMBsmallY/2,1),333-countingMBsmallY) ...
                countingMBsmallX countingMBsmallY ];
            measK1.flushAllODImages();
            measK1.createODimage('last');
            %measK1.plotODImage('last');
            measK1.bareNcntAverageMarqueeBox;
            measK1.analysis.NcntSmall(end+1) = measK1.analysis.bareNcntAverageMarqueeBoxValues(end);
            % K1 large box
            measK1.settings.marqueeBox=[min(max(centerX_K-countingMBlargeX/2,1),1024-countingMBlargeX) ...
                min(max(centerY_K-countingMBlargeY/2,1),333-countingMBlargeY) ...
                countingMBlargeX countingMBlargeY ];
            measK1.flushAllODImages();
            measK1.createODimage('last');
            %measK1.plotODImage('last');
            set(gcf, 'Position', [1350 1328 560 420])
            measK1.bareNcntAverageMarqueeBox;
            measK1.analysis.NcntLarge(end+1) = measK1.analysis.bareNcntAverageMarqueeBoxValues(end);


            % K2 small box
            measK2.settings.marqueeBox=[min(max(centerX_K-countingMBsmallX/2,1),1024-countingMBsmallX) ...
                min(max(centerY_K-countingMBsmallY/2,1),333-countingMBsmallY) ...
                countingMBsmallX countingMBsmallY ];
            measK2.flushAllODImages();
            measK2.createODimage('last');
            %measK2.plotODImage('last');
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
        end
        
        % for time optimization only
        currentRunTime = toc;
        lastIterationDuration = currentRunTime-lastRunTime;
        lastRunTime = currentRunTime;
        measNa.analysis.analysisDurations(end+1) = lastIterationDuration;        
        figure(233),
        plot(measNa.analysis.analysisDurations)
        ylabel('time (s)');
        xlabel('run #');
        drawnow;
    end
    Na_analysis = struct;
    Na_analysis.badShots    = measNa.badShots;
    Na_analysis.parameters  = measNa.parameters;
    Na_analysis.analysis    = measNa.analysis;
    Na_analysis.settings    = measNa.settings;
    
    K1_analysis = struct;
    K1_analysis.badShots    = measK1.badShots;
    K1_analysis.parameters  = measK1.parameters;
    K1_analysis.analysis    = measK1.analysis;
    K1_analysis.settings    = measK1.settings;
    
    K2_analysis = struct;
    K2_analysis.badShots    = measK2.badShots;
    K2_analysis.parameters  = measK2.parameters;
    K2_analysis.analysis    = measK2.analysis;
    K2_analysis.settings    = measK2.settings;
    toc
end