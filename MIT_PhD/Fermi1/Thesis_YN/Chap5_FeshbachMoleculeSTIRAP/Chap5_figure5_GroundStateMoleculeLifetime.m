%% load data
clear;
cd(fileparts(matlab.desktop.editor.getActiveFilename));

% 804nm Feshbach molecule STIRAP time evolution 

dir_FBmol804nmT9 = '..\..\202206\220624\run8_GroundStateMoleculeLifetime5sNaLoading';
FBmolLifetime = load([dir_FBmol804nmT9 '\analysisContainer.mat']);
FBmolLifetime_ODimages = thermalAnalysis_loader(dir_FBmol804nmT9);
FBmolLifetime.t_STIRAP = 20;
ncnt2atomnumber = 480;


figure(5);clf;hold on; box on;
xlimit = [0,20];
ylimit = [0,4e4];

plot(FBmolLifetime.analysisContainer.FitXval*1e-3,...
     FBmolLifetime.analysisContainer.FitYval*ncnt2atomnumber,...
    'k-','LineWidth',3,'color',[0 0 0 0.3]);
% plot(FBmol804nmT9_2.analysisContainer.FitXval,...
%      FBmol804nmT9_2.analysisContainer.FitYval_G,...
%     'k--','LineWidth',2);

errorbar(FBmolLifetime.analysisContainer.DataAverage.xvalsAveraged*1e-3,...
         FBmolLifetime.analysisContainer.DataAverage.yvalsAveraged*ncnt2atomnumber,...
         FBmolLifetime.analysisContainer.DataAverage.yStdAveraged*ncnt2atomnumber,...
         '.','MarkerSize',30,'CapSize',0,'Color',[0 0 0],'LineWidth',2);

xlim(xlimit);
ylim(ylimit);

xlabel('time (ms)');
ylabel('Feshbach molecule number');
set(gca, 'FontName', 'Arial')
set(gca,'FontSize', 16);

% calculate the ground state molecule two body loss coefficient
beta_GSM_cm3s = 1/(FBmolLifetime.analysisContainer.fit_result(2)*1e-6)/...
              (FBmolLifetime_ODimages.averagedThermal.analysis.fitBose_ColumnDensity_z.nB_deBroglie*1e-6)

%%
% plot OD image of thermal polarons 
Z_cam_pix_size = 2.45*1.06;
limOD = [-0.1 1];
% selected_index = [1 8 19];
selected_index = [1];
for jdx = 1:length(selected_index)
    idx = selected_index(jdx);
    figure(100+idx);clf;
    
    t = tiledlayout(2,1);
    t.Padding = 'none';
    t.TileSpacing = 'none';
    
    nexttile;
        imagesc(squeeze(FBmolLifetime_ODimages.K_OD_images(idx,:,:)));
        box off; axis off;
        caxis(limOD);
        axis equal;
        colormap(flipud(bone));
        c=colorbar;
        c.Ticks = [0 1];
        c.FontSize = 12;
        c.Label.String = 'optical density';
        c.Location = 'west';
        title(['t_{hold}=' num2str(FBmolLifetime.analysisContainer.DataAverage.xvalsAveraged(selected_index(jdx)))]);
        hold on;
        line([0 100/Z_cam_pix_size],[5 5],'color',[0 0 0],'linewidth',1.5);
        text(3,12,'100\mum','fontsize',16);
        
    nexttile;
        imagesc(squeeze(FBmolLifetime_ODimages.Na_OD_images(idx,:,:)));
        box off; axis off;
        caxis(limOD);
        axis equal;
        colormap(flipud(bone));
        c = colorbar;
        c.Ticks = [0 1];
        c.FontSize = 14;
        c.Label.String = 'optical density';
        c.Location = 'west';
        hold on;
        line([0 100/Z_cam_pix_size],[5 5],'color',[0 0 0],'linewidth',1.5);
        text(3,12,'100\mum','fontsize',16);
        
        
    
    print('Chap5_figure5_NaODimage','-dpdf');
end


%%
function output = thermalAnalysis_loader(dir)

load([dir '\thermalAnalysis.mat'],'thermalAnalysis');

output = thermalAnalysis;

end