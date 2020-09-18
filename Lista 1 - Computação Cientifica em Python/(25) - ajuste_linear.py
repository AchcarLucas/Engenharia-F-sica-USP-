# Lucas Campos Achcar

import matplotlib.pyplot as plot
import numpy as np
import math

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

data = []

def main():
    #file_name = 'a.txt'
    file_name = input('Digite o nome do arquivo <name>: ')
    f = open(file_name, 'r')
    
    isRead = True
    counter = 0
    
    while isRead:
        buffer_line = f.readline()
        if(buffer_line == ''):
            isRead = False
            continue
        buffer_line = buffer_line.translate({ord(i): None for i in '()'})
        a, b = buffer_line.split(',')
        
        a = float(a)
        b = float(b)
        
        print(f'[{counter}] a = {a}, b = {b}')

        data.append([a, b])
        counter += 1

    # Dados
    #print(f'Dados: {data}, n = {counter}')

    sum_xi = sum(data, 0)
    sum_yi = sum(data, 1)

    #print(f'sum_xi = {sum_xi}, sum_yi = {sum_yi}')

    sum_quad_x = sum_quad_xy(data, 0)

    #print(f'sum_quad_x = {sum_quad_x}')

    sum_xiyi = sum_xi*sum_yi

    #print(f'sum_xiyi = {sum_xiyi}')

    sum_prod_xiyi = sum_prod_xy(data)

    #print(f'sum_prod_xiyi = {sum_prod_xiyi}')

    m = ((counter*sum_prod_xiyi) - sum_xiyi) / ((counter*sum_quad_x) - (sum_xi*sum_xi))

    #print(f'm = {m:02f}')

    # y = ax + b

    b = (sum_yi / counter) - m*(sum_xi / counter)

    #print(f'b = {b:02f}')

    print(f'y(x) = {m:02f}*x + {b:02f}')
        
    f.close()

    x_data = [v[0] for v in data]
    y_data = [v[0] for v in data]    

    # point(s)
    plot.scatter(x_data, y_data, s=10, edgecolors='none', c='blue')

    line_x = []
    line_y = []

    # line(s)
    line_x.append(0)
    line_y.append(b)

    line_x.append(max(x_data))
    line_y.append(max(x_data)*m + b)

    plot.plot(line_x, line_y, c='red', linestyle='dashed')

    plot.text(((max(x_data)) / 2) + 0.2, ((max(x_data)) / 2)*m + b, f'y(x) = {m:02f}*x + {b:02f}', fontsize=12)
    plot.title("Método Mínimo Quadrático (MMQ)", fontsize=19)

    plot.xlabel("X", fontsize=10)
    plot.ylabel("Y", fontsize=10)

    plot.tick_params(axis='both', which='major', labelsize=9)
    
    plot.show()

main()
