% computes the energy expectation, following paper by Nakanishi et al.

function [Energy_Expectation] = excited_energy_expectation(k, params, k_states, N, p, weight, Hamiltonian, cell_gX, cell_JZZ)

Energy_Expectation = 0;
params = reshape(params, [2*p,N]);
HgX = sparse(2^N,2^N);
HZZ = sparse(2^N,2^N);
for m=1:2:2*p
    % params(k,k+1) gives two rows:
    % first row is beta; second row is gamma  
    for l=1:N
        HgX = HgX + cell_gX{l}*params(m+1,l);
        HZZ = HZZ + cell_JZZ{l}*params(m,l);
    end
    % generate a k states, transformed by the ansatz    
    k_states = cellfun(@(state) expv(-1i, HgX,  expv(-1i, HZZ, state, 5e-5, 10), 5e-5, 10) , k_states, 'UniformOutput', false);
end
% now calculate the weighted energy expectation
% first apply weight to the kth state:
k_states{k} = sqrt(weight)*k_states{k};
% then compute the expectation value
for n=1:k
    Energy_Expectation = Energy_Expectation + real(k_states{n}'*(Hamiltonian*k_states{n}));
end


