import numpy.linalg as alg

A = [
        [1, 9, 2, 1, 1],
        [10, 1, 2, 1, 1],
        [1, 0, 5, 1, 1],
        [2, 1, 1, 2, 9],
        [2, 1, 2, 13, 2]
    ]

b = [170, 180, 140, 180, 350]

S = alg.solve(A, b)
print(S)
