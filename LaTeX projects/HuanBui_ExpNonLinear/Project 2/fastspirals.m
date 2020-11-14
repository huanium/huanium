function [makestep,stepper]=fastspirals(m,n)
stepper=@spirals;
makestep=@creatematrix;
mn=m*n;

function [unew,vnew] = spirals(u,v,dt,A,B,RHSmatu,RHSmatv,Lu,Lv,Uu,Uv,Pu,Pv)
%
%   This routine updates the Brusselator variables
%   u and v and updates them one time step of size dt
%
%   Inputs:    u -  the first reactact concentration
%              v -  the second reactant concentration
%              n - the number of points in x direction
%              m - the number of points in y direction
%              dt- the size of the timestep
%            A,B,D1,D2 - parameters in the model
%
%   Model:     u_t = D1 (u_xx+u_yy) + A - (B+1)u + u^2*v
%              v_t = D2 (v_xx+v_yy) + B*u - u^2*v
%        boundary conditions: u_x(0,y,t)=u_x(1,y,t)=u_y(x,0,t)=u_y(x,1,t)=0
%                             v_x(0,y,t)=v_x(1,y,t)=v_y(x,0,t)=v_y(x,1,t)=0
%
%   Outputs:   unew - the new first reactant concentration
%              vnew - the new second reactant concentration
%mn=m*n;
% the RHS vector
%RHSu=(ID+dt.*D1.*L/2)*u + dt.*(A-(B+1).*u+u.^2.*v) ;
%RHSv=(ID+dt.*D2.*L/2)*v + dt.*(B.*u-u.^2.*v) ;
RHSu=RHSmatu*u + dt.*(A-(B+1).*u+u.^2.*v) ;
RHSv=RHSmatv*v + dt.*(B.*u-u.^2.*v) ;
%
rows=1:n;
RHSu(rows)=0;
RHSu(mn-n+rows)=0;
RHSv(rows)=0;
RHSv(mn-n+rows)=0;

% each equation is LHS*x = RHS, so invert LHS:
unew = Uu\(Lu\(Pu*RHSu));
vnew = Uv\(Lv\(Pv*RHSv));
end

function [RHSmatu,RHSmatv,Lu,Lv,Uu,Uv,Pu,Pv] = creatematrix(dt,D1,D2)
% create the time stepping matrices.  
% global variables n,m,dt,D1,D2 are used in creating this routine.
% Their values are taken from the arguments to fastapirals

% set up h   
hx=(1-0)/(n-1);
hy=(1-0)/(m-1);

% set up laplacian matrix
rows=2:n-1;
ID=sparse(mn,mn);
UP=sparse(mn,mn);
DN=sparse(mn,mn);
LF=sparse(mn,mn);
RT=sparse(mn,mn);
for j=2:m-1
    rows=rows+n;
    ID=ID+sparse(rows,rows,1,mn,mn);
    UP=UP+sparse(rows,rows-1,1,mn,mn);
    DN=DN+sparse(rows,rows+1,1,mn,mn);
    LF=LF+sparse(rows,rows-n,1,mn,mn);
    RT=RT+sparse(rows,rows+n,1,mn,mn);
end
% Laplacian
L=(UP-2*ID+DN)/hy^2+(LF-2*ID+RT)/hx^2;

% Setup boundary conditions
%  These values are the coefficients of a three point derivative on the boundary
values=[-3/2 2 -1/2 -3/2 2 -1/2];
valuesx=values/hx;
valuesy=values/hy;

% X-direction
rows=1:n;
bc=   sparse(rows,rows,valuesx(1),mn,mn);
disp(size(bc));
bc=bc+sparse(rows,rows+n,valuesx(2),mn,mn);
bc=bc+sparse(rows,rows+2*n,valuesx(3),mn,mn);
rows=mn-n+(1:n);
bc=bc+sparse(rows,rows,valuesx(1),mn,mn);
bc=bc+sparse(rows,rows-n,valuesx(2),mn,mn);
bc=bc+sparse(rows,rows-2*n,valuesx(3),mn,mn);
% Y-direction
rows=[1,1,1,n,n,n];
cols=[1 2 3 n n-1 n-2];
for j=2:m-1
    rows=rows+n;
    cols=cols+n;
    bc=bc+sparse(rows,cols,valuesy,mn,mn);
end


%Now form left hand side matrix
LHSu=ID-dt.*D1.*L/2 + bc;
LHSv=ID-dt.*D2.*L/2 + bc;
[Lu,Uu,Pu]=lu(LHSu);
[Lv,Uv,Pv]=lu(LHSv);
%inverseLHSu=inv(LHSu);
%inverseLHSv=inv(LHSv);

% Build RHS matrix for laplacian
RHSmatu=(ID+dt.*D1.*L/2);
RHSmatv=(ID+dt.*D2.*L/2);
disp('Done making matrices')
end
disp('done defining functions')
end
