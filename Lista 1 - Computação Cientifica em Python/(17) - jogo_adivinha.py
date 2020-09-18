import numpy

a = 1
b = 100

winner = False

r_number = numpy.random.randint(a, b + 1)
print(r_number)

attempt = 1

while not winner:
    value = input(f' [{attempt}] Adivinhe o número entre <{a}, {b}>: ')
    value = int(value)

    if r_number == value:
        print(f'Winner!! Number {r_number}, attempt {attempt}')
        winner = True
        continue

    attempt += 1

    if not (value >= a and value <= b):
        print(f'O valor está entre <{a} e {b}>')
        continue

    if value > r_number:
        b = value;
    else:
        a = value;
