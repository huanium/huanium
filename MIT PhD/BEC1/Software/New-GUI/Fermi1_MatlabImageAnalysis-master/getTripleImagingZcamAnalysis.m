function [struct_out] = getTripleImagingZcamAnalysis(filepathK1, filepathK2, filepathNa)
ScanParmater = 0;

largeMBwidthX = 250;
largeMBwidthY = 100;

smallMBwidthX = 240;
smallMBwidthY = 100;

countingMBX = 100;
countingMBY = 16;

BECoffsetX = -654;
BECoffsetY = 14;

averageYCenterK  = 167-20;
averageYCenterNa = 178-20;

measNa = Measurement('Na','imageStartKeyword','Na','sortFilesBy','name',...
                'plotImage','original','NormType','Box','plotOD',false,...
                'verbose',false,'storeImages',false,'recenterMarqueeBox',false);
measNa.settings.avIntPerPixelThreshold    = 0.1;
measNa.settings.LineDensityPixelAveraging = 2; 

measK1 = Measurement('K','imageStartKeyword','K1','sortFilesBy','name',...
                'plotImage','original','NormType','Box','plotOD',false,...
                'verbose',false,'storeImages',false,'recenterMarqueeBox',false);
measK1.settings.avIntPerPixelThreshold    = 0.1;
measK1.settings.LineDensityPixelAveraging = 2; 


measK2 = Measurement('K','imageStartKeyword','K2','sortFilesBy','name',...
                'plotImage','original','NormType','Box','plotOD',false,...
                'verbose',false,'storeImages',false,'recenterMarqueeBox',false);
measK2.settings.avIntPerPixelThreshold    = 0.1;
measK2.settings.LineDensityPixelAveraging = 2; 

defaultNaBox = [21 93 largeMBwidthX largeMBwidthY ];
measNa.settings.marqueeBox  = defaultNaBox;
measNa.settings.normBox     = [95    96   159     8];
measK1.settings.marqueeBox   = [727 81 smallMBwidthX smallMBwidthY ];  
measK1.settings.normBox      = [722    78   208    10];
measK2.settings.marqueeBox   = [727 81 smallMBwidthX smallMBwidthY ];  
measK2.settings.normBox      = [722    78   208    10];
centerXall = 400;
TOF = 0.0;

im = [];

measNa.analysis.lineDensityNaMatrix     = [];
measNa.analysis.ODimageNaStack          = [];
measK1.analysis.lineDensityKMatrix       = [];
measK1.analysis.ODimageKStack            = []; 
measK1.analysis.NcntSmall                = [];
measK2.analysis.lineDensityKMatrix       = [];
measK2.analysis.ODimageKStack            = []; 
measK2.analysis.NcntSmall                = [];

OmegaX = 2*pi*12.2;
OmegaY = 2*pi*94;
OmegaZ = 2*pi*103;

tic
trueIdx = 0;
% load new images for K and Na
measNa.loadNewestSPEImage(ScanParmater,'FilePath',filepathNa);
measK1.loadNewestSPEImage(ScanParmater,'FilePath',filepathK1);
measK2.loadNewestSPEImage(ScanParmater,'FilePath',filepathK2);
if(~measNa.lastImageBad && ~measK1.lastImageBad && ~measK2.lastImageBad) % only do analysis if images were good
    %fit Na with large box
    trueIdx = trueIdx+1;
    measNa.fitIntegratedGaussian('last');
    % set Na small MB and refit
    centerX_Na = round(2*measNa.analysis.fitIntegratedGaussX.param(end,3)+measNa.settings.marqueeBox(1));
    centerX_Na = max(centerX_Na,smallMBwidthX/2+2);
    centerY_Na = round(2*measNa.analysis.fitIntegratedGaussY.param(end,3)+measNa.settings.marqueeBox(2));
    if isnan(centerY_Na)
        centerY_Na = 93;
    end
    %make small MB for Na and do proper analysis
    measNa.settings.marqueeBox=[centerX_Na-smallMBwidthX/2 centerY_Na-smallMBwidthY/2 smallMBwidthX smallMBwidthY ];
    measNa.flushAllODImages();
    measNa.createODimage('last');
    measNa.createLineDensities();
    measNa.fitBimodalExcludeCenter('last','BlackedOutODthreshold',4,'TFcut',1.2,'useLineDensity',false);
    measNa.fitBimodalBose('last',OmegaY,OmegaX,'camPix',2.81e-6,'TFCut',.9,'BoseTFCut',1.2,'BlackedOutODThreshold',6,'TOF',TOF/1000,'useLineDensity',false);
    measNa.fitIntegratedGaussian('last','useLineDensity',true);
    
    %save some additional things
    ODimageNa                                   = squeeze(measNa.images.ODImages(1,:,:));
    measNa.analysis.ODimageNaStack(trueIdx,:,:) = ODimageNa;
    lineDensityNa                               = measNa.lineDensities.Yintegrated(end,:);
    measNa.analysis.lineDensityNaMatrix(end+1,:)= lineDensityNa;
    
    %make K1 MB based on Na and analyze
    centerX = centerX_Na-BECoffsetX;
    centerY = centerY_Na-BECoffsetY;
    measK1.settings.marqueeBox=[centerX-smallMBwidthX/4 centerY-smallMBwidthY/32 smallMBwidthX/2 smallMBwidthY/16 ];
    measK1.flushAllODImages();
    measK1.createODimage('last');
    measK1.createLineDensities();
    measK1.fitIntegratedGaussian('last','useLineDensity',true,'fitY',false);
    
    %save some additional things
    ODimageK                                    = squeeze(measK1.images.ODImages(1,:,:));
    measK1.analysis.ODimageKStack(trueIdx,:,:)   = ODimageK;
    lineDensityK                                = measK1.lineDensities.Yintegrated(end,:);
    measK1.analysis.lineDensityKMatrix(end+1,:)  = lineDensityK;
    
    
    % K1 counting in small box
    measK1.settings.marqueeBox=[centerX-countingMBX/2 ...
        centerY-countingMBY/2 ...
        countingMBX countingMBY ];
    measK1.flushAllODImages();
    measK1.createODimage('last');
    measK1.plotODImage('last');
    measK1.bareNcntAverageMarqueeBox;
    measK1.analysis.NcntSmall(end+1) = measK1.analysis.bareNcntAverageMarqueeBoxValues(end);
    
    
    %make K2 MB based on Na and analyze
    centerX = centerX_Na-BECoffsetX;
    centerY = centerY_Na-BECoffsetY;
    measK2.settings.marqueeBox=[centerX-smallMBwidthX/4 centerY-smallMBwidthY/32 smallMBwidthX/2 smallMBwidthY/16 ];
    measK2.flushAllODImages();
    measK2.createODimage('last');
    measK2.createLineDensities();
    measK2.fitIntegratedGaussian('last','useLineDensity',true,'fitY',false);
    
    %save some additional things
    ODimageK                                    = squeeze(measK2.images.ODImages(1,:,:));
    measK2.analysis.ODimageKStack(trueIdx,:,:)   = ODimageK;
    lineDensityK                                = measK2.lineDensities.Yintegrated(end,:);
    measK2.analysis.lineDensityKMatrix(end+1,:)  = lineDensityK;
    
    
    % K2 counting in small box
    measK2.settings.marqueeBox=[centerX-countingMBX/2 ...
        centerY-countingMBY/2 ...
        countingMBX countingMBY ];
    measK2.flushAllODImages();
    measK2.createODimage('last');
    measK2.plotODImage('last');
    measK2.bareNcntAverageMarqueeBox;
    measK2.analysis.NcntSmall(end+1) = measK2.analysis.bareNcntAverageMarqueeBoxValues(end);
    
    
    % set back to large MB
    measNa.settings.marqueeBox=defaultNaBox;
    measNa.flushAllODImages();
end

struct_out.K1_analysis = measK1.analysis; 
struct_out.K1_settings = measK1.settings;
struct_out.K2_analysis = measK2.analysis; 
struct_out.K2_settings = measK2.settings; 
struct_out.Na_analysis = measNa.analysis; 
struct_out.Na_settings = measNa.settings; 

end