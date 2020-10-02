def media(data):
    # Vetor que irá conter as médias dos valores
    r_media = []
    # Interação sobre as linhas da lista
    for row in data:
        tmp_media = 0
        # Cada linha da lista tem uma lista valores (matrix)
        for value in row:
            # Soma todos os valores
            tmp_media += value
        # Divide pela quantidade de valores somados e salva na lista média
        r_media.append(tmp_media / len(row))
    # Retorna a lista contendo os valores das médias
    return r_media
            
'''
    Test
    
'''

'''
data = []
data.append([1,2,5])
data.append([10,20,5])

test_media = media(data)

print(test_media)
'''
