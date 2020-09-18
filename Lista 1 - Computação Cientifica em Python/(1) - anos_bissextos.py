# Lucas Campos Achcar
running = True
while running:
    bs = 'não é'
    year = input('Digite um ano: ')
    year = int(year)

    if ((year % 4) == 0 and (year % 100) != 0) or ((year % 400) == 0):
        bs = 'é'

    print(f'O ano {year} {bs} bissexto! ')

    cont = input("Deseja continuar no programa S/N?: ")
    running = True if cont == 'S' else False
    
