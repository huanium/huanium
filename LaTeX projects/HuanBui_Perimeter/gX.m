% This section produces the X Hamiltonian piece in terms of 
% the parameter vectors gamma

function [X_gamma] = gX( N, gamma ,g)

%tic
Sx = [0 1 ; 1 0];
Id = [1 0 ; 0 1];
X_gamma = sparse(2^N,2^N);
term = sparse(2,2);
for k = 0:N-1
    operators = horzcat( horzcat( repmat({Id},1,k), {gamma(k+1)*g(k+1)*Sx}), repmat({Id}, 1 , N-1-k));
    term = operators{1};
    for o = 2:N 
        term = sparse(kron(term, operators{o}));
    end
    X_gamma = sparse(X_gamma + term);
end
%X_gamma = sparse(X_gamma);
%disp(toc)

