%%% Huan Q. Bui

clc
clear
close all

%%%%%%%%%%%%%%%%%%%
% clock starts
tic 
% clock starts
%%%%%%%%%%%%%%%%%%%

N = 1e5; % No. of points.
hbar = 1;
m = 1;
x_start = -5;
x_end = 5;
x = linspace(x_start, x_end, N).'; % Generate column vector with N 
dx = x(2) - x(1); % Coordinate step

% Three-point finite-difference representation of Laplacian
e = ones(N,1); % a column of ones
Lap = spdiags([e -2*e e],[-1 0 1],N,N) / (2*dx^2);
% put -2e on the main diagonal and e-s on upper and lower diagonals

% potential
U = x.^4/4;
% Total Hamiltonian.
H = -(1/2)*(hbar^2/m)*Lap + spdiags(U,0,N,N); % 0 indicates main diagonal 
% put vector U on the main diagonal of NxN sparse matrix

% Find lowest nmodes eigenvectors and eigenvalues of sparse matrix.
nmodes = 2; 
[V,E] = eigs(H,nmodes,'SM'); % find two smallest eigenvalues
[E,ind] = sort(diag(E)); % convert E to vector and sort low to high.
V = V(:,ind); % rearrange corresponding eigenvectors.
syms X
eqn = X.^4/4 == E(1);
X1 = vpasolve(eqn, X, [-10 0]);
X2 = vpasolve(eqn, X, [0 10]);


% Generate plot of lowest energy eigenvectors V(x) and U(x).
figure(1);
subplot(2,1,1)
plot(x, abs(V).^2);
xlabel('x');
ylabel('|\psi|^2');
xlim([x_start x_end]);
% Add legend showing Energy of plotted V(x).
legendLabels = [repmat('E = ',nmodes,1), num2str(E)];
legend(legendLabels)

subplot(2,1,2)
plot(x, (E(1))*ones(N,1),...
    x, (E(2))*ones(N,1), x, U, '--k');
xline(double(X1));
xline(double(X2));
xlabel('x');
ylabel('Energies');
xlim([x_start x_end]);

%%%%%%%%%%%%%%%%%%%
% clock ends
Duration = seconds(round(toc));
Duration.Format = 'hh:mm:ss';
disp(['Time taken : ' char(Duration)]);
disp(['Time in sec: ' num2str(toc)]);
disp(' ');
% clock ends
%%%%%%%%%%%%%%%%%%%


