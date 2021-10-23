
p = [8,35,5];
% param order is: omega_1, y amplitude, y offset
x = 0:0.001:1;
% x are the pulse durations in us
polaronEndState = ThreeLvLPAFunction(p,x);

figure(881)
plot(x,polaronEndState)

