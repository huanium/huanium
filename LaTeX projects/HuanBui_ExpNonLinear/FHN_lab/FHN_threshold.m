% create a vector containing a series of perturbation sizes
steps = 0.01:0.01:0.32;
% create another vector in which to store responses
responses = zeros(1,length(steps));
% loop over all perturbation sizes
for j = 1: length(steps)
    % pick initial values
    y0 = [v_eq, w_eq - steps(j)];
    % solve the equations
    [t,y] = ode45(ode,tspan,y0,options);
    % find maximum in membrane voltage response
    responses(j) = max(y(:,1)) - v_eq;
end
% plot results
plot(steps, responses, 'o-');
