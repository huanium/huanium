% fix model parameters values
epsilon = 6e-3;
q = 7.62e-5;
f = 5;

% find equilibrium values of reactants
ueq = 0.5*(1-q-f) + 0.5*sqrt((1-q-f)^2 + 4*(1+f)*q);
veq = ueq;

% pick initial values of y(1), y(2)
y0 = [ueq + 1e-5, veq + 1e-5];

% pick a time interval
tspan = [0, 100];
% 
% % use the equations you defined
% ode = @(t,y) BZ_model(t,y,epsilon,q,f);
% J = @(t,y) BZ_Jacobian(t,y,epsilon,q,f);
% 
% % solve the equations
% options = odeset('RelTol',1e-6,'Jacobian',J);
% [t,y] = ode15s(ode,tspan,y0,options);
% 
% % plot results
% figure
% plot(t,y(:,2))
% 
% figure 
% plot(y(:,1),y(:,2))




%%%% perturbation in epsilon & f %%%%%%%%


epsilon = 150e-3;
f = 0.6;
% loop over all epsilon sizes

for k = 1:length(f)
    for j = 1: length(epsilon)
        
        ueq = 0.5*(1-q-f(k)) + 0.5*sqrt((1-q-f(k))^2 + 4*(1+f(k))*q);
        veq = ueq;
        y0 = [ueq + 1e-5, veq + 1e-5];
        
        % use the equations you defined
        ode = @(t,y) BZ_model(t,y,epsilon(j),q,f(k));
        J = @(t,y) BZ_Jacobian(t,y,epsilon(j),q,f(k));
        
        % solve the equations
        options = odeset('RelTol',1e-7,'Jacobian',J);
        [t,y] = ode15s(ode,tspan,y0,options);
                
        hold on
        figure(1)
        % phase trajectories
        plot(y(:,1), y(:,2))
        title('y2 vs y1')
        xlabel('y1')
        ylabel('y2')
    end
end

for k = 1:length(f)
    for j = 1: length(epsilon)
        
        ueq = 0.5*(1-q-f(k)) + 0.5*sqrt((1-q-f(k))^2 + 4*(1+f(k))*q);
        veq = ueq;
        y0 = [ueq - 0.1, veq - 0.2];
        
        % use the equations you defined
        ode = @(t,y) BZ_model(t,y,epsilon(j),q,f(k));
        J = @(t,y) BZ_Jacobian(t,y,epsilon(j),q,f(k));
        
        % solve the equations
        options = odeset('RelTol',1e-7,'Jacobian',J);
        [t,y] = ode15s(ode,tspan,y0,options);
                
        hold on
        figure(1)
        % phase trajectories
        plot(y(:,1), y(:,2))
        title('y2 vs y1')
        xlabel('y1')
        ylabel('y2')
    end
end

for k = 1:length(f)
    for j = 1: length(epsilon)
        
        ueq = 0.5*(1-q-f(k)) + 0.5*sqrt((1-q-f(k))^2 + 4*(1+f(k))*q);
        veq = ueq;
        y0 = [0.1, 0.5];
        
        % use the equations you defined
        ode = @(t,y) BZ_model(t,y,epsilon(j),q,f(k));
        J = @(t,y) BZ_Jacobian(t,y,epsilon(j),q,f(k));
        
        % solve the equations
        options = odeset('RelTol',1e-7,'Jacobian',J);
        [t,y] = ode15s(ode,tspan,y0,options);
                
        hold on
        figure(1)
        % phase trajectories
        plot(y(:,1), y(:,2))
        title('y2 vs y1')
        xlabel('y1')
        ylabel('y2')
    end
end


for k = 1:length(f)
    for j = 1: length(epsilon)
        
        ueq = 0.5*(1-q-f(k)) + 0.5*sqrt((1-q-f(k))^2 + 4*(1+f(k))*q);
        veq = ueq;
        y0 = [0.26957798, 0.44287298];
        
        % use the equations you defined
        ode = @(t,y) BZ_model(t,y,epsilon(j),q,f(k));
        J = @(t,y) BZ_Jacobian(t,y,epsilon(j),q,f(k));
        
        % solve the equations
        options = odeset('RelTol',1e-7,'Jacobian',J);
        [t,y] = ode15s(ode,tspan,y0,options);
                
        hold on
        figure(1)
        % phase trajectories
        plot(y(:,1), y(:,2), 'LineWidth', 2, 'Color', 'k')
        title('y2 vs y1')
        xlabel('y1')
        ylabel('y2')
       
    end
end





%%%%%% mapping out Hopf bifurcation %%%%%%%

% to see what the attractor looks like --> need different initial condition
% fix epsilon, f and look at various initial conditions.

% epsilon = 6e-3;
% f = 1;
% ueq = 0.5*(1-q-f) + 0.5*sqrt((1-q-f)^2 + 4*(1+f)*q);
% veq = ueq;
% y1_pert = -ueq:ueq/2:2*ueq;
% y2_pert = -veq:veq/2:2*veq;
% % create another vector in which to store responses
% %responses1 = zeros(1,length(epsilon));
% %responses2 = zeros(1,length(epsilon));
% 
% % loop over all epsilon sizes
% 
% hold on
% for k = 1:length(y1_pert)
%     for j = 1: length(y2_pert)
%           
%         y0 = [ueq + y1_pert(k), veq + y2_pert(j)];
%         % use the equations you defined
%         ode = @(t,y) BZ_model(t,y,epsilon,q,f);
%         J = @(t,y) BZ_Jacobian(t,y,epsilon,q,f);
%         
%         % solve the equations
%         options = odeset('RelTol',1e-6,'Jacobian',J);
%         [t,y] = ode15s(ode,tspan,y0,options);     
%         
%         % y1 vs. t
% %         figure(1);
% %         plot(t, y(:,1))
% %         title('y1 vs. Time')
% %         xlabel('Time (t)')
% %         ylabel('y1')
% %         
% %         
% %         hold on
% %         % y2 vs. t
% %         figure(2);
% %         plot(t, y(:,2))
% %         title('y2 vs. Time (t)')
% %         xlabel('Time (t)')
% %         ylabel('y2')
%         
%         
%         hold on
%         % phase trajectories
%         figure(3);
%         plot(y(:,1), y(:,2))
%         title('y2 vs y1')
%         xlabel('y1')
%         ylabel('y2')
%         
%         hold on
%     end
% end
% % chart threshold
% figure(4);
% plot(f, responses1, 'o-', 'LineWidth',1);
% title('Max y1 vs. f Perturbation')
% xlabel('Perturbation') 
% ylabel('Max y1') 
% hold off






%%%%%%%% FUNCTIONS %%%%%%%%

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