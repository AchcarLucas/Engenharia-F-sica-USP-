import matplotlib.pyplot as plot
import scipy.integrate as spi
import numpy as np

def integral(th):
  return np.sqrt(1 - ((e * np.cos(th)) ** 2))
  
a, b = 20, 10
e = np.sqrt(1.0 - (b / a)**2)

value, err = spi.quad(integral, 0, np.pi / 2)
perimeter = 4 * value * a
print(f'a = {a}, b = {b}, C = {perimeter}')

a = 10

x = np.arange(0.1, 1., 0.01)
y = np.array([])
for k in x:
  e = k
  value, err = spi.quad(integral, 0, np.pi / 2)
  perimeter = 4 * value * a
  y = np.append(y, perimeter)

plot.figure()
plot.plot(x, y, label="Gráfico $Excentricidade$ x $Perímetro$")
plot.xlabel('$Excentricidade$')
plot.ylabel('$Perímetro$')
plot.legend()
plot.show()
