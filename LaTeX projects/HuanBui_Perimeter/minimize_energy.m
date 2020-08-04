N    = 8;
p    = round(log(N));
%p = N/2;
%p = round(log2(N));
M=N;
%M=1;
x = zeros(2*p*M,1);
fval = 0;
%g    = 2*rand(N,1);
g    = ones(N,1);
%J    = 2*rand(N,1);
J    = ones(N,1);
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
Ex = 1; % state number
[state0, eigv] = eigs(Hamiltonian, Ex, 'SA');
state0 = state0(:,end); % take last eigenstate
eigv = eigv(end); % take last eigenvalue



% generate the ZZ cell array of the Hamiltonia for the 2N system
cell_JZZ_2N = cell(2*N,1);
term = sparse(2,2);
operators = cell(2*N,1);
for k = 0:2*N-2
    operators = horzcat( horzcat( repmat({Id},1,k)  ,horzcat({Sz}, {Sz})), repmat({Id}, 1 , 2*N-2-k));
    term = operators{1};
    for o = 2:2*N 
        term = sparse(kron(term, operators{o}));
    end
    cell_JZZ_2N{k+1} = term;
end
operators = horzcat(horzcat( {Sz}, repmat({Id}, 1, 2*N-2) ), {Sz} );
term = operators{1};
for o = 2:2*N 
    term = sparse(kron(term, operators{o}));
end
cell_JZZ_2N{2*N} = term;
% generate the gXX cell array of the Hamiltonian for the 2N system
term = sparse(2,2);
cell_gX_2N = cell(2*N,1);
operators = cell(2*N,1);
for k = 0:2*N-1
    operators = horzcat( horzcat( repmat({Id},1,k), {Sx}), repmat({Id}, 1 , 2*N-1-k));
    term = operators{1};
    for o = 2:2*N
        term = sparse(kron(term, operators{o}));
    end
    cell_gX_2N{k+1} = term;
end

% % generate guess state
% params = (pi/2)*rand(2*p*2*M,1);
% params = reshape(params, [2*p,2*M]);
% Overlap = 0;
QAOA_state = ones(2^(2*N),1)/norm(ones(2^(2*N),1)); % |+> product state
% % create GHZ state
% %QAOA_state(1)   = 1/sqrt(2);
% %QAOA_state(end) = 1/sqrt(2);
% param_layer = zeros(2, 2*1); 
% beta  = zeros(2*1, 1); 
% gamma = zeros(2*1, 1); 
% HgX = sparse(2^(2*N),2^(2*N));
% HZZ = sparse(2^(2*N),2^(2*N));
% for k=1:2:2*p
%     % params(k,k+1) gives two rows:
%     % first row is beta
%     % second row is gamma
%     param_layer = params(k:k+1,:);
%     beta  = param_layer(1,:);
%     gamma = param_layer(2,:);   
%     for m=1:2*N
%         HgX = HgX + cell_gX_2N{m}*gamma(mod(m,2)+1);
%         HZZ = HZZ + cell_JZZ_2N{m}*beta( mod(m,2)+1);
%     end
%     QAOA_state = expv(-1i, HgX,  expv(-1i, HZZ, QAOA_state, 5e-4, 10), 5e-4, 10);
% end
% QAOA_state = measure_plus(CZ_circuit(2*N)*QAOA_state, N);

if max(size(gcp)) == 0 % parallel pool needed
    parpool % create the parallel pool
end

% constrained
% 'Display','iter', 'PlotFcn', 'optimplotfval', 'Algorithm', 'sqp'
options = optimoptions('fmincon','UseParallel',true, 'Algorithm','interior-point', 'Display','final-detailed' ,...
    'ConstraintTolerance', 1e-5,'MaxFunctionEvaluations', 20000, 'MaxIterations', 1000,...
    'OptimalityTolerance', 5e-5, 'StepTolerance', 1e-4, 'PlotFcn', 'optimplotfval');
%%%%%%%%%%%%%%%%%%%
% clock starts
tic 
% clock starts
%%%%%%%%%%%%%%%%%%%
[x , fval] = fmincon(@(params) overlap(params, N, p, state0, QAOA_state, cell_gX, cell_JZZ), 0.5*ones(2*p*M,1), [], [], [], [], lb, ub, [],  options);
disp(['Energy of state: ' num2str(Ex)] )
disp(eigv);
disp(['System size:      ' num2str(N)]);
disp(['Number of layers: ' num2str(p)]);
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

%save('x_N_4.mat', 'x');

