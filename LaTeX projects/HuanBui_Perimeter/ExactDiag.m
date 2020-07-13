% mainExactDiag
% ------------------------
% Script file for initializing exact diagonalization using the 'eigs'
% routine for a 1D quantum system
%
% by Glen Evenbly (c) for www.tensors.net, (v1.1) - last modified 21/1/2019

%%%%% Example 1: XX model %%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%% Simulation parameters
Nsites = 4; % number of lattice sites
usePBC = 1; % use periodic or open boundaries
numval = 1; % number of eigenstates to compute

%%%%% Set the options for eigs
OPTS.disp = 0;
OPTS.issym = 1;
OPTS.isreal = 1;
OPTS.maxit = 300;

%%%%% Define Hamiltonian (quantum Ising model)
d = 2; % local dimension
sX = [0,1;1,0]; sY = [0,-1i;1i,0]; sZ = [1,0;0,-1]; sI = eye(2);
%hloc = reshape(real(kron(sX,sX) + kron(sY,sY)),[2,2,2,2]); % XX model
hloc = reshape(real(-kron(sX,sX) + 1*kron(sZ,sI) + 1*kron(sI,sZ)),[2,2,2,2]); % Ising


%%%%% Do exact diag
tic; [psi,Energy] = eigs(@doApplyHam,d^Nsites,numval,'SA',OPTS,hloc,Nsites,usePBC);
diagTime = toc;

%%%%% Check with exact energy
% EnExact = -4/sin(pi/Nsites); % for PBC (XX model)
EnExact = -2/sin(pi/(2*Nsites)); % for PBC (Crit Ising)
EnErr = abs(Energy-EnExact);
IsingModelGS = table(Nsites,diagTime,Energy,EnErr)


