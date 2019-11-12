#!/usr/bin/python
from numpy import *

N = 500

A = zeros((N, N, N), dtype = float64)

for i in range(N):
    for j in range(N):
        for k in range(N):
            A[i, j, k] = i*N*N + j*N + k + 1
            A[i, j, k] *= 3.141592653589793238462643383279028841971

print "Last element is:", A[i, j, k]
