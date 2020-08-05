% projects the quantum state
% so that every other qubit is in |+> 
% basically, we're fixing the measurement outcome to be {0,0,0,...}
% after that, reduce system size by 1/2 
% ==> pick out only the unmeasured qubits

function reduced_state = measure_plus(state, N, cell_H)
% note: N is the true system size
% find indices of first occurences of all coefs (2^N):

for k = 1:N
   state = cell_H{k}*state;
end

vec2 = zeros(N,1);
for k = 1:N
    vec2(k) = 2^(2*k-1);
end
vec2 = flip(vec2);
reduced_state = zeros(2^N,1);
for k = 0:2^N-1
    vec = (num2str(dec2bin(k,N)) -'0');
    reduced_state(k+1)=state(vec*vec2+1);
end
reduced_state = reduced_state/norm(reduced_state);