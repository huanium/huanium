function dy = BZ_model(t,y,epsilon,q,f)

    % model equations
    dy = zeros(2,1)
    dy(1) = (y(1)*(1 - y(1)) - f*y(2)*(y(1) - q)/(y(1) + q))/epsilon;
    dy(2) = y(1) - y(2);
    
end