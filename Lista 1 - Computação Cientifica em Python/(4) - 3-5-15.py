# Lucas Campos Achcar
for n in range(1, 101):
    if(n % 3 == 0 and n % 5 == 0):
        print('cincisprezece', end=' ')
    elif n % 3 == 0:
        print('trei', end=' ')
    elif n % 5 == 0:
        print('cinci', end=' ')
    else:
        print(f'{n} ', end=' ')
