#!/usr/bin/python

import math
import fileinput
from scipy import stats

vals = []
means = []
variances = []
skews = []

if __name__ == "__main__":
    for line in fileinput.input():
        if line.isspace():
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


