import media as md
import math

def desvio(data, media):
    if(len(data) != len(media)):
        print(f'data e media devem possuir o mesmo tamanho')
        return -1
    # Vetor que irá conter as médias dos valores
    r_desvio = []
    c_tmp = 0
    # Interação sobre as linhas da lista
    for row in data:
        tmp_sum = 0
        for value in row:
            tmp_sum += math.pow(value - media[c_tmp], 2)
        r_desvio.append(math.sqrt(tmp_sum / len(row)))
        c_tmp +=1
        
    return r_desvio


'''
    Test
'''

'''
data = []
data.append([1,1,1])
data.append([10,20,5])

print(f'Dados {data}')

test_media = md.media(data)

print(f'Média {test_media}')

test_desvio = desvio(data, test_media)

print(f'Desvio {test_desvio}')
'''
