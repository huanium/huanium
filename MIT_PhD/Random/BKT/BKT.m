%%%% BKT transition simulation

numSpinsPerDim = 2^6;
J = 1.5;
% temperature
T = 0.001;
% initialize spins
spin = initSpins(numSpinsPerDim);
% simulate
spin = metropolis(spin, T, J);



% initialize spins
function spin = initSpins(numSpinsPerDim)
spin = 2*pi*rand(numSpinsPerDim,numSpinsPerDim);
end


% calculate energy per spin
function E = energyXY(spin,J)
Em = ...
      cos(spin-circshift(spin, [ 0  1])) ...
    + cos(spin-circshift(spin, [ 0 -1])) ...
    + cos(spin-circshift(spin, [ 1  0])) ...
    + cos(spin-circshift(spin, [-1  0]));
E  = -J.*sum(Em(:));

end


function spin = metropolis(spin,T,J)
numIters = 2^20 * numel(spin);
disp('Number of iterations:')
disp(numIters)

figure(1);

imagesc(spin)
% set so that the color scale is correct... (dubious!)
spin(1,1) = 2*pi;
spin(2,2) = 0;
colormap default
axis equal tight;


for iter = 1 : numIters
    % Pick a random spin
    linearIndex = randi(numel(spin));
    [row, col]  = ind2sub(size(spin), linearIndex);
     
    % pick a random value from the possible spin vals and assign
    new_spin = 2*pi*rand();
    new_lattice = spin;
    new_lattice(row,col) = new_spin;
    
    % Calculate energy change if this spin is modified
    %dE = energyXY(new_lattice,J) - energyXY(spin,J);
    
    % Find its nearest neighbors
    above = mod(row - 1 - 1, size(spin,1)) + 1;
    below = mod(row + 1 - 1, size(spin,1)) + 1;
    left  = mod(col - 1 - 1, size(spin,2)) + 1;
    right = mod(col + 1 - 1, size(spin,2)) + 1;
    
    neighbors = [      spin(above,col);
        spin(row,left);                spin(row,right);
                       spin(below,col)];
    
    dE = -cos(new_lattice(row,col)-neighbors(1))+cos(spin(row,col)-neighbors(1))...
        -cos(new_lattice(row,col)-neighbors(2))+cos(spin(row,col)-neighbors(2))...
        -cos(new_lattice(row,col)-neighbors(3))+cos(spin(row,col)-neighbors(3))...
        -cos(new_lattice(row,col)-neighbors(4))+cos(spin(row,col)-neighbors(4));
    
    de = J*dE;
    
    % Boltzmann probability of flipping
    prob = exp(-dE / T);
    
    % Spin flip condition
    if dE <= 0 || rand() <= prob
        spin = new_lattice;
    end

    % plot every 100 iterations
    if mod(iter,100000) == 0
        imagesc(spin)
        drawnow;
    end

end
end



