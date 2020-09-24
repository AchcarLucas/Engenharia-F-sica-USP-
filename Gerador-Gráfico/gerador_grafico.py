# Lucas Campos Achcar

import matplotlib.pyplot as plot


'''
-------------------------------------------
'''

def sum(data, i):
    sum = 0.0
    for v in data:
        sum += v[i]
    return sum
        
def prod(data, i):
    prod = 1.0
    for v in data:
        prod *= v[i]
    return prod

def sum_prod_xy(data):
    sum_prod_xy = 0.0
    for v in data:
        sum_prod_xy += v[0]*v[1] 
    return sum_prod_xy

def sum_quad_xy(data, i):
    sum_quad = 0.0
    for v in data:
        sum_quad += v[i]*v[i]
    return sum_quad

def MMQ(x, y, counter):
    data = []
    '''
    -------- Linearização
    '''
    for idx in range(0, counter):
        data.append([x[idx], y[idx]])

    # Dados

    sum_xi = sum(data, 0)
    sum_yi = sum(data, 1)

    sum_quad_x = sum_quad_xy(data, 0)

    sum_xiyi = sum_xi*sum_yi

    sum_prod_xiyi = sum_prod_xy(data)

    m = ((counter*sum_prod_xiyi) - sum_xiyi) / ((counter*sum_quad_x) - (sum_xi*sum_xi))

    # y = ax + b

    b = (sum_yi / counter) - m*(sum_xi / counter)

    print(f'y(x) = {m:02f}*x + {b:02f}')
    
    return m, b

    '''
    -------- Linearização
    '''


'''
-------------------------------------------
'''

x = [0, 1, 2, 3, 4, 5]
y = [0, 2, 4, 6, 8, 10]

m, b = MMQ(x, y, len(x))

plot.figure()


# line(s)

line_x = []
line_y = []

line_x.append(-1000)
line_y.append(-1000*m + b)

line_x.append(1000)
line_y.append(1000*m + b)

plot.plot(x, y, '.', label='Label', color='red', markersize=8)

plot.xlim(min(x) - 0.05, max(x) + 0.05)
plot.ylim(min(y) - 1.00, max(y) + 1.00)

plot.grid()

plot.xlabel('Label X')
plot.ylabel('Label Y')

plot.plot(line_x, line_y, c='blue', linestyle='--', label=f'Label')

plot.legend()
plot.show()
