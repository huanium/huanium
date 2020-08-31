N    = 5;
Ex = 4; % excited state number
%p    = round(log2(N));
p = round(N/2);
%p = round(log2(N));
M=N;
%M=1;
x = zeros(2*p*M,1);
fval = 0;
g    = 2*rand(N,1);
%g    = ones(N,1);
J    = 2*rand(N,1);
%J    = ones(N,1);
state0 = zeros(2^N,1);
A   = eye(2*p*M);
ub  = (pi/2)*ones(2*p*M,1);
lb  = zeros(2*p*M,1);
eigv = 0;

% generate the gXX cell array of the Hamiltonian:
Sx = [0 1 ; 1 0];
Id = [1 0 ; 0 1];
term = sparse(2,2);
cell_gX = cell(N,1);
operators = cell(N,1);
for k = 0:N-1
    operators = horzcat( horzcat( repmat({Id},1,k), {g(k+1)*Sx}), repmat({Id}, 1 , N-1-k));
    term = operators{1};
    for o = 2:N 
        term = sparse(kron(term, operators{o}));
    end
    cell_gX{k+1} = term;
end
% generate the ZZ cell array of the Hamiltonia:
Sz = [1 0 ; 0 -1];
cell_JZZ = cell(N,1);
term = sparse(2,2);
operators = cell(N,1);
for k = 0:N-2
    operators = horzcat( horzcat( repmat({Id},1,k)  ,horzcat({J(k+1)*Sz}, {Sz})), repmat({Id}, 1 , N-2-k));
    term = operators{1};
    for o = 2:N 
        term = sparse(kron(term, operators{o}));
    end
    cell_JZZ{k+1} = term;
end
operators = horzcat(horzcat( {Sz}, repmat({Id}, 1, N-2) ), {J(N)*Sz} );
term = operators{1};
for o = 2:N 
    term = sparse(kron(term, operators{o}));
end
cell_JZZ{N} = term;

% generates Hamiltonian
Hamiltonian = sparse(2^N,2^N);
for i = 1:N
    Hamiltonian = Hamiltonian - cell_JZZ{i} - cell_gX{i};
end

[state0, eigv] = eigs(Hamiltonian, Ex, 'SA');
state_gnd = state0(:,1); % take ground eigenstate
state0 = state0(:,end); % take last eigenstate
eigv = eigv(end); % take last eigenvalue

%if max(size(gcp)) == 0 % parallel pool needed
%    parpool % create the parallel pool
%end

% constrained
% 'Display','iter', 'PlotFcn', 'optimplotfval', 'Algorithm', 'sqp'
options = optimoptions('fmincon','UseParallel',true, 'Algorithm','interior-point', 'Display','iter' ,...
    'ConstraintTolerance', 1e-5,'MaxFunctionEvaluations', 40000, 'MaxIterations', 1000,...
    'OptimalityTolerance', 5e-5, 'StepTolerance', 1e-4);
%%%%%%%%%%%%%%%%%%%
% clock starts
tic 
% clock starts
%%%%%%%%%%%%%%%%%%%
[x , fval] = fmincon(@(params) overlap(params, N, p, state0, cell_gX, cell_JZZ), 0.5*ones(2*p*M,1), [], [], [], [], lb, ub, [],  options);
disp(['Energy of which state? ' num2str(Ex) 'th'] )
disp(eigv)
%disp('Wfn of ground state ')
%disp(state_gnd) % display state to check symmetry
%disp('Wfn of excited state ')
%disp(state0) % display state to check symmetry
disp('First Optimal angles')
disp(reshape(x,[2*p,M]));
disp(['First Fidelity by Overlap: ' num2str(-fval*100) '%']);

%%%%%%%%%%%%%%%%%%%
% clock ends
Duration = seconds(round(toc));
Duration.Format = 'hh:mm:ss';
disp(['Time taken : ' char(Duration)]);
disp(['Time in sec: ' num2str(toc)]);
disp(' ')
% clock ends
%%%%%%%%%%%%%%%%%%%

