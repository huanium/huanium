function [values] = HydroBECTOF(times,Omegas,varargin)
    p = inputParser;

    p.addParameter('Axis','Z');
    p.parse(varargin{:});
    
    axis  = p.Results.Axis;
    
    Sys = @(t,Y,oX,oY,oZ) [Y(2);...
              oX^2/(Y(1)^2*Y(3)*Y(5));...
              Y(4);...
              oY^2/(Y(1)*Y(3)^2*Y(5));...
              Y(6);...
              oZ^2/(Y(1)*Y(3)*Y(5)^2) ];
    
    omegaX = Omegas(1);
    omegaY = Omegas(2);
    omegaZ = Omegas(3);
    Y0=[1 0 1 0 1 0];
    [~,y] = ode45(@(t,Y) Sys(t,Y,omegaX,omegaY,omegaZ), times, Y0);
    
    if(strcmp(axis,'X'))
        values = y(:,1);
    elseif(strcmp(axis,'Y'))
        values = y(:,3);
    elseif(strcmp(axis,'Z'))
        values = y(:,5);
    end
end