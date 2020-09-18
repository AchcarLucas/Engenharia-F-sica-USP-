# Lucas Campos Achcar

print("Programa para calcular MDC entre dois valores")
a, b = input("Digite dois valores <a b>: ").split()
a = int(a)
b = int(b)
d = min(a, b)
while(not(a % d == 0 and b % d == 0)):
    d -= 1
print(f'{d} é o Maior Divisor Comum (MDC) de {a} e {b}')
        
