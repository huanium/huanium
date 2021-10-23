classdef Measurement < handle
    %MEASUREMENT
    properties
        name;
        date;
        settings = struct();
        images = struct();
        lineDensities = struct();
        parameters = [];
        parametersWithBadShots = [];
        analysis = struct();
        
        nextFileNumber = 1;
        badShots = {};
        lastImageBad = false;
        counterTotalImages = 0;
        counterBadImages = 0;
        counterGoodImages = 0;
    end
    
    methods
        function this = Measurement(MeasurementName,varargin)
            p = inputParser;
            
            p.addParameter('imageStartKeyword','');
            p.addParameter('sortFilesBy','date');
            p.addParameter('moveFile',false);
            p.addParameter('plotImage','original');
            p.addParameter('NormOff',false);
            p.addParameter('NormType','Shell');
            p.addParameter('reCenterMarqueeBox',false);
            p.addParameter('removeBeamIris',false);
            p.addParameter('ellipseMarqueeX',[]);
            p.addParameter('ellipseMarqueeY',[]);  
            p.addParameter('storeImages',true);
            p.addParameter('plotOD',true);
            p.addParameter('verbose',true);  
            
            p.parse(varargin{:});
            
            % settings for loading images
            this.settings.imageKeyword              = p.Results.imageStartKeyword;
            this.settings.sortFilesBy               = p.Results.sortFilesBy;
            this.settings.moveFile                  = p.Results.moveFile;
            this.settings.plotImage                 = p.Results.plotImage;
            this.settings.storeImages               = p.Results.storeImages;
            
            % settings for normalization and marquee box
            this.settings.NormOff                   = p.Results.NormOff;
            this.settings.NormType                  = p.Results.NormType;
            this.settings.reCenterMarqueeBox        = p.Results.reCenterMarqueeBox;
            this.settings.removeBeamIris            = p.Results.removeBeamIris;
            this.settings.rawImageSize              = [1024,1024];
            this.settings.marqueeBox                = [];
            this.settings.normBox                   = [];
            this.settings.normBoxOffset             = 5;
            this.settings.normBoxWidth              = 5;
            this.settings.normBoxWidth              = 5;
            this.settings.imageRotationAngle        = 0;
            this.settings.xOffset                   = -10;
            this.settings.yOffset                   = -55;
            this.settings.beamIris                  = struct;
            
            % 2 x Nparams vector, first row is center position in pixel, second row is TF radius in pixel
            this.settings.ellipseMarqueeX           = p.Results.ellipseMarqueeX; 
            this.settings.ellipseMarqueeY           = p.Results.ellipseMarqueeY;
            
            % settings for the autobad shot detection
            this.settings.avIntPerPixelThreshold    = 0.1;
            this.settings.diffToDarkThreshold       = 40;
            
            % low and high cap for OD images
            this.settings.ODThreshold               = 4;
            this.settings.lowThreshold              = 0.01;
            
            % settings for filtering and averaging images
            this.settings.superSamplingFactor       = 2;
            this.settings.AbbeRadius                = 3; % in camera pixel
            this.settings.GaussianFilterWidth       = 1; % in pixel, should be set by PSF resolution
            this.settings.pixelAveraging            = 2;
            
            % settings for line desnities
            this.settings.LineDensityPixelAveraging = 1;
            this.settings.LineDensityFoldCenter     = false;
            this.settings.fudgeWidth                = 1;
            this.settings.fudgeFilterFreq           = 100;
            this.settings.superSamplingFactor1D     = 4;
            
            % settings for analysis
            this.settings.extraPixelForQuickDensity = 2;
            
            % settings for console output and plots
            this.settings.plotOD                    = p.Results.plotOD;
            this.settings.verbose                   = p.Results.verbose;
           
            % create empty image and analysis arrays
            this.analysis.bareNcntValues            = [];
            this.analysis.bareNcntAverageMarqueeBoxValues = [];
            
            this.images.rawDarkFieldImage           = [];
            this.images.rawBrightFieldImage         = [];
            this.images.rawBrightAtomImage          = [];
            
            this.images.absorptionImages            = [];
            this.images.absorptionImagesAveraged    = [];
            this.images.absorptionImagesFiltered    = [];
            
            this.images.ODImages                    = [];
            this.images.ODImagesFiltered            = [];
            this.images.ODImagesAveraged            = [];
            
            this.lineDensities.Xintegrated          = [];
            this.lineDensities.XintegratedUpsampled = [];
            this.lineDensities.Yintegrated          = [];
            this.lineDensities.YintegratedUpsampled = [];
            
            this.name = MeasurementName;
            
            this.date = datestr(now,30);
            if((exist([pwd '\done\'])~=7))
                mkdir('done');
            end
            if((exist([pwd '\badShots\'])~=7))
                mkdir('badShots');
            end
            
            % turn off prepareFittingData inf and NaN warning 
            warning('off','curvefit:prepareFittingData:removingNaNAndInf');
            
        end
        
        function save(this)
            newVarName = ['M_' this.date '_' this.name];
            newVarName=strrep(newVarName, ' ', '_');
            newVarName=strrep(newVarName, '.', '_');
            newVarName=strrep(newVarName, '-', '_');
            newVarName=strrep(newVarName, '(', '_');
            newVarName=strrep(newVarName, ')', '_');
            newVarName=strrep(newVarName, ':', '_');
            newVarName=strrep(newVarName, ';', '_');
            newVarName=strrep(newVarName, ',', '_');
            if(length(newVarName)>63)
                newVarName = newVarName(1:63);
            end
            assignin('base',newVarName,this);
            if(exist([pwd '\Data'])==7)
                evalin('base',strcat('save(''Data/',newVarName,''',''',newVarName,''')'));
            else
                evalin('base',strcat('save(''',newVarName,''',''',newVarName,''')'));
            end
            evalin('base',cell2mat(strcat('clear',{' '},newVarName)));
            
            disp(['Measurement saved as |' newVarName '.mat|'])
        end
        
        
        function flushAllODImages(this)
            this.images.ODImages = [];
            this.images.ODImagesAveraged = [];
            this.images.ODImagesFiltered = [];
            this.lineDensities.Xintegrated = [];
            this.lineDensities.Yintegrated = [];
            this.lineDensities.XintegratedUpsampled = [];
            this.lineDensities.YintegratedUpsampled = [];
        end
        
        function flushAllImages(this)
            this.images.rawDarkFieldImage   = [];
            this.images.rawBrightFieldImage = [];
            this.images.rawBrightAtomImage  = [];
            
            this.images.absorptionImages = [];
            this.images.absorptionImagesAveraged = [];
            this.images.absorptionImagesFiltered = [];
            
            this.images.ODImages = [];
            this.images.ODImagesAveraged = [];
            this.images.ODImagesFiltered = [];
            
            this.lineDensities.Xintegrated = [];
            this.lineDensities.Yintegrated = [];
            
            this.lineDensities.XintegratedUpsampled = [];
            this.lineDensities.YintegratedUpsampled = [];
        end
        
        function loadFITSImageFromFileName(this,parameters,FileName,varargin)
            p = inputParser;
            p.addParameter('testing',false);
            p.addParameter('imageTag','');
            p.addParameter('fluoImage',false);
            
            p.parse(varargin{:});
            testing  = p.Results.testing;
            imageTag  = p.Results.imageTag;
            fluoImage  = p.Results.fluoImage;
            
            % save parameter
            this.parameters(end+1) = parameters;
            this.parametersWithBadShots(end+1) = parameters;
            
            if(~testing)
                % get newest spe file
                if isempty(imageTag)
                    files = dir(FileName);
                    fprintf(['loading: ' files.name '\n']);
                    newImagesTemp=fitsread(FileName);
                    if fluoImage
                        newImages(:,:,1) = newImagesTemp(:,:,2);
                        newImages(:,:,2) = newImagesTemp(:,:,1);
                        newImages(:,:,3) = zeros(size(newImagesTemp(:,:,2)));
                    
                    else
                        newImages = newImagesTemp;
                    end
                    if this.settings.moveFile == true
                        movefile(files.name,[pwd '\done\']);
                    end
                else
                    files= dir([num2str(FileName) imageTag '*fits']);
                    fprintf(['loading: ' files.name '\n']);
                    newImages=fitsread(files.name);
                    if this.settings.moveFile == true
                        movefile(files.name,[pwd '\done\']);
                    end
                end
                
                    
                
            else
                newImages(:,:,1) = 10*ones(1024,1024);
                newImages(1:100,1:100,1) = 100*ones(100,100);
                newImages(:,:,2) = 100*ones(1024,1024);
                newImages(:,:,3) = 0*ones(1024,1024);
                fileIdx = 1;
                files.name = 'testing';
                fprintf(['loading: ' files(fileIdx).name '\n']);
            end
            
            this.counterTotalImages = this.counterTotalImages+1;
            this.createAbsorptionImage(newImages,files.name);
            
        end
        
        
        function loadSPEImageFromFileName(this,parameters,FileName,varargin)
            p = inputParser;
            p.addParameter('testing',false);
            p.addParameter('imageTag','');
            p.addParameter('fluoImage',false);
            
            p.parse(varargin{:});
            testing  = p.Results.testing;
            imageTag  = p.Results.imageTag;
            fluoImage  = p.Results.fluoImage;
            
            % save parameter
            this.parameters(end+1) = parameters;
            this.parametersWithBadShots(end+1) = parameters;
            
            if(~testing)
                % get newest spe file
                if isempty(imageTag)
                    files = dir(FileName);
                    fprintf(['loading: ' files.name '\n']);
                    newImagesTemp=im2double(this.readSPE(FileName));
                    if fluoImage
                        newImages(:,:,1) = newImagesTemp(:,:,2);
                        newImages(:,:,2) = newImagesTemp(:,:,1);
                        newImages(:,:,3) = zeros(size(newImagesTemp(:,:,2)));
                    
                    else
                        newImages = newImagesTemp;
                    end
                    if this.settings.moveFile == true
                        movefile(files.name,[pwd '\done\']);
                    end
                else
                    files= dir([num2str(FileName) imageTag '*spe']);
                    fprintf(['loading: ' files.name '\n']);
                    newImages=im2double(this.readSPE(files.name));
                    if this.settings.moveFile == true
                        movefile(files.name,[pwd '\done\']);
                    end
                end
                
                    
                
            else
                newImages(:,:,1) = 10*ones(1024,1024);
                newImages(1:100,1:100,1) = 100*ones(100,100);
                newImages(:,:,2) = 100*ones(1024,1024);
                newImages(:,:,3) = 0*ones(1024,1024);
                fileIdx = 1;
                files.name = 'testing';
                fprintf(['loading: ' files(fileIdx).name '\n']);
            end
            
            this.counterTotalImages = this.counterTotalImages+1;
            this.createAbsorptionImage(newImages,files.name);
            
        end
        
        
        function loadNewestSPEImage(this,parameters,varargin)
            p = inputParser;
            p.addParameter('testing',false);
            p.parse(varargin{:});
            testing  = p.Results.testing;
            
            % save parameter
            this.parameters(end+1) = parameters;
            this.parametersWithBadShots(end+1) = parameters;
            
            if(~testing)
                % get newest spe file
                files= dir([this.settings.imageKeyword '*spe']);
                if(strcmp(this.settings.sortFilesBy,'date'))
                    dates = zeros(length(files),1);
                    for j = 1:length(files)
                        dates(j) =datenum(files(j).date);
                    end
                    [~, fileIdx]=(max(dates));
                elseif(strcmp(this.settings.sortFilesBy,'name'))
                    if this.settings.moveFile == true
                        targetFileNumber = 1;
                    else
                        targetFileNumber = this.nextFileNumber;
                        this.nextFileNumber = this.nextFileNumber+1;
                    end
                    filenames = cell(length(files),1);
                    for jdx = 1:length(files)
                        numbers = regexp(files(jdx).name,'\d*','Match');
                        filenames{jdx} = [files(jdx).name(1:end-strlength(numbers(end))-4),sprintf('%010d',str2double(numbers{end})),'.spe'];
                    end
                    [~,sortidx] = sort(filenames);
                    fileIdx = sortidx(targetFileNumber);
                end
                fprintf(['loading: ' files(fileIdx).name '\n']);
                newImages=im2double(this.readSPE(files(fileIdx).name));
                if this.settings.moveFile == true
                    movefile(files(fileIdx).name,[pwd '\done\']);
                end
            else
                newImages(:,:,1) = 10*ones(1024,1024);
                newImages(1:100,1:100,1) = 100*ones(100,100);
                newImages(:,:,2) = 100*ones(1024,1024);
                newImages(:,:,3) = 0*ones(1024,1024);
                fileIdx = 1;
                files.name = 'testing';
                fprintf(['loading: ' files(fileIdx).name '\n']);
            end
            
            this.counterTotalImages = this.counterTotalImages+1;
            this.createAbsorptionImage(newImages,files(fileIdx).name);
        end
        
        function newImages=loadAndAverageSPEImagesFromFileName(this,parameter,imageFileNames,ReferencePositions,varargin)
            p = inputParser;
            p.addParameter('badShotImageNames',{});
            p.addParameter('binaryImageSelection',[]);
            p.parse(varargin{:});
            badShotImageNames = p.Results.badShotImageNames;
            binaryImageSelection = p.Results.binaryImageSelection;
            
            this.parameters(end+1) = parameter;
            this.parametersWithBadShots(end+1) = parameter;
            
            
            xZero = ReferencePositions(1,1);
            yZero = ReferencePositions(1,2);
            badShotImageIdxOffset = 0;
            newImages = [];
            trueIdx=1; %idx of Na parameters
            for idx = 1:length(imageFileNames)
                
                if isempty(badShotImageNames)
                    badShotImageIdxOffset = 0;
                else
                    badShotDet = 0;
                    for jdx = 1:length(badShotImageNames)
                        tempName1 = imageFileNames{trueIdx+badShotImageIdxOffset};
                        tempName2 = badShotImageNames{jdx};
                        badShotDet = badShotDet+strcmp(tempName1(end-10:end),tempName2(end-10:end));
                    end
                    if badShotDet>0
                        fprintf(['skipping bad image: ' imageFileNames{trueIdx+badShotImageIdxOffset} '\n']);
                        badShotImageIdxOffset = badShotImageIdxOffset+1;
                        continue;
                    end
                end
                
                if ~isempty(binaryImageSelection)
                    if binaryImageSelection(trueIdx) == 0
                       fprintf(['skipping image due to external selection: ' imageFileNames{trueIdx+badShotImageIdxOffset} '\n']);
                       trueIdx=trueIdx+1;
                       continue; 
                    end
                end
                
                xShift = round(xZero-ReferencePositions(trueIdx,1));
                yShift = round(yZero-ReferencePositions(trueIdx,2));
                fprintf(['loading: ' imageFileNames{trueIdx+badShotImageIdxOffset} '\n']);
                tempImages = im2double(this.readSPE(imageFileNames{idx}));
                mask = isnan(tempImages);
                tempImages(mask) = 0;
                for jdx = 1:3
                    tempImages(:,:,jdx) = imtranslate(squeeze(tempImages(:,:,jdx)),[xShift, yShift]);
                end
                newImages(:,:,:,end+1)=tempImages;
                if this.settings.moveFile == true
                    movefile(files(imageIdxs(idx)).name,[pwd '\done\']);
                end
                trueIdx=trueIdx+1;
            end
            if length(newImages)>0
                this.createAbsorptionImage(mean(newImages,4),'AveragedImage');
            end
        end
        
        function newImages=loadAndAverageSPEImages(this,parameter,imageIdxsUnsorted,ReferencePositions,varargin)
            p = inputParser;
            p.addParameter('badShotImageNames',{});
            p.addParameter('binaryImageSelection',[]);
            p.parse(varargin{:});
            badShotImageNames = p.Results.badShotImageNames;
            binaryImageSelection = p.Results.binaryImageSelection;
            
            this.parameters(end+1) = parameter;
            this.parametersWithBadShots(end+1) = parameter;
            
            % get newest spe file
            files= dir([this.settings.imageKeyword '*spe']);
            if(strcmp(this.settings.sortFilesBy,'date'))
                dates = zeros(length(files),1);
                for j = 1:length(files)
                    dates(j) =datenum(files(j).date);
                end
                [~,sortedDatesIdx] = sort(dates);
                imageIdxs = sortedDatesIdx(imageIdxsUnsorted);
            elseif(strcmp(this.settings.sortFilesBy,'name'))
                filenames = cell(length(files),1);
                    for jdx = 1:length(files)
                        numbers = regexp(files(jdx).name,'\d*','Match');
                        filenames{jdx} = [files(jdx).name(1:end-strlength(numbers(end))-4),sprintf('%010d',str2double(numbers{end})),'.spe'];
                    end
                    [~,sortidx] = sort(filenames);
                try
                    imageIdxs = sortidx(imageIdxsUnsorted);
                catch
                    display('abc');
                end
            end
            
            xZero = ReferencePositions(1,1);
            yZero = ReferencePositions(1,2);
            badShotImageIdxOffset = 0;
            %initialize newImages
            %dummy=im2double(this.readSPE(files(imageIdxs(1)).name));
            %newImages=zeros([size(dummy) length(ReferencePositions)]);
            newImages = [];
            trueIdx=1; %idx of Na parameters
            for idx = 1:length(imageIdxs)
                
                if isempty(badShotImageNames)
                    badShotImageIdxOffset = 0;
                else
                    badShotDet = 0;
                    for jdx = 1:length(badShotImageNames)
                        tempName1 = files(imageIdxs(trueIdx+badShotImageIdxOffset)).name;
                        tempName2 = badShotImageNames{jdx};
                        badShotDet = badShotDet+strcmp(tempName1(end-10:end),tempName2(end-10:end));
                    end
                    if badShotDet>0
                        fprintf(['skipping bad image: ' files(imageIdxs(trueIdx+badShotImageIdxOffset)).name '\n']);
                        badShotImageIdxOffset = badShotImageIdxOffset+1;
                        continue;
                    end
                end
                
                if ~isempty(binaryImageSelection)
                    if binaryImageSelection(trueIdx) == 0
                       fprintf(['skipping image due to external selection: ' files(imageIdxs(trueIdx+badShotImageIdxOffset)).name '\n']);
                       trueIdx=trueIdx+1;
                       continue; 
                    end
                end
                
                xShift = round(xZero-ReferencePositions(trueIdx,1));
                yShift = round(yZero-ReferencePositions(trueIdx,2));
                fprintf(['loading: ' files(imageIdxs(trueIdx+badShotImageIdxOffset)).name '\n']);
                tempImages = im2double(this.readSPE(files(imageIdxs(idx)).name));
                mask = isnan(tempImages);
                tempImages(mask) = 0;
                for jdx = 1:3
                    tempImages(:,:,jdx) = imtranslate(squeeze(tempImages(:,:,jdx)),[xShift, yShift]);
                end
                newImages(:,:,:,end+1)=tempImages;
                if this.settings.moveFile == true
                    movefile(files(imageIdxs(idx)).name,[pwd '\done\']);
                end
                trueIdx=trueIdx+1;
            end
            % original
%             this.createAbsorptionImage(mean(newImages,4),'AveragedImage');
            % added this avoid empty image
            if length(newImages)>0
                this.createAbsorptionImage(mean(newImages,4),'AveragedImage');
            end
        end
             
        function createAbsorptionImage(this,newImages,filename)
            
            darkFieldImage   = newImages(:,:,3);
            brightFieldImage = newImages(:,:,2);
            brightAtomImage  = newImages(:,:,1);
            
            % create normal absoprtion image
            %this.settings.rawImageSize = [size(darkFieldImage,1),size(darkFieldImage,2)];
            mask = and(brightAtomImage>darkFieldImage , brightFieldImage>darkFieldImage);
            tempImage = zeros(this.settings.rawImageSize(1),this.settings.rawImageSize(2));
            tempImage(mask) = (brightAtomImage(mask)-darkFieldImage(mask))./(brightFieldImage(mask)-darkFieldImage(mask));
            
            tempImage = imrotate((tempImage), this.settings.imageRotationAngle,'crop');
            diffToDark = sum(sum(brightFieldImage-darkFieldImage))./(length(darkFieldImage(1,:))*length(darkFieldImage(:,1)));
            
            %bad shot analysis
            avIntPerPixel = sum(sum(tempImage))./(length(tempImage(1,:)).*length(tempImage(:,1)));
            if this.settings.verbose
                fprintf('Average light level = %.2f; diffToDark = %.2f\n',avIntPerPixel,diffToDark)
            end
            if(avIntPerPixel>this.settings.avIntPerPixelThreshold&& ...
               avIntPerPixel<10&& ...
               diffToDark>this.settings.diffToDarkThreshold)
                this.lastImageBad = false;
                this.counterGoodImages = this.counterGoodImages+1;
                
                if(this.settings.removeBeamIris)
                   if(~isfield(this.settings.beamIris,'centers')) 
                       tempImage2 = tempImage;
                       mask = tempImage2<0;
                       tempImage2(mask) = 0;
                       mask = tempImage2>1;
                       tempImage2(mask) = 1;
                       [this.settings.beamIris.centers,this.settings.beamIris.radii] = imfindcircles(tempImage2,[150 200],'ObjectPolarity','bright','Sensitivity',0.99,'EdgeThreshold',0.2);
                   end
                   [xsize,ysize] = size(tempImage);
                   [columnsInImage, rowsInImage] = meshgrid( 1:ysize,1:xsize);
                   circlePixels = (columnsInImage - this.settings.beamIris.centers(1,1)).^2 + (rowsInImage - this.settings.beamIris.centers(1,2)).^2 <= (this.settings.beamIris.radii(1)-15).^2;
                   tempImage(~circlePixels) = 1;
                end
                
                if this.settings.storeImages
                    this.images.absorptionImages(length(this.parameters),:,:) = tempImage;
                else
                    this.images.absorptionImages(1,:,:) = tempImage;
                end
                this.images.rawDarkFieldImage   = darkFieldImage;
                this.images.rawBrightFieldImage = brightFieldImage;
                this.images.rawBrightAtomImage  = brightAtomImage;

               
                superSamplDarkFieldImage = this.upsampleAndFilter(darkFieldImage);
                superSamplBrightFieldImage = this.upsampleAndFilter(brightFieldImage);
                superSamplBrightAtomImage = this.upsampleAndFilter(brightAtomImage);
                
                % apply Gaussian filter to smoothen noise
                superSamplDarkFieldImage   = imgaussfilt(superSamplDarkFieldImage, this.settings.superSamplingFactor*this.settings.GaussianFilterWidth);
                superSamplBrightFieldImage = imgaussfilt(superSamplBrightFieldImage, this.settings.superSamplingFactor*this.settings.GaussianFilterWidth);
                superSamplBrightAtomImage  = imgaussfilt(superSamplBrightAtomImage, this.settings.superSamplingFactor*this.settings.GaussianFilterWidth);
                
                mask = and(superSamplBrightAtomImage>superSamplDarkFieldImage , superSamplBrightFieldImage>superSamplDarkFieldImage);
                tempImage = zeros(this.settings.superSamplingFactor*this.settings.rawImageSize(1),this.settings.superSamplingFactor*this.settings.rawImageSize(2));
                tempImage(mask) = (superSamplBrightAtomImage(mask)-superSamplDarkFieldImage(mask))./(superSamplBrightFieldImage(mask)-superSamplDarkFieldImage(mask));
                
                tempImage = imrotate((tempImage), this.settings.imageRotationAngle,'crop');
                
                if(this.settings.removeBeamIris)
                   [xsize,ysize] = size(tempImage);
                   [columnsInImage, rowsInImage] = meshgrid( 1:ysize,1:xsize);
                   circlePixels = (columnsInImage - round(this.settings.superSamplingFactor*this.settings.beamIris.centers(1,1))).^2 + (rowsInImage - this.settings.superSamplingFactor*this.settings.beamIris.centers(1,2)).^2 <= (this.settings.superSamplingFactor*(this.settings.beamIris.radii(1)-15)).^2;
                   tempImage(~circlePixels) = 1;
                end
                
                if this.settings.storeImages
                    this.images.absorptionImagesFiltered(length(this.parameters),:,:) = tempImage;
                else
                    this.images.absorptionImagesFiltered(1,:,:) = tempImage;
                end
                
                %create averaged image
                averagedDarkFieldImage = imresize(darkFieldImage, 1/this.settings.pixelAveraging, 'box');
                averagedBrightFieldImage = imresize(brightFieldImage, 1/this.settings.pixelAveraging, 'box');
                averagedBrightAtomImage = imresize(brightAtomImage, 1/this.settings.pixelAveraging, 'box');
                
                
                mask = and(averagedBrightAtomImage>averagedDarkFieldImage , averagedBrightFieldImage>averagedDarkFieldImage);
                tempImage = zeros(ceil(1/this.settings.pixelAveraging*this.settings.rawImageSize(1)),ceil(1/this.settings.pixelAveraging*this.settings.rawImageSize(2)));
                tempImage(mask) = (averagedBrightAtomImage(mask)-averagedDarkFieldImage(mask))./(averagedBrightFieldImage(mask)-averagedDarkFieldImage(mask));
                
                tempImage = imrotate((tempImage), this.settings.imageRotationAngle,'crop');
                
                if(this.settings.removeBeamIris)
                   [xsize,ysize] = size(tempImage);
                   [columnsInImage, rowsInImage] = meshgrid( 1:ysize,1:xsize);
                   circlePixels = (columnsInImage - ceil(1/this.settings.pixelAveraging*this.settings.beamIris.centers(1,1))).^2 + (rowsInImage - ceil(1/this.settings.pixelAveraging*this.settings.beamIris.centers(1,2))).^2 <= (ceil(1/this.settings.pixelAveraging*(this.settings.beamIris.radii(1)-15))).^2;
                   tempImage(~circlePixels) = 1;
                end
                
                if this.settings.storeImages
                    this.images.absorptionImagesAveraged(length(this.parameters),:,:) = tempImage;
                    currentImageIdx = length(this.images.absorptionImages(:,1,1));
                else
                    this.images.absorptionImagesAveraged(1,:,:) = tempImage;
                    currentImageIdx = 1;
                end
                
                % set marquee box if it has not been set yet
                if(isempty(this.settings.marqueeBox))
                    this.setmarqueeBox(currentImageIdx);
                    if(strcmp(this.settings.NormType,'Box' ))
                        this.setNormBox(currentImageIdx);
                    end
                end
                if(isempty(this.settings.normBox))
                    if(strcmp(this.settings.NormType,'Box' ))
                        this.setNormBox(currentImageIdx);
                    end
                end
                if(this.settings.reCenterMarqueeBox==true)
                    this.setMarqueeBoxCenterGlobal('last');
                end
                
                % plotting and analysis (this might move somewhere else)
                
                % this.plotAbsorptionImage(currentImageIdx);
                this.createODnormalzation(currentImageIdx);
                this.createODimage(currentImageIdx);
                this.createLineDensities();
                if this.settings.plotOD 
                    this.plotODImage(currentImageIdx);
                end
                % this.bareNcnt(currentImageIdx);
                this.bareNcntAverageMarqueeBox;
            else
                fprintf('Average light per pixel below %.2f (%.2f) or diffToDark below %.2f (%.2f), aborting analysis\n',this.settings.avIntPerPixelThreshold,avIntPerPixel,this.settings.diffToDarkThreshold,diffToDark)
                this.parameters(end) = [];
                this.badShots{end+1} = filename;
                this.lastImageBad = true;
                this.counterBadImages = this.counterBadImages+1;
                this.parametersWithBadShots(end) = NaN;
                if this.settings.moveFile == true
                    movefile([pwd '\done\' filename],[pwd '\badShots\' filename]);
                end
            end
        end
        
        function createODnormalzation(this,currentImageIdx)
            if strcmp(currentImageIdx,'last')
                currentImageIdx = length(this.images.absorptionImages(:,1,1));
                analyzeIdx = length(this.parameters);
            elseif this.settings.storeImages
                analyzeIdx = currentImageIdx;
            else
                currentImageIdx = 1;
                analyzeIdx = length(this.parameters);
            end
            
            
            %% calculate normalization
            if(strcmp(this.settings.NormType,'Shell' ))
                NormBoxMask = false(this.settings.rawImageSize(1),this.settings.rawImageSize(2));
                xpos    = this.settings.marqueeBox(2)-(this.settings.normBoxOffset+this.settings.normBoxWidth);
                ypos    = this.settings.marqueeBox(1)-(this.settings.normBoxOffset+this.settings.normBoxWidth);
                xwidth  = this.settings.marqueeBox(4)+2*(this.settings.normBoxOffset+this.settings.normBoxWidth);
                ywidth  = this.settings.marqueeBox(3)+2*(this.settings.normBoxOffset+this.settings.normBoxWidth);
                NormBoxMask(xpos:xpos+xwidth,ypos:ypos+ywidth) = true;

                xpos    = this.settings.marqueeBox(2)-(this.settings.normBoxOffset);
                ypos    = this.settings.marqueeBox(1)-(this.settings.normBoxOffset);
                xwidth  = this.settings.marqueeBox(4)+2*(this.settings.normBoxOffset);
                ywidth  = this.settings.marqueeBox(3)+2*(this.settings.normBoxOffset);
                NormBoxMask(xpos:xpos+xwidth,ypos:ypos+ywidth) = false;
            elseif(strcmp(this.settings.NormType,'Box' ))
                NormBoxMask = false(this.settings.rawImageSize(1),this.settings.rawImageSize(2));
                NormBoxMask(this.settings.normBox(2):this.settings.normBox(2)+this.settings.normBox(4)-1,this.settings.normBox(1):this.settings.normBox(1)+this.settings.normBox(3)-1) = true;
                
            end
            NormImage = squeeze(this.images.absorptionImages(currentImageIdx,:,:));
            % remove negative values
            mask = NormImage<0;
            NormImage(mask) = this.settings.lowThreshold;
            
            ODNorm=-log(NormImage);
            
            % remove high values
            mask = ODNorm>this.settings.ODThreshold;
            ODNorm(mask) = this.settings.ODThreshold;
            try 
                normalization = sum(sum(ODNorm(NormBoxMask)))./sum(sum(NormBoxMask));
            catch
                disp('ohoh!')
            end
            
            if this.settings.NormOff==true
                normalization = 0;
            end
            
            this.settings.ODnormalization = normalization;
            
        end
        
        function createODimage(this,currentImageIdx)

            if strcmp(currentImageIdx,'last')
                currentImageIdx = length(this.images.absorptionImages(:,1,1));
                analyzeIdx = length(this.parameters);
            elseif this.settings.storeImages
                analyzeIdx = currentImageIdx;
            else
                currentImageIdx = 1;
                analyzeIdx = length(this.parameters);
            end
            
            normalization = this.settings.ODnormalization;
            
            %% OD of unfiltered image
            % If ellipseMarquee is enabled, cut out the ellipse in the
            % absorption image, setting everything outset = 1.0
            if(~isempty(this.settings.ellipseMarqueeX))
                croppedAbsorptionImage = squeeze(this.images.absorptionImages(currentImageIdx,:,:));
                [xsize,ysize] = size(croppedAbsorptionImage);
                [columnsInImage, rowsInImage] = meshgrid( 1:ysize,1:xsize);
                xLoc=this.settings.marqueeBox(1)+this.settings.ellipseMarqueeX(1,currentImageIdx);
                yLoc=this.settings.marqueeBox(2)+this.settings.ellipseMarqueeY(1,currentImageIdx);
                xWp=this.settings.ellipseMarqueeX(2,currentImageIdx);
                yWp=this.settings.ellipseMarqueeY(2,currentImageIdx);
                circlePixels = (columnsInImage - xLoc).^2/xWp^2 + (rowsInImage - yLoc).^2/yWp^2 <= 1;
                croppedAbsorptionImage(~circlePixels) = 1;
            else
                try
                    croppedAbsorptionImage = squeeze(this.images.absorptionImages(currentImageIdx,this.settings.marqueeBox(2):this.settings.marqueeBox(2)+this.settings.marqueeBox(4)-1,this.settings.marqueeBox(1):min(this.settings.marqueeBox(1)+this.settings.marqueeBox(3)-1,1024)));
                catch
                    disp('ohoh');
                end
            end
            mask = croppedAbsorptionImage<0;
            croppedAbsorptionImage(mask) = this.settings.lowThreshold;
            
            ODImage=-log(croppedAbsorptionImage)-normalization;
            
            % remove high values
            mask = ODImage>this.settings.ODThreshold;
            ODImage(mask) = this.settings.ODThreshold;
            
            if this.settings.storeImages
                this.images.ODImages(currentImageIdx,:,:) = ODImage;
            else
                this.images.ODImages(1,:,:) = ODImage;
            end
            
            
            %% OD of unfiltered image with pixel averaging
            if(~isempty(this.settings.ellipseMarqueeX))
                tempAbs = squeeze(this.images.absorptionImagesAveraged(currentImageIdx,:,:));
                [xsize,ysize] = size(tempAbs);
                [columnsInImage, rowsInImage] = meshgrid( 1:ysize,1:xsize);
                xLoc=(this.settings.marqueeBox(1))/this.settings.pixelAveraging+this.settings.ellipseMarqueeX(1,currentImageIdx);
                yLoc=(this.settings.marqueeBox(2))/this.settings.pixelAveraging+this.settings.ellipseMarqueeY(1,currentImageIdx);
                xWp=this.settings.ellipseMarqueeX(2,currentImageIdx)/this.settings.pixelAveraging;
                yWp=this.settings.ellipseMarqueeY(2,currentImageIdx)/this.settings.pixelAveraging;
                circlePixels = (columnsInImage - xLoc).^2/xWp^2 + (rowsInImage - yLoc).^2/yWp^2 <= 1;
                tempAbs(~circlePixels) = 1;
                if this.settings.storeImages
                    this.images.absorptionImagesAveraged(currentImageIdx,:,:)=tempAbs;
                else
                    this.images.absorptionImagesAveraged(1,:,:)=tempAbs;
                end
            end
                
            croppedAbsorptionImage = squeeze(this.images.absorptionImagesAveraged(currentImageIdx,round(1/this.settings.pixelAveraging*this.settings.marqueeBox(2)):round(1/this.settings.pixelAveraging*(this.settings.marqueeBox(2)+this.settings.marqueeBox(4)))-1,round(1/this.settings.pixelAveraging*this.settings.marqueeBox(1)):round(1/this.settings.pixelAveraging*(this.settings.marqueeBox(1)+this.settings.marqueeBox(3)))-1));
            
            mask = croppedAbsorptionImage<0;
            croppedAbsorptionImage(mask) = this.settings.lowThreshold;
            
            ODImage=-log(croppedAbsorptionImage)-normalization;
            
            % remove high values
            mask = ODImage>this.settings.ODThreshold;
            ODImage(mask) = this.settings.ODThreshold;
            if this.settings.storeImages
                this.images.ODImagesAveraged(currentImageIdx,:,:) = ODImage;
            else
                this.images.ODImagesAveraged(1,:,:) = ODImage;
            end
            
            
            %% OD of filtered image with super sampling (if enabled)
            if(~isempty(this.settings.ellipseMarqueeX))
                tempAbs = squeeze(this.images.absorptionImagesFiltered(currentImageIdx,:,:));
                [xsize,ysize] = size(tempAbs);
                [columnsInImage, rowsInImage] = meshgrid( 1:ysize,1:xsize);
                xLoc=(this.settings.marqueeBox(1)+this.settings.pixelAveraging*this.settings.ellipseMarqueeX(1,currentImageIdx))*this.settings.superSamplingFactor;
                yLoc=(this.settings.marqueeBox(2)+this.settings.pixelAveraging*this.settings.ellipseMarqueeY(1,currentImageIdx))*this.settings.superSamplingFactor;
                xWp=this.settings.ellipseMarqueeX(2,currentImageIdx)*this.settings.superSamplingFactor;
                yWp=this.settings.ellipseMarqueeY(2,currentImageIdx)*this.settings.superSamplingFactor;
                circlePixels = (columnsInImage - xLoc).^2/xWp^2 + (rowsInImage - yLoc).^2/yWp^2 <= 1;
                tempAbs(~circlePixels) = 1;
                if this.settings.storeImages
                    this.images.absorptionImagesFiltered(currentImageIdx,:,:)=tempAbs;
                else
                    this.images.absorptionImagesFiltered(1,:,:)=tempAbs;
                end
            end
            try 
                croppedAbsorptionImage = squeeze(this.images.absorptionImagesFiltered(currentImageIdx,this.settings.superSamplingFactor*this.settings.marqueeBox(2):this.settings.superSamplingFactor*(this.settings.marqueeBox(2)+this.settings.marqueeBox(4)),this.settings.superSamplingFactor*this.settings.marqueeBox(1):min(this.settings.superSamplingFactor*(this.settings.marqueeBox(1)+this.settings.marqueeBox(3)),2048)));
            catch
                disp('ohoh');
            end
            mask = croppedAbsorptionImage<0;
            croppedAbsorptionImage(mask) = this.settings.lowThreshold;
            
            ODImage=-log(croppedAbsorptionImage)-normalization;
            
            % remove high values
            mask = ODImage>this.settings.ODThreshold;
            ODImage(mask) = this.settings.ODThreshold;
            if this.settings.storeImages
                this.images.ODImagesFiltered(currentImageIdx,:,:) = ODImage;
            else
                this.images.ODImagesFiltered(1,:,:) = ODImage;
            end
        end
        
        function setmarqueeBox(this,currentImageIdx)
            if strcmp(currentImageIdx,'last')
                currentImageIdx = length(this.parameters);
            end
            figure(1); clf
            
            image = squeeze(this.images.absorptionImages(currentImageIdx,:,:));
            imagesc(image);
            colorbar;
            axis equal;
            caxis([0,1]);
            title('Set Marquee Box', 'FontSize',18 )
            colormap(bone)
            caxis([0,1.3])
            drawnow;
            
            this.settings.marqueeBox = round(getrect);
            this.setMarqueeBoxCenter(currentImageIdx);
            
        end
        
        function setNormBox(this,currentImageIdx)
            if strcmp(currentImageIdx,'last')
                currentImageIdx = length(this.parameters);
            end
            figure(1); clf
            
            image = squeeze(this.images.absorptionImages(currentImageIdx,:,:));
            imagesc(image);
            colorbar;
            axis equal;
            colormap(bone)
            caxis([0,1.3])
            title('Set Normalization Box', 'FontSize',18 )
            drawnow;
            
            this.settings.normBox = round(getrect);
        end
        function setmarqueeBoxHole(this,currentImageIdx)
            if strcmp(currentImageIdx,'last')
                currentImageIdx = length(this.parameters);
            end
            figure(1); clf
            image = squeeze(this.images.ODImagesAveraged(currentImageIdx,:,:));
            imagesc(image);
            colorbar;
            axis equal;
            colormap(bone)
            caxis([0,1.3])
            drawnow;
            
            this.settings.marqueeBoxHole = round(getrect);
        end
        
        function setMarqueeBoxCenter(this,currentImageIdx)
            if strcmp(currentImageIdx,'last')
                currentImageIdx = length(this.parameters);
            end
            croppedImage = squeeze(this.images.absorptionImages(currentImageIdx,this.settings.marqueeBox(2):this.settings.marqueeBox(2)+this.settings.marqueeBox(4),this.settings.marqueeBox(1):this.settings.marqueeBox(1)+this.settings.marqueeBox(3)));
            figure(1)
            clf
            imagesc(croppedImage);
            title('Set Marquee Box Center', 'FontSize',18 )
            colormap(bone)
            caxis([0,1.3])
            axis equal;
            [xpos,ypos] = ginput(1);
            this.settings.marqueeBox(1) = this.settings.marqueeBox(1)+round(xpos-this.settings.marqueeBox(3)/2);
            this.settings.marqueeBox(2) = this.settings.marqueeBox(2)+round(ypos-this.settings.marqueeBox(4)/2);
            %this.settings.normBox = [this.settings.marqueeBox(1)+round(1.3*this.settings.marqueeBox(3)),this.settings.marqueeBox(2)+round(1.3*this.settings.marqueeBox(4)),round(this.settings.marqueeBox(3)/2),round(this.settings.marqueeBox(4)/2)];
        end
        
        function setMarqueeBoxCenterGlobal(this,currentImageIdx)
            if strcmp(currentImageIdx,'last')
                currentImageIdx = length(this.parameters);
            end
            croppedImage = squeeze(this.images.absorptionImages(currentImageIdx,:,:));
            figure(1)
            clf
            imagesc(croppedImage);
            title('Set Marquee Box Center', 'FontSize',18 )
            colormap(bone)
            caxis([0,1.3])
            axis equal;
            [xpos,ypos] = ginput(1);
            this.settings.marqueeBox(1) = round(xpos-this.settings.marqueeBox(3)/2);
            this.settings.marqueeBox(2) = round(ypos-this.settings.marqueeBox(4)/2);
            %this.settings.normBox = [this.settings.marqueeBox(1)+round(1.3*this.settings.marqueeBox(3)),this.settings.marqueeBox(2)+round(1.3*this.settings.marqueeBox(4)),round(this.settings.marqueeBox(3)/2),round(this.settings.marqueeBox(4)/2)];
        end
        
        function readjustMaqueeBoxToSecondMeas(this,meas,currentImageIdx)
            if strcmp(currentImageIdx,'last')
                currentImageIdx = length(this.parameters);
            end
            xpos = meas.settings.marqueeBox(1)+meas.analysis.fit2DGauss.param(currentImageIdx,3);
            ypos = meas.settings.marqueeBox(2)+meas.analysis.fit2DGauss.param(currentImageIdx,4);
            this.settings.marqueeBox(1) = this.settings.xOffset+round(xpos-this.settings.marqueeBox(3)/2);
            this.settings.marqueeBox(2) = this.settings.yOffset+round(ypos-this.settings.marqueeBox(4)/2);
        end
        
        %% Analysis functions
        function createLineDensities(this)
            
            analyzeIdx = length(this.parameters);
            normalization = this.settings.ODnormalization;
            
            croppedDarkFieldImage   = (this.images.rawDarkFieldImage(this.settings.marqueeBox(2):this.settings.marqueeBox(2)+this.settings.marqueeBox(4)-1,this.settings.marqueeBox(1):this.settings.marqueeBox(1)+this.settings.marqueeBox(3)-1));
            croppedBrightFieldImage = (this.images.rawBrightFieldImage(this.settings.marqueeBox(2):this.settings.marqueeBox(2)+this.settings.marqueeBox(4)-1,this.settings.marqueeBox(1):this.settings.marqueeBox(1)+this.settings.marqueeBox(3)-1));
            croppedBrightAtomImage  = (this.images.rawBrightAtomImage(this.settings.marqueeBox(2):this.settings.marqueeBox(2)+this.settings.marqueeBox(4)-1,this.settings.marqueeBox(1):this.settings.marqueeBox(1)+this.settings.marqueeBox(3)-1));
            
            [rows,columns] = size(croppedBrightAtomImage);
            
            %% Y Line Density (integrated along X)
            croppedDarkFieldLine    = sum(croppedDarkFieldImage,1);
            croppedBrightFieldLine  = sum(croppedBrightFieldImage,1);
            croppedBrightAtomLine   = sum(croppedBrightAtomImage,1);
            
            if(this.settings.LineDensityFoldCenter == true)
                if(mod(columns,2))
                   croppedDarkFieldLine     = ([croppedDarkFieldLine(1:columns/2),0]+fliplr(croppedDarkFieldLine(columns/2+1:end)))/2;
                   croppedBrightFieldLine   = ([croppedBrightFieldLine(1:columns/2),0]+fliplr(croppedBrightFieldLine(columns/2+1:end)))/2;
                   croppedBrightAtomLine    = ([croppedBrightAtomLine(1:columns/2),0]+fliplr(croppedBrightAtomLine(columns/2+1:end)))/2;
                else
                   croppedDarkFieldLine     = croppedDarkFieldLine(1:columns/2)+fliplr(croppedDarkFieldLine(columns/2+1:end));
                   croppedBrightFieldLine   = croppedBrightFieldLine(1:columns/2)+fliplr(croppedBrightFieldLine(columns/2+1:end));
                   croppedBrightAtomLine    = croppedBrightAtomLine(1:columns/2)+fliplr(croppedBrightAtomLine(columns/2+1:end));
                end
            end
            
            if(this.settings.LineDensityPixelAveraging > 1)
                PXav = this.settings.LineDensityPixelAveraging;
                croppedDarkFieldLine    = mean(reshape(croppedDarkFieldLine(1:fix(numel(croppedDarkFieldLine)/PXav)*PXav), PXav, []));
                croppedBrightFieldLine  = mean(reshape(croppedBrightFieldLine(1:fix(numel(croppedBrightFieldLine)/PXav)*PXav), PXav, []));
                croppedBrightAtomLine   = mean(reshape(croppedBrightAtomLine(1:fix(numel(croppedBrightAtomLine)/PXav)*PXav), PXav, []));
            end
            
            reshapedColumns = length(croppedDarkFieldLine);
            
            % create normal absoprtion line
            mask = and(croppedBrightAtomLine>croppedDarkFieldLine , croppedBrightFieldLine>croppedDarkFieldLine);
            absorptionLine = zeros(1,reshapedColumns);
            absorptionLine(mask) = (croppedBrightAtomLine(mask)-croppedDarkFieldLine(mask))./(croppedBrightFieldLine(mask)-croppedDarkFieldLine(mask));
            
            ODLine=-log(absorptionLine)-normalization;
            
            % remove high values
            mask = ODLine>this.settings.ODThreshold;
            ODLine(mask) = this.settings.ODThreshold;
            
            this.lineDensities.Yintegrated(analyzeIdx,:) = ODLine;
            
            this.lineDensities.YintegratedUpsampled(analyzeIdx,:) = this.upsampleAndFilter1D(ODLine)/this.settings.superSamplingFactor1D;
            
            %% X Line Density (integrated along Y)
            croppedDarkFieldLine    = sum(croppedDarkFieldImage,2);
            croppedBrightFieldLine  = sum(croppedBrightFieldImage,2);
            croppedBrightAtomLine   = sum(croppedBrightAtomImage,2);
            
            if(this.settings.LineDensityFoldCenter == true)
                if(mod(rows,2))
                   croppedDarkFieldLine     = ([croppedDarkFieldLine(1:rows/2);0]+flipud(croppedDarkFieldLine(rows/2+1:end)))/2;
                   croppedBrightFieldLine   = ([croppedBrightFieldLine(1:rows/2);0]+flipud(croppedBrightFieldLine(rows/2+1:end)))/2;
                   croppedBrightAtomLine    = ([croppedBrightAtomLine(1:rows/2);0]+flipud(croppedBrightAtomLine(rows/2+1:end)))/2;
                else
                   croppedDarkFieldLine     = croppedDarkFieldLine(1:rows/2)+flipud(croppedDarkFieldLine(rows/2+1:end));
                   croppedBrightFieldLine   = croppedBrightFieldLine(1:rows/2)+flipud(croppedBrightFieldLine(rows/2+1:end));
                   croppedBrightAtomLine    = croppedBrightAtomLine(1:rows/2)+flipud(croppedBrightAtomLine(rows/2+1:end));
                end
            end
            
            if(this.settings.LineDensityPixelAveraging > 1)
                PXav = this.settings.LineDensityPixelAveraging;
                croppedDarkFieldLine    = mean(reshape(croppedDarkFieldLine(1:fix(numel(croppedDarkFieldLine)/PXav)*PXav), PXav, []));
                croppedBrightFieldLine  = mean(reshape(croppedBrightFieldLine(1:fix(numel(croppedBrightFieldLine)/PXav)*PXav), PXav, []));
                croppedBrightAtomLine   = mean(reshape(croppedBrightAtomLine(1:fix(numel(croppedBrightAtomLine)/PXav)*PXav), PXav, []));
            end
            
            reshapedRows = length(croppedDarkFieldLine);
            
            % create normal absoprtion line
            mask = and(croppedBrightAtomLine>croppedDarkFieldLine , croppedBrightFieldLine>croppedDarkFieldLine);
            absorptionLine = zeros(1,reshapedRows);
            absorptionLine(mask) = (croppedBrightAtomLine(mask)-croppedDarkFieldLine(mask))./(croppedBrightFieldLine(mask)-croppedDarkFieldLine(mask));
            
            ODLine=-log(absorptionLine)-normalization;
            
            % remove high values
            mask = ODLine>this.settings.ODThreshold;
            ODLine(mask) = this.settings.ODThreshold;
            
            this.lineDensities.Xintegrated(analyzeIdx,:) = ODLine;
            
            this.lineDensities.XintegratedUpsampled(analyzeIdx,:) = this.upsampleAndFilter1D(ODLine)/this.settings.superSamplingFactor1D;
            
            
        end
        
        
        function bareNcntAverageMarqueeBox(this)
            analyzeIdx = length(this.parameters);
            
            
            normalization = this.settings.ODnormalization;
                        
            %% OD of unfiltered image
            
            croppedDarkFieldImage   = (this.images.rawDarkFieldImage(this.settings.marqueeBox(2):this.settings.marqueeBox(2)+this.settings.marqueeBox(4)-1,this.settings.marqueeBox(1):this.settings.marqueeBox(1)+this.settings.marqueeBox(3)-1));
            croppedBrightFieldImage = (this.images.rawBrightFieldImage(this.settings.marqueeBox(2):this.settings.marqueeBox(2)+this.settings.marqueeBox(4)-1,this.settings.marqueeBox(1):this.settings.marqueeBox(1)+this.settings.marqueeBox(3)-1));
            croppedBrightAtomImage  = (this.images.rawBrightAtomImage(this.settings.marqueeBox(2):this.settings.marqueeBox(2)+this.settings.marqueeBox(4)-1,this.settings.marqueeBox(1):this.settings.marqueeBox(1)+this.settings.marqueeBox(3)-1));
            
            [rows,columns] = size(croppedBrightAtomImage);
            
            summedAbsorption = (sum(croppedBrightAtomImage(:)-croppedDarkFieldImage(:)))./(sum(croppedBrightFieldImage(:)-croppedDarkFieldImage(:)));
            
            ODValue=-log(summedAbsorption)-normalization;
            
            % remove high values
            mask = ODValue>this.settings.ODThreshold;
            ODValue(mask) = this.settings.ODThreshold;
            
            this.analysis.bareNcntAverageMarqueeBoxValues(analyzeIdx) = rows*columns*ODValue;
            fprintf([this.name ' - MB av cnt: ' num2str(this.analysis.bareNcntAverageMarqueeBoxValues(analyzeIdx),2) ' - image (good/total): '  num2str(this.counterGoodImages) '/' num2str(this.counterTotalImages) ' - parameter: ' num2str(this.parameters(analyzeIdx)) '\n'  ]);
        end
        
        function bareNcnt(this,currentImageIdx)
            if strcmp(currentImageIdx,'last')
                currentImageIdx = length(this.images.ODImages(:,1,1));
                analyzeIdx = length(this.parameters);
            elseif this.settings.storeImages
                analyzeIdx = currentImageIdx;
            else
                currentImageIdx = 1;
                analyzeIdx = length(this.parameters);
            end
            
            this.analysis.bareNcntValues(analyzeIdx)=this.settings.pixelAveraging^2*sum(sum(squeeze(this.images.ODImagesAveraged(currentImageIdx,:,:))));
            fprintf([this.name ' - (outdated) N cnt: ' num2str(this.analysis.bareNcntValues(analyzeIdx),2) ' - image (good/total): '  num2str(this.counterGoodImages) '/' num2str(this.counterTotalImages) ' - parameter: ' num2str(this.parameters(analyzeIdx)) '\n'  ]);
        
        end
        
        function bareNcntInsideOutside(this,currentImageIdx)
            if strcmp(currentImageIdx,'last')
                currentImageIdx = length(this.images.ODImages(:,1,1));
                analyzeIdx = length(this.parameters);
            elseif this.settings.storeImages
                analyzeIdx = currentImageIdx;
            else
                currentImageIdx = 1;
                analyzeIdx = length(this.parameters);
            end
            currentODimage = squeeze(this.images.ODImagesAveraged(currentImageIdx,:,:));
            [dy,dx] = size(currentODimage);
            HoleBoxMask = true(dy,dx);
            
            xpos = this.settings.marqueeBoxHole(1);
            xwidth = this.settings.marqueeBoxHole(3);
            ypos = this.settings.marqueeBoxHole(2);
            ywidth = this.settings.marqueeBoxHole(4);
            HoleBoxMask(ypos:ypos+ywidth-1,xpos:xpos+xwidth-1) = false;
            
            this.analysis.bareNcntValuesOutside(analyzeIdx) = sum(sum(currentODimage(HoleBoxMask)));
            ODHoleImage = currentODimage(ypos:ypos+ywidth-1,xpos:xpos+xwidth-1);
            this.analysis.bareNcntValuesInside(analyzeIdx) = sum(sum(ODHoleImage));
        end
        
        function inverseAbel(this,currentImageIdx)
            if strcmp(currentImageIdx,'last')
                currentImageIdx = length(this.images.ODImages(:,1,1));
                analyzeIdx = length(this.parameters);
            elseif this.settings.storeImages
                analyzeIdx = currentImageIdx;
            else
                currentImageIdx = 1;
                analyzeIdx = length(this.parameters);
            end
            if(~isfield(this.analysis, 'averagedElliptical'))
                this.averageRadiallyElliptical(currentImageIdx);
            end
            if(length(this.analysis.averagedElliptical.radialCoordinates(:,1))<currentImageIdx)
                this.averageRadiallyElliptical(currentImageIdx);
            end
            diffAverage = (diff(this.analysis.averagedElliptical.radialAverageOD(currentImageIdx,:)));
            radialCoordinates = this.analysis.averagedElliptical.radialCoordinates(currentImageIdx,:);
            
            radialCoordinates(isnan(radialCoordinates)) = [];
            diffAverage(isnan(diffAverage)) = [];
            
            inverseAbelDensity(:) = zeros(1,max(this.settings.marqueeBox(3),this.settings.marqueeBox(4)));
            for idx = 1:length(diffAverage)
                radius = radialCoordinates(idx);
                xvals = radialCoordinates(1:end-1);
                temp = interp1(xvals,diffAverage,sqrt(radius^2+xvals.^2)) ./ (sqrt(radius^2+xvals.^2));
                temp(isnan(temp)) = [];
                inverseAbelDensity(idx) = -1/pi * sum(temp);
            end
            normFactor = sqrt(this.settings.inverseAbel.widthx/this.settings.inverseAbel.widthy);
            
            this.analysis.inverseAbel.Densities(analyzeIdx,:) = normFactor*inverseAbelDensity;
            
            radialCoordinatesForSaving = NaN(1,max(this.settings.marqueeBox(3),this.settings.marqueeBox(4)));
            radialCoordinatesForSaving(1:length(xvals)) = xvals;
            this.analysis.inverseAbel.radialCoordinates(analyzeIdx,:) = radialCoordinatesForSaving;
            figure(13)
            clf
            plot(xvals,normFactor*inverseAbelDensity(1:length(xvals)),'.', 'MarkerSize',20)
            drawnow;
            
%             yvals = normFactor*inverseAbelDensity(1:length(xvals));
%             % filter signal:
%             samplingFreq = 1;
%             cutoffFreq=0.008;
%             w=2*pi*cutoffFreq;% convert to radians per second
%             nyquivstFreq=samplingFreq/2;
%             order = 7;
%             
%             [b14, a14]=butter(order,(w/nyquivstFreq),'low');
%             lowPassfiltered=filtfilt(b14,a14,yvals);
%             hold on
%             plot(xvals,lowPassfiltered);
%             hold off
        end
        
        function fit2DGaussian(this,currentImageIdx)
            if strcmp(currentImageIdx,'last')
                currentImageIdx = length(this.images.ODImages(:,1,1));
                analyzeIdx = length(this.parameters);
            elseif this.settings.storeImages
                analyzeIdx = currentImageIdx;
            else
                currentImageIdx = 1;
                analyzeIdx = length(this.parameters);
            end
            if strcmp(this.settings.plotImage,'original')
                croppedODImage = squeeze(this.images.ODImages(currentImageIdx,:,:));
                
                pGuess = [mean([croppedODImage(1,:),croppedODImage(:,1)']),max(max(croppedODImage)),this.settings.marqueeBox(3)/2,this.settings.marqueeBox(4)/2,this.settings.marqueeBox(3)/10,1,0];   % Inital (guess) parameters
                lb = [-0.05,0.05,0.1*this.settings.marqueeBox(3),0.1*this.settings.marqueeBox(4),1,0.02,-10];
                ub = [1.2*abs(mean([croppedODImage(1,:),croppedODImage(:,1)'])),1.2*max(max(croppedODImage)),0.9*this.settings.marqueeBox(3),0.9*this.settings.marqueeBox(4),min(this.settings.marqueeBox(4),this.settings.marqueeBox(3)),10,10];
                
                [x,y]=meshgrid(1:this.settings.marqueeBox(3),1:this.settings.marqueeBox(4));
                pixel=zeros(this.settings.marqueeBox(4),this.settings.marqueeBox(3),2);
                
            elseif strcmp(this.settings.plotImage,'filtered')
                croppedODImage = squeeze(this.images.ODImagesFiltered(currentImageIdx,:,:));
                
                pGuess = [mean([croppedODImage(1,:),croppedODImage(:,1)']),max(max(croppedODImage)),this.settings.superSamplingFactor*this.settings.marqueeBox(3)/2,this.settings.superSamplingFactor*this.settings.marqueeBox(4)/2,this.settings.superSamplingFactor*this.settings.marqueeBox(3)/10,1,0];   % Inital (guess) parameters
                lb = [-0.05,0.05,0.1*this.settings.superSamplingFactor*this.settings.marqueeBox(3),0.1*this.settings.superSamplingFactor*this.settings.marqueeBox(4),1,0.02,-10];
                ub = [1.2*abs(mean([croppedODImage(1,:),croppedODImage(:,1)'])),1.2*max(max(croppedODImage)),0.9*this.settings.superSamplingFactor*this.settings.marqueeBox(3),0.9*this.settings.superSamplingFactor*this.settings.marqueeBox(4),min(this.settings.superSamplingFactor*this.settings.marqueeBox(3),this.settings.superSamplingFactor*this.settings.marqueeBox(4)),10,10];
                
                [x,y]=meshgrid(1:this.settings.superSamplingFactor*this.settings.marqueeBox(3)+1,1:this.settings.superSamplingFactor*this.settings.marqueeBox(4)+1);
                pixel=zeros(this.settings.superSamplingFactor*this.settings.marqueeBox(4)+1,this.settings.superSamplingFactor*this.settings.marqueeBox(3)+1,2);
                
            end
            pixel(:,:,1)=x;
            pixel(:,:,2)=y;
            
            fitfun = @(p,x) p(1)+p(2)*exp( -(...
                ( x(:,:,1)*cosd(p(7))-x(:,:,2)*sind(p(7)) - p(3)*cosd(p(7))+p(4)*sind(p(7)) ).^2/(p(5)^2) + ...
                ( x(:,:,1)*sind(p(7))+x(:,:,2)*cosd(p(7)) - p(3)*sind(p(7))-p(4)*cosd(p(7)) ).^2/((p(5)*p(6))^2) ) );
            
            parameterNames = {'Offset', 'Amplitude','Center X','Center Y','Width','Aspect Ratio', 'Angle'};
            
            opts = optimoptions('lsqcurvefit','Algorithm','trust-region-reflective','Display','off','MaxFunctionEvaluations',100);
            [param,~,residuals,~,~,~,J] = lsqcurvefit(fitfun,pGuess,pixel,croppedODImage,lb,ub,opts);
            
            if(isempty(residuals))
                ci = NaN(7,2);
            else
                ci = nlparci(param,residuals,'jacobian',J,'alpha',1-0.68);
            end
            
            figure(4);
            clf;
            subplot(1,3,1);
            imagesc(croppedODImage);
            title('Image')
            axis equal;
            colorbar
            caxis([0 max(max(croppedODImage))]);
            subplot(1,3,2);
            imagesc(fitfun(param,pixel));
            title('Fitted Gaussian')
            axis equal;
            colorbar
            caxis([0 max(max(croppedODImage))]);
            subplot(1,3,3);
            imagesc((fitfun(param,pixel)-croppedODImage));
            title('Residuals')
            axis equal;
            colorbar
            drawnow;
            
            %report outputs in "real pixels" not supersampled pixels
            if strcmp(this.settings.plotImage,'filtered')
                param(3:5)=param(3:5)/this.settings.superSamplingFactor;
                ci(3:5)=ci(3:5)/this.settings.superSamplingFactor;
                ci(10:12)=ci(10:12)/this.settings.superSamplingFactor;
            end
           
            this.printFitReport(parameterNames,param,ci);
            this.analysis.fit2DGauss.parameterNames(analyzeIdx,:)  = parameterNames;
            this.analysis.fit2DGauss.param(analyzeIdx,:)           = param;
            this.analysis.fit2DGauss.ci(analyzeIdx,:,:)            = ci;
            

        end
        
        function fitBimodal(this,currentImageIdx,varargin)
            p = inputParser;
            
            p.addParameter('testing',false);
            p.addParameter('TFradii',5*[4,1,1]);
            p.addParameter('GaussSigma',10*[4,1,1]);
            p.addParameter('nBECnTherm',0.2);
            p.addParameter('noisePercent',0.05);
            p.addParameter('BlackedOutODthreshold',4);
            p.addParameter('plotting',false);
            p.addParameter('useLineDensity',false);
            
            p.parse(varargin{:});
            testing                 = p.Results.testing;
            TFradii                 = p.Results.TFradii;
            GaussSigma              = p.Results.GaussSigma;
            nBECnTherm              = p.Results.nBECnTherm;
            noisePercent            = p.Results.noisePercent;
            BlackedOutODthreshold   = p.Results.BlackedOutODthreshold;
            plotting                = p.Results.plotting;
            useLineDensity          = p.Results.useLineDensity;
            
            if testing
                currentImageIdx = 1;
                analyzeIdx = 1;
                BEC=@(x,y,z) 15/(8*pi*TFradii(1)*TFradii(2)*TFradii(3))*(1-x.^2/TFradii(1)^2-y.^2/TFradii(2)^2-z.^2/TFradii(3)^2).*heaviside(1-x.^2/TFradii(1)^2-y.^2/TFradii(2)^2-z.^2/TFradii(3)^2);
                
                Therm=@(x,y,z) 1/(GaussSigma(1)*GaussSigma(2)*GaussSigma(3)*pi^1.5)*exp(-x.^2/GaussSigma(1)^2-y.^2/GaussSigma(2)^2-z.^2/GaussSigma(3)^2);
                
                Combined = @(x,y,z) BEC(x,y,z)+nBECnTherm*Therm(x,y,z);
                
                xCoords = -3*max(GaussSigma(1),TFradii(1)):1:3*max(GaussSigma(1),TFradii(1));
                yCoords = -3*max(GaussSigma(2),TFradii(2)):1:3*max(GaussSigma(2),TFradii(3));
                zCoords = -3*max(GaussSigma(3),TFradii(3)):1:3*max(GaussSigma(2),TFradii(3));
                
                [XCoords,YCoords,ZCoords] = meshgrid(xCoords,yCoords,zCoords);   
                
                simulatedColumnDensity = sum(100*Combined(XCoords,YCoords,ZCoords),3);
                ysum=sum(simulatedColumnDensity,2);
                xsum=sum(simulatedColumnDensity,1);
                
                ysum=ysum+noisePercent.*ysum.*randn(length(yCoords'),1)+noisePercent./10.*max(ysum).*randn(length(yCoords'),1);
                xsum=xsum+noisePercent.*xsum.*randn(1,length(xCoords))+noisePercent./10.*max(xsum).*randn(1,length(xCoords));
                
                [xpix, nx] = prepareCurveData( xCoords, xsum );
                [ypix, ny] = prepareCurveData( yCoords, ysum' );
                
            else
                if strcmp(currentImageIdx,'last')
                    currentImageIdx = length(this.images.ODImages(:,1,1));
                    analyzeIdx = length(this.parameters);
                elseif this.settings.storeImages
                    analyzeIdx = currentImageIdx;
                else
                    currentImageIdx = 1;
                    analyzeIdx = length(this.parameters);
                end
                if strcmp(this.settings.plotImage,'original')
                    croppedODImage = squeeze(this.images.ODImages(currentImageIdx,:,:));
                elseif strcmp(this.settings.plotImage,'averaged')
                    croppedODImage = squeeze(this.images.ODImagesAveraged(currentImageIdx,:,:));
                elseif strcmp(this.settings.plotImage,'filtered')
                    croppedODImage = squeeze(this.images.ODImagesFiltered(currentImageIdx,:,:));
                end
                
                if useLineDensity
                    ysum = this.lineDensities.Xintegrated(end,:);
                    xsum = this.lineDensities.Yintegrated(end,:);
                else
                    ysum=sum(croppedODImage,2);
                    xsum=sum(croppedODImage,1);
                end
                
                
                
               [xpix, nx] = prepareCurveData( 1:length(xsum), xsum );
               [ypix, ny] = prepareCurveData( 1:length(ysum), ysum' );
            end
            if(~isnan(BlackedOutODthreshold))
                ODmask = croppedODImage>BlackedOutODthreshold;
                croppedODImage(ODmask) = NaN;
            end
            
            % inv parab to peak fit:
            [maxValue,mavValueIdx] = max(nx);
            PeakMaskP = nx>0.4*maxValue;
            if(sum(PeakMaskP)<10)
                PeakMaskP = false(size(nx));
                if mavValueIdx<7 || mavValueIdx>length(PeakMaskP)-6
                    mavValueIdx = round(length(PeakMaskP)/2);
                end
                try 
                    PeakMaskP(mavValueIdx-3:mavValueIdx+4) = true;
                catch
                    display('abc');
                end
            end
            
            fitInvParab = @(p,x) p(1)*(1-(x-p(3)).^2./(p(2).^2)).^2;
            lb = [0,(xpix(end)-xpix(1))/100,xpix(1)];   % Inital (guess) parameters
            pGuess =  [max(nx),(xpix(end)-xpix(1))/20,xpix(max(find(nx==max(nx))))];
            ub =  [1.5*max(nx),(xpix(end)-xpix(1))/2,xpix(end)];
            
            optio = optimoptions('lsqcurvefit','Algorithm','trust-region-reflective','Display','off','MaxFunctionEvaluations',100);
            try
                [parabX,~,residP,~,~,~,J] = lsqcurvefit(fitInvParab,pGuess,xpix(PeakMaskP),nx(PeakMaskP),lb,ub,optio);
            catch
                fprintf('fit failed\n');
            end
            
            %xsum=sum(croppedODImage,1);
            %[xpix, nx] = prepareCurveData( 1:length(xsum), xsum );
            
            %Obtain good starting guesses by first fitting a pure gaussian
            fitfun = @(p,x) p(1).*exp(-(x-p(4)).^2./(2*p(3).^2))+p(2);
            parameterNames = {'amplitude','offset','width','position'};
            
            lb = [0,min(nx),(xpix(end)-xpix(1))/100,xpix(1)];   % Inital (guess) parameters
            pGuess =  [max(nx),0,(xpix(end)-xpix(1))/20,xpix(max(find(nx==max(nx))))];
            ub =  [1.5*max(nx),0.5*max(nx),(xpix(end)-xpix(1))/2,xpix(end)];
            
            optio = optimoptions('lsqcurvefit','Algorithm','trust-region-reflective','Display','off','MaxFunctionEvaluations',100);
            [ggx,~,residG,~,~,~,J] = lsqcurvefit(fitfun,pGuess,xpix,nx,lb,ub,optio);
            %ci = nlparci(param,residuals,'jacobian',J,'alpha',1-0.68);
            
            %plot initial guess
%             figure(103),clf;
%             plot(xpix,nx);
%             hold on
%             
%             plot(xpix,fitfun(ggx,xpix),'LineWidth',2);
%             plot(xpix(PeakMaskP),fitInvParab(parabX,xpix(PeakMaskP)),'LineWidth',2);
%             hold off

            %Do x-integrated bimodal fit
            ft = fittype( 'aT*aBEC*exp(-(x-xT)^2/((wTherm)^2))+aBEC*heaviside((1-(x-x0)^2/(wBEC)^2))*((1-(x-x0)^2/(wBEC)^2)).^2+c',...
                'independent', 'x', 'dependent', 'y' );
            parameterNames = {'Amp BEC', 'Amp Therm:BEC ratio','Offset','BEC ratio width','Therm width','xBEC','xTherm'};
            %ampBEC, ampTherm,  wBEC, wTherm,x0
            %The half-length of the condensate is BECwidth
            opts=fitoptions('Method','NonlinearLeastSquares');
            opts.Display = 'Off';

            opts.Lower =        [0,         0,   min(nx),    0.5*parabX(2),    0.1*parabX(2),  parabX(3)-parabX(2),parabX(3)-parabX(2)];
            opts.StartPoint =   [parabX(1),  0.1,abs(ggx(2)),1.0*parabX(2),    2.0*parabX(2),  parabX(3),          parabX(3)];
            
            %opts.StartPoint =   [0.047,  0.06,    0,0.5,    10*4,    abs(ggx(4)),            abs(ggx(4))];
            opts.Upper =        [max(2*abs(parabX(1)),1),  5,max(nx),     2*parabX(2),      5*parabX(2),  parabX(3)+parabX(2),parabX(3)+parabX(2)];
            

            % Fit model to data.
            [fitresult] = fit( xpix, nx, ft, opts );
            xparam=coeffvalues(fitresult);
            xci=confint(fitresult); %confidence interval
            
%             % Plot fit with data.
%             figure(7771);clf; hold on;
%             plot( fitresult, xpix, nx ,'.');
            
            
            % inv parab to peak fit:
            [maxValue,mavValueIdx] = max(ny);
            PeakMaskP = ny>0.4*maxValue;
            if(sum(PeakMaskP)<10)
                if mavValueIdx<7 || mavValueIdx>length(PeakMaskP)-6
                    mavValueIdx = round(length(PeakMaskP)/2);
                end
                PeakMaskP(mavValueIdx-4:mavValueIdx+4) = true;
            end
            
            
            fitInvParab = @(p,x) p(1)*(1-(x-p(3)).^2./(p(2).^2)).^2;
            lb = [0,(ypix(end)-ypix(1))/100,ypix(1)];   % Inital (guess) parameters
            pGuess =  [max(ny),(ypix(end)-ypix(1))/20,ypix(max(find(ny==max(ny))))];
            ub =  [1.5*max(ny),(ypix(end)-ypix(1))/2,ypix(end)];
            
            optio = optimoptions('lsqcurvefit','Algorithm','trust-region-reflective','Display','off','MaxFunctionEvaluations',100);
            try
                [parabY,~,residP,~,~,~,J] = lsqcurvefit(fitInvParab,pGuess,ypix(PeakMaskP),ny(PeakMaskP),lb,ub,optio);
            catch
                display('ohoh')
            end
            
            %ysum=sum(croppedODImage,2);
            %[ypix, ny] = prepareCurveData( 1:length(ysum), ysum' );
            
            %Y axis: Obtain good starting guesses by first fitting a pure gaussian
            
            fitfun = @(p,x) p(1).*exp(-(x-p(4)).^2./(2*p(3).^2))+p(2);
%             parameterNames = {'amplitude','offset','width','position'};
            
            lb = [0,min(ny),(ypix(end)-ypix(1))/100,ypix(1)];   % Inital (guess) parameters
            pGuess =  [max(ny),0,(ypix(end)-ypix(1))/20,ypix(max(find(ny==max(ny))))];
            ub =  [1.5*max(ny),0.5*max(ny),(ypix(end)-ypix(1))/2,ypix(end)];
            
            optio = optimoptions('lsqcurvefit','Algorithm','trust-region-reflective','Display','off','MaxFunctionEvaluations',100);
            [gg,~,residuals,~,~,~,J] = lsqcurvefit(fitfun,pGuess,ypix,ny,lb,ub,optio);
            %ci = nlparci(param,residuals,'jacobian',J,'alpha',1-0.68);
            
            
%             figure(102),clf;
%             plot(ypix,ny);
%             hold on
%             
%             plot(ypix,fitfun(gg,ypix),'LineWidth',2);
%             plot(ypix(PeakMaskP),fitInvParab(parabY,ypix(PeakMaskP)),'LineWidth',2);
%             hold off
            
            %Do y-integrated bimodal fit
            
            
            opts.Lower =        [0,         0,   min(ny),    0.5*parabY(2),    0.1*parabY(2),  parabY(3)-parabY(2),parabY(3)-parabY(2)];
            opts.StartPoint =   [parabY(1),  0.1,abs(gg(2)),1.0*parabY(2),    2.0*parabY(2),  parabY(3),          parabY(3)];
            opts.Upper =        [max(0.1,2*abs(parabY(1))),  5,max(ny),     2*parabY(2),      5*parabY(2),  parabY(3)+parabY(2),parabY(3)+parabY(2)];
            
            
            % Fit model to data.
            try
                [fitresult] = fit( ypix, ny, ft, opts );
            catch
                display('ohoh');
            end
            yparam=coeffvalues(fitresult);
            yci=confint(fitresult); %confidence interval
            
            if plotting
            % % Plot fit with data.
                figure(777); hold on;
                plot( fitresult, ypix, ny ,'g.');
                xleg=strcat('aBEC = ',num2str(xparam(1),2),', aT=',num2str(xparam(2),2),...
                    ' c= ', num2str(xparam(3),2),', wBEC =',num2str(xparam(4),2), ' wT = ', ...
                    num2str(xparam(5),2), ', xBEC= ', num2str(xparam(6),2), ', xT= ',num2str(xparam(7),2)) ;
                yleg=strcat('aBEC = ',num2str(yparam(1),2),', aT=',num2str(yparam(2),2),...
                    ' c= ', num2str(yparam(3),2),', wBEC =',num2str(yparam(4),2), ' wT = ', ...
                    num2str(yparam(5),2), ', xBEC= ', num2str(yparam(6),2), ', xT= ',num2str(yparam(7),2));
                legend( 'xdata',xleg,'ydata',yleg );
                hold off;
                drawnow;
            end
            
            this.analysis.fitBimodal.parameterNames(analyzeIdx,:)  = parameterNames;
            this.analysis.fitBimodal.xparam(analyzeIdx,:)           = xparam;
            this.analysis.fitBimodal.yparam(analyzeIdx,:)           = yparam;
            this.analysis.fitBimodal.xci(analyzeIdx,:,:)            = xci;
            this.analysis.fitBimodal.yci(analyzeIdx,:,:)            = yci;
            
            
        end
        
        function fitBimodalExcludeCenter(this,currentImageIdx,varargin)
            p = inputParser;
            
            p.addParameter('BlackedOutODthreshold',3.5);
            p.addParameter('BlackedOutODthresholdX',NaN);
            p.addParameter('testing',false);
            p.addParameter('TFradii',5*[4,1,1]);
            p.addParameter('GaussSigma',10*[4,1,1]);
            p.addParameter('nBECnTherm',0.2);
            p.addParameter('noisePercent',0.05);
            p.addParameter('TFcut',1);
            p.addParameter('useLineDensity',false);
            p.addParameter('savePlottingInfo',true);
            p.parse(varargin{:});
            testing                 = p.Results.testing;
            TFradii                 = p.Results.TFradii;
            GaussSigma              = p.Results.GaussSigma;
            nBECnTherm              = p.Results.nBECnTherm;
            noisePercent            = p.Results.noisePercent;
            BlackedOutODthreshold   = p.Results.BlackedOutODthreshold;
            BlackedOutODthresholdX  = p.Results.BlackedOutODthresholdX;
            TFcut                   = p.Results.TFcut;
            useLineDensity          = p.Results.useLineDensity;
            savePlottingInfo          = p.Results.savePlottingInfo;
            
            if isnan(BlackedOutODthresholdX)
                BlackedOutODthresholdX = BlackedOutODthreshold;
            end
            
            if testing
                currentImageIdx = 1;
                analyzeIdx = 1;
                BEC=@(x,y,z) 15/(8*pi*TFradii(1)*TFradii(2)*TFradii(3))*(1-x.^2/TFradii(1)^2-y.^2/TFradii(2)^2-z.^2/TFradii(3)^2).*heaviside(1-x.^2/TFradii(1)^2-y.^2/TFradii(2)^2-z.^2/TFradii(3)^2);
                
                Therm=@(x,y,z) 1/(GaussSigma(1)*GaussSigma(2)*GaussSigma(3)*pi^1.5)*exp(-x.^2/GaussSigma(1)^2-y.^2/GaussSigma(2)^2-z.^2/GaussSigma(3)^2);
                
                Combined = @(x,y,z) BEC(x,y,z)+nBECnTherm*Therm(x,y,z);
                
                extrasigma = 4;
                xCoords = -extrasigma*max(GaussSigma(1),TFradii(1)):1:extrasigma*max(GaussSigma(1),TFradii(1));
                yCoords = -extrasigma*max(GaussSigma(2),TFradii(2)):1:extrasigma*max(GaussSigma(2),TFradii(3));
                zCoords = -extrasigma*max(GaussSigma(3),TFradii(3)):1:extrasigma*max(GaussSigma(2),TFradii(3));
                
                [XCoords,YCoords,ZCoords] = meshgrid(xCoords,yCoords,zCoords);   
                
                simulatedColumnDensity = sum(100*Combined(XCoords,YCoords,ZCoords),3);
                ysum=sum(simulatedColumnDensity,2);
                xsum=sum(simulatedColumnDensity,1);
                
                ysum=ysum+noisePercent.*ysum.*randn(length(yCoords'),1)+noisePercent./10.*max(ysum).*randn(length(yCoords'),1);
                xsum=xsum+noisePercent.*xsum.*randn(1,length(xCoords))+noisePercent./10.*max(xsum).*randn(1,length(xCoords));
                
                [xpix, nx] = prepareCurveData( xCoords, xsum );
                [ypix, ny] = prepareCurveData( yCoords, ysum' );
                
                
                
            else
                %Identical to FitBimodal, but the gaussian wings are fitted
                %while excluding the central (blacked out) portions
                if strcmp(currentImageIdx,'last')
                    currentImageIdx = length(this.images.ODImages(:,1,1));
                    analyzeIdx = length(this.parameters);
                elseif this.settings.storeImages
                    analyzeIdx = currentImageIdx;
                else
                    currentImageIdx = 1;
                    analyzeIdx = length(this.parameters);
                end
                if strcmp(this.settings.plotImage,'original')
                    croppedODImage = squeeze(this.images.ODImages(currentImageIdx,:,:));
                elseif strcmp(this.settings.plotImage,'averaged')
                    croppedODImage = squeeze(this.images.ODImagesAveraged(currentImageIdx,:,:));
                elseif strcmp(this.settings.plotImage,'filtered')
                    croppedODImage = squeeze(this.images.ODImagesFiltered(currentImageIdx,:,:));
                end
                croppedODImageNoBlackedOut = croppedODImage;
                croppedODImageTemp = croppedODImage;
                
                if(~isnan(BlackedOutODthresholdX))
                    ODmask = croppedODImage>BlackedOutODthresholdX;
                    croppedODImage(ODmask) = NaN;
                end
                
                if useLineDensity
                    
                    this.images.ODImages(currentImageIdx,:,:) = croppedODImage;
                    this.createLineDensities();
                    ysum = this.lineDensities.Xintegrated(end,:);
                    xsum = this.lineDensities.Yintegrated(end,:);
                    
                    ODmask = ysum>BlackedOutODthresholdX;
                    ysum(ODmask) = NaN;
                    
                    ODmask = xsum>BlackedOutODthresholdX;
                    xsum(ODmask) = NaN;
                else
                    ysum=sum(croppedODImage,2);
                    xsum=sum(croppedODImage,1);
                end
                [xpix, nx] = prepareCurveData( 1:length(xsum), xsum );
                [ypix, ny] = prepareCurveData( 1:length(ysum), ysum' );
                
                if~isnan(BlackedOutODthreshold)
                    ODmask = croppedODImageTemp>BlackedOutODthreshold;
                    croppedODImageTemp(ODmask) = NaN;
                end
                
            end
            

                
            parameterNames = {'Amp BEC', 'Amp Therm:BEC ratio','Offset','BEC ratio width','Therm width','xBEC','xTherm'};
            
                this.fitBimodal(currentImageIdx,'testing',testing,'TFradii',TFradii,'GaussSigma',GaussSigma,...
                            'nBECnTherm',nBECnTherm,'noisePercent',noisePercent,'BlackedOutODthreshold',...
                            BlackedOutODthreshold,'useLineDensity',useLineDensity);
            try
                thermAmp = this.analysis.fitBimodal.xparam(analyzeIdx,1)*this.analysis.fitBimodal.xparam(analyzeIdx,2);
            catch
                display('ohoh')
            end
            offset = this.analysis.fitBimodal.xparam(analyzeIdx,3);
            thermWidth = this.analysis.fitBimodal.xparam(analyzeIdx,5);
            thermPos = this.analysis.fitBimodal.xparam(analyzeIdx,7);
            BECPos = this.analysis.fitBimodal.xparam(analyzeIdx,6);
            BECWidth = this.analysis.fitBimodal.xparam(analyzeIdx,4);
            BECAmp = this.analysis.fitBimodal.xparam(analyzeIdx,1);
            
            fitfun = @(p,x) p(1).*exp(-(x-p(4)).^2./(p(3).^2))+p(2);
            parameterNames = {'amplitude','offset','width','position'};
            %fit wings with pure gaussian
            lb      = [0.5*thermAmp,-2*abs(offset),1.0*BECWidth,max(thermPos-0.2*BECWidth,1)];  
            pGuess  = [1.0*thermAmp,1.0*offset    ,2.0*BECWidth,thermPos];
            ub      = [2.0*thermAmp,+2*abs(offset),5.0*BECWidth,min(thermPos+0.2*BECWidth,xpix(end))];
            
            PeakMaskX = (xpix>BECPos+TFcut*BECWidth | xpix < BECPos-TFcut*BECWidth);
            if(sum(PeakMaskX)<10)
                PeakMaskX(1:5) = true;
                PeakMaskX(end-5:end) = true;
            end
            
            optio = optimoptions('lsqcurvefit','Algorithm','trust-region-reflective','Display','off','MaxFunctionEvaluations',100);
            [GaussianWingsX,~,residuals,~,~,~,J] = lsqcurvefit(fitfun,pGuess,xpix(PeakMaskX),nx(PeakMaskX),lb,ub,optio);
            if(isempty(residuals))
                GaussianWingsXci = NaN(4,2);
            else
                GaussianWingsXci = nlparci(GaussianWingsX,residuals,'jacobian',J,'alpha',1-0.68);
            end
            this.printFitReport(parameterNames,GaussianWingsX,GaussianWingsXci);
            
            
            %fit bimodal with only BEC variable
            fitfunBimodX = @(p,x) GaussianWingsX(1).*exp(-(x-GaussianWingsX(4)).^2/(GaussianWingsX(3).^2))+p(1).*heaviside((1-(x-p(3)).^2./(p(2))^2)).*((1-(x-p(3)).^2./(p(2)).^2)).^2+GaussianWingsX(2);
            parameterNames = {'amplitude','width','position'};
            
            lb      = [0.5*BECAmp,0.5*BECWidth,BECPos-0.5*BECWidth];   % Inital (guess) parameters
            pGuess  = [1.0*BECAmp,1.0*BECWidth,1.0*BECPos];
            ub      = [2.0*BECAmp,2.0*BECWidth,BECPos+0.5*BECWidth];
            
            optio = optimoptions('lsqcurvefit','Algorithm','trust-region-reflective','Display','off','MaxFunctionEvaluations',100);
            [xparam,~,residuals,~,~,~,J] = lsqcurvefit(fitfunBimodX,pGuess,xpix,nx,lb,ub,optio);
            if(isempty(residuals))
                xci = NaN(4,2);
            else
                xci = nlparci(xparam,residuals,'jacobian',J,'alpha',1-0.68,'alpha',1-0.68);
            end
            this.printFitReport(parameterNames,xparam,xci);
            
            if this.settings.plotOD
                figure(810),clf;
                subplot(1,2,1);
                plot(xpix(PeakMaskX),nx(PeakMaskX),'.','MarkerSize',20);
                hold on
                plot(xpix(~PeakMaskX),nx(~PeakMaskX),'.','MarkerSize',20);
                plot(xpix(1):xpix(end),fitfun(GaussianWingsX,xpix(1):xpix(end)),'LineWidth',2);
                plot(xpix(1):xpix(end),fitfunBimodX(xparam,xpix(1):xpix(end)),'LineWidth',2);

                plot([xparam(3)-xparam(2),xparam(3)-xparam(2)],get(gca,'YLim' ),'k--','LineWidth',1);
                plot([xparam(3)+xparam(2),xparam(3)+xparam(2)],get(gca,'YLim' ),'k--','LineWidth',1);
                hold off
                % % Plot fit with data.

                ylabel('Amp');xlabel('x');
                xleg={strcat('aBEC = ',num2str(xparam(1),2),', aT=',num2str(GaussianWingsX(1),2),...
                     ' c= ', num2str(GaussianWingsX(2),2)),strcat('wBEC =',num2str(xparam(2),2), ' wT = ', ...
                     num2str(GaussianWingsX(3),2), ', xBEC= ', num2str(xparam(3),2), ', xT= ',num2str(GaussianWingsX(4),2))} ;           
                title(xleg);
            end
            
            %calculate COM
            offsetCorrectedValues = nx-GaussianWingsX(2);
            this.analysis.COMX(analyzeIdx) = sum(offsetCorrectedValues.*xpix)./sum(offsetCorrectedValues);
            
            figure(771),clf;
            set(gcf,'color','w');
            subplot(3,3,[1,2,4,5]);
                imagesc(croppedODImageNoBlackedOut);
                colormap(flipud(bone));
                hold on
                l = plot(this.settings.LineDensityPixelAveraging*[xparam(3)-xparam(2),xparam(3)-xparam(2)],get(gca,'YLim' ),'k--','LineWidth',1);
                set(l,'ZData',[5,5]);
                l = plot(this.settings.LineDensityPixelAveraging*[xparam(3)+xparam(2),xparam(3)+xparam(2)],get(gca,'YLim' ),'k--','LineWidth',1);
                set(l,'ZData',[5,5]);
                hold off
                axis equal
            subplot(3,3,[7,8])
                plot(xpix,nx,'.','MarkerSize',20);
                hold on
                plot(xpix(~PeakMaskX),nx(~PeakMaskX),'.','MarkerSize',20);
                plot(xpix(1):xpix(end),fitfun(GaussianWingsX,xpix(1):xpix(end)),'LineWidth',2);
                plot(xpix(1):xpix(end),fitfunBimodX(xparam,xpix(1):xpix(end)),'LineWidth',2);
                plot([xparam(3)-xparam(2),xparam(3)-xparam(2)],get(gca,'YLim' ),'k--','LineWidth',1);
                plot([xparam(3)+xparam(2),xparam(3)+xparam(2)],get(gca,'YLim' ),'k--','LineWidth',1);
                hold off
                ylabel('Amplitude');xlabel(['x (pixel) TF_x = ' num2str(xparam(2),3)]);
                try
                    ylim([-0.01*abs(max(fitfunBimodX(xparam,xpix(1):xpix(end)))),1.2*abs(max(fitfunBimodX(xparam,xpix(1):xpix(end))))]);
                catch
                    display('something wrong')
                end
                box on
                
            
            %same for y 
            
            thermAmp = this.analysis.fitBimodal.yparam(analyzeIdx,1)*this.analysis.fitBimodal.yparam(analyzeIdx,2);
            offset = this.analysis.fitBimodal.yparam(analyzeIdx,3);
            thermWidth = this.analysis.fitBimodal.yparam(analyzeIdx,5);
            thermPos = this.analysis.fitBimodal.yparam(analyzeIdx,7);
            BECPos = this.analysis.fitBimodal.yparam(analyzeIdx,6);
            BECWidth = this.analysis.fitBimodal.yparam(analyzeIdx,4);
            BECAmp = this.analysis.fitBimodal.yparam(analyzeIdx,1);
            
            fitfun = @(p,x) p(1).*exp(-(x-p(4)).^2./(p(3).^2))+p(2);
            parameterNames = {'amplitude','offset','width','position'};
            %fit wings with pure gaussian
            lb      = [0.5*thermAmp,-2*abs(offset),1.0*BECWidth,max(1,thermPos-0.2*BECWidth)];  
            pGuess  = [1.0*thermAmp,1.0*offset    ,2.0*BECWidth,thermPos];
            ub      = [2.0*thermAmp,+2*abs(offset),4.0*BECWidth,min(ypix(end),thermPos+0.2*BECWidth)];
            
            
            PeakMaskY = (ypix>BECPos+TFcut*BECWidth | ypix < BECPos-TFcut*BECWidth);
            if(sum(PeakMaskY)<4)
                PeakMaskY(1:5) = true;
                PeakMaskY(end-4:end) = true;
            end
            
            optio = optimoptions('lsqcurvefit','Algorithm','trust-region-reflective','Display','off','MaxFunctionEvaluations',100);
            try
                [GaussianWingsY,~,residuals,~,~,~,J] = lsqcurvefit(fitfun,pGuess,ypix(PeakMaskY),ny(PeakMaskY),lb,ub,optio);
            catch
                display('abc');
            end
            if(isempty(residuals))
                GaussianWingsYci = NaN(4,2);
            else
                GaussianWingsYci = nlparci(GaussianWingsY,residuals,'jacobian',J,'alpha',1-0.68);
            end
            this.printFitReport(parameterNames,GaussianWingsY,GaussianWingsYci);
           
            
            %fit bimodal with only BEC variable
            fitfunBimodY = @(p,x) GaussianWingsY(1).*exp(-(x-GaussianWingsY(4)).^2/(GaussianWingsY(3).^2))+p(1).*heaviside((1-(x-p(3)).^2./(p(2))^2)).*((1-(x-p(3)).^2./(p(2)).^2)).^2+GaussianWingsY(2);
            parameterNames = {'amplitude','width','position'};
            
            
            lb      = [0.5*BECAmp,0.5*BECWidth,BECPos-0.5*BECWidth];   % Inital (guess) parameters
            pGuess  = [1.0*BECAmp,1.0*BECWidth,1.0*BECPos];
            ub      = [2.0*BECAmp,2.0*BECWidth,BECPos+0.5*BECWidth];
            
            
            optio = optimoptions('lsqcurvefit','Algorithm','trust-region-reflective','Display','off','MaxFunctionEvaluations',100);
            [yparam,~,residuals,~,~,~,J] = lsqcurvefit(fitfunBimodY,pGuess,ypix,ny,lb,ub,optio);
            if(isempty(residuals))
                yci = NaN(4,2);
            else
                yci = nlparci(yparam,residuals,'jacobian',J,'alpha',1-0.68);
            end
            this.printFitReport(parameterNames,yparam,yci);
            
            if this.settings.plotOD
                figure(810);
                subplot(1,2,2);
                plot(ypix(PeakMaskY),ny(PeakMaskY),'.','MarkerSize',20);
                hold on
                plot(ypix(~PeakMaskY),ny(~PeakMaskY),'.','MarkerSize',20);
                plot(ypix(1):ypix(end),fitfun(GaussianWingsY,ypix(1):ypix(end)),'LineWidth',2);
                plot(ypix(1):ypix(end),fitfunBimodY(yparam,ypix(1):ypix(end)),'LineWidth',2);
                plot([yparam(3)-yparam(2),yparam(3)-yparam(2)],get(gca,'YLim' ),'k--','LineWidth',1);
                plot([yparam(3)+yparam(2),yparam(3)+yparam(2)],get(gca,'YLim' ),'k--','LineWidth',1);
                hold off
                % % Plot fit with data.
                ylabel('Amp');xlabel('y');
                yleg={strcat('aBEC = ',num2str(yparam(1),2),', aT=',num2str(GaussianWingsY(1),2),...
                     ' c= ', num2str(GaussianWingsY(2),2)),strcat('wBEC =',num2str(yparam(2),2), ' wT = ', ...
                     num2str(GaussianWingsY(3),2), ', xBEC= ', num2str(yparam(3),2), ', xT= ',num2str(GaussianWingsY(4),2))} ;           
                title(yleg);
            end
           
            %calculate COM
            offsetCorrectedValues = ny-GaussianWingsY(2);
            this.analysis.COMY(analyzeIdx) = sum(offsetCorrectedValues.*ypix)./sum(offsetCorrectedValues);
            
            figure(771);
            subplot(3,3,[1,2,4,5]);
                hold on
                l = plot(get(gca,'XLim'),this.settings.LineDensityPixelAveraging* [yparam(3)-yparam(2),yparam(3)-yparam(2)],'k--','LineWidth',1);
                set(l,'ZData',[5,5]);
                l = plot(get(gca,'XLim' ),this.settings.LineDensityPixelAveraging*[yparam(3)+yparam(2),yparam(3)+yparam(2)],'k--','LineWidth',1);
                set(l,'ZData',[5,5]);
                hold off
            subplot(3,3,[3,6])
                plot(ny,ypix,'.','MarkerSize',20);
                hold on
                plot(ny(~PeakMaskY),ypix(~PeakMaskY),'.','MarkerSize',20);
                plot(fitfun(GaussianWingsY,ypix(1):ypix(end)),ypix(1):ypix(end),'LineWidth',2);
                plot(fitfunBimodY(yparam,ypix(1):ypix(end)),ypix(1):ypix(end),'LineWidth',2);
                plot(get(gca,'XLim'),[yparam(3)-yparam(2),yparam(3)-yparam(2)],'k--','LineWidth',1);
                plot(get(gca,'XLim'),[yparam(3)+yparam(2),yparam(3)+yparam(2)],'k--','LineWidth',1);
                hold off
                set(gca,'XDir','reverse');
                set(gca,'YDir','reverse');
                set(gca, 'YAxisLocation', 'right')
                xlabel('Amplitude');ylabel(['y (pixel) TF_y = ' num2str(yparam(2),3)]);
                xlim([-0.01*abs(max(fitfunBimodY(yparam,ypix(1):ypix(end)))),1.2*abs(max(fitfunBimodY(yparam,ypix(1):ypix(end))))]);
                box on
            
            drawnow;
            
            this.analysis.fitBimodalExcludeCenter.ODimage                           = croppedODImageNoBlackedOut;
            this.analysis.fitBimodalExcludeCenter.parameterNames(analyzeIdx,:)      = parameterNames;
            
            
            this.analysis.fitBimodalExcludeCenter.xparam(analyzeIdx,:)              = xparam;
            this.analysis.fitBimodalExcludeCenter.yparam(analyzeIdx,:)              = yparam;
            this.analysis.fitBimodalExcludeCenter.xci(analyzeIdx,:,:)               = xci;
            this.analysis.fitBimodalExcludeCenter.yci(analyzeIdx,:,:)               = yci;
            this.analysis.fitBimodalExcludeCenter.GaussianWingsX(analyzeIdx,:)      = GaussianWingsX;
            this.analysis.fitBimodalExcludeCenter.GaussianWingsY(analyzeIdx,:)      = GaussianWingsY;
            this.analysis.fitBimodalExcludeCenter.GaussianWingsXci(analyzeIdx,:,:)  = GaussianWingsXci;
            this.analysis.fitBimodalExcludeCenter.GaussianWingsYci(analyzeIdx,:,:)  = GaussianWingsYci;
            
            
            if savePlottingInfo
                this.analysis.fitBimodalExcludeCenter.GaussianFun                       = fitfun;
                this.analysis.fitBimodalExcludeCenter.BimodalFunX                       = fitfunBimodX;
                this.analysis.fitBimodalExcludeCenter.BimodalFunY                       = fitfunBimodY;
                this.analysis.fitBimodalExcludeCenter.PeakMaskX(analyzeIdx,:)           = PeakMaskX;
                this.analysis.fitBimodalExcludeCenter.PeakMaskY(analyzeIdx,:)           = PeakMaskY;
                this.analysis.fitBimodalExcludeCenter.xpix(analyzeIdx,:)                = xpix;
                this.analysis.fitBimodalExcludeCenter.nx(analyzeIdx,:)                  = nx;
                this.analysis.fitBimodalExcludeCenter.ypix(analyzeIdx,:)                = ypix;
                this.analysis.fitBimodalExcludeCenter.ny(analyzeIdx,:)                  = ny;
            end
        end
        
        
        
        function fitFermi1D(this,currentImageIdx,varargin)
            %fits fermi dirac 1D distribution to line density.  Optional
            %input of the starting position of the logarithm of the fugacity.
            p = inputParser;
            p.addParameter('logfugacity',1);
            p.parse(varargin{:});
            logfugacity                 = p.Results.logfugacity;
            if strcmp(currentImageIdx,'last')
                currentImageIdx = length(this.images.ODImages(:,1,1));
                analyzeIdx = length(this.parameters);
            elseif this.settings.storeImages
                analyzeIdx = currentImageIdx;
            else
                currentImageIdx = 1;
                analyzeIdx = length(this.parameters);
            end
            
            croppedODImage = squeeze(this.images.ODImages(currentImageIdx,:,:));

            %Following pg 69 of the Fermi Varenna notes
            f1 = @(s)(1+s)./s.*log(1+s);
            fitfun = @(p,x) real(p(1)+p(2)*PolyLog(2.5,-exp(p(5)-(x-p(3)).^2./p(4)^2*f1(exp(p(5)))))/PolyLog(2.5,-exp(p(5))));
            parameterNames = {'Offset 1','Amplitude 2','Center 3','Width 4','q= mu*beta 5'};
            
            %use line density (log of sum) instead of sum of log
            if  ~isempty(this.lineDensities.Yintegrated)
                integratedAlongX = this.lineDensities.Xintegrated(end,:);
                integratedAlongY = this.lineDensities.Yintegrated(end,:);
            else
                integratedAlongX=sum(croppedODImage,2);
                integratedAlongY=sum(croppedODImage,1);
            end

            xcoords = 1:length(integratedAlongY);
            ycoords = 1:length(integratedAlongX);
            
            
            % use gaussian init guess with width modified to 50%
% %             pGuess=[integratedAlongY(1), max(integratedAlongY),...
% %                 this.analysis.fitIntegratedGaussX.param(analyzeIdx,3),1.5*this.analysis.fitIntegratedGaussX.param(analyzeIdx,4),logfugacity];
            pGuess=[integratedAlongY(1), .8*max(integratedAlongY),...
                this.analysis.fitIntegratedGaussX.param(analyzeIdx,3),1.5*this.analysis.fitIntegratedGaussX.param(analyzeIdx,4),logfugacity];
            lb = [min(integratedAlongY),.5*max(integratedAlongY),0,0, -10];
            ub = [mean(integratedAlongY),1.5*max(integratedAlongY),this.settings.marqueeBox(3),this.settings.marqueeBox(3), 10];

            opts = optimoptions('lsqcurvefit','Algorithm','trust-region-reflective','Display','off','MaxFunctionEvaluations',1000);
            [param,~,residX,~,~,~,J] = lsqcurvefit(fitfun,pGuess,xcoords,integratedAlongY,lb,ub,opts);
            try
                ci = nlparci(param,residuals,'jacobian',J,'alpha',1-0.68);
            catch
                disp('ci not possible');
                ci=-1*ones(size(5,2));
            end
            %this.printFitReport(parameterNames,param,ci);
            this.analysis.fitFermiX.parameterNames(analyzeIdx,:)  = parameterNames;
            this.analysis.fitFermiX.param(analyzeIdx,:)           = param;
            this.analysis.fitFermiX.ci(currentImageIdx,:,:)            = ci;
            this.analysis.fitFermiXToverTf(analyzeIdx,:)         =(-6*PolyLog(3,-exp(param(5))))^(-1/3);


            %try gaussian init cond

            pGuess=[integratedAlongX(1), .8*max(integratedAlongX),...
            this.analysis.fitIntegratedGaussY.param(analyzeIdx,3),1.5*this.analysis.fitIntegratedGaussY.param(analyzeIdx,4),logfugacity];
            lb = [min(integratedAlongX),.5*max(integratedAlongX),0,0,-10];
            ub = [mean(integratedAlongX),1.5*max(integratedAlongX),this.settings.marqueeBox(4),this.settings.marqueeBox(4),10];

            opts = optimoptions('lsqcurvefit','Algorithm','trust-region-reflective','Display','off','MaxFunctionEvaluations',1000);
            [param,~,residuals,~,~,~,J] = lsqcurvefit(fitfun,pGuess,ycoords,integratedAlongX,lb,ub,opts);
            try
                ci = nlparci(param,residuals,'jacobian',J,'alpha',1-0.68);
            catch
                disp('ci not possible');
                ci=-1*ones(size(5,2));
            end
            
            %this.printFitReport(parameterNames,param,ci);
            this.analysis.fitFermiY.parameterNames(analyzeIdx,:)  = parameterNames;
            this.analysis.fitFermiY.param(analyzeIdx,:)           = param;
            this.analysis.fitFermiY.ci(currentImageIdx,:,:)            = ci;
            this.analysis.fitFermiYToverTf(analyzeIdx,:)         =(-6*PolyLog(3,-exp(param(5))))^(-1/3);
            figure(819);
            clf;
            subplot(2,2,1);
            plot(xcoords,fitfun(this.analysis.fitFermiX.param(analyzeIdx,:),xcoords),'LineWidth',1.5);
            ylim([1.2*min(min(integratedAlongX),min(integratedAlongY)),1.2*max(max(integratedAlongX),max(integratedAlongY))]);
            hold on
            plot(xcoords,integratedAlongY,'LineWidth',1.5);
            title(num2str(this.analysis.fitFermiX.param(analyzeIdx,:),3));
            legend(num2str(this.analysis.fitFermiXToverTf(analyzeIdx)));
            subplot(2,2,3);
            plot(xcoords,residX);
            title(strcat('\Sigma r^2/N = ', num2str(sum(residX.^2)/length(xcoords),3)));
            xlabel('x coord pix');
            ylabel('residuals');
            
            
            %testing
% %             if analyzeIdx>8
% %                 disp('test');
% %             end
            hold off
            subplot(2,2,2);
            plot(ycoords,fitfun(this.analysis.fitFermiY.param(analyzeIdx,:),ycoords),'LineWidth',1.5);
            ylim([1.2*min(min(integratedAlongX),min(integratedAlongY)),1.2*max(max(integratedAlongX),max(integratedAlongY))]);
            hold on
            plot(ycoords,integratedAlongX,'LineWidth',1.5);
            title(num2str(this.analysis.fitFermiY.param(analyzeIdx,:)));
            legend(num2str(this.analysis.fitFermiYToverTf(analyzeIdx)));
            ylabel('Y');
            subplot(2,2,4);
            plot(ycoords,residuals);
            title(strcat('\Sigma r^2/N = ', num2str(sum(residuals.^2)/length(ycoords),3)));
            ylabel('residuals');
            xlabel('y coord pix');
            hold off
            drawnow;
        end
        
        function fitIntegratedGaussian(this,currentImageIdx,varargin)
            p = inputParser;
            p.addParameter('BlackedOutODthreshold',NaN);
            p.addParameter('LowODthreshold',NaN);
            p.addParameter('useLineDensity',true);
            p.addParameter('guessXWidthPix',[]);
            p.addParameter('guessYWidthPix',[]);
            p.addParameter('fitX',true);
            p.addParameter('fitY',true);
            p.addParameter('getFWHM',true);
            

            p.parse(varargin{:});
            BlackedOutODthreshold   = p.Results.BlackedOutODthreshold;
            LowODthreshold          = p.Results.LowODthreshold;
            useLineDensity          = p.Results.useLineDensity;
            guessXWidthPix          = p.Results.guessXWidthPix;
            guessYWidthPix          = p.Results.guessYWidthPix;
            fitX                    = p.Results.fitX;
            fitY                    = p.Results.fitY;
            getFWHM                 = p.Results.getFWHM;
            
            if strcmp(currentImageIdx,'last')
                currentImageIdx = length(this.images.ODImages(:,1,1));
                analyzeIdx = length(this.parameters);
            elseif this.settings.storeImages
                analyzeIdx = currentImageIdx;
            else
                currentImageIdx = 1;
                analyzeIdx = length(this.parameters);
            end
            if strcmp(this.settings.plotImage,'original')
                croppedODImage = squeeze(this.images.ODImages(currentImageIdx,:,:));
            elseif strcmp(this.settings.plotImage,'filtered')
                croppedODImage = squeeze(this.images.ODImagesFiltered(currentImageIdx,:,:));
                croppedODImage=croppedODImage/this.settings.superSamplingFactor;
                
            elseif strcmp(this.settings.plotImage,'averaged')
                croppedODImage = squeeze(this.images.ODImagesAveraged(currentImageIdx,:,:));
                croppedODImage=croppedODImage*this.settings.pixelAveraging;
            end
            
            
            if~isnan(BlackedOutODthreshold)
                ODmask = croppedODImage>BlackedOutODthreshold;
                croppedODImage(ODmask) = NaN;
            end
            if~isnan(LowODthreshold)
                ODmask = croppedODImage<LowODthreshold;
                croppedODImage(ODmask) = 0;
            end
            if useLineDensity
                integratedAlongX = this.lineDensities.Xintegrated(end,:);
                integratedAlongY = this.lineDensities.Yintegrated(end,:);
            else
                integratedAlongX=sum(croppedODImage,2);
                integratedAlongY=sum(croppedODImage,1);
            end
            figure(4);
            clf;
            figure(842),clf;
            xcoords = 1:length(integratedAlongY);
            ycoords = 1:length(integratedAlongX);
            [xcoords, integratedAlongY] = prepareCurveData( xcoords, integratedAlongY );
            [ycoords, integratedAlongX] = prepareCurveData( ycoords, integratedAlongX );
            this.analysis.COMX(analyzeIdx) = sum(integratedAlongY.*xcoords)./sum(integratedAlongY);
            this.analysis.COMY(analyzeIdx) = sum(integratedAlongX.*ycoords)./sum(integratedAlongX);
            
            fitfun = @(p,x) p(1)+p(2)*exp( -(x-p(3)).^2/(p(4)^2));
            parameterNames = {'Offset','Amplitude','Center','Width'};
            
            
            [maxy,idxy]=max(integratedAlongY);
            [maxx,idxx]=max(integratedAlongX);
            %estimated gaussian width by estimating location where gaussian
            %crosses 1/e *amplitude
            [~,idxY2]=min(abs(integratedAlongY-exp(-1)*maxy));
            [~,idxX2]=min(abs(integratedAlongX-exp(-1)*maxx));
            
            if fitX

                %integrated along y guesses
                pGuess = [(integratedAlongY(1)+integratedAlongY(end))/2, max(integratedAlongY),idxy,abs(idxy-idxY2)];   % Inital (guess) parameters

                ub = [mean(integratedAlongY),1.5*max(integratedAlongY),idxy+length(xcoords)/10,range(xcoords)];
                lb = [min(integratedAlongY),  (maxy-min(integratedAlongY))/2,idxy-length(xcoords)/10,abs(idxy-idxY2)/4];
                if ~isempty(guessXWidthPix)
                    pGuess(end)=guessXWidthPix;
                    ub(end)=guessXWidthPix*2;
                    lb(end)=guessXWidthPix/2;
                end
                opts = optimoptions('lsqcurvefit','Algorithm','trust-region-reflective','Display','off','MaxFunctionEvaluations',1000);
                try
                    [param,~,residuals,~,~,~,J] = lsqcurvefit(fitfun,pGuess,xcoords,integratedAlongY,lb,ub,opts);
                catch
                    residuals = [];
                    param = [NaN,NaN,NaN,NaN];
                end

                if(isempty(residuals))
                    ci = NaN(4,2);
                else
                    ci = nlparci(param,residuals,'jacobian',J,'alpha',1-0.68);
                end

                this.printFitReport(parameterNames,param,ci);
                this.analysis.fitIntegratedGaussX.parameterNames(analyzeIdx,:)  = parameterNames;
                this.analysis.fitIntegratedGaussX.param(analyzeIdx,:)           = param;
                this.analysis.fitIntegratedGaussX.ci(analyzeIdx,:,:)            = ci;
                this.analysis.fitIntegratedGaussX.fitfun                        = fitfun;
                this.analysis.fitIntegratedGaussX.xcoords                       = xcoords;
                this.analysis.fitIntegratedGaussX.integratedAlongY              = integratedAlongY;
                this.analysis.fitIntegratedGaussX.croppedODImage                = croppedODImage;
                
                %take into account supersampling on fitted length scales:
                %center and location
                if strcmp(this.settings.plotImage,'filtered')
                    this.analysis.fitIntegratedGaussX.param(analyzeIdx,3:4)=this.analysis.fitIntegratedGaussX.param(analyzeIdx,3:4)/this.settings.superSamplingFactor;
                    this.analysis.fitIntegratedGaussX.ci(analyzeIdx,3:4,:)=this.analysis.fitIntegratedGaussX.ci(analyzeIdx,3:4,:)/this.settings.superSamplingFactor;
                elseif strcmp(this.settings.plotImage,'averaged')
                    this.analysis.fitIntegratedGaussX.param(analyzeIdx,3:4)=this.analysis.fitIntegratedGaussX.param(analyzeIdx,3:4)*this.settings.pixelAveraging;
                    this.analysis.fitIntegratedGaussX.ci(analyzeIdx,3:4,:)=this.analysis.fitIntegratedGaussX.ci(analyzeIdx,3:4,:)*this.settings.pixelAveraging;

                end
                %plot fit along y-coords
                figure(4)
                subplot(1,2,1);
                plot(xcoords,fitfun(param,xcoords),'LineWidth',1.5);
                %ylim([1.2*min(min(integratedAlongX),min(integratedAlongY)),1.2*max(max(integratedAlongX),max(integratedAlongY))]);
                xlabel('x coordinate (px)');
                title(['Width: ',num2str(this.analysis.fitIntegratedGaussX.param(analyzeIdx,4),3) ' center: ' ,num2str(this.analysis.fitIntegratedGaussX.param(analyzeIdx,3),3) ]);
                hold on
                plot(xcoords,integratedAlongY,'LineWidth',1.5);
                plot([this.analysis.fitIntegratedGaussX.param(analyzeIdx,3),this.analysis.fitIntegratedGaussX .param(analyzeIdx,3)],ylim,'k','LineWidth',1.2)
                hold off
                
                if getFWHM
                    alpha = 0.68;

                    yData = this.lineDensities.Yintegrated(end,:);
                    yDataFiltered = sgolayfilt(yData,2,5);
                    yCumSum = cumsum(yDataFiltered);
                    widthArray = [0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9];
                    
                    try
                        leftCIWidth = interp1(yCumSum./max(yCumSum),1:length(yCumSum),(1-alpha)/2);
                    catch
                        leftCIWidth = 0;
                    end
                    try
                        rightCIWidth = interp1(yCumSum./max(yCumSum),1:length(yCumSum),1-(1-alpha)/2);
                    catch
                        rightCIWidth = length(yCumSum);
                    end
                        
                    peakCenter = round(this.analysis.fitIntegratedGaussX.param(analyzeIdx,3));
                    peakValue  = mean(maxk(yDataFiltered,3));
                    
                    if peakCenter<5 || peakCenter>length(yDataFiltered)-5
                        peakCenter = round(length(yDataFiltered)/2);
                    end
                    if isnan(peakCenter)
                        leftpeak = 1:round(length(yDataFiltered)/2);
                    else
                        leftPeak = yDataFiltered(1:peakCenter);
                    end
                    
                    if isnan(peakCenter)
                        rightPeak = round(length(yDataFiltered)/2):round(length(yDataFiltered));
                    else
                        rightPeak = yDataFiltered(peakCenter:end);
                    end
                    
                    mask = abs(diff(rightPeak)) <= 0.0001;
                    pixel = 1:length(rightPeak);
                    
                    for idx = 1:length(widthArray)
                        try
                            leftWidth = interp1(leftPeak,1:length(leftPeak),widthArray(idx)*peakValue);
                        catch
                            leftWidth = NaN;
                        end
                        
                        try
                            rightWidth = peakCenter-1+interp1(rightPeak(~mask),pixel(~mask),widthArray(idx)*peakValue);
                        catch
                            rightWidth = NaN;
                        end
                        fullWidth(idx) = rightWidth-leftWidth;
                        
                        if widthArray(idx) == 0.5
                            leftFWHMWidth   = leftWidth;
                            rightFWHMWidth  = rightWidth;
                            halfValue       = widthArray(idx)*peakValue;
                        end
                        
                    end
                    
                    
%                     try
%                         leftFWHMWidth = interp1(leftPeak,1:length(leftPeak),0.5*this.analysis.fitIntegratedGaussX.param(analyzeIdx,2));
%                     catch
%                         leftFWHMWidth = NaN;
%                     end
%                     
% 
%                     rightFWHMWidth = round(this.analysis.fitIntegratedGaussX.param(analyzeIdx,3))-1+interp1(rightPeak(~mask),pixel(~mask),0.5*this.analysis.fitIntegratedGaussX.param(analyzeIdx,2));
                    figure(842)
                    subplot(1,2,1)
                    plot(yData)
                    hold on
                    plot(yDataFiltered,'LineWidth',2)
                    plot(yCumSum./max(yCumSum).*max(yDataFiltered),'LineWidth',2)
                    ylimits = ylim;
                    %plot([leftCIWidth,leftCIWidth],ylimits,'k--','LineWidth',2)
                    %plot([rightCIWidth,rightCIWidth],ylimits,'k--','LineWidth',2)
                    plot([leftFWHMWidth,leftFWHMWidth],ylimits,'k-.','LineWidth',2)
                    plot([rightFWHMWidth,rightFWHMWidth],ylimits,'k-.','LineWidth',2)
                    hold off
                    legend('raw linedensity','SG filtered', 'cumulative sum')
                    title(['CI width: ' num2str(rightCIWidth-leftCIWidth,3) '   FWHM: ' num2str(rightFWHMWidth-leftFWHMWidth,3)])

                    this.analysis.widthX.CI(analyzeIdx) = rightCIWidth-leftCIWidth;
                    %this.analysis.widthX.FWHM(analyzeIdx) = rightFWHMWidth-leftFWHMWidth;
                    this.analysis.widthX.FWHM(analyzeIdx,:) = fullWidth;
                    this.analysis.widthX.widthArray(analyzeIdx,:) = widthArray;
                end
                
            end
            if fitY
            %integrated along x guesses
                pGuess = [(integratedAlongX(1)+integratedAlongX(end))/2, max(integratedAlongX),idxx,abs(idxx-idxX2)];   % Inital (guess) parameters
                lb = [min(integratedAlongX),  (maxx-min(integratedAlongX))/2,idxx-length(ycoords)/10,abs(idxx-idxX2)/4];
                ub = [mean(integratedAlongX),1.5*max(integratedAlongX),idxx+length(ycoords)/10,range(ycoords)];
                if ~isempty(guessYWidthPix)
                    pGuess(end)=guessYWidthPix;
                    ub(end)=guessYWidthPix*2;
                    lb(end)=guessYWidthPix/2;
                end
%             if length(ycoords)>10;    
                opts = optimoptions('lsqcurvefit','Algorithm','trust-region-reflective','Display','off','MaxFunctionEvaluations',1000);
                try
                    [param,~,residuals,~,~,~,J] = lsqcurvefit(fitfun,pGuess,ycoords,integratedAlongX,lb,ub,opts);
                catch
                    residuals = [];
                    param = [NaN,NaN,NaN,NaN];
                end
                if(isempty(residuals))
                    ci = NaN(4,2);
                else
                    ci = nlparci(param,residuals,'jacobian',J,'alpha',1-0.68);
                end

                this.printFitReport(parameterNames,param,ci);
                this.analysis.fitIntegratedGaussY.parameterNames(analyzeIdx,:)  = parameterNames;
                this.analysis.fitIntegratedGaussY.param(analyzeIdx,:)           = param;
                this.analysis.fitIntegratedGaussY.ci(analyzeIdx,:,:)            = ci;
                this.analysis.fitIntegratedGaussY.fitfun                        = fitfun;
                this.analysis.fitIntegratedGaussY.ycoords                       = ycoords;
                this.analysis.fitIntegratedGaussY.integratedAlongX              = integratedAlongX;
                this.analysis.fitIntegratedGaussY.croppedODImage                = croppedODImage;
                %take into account supersampling on fitted length scales:
                %center and location
                if strcmp(this.settings.plotImage,'filtered')
                    this.analysis.fitIntegratedGaussY.param(analyzeIdx,3:4)=this.analysis.fitIntegratedGaussY.param(analyzeIdx,3:4)/this.settings.superSamplingFactor;
                    this.analysis.fitIntegratedGaussY.ci(analyzeIdx,3:4,:)=this.analysis.fitIntegratedGaussY.ci(analyzeIdx,3:4,:)/this.settings.superSamplingFactor;
                elseif strcmp(this.settings.plotImage,'averaged')
                    this.analysis.fitIntegratedGaussY.param(analyzeIdx,3:4)=this.analysis.fitIntegratedGaussY.param(analyzeIdx,3:4)*this.settings.pixelAveraging;
                    this.analysis.fitIntegratedGaussY.ci(analyzeIdx,3:4,:)=this.analysis.fitIntegratedGaussY.ci(analyzeIdx,3:4,:)*this.settings.pixelAveraging;

                end
                figure(4)
                subplot(1,2,2);
                plot(ycoords,fitfun(param,ycoords),'LineWidth',1.5);
                %ylim([1.2*min(min(integratedAlongX),min(integratedAlongY)),1.2*max(max(integratedAlongX),max(integratedAlongY))]);
                hold on
                plot(ycoords,integratedAlongX,'LineWidth',1.5);
                plot([this.analysis.fitIntegratedGaussY.param(analyzeIdx,3),this.analysis.fitIntegratedGaussY.param(analyzeIdx,3)],ylim,'k','LineWidth',1.2)
                if length(ycoords)>10
                    title(['Width: ',num2str(this.analysis.fitIntegratedGaussY.param(analyzeIdx,4),3) ' center: ' ,num2str(this.analysis.fitIntegratedGaussY.param(analyzeIdx,3),3) ]);
                end
                title(['Width: ',num2str(this.analysis.fitIntegratedGaussY.param(analyzeIdx,4),2) ' center: ' ,num2str(this.analysis.fitIntegratedGaussY.param(analyzeIdx,3),3) ]);
                
                hold off
                
                if getFWHM
                    alpha = 0.68;

                    yData = this.lineDensities.Xintegrated(end,:);
                    yDataFiltered = sgolayfilt(yData,2,5);
                    yCumSum = cumsum(yDataFiltered);
                    leftCIWidth = interp1(yCumSum./max(yCumSum),1:length(yCumSum),(1-alpha)/2);
                    rightCIWidth = interp1(yCumSum./max(yCumSum),1:length(yCumSum),1-(1-alpha)/2);
                    
                    peakCenter = round(this.analysis.fitIntegratedGaussY.param(analyzeIdx,3));
                    peakValue  = mean(maxk(yDataFiltered,3));
                    
                    
%                     if peakCenter<5 || peakCenter>length(yDataFiltered)-5
%                         peakCenter = round(length(yDataFiltered)/2);
%                     end
%                     if isnan(peakCenter)
%                         peakCenter = round(length(yDataFiltered)/2);
%                     end
%                         
%                     leftPeak = yDataFiltered(1:peakCenter);
%                     try
%                         leftFWHMWidth = interp1(leftPeak,1:length(leftPeak),0.5*this.analysis.fitIntegratedGaussY.param(analyzeIdx,2));
%                     catch
%                         leftFWHMWidth = NaN;
%                     end
%                     rightPeak = yDataFiltered(peakCenter:end);
%                     try
%                         rightFWHMWidth = round(this.analysis.fitIntegratedGaussY.param(analyzeIdx,3))-1+interp1(rightPeak,1:length(rightPeak),0.5*this.analysis.fitIntegratedGaussY.param(analyzeIdx,2));
%                     catch
%                         rightFWHMWidth = length(yDataFiltered);
%                     end
                    
                    if peakCenter<5 || peakCenter>length(yDataFiltered)-5
                        peakCenter = round(length(yDataFiltered)/2);
                    end
                    if isnan(peakCenter)
                        leftpeak = 1:round(length(yDataFiltered)/2);
                    else
                        leftPeak = yDataFiltered(1:peakCenter);
                    end
                    
                    if isnan(peakCenter)
                        rightPeak = round(length(yDataFiltered)/2):round(length(yDataFiltered));
                    else
                        rightPeak = yDataFiltered(peakCenter:end);
                    end
                    
                    mask = abs(diff(rightPeak)) <= 0.0001;
                    pixel = 1:length(rightPeak);
                    
                    for idx = 1:length(widthArray)
                        try
                            leftWidth = interp1(leftPeak,1:length(leftPeak),widthArray(idx)*peakValue);
                        catch
                            leftWidth = NaN;
                        end
                        
                        try
                            rightWidth = peakCenter-1+interp1(rightPeak(~mask),pixel(~mask),widthArray(idx)*peakValue);
                        catch
                            rightWidth = NaN;
                        end
                        fullWidth(idx) = rightWidth-leftWidth;
                        
                        if widthArray(idx) == 0.5
                            leftFWHMWidth   = leftWidth;
                            rightFWHMWidth  = rightWidth;
                            halfValue       = widthArray(idx)*peakValue;
                        end
                        
                    end
                    
                    
                    figure(842)
                    subplot(1,2,2)
                    plot(yData)
                    hold on
                    plot(yDataFiltered,'LineWidth',2)
                    plot(yCumSum./max(yCumSum).*max(yDataFiltered),'LineWidth',2)
                    ylimits = ylim;
                    %plot([leftCIWidth,leftCIWidth],ylimits,'k--','LineWidth',2)
                    %plot([rightCIWidth,rightCIWidth],ylimits,'k--','LineWidth',2)
                    plot([leftFWHMWidth,leftFWHMWidth],ylimits,'k-.','LineWidth',2)
                    plot([rightFWHMWidth,rightFWHMWidth],ylimits,'k-.','LineWidth',2)
                    hold off
                    legend('raw linedensity','SG filtered', 'cumulative sum')
                    title(['CI width: ' num2str(rightCIWidth-leftCIWidth,3) '   FWHM: ' num2str(rightFWHMWidth-leftFWHMWidth,3)])

                    this.analysis.widthY.CI(analyzeIdx) = rightCIWidth-leftCIWidth;
                    %this.analysis.widthY.FWHM(analyzeIdx) = rightFWHMWidth-leftFWHMWidth;
                    this.analysis.widthY.FWHM(analyzeIdx,:) = fullWidth;
                    this.analysis.widthY.widthArray(analyzeIdx,:) = widthArray;
                end
            end
            drawnow;
        end
        
        function fitIntegratedAsymGaussian(this,currentImageIdx,varargin)
            p = inputParser;
            p.addParameter('BlackedOutODthreshold',NaN);
            p.addParameter('LowODthreshold',NaN);
            p.parse(varargin{:});
            BlackedOutODthreshold   = p.Results.BlackedOutODthreshold;
            LowODthreshold          = p.Results.LowODthreshold;
            
            if strcmp(currentImageIdx,'last')
                currentImageIdx = length(this.images.ODImages(:,1,1));
                analyzeIdx = length(this.parameters);
            elseif this.settings.storeImages
                analyzeIdx = currentImageIdx;
            else
                currentImageIdx = 1;
                analyzeIdx = length(this.parameters);
            end
            if strcmp(this.settings.plotImage,'original')
                croppedODImage = squeeze(this.images.ODImages(currentImageIdx,:,:));
            elseif strcmp(this.settings.plotImage,'filtered')
                croppedODImage = squeeze(this.images.ODImagesFiltered(currentImageIdx,:,:));
                croppedODImage=croppedODImage/this.settings.superSamplingFactor;
            end
            if~isnan(BlackedOutODthreshold)
                ODmask = croppedODImage>BlackedOutODthreshold;
                croppedODImage(ODmask) = NaN;
            end
            if~isnan(LowODthreshold)
                ODmask = croppedODImage<LowODthreshold;
                croppedODImage(ODmask) = 0;
            end
            integratedAlongY = sum(croppedODImage,1);
            integratedAlongX = sum(croppedODImage,2)';
            xcoords = 1:length(integratedAlongY);
            ycoords = 1:length(integratedAlongX);
            [xcoords, integratedAlongY] = prepareCurveData( xcoords, integratedAlongY );
            [ycoords, integratedAlongX] = prepareCurveData( ycoords, integratedAlongX );
            
            
            %fitfun = @(p,x) p(1)+p(2)*exp( -(x-p(3)).^2/(p(4)^2));
            %parameterNames = {'Offset','Amplitude','Center','Width'};
            partfun = @(p,x) 2*p(4)./(1+exp(p(5).*(x-p(3))));             
            fitfun = @(p,x) p(1)+p(2)./partfun(p,x).*exp(-4*log(2)*(2*((x-p(3))./partfun(p,x)).^2));
            parameterNames = {'Offset','Amplitude','Center','Width','Asym'};

            
            [maxy,idxy]=max(integratedAlongY);
            [maxx,idxx]=max(integratedAlongX);
            %estimated gaussian width by estimating location where gaussian
            %crosses 1/e *amplitude
            [~,idxY2]=min(abs(integratedAlongY-exp(-1)*maxy));
            [~,idxX2]=min(abs(integratedAlongX-exp(-1)*maxx));
            %integrated along y guesses

            pGuess  = [(integratedAlongY(1)+integratedAlongY(end))/2 100*max(integratedAlongY) idxy  abs(idxy-idxY2) -0.01];
            lb      = [min(integratedAlongY)    0,  idxy-length(xcoords)/3,abs(idxy-idxY2)/4 -1];
            ub      = [mean(integratedAlongY) inf,  idxy+length(xcoords)/3,range(xcoords) 1];
                
            opts = optimoptions('lsqcurvefit','Algorithm','trust-region-reflective','Display','off','MaxFunctionEvaluations',1000);
            [param,~,residuals,~,~,~,J] = lsqcurvefit(fitfun,pGuess,xcoords,integratedAlongY,lb,ub,opts);
            if(isempty(residuals))
                ci = NaN(4,2);
            else
                ci = nlparci(param,residuals,'jacobian',J,'alpha',1-0.68);
            end
            
            xvalsForPeak = xcoords(1):0.1:xcoords(end);
            yvalsForPeak = fitfun(param,xvalsForPeak);
            [~,XvalIdx] = max(yvalsForPeak);
            PeakInPx = xvalsForPeak(XvalIdx);
            
            this.printFitReport(parameterNames,param,ci);
            this.analysis.fitIntegratedAsymGaussX.parameterNames(analyzeIdx,:)  = parameterNames;
            this.analysis.fitIntegratedAsymGaussX.param(analyzeIdx,:)           = param;
            this.analysis.fitIntegratedAsymGaussX.ci(analyzeIdx,:,:)            = ci;
            this.analysis.fitIntegratedAsymGaussX.peak = PeakInPx;
            
            %plot fit along y-coords
            figure(4);
            clf;
            subplot(1,2,1);
            plot(xcoords,fitfun(param,xcoords),'LineWidth',1.5);
            ylim([1.2*min(min(integratedAlongX),min(integratedAlongY)),1.2*max(max(integratedAlongX),max(integratedAlongY))]);
            xlabel('x coordinate (= pixel if supersampling=1)');
            hold on
            plot(xcoords,integratedAlongY,'LineWidth',1.5);
            hold off
            
            %integrated along x guesses
            pGuess  = [(integratedAlongX(1)+integratedAlongX(end))/2 100*max(integratedAlongX) idxx abs(idxx-idxX2) -0.01];
            lb      = [min(integratedAlongX)    0,  idxx-length(ycoords)/3,abs(idxx-idxX2)/4 -1];
            ub      = [mean(integratedAlongX) inf,  idxx+length(ycoords)/3,range(ycoords) 1];
           
            opts = optimoptions('lsqcurvefit','Algorithm','trust-region-reflective','Display','off','MaxFunctionEvaluations',1000);
            [param,~,residuals,~,~,~,J] = lsqcurvefit(fitfun,pGuess,ycoords,integratedAlongX,lb,ub,opts);
            if(isempty(residuals))
                ci = NaN(4,2);
            else
                ci = nlparci(param,residuals,'jacobian',J,'alpha',1-0.68);
            end
            
            xvalsForPeak = ycoords(1):0.1:ycoords(end);
            yvalsForPeak = fitfun(param,xvalsForPeak);
            [~,XvalIdx] = max(yvalsForPeak);
            PeakInPx = xvalsForPeak(XvalIdx);
            
            this.printFitReport(parameterNames,param,ci);
            this.analysis.fitIntegratedAsymGaussY.parameterNames(analyzeIdx,:)  = parameterNames;
            this.analysis.fitIntegratedAsymGaussY.param(analyzeIdx,:)           = param;
            this.analysis.fitIntegratedAsymGaussY.ci(analyzeIdx,:,:)            = ci;
            this.analysis.fitIntegratedAsymGaussY.peak = PeakInPx;
            

            subplot(1,2,2);
            plot(ycoords,fitfun(param,ycoords),'LineWidth',1.5);
            ylim([1.2*min(min(integratedAlongX),min(integratedAlongY)),1.2*max(max(integratedAlongX),max(integratedAlongY))]);
            hold on
            plot(ycoords,integratedAlongX,'LineWidth',1.5);
            hold off
            drawnow;
           
        end
        
        function fitIntegratedGaussianMasked(this,currentImageIdx, x1, x2, y1, y2)
            % 2018-04-09 this function should be combined with previous via
            % varargin, also has this ever been used?
            
            %Fits a gaussian with the user-defined portion masked out
            if strcmp(currentImageIdx,'last')
                currentImageIdx = length(this.images.ODImages(:,1,1));
                analyzeIdx = length(this.parameters);
            elseif this.settings.storeImages
                analyzeIdx = currentImageIdx;
            else
                currentImageIdx = 1;
                analyzeIdx = length(this.parameters);
            end
            if strcmp(this.settings.plotImage,'original')
                croppedODImage = squeeze(this.images.ODImages(currentImageIdx,:,:));
            elseif strcmp(this.settings.plotImage,'filtered')
                croppedODImage = squeeze(this.images.ODImagesFiltered(currentImageIdx,:,:));
                croppedODImage=croppedODImage/this.settings.superSamplingFactor;
            end
           
            fitfun = @(p,x) p(1)+p(2)*exp( -(x-p(3)).^2/(p(4)^2));
            parameterNames = {'Offset','Amplitude','Center','Width'};
            
            integratedAlongY = sum(croppedODImage,1);
            integratedAlongX = sum(croppedODImage,2)';
            xcoords = 1:length(integratedAlongY);
            ycoords = 1:length(integratedAlongX);
            PeakMaskY = (ycoords<y1 | ycoords>y2);
            PeakMaskX= (xcoords<x1 | xcoords >x2);
            
            [maxy,idxy]=max(integratedAlongY);
            [maxx,idxx]=max(integratedAlongX);
            %estimated gaussian width by estimating location where gaussian
            %crosses 1/e *amplitude
            [dummyY,idxY2]=min(abs(integratedAlongY-exp(-1)*maxy));
            [dummyX,idxX2]=min(abs(integratedAlongX-exp(-1)*maxx));
            %integrated along y guesses
            pGuess = [(integratedAlongY(1)+integratedAlongY(end))/2, 2*max(integratedAlongY),idxy,abs(idxy-idxY2)];   % Inital (guess) parameters
            ub = [mean(integratedAlongY),5*max(integratedAlongY),idxy+length(xcoords)/3,range(xcoords)];
            lb = [min(integratedAlongY),  (maxy-min(integratedAlongY)),idxy-length(xcoords)/3,abs(idxy-idxY2)/4];

            opts = optimoptions('lsqcurvefit','Algorithm','trust-region-reflective','Display','off','MaxFunctionEvaluations',1000);
            [param,~,residuals,~,~,~,J] = lsqcurvefit(fitfun,pGuess,xcoords(PeakMaskX),integratedAlongY(PeakMaskX),lb,ub,opts);
            
            
            if(isempty(residuals))
                ci = NaN(4,2);
            else
                ci = nlparci(param,residuals,'jacobian',J,'alpha',1-0.68);
            end
            
            this.printFitReport(parameterNames,param,ci);
            this.analysis.fitIntegratedGaussMaskedX.parameterNames(analyzeIdx,:)  = parameterNames;
            this.analysis.fitIntegratedGaussMaskedX.param(analyzeIdx,:)           = param;
            this.analysis.fitIntegratedGaussMaskedX.ci(analyzeIdx,:,:)            = ci;
            %take into account supersampling on fitted length scales:
            %center and location
            if strcmp(this.settings.plotImage,'filtered')
                this.analysis.fitIntegratedGaussMaskedX.param(analyzeIdx,3:4)=this.analysis.fitIntegratedGaussMaskedX.param(analyzeIdx,3:4)/this.settings.superSamplingFactor;
                this.analysis.fitIntegratedGaussMaskedX.ci(analyzeIdx,3:4,:)=this.analysis.fitIntegratedGaussMaskedX.ci(analyzeIdx,3:4,:)/this.settings.superSamplingFactor;
            
            end
            %plot fit along y-coords
            figure(554);
            clf;
            subplot(1,2,1);
            plot(xcoords,fitfun(param,xcoords),'LineWidth',1.5);
            ylim([1.2*min(min(integratedAlongX),min(integratedAlongY)),1.2*max(max(integratedAlongX),max(integratedAlongY))]);
            xlabel('x coordinate (= pixel if supersampling=1)');
            title(strcat('Width in camera pixels = ',num2str(this.analysis.fitIntegratedGaussMaskedX.param(analyzeIdx,4),2)));
            hold on

            %integrated along x guesses
                pGuess = [(integratedAlongX(1)+integratedAlongX(end))/2, max(integratedAlongX),idxx,abs(idxx-idxX2)];   % Inital (guess) parameters
                lb = [min(integratedAlongX),  (maxx-min(integratedAlongX))/2,idxx-length(ycoords)/10,abs(idxx-idxX2)/4];
                ub = [mean(integratedAlongX),1.5*max(integratedAlongX),idxx+length(ycoords)/10,range(ycoords)];
                
            opts = optimoptions('lsqcurvefit','Algorithm','trust-region-reflective','Display','off','MaxFunctionEvaluations',1000);
            [param,~,residuals,~,~,~,J] = lsqcurvefit(fitfun,pGuess,ycoords(PeakMaskY),integratedAlongX(PeakMaskY),lb,ub,opts);
            if(isempty(residuals))
                ci = NaN(4,2);
            else
                ci = nlparci(param,residuals,'jacobian',J,'alpha',1-0.68);
            end
            
            this.printFitReport(parameterNames,param,ci);
            this.analysis.fitIntegratedGaussMaskedY.parameterNames(analyzeIdx,:)  = parameterNames;
            this.analysis.fitIntegratedGaussMaskedY.param(analyzeIdx,:)           = param;
            this.analysis.fitIntegratedGaussMaskedY.ci(analyzeIdx,:,:)            = ci;
            %take into account supersampling on fitted length scales:
            %center and location
            if strcmp(this.settings.plotImage,'filtered')
                this.analysis.fitIntegratedGaussMaskedY.param(analyzeIdx,3:4)=this.analysis.fitIntegratedGaussMaskedY.param(analyzeIdx,3:4)/this.settings.superSamplingFactor;
                this.analysis.fitIntegratedGaussMaskedY.ci(analyzeIdx,3:4,:)=this.analysis.fitIntegratedGaussMaskedY.ci(analyzeIdx,3:4,:)/this.settings.superSamplingFactor;
            
            end

            plot(xcoords,integratedAlongY,'LineWidth',1.5);
            plot(xcoords(PeakMaskX),integratedAlongY(PeakMaskX),'.','MarkerSize',20);
            legend('fit Masked','Data','Data for fit');
            hold off
            subplot(1,2,2);
            plot(ycoords,fitfun(param,ycoords),'LineWidth',1.5);
            ylim([1.2*min(min(integratedAlongX),min(integratedAlongY)),1.2*max(max(integratedAlongX),max(integratedAlongY))]);
            hold on
            plot(ycoords,integratedAlongX,'LineWidth',1.5);
            plot(ycoords(PeakMaskY),integratedAlongX(PeakMaskY),'.','MarkerSize',20);
            title(strcat('Width in camera pixels = ',num2str(this.analysis.fitIntegratedGaussMaskedY.param(analyzeIdx,4),2)));

            hold off
            drawnow;
        end
        
        function fitIntegratedBose(this,currentImageIdx,OmegaX,OmegaZ,varargin)
            %9/13/18 Fits a g5/2 thermal bose function to a just-above-Tc cloud
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %Inputs: imageIdx, trap frequencies
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %Outputs: x and z temperatures, amp, center, offset
            

            p = inputParser;
            p.addParameter('ChemicalPotential',0);  %chemical potential in Joules, 
            p.addParameter('camPix',2.5e-6); %meters
            p.parse(varargin{:});

            ChemicalPotential   = p.Results.ChemicalPotential;
            camPix              =p.Results.camPix;    
            if strcmp(currentImageIdx,'last')
                currentImageIdx = length(this.images.ODImages(:,1,1));
                analyzeIdx = length(this.parameters);
            elseif this.settings.storeImages
                analyzeIdx = currentImageIdx;
            else
                currentImageIdx = 1;
                analyzeIdx = length(this.parameters);
            end
            if strcmp(this.settings.plotImage,'original')
                croppedODImage = squeeze(this.images.ODImages(currentImageIdx,:,:));
            elseif strcmp(this.settings.plotImage,'filtered')
                croppedODImage = squeeze(this.images.ODImagesFiltered(currentImageIdx,:,:));
                croppedODImage=croppedODImage/this.settings.superSamplingFactor;
            elseif strcmp(this.settings.plotImage,'averaged')
                croppedODImage = squeeze(this.images.ODImagesAveraged(currentImageIdx,:,:));
                croppedODImage=croppedODImage*this.settings.pixelAveraging;

            end
            
            this.fitIntegratedGaussian(currentImageIdx);
            
            
            if useLineDensity
                xvals = this.lineDensities.Xintegrated(end,:);
                zvals = this.lineDensities.Yintegrated(end,:);
            else
                xvals=sum(croppedODImage,2);
                zvals=sum(croppedODImage,1);
            end
            
            
            xcoords = [1:length(xvals)];
            zcoords = [1:length(zvals)];

            
            %coordinates in meters
%             camPix=2.5e-6; %ycam meters per pixel
            
            
            GaussWidthZ = this.analysis.fitIntegratedGaussX.param(analyzeIdx,4);
            GaussWidthX = this.analysis.fitIntegratedGaussY.param(analyzeIdx,4);
            
            GaussPosZ = this.analysis.fitIntegratedGaussX.param(analyzeIdx,3);
            GaussPosX = this.analysis.fitIntegratedGaussY.param(analyzeIdx,3);;
            
            GaussOffsetZ = this.analysis.fitIntegratedGaussX.param(analyzeIdx,1);
            GaussOffsetX = this.analysis.fitIntegratedGaussY.param(analyzeIdx,1);
            
            GaussAmpZ = this.analysis.fitIntegratedGaussX.param(analyzeIdx,2);
            GaussAmpX = this.analysis.fitIntegratedGaussY.param(analyzeIdx,2);
            if strcmp(this.settings.plotImage,'averaged')
                xcoords=xcoords*this.settings.pixelAveraging;
                zcoords=zcoords*this.settings.pixelAveraging;
%                 GaussWidthX=GaussWidthX*this.settings.pixelAveraging;
%                 GaussWidthZ=GaussWidthZ*this.settings.pixelAveraging;
%                 GaussPosX=GaussPosX*this.settings.pixelAveraging;
%                 GaussPosZ=GaussPosZ*this.settings.pixelAveraging;
            elseif strcmp(this.settings.plotImage,'filtered')
                xcoords=xcoords/this.settings.superSamplingFactor;
                zcoords=zcoords/this.settings.superSamplingFactor;
%                 GaussWidthX=GaussWidthX/this.settings.superSamplingFactor
%                 GaussWidthZ=GaussWidthZ/this.settings.superSamplingFactor;
%                 GaussPosX=GaussPosX/this.settings.superSamplingFactor
%                 GaussPosZ=GaussPosZ/this.settings.superSamplingFactor;
                
            end

%             if strcmp(this.settings.plotImage,'averaged')
%                 xcoords=xcoords*this.settings.pixelAveraging;
%                 zcoords=zcoords*this.settings.pixelAveraging;
%                 
%                 GaussWidthZ = GaussWidthZ*this.settings.pixelAveraging;
%                 GaussWidthX = GaussWidthX*this.settings.pixelAveraging;
%                 
%                 GaussPosZ = GaussPosZ*this.settings.pixelAveraging;
%                 GaussPosX = GaussPosX*this.settings.pixelAveraging;
% 
%             elseif strcmp(this.settings.plotImage,'filtered')
%                 xcoords=xcoords/this.settings.superSamplingFactor;
%                 zcoords=zcoords/this.settings.superSamplingFactor;
%                 
%                 GaussWidthZ = GaussWidthZ/this.settings.superSamplingFactor;
%                 GaussWidthX = GaussWidthX/this.settings.superSamplingFactor;
%                 
%                 GaussPosZ = GaussPosZ/this.settings.superSamplingFactor;
%                 GaussPosX = GaussPosX/this.settings.superSamplingFactor;
%                 
%             end
            
            TOF = this.parameters(analyzeIdx) * 1e-3;
            GaussTemp = 1/2/kB*mNa*(OmegaX^2/(1+OmegaX.^2.*TOF.^2)*(GaussWidthX*camPix)^2);
            
            [xcoords,xvals]=prepareCurveData(xcoords,xvals'); %remove Nan
            BECMask = 1:length(xcoords);
            
            fitfun =@(p,x) p(4)+p(2)*PolyLog(2.5, exp(-abs((ChemicalPotential-1/2*mNa*OmegaX^2/(1+OmegaX^2*TOF^2)*(x-p(3)).^2))./(kB*p(1))));
            parameterNames = {'Temperature(Kelvin)','amp','center','offset'};
                       
            ub =    [2.0*GaussTemp 2.0*GaussAmpX  1.5*GaussPosX*camPix     +2.0*abs(GaussOffsetX)];
            lb=     [0.5*GaussTemp 0.5*GaussAmpX  0.5*GaussPosX*camPix     -2.0*abs(GaussOffsetX)];
            pGuess= [    GaussTemp     GaussAmpX      GaussPosX*camPix              GaussOffsetX];
           
            opts = optimoptions('lsqcurvefit','Algorithm','trust-region-reflective','Display','off','MaxFunctionEvaluations',1000);
            
            [param,~,residuals,~,~,~,J] = lsqcurvefit(fitfun,pGuess,xcoords(BECMask)*camPix,xvals(BECMask),lb,ub,opts);
            
            
            if(isempty(residuals))
                ci = NaN(4,2);
            else
                ci = nlparci(param,residuals,'jacobian',J,'alpha',1-0.68);
            end
            
            this.printFitReport(parameterNames,param,ci);
            this.analysis.fitIntegratedBoseMaskedX.parameterNames(analyzeIdx,:)  = parameterNames;
            this.analysis.fitIntegratedBoseMaskedX.param(analyzeIdx,:)           = param;
            this.analysis.fitIntegratedBoseMaskedX.ci(analyzeIdx,:,:)            = ci;
            this.analysis.fitIntegratedBoseMaskedX.GaussTemp(analyzeIdx)         = GaussTemp;
            
            fitfunGauss = @(p,x) p(1).*exp(-(x-p(4)).^2./(p(3).^2))+p(2);
            
            %plot fit 
            figure(11);
            clf;
            subplot(1,2,2);            
            hold on;
            plot(xcoords(BECMask),xvals(BECMask),'.','MarkerSize',20);
            xplot = xcoords(1):0.01:xcoords(end);
            plot(xplot,fitfunGauss([GaussAmpX,GaussOffsetX,GaussWidthX,GaussPosX],xplot),'--' ,'LineWidth',1.5);
            plot(xplot,fitfun(param,xplot*camPix),'LineWidth',1.5);
            xlabel('x coordinate (= pixel if supersampling=1)');
            box on
            title({['T Bose = ',num2str(param(1)*10^9,3), ' nK' ];['T Gauss = ',num2str(GaussTemp*10^9,3), ' nK' ]});
            
            %%%%%%%%%%%%% 2nd dimension %%%%%%%%%%%%%%%%%%%%%
            GaussTemp = 1/2/kB*mNa*(OmegaZ^2/(1+OmegaZ.^2.*TOF.^2)*(GaussWidthZ*camPix)^2);
            
            [zcoords, zvals]=prepareCurveData(zcoords,zvals');
            BECMask = 1:length(zcoords);
            
            fitfun =@(p,x) p(4)+p(2)*PolyLog(2.5, exp(-abs((ChemicalPotential-1/2*mNa*OmegaZ^2/(1+OmegaZ^2*TOF^2)*(x-p(3)).^2))./(kB*p(1))));
            
            %integrated along x guesses
            ub =    [2.0*GaussTemp 2.0*GaussAmpZ  1.5*GaussPosZ*camPix     +2.0*abs(GaussOffsetZ)];
            lb=     [0.5*GaussTemp 0.5*GaussAmpZ  0.5*GaussPosZ*camPix     -2.0*abs(GaussOffsetZ)];
            pGuess= [    GaussTemp     GaussAmpZ      GaussPosZ*camPix              GaussOffsetZ];
           
            opts = optimoptions('lsqcurvefit','Algorithm','trust-region-reflective','Display','off','MaxFunctionEvaluations',1000);
            [param,~,residuals,~,~,~,J] = lsqcurvefit(fitfun,pGuess,zcoords(BECMask)*camPix,zvals(BECMask),lb,ub,opts);
            if(isempty(residuals))
                ci = NaN(4,2);
            else
                ci = nlparci(param,residuals,'jacobian',J,'alpha',1-0.68);
            end
            
            this.printFitReport(parameterNames,param,ci);
            this.analysis.fitIntegratedBoseMaskedZ.parameterNames(analyzeIdx,:)  = parameterNames;
            this.analysis.fitIntegratedBoseMaskedZ.param(analyzeIdx,:)           = param;
            this.analysis.fitIntegratedBoseMaskedZ.ci(analyzeIdx,:,:)            = ci;
            this.analysis.fitIntegratedBoseMaskedZ.GaussTemp(analyzeIdx)         = GaussTemp;
            
            subplot(1,2,1);
            hold on
            plot(zcoords(BECMask),zvals(BECMask),'.','MarkerSize',20);
            zplot = zcoords(1):0.01:zcoords(end);
            plot(zplot,fitfunGauss([GaussAmpZ,GaussOffsetZ,GaussWidthZ,GaussPosZ],zplot),'--' ,'LineWidth',1.5);
            plot(zplot,fitfun(param,zplot*camPix),'LineWidth',1.5);
            
            
            xlabel('z coordinate');
            box on
            title({['T Bose = ',num2str(param(1)*10^9,3), ' nK'];['T Gauss = ',num2str(GaussTemp*10^9,3), ' nK' ]});
            hold off
            drawnow;
        end
        
        function fitIntegratedBoseMasked(this,currentImageIdx,OmegaX,OmegaZ,varargin)
            %Fits a g5/2 thermal bose function to a bimodally-distributed cloud
            %with the user-defined portion of the BEC masked out
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %Inputs: imageIdx, trap frequencies
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %Outputs: x and z temperatures, amp, center, offset
            

            p = inputParser;
            p.addParameter('BlackedOutODThreshold',3.5);
            p.addParameter('ChemicalPotential',0);  %chemical potential in Joules, 
            p.addParameter('TFCut',1.8);
            p.addParameter('BimodalTFCut',1.0);
            p.addParameter('TOF',NaN); 
            p.addParameter('useLineDensity',true);
            p.addParameter('camPix',2.5e-6); %meters
            
            p.parse(varargin{:});
            BlackedOutODThreshold   = p.Results.BlackedOutODThreshold;
            TFCut                   = p.Results.TFCut;
            ChemicalPotential       = p.Results.ChemicalPotential;
            BimodalTFCut            = p.Results.BimodalTFCut;
            TOF                     = p.Results.TOF;
            useLineDensity          = p.Results.useLineDensity;
            camPix                  = p.Results.camPix;
            
            if strcmp(currentImageIdx,'last')
                currentImageIdx = length(this.images.ODImages(:,1,1));
                analyzeIdx = length(this.parameters);
            elseif this.settings.storeImages
                analyzeIdx = currentImageIdx;
            else
                currentImageIdx = 1;
                analyzeIdx = length(this.parameters);
            end
            if strcmp(this.settings.plotImage,'original')
                croppedODImage = squeeze(this.images.ODImages(currentImageIdx,:,:));
            elseif strcmp(this.settings.plotImage,'filtered')
                croppedODImage = squeeze(this.images.ODImagesFiltered(currentImageIdx,:,:));
                croppedODImage=croppedODImage/this.settings.superSamplingFactor;
            elseif strcmp(this.settings.plotImage,'averaged')
                croppedODImage = squeeze(this.images.ODImagesAveraged(currentImageIdx,:,:));
            end
            
            this.fitBimodalExcludeCenter(currentImageIdx,'TFCut',BimodalTFCut,'BlackedOutODThreshold',BlackedOutODThreshold,'useLineDensity',useLineDensity,'savePlottingInfo',false)
            
            %exclude BEC region
            if(~isnan(BlackedOutODThreshold))
                    ODmask = croppedODImage>BlackedOutODThreshold;
                    croppedODImage(ODmask) = NaN;
            end
            
            if useLineDensity
                xvals = this.lineDensities.Xintegrated(end,:);
                zvals = this.lineDensities.Yintegrated(end,:);
            else
                xvals=sum(croppedODImage,2);
                zvals=sum(croppedODImage,1);
            end
            
            xcoords = [1:length(xvals)];
            zcoords = [1:length(zvals)];
            %coordinates in meters
%             camPix=2.5e-6; %ycam meters per pixel
            
            
            GaussWidthZ = this.analysis.fitBimodalExcludeCenter.GaussianWingsX(analyzeIdx,3);
            GaussWidthX = this.analysis.fitBimodalExcludeCenter.GaussianWingsY(analyzeIdx,3);
            
            GaussPosZ = this.analysis.fitBimodalExcludeCenter.GaussianWingsX(analyzeIdx,4);
            GaussPosX = this.analysis.fitBimodalExcludeCenter.GaussianWingsY(analyzeIdx,4);
            
            GaussOffsetZ = this.analysis.fitBimodalExcludeCenter.GaussianWingsX(analyzeIdx,2);
            GaussOffsetX = this.analysis.fitBimodalExcludeCenter.GaussianWingsY(analyzeIdx,2);
            
            GaussAmpZ = this.analysis.fitBimodalExcludeCenter.GaussianWingsX(analyzeIdx,1);
            GaussAmpX = this.analysis.fitBimodalExcludeCenter.GaussianWingsY(analyzeIdx,1);
            
            BECposZ = this.analysis.fitBimodalExcludeCenter.xparam(analyzeIdx,3);
            BECposX = this.analysis.fitBimodalExcludeCenter.yparam(analyzeIdx,3);
            
            TFZ = this.analysis.fitBimodalExcludeCenter.xparam(analyzeIdx,2);
            TFX = this.analysis.fitBimodalExcludeCenter.yparam(analyzeIdx,2);

            if strcmp(this.settings.plotImage,'averaged') || useLineDensity
                xcoords=xcoords*this.settings.pixelAveraging;
                zcoords=zcoords*this.settings.pixelAveraging;
                
                GaussWidthZ = this.analysis.fitBimodalExcludeCenter.GaussianWingsX(analyzeIdx,3)*this.settings.pixelAveraging;
                GaussWidthX = this.analysis.fitBimodalExcludeCenter.GaussianWingsY(analyzeIdx,3)*this.settings.pixelAveraging;
                
                GaussPosZ = this.analysis.fitBimodalExcludeCenter.GaussianWingsX(analyzeIdx,4)*this.settings.pixelAveraging;
                GaussPosX = this.analysis.fitBimodalExcludeCenter.GaussianWingsY(analyzeIdx,4)*this.settings.pixelAveraging;
                
                BECposZ = this.analysis.fitBimodalExcludeCenter.xparam(analyzeIdx,3)*this.settings.pixelAveraging;
                BECposX = this.analysis.fitBimodalExcludeCenter.yparam(analyzeIdx,3)*this.settings.pixelAveraging;
                
                TFZ = this.analysis.fitBimodalExcludeCenter.xparam(analyzeIdx,2)*this.settings.pixelAveraging;
                TFX = this.analysis.fitBimodalExcludeCenter.yparam(analyzeIdx,2)*this.settings.pixelAveraging;
            elseif strcmp(this.settings.plotImage,'filtered')
                xcoords=xcoords/this.settings.superSamplingFactor;
                zcoords=zcoords/this.settings.superSamplingFactor;
                
                GaussWidthZ = this.analysis.fitBimodalExcludeCenter.GaussianWingsX(analyzeIdx,3)/this.settings.superSamplingFactor;
                GaussWidthX = this.analysis.fitBimodalExcludeCenter.GaussianWingsY(analyzeIdx,3)/this.settings.superSamplingFactor;
                
                GaussPosZ = this.analysis.fitBimodalExcludeCenter.GaussianWingsX(analyzeIdx,4)/this.settings.superSamplingFactor;
                GaussPosX = this.analysis.fitBimodalExcludeCenter.GaussianWingsY(analyzeIdx,4)/this.settings.superSamplingFactor;
                
                BECposZ = this.analysis.fitBimodalExcludeCenter.xparam(analyzeIdx,3)/this.settings.superSamplingFactor;
                BECposX = this.analysis.fitBimodalExcludeCenter.yparam(analyzeIdx,3)/this.settings.superSamplingFactor;
                
                TFZ = this.analysis.fitBimodalExcludeCenter.xparam(analyzeIdx,2)/this.settings.superSamplingFactor;
                TFX = this.analysis.fitBimodalExcludeCenter.yparam(analyzeIdx,2)/this.settings.superSamplingFactor;
            end
            
            
            if(isnan(TOF))
                TOF = this.parameters(analyzeIdx) * 1e-3;
            end
                
            GaussTemp = 1/2/kB*mNa*(OmegaX^2/(1+OmegaX.^2.*TOF.^2)*(GaussWidthX*camPix)^2);
            
            [xcoords,xvals]=prepareCurveData(xcoords,xvals'); %remove Nan
            BECMask = xcoords>(BECposX+TFCut*TFX) | xcoords<(BECposX-TFCut*TFX);
            if(sum(BECMask)<14)
                BECMask(1:7) = true;
                BECMask(end-6:end) = true;
            end
            
            fitfun =@(p,x) p(4)+p(2)*PolyLog(2.5, exp(-abs((ChemicalPotential-1/2*mNa*OmegaX^2/(1+OmegaX^2*TOF^2)*(x-p(3)).^2))./(kB*p(1))));
            parameterNames = {'Temperature(Kelvin)','amp','center','offset'};
                       
            ub =    [2.0*GaussTemp 2.0*GaussAmpX  1.5*BECposX*camPix     +2.0*abs(GaussOffsetX)];
            lb=     [0.5*GaussTemp 0.5*GaussAmpX  0.5*BECposX*camPix     -2.0*abs(GaussOffsetX)];
            pGuess= [    GaussTemp     GaussAmpX      BECposX*camPix              GaussOffsetX];
           
            opts = optimoptions('lsqcurvefit','Algorithm','trust-region-reflective','Display','off','MaxFunctionEvaluations',1000);
            
            [param,~,residuals,~,~,~,J] = lsqcurvefit(fitfun,pGuess,xcoords(BECMask)*camPix,xvals(BECMask),lb,ub,opts);
            
            
            if(isempty(residuals))
                ci = NaN(4,2);
            else
                ci = nlparci(param,residuals,'jacobian',J,'alpha',1-0.68);
            end
            
            this.printFitReport(parameterNames,param,ci);
            this.analysis.fitIntegratedBoseMaskedX.parameterNames(analyzeIdx,:)  = parameterNames;
            this.analysis.fitIntegratedBoseMaskedX.param(analyzeIdx,:)           = param;
            this.analysis.fitIntegratedBoseMaskedX.ci(analyzeIdx,:,:)            = ci;
            this.analysis.fitIntegratedBoseMaskedX.GaussTemp(analyzeIdx)         = GaussTemp;
            
            fitfunGauss = @(p,x) p(1).*exp(-(x-p(4)).^2./(p(3).^2))+p(2);
            
            %plot fit 
            figure(11);
            clf;
            subplot(1,2,2);            
            hold on;
            plot(xcoords(BECMask),xvals(BECMask),'.','MarkerSize',20);
            plot(xcoords(~BECMask),xvals(~BECMask),'.','MarkerSize',20);
            xplot = xcoords(1):0.01:xcoords(end);
            plot(xplot,fitfunGauss([GaussAmpX,GaussOffsetX,GaussWidthX,GaussPosX],xplot),'--' ,'LineWidth',1.5);
            plot(xplot,fitfun(param,xplot*camPix),'LineWidth',1.5);
            xlabel('x coordinate (= pixel if supersampling=1)');
            box on
            title({['T Bose = ',num2str(param(1)*10^9,3), ' nK' ];['T Gauss = ',num2str(GaussTemp*10^9,3), ' nK' ]});
            
            %%%%%%%%%%%%% 2nd dimension %%%%%%%%%%%%%%%%%%%%%
            GaussTemp = 1/2/kB*mNa*(OmegaZ^2/(1+OmegaZ.^2.*TOF.^2)*(GaussWidthZ*camPix)^2);
            
            [zcoords, zvals]=prepareCurveData(zcoords,zvals');
            BECMask = zcoords>(BECposZ+TFCut*TFZ) | zcoords<(BECposZ-TFCut*TFZ);
            if(sum(BECMask)<14)
                BECMask(1:7) = true;
                BECMask(end-6:end) = true;
            end

            
            fitfun =@(p,x) p(4)+p(2)*PolyLog(2.5, exp(-abs((ChemicalPotential-1/2*mNa*OmegaZ^2/(1+OmegaZ^2*TOF^2)*(x-p(3)).^2))./(kB*p(1))));
            
            %integrated along x guesses
            ub =    [2.0*GaussTemp 2.0*GaussAmpZ  1.5*BECposZ*camPix     +2.0*abs(GaussOffsetZ)];
            lb=     [0.5*GaussTemp 0.5*GaussAmpZ  0.5*BECposZ*camPix     -2.0*abs(GaussOffsetZ)];
            pGuess= [    GaussTemp     GaussAmpZ      BECposZ*camPix              GaussOffsetZ];
           
            opts = optimoptions('lsqcurvefit','Algorithm','trust-region-reflective','Display','off','MaxFunctionEvaluations',1000);
            [param,~,residuals,~,~,~,J] = lsqcurvefit(fitfun,pGuess,zcoords(BECMask)*camPix,zvals(BECMask),lb,ub,opts);
            if(isempty(residuals))
                ci = NaN(4,2);
            else
                ci = nlparci(param,residuals,'jacobian',J,'alpha',1-0.68);
            end
            
            this.printFitReport(parameterNames,param,ci);
            this.analysis.fitIntegratedBoseMaskedZ.parameterNames(analyzeIdx,:)  = parameterNames;
            this.analysis.fitIntegratedBoseMaskedZ.param(analyzeIdx,:)           = param;
            this.analysis.fitIntegratedBoseMaskedZ.ci(analyzeIdx,:,:)            = ci;
            this.analysis.fitIntegratedBoseMaskedZ.GaussTemp(analyzeIdx)         = GaussTemp;
            
            subplot(1,2,1);
            hold on
            plot(zcoords(BECMask),zvals(BECMask),'.','MarkerSize',20);
            plot(zcoords(~BECMask),zvals(~BECMask),'.','MarkerSize',20);
            zplot = zcoords(1):0.01:zcoords(end);
            plot(zplot,fitfunGauss([GaussAmpZ,GaussOffsetZ,GaussWidthZ,GaussPosZ],zplot),'--' ,'LineWidth',1.5);
            plot(zplot,fitfun(param,zplot*camPix),'LineWidth',1.5);
            
            
            xlabel('z coordinate');
            box on
            title({['T Bose = ',num2str(param(1)*10^9,3), ' nK'];['T Gauss = ',num2str(GaussTemp*10^9,3), ' nK' ]});
            hold off
%             suptitle('Bose Function Fit')
            drawnow;
        end
        
        
        
        function fitBimodalBose(this,currentImageIdx,OmegaX,OmegaZ,varargin)
            %Fits a g5/2 thermal bose function to a bimodally-distributed cloud
            %with the user-defined portion of the BEC masked out
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %Inputs: imageIdx, trap frequencies
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %Outputs: x and z temperatures, amp, center, offset
            p = inputParser;
            p.addParameter('BlackedOutODThreshold',3.5);
            p.addParameter('ChemicalPotential',0);  %chemical potential in Joules, 
            p.addParameter('TFCut',0.8);
            p.addParameter('BoseTFCut',1.6);
            p.addParameter('BimodalTFCut',1.0);
            p.addParameter('TOF',NaN);
            p.addParameter('useLineDensity',true);
            p.addParameter('camPix',5.2e-7); %to convert to meters, ycam
            p.parse(varargin{:});
            BlackedOutODThreshold   = p.Results.BlackedOutODThreshold;
            BoseTFCut               = p.Results.BoseTFCut;
            ChemicalPotential       = p.Results.ChemicalPotential;
            BimodalTFCut            = p.Results.BimodalTFCut;
            TFCut                   = p.Results.TFCut;
            TOF                     = p.Results.TOF;
            useLineDensity          = p.Results.useLineDensity;
            camPix                  = p.Results.camPix;
            if strcmp(currentImageIdx,'last')
                currentImageIdx = length(this.images.ODImages(:,1,1));
                analyzeIdx = length(this.parameters);
            elseif this.settings.storeImages
                analyzeIdx = currentImageIdx;
            else
                currentImageIdx = 1;
                analyzeIdx = length(this.parameters);
            end
            if strcmp(this.settings.plotImage,'original')
                croppedODImage = squeeze(this.images.ODImages(currentImageIdx,:,:));
            elseif strcmp(this.settings.plotImage,'filtered')
                croppedODImage = squeeze(this.images.ODImagesFiltered(currentImageIdx,:,:));
                croppedODImage=croppedODImage/this.settings.superSamplingFactor;
            elseif strcmp(this.settings.plotImage,'averaged')
                croppedODImage = squeeze(this.images.ODImagesAveraged(currentImageIdx,:,:));
            end
            
            this.fitIntegratedBoseMasked(currentImageIdx,OmegaX,OmegaZ,...
                'BlackedOutODThreshold',BlackedOutODThreshold,...
                'TFCut',BoseTFCut,'BimodalTFCut',BimodalTFCut,'ChemicalPotential',ChemicalPotential,'TOF',TOF,'useLineDensity',useLineDensity);
            %exclude BEC region
            if(~isnan(BlackedOutODThreshold))
                    ODmask = croppedODImage>BlackedOutODThreshold;
                    croppedODImage(ODmask) = NaN;
            end
            
            if useLineDensity
                xvals = this.lineDensities.Xintegrated(end,:);
                zvals = this.lineDensities.Yintegrated(end,:);
            else
                xvals=sum(croppedODImage,2);
                zvals=sum(croppedODImage,1);
            end
            
            xcoords = [1:length(xvals)];
            zcoords = [1:length(zvals)];
            %coordinates in meters
%             camPix=2.5e-6; %ycam meters per pixel
            
            BoseAmpZ = this.analysis.fitIntegratedBoseMaskedZ.param(analyzeIdx,2);
            BoseAmpX = this.analysis.fitIntegratedBoseMaskedX.param(analyzeIdx,2);
            
            BosePosZ = this.analysis.fitIntegratedBoseMaskedZ.param(analyzeIdx,3);
            BosePosX = this.analysis.fitIntegratedBoseMaskedX.param(analyzeIdx,3);
            
            BoseOffsetZ = this.analysis.fitIntegratedBoseMaskedZ.param(analyzeIdx,4);
            BoseOffsetX = this.analysis.fitIntegratedBoseMaskedX.param(analyzeIdx,4);
           
            BECAmpZ = this.analysis.fitBimodalExcludeCenter.xparam(analyzeIdx,1);
            BECAmpX = this.analysis.fitBimodalExcludeCenter.yparam(analyzeIdx,1);
            
            TFZ = this.analysis.fitBimodalExcludeCenter.xparam(analyzeIdx,2);
            TFX = this.analysis.fitBimodalExcludeCenter.yparam(analyzeIdx,2);
            
            BECposZ = this.analysis.fitBimodalExcludeCenter.xparam(analyzeIdx,3);
            BECposX = this.analysis.fitBimodalExcludeCenter.yparam(analyzeIdx,3);
            
            
            if strcmp(this.settings.plotImage,'averaged') || useLineDensity
                xcoords=xcoords*this.settings.pixelAveraging;
                zcoords=zcoords*this.settings.pixelAveraging;
                
                BECposZ = this.analysis.fitBimodalExcludeCenter.xparam(analyzeIdx,3)*this.settings.pixelAveraging;
                BECposX = this.analysis.fitBimodalExcludeCenter.yparam(analyzeIdx,3)*this.settings.pixelAveraging;
                
                TFZ = this.analysis.fitBimodalExcludeCenter.xparam(analyzeIdx,2)*this.settings.pixelAveraging;
                TFX = this.analysis.fitBimodalExcludeCenter.yparam(analyzeIdx,2)*this.settings.pixelAveraging;
            elseif strcmp(this.settings.plotImage,'filtered')
                xcoords=xcoords/this.settings.superSamplingFactor;
                zcoords=zcoords/this.settings.superSamplingFactor;
                
                BECposZ = this.analysis.fitBimodalExcludeCenter.xparam(analyzeIdx,3)/this.settings.superSamplingFactor;
                BECposX = this.analysis.fitBimodalExcludeCenter.yparam(analyzeIdx,3)/this.settings.superSamplingFactor;
                
                TFZ = this.analysis.fitBimodalExcludeCenter.xparam(analyzeIdx,2)/this.settings.superSamplingFactor;
                TFX = this.analysis.fitBimodalExcludeCenter.yparam(analyzeIdx,2)/this.settings.superSamplingFactor;
            end
            
            
            
            if(isnan(TOF))
                TOF = this.parameters(analyzeIdx) * 1e-3;
            end
            
            tempZ =this.analysis.fitIntegratedBoseMaskedZ.param(analyzeIdx,1);
            tempZErr=range(squeeze(this.analysis.fitIntegratedBoseMaskedZ.ci(analyzeIdx,1,:)));
            tempX =this.analysis.fitIntegratedBoseMaskedX.param(analyzeIdx,1);
            tempXErr=range(squeeze(this.analysis.fitIntegratedBoseMaskedX.ci(analyzeIdx,1,:)));
            
            BoseTemp = (tempZ/tempZErr+tempX/tempXErr)/(1/tempZErr+1/tempXErr);
            
            [xcoords,xvals]=prepareCurveData(xcoords,xvals'); %remove Nan
            BECMask = (xcoords>(BECposX-TFCut*TFX) & xcoords<(BECposX+TFCut*TFX))|xcoords>(BECposX+BoseTFCut*TFX)|xcoords<(BECposX-BoseTFCut*TFX);
            
            fitfunBoseBimod = @(p,x) BoseOffsetX+BoseAmpX*PolyLog(2.5, exp(-abs((ChemicalPotential-1/2*mNa*OmegaX^2/(1+OmegaX^2*TOF^2)*(x-BosePosX).^2))./(kB*tempX))) ...
                                    +p(1).*heaviside((1-(x-p(3)).^2./(p(2))^2)).*((1-(x-p(3)).^2./(p(2)).^2)).^2;
            
            parameterNames = {'Bose bimodal BEC Amp','Bose bimodal BEC TF','Bose bimodal BEC Position'};
                       
            ub =    [20.0*BECAmpX  2.0*TFX*camPix  1.5*BECposX*camPix];
            lb=     [0.01*BECAmpX  0.5*TFX*camPix  0.5*BECposX*camPix];
            pGuess= [     BECAmpX      TFX*camPix      BECposX*camPix];
           
            opts = optimoptions('lsqcurvefit','Algorithm','trust-region-reflective','Display','off','MaxFunctionEvaluations',1000);
            
            [param,~,residuals,~,~,~,J] = lsqcurvefit(fitfunBoseBimod,pGuess,xcoords(BECMask)*camPix,xvals(BECMask),lb,ub,opts);
            
            if(isempty(residuals))
                ci = NaN(3,2);
            else
                ci = nlparci(param,residuals,'jacobian',J,'alpha',1-0.68);
            end
            
            
            this.printFitReport(parameterNames,param,ci);
            this.analysis.fitBimodalBoseX.parameterNames(analyzeIdx,:)  = parameterNames;
            this.analysis.fitBimodalBoseX.param(analyzeIdx,:)           = param;
            this.analysis.fitBimodalBoseX.ci(analyzeIdx,:,:)            = ci;
            
            %plot fit 
            GaussianWings = this.analysis.fitBimodalExcludeCenter.GaussianWingsY(analyzeIdx,:);
            BECparam = this.analysis.fitBimodalExcludeCenter.yparam(analyzeIdx,:);
            fitfunBimod = @(x) GaussianWings(1).*exp(-(x-GaussianWings(4)).^2/(GaussianWings(3).^2))+BECparam(1).*heaviside((1-(x-BECparam(3)).^2./(BECparam(2))^2)).*((1-(x-BECparam(3)).^2./(BECparam(2)).^2)).^2+GaussianWings(2);
            
            figure(13);
            clf;
            subplot(1,2,2);            
            hold on;
            plot(xcoords(BECMask),xvals(BECMask),'.','MarkerSize',20);
            plot(xcoords(~BECMask),xvals(~BECMask),'.','MarkerSize',20);
            
            xplot = xcoords(1):0.01:xcoords(end);
            if strcmp(this.settings.plotImage,'averaged')|| useLineDensity
                xplot2 = xplot/this.settings.pixelAveraging;
            elseif strcmp(this.settings.plotImage,'filtered')
                xplot2 = xplot*this.settings.superSamplingFactor;
            else
                xplot2 = xplot;
            end
            plot(xplot,fitfunBimod(xplot2),'--','LineWidth',1.5);
            xplot = xcoords(1):0.01:xcoords(end);
            plot(xplot,fitfunBoseBimod(param,xplot*camPix),'LineWidth',1.5);
            xlabel('x coordinate (lab)');
            box on
            title({['TF radius Bose = ',num2str(param(2)*10^6,3), ' \mum'];['TF radius Gauss = ',num2str(TFX*camPix*1e6,3), ' \mum' ]});
            
            [zcoords,zvals]=prepareCurveData(zcoords,zvals'); %remove Nan
            BECMask = (zcoords>(BECposZ-TFCut*TFZ) & zcoords<(BECposZ+TFCut*TFZ))| zcoords>(BECposZ+BoseTFCut*TFZ)|zcoords<(BECposZ-BoseTFCut*TFZ);
            
            fitfunBoseBimod = @(p,x) BoseOffsetZ+BoseAmpZ*PolyLog(2.5, exp(-abs((ChemicalPotential-1/2*mNa*OmegaZ^2/(1+OmegaZ^2*TOF^2)*(x-BosePosZ).^2))./(kB*tempZ))) ...
                                    +p(1).*heaviside((1-(x-p(3)).^2./(p(2))^2)).*((1-(x-p(3)).^2./(p(2)).^2)).^2;
            
            parameterNames = {'Bose bimodal BEC Amp','Bose bimodal BEC TF','Bose bimodal BEC Position'};
                       
            ub =    [20.0*BECAmpZ  2.0*TFZ*camPix  1.5*BECposZ*camPix];
            lb=     [0.01*BECAmpZ  0.5*TFZ*camPix  0.5*BECposZ*camPix];
            pGuess= [     BECAmpZ      TFZ*camPix      BECposZ*camPix];
           
            opts = optimoptions('lsqcurvefit','Algorithm','trust-region-reflective','Display','off','MaxFunctionEvaluations',1000);
            
            [param,~,residuals,~,~,~,J] = lsqcurvefit(fitfunBoseBimod,pGuess,zcoords(BECMask)*camPix,zvals(BECMask),lb,ub,opts);
            
            if(isempty(residuals))
                ci = NaN(3,2);
            else
                ci = nlparci(param,residuals,'jacobian',J,'alpha',1-0.68);
            end
            
            
            this.printFitReport(parameterNames,param,ci);
            this.analysis.fitBimodalBoseZ.parameterNames(analyzeIdx,:)  = parameterNames;
            this.analysis.fitBimodalBoseZ.param(analyzeIdx,:)           = param;
            this.analysis.fitBimodalBoseZ.ci(analyzeIdx,:,:)            = ci;
            
            %plot fit 
            GaussianWings = this.analysis.fitBimodalExcludeCenter.GaussianWingsX(analyzeIdx,:);
            BECparam = this.analysis.fitBimodalExcludeCenter.xparam(analyzeIdx,:);
            fitfunBimod = @(x) GaussianWings(1).*exp(-(x-GaussianWings(4)).^2/(GaussianWings(3).^2))+BECparam(1).*heaviside((1-(x-BECparam(3)).^2./(BECparam(2))^2)).*((1-(x-BECparam(3)).^2./(BECparam(2)).^2)).^2+GaussianWings(2);
            
            figure(13);
            subplot(1,2,1);            
            hold on;
            plot(zcoords(BECMask),zvals(BECMask),'.','MarkerSize',20);
            plot(zcoords(~BECMask),zvals(~BECMask),'.','MarkerSize',20);
            
            zplot = zcoords(1):0.01:zcoords(end);
            if strcmp(this.settings.plotImage,'averaged')|| useLineDensity
                zplot2 = zplot/this.settings.pixelAveraging;
            elseif strcmp(this.settings.plotImage,'filtered')
                zplot2 = zplot*this.settings.superSamplingFactor;
            else
                zplot2 = zplot;
            end
            plot(zplot,fitfunBimod(zplot2),'--','LineWidth',1.5);
            plot(zplot,fitfunBoseBimod(param,zplot*camPix),'LineWidth',1.5);
            xlabel('z coordinate (lab)');
            box on
            title({['TF radius Bose = ',num2str(param(2)*10^6,3), ' \mum'];['TF radius Gauss = ',num2str(TFZ*camPix*1e6,3), ' \mum' ]});
            drawnow;
            
        end
        
        
        function quickEstimateCentralDensity(this,currentImageIdx)
            if strcmp(currentImageIdx,'last')
                currentImageIdx = length(this.images.ODImages(:,1,1));
                analyzeIdx = length(this.parameters);
            elseif this.settings.storeImages
                analyzeIdx = currentImageIdx;
            else
                currentImageIdx = 1;
                analyzeIdx = length(this.parameters);
            end
            if strcmp(this.settings.plotImage,'original')
                croppedODImage = squeeze(this.images.ODImages(currentImageIdx,:,:));
            elseif strcmp(this.settings.plotImage,'filtered')
                croppedODImage = squeeze(this.images.ODImagesFiltered(currentImageIdx,:,:));
            end
            centralImage = croppedODImage(round(this.analysis.fit2DGauss.param(analyzeIdx,3))-this.settings.extraPixelForQuickDensity:round(this.analysis.fit2DGauss.param(analyzeIdx,3))+this.settings.extraPixelForQuickDensity,round(this.analysis.fit2DGauss.param(analyzeIdx,4))-this.settings.extraPixelForQuickDensity:round(this.analysis.fit2DGauss.param(analyzeIdx,4))+this.settings.extraPixelForQuickDensity);
            if(~isfield(this.analysis, 'fit2DGauss'))
                this.fit2DGaussian(currentImageIdx);
            end
            this.analysis.quickEstimateCentralDensitys(analyzeIdx) = sum(sum(centralImage))/(length(centralImage(1,:))*length(centralImage(:,1)))/sqrt(this.analysis.fit2DGauss.param(analyzeIdx,5).*this.analysis.fit2DGauss.param(analyzeIdx,5).*this.analysis.fit2DGauss.param(analyzeIdx,6));
        end
        
        %% plotting function
        
        function plotODImage(this,currentImageIdx)
            if strcmp(currentImageIdx,'last')
                currentImageIdx = length(this.images.ODImages(:,1,1));
                analyzeIdx = length(this.parameters);
            elseif this.settings.storeImages
                analyzeIdx = currentImageIdx;
            else
                currentImageIdx = 1;
                analyzeIdx = length(this.parameters);
            end
            if strcmp(this.settings.plotImage,'original')
                croppedODImage = squeeze(this.images.ODImages(currentImageIdx,:,:));
                figure(1)
                clf
                subplot(2,3,[1,2,4,5]);
                imagesc(croppedODImage);
                axis equal;
                caxis([-0.1,mean(maxk(croppedODImage(:),20))]);
                colorbar
                
                subplot(2,3,3);
                if(length(croppedODImage(:,1))>3)
                    plot(sum(croppedODImage(round(length(croppedODImage(:,1))/2)-1:round(length(croppedODImage(:,1))/2)+1,:),1)/5,'LineWidth',2);
                    %ylim([-0.05,4.1]);
                end
                subplot(2,3,6);
                if(length(croppedODImage(1,:))>3)
                    plot(sum(croppedODImage(:,round(length(croppedODImage(1,:))/2)-1:round(length(croppedODImage(1,:))/2)+1),2)/5,'LineWidth',2);
                    %ylim([-0.05,4.1]);
                end
                colormap(flipud(bone));
                drawnow;
            elseif strcmp(this.settings.plotImage,'filtered')
                unFilteredCroppedAbsorptionImage = squeeze(this.images.ODImages(currentImageIdx,:,:));
                croppedODImage = squeeze(this.images.ODImagesFiltered(currentImageIdx,:,:));
                figure(1)
                clf
                subplot(2,5,[1,2,6,7]);
                imagesc(unFilteredCroppedAbsorptionImage);
                axis equal;
                colorbar
                %caxis([0,1.1]);
                subplot(2,5,[3,4,8,9]);
                imagesc(croppedODImage);
                axis equal;
                colorbar
                %caxis([0,1.1]);
                subplot(2,5,5);
                plot(sum(croppedODImage(round(length(croppedODImage(:,1))/2)-2:round(length(croppedODImage(:,1))/2)+2,:),1)/5,'LineWidth',2);
                ylim([-0.05,4.1]);
                subplot(2,5,10);
                plot(sum(croppedODImage(:,round(length(croppedODImage(1,:))/2)-2:round(length(croppedODImage(1,:))/2)+2),2)/5,'LineWidth',2);
                ylim([-0.05,4.1]);
                colormap(flipud(bone) );
                drawnow;
            
            elseif strcmp(this.settings.plotImage,'averaged')
                unFilteredCroppedAbsorptionImage = squeeze(this.images.ODImages(currentImageIdx,:,:));
                croppedODImage = squeeze(this.images.ODImagesAveraged(currentImageIdx,:,:));
                figure(1)
                clf
                subplot(2,5,[1,2,6,7]);
                imagesc(unFilteredCroppedAbsorptionImage);
                axis equal;
                colorbar
                %caxis([0,1.1]);
                subplot(2,5,[3,4,8,9]);
                imagesc(croppedODImage);
                axis equal;
                colorbar
                %caxis([0,1.1]);
                subplot(2,5,5);
                plot(sum(unFilteredCroppedAbsorptionImage(round(length(unFilteredCroppedAbsorptionImage(:,1))/2)-2:round(length(unFilteredCroppedAbsorptionImage(:,1))/2)+2,:),1)/5,'LineWidth',2);
                ylim([-0.05,4.1]);
                subplot(2,5,10);
                plot(sum(unFilteredCroppedAbsorptionImage(:,round(length(unFilteredCroppedAbsorptionImage(1,:))/2)-2:round(length(unFilteredCroppedAbsorptionImage(1,:))/2)+2),2)/5,'LineWidth',2);
                ylim([-0.05,4.1]);
                colormap(flipud(bone) );
                drawnow;
            end
            
        end
        
        
        function plotODImageMovie(this,currentImageIdx)
            if strcmp(currentImageIdx,'last')
                currentImageIdx = length(this.images.ODImages(:,1,1));
                analyzeIdx = length(this.parameters);
            elseif this.settings.storeImages
                analyzeIdx = currentImageIdx;
            else
                currentImageIdx = 1;
                analyzeIdx = length(this.parameters);
            end
            if strcmp(this.settings.plotImage,'original')
                croppedODImage = squeeze(this.images.ODImages(currentImageIdx,:,:));
                figure(1)
                clf
                imagesc(croppedODImage);
                axis equal;
                colorbar
                drawnow;
            elseif strcmp(this.settings.plotImage,'filtered')
                croppedODImage = squeeze(this.images.ODImagesFiltered(currentImageIdx,:,:));
                figure(1)
                clf
                imagesc(croppedODImage);
                axis equal;
                colorbar
                drawnow;
            end
            
        end
        
        function plotAbsorptionImage(this,currentImageIdx)
            if strcmp(currentImageIdx,'last')
                currentImageIdx = length(this.images.ODImages(:,1,1));
                analyzeIdx = length(this.parameters);
            elseif this.settings.storeImages
                analyzeIdx = currentImageIdx;
            else
                currentImageIdx = 1;
                analyzeIdx = length(this.parameters);
            end
            if strcmp(this.settings.plotImage,'original')
                xstart = round(this.settings.marqueeBox(2)-this.settings.marqueeBox(4)/2);
                xend = round(xstart+2*this.settings.marqueeBox(4));
                ystart = round(this.settings.marqueeBox(1)-this.settings.marqueeBox(3)/2);
                yend = round(ystart+2*this.settings.marqueeBox(3));
                croppedAbsorptionImage = squeeze(this.images.absorptionImages(currentImageIdx,xstart:xend,ystart:yend));
                figure(1)
                clf
                subplot(2,3,[1,2,4,5]);
                imagesc(croppedAbsorptionImage);
                rectangle('Position',[this.settings.marqueeBox(3)/2,this.settings.marqueeBox(4)/2,this.settings.marqueeBox(3),this.settings.marqueeBox(4)],'LineWidth',2,'LineStyle','--')
                axis equal;
                colorbar
                caxis([0,1.1]);
                subplot(2,3,3);
                plot(sum(croppedAbsorptionImage(round(length(croppedAbsorptionImage(:,1))/2)-2:round(length(croppedAbsorptionImage(:,1))/2)+2,:),1)/5,'LineWidth',2);
                ylim([-0.05,1.1]);
                subplot(2,3,6);
                plot(sum(croppedAbsorptionImage(:,round(length(croppedAbsorptionImage(1,:))/2)-2:round(length(croppedAbsorptionImage(1,:))/2)+2),2)/5,'LineWidth',2);
                ylim([-0.05,1.1]);
                drawnow;
            elseif strcmp(this.settings.plotImage,'filtered')
                xstart = round(this.settings.marqueeBox(2)-this.settings.marqueeBox(4)/2);
                xend = round(xstart+2*this.settings.marqueeBox(4));
                ystart = round(this.settings.marqueeBox(1)-this.settings.marqueeBox(3)/2);
                yend = round(ystart+2*this.settings.marqueeBox(3));
                unFilteredCroppedAbsorptionImage = squeeze(this.images.absorptionImages(currentImageIdx,xstart:xend,ystart:yend));
                
                xstart = this.settings.superSamplingFactor*round(this.settings.marqueeBox(2)-this.settings.marqueeBox(4)/2);
                xend = round(xstart+this.settings.superSamplingFactor*2*this.settings.marqueeBox(4));
                ystart = this.settings.superSamplingFactor*round(this.settings.marqueeBox(1)-this.settings.marqueeBox(3)/2);
                yend = round(ystart+this.settings.superSamplingFactor*2*this.settings.marqueeBox(3));
                croppedAbsorptionImage = squeeze(this.images.absorptionImagesFiltered(currentImageIdx,xstart:xend,ystart:yend));
                
                figure(1)
                clf
                subplot(2,5,[1,2,6,7]);
                imagesc(unFilteredCroppedAbsorptionImage);
                rectangle('Position',[this.settings.marqueeBox(3)/2,this.settings.marqueeBox(4)/2,this.settings.marqueeBox(3),this.settings.marqueeBox(4)],'LineWidth',2,'LineStyle','--')
                
                axis equal;
                colorbar
                caxis([0,1.1]);
                subplot(2,5,[3,4,8,9]);
                imagesc(croppedAbsorptionImage);
                rectangle('Position',this.settings.superSamplingFactor*[this.settings.marqueeBox(3)/2,this.settings.marqueeBox(4)/2,this.settings.marqueeBox(3),this.settings.marqueeBox(4)],'LineWidth',2,'LineStyle','--')
                
                axis equal;
                colorbar
                caxis([0,1.1]);
                subplot(2,5,5);
                plot(sum(croppedAbsorptionImage(round(length(croppedAbsorptionImage(:,1))/2)-2:round(length(croppedAbsorptionImage(:,1))/2)+2,:),1)/5,'LineWidth',2);
                ylim([-0.05,1.1]);
                subplot(2,5,10);
                plot(sum(croppedAbsorptionImage(:,round(length(croppedAbsorptionImage(1,:))/2)-2:round(length(croppedAbsorptionImage(1,:))/2)+2),2)/5,'LineWidth',2);
                ylim([-0.05,1.1]);
                drawnow;
            end
            
            
        end
        
        function plotEllipticalAverage(this,currentImageIdx)
            if strcmp(currentImageIdx,'last')
                currentImageIdx = length(this.images.ODImages(:,1,1));
                analyzeIdx = length(this.parameters);
            elseif this.settings.storeImages
                analyzeIdx = currentImageIdx;
            else
                currentImageIdx = 1;
                analyzeIdx = length(this.parameters);
            end
            figure(2)
            clf
            if(~isfield(this.analysis, 'averagedElliptical'))
                this.averageRadiallyElliptical(currentImageIdx);
            end
            if(length(this.analysis.averagedElliptical.radialCoordinates(:,1))<currentImageIdx)
                this.averageRadiallyElliptical(currentImageIdx);
            end
            plot(this.analysis.averagedElliptical.radialCoordinates(currentImageIdx,:),this.analysis.averagedElliptical.radialAverageOD(currentImageIdx,:),'LineWidth',1.5);
        end
        
        function plotBareNcnt(this)
            figure(3),
            clf,
            plot(this.parameters,this.analysis.bareNcntValues,'.','MarkerSize',30);
        end
        
        function printFitReport(this,names,param,ci)
            if this.settings.verbose 
                fprintf('--------------------------------------------\n');
                for idx = 1:length(names)
                    fprintf([names{idx} ': %.2f [%.2f - %.2f]\n'],param(idx),ci(idx,1),ci(idx,2))
                end
                fprintf('--------------------------------------------\n');
            end
        end
        function getCOMY(this,currentImageIdx)
            %Calculates the Y-axis COM.  Relies on the 1D integrated
            %gaussian fit(offset parameter) to normalize the baseline of the line density to zero.
            if strcmp(currentImageIdx,'last')
                currentImageIdx = length(this.images.ODImages(:,1,1));
                analyzeIdx = length(this.parameters);
            elseif this.settings.storeImages
                analyzeIdx = currentImageIdx;
            else
                currentImageIdx = 1;
                analyzeIdx = length(this.parameters);
            end
            if strcmp(this.settings.plotImage,'original')
                croppedODImage = squeeze(this.images.ODImages(currentImageIdx,:,:));
            elseif strcmp(this.settings.plotImage,'filtered')
                croppedODImage = squeeze(this.images.ODImagesFiltered(currentImageIdx,:,:));
                croppedODImage=croppedODImage/this.settings.superSamplingFactor;
                
            elseif strcmp(this.settings.plotImage,'averaged')
                croppedODImage = squeeze(this.images.ODImagesAveraged(currentImageIdx,:,:));
                croppedODImage=croppedODImage*this.settings.pixelAveraging;
            end
%             this.analysis.COM.pos = [];
            integratedAlongXNorm = sum(croppedODImage,2)-this.analysis.fitIntegratedGaussY.param(analyzeIdx,1);
            ycoords = 1:length(integratedAlongXNorm);
            this.analysis.COMY(analyzeIdx) = sum(integratedAlongXNorm.*ycoords')./sum(integratedAlongXNorm);
            %need to subtract offset from 0 from the 'integratedAlongX'
        end
        
        function getSecondMoment(this,currentImageIdx,varargin)
            %Calculates the Y-axis second moment <y^2>.  Relies on the 1D integrated
            %gaussian fit(offset parameter) to normalize the baseline of the line density to zero.
            %uses Gaussian 1D fit to find center.
            p = inputParser;
            p.addParameter('foldingAverage',true); %use bilateral symmetry along y to double SNR
            p.addParameter('zeroNegativeValues',true); %set amplitudes <0 to 0
            p.addParameter('useLineDensity',true);
            p.addParameter('useCOMToCenter',false); %if false, uses fitIntegratedGaussian as center.  If true, needs getCOMY
            p.parse(varargin{:});
            zeroNegativeValues=         p.Results.zeroNegativeValues;
            useLineDensity          =   p.Results.useLineDensity;
            foldingAverage =            p.Results.foldingAverage;
            useCOMToCenter=             p.Results.useCOMToCenter;
            gaussianUseLineDensity=true;%if the gaussian center relied on line density
            

            if strcmp(currentImageIdx,'last')
                currentImageIdx = length(this.images.ODImages(:,1,1));
                analyzeIdx = length(this.parameters);
            elseif this.settings.storeImages
                analyzeIdx = currentImageIdx;
            else
                currentImageIdx = 1;
                analyzeIdx = length(this.parameters);
            end
            if ~useLineDensity
                if strcmp(this.settings.plotImage,'original')
                    croppedODImage = squeeze(this.images.ODImages(currentImageIdx,:,:));
                elseif strcmp(this.settings.plotImage,'filtered')
                    croppedODImage = squeeze(this.images.ODImagesFiltered(currentImageIdx,:,:));
                    croppedODImage=croppedODImage/this.settings.superSamplingFactor;

                elseif strcmp(this.settings.plotImage,'averaged')
                    croppedODImage = squeeze(this.images.ODImagesAveraged(currentImageIdx,:,:));
                    croppedODImage=croppedODImage*this.settings.pixelAveraging;
                end
                integratedAlongXNorm = sum(croppedODImage,2)'-this.analysis.fitIntegratedGaussY.param(analyzeIdx,1);

            else %used line density
                %take care of offset
                integratedAlongXNorm = this.lineDensities.Xintegrated(end,:)-this.analysis.fitIntegratedGaussY.param(analyzeIdx,1);
                
            end
            if gaussianUseLineDensity&&~useLineDensity
                centerOffs=this.analysis.fitIntegratedGaussY.param(analyzeIdx,3)*this.settings.LineDensityPixelAveraging;
            else
                centerOffs=this.analysis.fitIntegratedGaussY.param(analyzeIdx,3);

            end
            if useCOMToCenter
                centerOffs=this.analysis.COMY(analyzeIdx);
                if useLineDensity
                    centerOffs=centerOffs/this.settings.LineDensityPixelAveraging;
                end
            end
            if centerOffs<1 || centerOffs>length(integratedAlongXNorm)
                this.analysis.SecondMoment(analyzeIdx) = NaN; %cannot find moment if fit is off
                return
            end
            if foldingAverage
                %average along the center line
                    left=fliplr(integratedAlongXNorm(1:max(1,floor(centerOffs))));
                    right=integratedAlongXNorm(ceil(centerOffs):end);
                    halfLength=min(length(left),length(right));
                    left=left(1:halfLength);
                    right=right(1:halfLength);
                    ycoords=0.5:1:(halfLength-.5);
                    foldedYamp=left+right; %average, multiply times two
                    if zeroNegativeValues
                    foldedYamp( find(foldedYamp<0))=0;
                    end
                    this.analysis.SecondMoment(analyzeIdx) = sum(foldedYamp.*ycoords.^2)./sum(foldedYamp);
                    %%%test plotting
% %                     figure(111);clf;subplot(2,1,1);
% %                     plot(ycoords,left);hold on;plot(ycoords,right); legend('left','right');
% %                     subplot(2,1,2);
% %                     plot(integratedAlongXNorm,'.','MarkerSize',20);
% %                     title(strcat('2nd moment = ', num2str(this.analysis.SecondMoment(analyzeIdx),3)));
% %                     legend(num2str(centerOffs,2));
                    %%%%
            else
                %center the distribution at 0
                ycoords=1:length(integratedAlongXNorm);
                ycoords=ycoords-centerOffs;
                if zeroNegativeValues
                    integratedAlongXNorm( find(integratedAlongXNorm<0))=0;
                end
                this.analysis.SecondMoment(analyzeIdx) = sum(integratedAlongXNorm.*ycoords.^2)./sum(integratedAlongXNorm);
                %need to subtract offset from 0 from the 'integratedAlongX'
                %%%%testing plotting
% %                 figure(11);clf; hold on;
% %                 plot(ycoords,this.lineDensities.Xintegrated(end,:));
% %                 plot(ycoords,integratedAlongXNorm);
% %                 title(strcat('2nd moment = ', num2str(this.analysis.SecondMoment(analyzeIdx),3)));
                %%%%
            end


            
        end
        
        function plotAllIntegratedProfilesX(this,varargin)
            p = inputParser;
            
            p.addParameter('rangeMax',NaN);
            p.addParameter('normalize',false);
            p.addParameter('drawLines',true);
            
            p.parse(varargin{:});
            rangeMax  = p.Results.rangeMax;
            normalize  = p.Results.normalize;
            drawLines  = p.Results.drawLines;
            
            this.analysis.COM.pos = [];
            this.analysis.COM.rms = [];
            this.analysis.rightFlank = [];
            this.analysis.leftFlank = [];
            this.analysis.AreaUnder = [];
            this.analysis.fitPeak = [];
            this.analysis.integratedAlongX.values= [];
            this.analysis.integratedAlongX.axis  = [];
            figure(301),
            clf,
            hold on
            
            if isnan(rangeMax)
                plottingRange = 1:length(this.parameters);
            else
                plottingRange = find(this.parameters<rangeMax);
            end
            
            for currentImageIdx = plottingRange
                
                if strcmp(this.settings.plotImage,'original')
                    croppedODImage = squeeze(this.images.ODImages(currentImageIdx,:,:));
                elseif strcmp(this.settings.plotImage,'filtered')
                    croppedODImage = squeeze(this.images.ODImagesFiltered(currentImageIdx,:,:));
                elseif strcmp(this.settings.plotImage,'averaged')
                    croppedODImage = squeeze(this.images.ODImagesAveraged(currentImageIdx,:,:));
                end
                
                
                
                integratedAlongX = sum(croppedODImage,2);
                ycoords = 1:length(integratedAlongX);
                ycoords = ycoords/2+this.settings.marqueeBox(2);
                this.analysis.AreaUnder(currentImageIdx) = trapz(ycoords,integratedAlongX);
                
                if normalize
                    %integratedAlongX = integratedAlongX./max(integratedAlongX);
                    integratedAlongX = integratedAlongX./this.analysis.AreaUnder(currentImageIdx);
                end
                
                this.analysis.integratedAlongX.values(currentImageIdx,:)= integratedAlongX';
                this.analysis.integratedAlongX.axis(currentImageIdx,:)= ycoords;
                
                
                [maxY,maxYidx] = max(integratedAlongX);
                peakMask = find(integratedAlongX>0.90*maxY);
                
                %check for multiple peaks
                diffMask = diff(peakMask);
                corner = find(diffMask>1);
                if ~isempty(corner)
                    if(abs(peakMask(corner)-maxYidx)/length(integratedAlongX)>0.1)
                        peakMask = peakMask(corner+1:end);
                    else
                        peakMask = peakMask(1:corner);
                    end
                    
                end
                
                
                
                fitfun = @(p,x) p(1)+p(2)*(p(3)-x).^2;
                parameterNames = {'Offset','Slope','Position'};
                
                pGuess = [maxY,-1,ycoords(maxYidx)];
                lb = [0.9*maxY,-10,ycoords(peakMask(1))];
                ub = [1.1*maxY,0,ycoords(peakMask(end))];
                
                opts = optimoptions('lsqcurvefit','Algorithm','trust-region-reflective','Display','off','MaxFunctionEvaluations',100);
                [param,~,residuals,~,~,~,J] = lsqcurvefit(fitfun,pGuess,ycoords(peakMask)',integratedAlongX(peakMask),lb,ub,opts);
                ci = nlparci(param,residuals,'jacobian',J,'alpha',1-0.68);
                
                
                this.analysis.fitPeak.parameterNames(currentImageIdx,:)  = parameterNames;
                this.analysis.fitPeak.param(currentImageIdx,:)           = param;
                this.analysis.fitPeak.ci(currentImageIdx,:,:)            = ci;
                
                
                figure(303),
                clf
                plot(ycoords,integratedAlongX,'LineWidth',1.5);
                xlabel('position (px)');
                hold on
                plot(ycoords(peakMask)',fitfun(param,ycoords(peakMask)'),'LineWidth',1.5);
                hold off
                
                
                this.analysis.COM.pos(currentImageIdx,:) = sum(integratedAlongX.*ycoords')./sum(integratedAlongX);
                this.analysis.COM.rms(currentImageIdx,:) = sqrt(sum(integratedAlongX.*(ycoords'-this.analysis.COM.pos(currentImageIdx,:)).^2)./sum(integratedAlongX));
                
                aboveHalf = find(integratedAlongX>0.5*maxY);
                rightIdx = aboveHalf(end);
                this.analysis.rightFlank(currentImageIdx,:) = interp1(integratedAlongX(rightIdx-5:min(rightIdx+5,length(integratedAlongX))),ycoords(rightIdx-5:min(rightIdx+5,length(integratedAlongX))),0.5*maxY);
                leftIdx = aboveHalf(1);
                this.analysis.leftFlank(currentImageIdx,:) = interp1(integratedAlongX(leftIdx-min(5,leftIdx-1):leftIdx+5),ycoords(leftIdx-min(5,leftIdx-1):leftIdx+5),0.5*maxY);
                
                
                fitfun = @(p,x) p(1)+p(2)*exp( -(x-p(3)).^2/(2*p(4)^2));
                parameterNames = {'Offset','Amplitude','Center','Width'};
                
                if strcmp(this.settings.plotImage,'original')
                    pGuess = [mean(integratedAlongX(1:5)),max(integratedAlongX),param(3),2];   % Inital (guess) parameters
                    lb = [-1,0,0,0];
                    ub = [mean(integratedAlongX),1.5*max(integratedAlongX),ycoords(maxYidx),this.settings.marqueeBox(4)/2];
                elseif strcmp(this.settings.plotImage,'filtered')
                    pGuess = [mean(integratedAlongX(1:5)),max(integratedAlongX),param(3),this.settings.superSamplingFactor*2];   % Inital (guess) parameters
                    lb = [-1,0,0,0];
                    ub = [mean(integratedAlongX),1.5*max(integratedAlongX),this.settings.superSamplingFactor*ycoords(maxYidx),this.settings.superSamplingFactor*this.settings.marqueeBox(4)];
                end
                opts = optimoptions('lsqcurvefit','Algorithm','trust-region-reflective','Display','off','MaxFunctionEvaluations',100);
                [param,~,residuals,~,~,~,J] = lsqcurvefit(fitfun,pGuess,ycoords,integratedAlongX',lb,ub,opts);
                ci = nlparci(param,residuals,'jacobian',J,'alpha',1-0.68);
                this.printFitReport(parameterNames,param,ci);
                
                this.analysis.fit1DGaus.parameterNames(currentImageIdx,:)  = parameterNames;
                this.analysis.fit1DGaus.param(currentImageIdx,:)           = param;
                this.analysis.fit1DGaus.ci(currentImageIdx,:,:)            = ci;
                
                figure(304),
                clf;
                plot(ycoords,integratedAlongX,'LineWidth',1.5);
                hold on
                plot(ycoords,fitfun(param(:),ycoords),'LineWidth',1.5);
                hold off
                
                
                
                figure(305)
                clf
                subplot(4,1,1)
                plot(this.parameters(1:length(this.analysis.rightFlank)),this.analysis.rightFlank,'.','MarkerSize',20)
                title('right flank position');
                ylabel('right flank position (px)');
                subplot(4,1,2)
                plot(this.parameters(1:length(this.analysis.leftFlank)),this.analysis.leftFlank,'.','MarkerSize',20)
                title('left flank position');
                ylabel('left flank position (px)');
                subplot(4,1,3)
                errorbar(this.parameters(1:length(this.analysis.COM.pos)),this.analysis.COM.pos,this.analysis.COM.rms/2,this.analysis.COM.rms/2,'.','MarkerSize',20)
                title('center of mass');
                ylabel('position (px)');
                subplot(4,1,4)
                errorbar(this.parameters(1:length(this.analysis.COM.pos)),this.analysis.fitPeak.param(:,3),this.analysis.fitPeak.param(:,3)-this.analysis.fitPeak.ci(:,3,1),this.analysis.fitPeak.ci(:,3,2)-this.analysis.fitPeak.param(:,3),'.','MarkerSize',20)
                title('fitted peak position');
                ylabel('position (px)');
                
                figure(307)
                clf
                title('Summary');
                plot(this.parameters(1:length(this.analysis.rightFlank)),this.analysis.rightFlank,'.','MarkerSize',20)
                hold on
                plot(this.parameters(1:length(this.analysis.leftFlank)),this.analysis.leftFlank,'.','MarkerSize',20)
                errorbar(this.parameters(1:length(this.analysis.COM.pos)),this.analysis.COM.pos,this.analysis.COM.rms/2,this.analysis.COM.rms/2,'.','MarkerSize',20);
                errorbar(this.parameters(1:length(this.analysis.COM.pos)),this.analysis.fitPeak.param(:,3),this.analysis.fitPeak.param(:,3)-this.analysis.fitPeak.ci(:,3,1),this.analysis.fitPeak.ci(:,3,2)-this.analysis.fitPeak.param(:,3),'.','MarkerSize',20)
                
                hold off
                legend('right flank','left flank','center of mass','fitted peak position', 'Location', 'Best');
                ylabel('position (px)');
                
                figure(308)
                clf
                title('integrated Area');
                plot(this.parameters(1:length(this.analysis.rightFlank)),this.analysis.AreaUnder,'.','MarkerSize',20)
                
                
                figure(301),
                hold on
                plot(ycoords,integratedAlongX,'LineWidth',1.5);
                xlabel('position (px)');
                y1=get(gca,'ylim');
                if drawLines
                    line([this.analysis.rightFlank(currentImageIdx) this.analysis.rightFlank(currentImageIdx)],y1,'Color','k','LineStyle','--', 'LineWidth',1.5);
                    line([this.analysis.leftFlank(currentImageIdx) this.analysis.leftFlank(currentImageIdx)],y1,'Color','k','LineStyle','--', 'LineWidth',1.5);
                end
                hold off
                this.printFitReport(parameterNames,param,ci);
                
                drawnow;
            end
            
            
        end
        function plotAllIntegratedProfilesY(this,varargin)
            p = inputParser;
            
            p.addParameter('rangeMax',NaN);
            p.addParameter('normalize',false);
            p.addParameter('drawLines',true);
            
            p.parse(varargin{:});
            rangeMax  = p.Results.rangeMax;
            normalize  = p.Results.normalize;
            drawLines  = p.Results.drawLines;
            
            this.analysis.COM.pos = [];
            this.analysis.COM.rms = [];
            this.analysis.rightFlank = [];
            this.analysis.leftFlank = [];
            this.analysis.AreaUnder = [];
            this.analysis.fitPeak = [];
            this.analysis.integratedAlongX.values= [];
            this.analysis.integratedAlongX.axis  = [];
            figure(301),
            clf,
            hold on
            
            if isnan(rangeMax)
                plottingRange = 1:length(this.parameters);
            else
                plottingRange = find(this.parameters<rangeMax);
            end
            
            for currentImageIdx = plottingRange
                
                if strcmp(this.settings.plotImage,'original')
                    croppedODImage = squeeze(this.images.ODImages(currentImageIdx,:,:));
                elseif strcmp(this.settings.plotImage,'filtered')
                    croppedODImage = squeeze(this.images.ODImagesFiltered(currentImageIdx,:,:));
                elseif strcmp(this.settings.plotImage,'averaged')
                    croppedODImage = squeeze(this.images.ODImagesAveraged(currentImageIdx,:,:));
                end
                
                
                
                integratedAlongY = sum(croppedODImage,1);
                xcoords = 1:length(integratedAlongY);
                xcoords = xcoords/2+this.settings.marqueeBox(1);
                this.analysis.AreaUnder(currentImageIdx) = trapz(xcoords,integratedAlongY);
                
                if normalize
                    %integratedAlongX = integratedAlongX./max(integratedAlongX);
                    integratedAlongY = integratedAlongY./this.analysis.AreaUnder(currentImageIdx);
                end
                
                this.analysis.integratedAlongY.values(currentImageIdx,:)= integratedAlongY';
                this.analysis.integratedAlongY.axis(currentImageIdx,:)= xcoords;
                
                
                [maxY,maxYidx] = max(integratedAlongY);
                peakMask = find(integratedAlongY>0.01*maxY);
                
                %check for multiple peaks
                diffMask = diff(peakMask);
                corner = find(diffMask>1);
                if ~isempty(corner)
                    if(abs(peakMask(corner)-maxYidx)/length(integratedAlongY)>0.1)
                        %peakMask = peakMask(corner+1:end);
                    else
                        %peakMask = peakMask(1:corner);
                    end
                    
                end
                
                
                
                fitfun = @(p,x) p(1)+p(2)*(p(3)-x).^2;
                parameterNames = {'Offset','Slope','Position'};
                
                pGuess = [maxY,-1,xcoords(maxYidx)];
                lb = [0.9*maxY,-10,xcoords(peakMask(1))];
                ub = [1.1*maxY,0,xcoords(peakMask(end))];
                
                opts = optimoptions('lsqcurvefit','Algorithm','trust-region-reflective','Display','off','MaxFunctionEvaluations',100);
                [param,~,residuals,~,~,~,J] = lsqcurvefit(fitfun,pGuess,xcoords(peakMask),integratedAlongY(peakMask),lb,ub,opts);
                ci = nlparci(param,residuals,'jacobian',J,'alpha',1-0.68);
                
                
                this.analysis.fitPeak.parameterNames(currentImageIdx,:)  = parameterNames;
                this.analysis.fitPeak.param(currentImageIdx,:)           = param;
                this.analysis.fitPeak.ci(currentImageIdx,:,:)            = ci;
                
                
                this.analysis.COM.pos(currentImageIdx,:) = sum(integratedAlongY.*xcoords)./sum(integratedAlongY);
                this.analysis.COM.rms(currentImageIdx,:) = sqrt(sum(integratedAlongY.*(xcoords-this.analysis.COM.pos(currentImageIdx,:)).^2)./sum(integratedAlongY));
                
                aboveHalf = find(integratedAlongY>0.5*maxY);
                rightIdx = aboveHalf(end);
                this.analysis.rightFlank(currentImageIdx,:) = interp1(integratedAlongY(rightIdx-5:min(rightIdx+5,length(integratedAlongY))),xcoords(rightIdx-5:min(rightIdx+5,length(integratedAlongY))),0.5*maxY);
                leftIdx = aboveHalf(1);
                this.analysis.leftFlank(currentImageIdx,:) = interp1(integratedAlongY(leftIdx-min(5,leftIdx-1):leftIdx+5),xcoords(leftIdx-min(5,leftIdx-1):leftIdx+5),0.5*maxY);
                
                figure(303),
                clf
                plot(xcoords,integratedAlongY,'LineWidth',1.5);
                xlabel('position (px)');
                hold on
                plot(xcoords(peakMask)',fitfun(param,xcoords(peakMask)'),'LineWidth',1.5);
                hold off
                
                
                
                figure(305)
                clf
                subplot(4,1,1)
                plot(this.parameters(1:length(this.analysis.rightFlank)),this.analysis.rightFlank,'.','MarkerSize',20)
                title('right flank position');
                ylabel('right flank position (px)');
                subplot(4,1,2)
                plot(this.parameters(1:length(this.analysis.leftFlank)),this.analysis.leftFlank,'.','MarkerSize',20)
                title('left flank position');
                ylabel('left flank position (px)');
                subplot(4,1,3)
                errorbar(this.parameters(1:length(this.analysis.COM.pos)),this.analysis.COM.pos,this.analysis.COM.rms/2,this.analysis.COM.rms/2,'.','MarkerSize',20)
                title('center of mass');
                ylabel('position (px)');
                subplot(4,1,4)
                errorbar(this.parameters(1:length(this.analysis.COM.pos)),this.analysis.fitPeak.param(:,3),this.analysis.fitPeak.param(:,3)-this.analysis.fitPeak.ci(:,3,1),this.analysis.fitPeak.ci(:,3,2)-this.analysis.fitPeak.param(:,3),'.','MarkerSize',20)
                title('fitted peak position');
                ylabel('position (px)');
                
                figure(307)
                clf
                title('Summary');
                plot(this.parameters(1:length(this.analysis.rightFlank)),this.analysis.rightFlank,'.','MarkerSize',20)
                hold on
                plot(this.parameters(1:length(this.analysis.leftFlank)),this.analysis.leftFlank,'.','MarkerSize',20)
                errorbar(this.parameters(1:length(this.analysis.COM.pos)),this.analysis.COM.pos,this.analysis.COM.rms/2,this.analysis.COM.rms/2,'.','MarkerSize',20);
                errorbar(this.parameters(1:length(this.analysis.COM.pos)),this.analysis.fitPeak.param(:,3),this.analysis.fitPeak.param(:,3)-this.analysis.fitPeak.ci(:,3,1),this.analysis.fitPeak.ci(:,3,2)-this.analysis.fitPeak.param(:,3),'.','MarkerSize',20)
                
                hold off
                legend('right flank','left flank','center of mass','fitted peak position', 'Location', 'Best');
                ylabel('position (px)');
                
                figure(308)
                clf
                title('integrated Area');
                plot(this.parameters(1:length(this.analysis.rightFlank)),this.analysis.AreaUnder,'.','MarkerSize',20)
                
                
                figure(301),
                hold on
                plot(xcoords,integratedAlongY,'LineWidth',1.5);
                xlabel('position (px)');
                y1=get(gca,'ylim');
                if drawLines
                    line([this.analysis.rightFlank(currentImageIdx) this.analysis.rightFlank(currentImageIdx)],y1,'Color','k','LineStyle','--', 'LineWidth',1.5);
                    line([this.analysis.leftFlank(currentImageIdx) this.analysis.leftFlank(currentImageIdx)],y1,'Color','k','LineStyle','--', 'LineWidth',1.5);
                end
                hold off
                this.printFitReport(parameterNames,param,ci);
                
                drawnow;
            end
        end
        function analyzeCOMFFT(this,varargin)
            p = inputParser;
            
            p.addParameter('zeroPaddingUpTo',NaN);
            p.addParameter('removeHoles',true);
            p.addParameter('lowerPositionCut',NaN);
            p.addParameter('upperPositionCut',NaN);
          
            p.parse(varargin{:});
            zeroPaddingUpTo  = p.Results.zeroPaddingUpTo;
            lowerPositionCut  = p.Results.lowerPositionCut;
            upperPositionCut  = p.Results.upperPositionCut;
            
            times = this.parameters;
            positions = this.analysis.fitBimodalExcludeCenter.yparam(:,3);
            
            [times,sortIdx] = sort(times);
            positions = positions(sortIdx)';
            times = times/1000;
            times = times-(times(1));
            
            mask = find(positions>lowerPositionCut&positions<upperPositionCut);
            times = times(mask);
            positions = positions(mask);
            
            %approximate holes
            if(removeHoles == true)
                holesIdx = find(diff(times)>=mean(diff(times)));
                while(length(holesIdx)<length(diff(times)))
                    length(holesIdx)
                    for idx = 1:length(holesIdx)
                        positions = [positions(1:holesIdx(idx)),interp1(times,positions,times(holesIdx(idx))+median(diff(times))),positions(holesIdx(idx)+1:end)];
                        times = [times(1:holesIdx(idx)),times(holesIdx(idx))+median(diff(times)),times(holesIdx(idx)+1:end)];
                        holesIdx = holesIdx+1;
                    end
                    holesIdx = find(diff(times)>=0.99*mean(diff(times)));

                end
            end
            
            
            % remove DC and slow drift
            p = polyfit(times,positions,1);
            positions = positions-(p(2)+p(1).*times);
            
            
            %zero padding
            if(~isnan(zeroPaddingUpTo))
                zeroPadding = 258;
                times(end+1:end+zeroPadding) = (1:zeroPadding)*(times(2)-times(1));
                positions(end+1:end+zeroPadding) = (1:zeroPadding)*0;
            end
            
            %fft
            FsNA = 1/(times(2)-times(1));        % Sampling frequency
            L = length(times);             % Number of samples
            
            FFTy = fft(positions);
            powerNA = abs(FFTy/L);
            powerNA = powerNA(1:L/2+1);
            powerNA(2:end-1) = 2*powerNA(2:end-1);
            
            freqNA = FsNA*(0:(L/2))/L;
            
            % plotting
            figure(9);
            subplot(2,1,2)
            plot(freqNA,powerNA,'.-','MarkerSize',20)
            title('Single-Sided Amplitude Spectrum')
            xlabel('Frequency (Hz)')
            ylabel('Power')
            
            subplot(2,1,1)
            plot(times,positions,'.-','MarkerSize',20)
            ylabel('fitted peak position (px)')
            xlabel('time (s)')
        end
        
        %% Outdated methods (keept as reference and possibly backwards compatibility)
        function fitBimodalOutdated(this,currentImageIdx,varargin)
            p = inputParser;
            
            p.addParameter('testing',false);
            p.addParameter('TFradii',5*[4,1,1]);
            p.addParameter('GaussSigma',10*[4,1,1]);
            p.addParameter('nBECnTherm',0.2);
            p.addParameter('noisePercent',0.05);
            p.parse(varargin{:});
            testing  = p.Results.testing;
            TFradii  = p.Results.TFradii;
            GaussSigma  = p.Results.GaussSigma;
            nBECnTherm  = p.Results.nBECnTherm;
            noisePercent  = p.Results.noisePercent;
            
            
            if testing
                currentImageIdx = 1;
                analyzeIdx = 1;
                BEC=@(x,y,z) 15/(8*pi*TFradii(1)*TFradii(2)*TFradii(3))*(1-x.^2/TFradii(1)^2-y.^2/TFradii(2)^2-z.^2/TFradii(3)^2).*heaviside(1-x.^2/TFradii(1)^2-y.^2/TFradii(2)^2-z.^2/TFradii(3)^2);
                
                Therm=@(x,y,z) 1/(GaussSigma(1)*GaussSigma(2)*GaussSigma(3)*pi^1.5)*exp(-x.^2/GaussSigma(1)^2-y.^2/GaussSigma(2)^2-z.^2/GaussSigma(3)^2);
                
                Combined = @(x,y,z) BEC(x,y,z)+nBECnTherm*Therm(x,y,z);
                
                xCoords = -3*max(GaussSigma(1),TFradii(1)):1:3*max(GaussSigma(1),TFradii(1));
                yCoords = -3*max(GaussSigma(2),TFradii(2)):1:3*max(GaussSigma(2),TFradii(3));
                zCoords = -3*max(GaussSigma(3),TFradii(3)):1:3*max(GaussSigma(2),TFradii(3));
                
                [XCoords,YCoords,ZCoords] = meshgrid(xCoords,yCoords,zCoords);   
                
                simulatedColumnDensity = sum(100*Combined(XCoords,YCoords,ZCoords),3);
                ysum=sum(simulatedColumnDensity,2);
                xsum=sum(simulatedColumnDensity,1);
                
                ysum=ysum+noisePercent.*ysum.*randn(length(yCoords'),1)+noisePercent./10.*max(ysum).*randn(length(yCoords'),1);
                xsum=xsum+noisePercent.*xsum.*randn(1,length(xCoords))+noisePercent./10.*max(xsum).*randn(1,length(xCoords));
                
                [xpix, nx] = prepareCurveData( xCoords, xsum );
                [ypix, ny] = prepareCurveData( yCoords, ysum' );
                
                
               
            else
                if strcmp(currentImageIdx,'last')
                    currentImageIdx = length(this.images.ODImages(:,1,1));
                    analyzeIdx = length(this.parameters);
                elseif this.settings.storeImages
                    analyzeIdx = currentImageIdx;
                else
                    currentImageIdx = 1;
                    analyzeIdx = length(this.parameters);
                end
                if strcmp(this.settings.plotImage,'original')
                    croppedODImage = squeeze(this.images.ODImages(currentImageIdx,:,:));
                elseif strcmp(this.settings.plotImage,'averaged')
                    croppedODImage = squeeze(this.images.ODImagesAveraged(currentImageIdx,:,:));
                elseif strcmp(this.settings.plotImage,'filtered')
                    croppedODImage = squeeze(this.images.ODImagesFiltered(currentImageIdx,:,:));
                end
                ysum=sum(croppedODImage,2);
                xsum=sum(croppedODImage,1);
               [xpix, nx] = prepareCurveData( 1:length(xsum), xsum );
               [ypix, ny] = prepareCurveData( 1:length(ysum), ysum' );
            end
            
            
            % inv parab to peak fit:
            PeakMaskP = nx>0.3*max(nx);
            fitInvParab = @(p,x) p(1)*(1-(x-p(3)).^2./(p(2).^2)).^2;
            lb = [0,(xpix(end)-xpix(1))/100,xpix(1)];   % Inital (guess) parameters
            pGuess =  [max(nx),(xpix(end)-xpix(1))/20,xpix(find(nx==max(nx)))];
            ub =  [1.5*max(nx),(xpix(end)-xpix(1))/2,xpix(end)];
            
            optio = optimoptions('lsqcurvefit','Algorithm','trust-region-reflective','Display','off','MaxFunctionEvaluations',100);
            [parabX,~,residP,~,~,~,J] = lsqcurvefit(fitInvParab,pGuess,xpix(PeakMaskP),nx(PeakMaskP),lb,ub,optio);
            
            
            %Obtain good starting guesses by first fitting a pure gaussian
            fitfun = @(p,x) p(1).*exp(-(x-p(4)).^2./(2*p(3).^2))+p(2);
            parameterNames = {'amplitude','offset','width','position'};
            
            lb = [0,min(nx),(xpix(end)-xpix(1))/100,xpix(1)];   % Inital (guess) parameters
            pGuess =  [max(nx),0,(xpix(end)-xpix(1))/20,xpix(find(nx==max(nx)))];
            ub =  [1.5*max(nx),0.5*max(nx),(xpix(end)-xpix(1))/2,xpix(end)];
            
            optio = optimoptions('lsqcurvefit','Algorithm','trust-region-reflective','Display','off','MaxFunctionEvaluations',100);
            [ggx,~,residG,~,~,~,J] = lsqcurvefit(fitfun,pGuess,xpix,nx,lb,ub,optio);
            %ci = nlparci(param,residuals,'jacobian',J,'alpha',1-0.68);
            
            
            figure(103),clf;
            plot(xpix,nx);
            hold on
            plot(xpix(PeakMaskP),fitInvParab(parabX,xpix(PeakMaskP)),'LineWidth',2);
            plot(xpix,fitfun(ggx,xpix),'LineWidth',2);
            hold off
            
            %Do x-integrated bimodal fit
            ft = fittype( 'aT*aBEC*exp(-(x-xT)^2/(wTherm^2))+aBEC*heaviside((1-(x-x0)^2/(wTherm*wBEC)^2))*((1-(x-x0)^2/(wTherm*wBEC)^2)).^2+c',...
                'independent', 'x', 'dependent', 'y' );
            parameterNames = {'Amp BEC', 'Amp Therm:BEC ratio','Offset','BEC ratio width','Therm width','xBEC','xTherm'};
            %ampBEC, ampTherm,  wBEC, wTherm,x0
            %The half-length of the condensate is BECwidth
            opts=fitoptions('Method','NonlinearLeastSquares');
            opts.Display = 'Off';

            opts.Lower =        [0,         0,   min(nx),    0,              0,      abs(ggx(4))-abs(ggx(3)),abs(ggx(4))-abs(ggx(3))];
            opts.StartPoint =   [ggx(1),  0.1,    abs(ggx(2)),1,    abs(ggx(3)),    abs(ggx(4)),            abs(ggx(4))];
            
            %opts.StartPoint =   [0.047,  0.06,    0,0.5,    10*4,    abs(ggx(4)),            abs(ggx(4))];
            opts.Upper =        [2*ggx(1),5,    max(nx),    2,      abs(ggx(3)*10),  abs(ggx(4))+abs(ggx(3)),abs(ggx(4))+abs(ggx(3))];
            opts.Upper=abs(opts.Upper);

            
            % Fit model to data.
            [fitresult] = fit( xpix, nx, ft, opts );
            xparam=coeffvalues(fitresult);
            xci=confint(fitresult); %confidence interval
            
            % % Plot fit with data.
            figure(777);clf; hold on;
            plot( fitresult, xpix, nx ,'b.');
            
            
            
            %Y axis: Obtain good starting guesses by first fitting a pure gaussian
            
            
            
            fitfun = @(p,x) p(1).*exp(-(x-p(4)).^2./(2*p(3).^2))+p(2);
            parameterNames = {'amplitude','offset','width','position'};
            
            lb = [0,min(ny),(ypix(end)-ypix(1))/100,ypix(1)];   % Inital (guess) parameters
            pGuess =  [max(ny),0,(ypix(end)-ypix(1))/20,ypix(find(ny==max(ny)))];
            ub =  [1.5*max(ny),0.5*max(ny),(ypix(end)-ypix(1))/2,ypix(end)];
            
            optio = optimoptions('lsqcurvefit','Algorithm','trust-region-reflective','Display','off','MaxFunctionEvaluations',100);
            [gg,~,residuals,~,~,~,J] = lsqcurvefit(fitfun,pGuess,ypix,ny,lb,ub,optio);
            %ci = nlparci(param,residuals,'jacobian',J,'alpha',1-0.68);
            
            %Do y-integrated bimodal fit
            
            %                   ampBEC,     ampTherm,c,         wB,
            %                   wT,xB,xT
            opts.Lower =        [0,         0,   min(nx),    0,               0,             abs(gg(4))-abs(gg(3)), abs(gg(4))-abs(gg(3))];
            opts.StartPoint =   [gg(1),     0.1,  abs(gg(2)), 1,      abs(gg(3)),    abs(gg(4)),            abs(gg(4))];
            opts.Upper =        [2*gg(1) ,  5,  max(nx),    2,  abs(gg(3)*10),  abs(gg(4))+abs(gg(3)),abs(gg(4))+abs(gg(3))];
            opts.Upper=abs(opts.Upper);
            
            
            % Fit model to data.
            [fitresult] = fit( ypix, ny, ft, opts );
            yparam=coeffvalues(fitresult);
            yci=confint(fitresult); %confidence interval
            
            % % Plot fit with data.
            
            plot( fitresult, ypix, ny ,'g.');
            xleg=strcat('aBEC = ',num2str(xparam(1),2),', aT=',num2str(xparam(2),2),...
                ' c= ', num2str(xparam(3),2),', wBEC =',num2str(xparam(4),2), ' wT = ', ...
                num2str(xparam(5),2), ', xBEC= ', num2str(xparam(6),2), ', xT= ',num2str(xparam(7),2)) ;
            yleg=strcat('aBEC = ',num2str(yparam(1),2),', aT=',num2str(yparam(2),2),...
                ' c= ', num2str(yparam(3),2),', wBEC =',num2str(yparam(4),2), ' wT = ', ...
                num2str(yparam(5),2), ', xBEC= ', num2str(yparam(6),2), ', xT= ',num2str(yparam(7),2));
            legend( 'xdata',xleg,'ydata',yleg );
            drawnow;
            
            this.analysis.fitBimodal.parameterNames(analyzeIdx,:)  = parameterNames;
            this.analysis.fitBimodal.xparam(analyzeIdx,:)           = xparam;
            this.analysis.fitBimodal.yparam(analyzeIdx,:)           = yparam;
            this.analysis.fitBimodal.xci(analyzeIdx,:,:)            = xci;
            this.analysis.fitBimodal.yci(analyzeIdx,:,:)            = yci;
        end
        
        function fitBimodalExcludeCenterOutdated(this,currentImageIdx,varargin)
            p = inputParser;
            
            p.addParameter('testing',false);
            p.addParameter('TFradii',5*[4,1,1]);
            p.addParameter('GaussSigma',10*[4,1,1]);
            p.addParameter('nBECnTherm',0.2);
            p.addParameter('noisePercent',0.05);
            p.parse(varargin{:});
            testing  = p.Results.testing;
            TFradii  = p.Results.TFradii;
            GaussSigma  = p.Results.GaussSigma;
            nBECnTherm  = p.Results.nBECnTherm;
            noisePercent  = p.Results.noisePercent;
            
            if testing
                currentImageIdx = 1;
                analyzeIdx = 1;
                BEC=@(x,y,z) 15/(8*pi*TFradii(1)*TFradii(2)*TFradii(3))*(1-x.^2/TFradii(1)^2-y.^2/TFradii(2)^2-z.^2/TFradii(3)^2).*heaviside(1-x.^2/TFradii(1)^2-y.^2/TFradii(2)^2-z.^2/TFradii(3)^2);
                
                Therm=@(x,y,z) 1/(GaussSigma(1)*GaussSigma(2)*GaussSigma(3)*pi^1.5)*exp(-x.^2/GaussSigma(1)^2-y.^2/GaussSigma(2)^2-z.^2/GaussSigma(3)^2);
                
                Combined = @(x,y,z) BEC(x,y,z)+nBECnTherm*Therm(x,y,z);
                
                extrasigma = 4;
                xCoords = -extrasigma*max(GaussSigma(1),TFradii(1)):1:extrasigma*max(GaussSigma(1),TFradii(1));
                yCoords = -extrasigma*max(GaussSigma(2),TFradii(2)):1:extrasigma*max(GaussSigma(2),TFradii(3));
                zCoords = -extrasigma*max(GaussSigma(3),TFradii(3)):1:extrasigma*max(GaussSigma(2),TFradii(3));
                
                [XCoords,YCoords,ZCoords] = meshgrid(xCoords,yCoords,zCoords);   
                
                simulatedColumnDensity = sum(100*Combined(XCoords,YCoords,ZCoords),3);
                ysum=sum(simulatedColumnDensity,2);
                xsum=sum(simulatedColumnDensity,1);
                
                ysum=ysum+noisePercent.*ysum.*randn(length(yCoords'),1)+noisePercent./10.*max(ysum).*randn(length(yCoords'),1);
                xsum=xsum+noisePercent.*xsum.*randn(1,length(xCoords))+noisePercent./10.*max(xsum).*randn(1,length(xCoords));
                
                [xpix, nx] = prepareCurveData( xCoords, xsum );
                [ypix, ny] = prepareCurveData( yCoords, ysum' );
                
                
               
            else
                %Identical to FitBimodal, but the gaussian wings are fitted
                %while excluding the central (blacked out) portions
                if strcmp(currentImageIdx,'last')
                    currentImageIdx = length(this.images.ODImages(:,1,1));
                    analyzeIdx = length(this.parameters);
                elseif this.settings.storeImages
                    analyzeIdx = currentImageIdx;
                else
                    currentImageIdx = 1;
                    analyzeIdx = length(this.parameters);
                end
                if strcmp(this.settings.plotImage,'original')
                    croppedODImage = squeeze(this.images.ODImages(currentImageIdx,:,:));
                elseif strcmp(this.settings.plotImage,'averaged')
                    croppedODImage = squeeze(this.images.ODImagesAveraged(currentImageIdx,:,:));
                elseif strcmp(this.settings.plotImage,'filtered')
                    croppedODImage = squeeze(this.images.ODImagesFiltered(currentImageIdx,:,:));
                end


                ysum=sum(croppedODImage,2);
                xsum=sum(croppedODImage,1);
                [xpix, nx] = prepareCurveData( 1:length(xsum), xsum );
                [ypix, ny] = prepareCurveData( 1:length(ysum), ysum' );
            end
                
            
            % inv parab to peak fit:
            PeakMaskP = nx>0.3*max(nx);
            fitInvParab = @(p,x) p(1)*(1-(x-p(3)).^2./(p(2).^2)).^2;
            lb = [0,(xpix(end)-xpix(1))/100,xpix(1)];   % Inital (guess) parameters
            pGuess =  [max(nx),(xpix(end)-xpix(1))/20,xpix(find(nx==max(nx)))];
            ub =  [1.5*max(nx),(xpix(end)-xpix(1))/2,xpix(end)];
            
            optio = optimoptions('lsqcurvefit','Algorithm','trust-region-reflective','Display','off','MaxFunctionEvaluations',100);
            [parabX,~,residuals,~,~,~,J] = lsqcurvefit(fitInvParab,pGuess,xpix(PeakMaskP),nx(PeakMaskP),lb,ub,optio);
            
            
            %Obtain good starting guesses by first fitting a pure gaussian
            fitfun = @(p,x) p(1).*exp(-(x-p(4)).^2./(p(3).^2))+p(2);
            parameterNames = {'amplitude','offset','width','position'};
            
            lb = [0,min(nx),(xpix(end)-xpix(1))/100,xpix(1)];   % Inital (guess) parameters
            pGuess =  [max(nx),0,(xpix(end)-xpix(1))/20,xpix(find(nx==max(nx)))];
            ub =  [1.5*max(nx),0.5*max(nx),(xpix(end)-xpix(1))/2,xpix(end)];
            
            
            optio = optimoptions('lsqcurvefit','Algorithm','trust-region-reflective','Display','off','MaxFunctionEvaluations',100);
            [ggx,~,residuals,~,~,~,J] = lsqcurvefit(fitfun,pGuess,xpix,nx,lb,ub,optio);
            if(isempty(residuals))
                ci = NaN(4,2);
            else
                ci = nlparci(ggx,residuals,'jacobian',J,'alpha',1-0.68);
            end
            this.printFitReport(parameterNames,ggx,ci);
            
            
            
            %fit wings with pure gaussian
            lb = [0,min(nx),xpix(1),xpix(1)];  
            pGuess = [abs(ggx(1)/4), min(nx),ggx(3)*2, ggx(4)];
            ub =  [1.2*abs(ggx(1)),0.2*max(nx), ggx(3)*10,xpix(end)];
            
            ParabCut = 0.9;
            PeakMask = (xpix>parabX(3)+ParabCut*parabX(2) | xpix < parabX(3)-ParabCut*parabX(2));
            
            optio = optimoptions('lsqcurvefit','Algorithm','trust-region-reflective','Display','off','MaxFunctionEvaluations',100);
            [GaussianWingsX,~,residuals,~,~,~,J] = lsqcurvefit(fitfun,pGuess,xpix(PeakMask),nx(PeakMask),lb,ub,optio);
            if(isempty(residuals))
                GaussianWingsXci = NaN(4,2);
            else
                GaussianWingsXci = nlparci(GaussianWingsX,residuals,'jacobian',J,'alpha',1-0.68);
            end
            this.printFitReport(parameterNames,GaussianWingsX,ci);
            
            
            %fit bimodal with only BEC variable
            fitfunBimod = @(p,x) GaussianWingsX(1).*exp(-(x-GaussianWingsX(4)).^2/(GaussianWingsX(3).^2))+p(1).*heaviside((1-(x-p(3)).^2./(GaussianWingsX(3).*p(2))^2)).*((1-(x-p(3)).^2./(GaussianWingsX(3).*p(2)).^2)).^2+GaussianWingsX(2);
            parameterNames = {'amplitude','width','position'};
            
            lb = [0,0,parabX(3)-parabX(2)];   % Inital (guess) parameters
            pGuess = [(ggx(1)),parabX(2)./GaussianWingsX(3), parabX(3)];
            ub =  [ggx(1)*1.5, 1,parabX(3)+parabX(2)];
            
            optio = optimoptions('lsqcurvefit','Algorithm','trust-region-reflective','Display','off','MaxFunctionEvaluations',100);
            [xparam,~,residuals,~,~,~,J] = lsqcurvefit(fitfunBimod,pGuess,xpix,nx,lb,ub,optio);
            if(isempty(residuals))
                xci = NaN(4,2);
            else
                xci = nlparci(xparam,residuals,'jacobian',J,'alpha',1-0.68);
            end
            this.printFitReport(parameterNames,xparam,xci);
            
            if this.settings.plotOD
                figure(810),clf;
                subplot(1,2,1);
                plot(xpix(PeakMask),nx(PeakMask),'.','MarkerSize',20);
                hold on
                plot(xpix(~PeakMask),nx(~PeakMask),'.','MarkerSize',20);
                plot(xpix,fitfun(GaussianWingsX,xpix),'LineWidth',2);
                plot(xpix,fitfunBimod(xparam,xpix),'LineWidth',2);
                plot(xpix(PeakMaskP),fitInvParab(parabX,xpix(PeakMaskP)),'LineWidth',2);
                hold off
                % % Plot fit with data.


                ylabel('Amp');xlabel('x');
                xleg={strcat('aBEC = ',num2str(xparam(1),2),', aT=',num2str(GaussianWingsX(1),2),...
                     ' c= ', num2str(GaussianWingsX(2),2)),strcat('wBEC =',num2str(xparam(2)*GaussianWingsX(3),2), ' wT = ', ...
                     num2str(GaussianWingsX(3),2), ', xBEC= ', num2str(xparam(3),2), ', xT= ',num2str(GaussianWingsX(4),2))} ;           
                title(xleg);
            end
            
            
            
            % inv parab to peak fit:
            PeakMaskP = ny>0.3*max(ny);
            fitInvParab = @(p,x) p(1)*(1-(x-p(3)).^2./(p(2).^2)).^2;
            lb = [0,(ypix(end)-ypix(1))/100,ypix(1)];   % Inital (guess) parameters
            pGuess =  [max(ny),(ypix(end)-ypix(1))/20,ypix(find(ny==max(ny)))];
            ub =  [1.5*max(ny),(ypix(end)-ypix(1))/2,ypix(end)];
            
            optio = optimoptions('lsqcurvefit','Algorithm','trust-region-reflective','Display','off','MaxFunctionEvaluations',100);
            [parabY,~,residuals,~,~,~,J] = lsqcurvefit(fitInvParab,pGuess,ypix(PeakMaskP),ny(PeakMaskP),lb,ub,optio);
            
            
            
            %Obtain good starting guesses by first fitting a pure gaussian
            fitfun = @(p,x) p(1).*exp(-(x-p(4)).^2./(p(3).^2))+p(2);
            parameterNames = {'amplitude','offset','width','position'};
            
            lb = [0,min(ny),(ypix(end)-ypix(1))/100,ypix(1)];   % Inital (guess) parameters
            pGuess =  [max(ny),0,(ypix(end)-ypix(1))/20,ypix(find(ny==max(ny)))];
            ub =  [1.5*max(ny),0.5*max(ny),(ypix(end)-ypix(1))/2,ypix(end)];
            
            
            optio = optimoptions('lsqcurvefit','Algorithm','trust-region-reflective','Display','off','MaxFunctionEvaluations',100);
            [ggy,~,residuals,~,~,~,J] = lsqcurvefit(fitfun,pGuess,ypix,ny,lb,ub,optio);
            if(isempty(residuals))
                ci = NaN(4,2);
            else
                ci = nlparci(ggy,residuals,'jacobian',J,'alpha',1-0.68);
            end
            this.printFitReport(parameterNames,ggy,ci);
            
            
            %fit wings with pure gaussian
            lb = [0,min(ny),ypix(1),ypix(1)];  
            pGuess = [abs(ggy(1)/4), min(ny),ggy(3)*2, ggy(4)];
            ub =  [1.2*abs(ggy(1)),0.2*max(ny), ggy(3)*10,ypix(end)];
            
            
            PeakMask = (ypix>parabY(3)+ParabCut*parabY(2) | ypix < parabY(3)-ParabCut*parabY(2));
            
            optio = optimoptions('lsqcurvefit','Algorithm','trust-region-reflective','Display','off','MaxFunctionEvaluations',100);
            [GaussianWingsY,~,residuals,~,~,~,J] = lsqcurvefit(fitfun,pGuess,ypix(PeakMask),ny(PeakMask),lb,ub,optio);
            if(isempty(residuals))
                GaussianWingsYci = NaN(4,2);
            else
                GaussianWingsYci = nlparci(GaussianWingsY,residuals,'jacobian',J,'alpha',1-0.68);
            end
            this.printFitReport(parameterNames,GaussianWingsY,ci);
            
            
            %fit bimodal with only BEC variable
            fitfunBimod = @(p,x) GaussianWingsY(1).*exp(-(x-GaussianWingsY(4)).^2/(GaussianWingsY(3).^2))+p(1).*heaviside((1-(x-p(3)).^2./(GaussianWingsY(3).*p(2))^2)).*((1-(x-p(3)).^2./(GaussianWingsY(3).*p(2)).^2)).^2+GaussianWingsY(2);
            parameterNames = {'amplitude','width','position'};
            
            
            lb = [0,0,parabY(3)-parabY(2)];   % Inital (guess) parameters
            pGuess = [(ggy(1)),parabY(2)./GaussianWingsY(3), parabY(3)];
            ub =  [ggy(1)*1.5, 1,parabY(3)+parabY(2)];
            
            
            optio = optimoptions('lsqcurvefit','Algorithm','trust-region-reflective','Display','off','MaxFunctionEvaluations',100);
            [yparam,~,residuals,~,~,~,J] = lsqcurvefit(fitfunBimod,pGuess,ypix,ny,lb,ub,optio);
            if(isempty(residuals))
                yci = NaN(4,2);
            else
                yci = nlparci(yparam,residuals,'jacobian',J,'alpha',1-0.68);
            end
            this.printFitReport(parameterNames,yparam,yci);
            
            if this.settings.plotOD
                figure(810);
                subplot(1,2,2);
                plot(ypix(PeakMask),ny(PeakMask),'.','MarkerSize',20);
                hold on
                plot(ypix(~PeakMask),ny(~PeakMask),'.','MarkerSize',20);
                plot(ypix,fitfun(GaussianWingsY,ypix),'LineWidth',2);
                plot(ypix,fitfunBimod(yparam,ypix),'LineWidth',2);
                plot(ypix(PeakMaskP),fitInvParab(parabY,ypix(PeakMaskP)),'LineWidth',2);
                hold off
                % % Plot fit with data.
                ylabel('Amp');xlabel('y');
                yleg={strcat('aBEC = ',num2str(yparam(1),2),', aT=',num2str(GaussianWingsY(1),2),...
                     ' c= ', num2str(GaussianWingsY(2),2)),strcat('wBEC =',num2str(yparam(2)*GaussianWingsY(3),2), ' wT = ', ...
                     num2str(GaussianWingsY(3),2), ', xBEC= ', num2str(yparam(3),2), ', xT= ',num2str(GaussianWingsY(4),2))} ;           
                title(yleg);
            end
            
            this.analysis.fitBimodalExcludeCenter.parameterNames(analyzeIdx,:)          = parameterNames;
            this.analysis.fitBimodalExcludeCenter.xparam(analyzeIdx,:)                  = xparam;
            this.analysis.fitBimodalExcludeCenter.yparam(analyzeIdx,:)                  = yparam;
            this.analysis.fitBimodalExcludeCenter.xci(analyzeIdx,:,:)                   = xci;
            this.analysis.fitBimodalExcludeCenter.yci(analyzeIdx,:,:)                   = yci;
            this.analysis.fitBimodalExcludeCenter.GaussianWingsX(analyzeIdx,:)          = GaussianWingsX;
            this.analysis.fitBimodalExcludeCenter.GaussianWingsY(analyzeIdx,:)          = GaussianWingsY;
            this.analysis.fitBimodalExcludeCenter.GaussianWingsXci(analyzeIdx,:,:)      = GaussianWingsXci;
            this.analysis.fitBimodalExcludeCenter.GaussianWingsYci(analyzeIdx,:,:)      = GaussianWingsYci;
            
            
        end
        
        function fitIntegratedBoseMaskedOutdated(this,currentImageIdx,mu,tof,OmegaX,OmegaZ,varargin)
            %Fits a g5/2 thermal bose function to a bimodally-distributed cloud
            %with the user-defined portion of the BEC masked out
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %Inputs: image, chemical potential of BEC in Joules, 
            %TOF parameter in ms, trap frequencies, optional blacked
            %out threshold (typ 3.5)
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %Outputs: x and z temperatures, amp, center, offset
            %Formula for boson thermal line density follows Naraschewski paper Eqn. 20 for
            %mu_reduced<0

            p = inputParser;
            p.addParameter('BlackedOutODThreshold',3);
            p.addParameter('camPix',2.5e-6); %meters
            p.parse(varargin{:});
            BlackedOutODThreshold   = p.Results.BlackedOutODThreshold;
            camPix                  =p.Results.camPix;
            

            if strcmp(currentImageIdx,'last')
                currentImageIdx = length(this.images.ODImages(:,1,1));
                analyzeIdx = length(this.parameters);
            elseif this.settings.storeImages
                analyzeIdx = currentImageIdx;
            else
                currentImageIdx = 1;
                analyzeIdx = length(this.parameters);
            end
            if strcmp(this.settings.plotImage,'original')
                croppedODImage = squeeze(this.images.ODImages(currentImageIdx,:,:));
            elseif strcmp(this.settings.plotImage,'filtered')
                croppedODImage = squeeze(this.images.ODImagesFiltered(currentImageIdx,:,:));
                croppedODImage=croppedODImage/this.settings.superSamplingFactor;
            elseif strcmp(this.settings.plotImage,'averaged')
                croppedODImage = squeeze(this.images.ODImagesAveraged(currentImageIdx,:,:));

            end
            %estimate center of cloud
            integratedAlongY = sum(croppedODImage,1); %ycam z-axis
            integratedAlongX = sum(croppedODImage,2)'; %ycam x-axis

            maxy=max(integratedAlongY);
            maxx=max(integratedAlongX);
            

            parameterNames = {'Temperature(Kelvin)','amp','center','offset'};
            %exclude BEC region
            if(~isnan(BlackedOutODThreshold))
                    ODmask = croppedODImage>BlackedOutODThreshold;
                    croppedODImage(ODmask) = NaN;
            end
            
            xvals = sum(croppedODImage,2); %ycam z-axis
            zvals = sum(croppedODImage,1)'; %ycam x-axis
            %coordinates in meters
            
%             camPix=2.5e-6; %ycam meters per pixel

            
            xcoords = [1:length(xvals)];
            zcoords = [1:length(zvals)];
            if strcmp(this.settings.plotImage,'averaged')
                xcoords=xcoords*this.settings.pixelAveraging;
                zcoords=zcoords*this.settings.pixelAveraging;
            end
            %params: Temp, amplitude, center, offset
            fitfun =@(p,x) p(4)+p(2)*PolyLog(2.5, exp(-abs((mu-1/2*mNa*OmegaX^2/(1+OmegaX^2*tof^2/1e6)*(x-p(3)).^2))./(kB*p(1))));
                       
            ub =    [1e-6   2*maxy  xcoords(end)*camPix     abs(maxy)/2];
            lb=     [10e-9          0       0                      min(xvals)];
            pGuess= [100e-9   maxy/2    xcoords(end)/2*camPix   (xvals(1)+xvals(end))/2];
           
            opts = optimoptions('lsqcurvefit','Algorithm','trust-region-reflective','Display','off','MaxFunctionEvaluations',1000);
            
            [xcoords,xvals]=prepareCurveData(xcoords,xvals'); %remove Nan

            [param,~,residuals,~,~,~,J] = lsqcurvefit(fitfun,pGuess,xcoords*camPix,xvals,lb,ub,opts);
            
            
            if(isempty(residuals))
                ci = NaN(4,2);
            else
                ci = nlparci(param,residuals,'jacobian',J,'alpha',1-0.68);
            end
            
            this.printFitReport(parameterNames,param,ci);
            this.analysis.fitIntegratedBoseMaskedX.parameterNames(analyzeIdx,:)  = parameterNames;
            this.analysis.fitIntegratedBoseMaskedX.param(analyzeIdx,:)           = param;
            this.analysis.fitIntegratedBoseMaskedX.ci(analyzeIdx,:,:)            = ci;
            %take into account supersampling on fitted length scales:
            %center and location
            if strcmp(this.settings.plotImage,'filtered')
                this.analysis.fitIntegratedBoseMaskedX.param(analyzeIdx,2:3)=this.analysis.fitIntegratedBoseMaskedX.param(analyzeIdx,2:3)/this.settings.superSamplingFactor;
                this.analysis.fitIntegratedBoseMaskedX.ci(analyzeIdx,2:3,:)=this.analysis.fitIntegratedBoseMaskedX.ci(analyzeIdx,2:3,:)/this.settings.superSamplingFactor;
            
            end
            %plot fit 
            figure(11);
            clf;
            subplot(1,2,1);            hold on;
            plot(xcoords,fitfun(param,xcoords*camPix),'LineWidth',1.5);
            plot(xcoords,xvals,'bo');
            xlabel('x coordinate (= pixel if supersampling=1)');
            title(strcat('T(nK) = ',num2str(param(1)*10^9)));
            
            %%%%%%%%%%%%% 2nd dimension %%%%%%%%%%%%%%%%%%%%%
            fitfun =@(p,x) p(4)+p(2)*PolyLog(2.5, exp(-abs((mu-1/2*mNa*OmegaZ^2/(1+OmegaZ^2*tof^2/1e6)*(x-p(3)).^2))./(kB*p(1))));
            [zcoords, zvals]=prepareCurveData(zcoords,zvals');
            %integrated along x guesses
            ub =    [1e-6   2*maxx  zcoords(end)*camPix*.75    abs(maxx)/2];
            lb=     [10e-9          0       zcoords(end)*camPix*.25    min(zvals)];
            pGuess= [100e-9    maxx/2    zcoords(end)/2*camPix   (zvals(1)+zvals(end))/2];
           
            opts = optimoptions('lsqcurvefit','Algorithm','trust-region-reflective','Display','off','MaxFunctionEvaluations',1000);
            [param,~,residuals,~,~,~,J] = lsqcurvefit(fitfun,pGuess,zcoords*camPix,zvals,lb,ub,opts);
            if(isempty(residuals))
                ci = NaN(4,2);
            else
                ci = nlparci(param,residuals,'jacobian',J,'alpha',1-0.68);
            end
            
            this.printFitReport(parameterNames,param,ci);
            this.analysis.fitIntegratedBoseMaskedY.parameterNames(analyzeIdx,:)  = parameterNames;
            this.analysis.fitIntegratedBoseMaskedY.param(analyzeIdx,:)           = param;
            this.analysis.fitIntegratedBoseMaskedY.ci(analyzeIdx,:,:)            = ci;
            %take into account supersampling on fitted length scales:
            %center and location
            if strcmp(this.settings.plotImage,'filtered')
                this.analysis.fitIntegratedBoseMaskedY.param(analyzeIdx,2:3)=this.analysis.fitIntegratedBoseMaskedY.param(analyzeIdx,2:3)/this.settings.superSamplingFactor;
                this.analysis.fitIntegratedBoseMaskedY.ci(analyzeIdx,2:3,:)=this.analysis.fitIntegratedBoseMaskedY.ci(analyzeIdx,2:3,:)/this.settings.superSamplingFactor;
            
            end

            
            subplot(1,2,2);
            plot(zcoords,fitfun(param,zcoords*camPix),'LineWidth',1.5);
            hold on
            plot(zcoords,zvals,'o');
            xlabel('z coordinate');
            title(strcat('T(nK) = ',num2str(param(1)*10^9)));
            hold off
            drawnow;
        end
        
    end
    
end