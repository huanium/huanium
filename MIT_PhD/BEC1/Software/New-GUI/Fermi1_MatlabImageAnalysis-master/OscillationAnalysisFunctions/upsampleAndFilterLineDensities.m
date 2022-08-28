function upsampledLineDensities = upsampleAndFilterLineDensities(LineDensityMatrix,frequencyArray,targetFreq)

    [~,numPixel]            = size(LineDensityMatrix);
    fftLineDensitiesK       = fftshift(fft(LineDensityMatrix,numPixel,2),2);
    upsampleFactor          = 8;
    [numFreq,numPixelFreq]  = size(fftLineDensitiesK);
    pixelFrequencies        = ((1:numPixelFreq/2))/numPixelFreq;
    FilterBoost             = 5;
    filterFunction          = 1./(1+(FilterBoost*pixelFrequencies).^5);
    
    figure(17)
    plot(filterFunction)
    filteredFFTLineDensitiesK = [fliplr(filterFunction),filterFunction].*fftLineDensitiesK;

    upsampledFFTLineDensities = zeros(numFreq,upsampleFactor*numPixelFreq);
    upsampledFFTLineDensities(:,upsampleFactor*numPixelFreq/2-numPixelFreq/2+1:upsampleFactor*numPixelFreq/2+numPixelFreq/2)= filteredFFTLineDensitiesK;
    upsampledLineDensities = real(ifft(fftshift(upsampledFFTLineDensities,2),upsampleFactor*numPixelFreq,2));



    uniqueFrequenciesForPlotting = frequencyArray-diff([frequencyArray,frequencyArray(end)+frequencyArray(end)-frequencyArray(end-1)])/2;
    [X,Y] = meshgrid(uniqueFrequenciesForPlotting,((0:numPixel-1)-numPixel/2+0.5));

    figure(382),clf;
    subplot(1,2,1)
        s = pcolor(X,Y,LineDensityMatrix');
        s.EdgeColor = 'none';
        hold on
        hold off
        zlim([0,0.2]);
        box on
        colormap(flipud(bone));
        xlabel('frequency (Hz)');
        ylabel('linedensity (\mum)');
        set(gca, 'FontName', 'Arial')
        set(gca,'FontSize', 16);
        ylim([-20,20])
        xlim([min(uniqueFrequenciesForPlotting),max(uniqueFrequenciesForPlotting)])
        caxis([-0.03*mean(max(LineDensityMatrix,[],2)),1.1*mean(max(LineDensityMatrix,[],2))]);
        title('original linedensity')

    [X2,Y2] = meshgrid(uniqueFrequenciesForPlotting,((0:upsampleFactor*numPixelFreq-1)-upsampleFactor*numPixelFreq/2+0.5)/upsampleFactor); 
    subplot(1,2,2)
        s = pcolor(X2,Y2,upsampledLineDensities');
        s.EdgeColor = 'none';
        hold on
        hold off
        box on
        colormap(flipud(bone));
        xlabel('frequency (Hz)');
        ylabel('linedensity (\mum)');
        set(gca, 'FontName', 'Arial')
        set(gca,'FontSize', 16);
        ylim([-20,20])
        xlim([min(uniqueFrequenciesForPlotting),max(uniqueFrequenciesForPlotting)])
        title('upsampled and filtered linedensity')

     
     idx = find(frequencyArray == targetFreq);
     scaleFactor = max(LineDensityMatrix(idx,:))/max(upsampledLineDensities(idx,:));
     figure(9182),clf;
     plot(Y(:,1),LineDensityMatrix(idx,:),'LineWidth',2)
     hold on
     plot(Y2(:,1),upsampledLineDensities(idx,:)*scaleFactor,'LineWidth',2)
     hold off
     title(['slice @ ' num2str(targetFreq) 'Hz'])
     xlim([-30,30])
end