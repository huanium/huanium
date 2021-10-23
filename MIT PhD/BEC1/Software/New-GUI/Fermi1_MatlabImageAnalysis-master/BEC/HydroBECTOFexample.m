%%

syms bx(t) by(t) bz(t) oX oY oZ
Eqs = [(diff(bx(t),2)) == oX^2./(bx(t).*bx(t).*by(t).*bz(t)), ...
       (diff(by(t),2)) == oY^2./(by(t).*bx(t).*by(t).*bz(t)),...
       (diff(bz(t),2)) == oZ^2./(bz(t).*bx(t).*by(t).*bz(t))];
SymSys = odeToVectorField(Eqs)
Sys = @(t,Y,oX,oY,oZ) [Y(2);...
              oX^2/(Y(1)^2*Y(3)*Y(5));...
              Y(4);...
              oY^2/(Y(1)*Y(3)^2*Y(5));...
              Y(6);...
              oZ^2/(Y(1)*Y(3)*Y(5)^2) ];
omegaX = 2*pi*12.6;
omegaY = 2*pi*80;
omegaZ = 2*pi*100;
tspan=[0:0.0001:0.04];
Y0=[1 0 1 0 1 0];
[t,y] = ode45(@(t,Y) Sys(t,Y,omegaX,omegaY,omegaZ), tspan, Y0);
figure(1)
clf
hold on
plot(t, y(:,1),'LineWidth',2)
plot(t, y(:,3),'LineWidth',2)
plot(t, y(:,5),'LineWidth',2)
hold off
ylim([0,10])
legend(['X axis: ',num2str(omegaX/2/pi),'Hz'],['Y axis: ',num2str(omegaY/2/pi),'Hz'],['Z axis: ',num2str(omegaZ/2/pi),'Hz'])