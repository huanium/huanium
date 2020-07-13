function psiOut = doApplyHam(psiIn,hloc,N,usePBC)
% function psiOut = doApplyHam(psiIn,hloc,N,usePBC)
% ------------------------
% by Glen Evenbly (c) for www.tensors.net, (v1.1) - last modified 21/1/2019
% 
% Applies local Hamiltonian (given as sum of nearest neighbor terms 'hloc')
% to input state 'psiIn'. Number of lattice sites specified as 'N' while
% 'usePBC' determines whether open or periodic boundaries are used. 

d = size(hloc,1);
psiOut = zeros(length(psiIn(:)),1);

for k = 1:N-1
    % apply local Hamiltonian terms 
    psiOut = psiOut + reshape(permute(reshape(reshape(hloc,[d^2,d^2])*...
        reshape(permute(reshape(psiIn,[d^(k-1),d^2,d^(N-k-1)]),[2,1,3]),...
        [d^2,d^(N-2)]),[d^2,d^(k-1),d^(N-k-1)]),[2,1,3]),[d^N,1]);
end

if usePBC
    % apply periodic term
    psiOut = psiOut + reshape(permute(reshape(reshape(hloc,[d^2,d^2])*...
        reshape(permute(reshape(psiIn,[d,d^(N-2),d]),[3,1,2]),...
        [d^2,d^(N-2)]),[d,d,d^(N-2)]),[2,3,1]),[d^N,1]);
end