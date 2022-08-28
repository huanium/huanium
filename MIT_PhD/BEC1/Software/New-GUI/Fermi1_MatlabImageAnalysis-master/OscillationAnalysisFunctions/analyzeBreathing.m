function analyzeBreathing(params)
    
    largeMBwidthX = 250;
    largeMBwidthY = 100;
    smallMBwidthX = 140;
    smallMBwidthY = 100;

    %smallMBwidthX = 250;
    %smallMBwidthY = 70;
    smallMBwidthX = 40;
    smallMBwidthY = 80;

    LineDensityXMBwidthX = 200;
    LineDensityXMBwidthY = 20;
    
    OD_MBwidthX = 200;
    OD_MBwidthY = 80;


    countingMBlargeX = 80;
    countingMBlargeY = 60;
    countingMBsmallX = 40;
    countingMBsmallY = 30;

    BECoffsetX = -650+6;%-6;
    BECoffsetY = 12;

    averageYCenterK  = 167-20;
    averageYCenterNa = 178-20;

    LineDensityPixelAv = 1;
    measNa = Measurement('Na','imageStartKeyword','dual','sortFilesBy','name',...
                    'plotImage','original','NormType','Box','plotOD',false,...
                    'verbose',false,'storeImages',false,'recenterMarqueeBox',false);
    measNa.settings.avIntPerPixelThreshold    = 0.1;
    measNa.settings.LineDensityPixelAveraging = LineDensityPixelAv; 

    measK = Measurement('K','imageStartKeyword','dual','sortFilesBy','name',...
                    'plotImage','original','NormType','Box','plotOD',false,...
                    'verbose',false,'storeImages',false,'recenterMarqueeBox',false);
    measK.settings.avIntPerPixelThreshold    = 0.1;
    measK.settings.LineDensityPixelAveraging = LineDensityPixelAv;  


    measNa.analysis.NcntLarge = [];
    measNa.analysis.NcntSmall = [];
    measK.analysis.NcntLarge = [];
    measK.analysis.NcntSmall = [];

    measNa.analysis.fitBimodalExcludeCenter_medium.GaussianWingsX   = [];
    measNa.analysis.fitBimodalExcludeCenter_medium.GaussianWingsY   = [];
    measNa.analysis.fitBimodalExcludeCenter_medium.xparam           = [];
    measNa.analysis.fitBimodalExcludeCenter_medium.yparam           = [];



    ODimageKStack   = []; 
    ODimageNaStack  = [];


    defaultNaBox = [50 120 largeMBwidthX largeMBwidthY/2 ];
    measNa.settings.marqueeBox  = defaultNaBox;
    measNa.settings.normBox     = [60   187   227    19];
    measK.settings.marqueeBox   = [727 81 smallMBwidthX smallMBwidthY ];  
    measK.settings.normBox      = [722    53    12   160];

    centerXall = 400;
    TOF = 0.0;


    im = [];

    lineDensityNaMatrix = [];
    lineDensityKMatrix = [];

    lineDensityXNaMatrix = [];
    lineDensityXKMatrix = [];

    OmegaX = 2*pi*12.2;
    OmegaY = 2*pi*94;
    OmegaZ = 2*pi*103;
    tic
    trueIdx = 0;
    for idx = 1:length(params)
        measNa.loadNewestSPEImage(params(idx));
        measK.loadNewestSPEImage(params(idx));
        if(measNa.lastImageBad || measK.lastImageBad ) % only do analysis if images were good
            if ~measNa.lastImageBad
                measNa.setLastShotBad;
            end
            if ~measK.lastImageBad
                measK.setLastShotBad;
            end
        else

            trueIdx = trueIdx+1;
            % Na initial fit to get position with large MB
            measNa.fitIntegratedGaussian('last');
            measNa.fitBimodalExcludeCenter('last','BlackedOutODthreshold',4.1,'useLineDensity',true);
            measNa.analysis.fitBimodalExcludeCenter_medium.GaussianWingsX(end+1,:) = measNa.analysis.fitBimodalExcludeCenter.GaussianWingsX(end,:);
            measNa.analysis.fitBimodalExcludeCenter_medium.GaussianWingsY(end+1,:) = measNa.analysis.fitBimodalExcludeCenter.GaussianWingsY(end,:);
            measNa.analysis.fitBimodalExcludeCenter_medium.xparam(end+1,:) = measNa.analysis.fitBimodalExcludeCenter.xparam(end,:);
            measNa.analysis.fitBimodalExcludeCenter_medium.yparam(end+1,:) = measNa.analysis.fitBimodalExcludeCenter.yparam(end,:);
            % set Na small MB and refit small box 
            centerX_Na = round(LineDensityPixelAv*measNa.analysis.fitBimodalExcludeCenter.xparam(end,3)+measNa.settings.marqueeBox(1));
            centerY_Na = round(LineDensityPixelAv*measNa.analysis.fitBimodalExcludeCenter.yparam(end,3)+measNa.settings.marqueeBox(2));
            measNa.settings.marqueeBox=[max(centerX_Na-smallMBwidthX/2,1) max(centerY_Na-smallMBwidthY/2,1) smallMBwidthX smallMBwidthY ];
            measNa.flushAllODImages();
            measNa.createODimage('last');
            measNa.createLineDensities();
            measNa.fitBimodalExcludeCenter('last','BlackedOutODthreshold',4,'TFcut',1,'useLineDensity',true);

            % center on small box 
            centerY_Na = round(LineDensityPixelAv*measNa.analysis.fitBimodalExcludeCenter.yparam(end,3)+measNa.settings.marqueeBox(2));
            %measNa.settings.marqueeBox=[max(centerX_Na-smallMBwidthX/2,1) max(centerY_Na-smallMBwidthY/2,1) smallMBwidthX smallMBwidthY ];
            measNa.settings.marqueeBox=[max(centerX_Na-smallMBwidthX/2,1) 107 smallMBwidthX smallMBwidthY ];
            measNa.flushAllODImages();
            measNa.createODimage('last');
            measNa.createLineDensities();
            %measNa.lineDensities.Xintegrated = measNa.lineDensities.Xintegrated.*filterFunction;

            measNa.fitBimodalExcludeCenter('last','BlackedOutODthreshold',4,'TFcut',1,'useLineDensity',true);
            measNa.fitBimodalBose('last',OmegaY,OmegaX,'camPix',2.81e-6,'TFCut',.9,'BoseTFCut',1.2,'BlackedOutODThreshold',6,'TOF',TOF/1000,'useLineDensity',true);
            measNa.fitIntegratedGaussian('last','useLineDensity',true,'fitX',true);
            measNa.plotODImage('last');
            lineDensityNa   = measNa.lineDensities.Xintegrated(end,:);
            ODimageNa = squeeze(measNa.images.ODImages(1,:,:));
            lineDensityNaMatrix(end+1,:) = lineDensityNa;

            centerX = centerX_Na-BECoffsetX;
            centerY = centerY_Na-BECoffsetY;
            %measK.settings.marqueeBox=[max(centerX-smallMBwidthX/2,1) max(centerY-smallMBwidthY/2,1) smallMBwidthX/1 smallMBwidthY ];
            measK.settings.marqueeBox=[max(centerX-smallMBwidthX/4,1) 95 smallMBwidthX/2 smallMBwidthY ];
            measK.flushAllODImages();
            measK.createODimage('last');
            measK.createLineDensities();
            %measK.lineDensities.Xintegrated = measK.lineDensities.Xintegrated.*filterFunction;

            measK.fitBimodalExcludeCenter('last','BlackedOutODthreshold',4,'TFcut',1.2,'useLineDensity',true);
            measK.fitIntegratedGaussian('last','useLineDensity',true,'fitX',true);
            measK.plotODImage('last');
            lineDensityKMatrix(end+1,:)  = measK.lineDensities.Xintegrated(end,:);
            ODimageK = squeeze(measK.images.ODImages(1,:,:));
           


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
            % K large box
            centerY = round(measK.settings.LineDensityPixelAveraging*measK.analysis.fitBimodalExcludeCenter.yparam(end,3)+measK.settings.marqueeBox(2));
            measK.settings.marqueeBox=[min(max(centerX-countingMBlargeX/2,1),1024-countingMBlargeX) ...
                                           min(max(centerY-countingMBlargeY/2,1),333-countingMBlargeY) ...
                                            countingMBlargeX countingMBlargeY ];

            measK.flushAllODImages();
            measK.createODimage('last');
            measK.plotODImage('last');
            measK.bareNcntAverageMarqueeBox;
            measK.analysis.NcntLarge(end+1) = measK.analysis.bareNcntAverageMarqueeBoxValues(end);
            % Na small box
            measK.settings.marqueeBox=[min(max(centerX-countingMBsmallX/2,1),1024-countingMBsmallX) ...
                                           min(max(centerY-countingMBsmallY/2,1),333-countingMBsmallY) ...
                                            countingMBsmallX countingMBsmallY ];
            measK.flushAllODImages();
            measK.createODimage('last');
            measK.plotODImage('last');
            measK.bareNcntAverageMarqueeBox;
            measK.analysis.NcntSmall(end+1) = measK.analysis.bareNcntAverageMarqueeBoxValues(end);


            % x linedensity
            measNa.settings.marqueeBox=[min(max(centerX_Na-LineDensityXMBwidthX/2,1),1024-LineDensityXMBwidthX)...
                                        min(max(centerY_Na-LineDensityXMBwidthY/2,1),333-LineDensityXMBwidthY)...
                                        LineDensityXMBwidthX LineDensityXMBwidthY ];
            measNa.flushAllODImages();
            measNa.createODimage('last');
            measNa.createLineDensities();
            measNa.plotODImage('last');

            measK.settings.marqueeBox=[min(max(centerX-LineDensityXMBwidthX/2,1),1024-LineDensityXMBwidthX)...
                                        min(max(centerY-LineDensityXMBwidthY/2,1),333-LineDensityXMBwidthY)...
                                        LineDensityXMBwidthX/1 LineDensityXMBwidthY ];
            measK.flushAllODImages();
            measK.createODimage('last');
            measK.createLineDensities();
            measK.plotODImage('last');

            lineDensityXKMatrix(end+1,:)  = measK.lineDensities.Yintegrated(end,:);
            lineDensityXNaMatrix(end+1,:) = measNa.lineDensities.Yintegrated(end,:);
            
            
            % nice large OD images
            measNa.settings.marqueeBox=[min(max(centerX_Na-OD_MBwidthX/2,1),1024-OD_MBwidthX)...
                                        min(max(centerY_Na-OD_MBwidthY/2,1),333-OD_MBwidthY)...
                                        OD_MBwidthX OD_MBwidthY ];
            measNa.flushAllODImages();
            measNa.createODimage('last');
            measNa.createLineDensities();
            measNa.plotODImage('last');

            measK.settings.marqueeBox=[min(max(centerX-OD_MBwidthX/2,1),1024-OD_MBwidthX)...
                                        min(max(centerY-OD_MBwidthY/2,1),333-OD_MBwidthY)...
                                        OD_MBwidthX/1 OD_MBwidthY ];
            measK.flushAllODImages();
            measK.createODimage('last');
            measK.createLineDensities();
            measK.plotODImage('last');

            ODimageK = squeeze(measK.images.ODImages(1,:,:));
            ODimageKStack(trueIdx,:,:) = ODimageK;
            
            ODimageNa = squeeze(measNa.images.ODImages(1,:,:));
            ODimageNaStack(trueIdx,:,:) = ODimageNa;

            
            
            % make side by side movie 
            figure(881),clf;
            subplot(1,2,1);
                imagesc(ODimageNa);
                colormap(gca,flipud(bone));
                axis equal
                caxis([-0.2,2])
                colorbar
                title(['Na freq: ' num2str(params(trueIdx)) 'Hz'])
            subplot(1,2,2);
                imagesc(ODimageK);
                colormap(gca,flipud(bone));
                axis equal
                caxis([-0.05,0.5])
                colorbar
                title(['K freq: ' num2str(params(trueIdx)) 'Hz'])
            frame = getframe(gcf);
            im = frame2im(frame); 
            [imind,cm] = rgb2ind(im,256); 
            % Write to the GIF File 
            filename = 'SideBySide.gif';
            if idx == 1 
              imwrite(imind,cm,filename,'gif','DelayTime',0.1, 'Loopcount',inf); 
            else 
              imwrite(imind,cm,filename,'gif','WriteMode','append'); 
            end 
            
            
            % set back to large MB
            measNa.settings.marqueeBox=defaultNaBox;
            measNa.flushAllODImages();
        end       
    end

    save('measNa','measNa');
    save('measK','measK');
    save('ODimageKStack','ODimageKStack');
    save('ODimageNaStack','ODimageNaStack');
    save('lineDensityNaMatrix','lineDensityNaMatrix')
    save('lineDensityKMatrix','lineDensityKMatrix')
    save('lineDensityXKMatrix','lineDensityXKMatrix')
    save('lineDensityXNaMatrix','lineDensityXNaMatrix')
    toc

end