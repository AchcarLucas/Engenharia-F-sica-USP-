# Lucas Campos Achcar
print("Conversor Decimal - Binário")
b = input("Digite um valor decimal: ")

b_i = int(b)

bin = ''

while(b_i != 0):
    bin += str(b_i % 2)
    b_i = b_i // 2

print(bin[::-1])
