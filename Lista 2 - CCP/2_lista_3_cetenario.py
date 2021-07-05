import matplotlib.pyplot as plot
import numpy as np
import scipy.optimize as sp

'''
    Resolvendo a seguinte função
    y(50.0) - y(0) = 20
    a*cosh(50/a) - a - 20 = 0
'''

def y(x, a):
    return a*np.cosh(x / a)

def solve(x):
    return y(50, x) - y(0, x) - 20

# N/m
w = 50

# Converge mais rápido para a solução
scl = sp.bisect(solve, 1., 100.)

# Se escolher um ponto melhor, talvez a convergência seja mais rápida
#scl = sp.newton(solve, 10.)

print(f'Solução {scl}')
print(f'T(min) = {w*scl}')
print(f'T(max) = {w*(scl + 20)}')

plot.figure()
x = np.linspace(-50.0, 50.0, 101)
y = y(x, scl)

plot.plot(x, y, label='Catenária', color='green')

h_label = f'H(in) = {scl} m'
plot.axhline(scl, color='b', label=h_label, linestyle='--')

h_label = f'H (fn) = {scl + 20} m'
plot.axhline(scl + 20, color='r', label=h_label, linestyle='--')

plot.axvline(50, color='b', label='x = +50 m', linestyle='-.')
plot.axvline(-50, color='r', label='x = -50 m', linestyle='-.')

plot.legend()
plot.show()
