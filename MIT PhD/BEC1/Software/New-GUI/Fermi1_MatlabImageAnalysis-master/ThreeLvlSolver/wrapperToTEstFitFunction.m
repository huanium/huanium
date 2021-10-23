
p = [0.4,50,0,10,20,10];
% param order is: omega_1, omega_2, 2photon det, freq center, y amplitude,
% y offset
x = -40:1:40;
% x are the detunings in MHz without 2*pi
t = 20;
% t is the pulse time
polaronEndState = ThreeLvLSpectrumFunction(p,x,t);

figure(881)
plot(x,polaronEndState)

