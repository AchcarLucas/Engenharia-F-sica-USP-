def check_bissexto(year):
    if ((year % 400) == 0 or ((year % 4) == 0) and (year % 100) != 0):
        return True
    return False

#        J   F   M    A   M   J  J    A   S   O  N  D
m_dia = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

d, m, a = input("Digite o dia, mês e o ano em sequência: <d m a>: ").split()

a = int(a)
m = int(m)
d = int(d)

if(m == 2):
    if check_bissexto(a):
        m_dia[m - 1] = 29
    else:
        m_dia[m - 1] = 28

# Happy New Year!!!
if(d >= m_dia[m - 1]):
    d = 1
else:
    d += 1
    
if(m >= 12):
    m = 1
    a += 1
else:
    m += 1
    
if(m == 1 and d == 1):
    print('Happy New Year')
    
print(f'{d:02d}/{m:02d}/{a}')
    
