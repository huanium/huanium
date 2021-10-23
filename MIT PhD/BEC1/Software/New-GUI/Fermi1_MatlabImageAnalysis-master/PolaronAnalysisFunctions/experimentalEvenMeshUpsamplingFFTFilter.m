lowerFreq = -27.7;
upperFreq = 177.3;
freqMask = and(LineDensityAnalysis.FreqMesh(:,1)>lowerFreq,LineDensityAnalysis.FreqMesh(:,1)<upperFreq);

Transfer = LineDensityAnalysis.FancyKTransferMatrix(freqMask,:);
FreqMesh = LineDensityAnalysis.FreqMesh(freqMask,:);
PixelMesh = LineDensityAnalysis.PixelMesh(freqMask,:);
PixelAxis = LineDensityAnalysis.PixelMesh(1,:);

FreqSpacing = 0.5;  %in kHz
PulseTime   = 0.5;  %in ms
InterPolFreq = -25.7:FreqSpacing:175.8;


PixelUpsampling = 2;
InterPolPixel = PixelAxis(1):1/PixelUpsampling:PixelAxis(end);

[interPolPixelMesh, interPolFreqMesh] = meshgrid(InterPolPixel,InterPolFreq);

interpolatedTransfer = griddata(FreqMesh,PixelMesh,Transfer,interPolFreqMesh,interPolPixelMesh,'v4');

figure(212),clf;
plot3(FreqMesh,PixelMesh,LineDensityAnalysis.FancyKTransferMatrix(freqMask,:),'r.')
hold on
s = surf(interPolFreqMesh,interPolPixelMesh,interpolatedTransfer);
s.EdgeColor = 'none';
view(2);
%%
ExtraFreqFilterFactor = 2; %1 = normal,>1 more filtering
fudgeFilterWidthFreq  = 5;

MinInverseFreq = length(InterPolFreq);
InverseFreqCut = 1/ExtraFreqFilterFactor*MinInverseFreq*PulseTime/(1/FreqSpacing);

m = size(interpolatedTransfer,1);
n = size(interpolatedTransfer,2);

%fudge filter for frequencies
fudgeFilterFreq = ones(1,m);
if(fudgeFilterFreq<m)
    filterEdge = (1./(1+((0:m/2-InverseFreqCut+fudgeFilterWidthFreq/2)/fudgeFilterWidthFreq).^5));
    fudgeFilterFreq(1:length(filterEdge)) = fliplr(filterEdge);
    fudgeFilterFreq(end-length(filterEdge)+1:end) = (filterEdge);
end
mask = ones(m,n);
mask = mask.*fudgeFilterFreq';

%Gaussian filter for frequencies
times = (linspace(-1,1,length(InterPolFreq)))*1/FreqSpacing*1/2;
GaussSigma = 2*0.065;
GaussianFilter = exp(-times.^2./2/GaussSigma.^2);
mask = ones(m,n);
mask = mask.*GaussianFilter';
mask = mask.*fudgeFilterFreq';
% 
%fudge filter for camera pixels
ExtraPixelFilterFactor = 2; %1 = normal,>1 more filtering
fudgeFilterWidthPixel  = 5;

MaxInversePixel = length(InterPolPixel);
InversePixelCut = 1/2*MaxInversePixel*1/PixelUpsampling*1/ExtraPixelFilterFactor;
fudgeFilterPixel = ones(1,n);

if(fudgeFilterPixel<n)
    filterEdge = (1./(1+((0:n/2-InversePixelCut+fudgeFilterWidthPixel/2)/fudgeFilterWidthPixel).^5));
    fudgeFilterPixel(1:length(filterEdge)) = fliplr(filterEdge);
    fudgeFilterPixel(end-length(filterEdge)+1:end) = (filterEdge);
end
mask = mask.*fudgeFilterPixel;


imageFFT = fftshift(fft2(interpolatedTransfer)) .* mask;
interpolatedTransferFFTFiltered = abs(ifft2(ifftshift(imageFFT))); % reconstructed imageage

figure(213),clf;
subplot(1,3,1);
s = surf(FreqMesh,PixelMesh,Transfer);
title('Original');
s.EdgeColor = 'none';
view(2);
caxis([0.0,0.7])
subplot(1,3,2);
s = surf(interPolFreqMesh,interPolPixelMesh,interpolatedTransfer);
title('Even Mesh Upsamling');
s.EdgeColor = 'none';
view(2);
caxis([0.0,0.7])
subplot(1,3,3);

s = surf(interPolFreqMesh,interPolPixelMesh,interpolatedTransferFFTFiltered);
title('Fudge Fourier Filtering');
s.EdgeColor = 'none';
view(2);
caxis([0.0,0.7])

figure(214),clf;
subplot(1,2,1);
s = surf(interPolFreqMesh,interPolPixelMesh,real(imageFFT));
title('FFT with filter');
s.EdgeColor = 'none';
view(2);
subplot(1,2,2);
s = surf(interPolFreqMesh,interPolPixelMesh,mask);
title('Filter');
s.EdgeColor = 'none';
view(2);


plot2DMatrixWithSlider(interPolPixelMesh,interPolFreqMesh,interpolatedTransferFFTFiltered);




%%

for idx=1:m
    sgf(:,idx)=sgolayfilt(interpolatedTransferFFTFiltered(idx,:),2,13);
end
for idx=1:n
    sgf(idx,:)=sgolayfilt(interpolatedTransferFFTFiltered(:,idx),2,51);
end

plot2DMatrixWithSlider(interPolPixelMesh,interPolFreqMesh,sgf');

%%
load('LineDensityAnalysis_20px200px.mat')
KLineDensity            = LineDensityAnalysis.FreqIntegratedMatrix(end,:);
filteredKLineDensity    = sgolayfilt(KLineDensity,2,31);


z = LineDensityAnalysis.PixelMesh(end,:);
KDensity = -1./((z(1:end-1)+0.5)-2).*diff(filteredKLineDensity);
figure(817),clf;
plot(KLineDensity,'Linewidth',1.5)
hold on
plot(filteredKLineDensity,'Linewidth',1.5)
hold off
xlabel('axial coordinate (pixel)')
title('Line density from freq int')
legend('raw data','SG filtered')

figure(819),clf;
plot((KLineDensity-filteredKLineDensity)/max(filteredKLineDensity),'Linewidth',1.5);
xlabel('axial coordinate (pixel)')
title('relative residuals')
ylim([-0.05,0.05])

figure(818),clf;
plot((z(1:end-1)+0.5)-2,KDensity,'Linewidth',1.5)
xlabel('axial coordinate (pixel)')
title('reconstructed density n(x=y=0,z)')
ylim([-0.00001,0.0003])
xlim([-100,100])
%% Transfer x vs freq
freq = LineDensityAnalysis.FreqMesh(:,1);
pix = LineDensityAnalysis.PixelMesh(1,:)*2.5*2;
figure(924),clf
s = surf(LineDensityAnalysis.FreqMesh',LineDensityAnalysis.PixelMesh'*2*2.5,LineDensityAnalysis.FancyKTransferMatrix');
s.EdgeColor = 'none';
caxis([0.0,0.7])
view(2);
colormap(parula)
hold on
l = plot([freq(1),freq(end)],[BEC_X.TF,BEC_X.TF],'w--','LineWidth',1.5);
set(l,'ZData',[1,1]);
l = plot([freq(1),freq(end)],[-BEC_X.TF,-BEC_X.TF],'w--','LineWidth',1.5);
set(l,'ZData',[1,1]);
hold off
xlabel('\omega/2\pi (kHz)')
ylabel('position (\mum)' )
title( 'Transfer');
ylim([pix(1),pix(end)])
xlim([-20,175])
colorbar
set(gca,'FontSize', 14);
set(gca, 'FontName', 'Arial')
pos = get(gcf,'Position');
set(gcf,'Position',[pos(1),pos(2),768, 420]);
plot2DMatrixWithSlider(LineDensityAnalysis.FreqMesh',LineDensityAnalysis.PixelMesh'*2*2.5,LineDensityAnalysis.FancyKTransferMatrix');

%% Transfer x^2 vs freq
freq = LineDensityAnalysis.FreqMesh(:,1);
pix = sign(LineDensityAnalysis.PixelMesh(1,:)).*(LineDensityAnalysis.PixelMesh(1,:)*2.5*2).^2;
figure(925),clf
s = surf(LineDensityAnalysis.FreqMesh',sign(LineDensityAnalysis.PixelMesh').*(LineDensityAnalysis.PixelMesh'*2*2.5).^2,LineDensityAnalysis.FancyKTransferMatrix');
s.EdgeColor = 'none';
caxis([0.0,0.7])
view(2);
colormap(parula)
hold on
l = plot([freq(1),freq(end)],[BEC_X.TF^2,BEC_X.TF^2],'w--','LineWidth',1.5);
set(l,'ZData',[1,1]);
l = plot([freq(1),freq(end)],[-BEC_X.TF^2,-BEC_X.TF^2],'w--','LineWidth',1.5);
set(l,'ZData',[1,1]);
hold off
xlabel('\omega/2\pi (kHz)')
ylabel('position^2 (\mum^2)' )
title( 'Transfer');
ylim([pix(1),pix(end)])
xlim([-20,175])
colorbar
set(gca,'FontSize', 14);
set(gca, 'FontName', 'Arial')
pos = get(gcf,'Position');
set(gcf,'Position',[pos(1),pos(2),800, 680]);
plot2DMatrixWithSlider(LineDensityAnalysis.FreqMesh',sign(LineDensityAnalysis.PixelMesh').*(LineDensityAnalysis.PixelMesh'*2*2.5).^2,LineDensityAnalysis.FancyKTransferMatrix');

%% transfer x^2 vs global En
E_nGlobal = EnFunc(4*10^13*100^3);
freq = LineDensityAnalysis.FreqMesh(:,1)*1000*PlanckConst*2*pi/E_nGlobal;
pix = sign(LineDensityAnalysis.PixelMesh(1,:)).*(LineDensityAnalysis.PixelMesh(1,:)*2.5*2).^2;
figure(925),clf
s = surf(LineDensityAnalysis.FreqMesh'*1000*PlanckConst/E_nGlobal,sign(LineDensityAnalysis.PixelMesh').*(LineDensityAnalysis.PixelMesh'*2*2.5).^2,LineDensityAnalysis.FancyKTransferMatrix');
s.EdgeColor = 'none';
caxis([0.0,0.7])
view(2);
colormap(parula)
hold on
l = plot([freq(1),freq(end)],[BEC_X.TF^2,BEC_X.TF^2],'w--','LineWidth',1.5);
set(l,'ZData',[1,1]);
l = plot([freq(1),freq(end)],[-BEC_X.TF^2,-BEC_X.TF^2],'w--','LineWidth',1.5);
set(l,'ZData',[1,1]);
hold off
xlabel('$\hbar\omega/E_n$','Interpreter','latex');
ylabel('position^2 (\mum^2)' )
title( 'Transver in En using global avergaed En' );
ylim([pix(1),pix(end)])
xlim([-0.5,4])
colorbar
set(gca,'FontSize', 14);
set(gca, 'FontName', 'Arial')
pos = get(gcf,'Position');
set(gcf,'Position',[pos(1),pos(2),800, 680]);

plot2DMatrixWithSlider(LineDensityAnalysis.FreqMesh'*1000*PlanckConst/E_nGlobal,sign(LineDensityAnalysis.PixelMesh').*(LineDensityAnalysis.PixelMesh'*2*2.5).^2,LineDensityAnalysis.FancyKTransferMatrix');

%% Transfer x vs En
DensityArray = [fliplr(localNaDensityTemp2D.densityCombined(1:round(40/2))),localNaDensityTemp2D.densityCombined(1:round(40/2))];
EnArray = EnFunc(DensityArray*100^3);
EnYMesh = bsxfun(@rdivide, PlanckConst*1000*LineDensityAnalysis.FreqMesh',EnArray');


freq = LineDensityAnalysis.FreqMesh(:,1);
pix = LineDensityAnalysis.PixelMesh(1,:)*2.5*2;
figure(924),clf
s = surf(EnYMesh,LineDensityAnalysis.PixelMesh'*2*2.5,LineDensityAnalysis.FancyKTransferMatrix');
s.EdgeColor = 'none';
caxis([0.0,0.7])
view(2);
colormap(parula)
hold on
l = plot([freq(1),freq(end)],[BEC_X.TF,BEC_X.TF],'w--','LineWidth',1.5);
set(l,'ZData',[1,1]);
l = plot([freq(1),freq(end)],[-BEC_X.TF,-BEC_X.TF],'w--','LineWidth',1.5);
set(l,'ZData',[1,1]);
hold off
xlabel('$\hbar\omega/E_n$','Interpreter','latex');
ylabel('position (\mum)' )
title( 'Transver in En using box avergaed En' );
ylim([pix(1),pix(end)])
xlim([-0.5,3])
colorbar
set(gca,'FontSize', 14);
set(gca, 'FontName', 'Arial')
pos = get(gcf,'Position');
set(gcf,'Position',[pos(1),pos(2),800, 680]);
plot2DMatrixWithSlider(EnYMesh,LineDensityAnalysis.PixelMesh'*2*2.5,LineDensityAnalysis.FancyKTransferMatrix');


%% transfer x^2 vs local En
DensityArray = [fliplr(localNaDensityTemp2D.densityCombined(1:round(40/2))),localNaDensityTemp2D.densityCombined(1:round(40/2))];
EnArray = EnFunc(DensityArray*100^3);
EnYMesh = bsxfun(@rdivide, PlanckConst*1000*LineDensityAnalysis.FreqMesh',EnArray');
pix = sign(LineDensityAnalysis.PixelMesh(1,:)).*(LineDensityAnalysis.PixelMesh(1,:)*2.5*2).^2;

figure(921),clf
s = surf(EnYMesh,sign(LineDensityAnalysis.PixelMesh').*(LineDensityAnalysis.PixelMesh'*2*2.5).^2,LineDensityAnalysis.FancyKTransferMatrix');

s.EdgeColor = 'none';
caxis([-0.05,0.7])
view(2);
colormap(parula)
hold on
l = plot([freq(1),freq(end)],[BEC_X.TF^2,BEC_X.TF^2],'w--','LineWidth',1.5);
set(l,'ZData',[1,1]);
l = plot([freq(1),freq(end)],[-BEC_X.TF^2,-BEC_X.TF^2],'w--','LineWidth',1.5);
set(l,'ZData',[1,1]);
hold off
xlabel('$\hbar\omega/E_n$','Interpreter','latex');
ylabel('position^2 (\mum^2)' )
title( 'Transver in En using local En(x,y=z=0)' );
ylim([pix(1),pix(end)])
xlim([-0.5,3])
colorbar
set(gca,'FontSize', 14);
set(gca, 'FontName', 'Arial')
pos = get(gcf,'Position');
set(gcf,'Position',[pos(1),pos(2),800, 680]);
plot2DMatrixWithSlider(EnYMesh,sign(LineDensityAnalysis.PixelMesh').*(LineDensityAnalysis.PixelMesh'*2*2.5).^2,LineDensityAnalysis.FancyKTransferMatrix');

%% Transfer T/Tc vs En
DensityArray = [fliplr(localNaDensityTemp2D.densityCombined(1:round(40/2))),localNaDensityTemp2D.densityCombined(1:round(40/2))];
EnArray = EnFunc(DensityArray*100^3);
EnYMesh = bsxfun(@rdivide, PlanckConst*1000*LineDensityAnalysis.FreqMesh',EnArray');

ToverTcArray = [-fliplr(localNaDensityTemp2D.localToverTc(1:round(40/2))),localNaDensityTemp2D.localToverTc(1:round(40/2))];
[ToverTcMesh,~] = meshgrid(ToverTcArray',freq);


freq = LineDensityAnalysis.FreqMesh(:,1);
pix = LineDensityAnalysis.PixelMesh(1,:)*2.5*2;
figure(924),clf
s = surf(ToverTcMesh,EnYMesh',LineDensityAnalysis.FancyKTransferMatrix);
s.EdgeColor = 'none';
caxis([0.0,0.7])
view(2);
colormap(parula)
ylabel('$\hbar\omega/E_n$','Interpreter','latex');
xlabel('T/T_C' )
title( 'Transver in En using box avergaed En' );
xlim([ToverTcArray(1),ToverTcArray(end)])
ylim([-0.5,3])
colorbar
set(gca,'FontSize', 14);
set(gca, 'FontName', 'Arial')
pos = get(gcf,'Position');
set(gcf,'Position',[pos(1),pos(2),800, 680]);
plot2DMatrixWithSlider(EnYMesh,LineDensityAnalysis.PixelMesh'*2*2.5,LineDensityAnalysis.FancyKTransferMatrix');
