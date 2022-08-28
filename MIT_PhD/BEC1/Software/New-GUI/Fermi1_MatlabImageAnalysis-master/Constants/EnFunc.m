function E_n=EnFunc(densityInMeter)
    E_n = hbar^2 * ((6*pi^2*densityInMeter).^(1/3)).^2 ./(4*mReduced);
end