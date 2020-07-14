% computes the overlap

function [Overlap] = overlap(params,g,N,p,state0)

params = reshape(params, [2*p,N]);
Overlap = 0;
QAOA_state = zeros(2^N,1);
QAOA_state = ones(2^N,1)/norm(ones(2^N,1));
param_layer = zeros(2, N); 
beta  = zeros(N, 1); 
gamma = zeros(N, 1); 

for k=1:2:2*p
    % params(k,k+1) gives two rows:
    % first row is beta
    % second row is gamma
    param_layer = params(k:k+1,:);
    beta  = param_layer(1,:);
    gamma = param_layer(2,:);
    QAOA_state = expv(-1i, sparse(gX(N, gamma, g)),  expv(-1i, sparse(ZZ(N, beta)), QAOA_state, 5e-4, 10), 5e-4, 10);
end

% for k=1:2:2*p
%     % params(k,k+1) gives two rows:
%     % first row is beta
%     % second row is gamma
%     param_layer = params(k:k+1,:);
%     beta  = param_layer(1,:);
%     gamma = param_layer(2,:);
%     QAOA_state = ExpgX( N, gamma, g,  ExpZZ(N, beta, QAOA_state));
% end
Overlap = -(abs(state0'*QAOA_state));
