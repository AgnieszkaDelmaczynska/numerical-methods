import os
import csv
from matplotlib import pyplot


def interpolation_function(points_array, given_x):
    returned_result = 0.0
    for i in range(len(points_array)):
        base = 1
        x_i, y_i = points_array[i]
        for j in range(len(points_array)):
            if i != j:
                x_j, y_j = points_array[j]
                base *= (float(given_x) - float(x_j)) / (float(x_i) - float(x_j))
        returned_result += float(y_i) * base
    return returned_result


def interpolate_with_lagrange(k):
    for file in os.listdir('./data_for_diagrams'):
        # load file from directory
        f = open('./data_for_diagrams/' + file, 'r')
        data = list(csv.reader(f))
        interpolation_data = data[1::k]

        # create arrays to store distance and height
        distance = []
        height = []
        # create arrays to store trained and interpolated distance and height
        interpolated_height = []
        train_distance = []
        train_height = []
        # do interpolate for each point in array of data points
        for point in data[1:]:
            x, y = point
            distance.append(float(x))
            height.append(float(y))
            interpolated_height.append(interpolation_function(interpolation_data, float(x)))
        # do interpolate for each point in array of interpolated data points
        for point in interpolation_data:
            x, y = point
            train_distance.append(float(x))
            train_height.append(interpolation_function(interpolation_data, float(x)))

        # draw plots
        pyplot.plot(distance, height, 'b.', label='dane z pliku')
        pyplot.semilogy(distance, interpolated_height, color='green', label='F(x) - funkcja interpolująca')
        pyplot.semilogy(train_distance, train_height, 'r.', label='dane brane do interpolacji')
        pyplot.legend()
        pyplot.ylabel('wysokość od poziomu 0')
        pyplot.xlabel('odległość od punktu startowego')
        pyplot.title('Zastosowanie interpolacji Lagrange\'a, wzięto ' + str(len(interpolation_data)) + ' punktów')
        pyplot.suptitle(file)
        pyplot.grid()
        pyplot.show()
