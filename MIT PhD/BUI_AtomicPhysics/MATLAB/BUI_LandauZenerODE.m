% Huan Q. Bui
% 2nd order ODE solver for Landau-Zener problem

clear all
close all
global gamma

tspan = [-60 60];
B0 = 1;
C0 = 0;
gamma = 0.1;

[t,y] = ode45(@LZ_ODE,tspan,[B0; C0]);
% y(1) = B
% y(2) = C = \dot{B}

plot(t,abs(y(:,1)).^2,'LineWidth', 2)
title('|B(\tau)|^2 with \gamma = 0.1 using ODE45');
xlabel('Time \tau');
ylabel('Transition Probability |B(\tau)|^2');
grid on

% plot LZ prediction
yline(exp(-2*pi*gamma), 'LineWidth',2);

% legend
legend('|B(t)|^2', 'Exp(-2\pi\gamma)');

function dydt = LZ_ODE(t,y)
    global gamma
    dydt = [y(2); -1i*gamma.*t.*y(2) - gamma^2.*y(1)];
end
