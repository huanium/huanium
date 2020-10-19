% %%%% LIMIT CYCLE %%%%%%%%

epsilon = 1e-2;
f = 0.65;
q = 2e-3;
tspan = [0 20];
ueq = 0.5*(1-q-f) + 0.5*sqrt((1-q-f)^2 + 4*(1+f)*q);
veq = ueq;

% y1 = 0.02:0.05:0.5;
% y2 = 0.02:0.05:0.5;
% for j = 1:length(y1)
%     solve_traj(y1(j)-0.01,y2(j), epsilon, f, q ,tspan );
% end
% for j = 1:length(y2)
%     solve_traj(1,y2(j), epsilon, f, q ,tspan );
% end
% solve_traj(0.01, 0.06, epsilon, f, q ,tspan );
% solve_traj(0.06, 0.12, epsilon, f, q ,tspan );
% solve_traj(0.1, 0.17, epsilon, f, q ,tspan );
% solve_traj(0.14, 0.22, epsilon, f, q ,tspan );
% solve_traj(0.2, 0.27, epsilon, f, q ,tspan );
% solve_traj(0.26, 0.32, epsilon, f, q ,tspan );
% solve_traj(0.46, 0.38, epsilon, f, q ,tspan );
% solve_traj(ueq - 1e-6, veq - 1e-6, epsilon, f, q ,tspan );
% solve_traj(ueq + 1e-6, veq - 1e-6, epsilon, f, q ,tspan );
% solve_traj(ueq - 1e-6, veq + 1e-6, epsilon, f, q ,tspan );
% solve_traj(ueq + 1e-6, veq + 1e-6, epsilon, f, q ,tspan );



% % solve for limit cycle:
% y0 = [0.49592,0.02283];
% %
% % use the equations you defined
% ode = @(t,y) BZ_model(t,y,epsilon,q,f);
% J = @(t,y) BZ_Jacobian(t,y,epsilon,q,f);
% % solve the equations
% options = odeset('RelTol',1e-7,'Jacobian',J);
% [t,y] = ode15s(ode,tspan,y0,options);
% hold on
% figure(1)
% % phase trajectories
% plot(y(:,1), y(:,2), 'LineWidth', 2,'Color', 'k');
% %plot_dir(y(:,1), y(:,2));
% 
% % nullcline number 1
% y1 = 0:0.01:1;
% y2 = y1.*(1-y1).*(y1+q)./(f.*(y1-q));
% plot(y1, y2, 'LineWidth',2, 'Color','b');
% 
% % nullcline number 2
% y1 = 0:0.01:0.5;
% y2 = y1;
% plot(y1, y2, 'LineWidth',2, 'Color','b');



% y0 = [ueq+1e-7, veq+4e-8];
% % use the equations you defined
% ode = @(t,y) BZ_model(t,y,epsilon,q,f);
% J = @(t,y) BZ_Jacobian(t,y,epsilon,q,f);
% % solve the equations
% options = odeset('RelTol',1e-7,'Jacobian',J);
% [t,y] = ode15s(ode,tspan,y0,options);
% hold on
% figure(1)
% % phase trajectories
% plot(y(:,1), y(:,2), 'Color', 'r');
% %plot_dir(y(:,1), y(:,2));
% title('V vs U')
% xlabel('U')
% ylabel('V')
% figure(3)
% plot(t,y(:,1),t,y(:,2), 'LineWidth',2);
% legend('U','V');
% title('U,V versus Time')
% xlabel('Time')
% ylabel('Concentration')





% f = [0.505];
% q = 2e-3;
% epsilon = 1e-2;
% 
% 
% for j = 1:length(f)
%    ueq = 0.5*(1-q-f(j)) + 0.5*sqrt((1-q-f(j))^2 + 4*(1+f(j))*q);
%    veq = ueq;
%    solve_traj(0.55, 0.55, epsilon, f(j), q ,tspan ) 
%    % nullcline number 1
%    %y1 = 0:0.01:1;
%    %y2 = y1.*(1-y1).*(y1+q)./(f(j).*(y1-q));
%    %plot(y1, y2, 'LineWidth',1, 'Color','b');
%    
%    % nullcline number 2
%    %y1 = 0:0.01:0.5;
%    %y2 = y1;
%    %plot(y1, y2, 'LineWidth',1, 'Color','b');
% end





% EXCITABILITY 

epsilon = 1e-2;
q = 2e-3;
f = 3;
tspan = [0, 1];
ueq = 0.5*(1-q-f) + 0.5*sqrt((1-q-f)^2 + 4*(1+f)*q);
veq = ueq;
pert = 0:1e-4:1e-3;
% equilibrium
y0 = [ueq,veq];
% use the equations you defined
ode = @(t,y) BZ_model(t,y,epsilon,q,f);
J = @(t,y) BZ_Jacobian(t,y,epsilon,q,f);
% solve the equations
options = odeset('RelTol',1e-7,'Jacobian',J);
[t,y] = ode15s(ode,tspan,y0,options);
hold on
figure(1)
plot(y(:,1), y(:,2), 'Color' ,'k');
title('y2 vs y1')
xlabel('y1')
ylabel('y2')
figure(2)
plot(t,y(:,1), 'Color', 'k');
%%%%%%%%%%%%%%%%%

% create a vector containing a series of perturbation sizes
steps = 0.179999:0.00000001:0.180001001;
% create another vector in which to store responses
responses = zeros(1,length(steps));
% loop over all perturbation sizes
for j = 1: length(steps)
    solve_traj(ueq - pert(k), veq - pert(k), epsilon, f, q ,tspan );
    % pick initial values
    y0 = [ueq - steps(j), veq - steps(j)];
    % solve the equations
    [t,y] = ode15s(ode,tspan,y0,options);
    % find maximum in membrane voltage response
    responses(j) = max(y(:,1));
end
% plot results
figure(3);
plot(steps, responses, 'o-');




%%%%%%%% FUNCTIONS %%%%%%%%


function solve_traj(y1,y2, epsilon, f, q, tspan)
    y0 = [y1, y2];
    % use the equations you defined
    ode = @(t,y) BZ_model(t,y,epsilon,q,f);
    J = @(t,y) BZ_Jacobian(t,y,epsilon,q,f);
    % solve the equations
    options = odeset('RelTol',1e-7,'Jacobian',J);
    [t,y] = ode15s(ode,tspan,y0,options);
    hold on
    figure(1)
    % phase trajectories
    plot(y(:,1), y(:,2), 'Color', 'r');
    %plot(y(:,1), y(:,2));
    %plot_dir(y(:,1), y(:,2));
    title('V vs U')
    xlabel('U')
    ylabel('V')
    figure(2)
    plot(t,y(:,1));
end




function dy = BZ_model(t,y,epsilon,q,f)
    % model equations
    dy = zeros(2,1);
    dy(1) = (y(1)*(1 - y(1)) - f*y(2)*(y(1) - q)/(y(1) + q))/epsilon;
    dy(2) = y(1) - y(2);
end

function J = BZ_Jacobian(t,y,epsilon,q,f)
    % Jacobian equations
    J = zeros(2,2);
    J(1,1) = (1 - 2*y(1) - 2*f*y(2)*q/(y(1) + q)^2)/epsilon;
    J(1,2) = (-f*(y(1) - q)/(y(1) + q))/epsilon;
    J(2,1) = 1;
    J(2,2) = -1;
end