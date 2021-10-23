function [B_field] = B_fieldFromBreitRabiFrequency(B_guess,freq,m1,m2)
    f = @(B) BreitRabiInMHz(B,-7/2,-9/2) - freq;
    B_field = fzero(f,B_guess);
end