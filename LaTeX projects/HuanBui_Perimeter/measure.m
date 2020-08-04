% implements projective measurement and system reduction

function reduced_state = measure(N)

state = rand(2^(2*(N))/2,1);
state = [state ; flip(state)];
state = CZ_circuit(2*N)*state;
Id   = sparse([1 0 ; 0  1]);
Had  = sparse([1 1 ; 1 -1]);
P_0  = sparse([1 1 ; 0  0]);
P_1  = sparse([0 0 ; 1 -1]);
HP_0 = sparse(Had*P_0);
HP_1 = sparse(Had*P_1);
Random_Proj_Had = cell(2,1);
Random_Proj_Had{1} = HP_0;
Random_Proj_Had{2} = HP_1;
term = sparse(2,2);
operators = cell(2*N,1);
cell_H = cell(N,1);
HP = zeros(2,2);
reduced_state = zeros(2^N,1);

for k = 1:2:2*N
    HP = randsample(Random_Proj_Had,1);
    operators = horzcat( horzcat( repmat({Id},1,k), {HP{1}}), repmat({Id}, 1 , 2*N-1-k));
    term = operators{1};
    for o = 2:2*N
        term = sparse(kron(term, operators{o}));
    end
    cell_H{(k-1)/2+1} = term;
end

for k = 1:N
    state = cell_H{k}*state;
end

vec2 = zeros(N,1);
for k = 1:N
    vec2(k) = 2^(2*k-1);
end
vec2 = flip(vec2);
for k = 0:2^N-1
    vec = (num2str(dec2bin(k,N)) -'0');
    reduced_state(k+1)=state(vec*vec2+1);
end
    




