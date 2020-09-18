# Lucas Campos Achcar

string = 'azcbobobegghakl'

# Transformar as letras em números (ASCII)
c_string = [ord(v) for v in string]

# [Só para Debug]
#print(string)
#print(c_string)

sequences = []
t_sequence = []
biggers_sequence = []

for i in range(0, len(c_string)):
    for n in range(i, len(c_string) - 1):
        # Verifica se o valor atual é maior que o valor posterior
        if(c_string[n] <= c_string[n + 1]):
            # Salva esse valor na sequência temporária
            t_sequence.append(c_string[n])
        elif(len(t_sequence) >= 1):
            '''
                Se achou algum valor (antes de entrar nesse if), adiciona o mesmo
                na lista de sequências temporárias pois temos certeza que é maior
                do que o anterior
            '''
            t_sequence.append(c_string[n])
            
            # Adiciona a sequência que achou na lista de sequências

            # [Só para Debug]
            # print(t_sequence)

            '''
                Essa sequência é só para saber quais sequências foram encontradas,
                pode ser removida do código se quiser!
            '''
            sequences.append([chr(v) for v in t_sequence])
            break
        else:
            '''
                Se não achou nenhum valor, simplesmente
                saia do for para continuar procurando
            '''
            break

    # Verifica se a sequência temporária é maior do que o biggers, se for, salva!
    if(len(t_sequence) > len(biggers_sequence)):
        # Limpa a maior sequência salva!
        biggers_sequence.clear()
        
        # Adiciona a sequência nova no biggers
        biggers_sequence = ([chr(v) for v in t_sequence]);
        
    # Limpa a sequência temporária
    t_sequence.clear()

# [Só para Debug]
#print(f'Todas as sequências {sequences}')
print(f'Maior sequência: {biggers_sequence}')
