% computes the overlap

function [Overlap2] = overlap2(params, N, p, state0, new_QAOA_state, CZ_circuit_2N, cell_gX, cell_ZZ, proj_H, vec2)
% remember that N is the true system size
% all of the QAOA state prep must be done with the 2N system
% here p is already given as a function of 2*N, no worries
reduced_QAOA_state = zeros(2^N,1);
params = reshape(params, [2*p,2*1]);
Overlap2 = 0;
param_layer = zeros(2, 2*1); 
beta  = zeros(2*1, 1); 
gamma = zeros(2*1, 1); 
HgX = sparse(2^(2*N),2^(2*N));
HZZ = sparse(2^(2*N),2^(2*N));
for k=1:2:2*p
    param_layer = params(k:k+1,:);
    beta  = param_layer(1,:);
    gamma = param_layer(2,:);   
    for m=1:2*N
        HgX = HgX + cell_gX{m}*gamma(mod(m,2)+1);
        HZZ = HZZ + cell_ZZ{m}*beta( mod(m,2)+1);
    end
    new_QAOA_state = expv(-1i, HgX,  expv(-1i, HZZ, new_QAOA_state, 5e-5, 10), 5e-5, 10);
end

% Now measure & reduce. This avoids calling the measure function
new_QAOA_state = proj_H*CZ_circuit_2N*new_QAOA_state;
%%% SYSTEM REDUCTION %%%
reduced_QAOA_state = new_QAOA_state((num2str(dec2bin(0:2^N-1,N))-'0')*vec2 + 1);
% computes the overlap
Overlap2 = -(abs(state0'*reduced_QAOA_state/norm(reduced_QAOA_state)))^2;

