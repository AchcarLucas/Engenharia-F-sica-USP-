import numpy.linalg as alg

A = [
        [10, 10, 50, 20],
        [10, 100, 20, 40],
        [100, 30, 20, 35],
        [5, 6, 5, 15]
    ]

b = [140, 190, 205, 54]

S = alg.solve(A, b)
print(S)
