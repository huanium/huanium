function thermal = BEC_thermal_fit_func(c1, N, x)
    % a = background
    % b = therm*factor
    % c = x_center
    % d = rho_therm
    thermal = c1 + 1.*approx_polylog(2,exp(-(x-0).^2/(2^2)),N);
end