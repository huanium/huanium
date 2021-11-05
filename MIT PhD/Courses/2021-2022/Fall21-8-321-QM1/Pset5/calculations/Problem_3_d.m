%%% Huan Q. Bui

clc
clear
close all

%%%%%%%%%%%%%%%%%%%
% clock starts
tic 
% clock starts
%%%%%%%%%%%%%%%%%%%

hbar = 1;
m = 1;

N = 10^2;
L = 4;

x = linspace(-L,L,N);
y = linspace(-L,L,N);

dx= x(2) - x(1);
dy= y(2) - y(1);

%%% generate the 2D Laplacian operator quickly %%%
%%% source:
%%% https://www.mathworks.com/matlabcentral/fileexchange/69885-q_schrodinger2d_demo 

Axy = ones(1,(N-1)*N);
DX2 = (-2)*diag(ones(1,N*N)) + (1)*diag(Axy,-N) + (1)*diag(Axy,N);

AA = ones(1,N*N);
BB = ones(1,N*N-1);
BB(N:N:end) = 0;
DY2 =(-2)*diag(AA) + (1)*diag(BB,-1) + (1)*diag(BB,1);

Lap = sparse(DX2/dx^2 + DY2/dy^2);


% setting up potential
[X,Y] = meshgrid(x,y);
% harmonic potential 
% U = X.^2/2 + Y.^2/2;
% strange potential
%U = X.^2/2 + Y.^2/2 - sqrt(2)*abs(X-Y);
% another strange potential
U = X.^4/4 + Y.^6/6 + 2.*X.*Y;

% Total Hamiltonian.
H = sparse(-(1/2)*(hbar^2/m)*Lap + diag(U(:))) ; 



% Find lowest nmodes eigenvectors and eigenvalues of sparse matrix.
nmodes = 4; 
[Psi,E] = eigs(H,nmodes,'SM'); % find two smallest eigenvalues
[E,ind] = sort(diag(E)); % convert E to vector and sort low to high.
Psi = Psi(:,ind); % rearrange corresponding eigenvectors.

% display all energies
disp('Lowest energies requested: ')
disp(E)


%%%%%%%%%%%%%%%%%%%%%%% Normalization %%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:nmodes
    psi_temp = reshape(Psi(:,i),N,N);
    psi_result(:,:,i) = psi_temp / sqrt( trapz(y',trapz(x,abs(psi_temp).^2 ,2) , 1 ));  
end

% plot |psi|^2 for ground state only
figure(1)
surf(X,Y,abs(psi_result(:,:,1)).^2, 'LineWidth',0.1,'edgecolor','black', 'EdgeAlpha', 0.0 , 'FaceAlpha',1)
title('|\psi|^2(x,y)')
xlabel('x')
ylabel('y')

% plot \psi for ground state only
figure(2)
surf(X,Y,psi_result(:,:,1), 'LineWidth',0.1,'edgecolor','black', 'EdgeAlpha', 0.0 , 'FaceAlpha',1)
view([0 0 90])
colorbar;
title('\psi(x,y)')
xlabel('x')
ylabel('y')

%%%%%%%%%%%%%%%%%%%
% clock ends
Duration = seconds(round(toc));
Duration.Format = 'hh:mm:ss';
disp(['Time taken : ' char(Duration)]);
disp(['Time in sec: ' num2str(toc)]);
disp(' ');
% clock ends
%%%%%%%%%%%%%%%%%%%


