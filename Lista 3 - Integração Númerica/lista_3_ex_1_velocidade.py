import numpy as np

# y(n) = f(x) = A[x]
A = np.array([124, 134, 148, 156, 147,
     133, 121, 109, 99, 85,
     78, 89, 104, 116, 123])

x = [0, 6, 12, 18, 24, 30, 36, 42, 48, 54, 60, 66, 72, 78, 84]

def mtd_trapezio(y, h):
    return 0.5 * h * (y[0] + 2*np.sum(y[1:-1]) + y[-1])

A = A / 3.6     
A = mtd_trapezio(A, 6)
print(f'{A} m')
