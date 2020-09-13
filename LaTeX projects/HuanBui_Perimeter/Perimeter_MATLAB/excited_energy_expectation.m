% computes the energy expectation, following paper by Nakanishi et al.

function [Energy_Expectation] = excited_energy_expectation(k, params, N, p, weight, Hamiltonian, cell_gX, cell_JZZ)
params = reshape(params, [2*p,N]);
% generates the orthogonal states with \prod X = 1 symmetry
k_states = cell(1,k);
for j=1:k
    k_states{j} = sparse(2^N,1);
    k_states{j}(1+(j-1),1) = 1/sqrt(2);
    k_states{j}(end-(j-1),1) = 1/sqrt(2);
end


param_layer = zeros(2, N); 
beta  = zeros(N, 1); 
gamma = zeros(N, 1); 
HgX = sparse(2^N,2^N);
HZZ = sparse(2^N,2^N);
for m=1:2:2*p
    % params(k,k+1) gives two rows:
    % first row is beta; second row is gamma
    param_layer = params(m:m+1,:);
    beta  = param_layer(1,:);
    gamma = param_layer(2,:);   
    for l=1:N
        HgX = HgX + cell_gX{l}*gamma(l);
        HZZ = HZZ + cell_JZZ{l}*beta(l);
    end
    % generate a k states, transformed by the ansatz
    for n=1:k
        k_states{n} = expv(-1i, HgX,  expv(-1i, HZZ, k_states{n}, 5e-5, 10), 5e-5, 10);
    end
end

% now calculate the weighted energy expectation
Energy_Expectation = weight*real(k_states{k}'*(Hamiltonian*k_states{k}));
for n=1:k-1
    Energy_Expectation = Energy_Expectation + real(k_states{n}'*(Hamiltonian*k_states{n}));
end

