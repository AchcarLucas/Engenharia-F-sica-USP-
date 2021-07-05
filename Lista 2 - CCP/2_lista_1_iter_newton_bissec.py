import numpy as np

# função da qual se quer achar a raiz
def f(x):
    return x - np.cos(x)

# a derivada da função acima
def df(x):
    return 1 + np.sin(x)

# a derivada pelo método da secante
def sec_df(x, h, f):
    h *= 10.0
    return (f(x + h) - f(x - h)) / (2*h)

# função com o algoritmo de Newton-Raphson
def newton(func, deriv=None, x0=1, tol=1e-13):
    f = func(x0)
    _iter = 0
    while abs(f) > tol:
        # O usuário informou a função derivada ? Se não, usa o método da secante
        if(deriv == None):
            df = sec_df(x0, tol, func)
        else:
            df = deriv(x0)
        x0 -= f / df
        f = func(x0)
        _iter += 1
    return x0, _iter

# função com o algoritmo da bisssecção
def bissec(func, a, b, prec=1e-13):
    erro = b - a
    _iter = 0
    while erro > prec:
        c = .5 * (a + b)
        if func(a) * func(c) > 0:
            a = c
        else:
            b = c
        erro /= 2
        _iter += 1
    return c, _iter

# "chute" inicial: x0 = 1
sol, _iter = newton(f, None, 1, 1e-9)
print("Método Derivada ->", sol, "iterações ->", _iter)

# "chute" inicial: x0 = 1
sol, _iter = newton(f, df, 1, 1e-9)
print("Método Secante ->", sol, "iterações ->", _iter)

# Delimitando a raiz inicialmente em [0.5, 1]
sol, _iter = bissec(f, 0.5, 1, 1e-9)
print("Método Bissec ->", sol, "iterações ->", _iter)
