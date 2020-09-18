vogais = ['a', 'e', 'i', 'o', 'u']
s = 'azcbobobegghakl'
D = [v for v in s if v in vogais]
print(f'Existe(m) {len(D)} vogais na string {s}')
