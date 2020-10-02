function J = BZ_Jacobian(t,y,epsilon,q,f)
    % Jacobian equations
    J = zeros(2,2);
    J(1,1) = (1 - 2*y(1) - 2*f*y(2)*q/(y(1) + q)^2)/epsilon;
    J(1,2) = (-f*(y(1) - q)/(y(1) + q))/epsilon;
    J(2,1) = 1;
    J(2,2) = -1;
end