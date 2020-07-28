N    = 4;
p    = round(sqrt(N));
x = zeros(2*p*2*1,1);
fval = 0;
state0 = zeros(2^N,1);
A   = eye(2*p*2*1);
ub  = (pi/2)*ones(2*p*2*1,1);
lb  = zeros(2*p*2*1,1);
eigv = 0;

%% this section computes the Hamiltonian and GS of N-qubit system

% generates Hamiltonian and compute GS of the N-qubit system
% generate the gXX cell array of the Hamiltonian for the N system
Sx = sparse([0 1 ; 1  0]);
Id = sparse([1 0 ; 0  1]);
Sz = sparse([1 0 ; 0 -1]);
term = sparse(2,2);
cell_gX_N = cell(N,1);
operators = cell(N,1);
for k = 0:N-1
    operators = horzcat( horzcat( repmat({Id},1,k), {Sx}), repmat({Id}, 1 , N-1-k));
    term = operators{1};
    for o = 2:N
        term = sparse(kron(term, operators{o}));
    end
    cell_gX_N{k+1} = term;
end
% generate the ZZ cell array of the Hamiltonia for the N system
cell_JZZ_N = cell(N,1);
term = sparse(2,2);
operators = cell(N,1);
for k = 0:N-2
    operators = horzcat( horzcat( repmat({Id},1,k)  ,horzcat({Sz}, {Sz})), repmat({Id}, 1 , N-2-k));
    term = operators{1};
    for o = 2:N 
        term = sparse(kron(term, operators{o}));
    end
    cell_JZZ_N{k+1} = term;
end
operators = horzcat(horzcat( {Sz}, repmat({Id}, 1, N-2) ), {Sz} );
term = operators{1};
for o = 2:N 
    term = sparse(kron(term, operators{o}));
end
cell_JZZ_N{N} = term;
Hamiltonian = sparse(2^N,2^N);
for i = 1:N
    Hamiltonian = Hamiltonian - cell_JZZ_N{i} - cell_gX_N{i};
end
[state0, eigv] = eigs(Hamiltonian, 1, 'SA');

%% This section computes the QAOA for the 2N system
% generate the gXX cell array of the Hamiltonian for the 2N system
term = sparse(2,2);
cell_gX = cell(2*N,1);
operators = cell(2*N,1);
for k = 0:2*N-1
    operators = horzcat( horzcat( repmat({Id},1,k), {Sx}), repmat({Id}, 1 , 2*N-1-k));
    term = operators{1};
    for o = 2:2*N
        term = sparse(kron(term, operators{o}));
    end
    cell_gX{k+1} = term;
end
% generate the ZZ cell array of the Hamiltonia for the 2N system
cell_JZZ = cell(2*N,1);
term = sparse(2,2);
operators = cell(2*N,1);
for k = 0:2*N-2
    operators = horzcat( horzcat( repmat({Id},1,k)  ,horzcat({Sz}, {Sz})), repmat({Id}, 1 , 2*N-2-k));
    term = operators{1};
    for o = 2:2*N 
        term = sparse(kron(term, operators{o}));
    end
    cell_JZZ{k+1} = term;
end
operators = horzcat(horzcat( {Sz}, repmat({Id}, 1, 2*N-2) ), {Sz} );
term = operators{1};
for o = 2:2*N 
    term = sparse(kron(term, operators{o}));
end
cell_JZZ{2*N} = term;


%% This section runs the optimization

if max(size(gcp)) == 0 % parallel pool needed
    parpool('local',2); % create the parallel pool
end

% constrained
% 'Display','iter', 'PlotFcn', 'optimplotfval', 'Algorithm', 'sqp'
options = optimoptions('fmincon','UseParallel',true, 'Algorithm','interior-point', 'Display','final-detailed' ,...
    'ConstraintTolerance', 1e-5,'MaxFunctionEvaluations', 10000, 'MaxIterations', 1000,...
    'OptimalityTolerance', 5e-5, 'StepTolerance', 1e-4, 'PlotFcn', 'optimplotfval');

%%%%%%%%%%%%%%%%%%%
% clock starts
tic 
% clock starts
%%%%%%%%%%%%%%%%%%%

[x , fval] = fmincon(@(params) overlap2(params, N, p, state0, cell_gX, cell_JZZ), ones(2*p*2*1,1), [], [], [], [], lb, ub, [],  options);
disp('Ground state energy')
disp(eigv)
disp('Optimal angles')
disp(reshape(x,[2*p,2*1]));
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

%%
