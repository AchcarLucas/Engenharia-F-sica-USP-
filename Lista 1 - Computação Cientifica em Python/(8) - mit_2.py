# Lucas Campos Achcar
match = 'bob'
string = 'azcbobobegghaklbob'
c_match = 0
for n in range(len(string) - (len(match) - 1)):
    if(match in string[n:n+len(match)]):
        c_match += 1
print(f'Existe(m) {c_match} {match} na string {string}')
