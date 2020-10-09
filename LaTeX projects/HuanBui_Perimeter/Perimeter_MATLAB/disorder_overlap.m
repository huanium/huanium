% computes the energy expectation, following paper by Nakanishi et al.

function [overlap] = disorder_overlap(params, N, p, state0, cell_gX, cell_JZZ, cell_fZ)

overlap = 0;
params = reshape(params, [3*p,N]); % three sublayers per layer: g,j,f
QAOA_state = zeros(2^N,1);
%QAOA_state = ones(2^N,1)/norm(ones(2^N,1)); % |+> product state 
QAOA_state(1) = 1; % ground state for \sum Z
HgX = sparse(2^N,2^N);
HZZ = sparse(2^N,2^N);
HfZ = sparse(2^N,2^N);

for m=1:3:3*p
    % params(k,k+1) gives 3 rows:
    for l=1:N
        HfZ = HfZ + cell_fZ{l}*params(m+2,l);
        HgX = HgX + cell_gX{l}*params(m+1,l);
        HZZ = HZZ + cell_JZZ{l}*params(m,l);
    end
    % the order is HfZ, HZZ, HgX,
    % because the first operator to act should not be ZZ
    QAOA_state = expv(-1i, HfZ,  expv(-1i, HZZ, expv(-1i, HgX , QAOA_state, 1e-8, 10), 1e-8, 10), 1e-8, 10);
end
% now compute the overlap
overlap = -(abs(state0'*QAOA_state))^2;





