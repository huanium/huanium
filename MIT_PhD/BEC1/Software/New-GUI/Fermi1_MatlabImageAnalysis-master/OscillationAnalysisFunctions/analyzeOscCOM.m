function ana = analyzeOscCOM(params,varargin)
%Analyzes COM for either Na or K
    tic
    p = inputParser;
    p.addParameter('BlackedOutODthreshold',1.4);
    p.addParameter('BoxSize','OscY');
    p.addParameter('diffToDark',40.00);
    p.addParameter('species','Na');
    p.parse(varargin{:});
    BlackedOutODthreshold   = p.Results.BlackedOutODthreshold;
    BoxSize                 = p.Results.BoxSize;
    diffToDark              = p.Results.diffToDark;
    species                 = p.Results.species;
    if strcmp(BoxSize,'OscY')
        marqueeX0 = 500;
        marqueeY0 = 120;
        marqueeXwidth = 150;
        marqueeYwidth=150;
        warning('Box size is 150 x 150,  better for oscillations in the y-axis. \n');
    elseif strcmp(BoxSize,'OscX')
        warning('Box size is 320 x 80, better for oscillations in the x-axis. \n')
        fprintf(' ');
        marqueeX0 = 410;
        marqueeY0 = 120;
        marqueeXwidth = 320;
        marqueeYwidth=80;    

    else
        error(['Choose marquee box size: OscY or OscX']);
    end
    
    
     % check if enough images
    imageStartKeyword = species;
    files= dir([imageStartKeyword '*spe']);
    
    if(length(files)<length(params))
        error(['Error: there are less images (' num2str(length(files)) ') than parameters (' num2str(length(params)) ')'])
    elseif(length(files)>length(params))
        warning(['Warning: there are more images (' num2str(length(files)) ') than parameters (' num2str(length(params)) ') press any key to continue'])
        waitforbuttonpress;
    end


    meas = Measurement(species,'imageStartKeyword',imageStartKeyword,'sortFilesBy','name',...
        'plotImage','original','NormOff' ,false,'NormType','Box','plotOD',false,'verbose',false,'storeImages',false,'recenterMarqueeBox',false);
    
    meas.settings.diffToDarkThreshold       = diffToDark;
    meas.settings.GaussianFilterWidth = 2;
    meas.settings.AbbeRadius = 0.75;
    meas.analysis.analysisDurations = [];
    meas.analysis.fittedGaussianAbsolutePositionX = [];
    meas.analysis.fittedGaussianAbsolutePositionY = [];
    
    lastRunTime = toc;
    if ~isempty(marqueeX0)
        meas.settings.marqueeBox=[marqueeX0 marqueeY0 marqueeXwidth marqueeYwidth ];
       
    end
    
    for idx = 1:length(params)
        
        meas.loadNewestSPEImage(params(idx));
        
        %recenter marquee box if we chose a fixed size 
        if idx==1 
            meas.setMarqueeBoxCenter(1);
            meas.createODimage('last');
        end
        if(~meas.lastImageBad)
            %IF analyzing Na BEC, use FitBimodalExcludeCenter
            if strcmp(species,'Na')
                meas.fitBimodalExcludeCenter('last','BlackedOutODthreshold',BlackedOutODthreshold,'BlackedOutODthresholdX',2.5);
                meas.flushAllODImages();
            else
                meas.fitIntegratedGaussian('last');
%                 meas.plotAllIntegratedProfilesX();
                meas.getCOMY('last');
                meas.flushAllODImages();

            end
        end
        
        % for time optimization only
        currentRunTime = toc;
        lastIterationDuration = currentRunTime-lastRunTime;
        lastRunTime = currentRunTime;
        meas.analysis.analysisDurations(end+1) = lastIterationDuration;        
        figure(233),
        plot(meas.analysis.analysisDurations)
        ylabel('time (s)');
        xlabel('run #');
        drawnow;
    end
    ana = struct;
    ana.badShots = meas.badShots;
    ana.parameters = meas.parameters;
    ana.analysis = meas.analysis;
    ana.settings = meas.settings;
    toc
end