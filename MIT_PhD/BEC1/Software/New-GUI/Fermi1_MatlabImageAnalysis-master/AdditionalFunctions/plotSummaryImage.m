function plotSummaryImage(measNa,measK)
    %subplot(6,4,[5,6,7,9,10,11]);
    subplot(6,6,[7,8,9,10,11,13,14,15,16,17]);
        imagesc(measK.analysis.fitIntegratedGaussY.croppedODImage);
        hold on
        rectangle('Position',[0.5 0.5 measNa.settings.countingMBlargeX measNa.settings.countingMBlargeY],'EdgeColor','b','LineWidth',1.5)
        rectangle('Position',[0.5+measNa.settings.countingMBlargeX/2-measNa.settings.countingMBsmallX/2 0.5+measNa.settings.countingMBlargeY/2-measNa.settings.countingMBsmallY/2 measNa.settings.countingMBsmallX measNa.settings.countingMBsmallY],'EdgeColor','r','LineWidth',1.5)
        text(2,6,'^{40}K' ,'FontSize',18,'FontWeight','bold')
        text(2,measNa.settings.countingMBlargeY-5,['Ncnt: ' num2str(measK.analysis.NcntLarge,3)] ,'FontSize',20,'Color','b','FontWeight','bold')
        text(measNa.settings.countingMBlargeX/2,measNa.settings.countingMBlargeY-5,['Ncnt: ' num2str(measK.analysis.NcntSmall,3)] ,'FontSize',20,'Color','r','FontWeight','bold')
        hold off
        caxis([-0.1,mean(maxk(measK.analysis.fitIntegratedGaussY.croppedODImage(:),100))]);
        colormap(flipud(bone));
        mycbar = colorbar('westoutside');
        ylabel(mycbar, 'OD')
        set(gca, 'FontName', 'Arial')
        set(gca,'FontSize', 14);
        set(gca,'xaxisLocation','top')
        
        axis equal
    %subplot(6,4,[2,3])
    subplot(6,6,[2,3,4,5])
        plot(measK.settings.LineDensityPixelAveraging*measK.analysis.fitIntegratedGaussX.xcoords,measNa.settings.countingMBlargeY*measK.analysis.fitIntegratedGaussX.integratedAlongY,'.','MarkerSize',20);
        xlabel(['x (pixel) - center = ' ,num2str(measK.settings.LineDensityPixelAveraging*measK.analysis.fitIntegratedGaussX.param(end,3),3),'px']);
        ylabel('Line OD')
        hold on
        plot(measK.settings.LineDensityPixelAveraging*measK.analysis.fitIntegratedGaussX.xcoords,measNa.settings.countingMBlargeY*measK.analysis.fitIntegratedGaussX.fitfun(measK.analysis.fitIntegratedGaussX.param,measK.analysis.fitIntegratedGaussX.xcoords),'LineWidth',2);
        plot(measK.settings.LineDensityPixelAveraging*[measK.analysis.fitIntegratedGaussX.param(end,3),measK.analysis.fitIntegratedGaussX.param(end,3)],ylim,'k','LineWidth',1.2)
        hold off
        set(gca, 'FontName', 'Arial')
        set(gca,'FontSize', 14);
        set(gca,'xaxisLocation','top')
        box on
    %subplot(6,4,[8,12])
    subplot(6,6,[12,18])
        hold on
        plot(measNa.settings.countingMBlargeX*measK.analysis.fitIntegratedGaussY.integratedAlongX,measK.settings.LineDensityPixelAveraging*measK.analysis.fitIntegratedGaussY.ycoords,'.','MarkerSize',20);
        plot(measNa.settings.countingMBlargeX*measK.analysis.fitIntegratedGaussY.fitfun(measK.analysis.fitIntegratedGaussY.param,measK.analysis.fitIntegratedGaussY.ycoords),measK.settings.LineDensityPixelAveraging*measK.analysis.fitIntegratedGaussY.ycoords,'LineWidth',2);
        plot(xlim,measK.settings.LineDensityPixelAveraging*[measK.analysis.fitIntegratedGaussY.param(end,3),measK.analysis.fitIntegratedGaussY.param(end,3)],'k','LineWidth',1.2)
        title([ ]);
        set(gca,'XDir','reverse');
        set(gca,'YDir','reverse');
        set(gca, 'YAxisLocation', 'right')
        xlabel('Line OD');
        ylabel(['y (pixel) - center = ' ,num2str(measK.settings.LineDensityPixelAveraging*measK.analysis.fitIntegratedGaussY.param(end,3),3),'px']);
        set(gca, 'FontName', 'Arial')
        set(gca,'FontSize', 14);
        set(gca,'xaxisLocation','top')
        box on
    set(gcf,'color','w');
    %subplot(6,4,[13,14,15,17,18,19]);
    subplot(6,6,[19,20,21,22,23,25,26,27,28,29]);
        imagesc(measNa.analysis.fitBimodalExcludeCenter.ODimage);
        hold on
        rectangle('Position',[0.5 0.5 measNa.settings.countingMBlargeX measNa.settings.countingMBlargeY],'EdgeColor','b','LineWidth',1.5)
        rectangle('Position',[0.5+measNa.settings.countingMBlargeX/2-measNa.settings.countingMBsmallX/2 0.5+measNa.settings.countingMBlargeY/2-measNa.settings.countingMBsmallY/2 measNa.settings.countingMBsmallX measNa.settings.countingMBsmallY],'EdgeColor','r','LineWidth',1.5)
        text(2,6,'^{23}Na' ,'FontSize',18,'FontWeight','bold')
        text(2,measNa.settings.countingMBlargeY-5,['Ncnt: ' num2str(measNa.analysis.NcntLarge,3)] ,'FontSize',20,'Color','b','FontWeight','bold')
        text(measNa.settings.countingMBlargeX/2,measNa.settings.countingMBlargeY-5,['Ncnt: ' num2str(measNa.analysis.NcntSmall,3)] ,'FontSize',20,'Color','r','FontWeight','bold')
        hold off
        caxis([-0.1,mean(maxk(measNa.analysis.fitBimodalExcludeCenter.ODimage(:),100))]);
        colormap(flipud(bone));
        mycbar = colorbar('westoutside');
        ylabel(mycbar, 'OD')
        set(gca, 'FontName', 'Arial')
        set(gca,'FontSize', 14);
        axis equal
    %subplot(6,4,[22,23])
    subplot(6,6,[32,33,34,35])
        plot(measNa.analysis.fitBimodalExcludeCenter.xpix,measNa.analysis.fitBimodalExcludeCenter.nx,'.','MarkerSize',20);
        hold on
        plot(measNa.analysis.fitBimodalExcludeCenter.xpix(~measNa.analysis.fitBimodalExcludeCenter.PeakMaskX),measNa.analysis.fitBimodalExcludeCenter.nx(~measNa.analysis.fitBimodalExcludeCenter.PeakMaskX),'.','MarkerSize',20);
        plot(measNa.analysis.fitBimodalExcludeCenter.xpix(1):measNa.analysis.fitBimodalExcludeCenter.xpix(end),measNa.analysis.fitBimodalExcludeCenter.GaussianFun(measNa.analysis.fitBimodalExcludeCenter.GaussianWingsX,measNa.analysis.fitBimodalExcludeCenter.xpix(1):measNa.analysis.fitBimodalExcludeCenter.xpix(end)),'LineWidth',2);
        plot(measNa.analysis.fitBimodalExcludeCenter.xpix(1):measNa.analysis.fitBimodalExcludeCenter.xpix(end),measNa.analysis.fitBimodalExcludeCenter.BimodalFunX(measNa.analysis.fitBimodalExcludeCenter.xparam,measNa.analysis.fitBimodalExcludeCenter.xpix(1):measNa.analysis.fitBimodalExcludeCenter.xpix(end)),'LineWidth',2);
        plot([measNa.analysis.fitBimodalExcludeCenter.xparam(3)-measNa.analysis.fitBimodalExcludeCenter.xparam(2),measNa.analysis.fitBimodalExcludeCenter.xparam(3)-measNa.analysis.fitBimodalExcludeCenter.xparam(2)],get(gca,'YLim' ),'k--','LineWidth',1);
        plot([measNa.analysis.fitBimodalExcludeCenter.xparam(3)+measNa.analysis.fitBimodalExcludeCenter.xparam(2),measNa.analysis.fitBimodalExcludeCenter.xparam(3)+measNa.analysis.fitBimodalExcludeCenter.xparam(2)],get(gca,'YLim' ),'k--','LineWidth',1);
        hold off
        ylabel('Line OD');
        xlabel(['x (pixel) - TF_X = ' num2str(measNa.analysis.fitBimodalExcludeCenter.xparam(2),2) 'px' ]);
        try
            ylim([-0.01*abs(max(measNa.analysis.fitBimodalExcludeCenter.BimodalFunX(measNa.analysis.fitBimodalExcludeCenter.xparam,measNa.analysis.fitBimodalExcludeCenter.xpix(1):measNa.analysis.fitBimodalExcludeCenter.xpix(end)))),1.2*abs(max(measNa.analysis.fitBimodalExcludeCenter.BimodalFunX(measNa.analysis.fitBimodalExcludeCenter.xparam,measNa.analysis.fitBimodalExcludeCenter.xpix(1):measNa.analysis.fitBimodalExcludeCenter.xpix(end))))]);
        catch
            display('something wrong')
        end
        box on
        set(gca, 'FontName', 'Arial')
        set(gca,'FontSize', 14);
    %subplot(6,4,[16,20])
    subplot(6,6,[24,30])
        plot(measNa.analysis.fitBimodalExcludeCenter.ny,measNa.analysis.fitBimodalExcludeCenter.ypix,'.','MarkerSize',20);
        hold on
        plot(measNa.analysis.fitBimodalExcludeCenter.ny(~measNa.analysis.fitBimodalExcludeCenter.PeakMaskY),measNa.analysis.fitBimodalExcludeCenter.ypix(~measNa.analysis.fitBimodalExcludeCenter.PeakMaskY),'.','MarkerSize',20);
        plot(measNa.analysis.fitBimodalExcludeCenter.GaussianFun(measNa.analysis.fitBimodalExcludeCenter.GaussianWingsY,measNa.analysis.fitBimodalExcludeCenter.ypix(1):measNa.analysis.fitBimodalExcludeCenter.ypix(end)),measNa.analysis.fitBimodalExcludeCenter.ypix(1):measNa.analysis.fitBimodalExcludeCenter.ypix(end),'LineWidth',2);
        plot(measNa.analysis.fitBimodalExcludeCenter.BimodalFunY(measNa.analysis.fitBimodalExcludeCenter.yparam,measNa.analysis.fitBimodalExcludeCenter.ypix(1):measNa.analysis.fitBimodalExcludeCenter.ypix(end)),measNa.analysis.fitBimodalExcludeCenter.ypix(1):measNa.analysis.fitBimodalExcludeCenter.ypix(end),'LineWidth',2);
        plot(get(gca,'XLim'),[measNa.analysis.fitBimodalExcludeCenter.yparam(3)-measNa.analysis.fitBimodalExcludeCenter.yparam(2),measNa.analysis.fitBimodalExcludeCenter.yparam(3)-measNa.analysis.fitBimodalExcludeCenter.yparam(2)],'k--','LineWidth',1);
        plot(get(gca,'XLim'),[measNa.analysis.fitBimodalExcludeCenter.yparam(3)+measNa.analysis.fitBimodalExcludeCenter.yparam(2),measNa.analysis.fitBimodalExcludeCenter.yparam(3)+measNa.analysis.fitBimodalExcludeCenter.yparam(2)],'k--','LineWidth',1);
        hold off
        set(gca,'XDir','reverse');
        set(gca,'YDir','reverse');
        set(gca, 'YAxisLocation', 'right')
        xlabel('Line OD');
        ylabel(['y (pixel) - TF_Y = ' num2str(measNa.analysis.fitBimodalExcludeCenter.yparam(2),2) 'px' ]);
        xlim([-0.01*abs(max(measNa.analysis.fitBimodalExcludeCenter.BimodalFunY(measNa.analysis.fitBimodalExcludeCenter.yparam,measNa.analysis.fitBimodalExcludeCenter.ypix(1):measNa.analysis.fitBimodalExcludeCenter.ypix(end)))),1.2*abs(max(measNa.analysis.fitBimodalExcludeCenter.BimodalFunY(measNa.analysis.fitBimodalExcludeCenter.yparam,measNa.analysis.fitBimodalExcludeCenter.ypix(1):measNa.analysis.fitBimodalExcludeCenter.ypix(end))))]);
        box on
        set(gca, 'FontName', 'Arial')
        set(gca,'FontSize', 14);
        
        
    %print('-clipboard' ,'-dpng', '-r300', '-painters')
    print -clipboard -dbitmap
end