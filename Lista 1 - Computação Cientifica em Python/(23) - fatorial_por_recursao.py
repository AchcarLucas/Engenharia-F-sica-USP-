# Lucas Campos Achcar


# A função de recursividade chama a si mesmo enquanto o valor de n
# não for menos que 2, isso significa que teremos uma arvore

# Vamos tomar o valor 5 e fatorar (5*4*3*2*1 = 120)
# Utilizando recursividade teremos algo assim

#fatorial_recursivo(5) [0]

#   5 < 2 ? Não
#   5*fatorial_recursivo(4) [1]

#       4 < 2 ? Não
#       4*fatorial_recursivo(3) [2]

#           3 < 2 ? Não
#           3*fatorial_recursivo(2) [3]

#               3 < 2 ? Não
#               3*fatorial_recursivo(2) [4]

#                   2 < 2 ? Não
#                   2*fatorial_recursivo(2) [5]

#                       1 < 2 ? Sim ()
#                       Return 1    [6]

# Quando chegar no retorno [6] então a função irá devolver o valor 1 para
# [5], em [5] iremos multiplicar por 2, [5] vai devolver 2 para [4], [4]
# irá multiplicar o valor por 3 e o valor 6 irá para [3], [3] irá multiplicar
# o valor retornado por 4 e irá retornar 24 para [1] e esse por sua vez, irá finalmente
# multiplicar o valor por 5 totalizado 120.

def fatorial_recursivo(n):
    if n < 2:
        return 1
    else:
        return n * fatorial_recursivo(n-1)

print(fatorial_recursivo(5))
