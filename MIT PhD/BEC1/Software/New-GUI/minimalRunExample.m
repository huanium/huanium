%% minimal example of fermi1 image analysis

% create new measurement object

meas = Measurement('Na','plotImage','original','NormType','Box','plotOD',false,...
                    'verbose',false,'storeImages',false,'recenterMarqueeBox',false);
      
% load image into system             
meas.loadFITSImageFromFileName(1,'W:\Fermi3\Images\2021\2021-10\2021-10-05\2021-10-05_18-39-15_iXon.fits')   

%% plot OD 
meas.plotODImage('last')

%% fit Bimodal
meas.fitBimodalExcludeCenter('last','BlackedOutODthreshold',0.1,'useLineDensity',true);
%%
meas.fitBimodal('last')

%% fit Gaussian
meas.fitIntegratedGaussian('last','useLineDensity',true);

%%
tempFromBoseFit(meas,1)