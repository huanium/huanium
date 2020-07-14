% This gives the QAOA state necessary for the energy expectation calc

function [state] = QAOA(N, p, params, g)

%tic

% params is a 2p x N matrix.
% each pair of rows is a layer
% each column is a particle. 

state = zeros(2^N,1);
state = ones(2^N,1)/norm(ones(2^N,1));
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

    % remember that ZZ only produces the diagonal!
    %state = expv(-1i, gX(N, gamma, g),  expv(-1i, diag(ZZ(N, beta)), state, 5e-4, 10), 5e-4, 10);

    state = expv(-1i, gX(N, gamma, g),  expv(-1i, ZZ(N, beta), state, 5e-4, 10), 5e-4, 10);

    %state = ExpGB(N, params(k:k+1,:), g, state);
end

%disp(toc)