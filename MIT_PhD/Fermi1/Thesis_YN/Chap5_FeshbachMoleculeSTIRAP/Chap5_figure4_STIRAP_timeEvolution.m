%% load data
clear;
cd(fileparts(matlab.desktop.editor.getActiveFilename));

% 804nm Feshbach molecule STIRAP time evolution 

dir_FBmol804nmT9 = '..\..\202206\220628\run9_STIRAP_TimeEvolution_20usSingleTripTime_TiSaHoldLock';
FBmol804nmT9 = load([dir_FBmol804nmT9 '\analysisContainer.mat']);
FBmol804nmT9_ODimages = BECanalysis_loader(dir_FBmol804nmT9);
FBmol804nmT9.t_STIRAP = 20;
ncnt2atomnumber = 480;


f4444=figure(4444);clf;
f4444.Position = [f4444.Position(1) f4444.Position(2) 560   600];
xlimit = [-1,41];
subplot(4,1,1);hold on; box on;
plot(FBmol804nmT9.analysisContainer.fit_STIRAP.t_us,...
     FBmol804nmT9.analysisContainer.fit_STIRAP.Rabi_upleg/FBmol804nmT9.analysisContainer.fit_STIRAP.gamma_e,...
     'linewidth',2,'color',[0.8500 0.3250 0.0980]);
plot(FBmol804nmT9.analysisContainer.fit_STIRAP.t_us,...
     FBmol804nmT9.analysisContainer.fit_STIRAP.Rabi_downleg/FBmol804nmT9.analysisContainer.fit_STIRAP.gamma_e,...
     'linewidth',2,'color',[0.4660 0.6740 0.1880]);
ylim([0 0.8]);
xlim(xlimit);
ylabel('\Omega/\gamma_e');
set(gca, 'FontName', 'Arial','FontSize', 16,...
    'XTickLabel',[])

subplot(4,1,2:4);hold on; box on;
ylimit = [-5e3,9e4];

plot(FBmol804nmT9.analysisContainer.FitXval*1e6,...
     FBmol804nmT9.analysisContainer.FitYval*FBmol804nmT9.analysisContainer.NcntNormFactor*ncnt2atomnumber,...
    'k-','LineWidth',3,'color',[0 0 0 0.3]);


errorbar(FBmol804nmT9.analysisContainer.DataAverage.xvalsAveraged,...
         FBmol804nmT9.analysisContainer.DataAverage.yvalsAveraged*FBmol804nmT9.analysisContainer.NcntNormFactor*ncnt2atomnumber,...
         FBmol804nmT9.analysisContainer.DataAverage.yStdAveraged*FBmol804nmT9.analysisContainer.NcntNormFactor*ncnt2atomnumber,...
         '.','MarkerSize',30,'CapSize',0,'Color',[0 0 0],'LineWidth',2);

xlim(xlimit);
ylim(ylimit);

xlabel('time \mus');
ylabel('^{40}K atom number');
set(gca, 'FontName', 'Arial')
set(gca,'FontSize', 16);

%%
% plot OD image of thermal polarons 
Z_cam_pix_size = 2.45*1.06;
limOD = [-0.1 0.31];
% selected_index = [1 8 19];
selected_index = [19];
for jdx = 1:length(selected_index)
    idx = selected_index(jdx);
    figure(100+idx);clf;
    
    t = tiledlayout(2,1);
    
    nexttile;
        imagesc(squeeze(FBmol804nmT9_ODimages.K_OD_images(idx,:,:)));
        box off; axis off;
        caxis(limOD);
        axis equal;
        colormap(flipud(bone));
        c=colorbar;
        c.Ticks = [0 0.3];
        c.FontSize = 12;
        c.Label.String = 'optical density';
        c.Location = 'west';
        title(['t_{STIRAP}=' num2str(FBmol804nmT9.analysisContainer.DataAverage.xvalsAveraged(selected_index(jdx)))]);
        hold on;
        line([0 100/Z_cam_pix_size],[5 5],'color',[0 0 0],'linewidth',1.5);
        text(3,12,'100\mum','fontsize',16);
        
    nexttile;
        imagesc(squeeze(FBmol804nmT9_ODimages.Na_OD_images(idx,:,:)));
        box off; axis off;
        caxis(limOD);
        axis equal;
        colormap(flipud(bone));
        c = colorbar;
        c.Ticks = [0 0.3];
        c.FontSize = 12;
        c.Label.String = 'optical density';
        c.Location = 'west';
        
        
    t.Padding = 'none';
    t.TileSpacing = 'none';
    print('ODimages_t40us','-dpdf');
end


%%
function output = BECanalysis_loader(dir)

load([dir '\BECanalysis.mat'],'BECanalysis');

output = BECanalysis;

end