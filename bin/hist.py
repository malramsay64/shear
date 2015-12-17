#!/usr/bin/python

import math
import fileinput
from scipy import stats
import sys

vals = []
means = []
variances = []
skews = []

if __name__ == "__main__":
    for line in fileinput.input():
        if line.isspace():
            if sum([x**2 for x in vals]) > 0:
                n, valRange, mean, var, skew, kurt = stats.describe(vals)
                variances.append(var)
                means.append(mean)
                skews.append(skew)
                for val in vals:
                    print(val-mean)
            vals = []
        else:
            vals.append(float(line.split(' ')[1]))
    print
    print stats.describe(means)[2], stats.describe(variances)[2], stats.describe(skews)[2]


