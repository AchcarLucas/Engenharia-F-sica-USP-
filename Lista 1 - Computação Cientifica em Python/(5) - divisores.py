# Lucas Campos Achcar

print("Programa para saber todos os divisores")
value = input("Digite um valor: ")
value = int(value)
D = [n for n in range(1, value + 1) if (value % n) == 0]
print(f'Divisores de {value} é/são {D}')
if(len(D) == 2):
    print(f'{value} é um primo!')
