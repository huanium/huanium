% Huan Bui
% Na 1178 nm seed power vs max output of 589 nm RFA 

clear all

seed_power = 10.*[1.98  1.719 1.254 0.968 1.826 1.512 1.343 1.173 1.921 1.780 1.618 1.864 0.897 0.649];
max_output =     [1.477 1.365 1.213 1.139 1.440 1.355 1.308 1.210 1.56  1.485 1.424 1.49  0.000 0.000];

plot(seed_power, max_output, 'o')
xlabel('Seed power (mW)')
ylabel('Max RFA output (W)')

grid on