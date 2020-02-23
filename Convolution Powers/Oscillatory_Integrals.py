from numpy import exp, tanh, inf
from scipy.integrate import quad

OMEGA = 30

def func(x):
    return 1 if x == 0 else x * exp(-x) / tanh(x)

result, err = quad(func, 0, inf, weight='cos', wvar=OMEGA)

print('Result: {0}, error: {1}'.format(result, err))
