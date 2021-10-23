measK = Measurement(KSpecies,'imageStartKeyword',KSpecies,'sortFilesBy','name','plotImage','original',...
                        'NormOff' ,false,'NormType','Box','removeBeamIris',false);
                    
measK.settings.marqueeBox = [200,200,10,10];
measK.settings.normBox = [10,10,10,10];
measK.settings.pixelAveraging = 10;

measK.settings.avIntPerPixelThreshold = 0;
measK.loadNewestSPEImage(1,'testing',1);