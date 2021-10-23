GaussXvals = -20:0.001:60;
sigma = 3.4093;
GaussYvals = 0.6*exp(-GaussXvals.^2./sigma.^2);

RFSpec = struct;
RFSpec.xvals = GaussXvals;
RFSpec.yvals = GaussYvals;
RFSpec.y_ci(1,1,:) = 0.9*GaussYvals;
RFSpec.y_ci(1,2,:) = 1.2*GaussYvals;

analyzeRFSpectrum(RFSpec,1,'peakFinder',3)

%%

