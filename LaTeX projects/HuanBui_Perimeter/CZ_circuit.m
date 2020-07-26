% computes the full-circuit CZ

function cz_full = CZ_circuit(N)

CZ = sparse([1 0 0 0; 0 1 0 0 ; 0 0 1 0 ; 0 0 0 -1]);
Id = [1 0 ; 0 1];
cz_full = speye(2^N, 2^N);
term = sparse(2,2);
operators = cell(N,1);
for k = 0:N-2
    operators = horzcat( horzcat( repmat({Id},1,k)  , {CZ}) , repmat({Id}, 1 , N-2-k));
    term = operators{1};
    if N > 2
        for o = 2:N-1 
        term = sparse(kron(term, operators{o}));
        end
    end
    cz_full = cz_full*term;
end
%disp(cz_full);
for k = 1:(2^N+1):2^(2*N)
    %disp(['Position ' num2str(k)]); % position of diag entries
    %disp(['Entry: ' num2str(cz_not_full(k))]);
    if (k-1)/(2^N+1) > 2^(N-1) && mod((k-1)/(2^N+1) ,2)==1
        %disp((k-1)/(2^N+1) + 1);
        cz_full(k) = (-1)*cz_full(k);
    end
end

