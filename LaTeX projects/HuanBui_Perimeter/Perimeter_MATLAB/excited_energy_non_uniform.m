N    = 4;
k = 2;  % number of states to be generated k \leq 2^n
weight = 0.5;
p = round(N)+1;
M=N;
x = zeros(2*p*M,1);
fval = 0;
rng('default');
g    = rand(N,1);
rng('default');
J    = rand(N,1);
state0 = zeros(2^N,1);
ub  = (pi/2)*ones(2*p*M,1);
lb  = zeros(2*p*M,1);
eigv = 0;

% generate the gXX cell array of the Hamiltonian:
Sx = [0 1 ; 1 0];
Id = [1 0 ; 0 1];
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

%[state0, eigv] = eigs(Hamiltonian, k, 'SA');
[state0, eigv] = eigs(Hamiltonian, 2^N, 'SA');

% generates the orthogonal states with \prod X = 1 symmetry
k_states = cell(1,k);
% trial states being states close to GHZ
for j=1:k
    k_states{j} = sparse(2^N,1);
    k_states{j}(1  +(j-1),1) = 1/sqrt(2);
    k_states{j}(end-(j-1),1) = 1/sqrt(2);
end



%if max(size(gcp)) == 0 % parallel pool needed
%    parpool % create the parallel pool
%end

% constrained
% 'Display','iter', 'PlotFcn', 'optimplotfval', 'Algorithm', 'sqp'
options = optimoptions('fmincon','UseParallel',true, 'Algorithm','interior-point', 'Display','iter' ,...
    'ConstraintTolerance', 1e-5,'MaxFunctionEvaluations', 1e5, 'MaxIterations', 1000,...
    'OptimalityTolerance', 5e-5, 'StepTolerance', 1e-4);
%%%%%%%%%%%%%%%%%%%
% clock starts
tic 
% clock starts
%%%%%%%%%%%%%%%%%%%


[angles , fval] = fmincon(@(params) excited_energy_expectation(k, params, k_states, N, p, weight, Hamiltonian, cell_gX, cell_JZZ),...
    0.5*ones(2*p*M,1), [], [], [], [], lb, ub, [],  options);

% compute the kth state and energy by passing the angles x through
[kth_state, kth_energy] = compute_state(k, angles, N, p, Hamiltonian, cell_gX, cell_JZZ);

% calculate symmetry quantum number
symmetry = zeros(1,2^N);
for n = 1:2^N
   if norm(state0(:,n)- flip(state0(:,n))) <= 1e-10 % they're the same under X
       symmetry(1,n)= 1;
   else % else the norm will be 2... so, not invariant under X
       symmetry(1,n) = -1;
   end
end

% print out 
%disp('Optimal angles');
%disp(reshape(angles,[2*p,M]));
disp('Lowest k energies:')
E  = diag(eigv);
disp(E(1:2*k+1)');
% disp(state0);
disp('How many states? k =');
disp(k);
disp('Symmetry of states up to k');
disp(symmetry(1:2*k+1));
disp('Weight used:')
disp(weight);
disp('kth energy:')
disp(kth_energy)

%%%%%%%%%%%%%%%%%%%
% clock ends
Duration = seconds(round(toc));
Duration.Format = 'hh:mm:ss';
disp(['Time taken : ' char(Duration)]);
% disp(['Time in sec: ' num2str(toc)]);
disp(' ')
% clock ends
%%%%%%%%%%%%%%%%%%%

