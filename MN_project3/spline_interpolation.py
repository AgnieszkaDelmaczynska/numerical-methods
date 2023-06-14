import os
import csv
import calculations
from matplotlib import pyplot


def calculate_params(points):
    # n - number of points
    n = len(points)
    # our A_matrix initially zeros
    A_matrix = [[0] * (4 * (n - 1)) for _ in range(4 * (n - 1))]
    # our b_vector initially zeros
    b_vector = [0] * (4 * (n - 1))
    # due to having 4 equations we do 4 'for loops'
    for i in range(n - 1):
        x, y = points[i]
        A_matrix[4 * i + 3][4 * i + 3] = 1
        b_vector[4 * i + 3] = (float(y))
    for i in range(n - 1):
        x_1, y_1 = points[i + 1]
        x0, y0 = points[i]
        h = float(x_1) - float(x0)
        # equations from the algorithm
        A_matrix[4 * i + 2][4 * i] = h ** 3
        A_matrix[4 * i + 2][4 * i + 1] = h ** 2
        A_matrix[4 * i + 2][4 * i + 2] = h ** 1
        A_matrix[4 * i + 2][4 * i + 3] = 1
        b_vector[4 * i + 2] = float(y_1)
    for i in range(n - 2):
        x_1, y_1 = points[i + 1]
        x0, y0 = points[i]
        h = float(x_1) - float(x0)
        A_matrix[4 * i][4 * i] = 3 * (h ** 2)
        A_matrix[4 * i][4 * i + 1] = 2 * h
        A_matrix[4 * i][4 * i + 2] = 1
        A_matrix[4 * i][4 * (i + 1) + 2] = -1
        b_vector[4 * i] = 0.0
    for i in range(n - 2):
        x_1, y_1 = points[i + 1]
        x0, y0 = points[i]
        h = float(x_1) - float(x0)
        A_matrix[4 * (i + 1) + 1][4 * i] = 6 * h
        A_matrix[4 * (i + 1) + 1][4 * i + 1] = 2
        A_matrix[4 * (i + 1) + 1][4 * (i + 1) + 1] = -2
        b_vector[4 * (i + 1) + 1] = 0.0
    # return A_matrix and b_vector
    A_matrix[1][1] = 2
    b_vector[1] = 0.0

    x_1, y_1 = points[-1]
    x0, y0 = points[-2]
    h = float(x_1) - float(x0)
    A_matrix[-4][1] = 2
    A_matrix[-4][-4] = 6 * h
    b_vector[-4] = 0.0
    # return result
    result = calculations.lu_fact(A_matrix, b_vector)
    return result


def auxiliary_function(params, points, given_x):
    array_of_params = []
    row = []
    for parameter in params:
        row.append(parameter)
        if len(row) == 4:
            array_of_params.append(row.copy())
            row.clear()

    for i in range(1, len(points)):
        x_i, y_i = points[i - 1]
        x_j, y_j = points[i]
        if float(x_i) <= given_x <= float(x_j):
            a, b, c, d = array_of_params[i - 1]
            h = given_x - float(x_i)
            return a * (h ** 3) + b * (h ** 2) + c * h + d
    return -100


def interpolate_with_spline(k):
    for file in os.listdir('./data_for_diagrams'):
        f = open('./data_for_diagrams/' + file, 'r')
        data = list(csv.reader(f))
        data = data[1:]
        shift = (-1) * (len(data) % k)
        if shift != 0:
            interpolation_data = data[:shift:k]
        else:
            interpolation_data = data[::k]
        params = calculate_params(interpolation_data)
        dist = []
        height = []
        interpolated_height = []
        for point in data:
            x, y = point
            dist.append(float(x))
            height.append(float(y))
            interpolated_height.append(auxiliary_function(params, interpolation_data, float(x)))
        train_distance = []
        train_height = []
        for point in interpolation_data:
            x, y = point
            train_distance.append(float(x))
            train_height.append(float(y))
        shift = -1 * interpolated_height.count(-100)

        pyplot.plot(dist, height, 'b.', label='dane z pliku')
        pyplot.plot(dist[:shift], interpolated_height[:shift], color='green', label='F(x) - funkcja interpolująca')
        pyplot.plot(train_distance, train_height, 'r.', label='dane brane do interpolacji')
        pyplot.legend()
        pyplot.ylabel('wysokość od poziomu 0')
        pyplot.xlabel('odległość od punktu startowego')
        pyplot.title('Zastosowanie interpolacji Splajnami, wzięto ' + str(len(interpolation_data)) + ' punktów')
        pyplot.suptitle(file)
        pyplot.grid()
        pyplot.show()
