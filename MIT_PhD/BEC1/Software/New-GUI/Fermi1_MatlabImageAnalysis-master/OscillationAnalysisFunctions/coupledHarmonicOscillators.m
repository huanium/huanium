function xdot = coupledHarmonicOscillators(t,x)
xdot=zeros(4,1);
k=0.2; %drag
N2OverN=0.01; %proportion in population 2
gamma2=k*(1-N2OverN);
gamma1=k*N2OverN;

f=1/1000; %to make time in milliseconds

m1=23/40; %mass
m2=1;
k1=m1*(2*pi*77*f)^2; %m omega^2 spring constant
k2=m2*(2*pi*125*f)^2;

xdot(1)=-gamma1/m1*x(1)-k1/m1*x(2)+gamma1/m1*x(3);
xdot(2)=x(1);
xdot(3)=gamma2/m2*x(1)-gamma2/m2*x(3)-k2/m2*x(4);
xdot(4)=x(3);
end