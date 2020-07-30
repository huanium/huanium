% computes the overlap

function [Overlap] = overlap(params, N, p, state0, cell_gX, cell_ZZ)

M=N;
%M = 1;
params = reshape(params, [2*p,M]);
Overlap = 0;
QAOA_state = zeros(2^N,1);
QAOA_state = ones(2^N,1)/norm(ones(2^N,1)); % |+> product state
% create GHZ state
%QAOA_state(1)   = 1/sqrt(2);
%QAOA_state(end) = 1/sqrt(2);
% superposition of GHZ and |+>
%QAOA_state = (1/sqrt(2))*(QAOA_state + ones(2^N,1)/norm(ones(2^N,1))); 
param_layer = zeros(2, M); 
beta  = zeros(N, 1); 
gamma = zeros(N, 1); 
HgX = sparse(2^N,2^N);
HZZ = sparse(2^N,2^N);
for k=1:2:2*p
    % params(k,k+1) gives two rows:
    % first row is beta
    % second row is gamma
    param_layer = params(k:k+1,:);
    beta  = param_layer(1,:);
    gamma = param_layer(2,:);   
    for l=1:N
        HgX = HgX + cell_gX{l}*gamma(l);
        HZZ = HZZ + cell_ZZ{l}*beta(l);
        
        %HgX = HgX + cell_gX{l}*gamma(1);
        %HZZ = HZZ + cell_ZZ{l}*beta(1);
        
    end
    QAOA_state = expv(-1i, HgX,  expv(-1i, HZZ, QAOA_state, 5e-5, 10), 5e-5, 10);
end
Overlap = -(abs(state0'*QAOA_state))^2;
