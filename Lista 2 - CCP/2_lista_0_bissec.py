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
    while abs(f) > tol:
        # O usuário informou a função derivada ? Se não, usa o método da secante
        if(deriv == None):
            df = sec_df(x0, tol, func)
        else:
            df = deriv(x0)
        x0 -= f / df
        f = func(x0)
    return x0


# "chute" inicial: x0 = 1
sol = newton(f, None, 1)
print("Método Derivada ->", sol)

sol = newton(f, df, 1)
print("Método Secante ->", sol)
