function Contact = contactFunction(slope,Rabi)
%Slope is fitted slope of RF spectrum, units of kHz^1.5
%Rabi in rad/s
    sigma=62.5e-6; %Gaussian sigma of pulse window
    Contact = slope*8*pi*(2*pi*1000)^1.5*sqrt(2*mReduced/pi/hbar)/sigma/Rabi^2;

end