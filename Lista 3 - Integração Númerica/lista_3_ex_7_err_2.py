import numpy as np

# m_err === E
#m_err = 1.0 / 2400.0
m_err = 0.0001

def mash(f, a, b, n):
    x = np.linspace(a, b, int(n) + 1, dtype=float)
    h = (b - a) / n
    y = f(x)
    return y, h

def mtd_trapezio(f, a, b, n):
    y, h = mash(f, a, b, n)
    return 0.5 * h * (y[0] + 2*np.sum(y[1:-1]) + y[-1])

def mtd_simpson(f, a, b, n):
    y, h = mash(f, a, b, n)
    Si = np.sum(y[1:-1:2])
    Sp = np.sum(y[2:-1:2])
    return (1.0 / 3.0) * h * (y[0] + 4*Si + 2*Sp + y[-1])

# Para essa função, o max será considerado o menor valor!
def f_2(x):
    return 2 / (x ** 2)

def f_4(x):
    return 24 / (x ** 5)

def f(x):
    return 1 / x

# Para o trapezio
# |E| <= |b - a|^3 / (12n^2) * max|f''(x)|

a = 1.0
b = 2.0

# Erro Trapezio
# raiz(|b - a|^3 / (12*|E|)*max(|f_2(x)|))
# ceil garante o valor superior
n_t = np.ceil(np.sqrt((np.abs(b - a) ** 3) / (12*np.abs(m_err)) * f_2(a)))


# Erro Simpsons
n_s = np.ceil(((np.abs(b - a) ** 5) / (180*np.abs(m_err)) * f_2(a)) ** (1 / 4))

h_t = (b - a) / n_t
h_s = (b - a) / n_s

print(f'T n = {n_t}, h = {h_t}')
print(f'S n = {n_s}, h = {h_s}')

A = mtd_trapezio(f, a, b, n_t)
print(f' T {A} m')

B = mtd_simpson(f, a, b, n_s)
print(f'S {B} m')
