% choose a value for I
I = 0.0;
% fix model parameters at traditional values
a = 0.7;
b = 0.8;
epsilon = 0.08;
% find equilibrium value of membrane potential
v_eq = fzero(@(v)(v - (v^3)/3 - (a+v)/b + I),0);
% find equilibrium value of recovery variable
w_eq = (a + v_eq)/b;
% pick initial values
y0 = [v_eq, w_eq - 0.01];
% pick a time interval
tspan = [0, 100];
% use the equations you defined
ode = @(t,y) FHN_model(t,y,I,a,b,epsilon);
% solve the equations
options = odeset('RelTol',1e-6);
[t,y] = ode45(ode,tspan,y0,options);

figure(1);
plot(t,y(:,1),'k');
title('Membrane Potential V(t) vs. Time (t)')
ylabel('Membrane Potential V(t)') 
xlabel('Time (t)') 
hold on;
% figure(2);
% plot(t,y(:,2),'k');
% title('Recovery Variable W(t) vs. Time (t)')
% ylabel('Recovery Variable W(t)') 
% xlabel('Time (t)') 
% hold on;
% figure(3);
% plot(y(:,1),y(:,2),'k');
% title('Recovery Variable W(t) vs. Membrane Potential V(t)')
% ylabel('Recovery Variable W(t)') 
% xlabel('Membrane Potential V(t)') 


%% look for refractory period


% create a vector containing a series of perturbation sizes
Is = 0.14;
% loop over all perturbation sizes

 
hold on
v_eq = fzero(@(v)(v - (v^3)/3 - (a+v)/b + I),0);
w_eq = (a + v_eq)/b;
y0 = [v_eq, w_eq - 0.01];
% change I for each step
ode = @(t,y) FHN_model(t,y,Is,a,b,epsilon);
[tC,yC] = ode45(ode,tspan,y0,options);
% V(t) vs. t
plot(tC, yC(:,1))
hold on
title('Membrane Potential V(t) vs. Time (t)')
xlabel('Time (t)') 
ylabel('Membrane Potential V(t)')








%% for perturbation in I
% % to look for excitation block
% 
% % create a vector containing a series of perturbation sizes
% Is = 0.135927813:0.000000001:0.135927814;
% Is_critical = sort([Is 0.1358 0.1359 0.135926 0.1359277 0.1359278 0.13592781...
%     0.135927812 0.135927813 0.1359278135 0.135927815 0.135927820 0.135927825...
%     0.135927830 0.135927860 0.135929 0.13594 0.136 0.137]);
% Is = sort([Is Is_critical]);
% % Is = sort([Is 0.2:0.4:2 ]);
% %Is = 0:0.75:1.5;
% responses = zeros(1,length(Is));
% % loop over all perturbation sizes
% 
% hold on
% % changing starting point
% %time = 10;
% %y0 = [y(time, 1),y(time,2)];
%     
% for j = 1: length(Is)
%     v_eq = fzero(@(v)(v - (v^3)/3 - (a+v)/b + I),0);
%     w_eq = (a + v_eq)/b;
%     y0 = [v_eq, w_eq - 0.01];
%     % change I for each step
%     ode = @(t,y) FHN_model(t,y,Is(j),a,b,epsilon);
%     [tC,yC] = ode45(ode,tspan,y0,options);
%     responses(j) = max(yC(:,1)) - v_eq;
%     % V(t) vs. t
%     figure(3);
%     if j == 1
%         plot(tC, yC(:,1),'LineStyle', '-.','LineWidth',3,'Color','k')
%     else
%         plot(tC, yC(:,1))
%     end
%     title('Membrane Potential V(t) vs. Time (t)')
%     xlabel('Time (t)') 
%     ylabel('Membrane Potential V(t)') 
%     hold on
%     % W(t) vs. t
% %    figure(4);
% %     if j == 1
% %         plot(tC, yC(:,2),'LineStyle', '-.','LineWidth',3,'Color','k')
% %     else
% %         plot(tC, yC(:,2))
% %     end
% %     title('Recovery Variable W(t) vs. Time (t)')
% %     xlabel('Time (t)') 
% %     ylabel('Recovery Variable W(t)') 
% %     hold on
%     % phase trajectories
% %     figure(3);
% %     if j == 1
% %         plot(yC(:,1), yC(:,2),'LineStyle', '-.','LineWidth',3,'Color','k')
% %     else
% %         plot(yC(:,1), yC(:,2))
% %     end
% %     plot(yC(:,1), yC(:,2))
% %     title('Phase Trajectories W(t) vs. V(t)')
% %     xlabel('Membrane Potential V(t)') 
% %     ylabel('Recovery Variable W(t)') 
% %     hold on
% end
% % % chart threshold
% 
% % figure(3);
% % VV = -2:0.01:2.1;
% % WW = VV-VV.^3./3  ;
% % plot(VV,WW,'LineWidth',1,'Color','k');
% % plot(VV,WW+1.5,'LineWidth',1,'Color','k');
% % plot(VV,(VV+0.7)/0.8,'LineWidth',1,'Color','k');
% % 
% % figure(4);
% % plot(Is, responses, 'o-', 'LineWidth',1);
% % title('Max V(t) vs. W Perturbation')
% % xlabel('Perturbation in Recovery Variable') 
% % ylabel('Max Membrane Potential') 
% % hold on
% 
% % for j = 1: length(Is_critical)
% %     v_eq = fzero(@(v)(v - (v^3)/3 - (a+v)/b + I),0);
% %     w_eq = (a + v_eq)/b;
% %     y0 = [v_eq, w_eq - 0.01];
% %     % change I for each step
% %     ode = @(t,y) FHN_model(t,y,Is_critical(j),a,b,epsilon);
% %     [t,y] = ode45(ode,tspan,y0,options);
% %     responses(j) = max(y(:,1)) - v_eq;
% %     % phase trajectories
% %     figure(3);
% %     plot_dir(y(:,1), y(:,2));
% %     title('Phase Trajectories W(t) vs. V(t)')
% %     xlabel('Membrane Potential V(t)') 
% %     ylabel('Recovery Variable W(t)') 
% %     hold on
% % end
% % hold off





%% for perturbation initial condition in W

% % create a vector containing a series of perturbation sizes
% steps = 0.1:0.01:0.25;
% steps_critical = [0.182400 0.1826300 0.1826760 0.1826786 0.18267885 0.1826789 0.18267891 0.18267892...
%     0.1826790 0.1826795 0.1826900 0.182800 0.18400];
% steps = sort([steps steps_critical]);
% % create another vector in which to store responses
% responses = zeros(1,length(steps));
% % loop over all perturbation sizes
% 
% 
% hold on
% for j = 1: length(steps)
%     % pick initial values
%     y0 = [v_eq, w_eq - steps(j)];
%     % solve the equations
%     [t,y] = ode45(ode,tspan,y0,options);
%     % find maximum in membrane voltage response
%     responses(j) = max(y(:,1)) - v_eq;
%     % V(t) vs. t
%     figure(1);
%     if j == 1
%         plot(t, y(:,1),'LineStyle', '-.','LineWidth',3,'Color','k')
%     else
%         plot(t, y(:,1))
%     end
%     title('Membrane Potential V(t) vs. Time (t)')
%     xlabel('Time (t)') 
%     ylabel('Membrane Potential V(t)') 
%     hold on
%     % W(t) vs. t
%     figure(2);
%     if j == 1
%         plot(t, y(:,2),'LineStyle', '-.','LineWidth',3,'Color','k')
%     else
%         plot(t, y(:,2))
%     end
%     title('Recovery Variable W(t) vs. Time (t)')
%     xlabel('Time (t)') 
%     ylabel('Recovery Variable W(t)') 
%     hold on
%     % phase trajectories
%     figure(3);
%     if j == 1
%         plot(y(:,1), y(:,2),'LineStyle', '-.','LineWidth',3,'Color','k')
%     else
%         plot(y(:,1), y(:,2))
%     end
%     title('Phase Trajectories W(t) vs. V(t)')
%     xlabel('Membrane Potential V(t)') 
%     ylabel('Recovery Variable W(t)') 
%     hold on
% end
% % % chart threshold
% figure(4);
% plot(steps, responses, 'o-', 'LineWidth',1);
% title('Max V(t) vs. W Perturbation')
% xlabel('Perturbation in Recovery Variable') 
% ylabel('Max Membrane Potential') 
% hold on
% 
% for j = 1: length(steps_critical)
%     % pick initial values
%     y0 = [v_eq, w_eq - steps_critical(j)];
%     % solve the equations
%     [t,y] = ode45(ode,tspan,y0,options);
%     % find maximum in membrane voltage response
%     responses(j) = max(y(:,1)) - v_eq;
%     % phase trajectories
%     figure(3);
%     plot_dir(y(:,1), y(:,2));
%     title('Phase Trajectories W(t) vs. V(t)')
%     xlabel('Membrane Potential V(t)') 
%     ylabel('Recovery Variable W(t)') 
%     hold on
% end
% hold off





%%

function dy = FHN_model(t,y,I,a,b,epsilon)
    % model equations
    dy = zeros(2,1);
    dy(1) = y(1) - (y(1)^3)/3 - y(2) + I;
    dy(2) = epsilon*(y(1) + a - b*y(2));
end
