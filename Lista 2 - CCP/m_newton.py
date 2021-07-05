import numpy as np

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
