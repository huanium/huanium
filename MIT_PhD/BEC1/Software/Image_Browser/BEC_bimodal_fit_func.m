function condensate_thermal = BEC_bimodal_fit_func(a,b,c, d, e, N , x)
    condensate_thermal = a*approx_polylog(2,exp(-(x-d).^2/e^2),N) + b*(max(1-(x-d).^2/c^2 ,0)).^(3/2);
end