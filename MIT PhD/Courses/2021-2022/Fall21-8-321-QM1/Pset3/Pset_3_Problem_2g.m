clear crc
clear all

N = 4;
res = 400;
x = 0:1/res:1-1/res;
figure(1)
for j=0:1:res-1
   eigv = Bfield(N,j/res); 
   hold on
   X = (j/res)*ones(2^N,1);
   plot(X,eigv,'Marker','o', 'MarkerSize', 2, 'Color', 'r', 'LineStyle', 'None')
   hold off
end
hold off
grid on

xlabel('x')
ylabel('Eigenvalues')
title(['Spectrum of H for N=' num2str(N)])




function eigv = Bfield(N,x)
Sz = [1 0 ; 0 -1];
Sx = [0 1 ; 1 0];
Sy = [0 -complex(0,1); complex(0,1) 0];
Id = [1 0 ; 0 1];

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

for n = 0:N-2
    operatorsZ = horzcat( horzcat( repmat({Id},1,n)  ,horzcat({Sz}, {Sz})), repmat({Id}, 1 , N-2-n));
    operatorsY = horzcat( horzcat( repmat({Id},1,n)  ,horzcat({Sy}, {Sy})), repmat({Id}, 1 , N-2-n));
    operatorsX = horzcat( horzcat( repmat({Id},1,n)  ,horzcat({Sx}, {Sx})), repmat({Id}, 1 , N-2-n));
    termZ = operatorsZ{1};
    termY = operatorsY{1};
    termX = operatorsX{1};
    for o = 2:N 
        termZ = kron(termZ, operatorsZ{o});
        termY = kron(termY, operatorsY{o});
        termX = kron(termX, operatorsX{o});
    end
    cell_ZZ{n+1} = termZ;
    cell_YY{n+1} = termY;
    cell_XX{n+1} = termX;
end


% deals with the periodic term
operatorsZ = horzcat(horzcat( {Sz}, repmat({Id}, 1, N-2) ), {Sz} );
operatorsY = horzcat(horzcat( {Sy}, repmat({Id}, 1, N-2) ), {Sy} );
operatorsX = horzcat(horzcat( {Sx}, repmat({Id}, 1, N-2) ), {Sx} );
termZ = operatorsZ{1};
termY = operatorsY{1};
termX = operatorsX{1};
for o = 2:N 
    termZ = kron(termZ, operatorsZ{o});
    termY = kron(termY, operatorsY{o});
    termX = kron(termX, operatorsX{o});
end
cell_ZZ{N} = termZ;
cell_YY{N} = termY;
cell_XX{N} = termX;


% generates Sz
% generate the fZ cell array of the Hamiltonian:
term = sparse(2,2);
cell_fZ = cell(N,1);
operators = cell(N,1);
for n = 0:N-1
    operators = horzcat( horzcat( repmat({Id},1,n), {Sz}), repmat({Id}, 1 , N-1-n));
    term = operators{1};
    for o = 2:N 
        term = sparse(kron(term, operators{o}));
    end
    cell_fZ{n+1} = term;
end

% generates Hamiltonian
Hamiltonian = zeros(2^N,2^N);
for i = 1:N
    Hamiltonian = Hamiltonian + 2*x*cell_fZ{i} - (1-x)*(cell_ZZ{i} + cell_XX{i} + cell_YY{i});
end

eigv = eig(Hamiltonian);

end


