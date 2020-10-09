% here we try to prepare the ground state of the disordered Ising Ham.
% Ham is of the form
% H = \sum fZ + gX + jZZ 
% where g, j, f random
% first we'll try this with just the gnd state of \sum Z

N    = 4;
k = 1; % indicates ground state
p = round(N/2);
M=N;
x = zeros(3*p*M,1); % 3 since we have three groups of parameters: g,j,f
fval = 0;
%rng('default');
g    = rand(N,1);
%rng('default');
J    = rand(N,1);
%rng('default');
f    = rand(N,1);
state0 = zeros(2^N,1);
ub  = (pi/2)*ones(3*p*M,1);
lb  = zeros(3*p*M,1);
eigv = 0;

% generate the fZ cell array of the Hamiltonian:
Sz = [1 0 ; 0 -1];
Id = [1 0 ; 0 1];
term = sparse(2,2);
cell_fZ = cell(N,1);
operators = cell(N,1);
for n = 0:N-1
    operators = horzcat( horzcat( repmat({Id},1,n), {f(n+1)*Sz}), repmat({Id}, 1 , N-1-n));
    term = operators{1};
    for o = 2:N 
        term = sparse(kron(term, operators{o}));
    end
    cell_fZ{n+1} = term;
end

% generate the gX cell array of the Hamiltonian:
Sx = [0 1 ; 1 0];
term = sparse(2,2);
cell_gX = cell(N,1);
operators = cell(N,1);
for n = 0:N-1
    operators = horzcat( horzcat( repmat({Id},1,n), {g(n+1)*Sx}), repmat({Id}, 1 , N-1-n));
    term = operators{1};
    for o = 2:N 
        term = sparse(kron(term, operators{o}));
    end
    cell_gX{n+1} = term;
end

% generate the ZZ cell array of the Hamiltonia:
Sz = [1 0 ; 0 -1];
cell_JZZ = cell(N,1);
term = sparse(2,2);
operators = cell(N,1);
for n = 0:N-2
    operators = horzcat( horzcat( repmat({Id},1,n)  ,horzcat({J(n+1)*Sz}, {Sz})), repmat({Id}, 1 , N-2-n));
    term = operators{1};
    for o = 2:N 
        term = sparse(kron(term, operators{o}));
    end
    cell_JZZ{n+1} = term;
end
% deals with the periodic term
operators = horzcat(horzcat( {Sz}, repmat({Id}, 1, N-2) ), {J(N)*Sz} );
term = operators{1};
for o = 2:N 
    term = sparse(kron(term, operators{o}));
end
cell_JZZ{N} = term;


% generates Hamiltonian
Hamiltonian = sparse(2^N,2^N);
for i = 1:N
    Hamiltonian = Hamiltonian - cell_JZZ{i} - cell_gX{i} - cell_fZ{i};
end

% find the ground state and E_0
[state0, eigv] = eigs(Hamiltonian, k, 'SA');
%[state0, eigv] = eigs(Hamiltonian, 2^N, 'SA');


%if max(size(gcp)) == 0 % parallel pool needed
%    parpool % create the parallel pool
%end

% constrained
% 'Display','iter', 'PlotFcn', 'optimplotfval', 'Algorithm', 'sqp'
options = optimoptions('fmincon','UseParallel',true, 'Algorithm','interior-point', 'Display','iter' ,...
    'ConstraintTolerance', 1e-13,'MaxFunctionEvaluations', 1e6, 'MaxIterations', 4000,...
    'OptimalityTolerance', 1e-13, 'StepTolerance', 1e-13, 'PlotFcn', 'optimplotfval');
%%%%%%%%%%%%%%%%%%%
% clock starts
tic 
% clock starts
%%%%%%%%%%%%%%%%%%%

[angles , fval] = fmincon(@(params) disorder_overlap(params, N, p, state0, cell_gX, cell_JZZ, cell_fZ),...
    0.5*ones(3*p*M,1), [], [], [], [], lb, ub, [],  options);

% printout
disp(['System size: ' num2str(N)]);
disp(['Circuit depth: ' num2str(p)]);
disp(['Ground state energy: ' num2str(eigv)]);
disp('Optimal angles')
disp(reshape(angles, [3*p,N]));
disp(['Fidelity: ' num2str(-fval*100) '%']);

%%%%%%%%%%%%%%%%%%%
% clock ends
Duration = seconds(round(toc));
Duration.Format = 'hh:mm:ss';
disp(['Time taken : ' char(Duration)]);
% disp(['Time in sec: ' num2str(toc)]);
disp(' ')
% clock ends
%%%%%%%%%%%%%%%%%%%

