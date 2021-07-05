import numpy as np

h = 0.1

a = 0.0

b = 0.4

# h = (b - a) / n
# Isola o n

n = (b - a) / h

print(f'n = {n}')

# Derivada 4º de integrate(e^x)
def f_4(x):
    return np.exp(x)

# o max será f_4(0.4) pois é uma integral crescente (o último valor é o maior!)

E = (np.abs(b - a) ** 5) / (180*(n**4))*np.max(f_4(0.4))
print(f'err = {E}')
