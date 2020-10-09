% fix model parameters values
epsilon = 1.2e-3;
q = 7.62e-5;
f = 5;

% find equilibrium values of reactants
ueq = 0.5*(1-q-f) + 0.5*sqrt((1-q-f)^2 + 4*(1+f)*q);
veq = ueq;

% pick initial values of y(1), y(2), y(3)
y0 = [ueq + 1e-5, veq + 1e-5];

% pick a time interval
tspan = [0, 50];

% use the equations you defined
ode = @(t,y) BZ_model(t,y,epsilon,q,f);
J = @(t,y) BZ_Jacobian(t,y,epsilon,q,f);

% solve the equations
options = odeset('RelTol',1e-6,'Jacobian',J);
[t,y] = ode15s(ode,tspan,y0,options);

% plot results
plot(t,y(:,2))


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