% % pick a time interval
tspan = [0, 100];
% pick initial values of y(1), y(2), y(3)
init = [0, 0.001, 0];
% choose a value for r
r = 28;

figure(1)
figure(2)
figure(3)
% figure(4)
% figure(5)
% figure(6)
for j = 1:length(r)
% use the equations you defined
ode = @(t,y) lorenzeqns(t,y,r(j));
% solve the equations
options = odeset('RelTol',1e-8);
[t,y] = ode45(ode,tspan,init,options);
% plot results
hold on
figure(1)
plot(y(:,1),y(:,2))
hold on
figure(2)
plot(y(:,2),y(:,3))
hold on
figure(3)
plot(y(:,1),y(:,3))
% hold on 
% figure(4)
% plot(t,y(:,1))
% hold on 
% figure(5)
% plot(t,y(:,2))
%hold on 
%figure(6)
%plot(t,y(:,3))
end






% % pick initial values of y(1), y(2), y(3)
% init_0 = [0, 0.001, 0];
% r = 28;
% tspan = [0, 100];
% for j = 1:length(r)
% ode = @(t,y9) lorenzeqns(t,y9,r);
% options = odeset('RelTol',1e-8);
% [t,y9] = ode45(ode,tspan, init_0 ,options);
% end
% % pick initial values of y(1), y(2), y(3)
% init_1 = [0, 0.001+1e-7, 0];
% r = 28;
% tspan = [0, 100];
% for j = 1:length(r)
% ode = @(t,y) lorenzeqns(t,y,r);
% options = odeset('RelTol',1e-8);
% [t,y] = ode45(ode,tspan, init_1 ,options);
% end
% X0 = y(:,1);
% X9 = y9(:,1);
% X0 = X0(1:28000);
% X9 = X9(1:28000);
% plot(X0-X9);
% xlabel('Time')
% ylabel('Difference in solution')
% title('X_perturbed-X_0')





% %%%%% bifurcation diagram %%%%%%
% % pick a time interval
% tspan = [0, 1000];
% % pick initial values of y(1), y(2), y(3)
% init = [0, 1, 2];
% % create an array in which to store X steady state values
% n = 200;
% x = zeros(n,1);
% r = x;
% % loop over n values of r
% rmax = 28;
% for j = 1:n
% % choose a value for r
% disp(['Progress/',num2str(n)]);
% disp(j);
% r(j) = rmax*j/n;
% % define "ode" using the actual lorenz eqns for your chosen r
% ode = @(t,y) lorenzeqns(t,y,r(j));
% % solve the lorenz eqns
% options = odeset('RelTol',1e-6);
% [t,y] = ode45(ode,tspan,init,options);
% % store a result
% x(j) = y(end,1);
% end
% % plot results
% plot(r,x)
% title('Steady state of y(1) as a function of r')
% xlabel('r')
% ylabel('steady state of y(1)')



% %%%% Z peaks &&&&&&&
% 
% pick a time interval
% tspan = [0, 10000];
% % pick initial values of y(1), y(2), y(3)
% init = [0, 0.001, 0];
% % choose a value for r
% r = 28;
% 
% % use the equations you defined
% ode = @(t,y) lorenzeqns(t,y,r);
% % solve the equations
% options = odeset('RelTol',1e-6);
% [t,y] = ode45(ode,tspan,init,options);
% 
% 
% [a,b] = peakdet(y(:,3),0.1,t);
% plot(a(:,1),a(:,2),'o',t,y(:,3));
% num = length(a(:,2));
% plot(a(1:num-1,2),a(2:num,2),'.')
% xlabel('Current max')
% ylabel('Next max')







%%%%% functions %%%%%%

function dy = lorenzeqns(t,y,r)
sig = 10;
b = 8/3;
dy = zeros(3,1);
dy(1) = sig*(y(2) - y(1));
dy(2) = r*y(1) - y(2) - y(1)*y(3);
dy(3) = y(1)*y(2) - b*y(3);
end
