# Calcula fibonnaci pelo n-esimo termo
#An = An-1 + An-2

def fibonacci(n):
    if n == 0:
        return 0
    elif (n == 1):
        return 1

    return fibonacci(n - 1) + fibonacci(n - 2)
    
fibonacci_value = [fibonacci(n) for n in range(0, 20)]
print(fibonacci_value)
    
