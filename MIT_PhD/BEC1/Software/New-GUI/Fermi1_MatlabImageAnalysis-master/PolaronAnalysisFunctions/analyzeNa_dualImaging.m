function Na_analysis = analyzeNa_dualImaging(ScanList,varargin)
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
    
    params = ScanList.RFK2;
    
    if strcmp(BoxSize,'default')
        warning('Marquee box to be selected by hand! Choose BoxSize small or large for greater accuracy in COM or TF fitting. \n');
        marqueeX0=[];
    elseif strcmp(BoxSize,'small')
        marqueeX0 = 500;
        marqueeY0 = 160;
        marqueeXwidth = 200;
        marqueeYwidth= 60;
        warning('Box size is 200 x 60, better for COM position fitting.  For accurate TF radius, choose BoxSize large. \n');
    elseif strcmp(BoxSize,'large')
        warning('Box size is 320 x 100, better for TF radii fitting.  For accurate COM position fitting, choose BoxSize small. \n')
        fprintf(' ');
        marqueeX0 = 10;
        marqueeY0 = 130;
        marqueeXwidth = 360;
        marqueeYwidth = 22;    

    else
        error(['Choose marquee box size to be: default for hand-drawn marquee, small for better COM position, or large for better TF fitting']);
    end
    
    
    % check if enough images
    imageStartKeyword = 'Na';
    files= dir([ '*spe']);
    
    if(length(files)<length(params))
        error(['Error: there are less images (' num2str(length(files)) ') than parameters (' num2str(length(params)) ')'])
    elseif(length(files)>length(params))
        error(['Warning: there are more images (' num2str(length(files)) ') than parameters (' num2str(length(params)) ') press any key to continue'])
        waitforbuttonpress;
    end


    measNa = Measurement('Na','imageStartKeyword',imageStartKeyword,'sortFilesBy','name','plotImage','original','NormOff' ,false,'NormType','Box','plotOD',false,'verbose',false,'storeImages',false,'recenterMarqueeBox',false);
    
    measNa.settings.diffToDarkThreshold       = diffToDark;
    measNa.settings.GaussianFilterWidth = 2;
    measNa.settings.AbbeRadius = 0.75;
    measNa.analysis.analysisDurations = [];
    measNa.analysis.fittedGaussianAbsolutePositionX = [];
    measNa.analysis.fittedGaussianAbsolutePositionY = [];
    measNa.settings.LineDensityPixelAveraging = LineDensityPixelAv; 
    
    lastRunTime = toc;
    if ~isempty(marqueeX0)
        measNa.settings.marqueeBox=[marqueeX0 marqueeY0 marqueeXwidth marqueeYwidth ];
       
    end
    measNa.settings.normBox     = [72   173   214    12];

    
    for idx = 1:length(params)
        
        measNa.loadSPEImageFromFileName(params(idx),[num2str(ScanList.run_id(idx)), '_0.spe']);
        
        %recenter marquee box if we chose a fixed size 
        if  ~strcmp(BoxSize,'default') && idx==1
            measNa.setMarqueeBoxCenter(1);
            measNa.createODimage('last');
        end
        defaultBox = measNa.settings.marqueeBox;
        if(~measNa.lastImageBad)
            measNa.fitBimodalExcludeCenter('last','BlackedOutODthreshold',BlackedOutODthreshold,'BlackedOutODthresholdX',BlackedOutODthreshold,'useLineDensity',useLineDensity,'savePlottingInfo',false,'TFcut',TFcut);
            
            measNa.settings.marqueeBox = defaultBox;
            measNa.flushAllODImages();
            measNa.createODimage('last');
            extraPixel = 5;
            centerImage = measNa.images.ODImages(1,measNa.settings.marqueeBox(4)/2-extraPixel:measNa.settings.marqueeBox(4)/2+extraPixel,measNa.settings.marqueeBox(3)/2-extraPixel:measNa.settings.marqueeBox(3)/2+extraPixel);
            lowODThreshold = mean(centerImage(:));
            measNa.fitIntegratedAsymGaussian( 'last','LowODthreshold',lowODThreshold/2);
            measNa.analysis.fittedGaussianAbsolutePositionX(end+1) = measNa.analysis.fitIntegratedAsymGaussX.peak+measNa.settings.marqueeBox(1);
            measNa.analysis.fittedGaussianAbsolutePositionY(end+1) = measNa.analysis.fitIntegratedAsymGaussY.peak+measNa.settings.marqueeBox(2);

            measNa.flushAllODImages();
            
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
    Na_analysis.badShots = measNa.badShots;
    Na_analysis.parameters = measNa.parameters;
    Na_analysis.analysis = measNa.analysis;
    Na_analysis.settings = measNa.settings;
    toc
end