function [x,t]=demoCoupledHarmonicOscillatorsOld(dragCoeff,varargin)
%wrapper function for the ODE coupledHO
%drag coeff is n*sigma*v in collisional limit
%if meanFieldShift is set to true, then the bare frequencies get the
%shifted by MF
p = inputParser;

p.addParameter('meanFieldShift',false);%mean field shifting of freqs
p.addParameter('aBF',[]);%scattering
p.addParameter('density',[]);%in m^-3

p.parse(varargin{:});

meanFieldShift                 =p.Results.meanFieldShift;
aBF                            =p.Results.aBF;
density                        =p.Results.density;

%parameters
N2OverN=0.01; %proportion in population 2

gamma2=4/3*dragCoeff*(1-N2OverN)*mNa/(mNa+mK);
gamma1=4/3*dragCoeff*N2OverN*mK/(mK+mNa);
f=1/1000; %to make time in milliseconds

omega1=(2*pi*78*f); 
omega2=(2*pi*125*f);
if meanFieldShift
    if isempty(aBF)||isempty(density)
        errror('MF shift requires aBF parameter and density parameter!');
    end
    energyShiftMF=2*pi*hbar^2*aBF/mReduced*density;
    yTF=70e-6;
    omega2=sqrt(max(omega2^2-energyShiftMF*2/mK/yTF^2,0));
end

%get initial condistions: initial velocity1, pos1, velocity2, pos2
vRatio=(55/35)^2;
initialCond=[-1;0;-vRatio;0];
endTime=500;

[t,x] = ode45(@(t,y) coupledHO(t,y,omega1,omega2,gamma1,gamma2),linspace(0,endTime,400),initialCond);
%
figure(3);clf; hold on;
plot(t,x(:,2),'LineWidth',2);
plot(t,x(:,4),'LineWidth',2);
legend('Na','K');
ylabel('COM');
xlabel('ms');

end
function ydot= coupledHO(t,y,omega1,omega2,gamma1,gamma2)
%to pass the parameters into ode45, which only takes two inputs
%represent {velocity 1, position 1, velocity 2, position 2}
ydot=zeros(4,1);
ydot(1)=-gamma1*y(1)-omega1^2*y(2)+gamma1*y(3);
ydot(2)=y(1);
ydot(3)=gamma2*y(1)-gamma2*y(3)-omega2^2*y(4);
ydot(4)=y(3);

end