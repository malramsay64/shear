#!/usr/bin/python3

import math
import statistics
import fileinput

vals = []

if __name__ == "__main__":
    for line in fileinput.input():
        if line.isspace():
            print(statistics.variance(vals))
            vals = []
        else:
            vals.append(float(line.split(' ')[1]))
