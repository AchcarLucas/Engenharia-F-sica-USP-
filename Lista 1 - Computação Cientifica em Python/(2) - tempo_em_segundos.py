# Lucas Campos Achcar
print("Conversor de Tempo em Segundos para Horas, Minutos e Segundos")
time_in_second = input("Digite um tempo em segundos: ")
time_in_second = int(time_in_second)

# 1 hora tem 3600 seconds
# Divide por 3600 e pega o valor inteiro
hours = time_in_second // 3600

# Pega o resto da divisão de 3600
rest = time_in_second % 3600

# 1 minuto tem 60 seconds
# divide o resto por 60
mins = rest // 60

# o resto dos minutos são os segundos
seconds = rest % 60

print(f'{hours:02d} hour(s) {mins:02d} min(s) {seconds:02d} second(s)')
