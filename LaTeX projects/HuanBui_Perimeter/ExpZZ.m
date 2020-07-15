% This section produces the ZZ Hamiltonian piece in terms of 
% the parameter vectors beta

function [state] = ExpZZ( N, beta, state)
Sz = [1 0 ; 0 -1];
Id = [1 0 ; 0  1];
term = sparse(2,2);
for k = 0:N-2
    operators = horzcat( horzcat( repmat({Id},1,k)  ,horzcat({beta(k+1)*Sz}, {Sz})), repmat({Id}, 1 , N-2-k));
    term = operators{1};
    for o = 2:N 
        term = sparse(kron(term, operators{o}));
    end
    state = expv(-1i, sparse(term), state, 1e-4, 10); 
end
operators = horzcat(horzcat( Sz, repmat({Id}, 1, N-2) ), beta(end)*Sz );
term = operators{1};
for o = 2:N 
    term = sparse(kron(term, operators{o}));
end
state = expv(-1i, sparse(term), state, 1e-4, 10); 

