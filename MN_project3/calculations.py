import math


def calc_norm(vect):
    temp = 0
    for number in vect:
        temp += number ** 2
    return math.sqrt(temp)


def sub_vectors(a, b):
    temp = a[:]
    for i in range(len(a)):
        temp[i] -= b[i]
    return temp


def dot(A, b):
    temp = [0 for _ in range(len(A))]
    for i in range(len(A)):
        for l in range(len(A)):
            temp[i] += A[i][l] * b[l]
    return temp


def create_LU(A_matrix):
    L_matrix = [[1 if x == y else 0 for x in range(len(A_matrix))] for y in range(len(A_matrix))]
    U_matrix = [[0 for _ in range(len(A_matrix))] for _ in range(len(A_matrix))]
    for i in range(len(A_matrix)):
        for j in range(i + 1):
            U_matrix[j][i] += A_matrix[j][i]
            for s in range(j):
                U_matrix[j][i] -= L_matrix[j][s] * U_matrix[s][i]
    for j in range(i + 1, len(A_matrix)):
        for s in range(i):
            L_matrix[j][i] -= L_matrix[j][s] * U_matrix[s][i]
        L_matrix[j][i] += A_matrix[j][i]
        L_matrix[j][i] /= U_matrix[i][i]
    return L_matrix, U_matrix


def lu_fact(A_matrix, b_vector) -> float:
    # generate y of zeros
    y = [0 for _ in range(len(A_matrix))]
    # generate x of ones
    x = [1 for _ in range(len(A_matrix))]
    L_matrix, U_matrix = create_LU(A_matrix)
    # do Ly = b
    for i in range(len(A_matrix)):
        temp = b_vector[i]
        for j in range(i):
            temp -= L_matrix[i][j] * y[j]
        y[i] = temp / L_matrix[i][i]
    # next do Ux = y
    for i in range(len(A_matrix) - 1, -1, -1):
        temp = y[i]
        for j in range(i + 1, len(A_matrix)):
            temp -= U_matrix[i][j] * x[j]
        x[i] = temp / U_matrix[i][i]
    return x
