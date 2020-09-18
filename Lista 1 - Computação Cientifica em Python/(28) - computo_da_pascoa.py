# Lucas Campos Achcar

def meeus_jones_butcher(year):
    a = year % 19
    b = year // 100
    c = year % 100
    d = b // 4
    e = b % 4
    f = (b + 8) // 25
    g = (b - f + 1) // 3
    h = (19*a + b - d - g + 15) % 30
    i = c // 4
    k = c % 4
    l = (32 + 2*e + 2*i - h - k) % 7
    m = (a + 11*h + 22*l) // 451
    n = (h + l - 7*m + 114) // 31
    p = (h + l - 7*m + 114) % 31
    return n, p + 1

year = input("Digite um ano a partir de 1583: ")
year = int(year)

n, p = meeus_jones_butcher(year)
print(f'O domingo de Páscoa do ano {year} será em {p:02d}/{n:02d}/{year}')
