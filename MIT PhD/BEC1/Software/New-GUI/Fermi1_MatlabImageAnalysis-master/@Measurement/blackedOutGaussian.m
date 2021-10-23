function values = blackedOutGaussian(this,p,x)

    fitfun = @(p,x) p(1)+p(2)*exp( -(...
    ( x(:,:,1)*cosd(p(7))-x(:,:,2)*sind(p(7)) - p(3)*cosd(p(7))+p(4)*sind(p(7)) ).^2/(2*p(5)^2) + ...
    ( x(:,:,1)*sind(p(7))+x(:,:,2)*cosd(p(7)) - p(3)*sind(p(7))-p(4)*cosd(p(7)) ).^2/(2*(p(5)*p(6))^2) ) );

    values = fitfun(p,x);
    
end