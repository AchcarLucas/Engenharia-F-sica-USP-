# Lucas Campos Achcar
print("Conversor Binário - Decimal")
b = input("Digite um valor binário: ")

b_i = int(b)

value = 0

for n in range(len(b)):
    t = b_i % 10
    b_i = b_i // 10
    value += t*pow(2, n)

print(value)
    
