# Lucas Campos Achcar
accuracy = 10e-12

r = input("Digite um valor para tirar a raiz quadrada: ")
r = int(r)

_sqrt = r / 2

while abs(_sqrt*_sqrt - r) >= accuracy:
    _sqrt = (_sqrt + (r / _sqrt)) / 2

print(f'A aprox da raiz {r} é {_sqrt}')
