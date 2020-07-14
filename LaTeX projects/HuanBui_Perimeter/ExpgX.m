% computes expv(gX, Id);
function [stateZZ] = ExpgX( N, gamma ,g, stateZZ)

% note that ExpgX applied AFTER ExpZZ, so its input 
% should be output from ZZ.

%tic
Sx = [0 1 ; 1 0];
Id = [1 0 ; 0 1];
term = sparse(2,2);
for k = 0:N-1
    operators = horzcat( horzcat( repmat({Id},1,k), {gamma(k+1)*g(k+1)*Sx}), repmat({Id}, 1 , N-1-k));
    term = operators{1};
    for o = 2:N 
        term = kron(term, operators{o});
    end
    stateZZ = expv(-1i, sparse(term), stateZZ, 1e-4, 10);
end
%X_gamma = sparse(X_gamma);
%disp(toc)