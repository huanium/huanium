%%% AUTHOR: Huan Q. Bui %%%
%%% MIT %%%%%
%%% March 29, 2022 %%%%%%%%


clear all
close all

J = 4;
strength = 0:0.05:10;
size = (J+1)^2;
H = zeros(size,size);

% creat a basis for the Hamiltonian
basis = [];

for j = 0:1:J
    for mj = -j:1:j
        basis = [basis; [j mj]];
   end
end

disp(basis)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% first plot energies as a fn of dE/B

stark = figure(1);
for a = strength % loop over field strengths
    % create the Hamiltonian, element-by-element
    for r = 1:size
        j = basis(r,1);
        mj = basis(r,2);
        for c = 1:size     
            jj = basis(c,1);  
            mjj = basis(c,2);
            
            H(r,c) = j*(j+1)*(j==jj)*(mj==mjj)...
                -a*(-1)^(-mjj)*sqrt((2*j+1)*(2*1+1)*(2*jj+1)/3)...
                *Wigner3j([j,1,jj],[0,0,0])*Wigner3j([j,1,jj],[mj,0,-mjj]);             
        end
    end
    % diag n plot eigenvalues associated with field strength a = dE/B
    energies = eig(H);
    hold on 
    plot(a*ones(size), energies, '.', 'Color', 'red', 'MarkerSize',4);
end

% disp(H)

% plot includes up to 6 lowest energies only

hold off
%title('Energy vs dE/B')
ylim([-6.5 10])
xlabel('dE/B')
ylabel('Energy/B')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% now find the lowest state and associated energy for various a = dE/B
% then take result over to mathematica to plot wavefunction^2

strength = [0 1 10];
wavefunction = 0;

for a = strength % loop over field strengths
    % create the Hamiltonian, element-by-element
    for r = 1:size
        j = basis(r,1);
        mj = basis(r,2);
        for c = 1:size     
            jj = basis(c,1);  
            mjj = basis(c,2);
            
            H(r,c) = j*(j+1)*(j==jj)*(mj==mjj)...
                -a*(-1)^(-mjj)*sqrt((2*j+1)*(2*1+1)*(2*jj+1)/3)...
                *Wigner3j([j,1,jj],[0,0,0])*Wigner3j([j,1,jj],[mj,0,-mjj]);             
        end
    end
    % diag n plot eigenvalues associated with field strength a = dE/B
    [state,energy] = eigs(H,1,'SA');
    disp('Ground state energy:')
    disp(energy)
    disp('Ground state:')
    disp(state) 
    
end




