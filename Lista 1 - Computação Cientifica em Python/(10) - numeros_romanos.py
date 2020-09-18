N_R = {1: 'I', 2:'II', 3:'III', 4:'IV', 5:'V', 6:'VI', 7:'VII', 8:'VIII', 9:'IX', 10:'X',
       20:'XX', 30:'XXX', 40: 'XL', 50:'L', 60:'LX', 70:'LXX', 80:'LXXX', 90:'XC', 100:'C',
       200:'CC', 300:'CCC', 400:'CD', 500:'D', 600:'DC', 700:'DCC', 800:'DCCC', 900:'CM', 1000:'M',
       2000:'MM', 3000:'MMM'}

print("Transformar números Decimais em números Romanos")
value = input("Digite um valor: ")
value = int(value)

if(value > 0 and value <= 3999):
    units = []

    # Convert Value to Units
    units.append((value // 1000) * 1000)
    value = value % 1000
    units.append((value // 100) * 100)
    value = value % 100
    units.append((value // 10) * 10)
    value = (value % 10)
    units.append(value)

    # Convert Units to Roman
    R = ''
    for v in units:
        if v > 0:
            R += N_R[v]

    print(R)
else:
    print("O número deve estar entre 1 a 3999")
