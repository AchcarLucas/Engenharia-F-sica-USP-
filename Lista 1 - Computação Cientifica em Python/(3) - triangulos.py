# Lucas Campos Achcar

print("Podemos formar um triangulo ?")
# O Split faz a separação nas três variáveis
a, b, c = input("Digite três medidas <a b c>: ").split()
if(c >= (a + b) or b >= (a + c) or a >= (b + c)):
    print("Falso, você não pode formar um triângulo")
else:
    print("Verdade, você pode formar um triângulo")
