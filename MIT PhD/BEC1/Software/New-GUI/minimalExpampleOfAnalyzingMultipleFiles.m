%% minimal example of fermi1 image analysis

% create new measurement object

meas = Measurement('Na','plotImage','original','NormType','Box','plotOD',false,...
                    'verbose',false,'storeImages',false,'recenterMarqueeBox',false);
                
filenames = dir('*.fits');
for idx = 1:length({filenames.name})            
    meas.loadFITSImageFromFileName(1,filenames(idx).name)   

    meas.fitBimodalExcludeCenter('last','BlackedOutODthreshold',4,'useLineDensity',true);
    meas.fitIntegratedGaussian('last','useLineDensity',true);
end
