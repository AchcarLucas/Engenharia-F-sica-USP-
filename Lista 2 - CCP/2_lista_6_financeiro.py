import matplotlib.pyplot as plot
import numpy as np
import scipy.optimize as sp

'''
   P -> Quantia Fixa
   j -> Taxa de Juros
   A -> Montante acumulado (ao final do mês m)
   m -> mês

   -----------------------

   A = 750000
   m = 20*12 (240)
   P = 1500
   j = x

   (P/j)*(np.pow_float(1 + j, m) - 1) - A
'''

A = 750000
m = 240 # 20 anos
P = 1500
    
def solve(j):
    return (P/j)*(np.float_power((1 + j), m) - 1) - A

scl = sp.newton(solve, x0=0.00001, maxiter=50, tol=1e-12)
print(f'j = {scl}')

print(f'A = {(P/scl)*(np.float_power((1 + scl), m) - 1)}')

