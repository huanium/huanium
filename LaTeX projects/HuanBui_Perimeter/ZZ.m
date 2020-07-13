% This section produces the ZZ Hamiltonian piece in terms of 
% the parameter vectors beta

function [ZZ_beta] = ZZ( N, beta )
Sz = [1 0 ; 0 -1];
Id = [1 0 ; 0  1];
ZZ_beta = zeros(2^N);
for k = 0:N-2
    operators = horzcat( horzcat( repmat({Id},1,k)  ,horzcat({beta(k+1)*Sz}, {Sz})), repmat({Id}, 1 , N-2-k));
    term = operators{1};
    for o = 2:N 
        term = kron(term, operators{o});
    end
    ZZ_beta = ZZ_beta + term;
end
operators = horzcat(horzcat( Sz, repmat({Id}, 1, N-2) ), beta(end)*Sz );
term = operators{1};
for o = 2:N 
    term = kron(term, operators{o});
end
ZZ_beta = ZZ_beta + term;



% function [ZZ_diag] = ZZ(N ,beta)
% % returns only the diagonal!
% ZZ_diag = zeros(2^N, 1);
% b = zeros(N,1);
% for col=0:2^N-1
%     b =  dec2bin( col,N );
%     val = 0;
%     for k = 1:N-1
%         val = val + (-1)^( str2double(b(k)) + str2double(b(k+1)))*beta(k);
%     end
%     val = val + (-1)^( str2double(b(1)) + str2double(b(end)))*beta(end);
%     ZZ_diag(col+1) = val;
% end

