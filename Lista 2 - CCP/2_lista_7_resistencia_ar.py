import matplotlib.pyplot as plot
import numpy as np
import scipy.optimize as sp

'''
    m -> massa (kg)
    h0 -> altura inicial (m)
    g -> gravidade (m/s^2)
    k -> coeficiente de resistência do ar (kg/s)
    tol = 1e-3 (0.01s de tolerância)
    
    -----------------------

    h(t) = h0 - (m*g / k) * t + (pow(m, 2)*g / pow(k, 2))*(1 - pow(np.e, (-k*t / m)))

    Quando atingir o solo h(t) = 0
    
'''

m = 0.25
h0 = 300
g = 9.80665
k = 0.1
tol = 1e-3

def h(t):
    return h0 - (m*g / k) * t + (pow(m, 2)*g / pow(k, 2))*(1 - pow(np.e, (-k*t / m)))

def solve(t):
    return h(t)

scl = sp.newton(solve, x0=2., maxiter=50, tol=tol)
print(f'tempo = {scl} s')
print(f'altura final = {h(scl):0.2f} m')

