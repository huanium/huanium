function[npeak]=peakGaussianDensity(sigmax,sigmay,N)
%sigma_i is defined as
%F(x,y,z)=Npeak*exp(-x^2/2sigmax^2-y^2/2sigmay^2-z^2/2sigmaz^2) and is
%given in units of microns
%Reports npeak in units of cm^-3
%N is atom number
sigmax=sigmax/1e6; %to meter
sigmay=sigmay/1e6;
%Calculate sigmaz in a crossed ODT setup 
sigmaz=sigmax*sigmay/sqrt(sigmax^2+sigmay^2)

npeak=N/((sqrt(2*pi))^3*sigmax*sigmay*sigmaz)*1e-6;

%For 10/14/15 run 3, Npeak = 1300, x width pixels ~ 9, y width 7, z
%width assumed to be 1/3*9, n0= 3*10^10
%From Jan Na BEC trap frequency, omega_x = 2pi*216Hz, omega_y=2pi*371Hz,
%omega_z=2pi*579Hz.  

end