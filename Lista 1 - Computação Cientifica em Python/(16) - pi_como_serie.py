import math

amount_iterator = 100000

def pi_serie():
    iterator = 1
    t_factor = 2

    result = 0

    while amount_iterator > iterator:
        result += pow(-1, iterator + 1)*(1 / (t_factor*(t_factor + 1)*(t_factor + 2)))
        t_factor += 2
        iterator += 1
        
    return (result * 4) + 3

print("Série: ", pi_serie())
print("Real:  ", math.pi)
    
