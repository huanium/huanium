% computes the QAOA state, given paras

function QAOA_state = QAOA_state(params, N, p, cell_gX, cell_ZZ)
params = reshape(params, [2*p,N]);
QAOA_state = ones(2^N,1)/norm(ones(2^N,1));
param_layer = zeros(2, N); 
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
    end
    QAOA_state = expv(-1i, HgX,  expv(-1i, HZZ, QAOA_state, 5e-4, 10), 5e-4, 10);
end