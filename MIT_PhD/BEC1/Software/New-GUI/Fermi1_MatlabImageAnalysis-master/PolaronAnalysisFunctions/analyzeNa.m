function Na_analysis = analyzeNa(params,varargin)
    tic
    p = inputParser;
    p.addParameter('BlackedOutODthreshold',1.4);
    p.addParameter('BoxSize','default');
    p.addParameter('diffToDark',40.00);
    p.parse(varargin{:});
    BlackedOutODthreshold   = p.Results.BlackedOutODthreshold;
    BoxSize                 = p.Results.BoxSize;
    diffToDark              = p.Results.diffToDark;
    
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
        marqueeX0 = 410;
        marqueeY0 = 140;
        marqueeXwidth = 280;
        marqueeYwidth=80;    

    else
        error(['Choose marquee box size to be: default for hand-drawn marquee, small for better COM position, or large for better TF fitting']);
    end
    
    
    % check if enough images
    imageStartKeyword = 'Na';
    files= dir([imageStartKeyword '*spe']);
    
    if(length(files)<length(params))
        error(['Error: there are less images (' num2str(length(files)) ') than parameters (' num2str(length(params)) ')'])
    elseif(length(files)>length(params))
        error(['Warning: there are more images (' num2str(length(files)) ') than parameters (' num2str(length(params)) ') press any key to continue'])
        waitforbuttonpress;
    end


    measNA = Measurement('Na','imageStartKeyword',imageStartKeyword,'sortFilesBy','name','plotImage','original','NormOff' ,false,'NormType','Box','plotOD',false,'verbose',false,'storeImages',false,'recenterMarqueeBox',false);
    
    measNA.settings.diffToDarkThreshold       = diffToDark;
    measNA.settings.GaussianFilterWidth = 2;
    measNA.settings.AbbeRadius = 0.75;
    measNA.analysis.analysisDurations = [];
    measNA.analysis.fittedGaussianAbsolutePositionX = [];
    measNA.analysis.fittedGaussianAbsolutePositionY = [];
    
    lastRunTime = toc;
    if ~isempty(marqueeX0)
        measNA.settings.marqueeBox=[marqueeX0 marqueeY0 marqueeXwidth marqueeYwidth ];
       
    end
    
    for idx = 1:length(params)
        
        measNA.loadNewestSPEImage(params(idx));
        
        %recenter marquee box if we chose a fixed size 
        if  ~strcmp(BoxSize,'default') && idx==1
            measNA.setMarqueeBoxCenter(1);
            measNA.createODimage('last');
        end
        if(~measNA.lastImageBad)
            measNA.fitBimodalExcludeCenter('last','BlackedOutODthreshold',BlackedOutODthreshold,'BlackedOutODthresholdX',2.5,'useLineDensity',true);
            
            centerX = round(measNA.analysis.fitBimodalExcludeCenter.xparam(end,3)+measNA.settings.marqueeBox(1));
            centerY = round(measNA.analysis.fitBimodalExcludeCenter.yparam(end,3)+measNA.settings.marqueeBox(2));
%             measNA.settings.marqueeBox=[centerX-marqueeXwidth/4 centerY-marqueeYwidth/2 marqueeXwidth/2 marqueeYwidth ];
            measNA.settings.marqueeBox=[marqueeX0 marqueeY0 marqueeXwidth marqueeYwidth ];

%             if (measNA.settings.marqueeBox(1)+measNA.settings.marqueeBox(3)>1024)
%                 measNA.settings.marqueeBox=[marqueeX0 centerY-marqueeYwidth/2 marqueeXwidth/2 marqueeYwidth ];
%             end
%             if (measNA.settings.marqueeBox(1)+measNA.settings.marqueeBox(3)>333)
%                 measNA.settings.marqueeBox=[centerX-marqueeXwidth/4 marqueeY0 marqueeXwidth/2 marqueeYwidth ];
%             end
            %measNA.settings.marqueeBox=[marqueeX0 marqueeY0 marqueeXwidth marqueeYwidth ];
            measNA.flushAllODImages();
            measNA.createODimage('last');
            extraPixel = 5;
            centerImage = measNA.images.ODImages(1,measNA.settings.marqueeBox(4)/2-extraPixel:measNA.settings.marqueeBox(4)/2+extraPixel,measNA.settings.marqueeBox(3)/2-extraPixel:measNA.settings.marqueeBox(3)/2+extraPixel);
            lowODThreshold = mean(centerImage(:));
            measNA.fitIntegratedAsymGaussian( 'last','LowODthreshold',lowODThreshold/3);
            measNA.analysis.fittedGaussianAbsolutePositionX(end+1) = measNA.analysis.fitIntegratedAsymGaussX.peak+measNA.settings.marqueeBox(1);
            measNA.analysis.fittedGaussianAbsolutePositionY(end+1) = measNA.analysis.fitIntegratedAsymGaussY.peak+measNA.settings.marqueeBox(2);
%             measNA.settings.marqueeBox=[500-marqueeXwidth/4 measNA.settings.marqueeBox(2) marqueeXwidth marqueeYwidth ];
            measNA.flushAllODImages();
        end
        
        % for time optimization only
        currentRunTime = toc;
        lastIterationDuration = currentRunTime-lastRunTime;
        lastRunTime = currentRunTime;
        measNA.analysis.analysisDurations(end+1) = lastIterationDuration;        
        figure(233),
        plot(measNA.analysis.analysisDurations)
        ylabel('time (s)');
        xlabel('run #');
        drawnow;
    end
    Na_analysis = struct;
    Na_analysis.badShots = measNA.badShots;
    Na_analysis.parameters = measNA.parameters;
    Na_analysis.analysis = measNA.analysis;
    Na_analysis.settings = measNA.settings;
    toc
end