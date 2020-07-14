% This computes the cost function: Energy

function Energy = Energy_expectation(params, g, N ,p)
% params is a 2p x N matrix.
% each pair of rows is a layer
% each column is a particle. 

%global N
%global p
%global g
% the Hamiltonian is obtained 
% from setting beta = gamma = 1.

%Hamiltonian = -diag(ZZ(N, ones(N,1))) - gX(N, ones(N,1), g);

params = reshape(params, [2*p,N]);
Hamiltonian = -ZZ(N, ones(N,1)) - gX(N, ones(N,1), g);

%disp(Hamiltonian)
%disp(eig(Hamiltonian))
%disp(params)
QAOA_state = zeros(2^N,1);
QAOA_state = QAOA(N, p, params, g);
% Energy = real(ctranspose(QAOA_state) * Hamiltonian * QAOA_state);
% Energy = real(dot(QAOA_state, Hamiltonian*QAOA_state));
Energy = real(QAOA_state'*(Hamiltonian*QAOA_state));

