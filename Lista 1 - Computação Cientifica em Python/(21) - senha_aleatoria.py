# Lucas Campos Achcar
import numpy.random

password = ''

for n in range(0, numpy.random.randint(7, 10)):
    password += chr(numpy.random.randint(33, 126))
print(password)
