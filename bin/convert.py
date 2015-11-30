#!/usr/bin/python

import math
import sys

def getDelta(A):
    a = 0.037
    b = 0.755
    c = 0.913
    return a*A/(1+b*A**c)

if __name__ == "__main__":
    if len(sys.argv) == 2:
        print getDelta(float(sys.argv[1]))
