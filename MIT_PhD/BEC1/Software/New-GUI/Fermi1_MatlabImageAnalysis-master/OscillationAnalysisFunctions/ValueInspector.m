testValue = 178

valuesIdx = find(measNa.parameters == testValue)
measK.analysis.bareNcntAverageMarqueeBoxValues(valuesIdx)


measNa.analysis.NcntLarge(valuesIdx)
measNa.analysis.widthY.FWHM(valuesIdx,2)'
measNa.analysis.fitIntegratedGaussY.param(valuesIdx,2)'

measNa.analysis.fitBimodalExcludeCenter.yparam(valuesIdx,1)'+measNa.analysis.fitBimodalExcludeCenter.GaussianWingsY(valuesIdx,2)'
measNa.analysis.fitIntegratedGaussY.param(valuesIdx,2)'.*measNa.analysis.fitIntegratedGaussY.param(valuesIdx,4)'
measK.analysis.widthY.FWHM(valuesIdx,7)'
figure(81919),clf;
subplot(2,1,1)
plot(lineDensityNaMatrix(valuesIdx,:)')
legend('1','2','3','4')
subplot(2,1,2)
plot(lineDensityKMatrix(valuesIdx,:)')
legend('1','2','3','4')

excludeIdxNa(valuesIdx)'