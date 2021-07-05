import matplotlib.pyplot as plot
import numpy as np
import scipy.optimize as sp

'''
    E = M + e*sin(E) (Equação de Kepler)
    M -> Anomalia Média (graus º)
    e -> excentricidade
    E -> anomalia excêntrica (graus º)

    Resolva E para M = 5º e e = 0.100

    M(rad) = [M(graus)*np.pi] / 180
    tol = e-09

    M + e*np.sin(E)- E = 0
'''

M = (5*np.pi) / 180.0
e = 0.100

def solve(x):
    return M + e*np.sin(x)- x

scl = sp.newton(solve, x0=0.5, maxiter=50, tol=1e-7)
print(f'Anomalia excêntrica E = {scl}')
print(f'Anomalia excêntrica (Fórmula) E = {M + e*np.sin(scl)}')
