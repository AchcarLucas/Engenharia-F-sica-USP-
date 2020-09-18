def create_pascal_triangle(n_line):
    # Cria o array para adicionar as linhas
    table = []
    for i in range(0, n_line):
        # Cria uma nova linha
        table.append([]);

        '''
            a(i,j) = {
                        1 se (j = 0 ou j = i)
                        a(i−1,j) + a(i−1,j−1), se 1 < j < i
                     }
            '''
            
        for j in range(0, i + 1):
            # Se j igual a 0 ou i igual a j, teremos um valor 1
            if(j == 0 or j == i):
                table[i].append(1)
            else:
                '''
                    Caso contrário, pega o valor da linha superior ao valor
                    da linha e a do lado esquerdo, soma os dois para dar o
                    próximo valor da posição j
                '''
                table[i].append(table[i - 1][j] + table[i - 1][j - 1])
    # Retorna a tabela contendo as linhas e colunas
    return table

table = create_pascal_triangle(8)
# Exibe o Triângulo de Páscal
for i in table:
    for j in i:
        print(j, end=' ')
    print()
