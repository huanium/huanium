% Author: Huan Q. Bui
% June 24, 2021
% Simple demo of PID control


% proportional constant 
Kp = 0.5;
% Integral constant
Ki = 1;
% Derivative constant
Kd = 0.0015;    


n = 300;
dt = 1/n;
% system output
y = zeros(n,1);
% set point/control signal
r = ones(n,1) + rand(n,1)/100;
%r(30:end)=1;
% error signal
e = zeros(n,1);
% control function
u = zeros(n,1);
dEdt = 0;


h = figure(1)
for t = 1:n
    e(t) = r(t)-y(t); % error signal
    if t == 1
        dEdt = 0;
    elseif t > 1
        dEdt = (e(t) - e(t-1))/dt;
    end    
    u(t) = Kp*e(t) + Ki*sum(e(1:t))*dt + Kd*dEdt; 
    
    y(t+1) = y(t) + u(t); 
end

plot(y);
hold on
plot(r);
hold off
legend('y','r')
