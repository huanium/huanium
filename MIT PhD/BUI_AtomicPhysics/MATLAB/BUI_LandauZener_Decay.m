% Huan Q. Bui
% Exponential decay in LZ transition probability

clear all
close all

% solve LZ ODE for these gammas
gamma = 0:0.05:1.5;
tspan = [-50 50];
B0 = 1;
C0 = 0;

B_list = [];

for g = gamma
    [t,y] = ode45(@(t,y) LZ_ODE(t,y,g),tspan,[B0; C0]);
    % y(1) = B
    % y(2) = C = \dot{B}
    
    % append the last B(t) = B(t=end) to B_list
    B_list = [B_list abs(y(end,1))^2];
end


plot(gamma,B_list,'-o')
hold on
plot(gamma, exp(-2*pi*gamma), 'LineWidth', 1)
hold off
title('|B(t_{end})| and Exp(-2\pi\gamma) vs. \gamma')
xlabel('\gamma')
ylabel('Transition probability')
legend('|B(t_f)|', 'Exp(-2\pi\gamma)')
grid on

function dydt = LZ_ODE(t,y,g)
    dydt = [y(2); -1i*g.*t.*y(2) - g^2.*y(1)];
end
