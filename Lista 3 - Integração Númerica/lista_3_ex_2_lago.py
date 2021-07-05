import numpy as np

# y(n) = f(x) = A[x]
A = np.array([7.0, 6.0, 9.0, 10.0, 9.0, 8.0, 6.0])
H_A = 6.0

B = np.array([4.0, 5.0, 9.0, 8.0, 7.0])
H_B = 8.0

def mtd_trapezio(y, h):
    return 0.5 * h * (y[0] + 2*np.sum(y[1:-1]) + y[-1])

def mtd_simpson(y, h):
    Si = np.sum(y[1:-1:2])
    Sp = np.sum(y[2:-1:2])
    return (1.0 / 3.0) * h * (y[0] + 4*Si + 2*Sp + y[-1])

A = mtd_simpson(A, H_A)
B = mtd_simpson(B, H_B)

print(f'{A+B} km')
