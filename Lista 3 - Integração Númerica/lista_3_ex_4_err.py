import scipy.integrate as sint
import numpy as np
import matplotlib.pyplot as plot

erf = lambda t: np.exp(-t*t)

table = []
for i in np.arange(0, 3.1, 0.1):
    value, err = sint.quad(erf, 0, i)
    v_erf = value * (2 / np.sqrt(np.pi))
    print(f'Dx = {i:0.2f}, Erf = {v_erf:0.6f}')
    table.append([i, v_erf])

table = np.array(table)

plot.figure()
plot.plot(table[:, 0], table[:, 1])
plot.xlabel('$\Delta X$')
plot.ylabel('Erf')
plot.grid()
plot.show()

# O valor do limite será 1 para x tendendo ao infinito
