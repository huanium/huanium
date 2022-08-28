theta0 = pi/3;
L = 100;
g= 9.8;
time = 0.563257;
[t,y] = ode45(@f,[time 0.95],[asin(2*sin(theta0)/3); -sqrt((3*g/L)*(sin(theta0)-(2/3)*sin(theta0)))]);

plot(t,y(:,1),'-o')
title('Solution');
xlabel('Time t');
ylabel('Solution y');
legend('y_1')

function dydt = f(t,y)
g = 9.8;
L = 100;
dydt = [y(2); 3*cos(y(1))*(-2*g/L+sin(y(1))*y(2)^2)/(3*cos(y(1))^2+1)];

end