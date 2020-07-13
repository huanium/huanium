%%%%%%%%%%%%%%%%%%%
% clock starts
tic 
% clock starts
%%%%%%%%%%%%%%%%%%%

%profile -timestamp 
%prof = profile('info');
%disp(prof);



%format longEng
format short e
global N
global p
global g
global state0
N    = 12;
p    = N/2;
%g    = 1*ones(N,1);
g    = 2*rand(N,1);
state0 = zeros(2^N,1);
%I   = eye(N^2);
%ub  = (pi/2)*ones(2*p,N);
%lb  = 0*ones(2*p,N);
%Aeq = [];
%beq = [];
eigv = diag(zeros(2^N,1));
Hamiltonian = -ZZ(N, ones(N,1)) - gX(N, ones(N,1), g);
[state0, eigv] = eigs(Hamiltonian, 1, 'smallestreal');

x = zeros(N^2);
fval = 0;

% unconstrained
options = optimoptions('fminunc','OptimalityTolerance', 5e-4, 'MaxIterations', 30, 'MaxFunctionEvaluations', 1500,...
                       'PlotFcn', 'optimplotfval');
%[x , fval] = fminunc(@(params) Energy_expectation(params), (pi/(N+3))*ones(2*p,N), options);
[x , fval] = fminunc(@(params) overlap(params), (pi/(N+3))*ones(2*p,N), options);
% constrained
%[x , fval] = fmincon(@(params) Energy_expectation(params), ones(2*p,N), I, ub, [], [], lb ,ub);

disp('Ground state energy')
GE = ground_state_energy(N,g);
disp(GE)
%disp('Energy minimum')
%disp(fval);
disp('Optimal angles')
disp(x);
%disp(['Fidelity by Energy: ' num2str(fval*100/GE) '%']);
disp(['Fidelity by Overlap: ' num2str(-fval*100) '%']);

%%%%%%%%%%%%%%%%%%%
% clock ends
Duration = seconds(round(toc));
Duration.Format = 'hh:mm:ss';
disp(['Time taken : ' char(Duration)]);
disp(['Time in sec: ' num2str(toc)]);
disp(' ')
% clock ends
%%%%%%%%%%%%%%%%%%%

