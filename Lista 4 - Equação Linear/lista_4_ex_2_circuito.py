import numpy.linalg as alg

A = [
        [5, 5, 0, 0, 0],
        [0, 0, 1, -1, 1],
        [0, 0, 0, 2, -3],
        [1, -1, -1, 0, 0],
        [0, 5, -7, -2, 0]
    ]

b = [5.5, 0, 0, 0, 0]

S = alg.solve(A, b)
print(S)
