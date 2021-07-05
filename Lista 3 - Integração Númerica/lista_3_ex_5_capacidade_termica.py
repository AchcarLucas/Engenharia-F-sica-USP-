import scipy.integrate as sint
import matplotlib.pyplot as plot
import numpy as np

def i_debye(u):
    return ((u ** 4)*np.exp(u)) / ((np.exp(u) - 1) ** 2)

# Constante universal dos gases (J mol^-1 * K^-1)
R = 8.31451

x = [70.16, 75.37, 81.59, 88.65, 96.68, 105.1, 113.04, 125.28, 134.29, 144.1,
       153.71, 162.76, 173.33, 181.96, 191.44, 200.94, 211.84, 231.06, 241.09,
       252.37, 264.31, 276.61, 287.96,300, 320, 340, 360, 380, 400, 420, 440,
       460, 480, 500, 550, 600, 650, 700, 750, 800, 850, 900, 950, 1000, 1050,
       1100]

def debye(x):
    value, err = sint.quad(i_debye, 0, x)
    return value, err

# T temperatura em kelvin
# Td temperatura de debye
def c_v(Td, T):
    return 9.0 * R * ((T / Td) ** 3) * debye(Td / T)[0]

y = []

for T in x:
    Cv = c_v(1849.0, T)
    y.append(Cv)
    print(f'T = ({T}) K - ({Cv:0.5f}) J')

plot.figure()
plot.plot(x, y)
plot.xlabel('Temperatura ($K$)')
plot.ylabel('Calor Especificio Molar ($J$ / $mol$)')
plot.show()
