function condensate_thermal_2D = BEC_bimodal_fit_func_2D(a,b,c, d, e, f, N , x, y)
    condensate_thermal_2D = a*approx_polylog(2,exp(-(x-d).^2/e^2-(y-f).^2/e^2),N) + b*(max(1-(x-d).^2/c^2-(y-f).^2/c^2 ,0)).^(3/2);
end