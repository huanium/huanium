% computes the state & energy, given the angles

function [QAOA_state, energy] = compute_state(k, params, N, p, Hamiltonian, cell_gX, cell_JZZ)

% the state of interest is always this one:
QAOA_state = sparse(2^N,1);
QAOA_state(1+(k-1),1) = 1/sqrt(2);
QAOA_state(end-(k-1),1) = 1/sqrt(2);

% compute the transformed state
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
    QAOA_state = expv(-1i, HgX,  expv(-1i, HZZ, QAOA_state, 5e-5, 10), 5e-5, 10);
end

energy = real(QAOA_state'*(Hamiltonian*QAOA_state));
