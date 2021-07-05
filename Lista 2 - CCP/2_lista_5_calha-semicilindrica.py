import matplotlib.pyplot as plot
import numpy as np
import scipy.optimize as sp

'''
    L = 10.
    r = 1.
    V = 12.4
    L*(0.5*np.pi*pow(r, 2) - pow(r, 2)*np.arcsin(h/r) - h*sqrt((pow(r, 2) - pow(h, 2)))) - V = 0
'''

L = 10.
r = 1.
V = 12.4

def solve(h):    
    a = 0.5 * np.pi * pow(r, 2)
    b = np.arcsin(h / r) * pow(r, 2)
    c = h * np.sqrt((pow(r, 2) - pow(h, 2)))
    
    return L*(a - b - c) - V

scl = sp.newton(solve, x0=0.2, maxiter=50, tol=1e-7)
print(f'h = {scl}')
print(f'V = {L*(0.5*np.pi*pow(r, 2) - pow(r, 2)*np.arcsin(scl/r) - scl*np.sqrt((pow(r, 2) - pow(scl, 2))))}')
