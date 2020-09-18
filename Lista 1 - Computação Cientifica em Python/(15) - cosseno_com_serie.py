# Lucas Campos Achcar
import math

# precisão que queremos da série
accuracy = 10e-6

# Conseguindo ideia para fatoração!
#2.1
#4.3.[(2.1)]
#6.5.[(4.3).(2.1)]

#Conseguindo ideia para a potencia
#x^2
#x*x

#x^4
#x*x*(x*x)

#x^6
#x*x*[(x*x)*(x*x)]

def taylor_cos_serie(x):
    # variável de iteração (Impar é [-], Par é [+])
    iterator = 1
    
    # primeira iteração
    x_t = x*x

    # primeiro fatorial 2*1
    factor = 2*1
    
    # a cada iteração, (n+2)*(n+1) são acrescidos ao factor
    t_factor = 2

    # a Série de Taylor inicia em 1
    result = 1.0

    # primeiro termo da série de Taylor
    t = 1.0

    # sai do while apenas quando o último termo tiver a accuracy desejada
    while t > accuracy:
        t = x_t / factor
        x_t *= x*x
        factor *= (t_factor + 2)*(t_factor + 1)
        result = result + t if iterator % 2 == 0 else result - t
        iterator += 1
        t_factor += 2
        print(factor, iterator)

    print(f'last term: {t}')
    print(f'iterator: {iterator}')
    return result
        
        
print(f'{taylor_cos_serie(math.pi / 3):.6f}')
