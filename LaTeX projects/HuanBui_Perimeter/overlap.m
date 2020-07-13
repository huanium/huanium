% computes the overlap

function [Overlap] = overlap(params)

global N
global p
global g
global state0

Overlap = 0;
QAOA_state = zeros(2^N,1);
QAOA_state = QAOA(N, p, params, g);

Overlap = -(abs(state0'*QAOA_state));
