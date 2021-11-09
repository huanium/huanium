% Author: Huan Q. Bui
% June 30, 2021
% Simple demo of PID control 
% for a driven damped HO

% Inspired by: https://robotics.stackexchange.com...
% /questions/6859/how-to-implement-tracking-problem-with-pid-controller


clear all; close all; clc;

global error r dt time_array;

error = 0;
dt = 0.1;
stoptime = 100;

%%% create set(point)function
r = ones(stoptime/dt,1); % setpoint
%r(1:10) = 0;
r(floor((stoptime/dt)/4):(stoptime/dt)/2) = 0;
r(floor(3*(stoptime/dt)/(4)):end) = 0;
% define time array so that dimension matches setpoint r(t)
time_array = 0:dt:dt*(numel(r)-1);


x0 = [0; 0]; % initial condition, position & velocity = 0;
options = odeset('Reltol',dt,'Stats','off');
tspan = [time_array(1),time_array(end)];
[t_ode, x] = ode45(@ODESolver, tspan, x0, options);


% interpolate setpoint function 
% so that we have r(t) with the same dimension as 
% x(t) from ODE (which has finer resolution)
r_desired_ode = interp1(time_array,r,t_ode);
err = x(:,1) - r_desired_ode; % Error signal


%%% plotting %%%

figure(1)
plot(t_ode,x(:,1))
hold on 
plot(t_ode,r_desired_ode)
xlabel('Time (sec)');
ylabel('Position', 'Interpreter','LaTex');
legend('Actual position', 'Desired position')
grid on
hold off


% figure(2)
% plot(t_ode, x(:,2), 'r', 'LineWidth', 2);
% title('Velocity','Interpreter','LaTex');
% xlabel('time (sec)');
% ylabel('$\dot{\theta}(t)$', 'Interpreter','LaTex');
% grid on

%%% %%%

function dxdt = ODESolver(t, x)

    persistent r_old t_old;
    global error r time_array;

    if isempty(r_old)
        r_old = 0;
        t_old = 0;
    end
   
    % Parameters:
    beta = 1;
    omega0 = 2*pi;

    % PID tuning
    % Kp = 100;
    % Ki = 20;
    % Kd = 7;
    
    % PID tuning
    Kp = 70;
    Ki = 2;
    Kd = 10;
    
    % dr/dt: find the derivative of r(t) for D-gain:
    r_now = interp1(time_array,r,t);
    if t == t_old
        drdt = 0;
    else
        drdt  = (r_now - r_old)/(t-t_old);
    end
    r_old = r_now;

    % u: control function
    u = Kp*(r_now - x(1))... % P-gain
        + Kd*(drdt - x(2))... % D-gain
        + Ki*error; % I-gain;
    
    % new error signal, obtained by accumulating errors (integral)
    error = error + (r_now - x(1))*(t-t_old);
    
    % 2x2 system of 1st-order ODEs
    % initialize: matrix with position & velocity
    dxdt = zeros(2,1);
    dxdt(1) = x(2); % velocity
    dxdt(2) = (omega0^2)*u - beta*x(2) - (omega0^2)*x(1); % acceleration
    
    t_old = t;
end

