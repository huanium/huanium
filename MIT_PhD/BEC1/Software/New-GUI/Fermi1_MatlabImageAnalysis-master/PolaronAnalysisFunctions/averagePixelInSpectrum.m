function [ejectionData]=averagePixelInSpectrum(ejectionData,groupingArray)

    if(~isfield(ejectionData,'injectionCorrectedScaledTransfer'))
        ejectionData.injectionCorrectedScaledTransfer = ejectionData.SuperFancyTransfer;
    end
    ejectionData.groupedFreqMesh = [];
    ejectionData.groupedPixelMesh = [];
    ejectionData.groupedInjectionCorrectedScaledTransfer = [];
    numPixel = length(ejectionData.PixelMesh(1,:));
    for idx = 1:length(groupingArray(:,1))
        avIdx = [groupingArray(idx,1):groupingArray(idx,2),(numPixel+1-groupingArray(idx,2)):(numPixel+1-groupingArray(idx,1))];
        ejectionData.groupedFreqMesh(:,idx) = mean((ejectionData.FreqMesh(:,avIdx)),2);
        ejectionData.groupedPixelMesh(:,idx) = mean(abs(ejectionData.PixelMesh(:,avIdx)),2);
        ejectionData.groupedInjectionCorrectedScaledTransfer(:,idx) = mean(ejectionData.injectionCorrectedScaledTransfer(:,avIdx),2);
    end
    ejectionData.groupedPixelMesh(:,end) = 0*ejectionData.groupedPixelMesh(:,end);
    plottingArray = ejectionData.groupedPixelMesh;
    plottingFreqMesh = ejectionData.groupedFreqMesh;
    plottingInjectionCorrectedScaledTransfer = ejectionData.groupedInjectionCorrectedScaledTransfer;
    
    plottingArray = plottingArray*2.5;

    load('cmap2.mat')
    figure(123),clf;
    s = surf(plottingArray',plottingFreqMesh',plottingInjectionCorrectedScaledTransfer');
    s.EdgeColor = 'none';
    caxis([0.00,0.7])
    colormap(cmap2)
    view([0,-90])
    hold on
    l = plot([ejectionData.BEC_TF_fromTOF*2.5,ejectionData.BEC_TF_fromTOF*2.5]./ejectionData.LineDensityPixelAveraging,[-100,300],'k--','LineWidth',1.5);
    set(l,'ZData',[-5,-5]);
    l = plot([-ejectionData.BEC_TF_fromTOF*2.5,-ejectionData.BEC_TF_fromTOF*2.5]./ejectionData.LineDensityPixelAveraging,[-100,300],'k--','LineWidth',1.5);
    set(l,'ZData',[-5,-5]);
    l = plot([-1000,1000],[0,0],'k-','LineWidth',1.5);
    set(l,'ZData',[-5,-5]);
    hold off
    ylabel('\omega/2\pi (kHz)')
    xlabel('position (\mum)' )
    xlim([-25*2.5,25*2.5])
    ylim([-10,125])
    colorbar
    set(gca,'FontSize', 14);
    set(gca, 'FontName', 'Arial')
    pos = get(gcf,'Position');
    set(gcf,'Position',[pos(1),pos(2),680,520]);

end