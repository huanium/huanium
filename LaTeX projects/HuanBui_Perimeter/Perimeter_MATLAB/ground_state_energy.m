% Get Hamiltonian

function ground_state_energy = ground_state_energy(N,g)
% remember, ZZ() is just the diagonal!
%Hamiltonian = -diag(ZZ(N, ones(N,1))) - gX(N, ones(N,1), g);

Hamiltonian = -ZZ(N, ones(N,1)) - gX(N, ones(N,1), g);
% disp(Hamiltonian);
ground_state_energy = 0;
ground_state_energy = eigs(Hamiltonian, 1, 'SA');


