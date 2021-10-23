function fftData = getPSDfromFFT(times,yvalues,zeroPadFactor)
    %times need to be in seconds
    
    NaNmask = isnan(yvalues);
    yvalues(NaNmask) = 0;
    
    fftData = struct;
    deltaT = (times(2)-times(1));
    times   = [times,times(end)+deltaT:deltaT:times(end)+deltaT*(zeroPadFactor-1)*length(yvalues)];
    yvalues = [yvalues,zeros(1,(zeroPadFactor-1)*length(yvalues))];
    
    Fs = 1/(times(2)-times(1));     % Sampling frequency
    N = length(times);              % Number of samples

    FFTy = fft(yvalues);
    FFTy = FFTy(1:N/2+1);
    fftData.power = (1/(Fs*N)) * abs(FFTy).^2;
    fftData.power(2:end-1) = 2*fftData.power(2:end-1);
    fftData.freq = Fs*(0:(N/2))/N;

end