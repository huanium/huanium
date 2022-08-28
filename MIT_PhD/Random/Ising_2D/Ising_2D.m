%%% Simulation and Analysis of Ising 2D model


%%%% Simulation part
numSpinsPerDim = 2^9;
probSpinUp = 0.5;
J = 1;
% temperature
kTc = 2*J / log(1+sqrt(2)); % Curie temperature
temp = kTc/1.5;
disp('Curie Temperature')
disp(kTc)
% initialize spins
spin = initSpins(numSpinsPerDim, probSpinUp);
% simulate
spin = metropolis(spin, temp, J);




% %%%% Analysis part
% numSpinsPerDim = 2^6;
% probSpinUp = 0.5;
% J = 1;
% % Temperatures to sample
% numTemps = 2^9;
% kTc = 2*J / log(1+sqrt(2)); % Curie temperature
% kT = linspace(0, 2*kTc, numTemps);
% % Preallocate to store results
% Emean = zeros(size(kT));
% Mmean = zeros(size(kT));
% % Replace 'for' with 'parfor' to run in parallel with Parallel Computing Toolbox.
% for tempIndex = 1 : numTemps
%     spin = initSpins(numSpinsPerDim, probSpinUp);
%     spin = metropolis(spin, kT(tempIndex), J);
%     Emean(tempIndex) = energyIsing(spin, J);
%     Mmean(tempIndex) = magnetizationIsing(spin);
% end


% plot(kT / kTc, Emean, '.');
% hold on;
% window = (2^-3)*numTemps - 1;
% plot(kT / kTc, movmean(  Emean, window));
% plot(kT / kTc, movmedian(Emean, window));
% hold off;
% title('Mean Energy Per Spin vs Temperature');
% xlabel('kT / kTc');
% ylabel('<E>');
% grid on;
% legend('raw',...
%     [num2str(window) ' pt. moving mean'],...
%     [num2str(window) ' pt. moving median'],...
%     'Location', 'NorthWest');
% 
% 
% 
% plot(kT / kTc, Mmean, '.');
% grid on;
% title('Magnetization vs Temperature');
% xlabel('kT / kTc');
% ylabel('M');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



function spin = initSpins(numSpinsPerDim, p)

spin = sign(p - rand(numSpinsPerDim, numSpinsPerDim));

end



function spin = metropolis(spin, kT, J)

numIters = 2^10 * numel(spin);
disp('Number of iterations:')
disp(numIters)

figure(1);
hi = image(spin);
hi.CDataMapping = 'scaled'; % or scaled
ht = text(5,5,'iter = 1');
ht.Color = [.95 .2 .8];
colormap gray

for iter = 1 : numIters
    % Pick a random spin
    linearIndex = randi(numel(spin));
    [row, col]  = ind2sub(size(spin), linearIndex);
    
    % Find its nearest neighbors
    above = mod(row - 1 - 1, size(spin,1)) + 1;
    below = mod(row + 1 - 1, size(spin,1)) + 1;
    left  = mod(col - 1 - 1, size(spin,2)) + 1;
    right = mod(col + 1 - 1, size(spin,2)) + 1;
    
    neighbors = [      spin(above,col);
        spin(row,left);                spin(row,right);
                       spin(below,col)];
    
    % Calculate energy change if this spin is flipped
    dE = 2 * J * spin(row, col) * sum(neighbors);
    
    % Boltzmann probability of flipping
    prob = exp(-dE / kT);
    
    % Spin flip condition
    if dE <= 0 || rand() <= prob
        spin(row, col) = - spin(row, col);
    end

    % plot every 10000 iterations
    if mod(iter,10000)==0
        hi.CData = spin;
        ht.String = ['Iteration: ' num2str(iter) '/' num2str(numIters)];
        drawnow;
    end

end
end



function Emean = energyIsing(spin, J)

sumOfNeighbors = ...
      circshift(spin, [ 0  1]) ...
    + circshift(spin, [ 0 -1]) ...
    + circshift(spin, [ 1  0]) ...
    + circshift(spin, [-1  0]);
Em = - J * spin .* sumOfNeighbors;
E  = 0.5 * sum(Em(:));
Emean = E / numel(spin);

end


function Mmean = magnetizationIsing(spin)

Mmean = mean(spin(:));

end




