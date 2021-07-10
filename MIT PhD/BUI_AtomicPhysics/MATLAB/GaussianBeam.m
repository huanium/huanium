r=-0.3:0.0001:0.3;
L=1000;                             %link distance
lamda=1550e-9;                      %Wavelength
Wo=1.5e-2;           %Beam spot radius at the transmitter
Fo=100;              %Beam phase front radius of curvature
k=2*pi/lamda;                       %wave number
theta0=1+L/Fo;                      %Curvature parameter
lamda0=2*L/(k*Wo^2);                 %Fresnel ratio
theta=theta0/(theta0^2+lamda0^2);   %Refraction parameter
lamda1=lamda0/(theta0^2+lamda0^2);  %Diffraction parameter
W=Wo*(theta0^2+lamda0^2)^0.5;       %Beam spot radius
nnn=exp(-1);
Ao=1/(theta0^2+lamda0^2)*exp(-r.^2/Wo^2);
A=(theta^2+lamda1^2)*exp(-2*r.^2/W^2);
plot(r,Ao,'LineWidth',2)
hold on
plot(r,A,'LineWidth',2)
xline(Wo,'b','--')
xline(-Wo,'k','--')
xline(W,'g','--')
xline(-W,'r','--')
xlabel('r-axis');
ylabel('amplitude')
legend('transmitted','received','Wo','-Wo','W','-W')
grid on