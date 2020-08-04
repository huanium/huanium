N    = 10;
M = 1;
p    = round(log(N))+1;
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
Ex = 1; % state number
[state0, eigv] = eigs(Hamiltonian, Ex, 'SA');
state0 = state0(:,end); % take last eigenstate
eigv = eigv(end); % take last eigenvalue


%% This section computes the QAOA for the 2N system & generate guess state
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

% generates projection to ALL PLUS
Had  = sparse([1 1 ; 1 -1]);
P_0  = sparse([1 1 ; 0  0]);
P_1  = sparse([0 0 ; 1 -1]);
HP_0 = sparse(Had*P_0);
HP_1 = sparse(Had*P_1);
Random_Proj_Had = cell(2,1);
Random_Proj_Had{1} = HP_0;
Random_Proj_Had{2} = HP_1;
term = sparse(2,2);
operators = cell(2*N,1);
cell_H = cell(N,1);
HP = zeros(2,2);
for k = 1:2:2*N
    % Random_Proj_Had can either be HP_0 or HP_1. 
    % if HP_0 then get |+> all the time
    % if HP_1 then get |-> if |0> and -|-> if |1>
    HP = randsample(Random_Proj_Had,1);
    HP = HP{1};
    operators = horzcat( horzcat( repmat({Id},1,k), {HP}), repmat({Id}, 1 , 2*N-1-k));
    term = operators{1};
    for o = 2:2*N 
        term = sparse(kron(term, operators{o}));
    end
    cell_H{(k-1)/2+1} = term;
end

% generate guess state
params = (pi/2)*rand(2*p*2*M,1);
params = reshape(params, [2*p,2*M]);
Overlap = 0;
QAOA_state = ones(2^(2*N),1)/norm(ones(2^(2*N),1)); % |+> product state
% create GHZ state
%QAOA_state(1)   = 1/sqrt(2);
%QAOA_state(end) = 1/sqrt(2);
param_layer = zeros(2, 2*1); 
beta  = zeros(2*1, 1); 
gamma = zeros(2*1, 1); 
HgX = sparse(2^(2*N),2^(2*N));
HZZ = sparse(2^(2*N),2^(2*N));
for k=1:2:2*p
    % params(k,k+1) gives two rows:
    % first row is beta
    % second row is gamma
    param_layer = params(k:k+1,:);
    beta  = param_layer(1,:);
    gamma = param_layer(2,:);   
    for m=1:2*N
        HgX = HgX + cell_gX{m}*gamma(mod(m,2)+1);
        HZZ = HZZ + cell_JZZ{m}*beta( mod(m,2)+1);
    end
    QAOA_state = expv(-1i, HgX,  expv(-1i, HZZ, QAOA_state, 5e-4, 10), 5e-4, 10);
end

%% This section runs the optimization

%parpool('local', 48);
%if max(size(gcp)) == 0 % parallel pool needed
%    parpool('local',2); % create the parallel pool
%end

% constrained
% 'Display','iter', 'PlotFcn', 'optimplotfval', 'Algorithm', 'sqp'
options = optimoptions('fmincon','UseParallel',true, 'Algorithm','interior-point', 'Display','final-detailed' ,...
    'ConstraintTolerance', 1e-5,'MaxFunctionEvaluations', 20000, 'MaxIterations', 2000,...
    'OptimalityTolerance', 1e-5, 'StepTolerance', 1e-5, 'PlotFcn', 'optimplotfval');

%%%%%%%%%%%%%%%%%%%
% clock starts
tic 
% clock starts
%%%%%%%%%%%%%%%%%%%
CZ_circuit_2N = CZ_circuit(2*N);
[x , fval] = fmincon(@(params) overlap2(params, N, p, state0, QAOA_state, CZ_circuit_2N, cell_gX, cell_JZZ, cell_H), ones(2*p*2*M,1), [], [], [], [], lb, ub, [],  options);
disp(['Energy of state: ' num2str(Ex)] )
disp(eigv);
disp(['System size:      ' num2str(N)]);
disp(['Number of layers: ' num2str(p)]);
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
