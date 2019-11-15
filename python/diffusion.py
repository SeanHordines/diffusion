from math import floor

#take console input
maxsize = int(input("Enter the value of maxsize: "))
partition = input("Partition? (y/n): ")

#initialize the room with zeros
cube = [[[0.0 for k in range(maxsize)] for j in range(maxsize)] for i in range(maxsize)]

#create partition
if(partition == "y"):
    for i in range(maxsize):
        for j in range(ceil(maxsize*0.25), maxsize):
            cube[i][j][floor(maxsize*.5)] = -555.0


#setup constants
diffusionCoefficient = 0.175
roomDimension = 5
speed = 250.0
timestep = (roomDimension/speed)/maxsize
distance = roomDimension/maxsize
dTerm = diffusionCoefficient * timestep/(distance*distance)

#initialize first cell
cube[0][0][0] = 1.0e21

#keep track of time
time = 0.0
ratio = 0.0

#until equilibrated
while(ratio < .99):
    #main loop
    for i in range(maxsize):
        for j in range(maxsize):
            for k in range(maxsize):
                #check if partition
                if(cube[i][j][k] == -555.0):
                    continue

                #repeat this for each cell face
                if(0 <= k-1 and k-1 < maxsize):
                    if(cube[i][j][k-1] != -555.0):
                        change = (cube[i][j][k] - cube[i][j][k-1])*dTerm
                        cube[i][j][k] -= change
                        cube[i][j][k-1] += change

                if(0 <= k+1 and k+1 < maxsize):
                    if(cube[i][j][k+1] != -555.0):
                        change = (cube[i][j][k] - cube[i][j][k+1])*dTerm
                        cube[i][j][k] -= change
                        cube[i][j][k+1] += change

                if(0 <= j-1 and j-1 < maxsize):
                    if(cube[i][j-1][k] != -555.0):
                        change = (cube[i][j][k] - cube[i][j-1][k])*dTerm
                        cube[i][j][k] -= change
                        cube[i][j-1][k] += change

                if(0 <= j+1 and j+1 < maxsize):
                    if(cube[i][j+1][k] != -555.0):
                        change = (cube[i][j][k] - cube[i][j+1][k])*dTerm
                        cube[i][j][k] -= change
                        cube[i][j+1][k] += change

                if(0 <= i-1 and i-1 < maxsize):
                    if(cube[i-1][j][k] != -555.0):
                        change = (cube[i][j][k] - cube[i-1][j][k])*dTerm
                        cube[i][j][k] -= change
                        cube[i-1][j][k] += change

                if(0 <= i+1 and i+1 < maxsize):
                    if(cube[i+1][j][k] != -555.0):
                        change = (cube[i][j][k] - cube[i+1][j][k])*dTerm
                        cube[i][j][k] -= change
                        cube[i+1][j][k] += change

    #update
    time += timestep
    sumVal = 0.0
    maxVal = cube[0][0][0]
    minVal = cube[0][0][0]
    for i in range(maxsize):
        for j in range(maxsize):
            for k in range(maxsize):
                if(cube[i][j][k] != -555.0):
                    maxVal = max(maxVal, cube[i][j][k])
                    minVal = min(minVal, cube[i][j][k])
                    sumVal += cube[i][j][k]

    ratio = minVal/maxVal

    #print(time, ratio, sumVal)

print("Box equilibrated in", time, "seconds of simulated time")
