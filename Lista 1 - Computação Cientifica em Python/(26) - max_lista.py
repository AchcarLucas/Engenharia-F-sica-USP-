# Lucas Campos Achcar

import numpy as np

def max_value(c):
    max = 0.0
    for v in c:
        if v > max:
            max = v
    return max
        

collection_len = 5
gen = [np.random.randint(1, 100) for i in range(0, collection_len)]
print(gen)
print('Maior value func max: ', max(gen))
print('Maior value func max_value: ', max_value(gen))
