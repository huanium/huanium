%%% Huan Q. Bui
%%% double well tunneling
%%% solve 1D time-independent SE and
%%% find tunneling rate of gnd state through barrier

clc
clear
close all

%%%%%%%%%%%%%%%%%%%
% clock starts
tic 
% clock starts
%%%%%%%%%%%%%%%%%%%

N = 1000; % No. of points.
wavelength = 1.064e-6; % 1064 nm light
k = 2*pi/wavelength; 
hbar = 1.0545718e-34;
m = 39.964008*1.66054e-27;
recoil = hbar^2*k^2/(2*m);
theta_XY = 10.8*pi/180; % angle of the beams, assume same
Vxy = (2000*0.14/4.4)*recoil;
Vz = (52.1/4.4)*recoil;
x_start = 12.4e-6;
x_end = 13.1e-6;
x = linspace(x_start, x_end, N).'; % Generate column vector with N 
dx = x(2) - x(1); % Coordinate step

% Three-point finite-difference representation of Laplacian
% using sparse matrices, where you save memory by only
% storing non-zero matrix elements.
e = ones(N,1); % a column of ones
Lap = spdiags([e -2*e e],[-1 0 1],N,N) / (2*dx^2);
% put -2e on the main diagonal and e-s on upper and lower diagonals

% potential
U = Vxy*(1-sin(k*sin(theta_XY).*x).^2) + Vz*(1-sin(k.*x).^2);
% Total Hamiltonian.
H = -(1/2)*(hbar^2/m)*Lap + spdiags(U,0,N,N); % 0 indicates main diagonal 
% put vector U on the main diagonal of NxN sparse matrix

% Find lowest nmodes eigenvectors and eigenvalues of sparse matrix.
nmodes = 2; 
[V,E] = eigs(H,nmodes,'SM'); % find two smallest eigenvalues
[E,ind] = sort(diag(E)); % convert E to vector and sort low to high.
V = V(:,ind); % rearrange corresponding eigenvectors.
syms X
eqn = Vxy*(1-sin(k*sin(theta_XY)*X)^2) + Vz*(1-sin(k*X)^2) == E(1);
X1 = vpasolve(eqn, X, [12.5e-6 12.7e-6]);
X2 = vpasolve(eqn, X, [12.7e-6 13e-6]);

% Generate plot of lowest energy eigenvectors V(x) and U(x).
figure(1);
subplot(2,1,1)
plot(x, abs(V).^2);
xlabel('x (m)');
ylabel('|\psi|^2');
xlim([x_start x_end]);
% Add legend showing Energy of plotted V(x).
legendLabels = [repmat('E = ',nmodes,1), num2str(E./recoil), repmat(' E_R',nmodes,1) ];
legend(legendLabels)

subplot(2,1,2)
plot(x, (E(1)/recoil)*ones(N,1),...
    x, (E(2)/recoil)*ones(N,1), x, U/recoil, '--k');
    %x, (E(3)/recoil)*ones(N,1),...
xline(double(X1));
xline(double(X2));
xlabel('x (m)');
ylabel('Energies (E_R)');
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


% looking at tunneling:
% Calculate transmission probability 
integrand = @(x) sqrt(2*m)*...
    real(sqrt(Vxy*(1-sin(k*sin(theta_XY).*x).^2)+Vz*(1-sin(k.*x).^2)...
    -E(1)));
% exp(-(2/\hbar)(2m)\int_{x1}^{x2}(sqrt(V-E))dx)
S_squared = exp(-(2/hbar)*integral(integrand, double(X1), double(X2)));
disp(['Transmission probability: ' num2str(S_squared)]);

% knocking frequency:
nu = E(1)/(hbar*2*pi);
disp(['Knocking frequency: ' num2str(nu) ' Hz']);

% tunneling rate:
R = nu*S_squared;
disp(['Tunneling frequency: ' num2str(R) ' Hz']);

% mean lifetime
tau = 1/R;
disp(['Mean lifetime: ' num2str(tau) ' s']);





