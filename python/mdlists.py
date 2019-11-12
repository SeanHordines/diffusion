#!/usr/bin/python

N = 500

A = [[[0.0 for k in range(N)] for j in range(N)] for i in range(N)]

for i in range(N):
    for j in range(N):
        for k in range(N):
            A[i][j][k] = i*N*N + j*N + k + 1
            A[i][j][k] *= 3.141592653589793238462643383279028841971

print "Last element is:", A[N-1][N-1][N-1]
