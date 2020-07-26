% projects the quantum state
% so that every other qubit is in |+> 
% basically, we're fixing the measurement outcome to be {0,0,0,...}
% after that, reduce system size by 1/2 
% ==> pick out only the unmeasured qubits

function reduced_state = measure_plus(state, N)
% note: N is the true system size
%state = (1:2^(2*N-1));
%state = [state flip(state)]';
%disp(state);
Id   = sparse([1 0 ; 0 1]);
Had  = sparse([1 1 ; 1 -1]);
P_0  = sparse([1 1 ; 0 0]);
HP_0 = sparse(Had*P_0);
term = sparse(2,2);
operators = cell(2*N,1);
% measure the even qubits and project them to |+>
for k = 1:2:2*N
    operators = horzcat( horzcat( repmat({Id},1,k), {HP_0}), repmat({Id}, 1 , 2*N-1-k));
    %disp(operators);
    term = operators{1};
    for o = 2:2*N 
        term = sparse(kron(term, operators{o}));
    end
    state = term*state;
end

% find occurences of the first coef
% vec1 = zeros(N/2+1,1);
% for k = 1:N/2+1
%     vec1(k) = 2^(2*(k-1));
% end
% vec1 = flip(vec1);
% for k = 0:2*N-1
%     vec = (num2str(dec2bin(k,N/2+1)) -'0');
%     %disp(vec);
%     %disp(vec*vec1 + 1);
%     disp(state(vec*vec1 + 1));
% end

% find indices of first occurences of all coefs (2^N):
vec2 = zeros(N,1);
for k = 1:N
    vec2(k) = 2^(2*k-1);
end
vec2 = flip(vec2);
%disp(vec2);
%disp(state);
reduced_state = zeros(2^N,1);
for k = 0:2^N-1
    vec = (num2str(dec2bin(k,N)) -'0');
    %disp(state(vec*vec2+1)); 
    reduced_state(k+1)=state(vec*vec2+1);
end
%disp('The reduced state is: ');
%disp(reduced_state);
reduced_state = reduced_state/norm(reduced_state);




