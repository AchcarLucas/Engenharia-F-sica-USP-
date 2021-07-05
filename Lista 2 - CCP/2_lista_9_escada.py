import numpy as np
import scipy.optimize as sp


'''
    L1^2 = h1^2 + W^2 (I)
    L2^2 = h2^2 + W^2 (II)

    sub (I) de (II)

    L1^2 - L2^2 = h1^2 - h2^2
    h1 = sqrt(L1^2 - L2^2 + h2^2) (III)

    Por semelhaça de triângulos

    |          |
    |          |
h1  |          |  h2
    |    | H   |
    |____|_____|
       x    y
         W

       h1 / H = W / x
       h2 / H = W / y

       x + y = W*(H / h1 + H / h2)
       
       x + y = W

       W = W*(H / h1 + H / h2)

       1 = (H / h1 + H / h2)

       1 / H = 1 / h1 + 1 / h2 (IV)

       sub (III) em (IV)

       1 / H = 1 / h1 + 1 / sqrt(L1^2 - L2^2 + h1^2)
       W = sqrt(L2^2 - h2^2)

       portanto

       H = 5
       L1 = 15
       L2 = 10
       h2 = x
       1 / H - 1 / sqrt(L1^2 - L2^2 + h2^2) + 1 / h2 = 0

       Arrumando a equação acima:
       
       h1 = sqrt(L1^2 - L2^2 + h2^2)
       H - (h2 * h1) /(h2 + h1) = 0
       
'''

H = 4
L1 = 15
L2 = 10

def solve(h2):
    h1 = np.sqrt(pow(L1, 2) - pow(L2, 2) + pow(h2, 2))
    return H - (h2 * h1) /(h2 + h1)


h2 = sp.newton(solve, x0=9, tol=1e-12, maxiter=50)

print(f'h2 {h2} m')

W = np.sqrt(pow(L2, 2) - pow(h2, 2))
print(f'W = {W} m')
