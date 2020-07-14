N    = 6;
x = zeros(2*p*N,1);
fval = 0;
%ex = matfile('x_N_4.mat');
%x = ex.x;
p    = N/2;
g    = 2*rand(N,1);
state0 = zeros(2^N,1);
A   = eye(2*p*N);
ub  = (pi/2)*ones(2*p*N,1);
lb  = zeros(2*p*N,1);
eigv = diag(zeros(2^N,1));
Hamiltonian = -ZZ(N, ones(N,1)) - gX(N, ones(N,1), g);
[state0, eigv] = eigs(Hamiltonian, 1, 'SA');

if max(size(gcp)) == 0 % parallel pool needed
    parpool % create the parallel pool
end

% unconstrained
% no displaying to optimize speed

%options = optimoptions('fminunc','OptimalityTolerance', 5e-4, 'MaxIterations', 30, 'MaxFunctionEvaluations', 1500);
%[x , fval] = fminunc(@(params) Energy_expectation(params), (pi/(N+3))*ones(2*p,N), options);
%[x , fval] = fminunc(@(params) overlap(params,g,N,p,state0), (pi/(N+3))*ones(2*p*N,1), options);

% constrained
% 'Display','iter', 'PlotFcn', 'optimplotfval', 'Algorithm', 'sqp'
options = optimoptions('fmincon','UseParallel',true, 'Algorithm','interior-point', 'Display','final-detailed' ,...
    'ConstraintTolerance', 1e-3,'MaxFunctionEvaluations', 4000, 'MaxIterations', 1000,...
    'OptimalityTolerance', 5e-3, 'StepTolerance', 1e-4, 'PlotFcn', 'optimplotfval');
%[x , fval] = fmincon(@(params)  Energy_expectation(params,g,N,p), (pi/(N+2))*ones(2*p*N,1), [], [], [], [], lb, ub, [],  options);

%%%%%%%%%%%%%%%%%%%
% clock starts
tic 
% clock starts
%%%%%%%%%%%%%%%%%%%
[x , fval] = fmincon(@(params)  overlap(params,g,N,p,state0), (pi/(N+2))*ones(2*p*N,1), [], [], [], [], lb, ub, [],  options);

disp('Ground state energy')
GE = ground_state_energy(N,g);
disp(GE)
%disp('Energy minimum')
%disp(fval);

disp('Optimal angles')
disp(reshape(x,[2*p,N]));
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

%save('x_N_4.mat', 'x');

