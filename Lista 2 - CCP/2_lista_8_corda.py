import numpy as np
import scipy.optimize as sp

def solve(a):
    return np.sin(a) - (5*a / 6)


scl = sp.newton(solve, 1.5)

print(f'Solução {scl} rad')

a = 5 / np.sin(scl)
print(f'raio (a) = {a} cm')

OC = np.cos(scl)*a
print(f'OC = {OC} cm')

print(f'CD = {a - OC} cm')
