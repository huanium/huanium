function [ExpGB] = ExpGB(N, param_layer, g, state)

% params(k,k+1) gives two rows:
% first row is beta
% second row is gamma
beta  = param_layer(1,:);
gamma = param_layer(2,:);

%disp(beta)
%disp(gamma)
%disp(expv(-1i, ZZ(N, beta), state, 1e-7, 20))

ExpGB = expv(-1i, gX(N, gamma, g),  expv(-1i, ZZ(N, beta), state, 1e-7, 20), 1e-7, 20);