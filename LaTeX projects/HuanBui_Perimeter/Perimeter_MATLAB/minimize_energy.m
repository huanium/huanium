N    = 16;
p    = N/2;
x = zeros(2*p*N,1);
fval = 0;
g    = 2*rand(N,1);
state0 = zeros(2^N,1);
A   = eye(2*p*N);
ub  = (pi)*ones(2*p*N,1);
lb  = zeros(2*p*N,1);
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
cell_ZZ = cell(N,1);
term = sparse(2,2);
operators = cell(N,1);
for k = 0:N-2
    operators = horzcat( horzcat( repmat({Id},1,k)  ,horzcat({Sz}, {Sz})), repmat({Id}, 1 , N-2-k));
    term = operators{1};
    for o = 2:N 
        term = sparse(kron(term, operators{o}));
    end
    cell_ZZ{k+1} = term;
end
operators = horzcat(horzcat( Sz, repmat({Id}, 1, N-2) ), Sz );
term = operators{1};
for o = 2:N 
    term = sparse(kron(term, operators{o}));
end
cell_ZZ{N} = term;

% generates Hamiltonian
Hamiltonian = sparse(2^N,2^N);
for i = 1:N
    Hamiltonian = Hamiltonian - cell_ZZ{i} - cell_gX{i};
end
[state0, eigv] = eigs(Hamiltonian, 1, 'SA');


%delete(gcp('nocreate'))
%parpool('local', 48)


% constrained
% 'Display','iter', 'PlotFcn', 'optimplotfval', 'Algorithm', 'sqp'
options = optimoptions('fmincon','UseParallel',true, 'Algorithm','interior-point', 'Display','iter' ,...
    'ConstraintTolerance', 1e-3,'MaxFunctionEvaluations', 10000, 'MaxIterations', 1000,...
    'OptimalityTolerance', 5e-4, 'StepTolerance', 1e-4);

%%%%%%%%%%%%%%%%%%%
% clock starts
tic 
% clock starts
%%%%%%%%%%%%%%%%%%%

[x , fval] = fmincon(@(params) overlap(params,g,N,p, state0, cell_gX, cell_ZZ), (pi/2)*rand(2*p*N,1), [], [], [], [], lb, ub, [],  options);
disp('Ground state energy')
disp(eigv)
disp('Optimal angles')
disp(reshape(x,[2*p,N]));
%disp(['Fidelity by Energy: ' num2str(fval*100/GE) '%']);
disp(['Fidelity by Overlap: ' num2str((fval^2)*100) '%']);
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