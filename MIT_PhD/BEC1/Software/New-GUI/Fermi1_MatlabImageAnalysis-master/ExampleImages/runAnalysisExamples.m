% copy files back from done folder
if((exist( 'done\')==7))
    files= dir([pwd '\done\'  '*spe']);
    for idx = 1:length(files)
        movefile(['done\' files(idx).name],[pwd]);
    end
end
%%
% copy files back from done folder
if((exist( 'done\')==7))
    files= dir([pwd '\done\'  '*spe']);
    for idx = 1:length(files)
        movefile(['done\' files(idx).name],[pwd]);
    end
end
% actual analysis
params = [800
    802
    804
    806
    808
    810
    812
    814
    816
    818
    820
    822];

measK40 = Measurement('run2b_K40','imageStartKeyword','K','sortFilesBy','name','plotImage','filtered');

measK40.settings.AbbeRadius = 3;
measK40.settings.superSamplingFactor = 2;
measK40.settings.GaussianFilterWidth = 1.0;

for(idx = 1:length(params))
    measK40.loadNewestSPEImage(params(idx));
    measK40.fit2DGaussian(idx);
    measK40.inverseAbel(idx);
    measK40.quickEstimateCentralDensity(idx);
    measK40.fitFermi1D(idx);
    measK40.fitBimodal(idx);
    waitforbuttonpress;
end

%% examples of various things
figure(15),clf;
plot(measK40.parameters,measK40.analysis.inverseAbel.Densities(:,1),'.','MarkerSize',20)
hold on
plot(measK40.parameters,measK40.analysis.quickEstimateCentralDensitys,'.','MarkerSize',20)
plot(measK40.parameters,measK40.analysis.bareNcntValues'./(measK40.analysis.fit2DGauss.param(:,5).*measK40.analysis.fit2DGauss.param(:,5).*measK40.analysis.fit2DGauss.param(:,6)).^1.5,'.','MarkerSize',20)
hold off


%%
% reset Marquee Box:
measK40.setMarqueeBox;

% redo analysis after shifting marquee box
for(idx = 1:length(measK40.parameters))
    measK40.bareNcnt(idx);      % calculates bare N
    measK40.plotODImage(idx);      % plots the image
    measK40.fit2DGaussian(idx);
end

%% save measurement
measK40.save
