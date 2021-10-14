clear 
%%%%%%%%%%%%%%%%%%%
% clock starts
tic 
% clock starts
%%%%%%%%%%%%%%%%%%%

N = 22;
parfor j=1:N-1
    data(j) = MinEig(j+1);
end
plot(2:1:N, data, 'LineWidth',2)
ylabel('Eigenvalues (units = $\hbar^2/4$)', 'Interpreter','latex', 'FontSize', 16)
xlabel('N')
grid on

% linear fit
p = polyfit(2:1:N, data, 1);
fit = polyval(p,2:1:N);
hold on
plot(2:1:N,fit, 'LineWidth', 1)
hold off

% display fit eqn in legend
a = p(1);
b = p(2);
legend('calculated', ['fit: minEig = ' num2str(a) 'N + ' num2str(b)])



%%%%%%%%%%%%%%%%%%%
% clock ends
Duration = seconds(round(toc));
Duration.Format = 'hh:mm:ss';
disp(['Time taken : ' char(Duration)]);
% disp(['Time in sec: ' num2str(toc)]);
disp(' ')
% clock ends
%%%%%%%%%%%%%%%%%%%

% returns the smallest eigenvalue
function minEig = MinEig(N)

Sz = sparse([1 0 ; 0 -1]);
Sx = sparse([0 1 ; 1 0]);
Sy = sparse([0 -complex(0,1); complex(0,1) 0]);
Id = sparse([1 0 ; 0 1]);

% ZZ, YY, XX
cell_ZZ = cell(N,1);
cell_YY = cell(N,1);
cell_XX = cell(N,1);
termZ = zeros(2,2);
termY = zeros(2,2);
termX = zeros(2,2);
operatorsZ = cell(N,1);
operatorsY = cell(N,1);
operatorsX = cell(N,1);

parfor n = 0:N-2
    operatorsZ = horzcat( horzcat( repmat({Id},1,n)  ,horzcat({Sz}, {Sz})), repmat({Id}, 1 , N-2-n));
    operatorsY = horzcat( horzcat( repmat({Id},1,n)  ,horzcat({Sy}, {Sy})), repmat({Id}, 1 , N-2-n));
    operatorsX = horzcat( horzcat( repmat({Id},1,n)  ,horzcat({Sx}, {Sx})), repmat({Id}, 1 , N-2-n));
    termZ = operatorsZ{1};
    termY = operatorsY{1};
    termX = operatorsX{1};
    for o = 2:N
        termZ = sparse(kron(termZ, operatorsZ{o}));
        termY = sparse(kron(termY, operatorsY{o}));
        termX = sparse(kron(termX, operatorsX{o}));
    end
    cell_ZZ{n+1} = termZ;
    cell_YY{n+1} = termY;
    cell_XX{n+1} = termX;
end

% periodic term
operatorsZ = horzcat(horzcat( {Sz}, repmat({Id}, 1, N-2) ), {Sz} );
operatorsY = horzcat(horzcat( {Sy}, repmat({Id}, 1, N-2) ), {Sy} );
operatorsX = horzcat(horzcat( {Sx}, repmat({Id}, 1, N-2) ), {Sx} );
termZ = operatorsZ{1};
termY = operatorsY{1};
termX = operatorsX{1};
for o = 2:N
    termZ = sparse(kron(termZ, operatorsZ{o}));
    termY = sparse(kron(termY, operatorsY{o}));
    termX = sparse(kron(termX, operatorsX{o}));
end
cell_ZZ{N} = termZ;
cell_YY{N} = termY;
cell_XX{N} = termX;

% generates Hamiltonian
Hamiltonian = sparse(2^N,2^N);
parfor i = 1:N
    Hamiltonian = Hamiltonian + cell_ZZ{i} + cell_XX{i} + cell_YY{i};
end
% exact diagonalization
eigv = eigs(Hamiltonian,1,'smallestreal');

% returns smallest eigenvalue
minEig = eigv;

end