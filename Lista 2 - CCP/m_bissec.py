import numpy as np

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
