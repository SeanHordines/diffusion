#take maxsize as console input
print("Enter the value of maxsize: ")
maxsize = parse(Int16, readline())

#initialize the room with zeros
cube = zeros(maxsize, maxsize, maxsize)

#setup constants
diffusionCoefficient = 0.175
roomDimension = 5
speed = 250.0
timestep = (roomDimension/speed)/maxsize
distance = roomDimension/maxsize
dTerm = diffusionCoefficient * timestep/(distance*distance)


#initialize first cell
cube[1, 1, 1] = 1.0e21;

#keep track of time
time = 0.0;
ratio = 0.0;

#until equilibrated
while ratio <= 0.99
    for i = 1:maxsize
        for j = 1:maxsize
            for k = 1:maxsize
                #repeat this for each cell face
                if 1 <= k-1 && k-1 <= maxsize
                    change = (cube[i, j, k] - cube[i, j, k-1])*dTerm
                    cube[i, j, k] -= change
                    cube[i, j, k-1] += change
                end

                if 1 <= k+1 && k+1 <= maxsize
                    change = (cube[i, j, k] - cube[i, j, k+1])*dTerm
                    cube[i, j, k] -= change
                    cube[i, j, k+1] += change
                end

                if 1 <= j-1 && j-1 <= maxsize
                    change = (cube[i, j, k] - cube[i, j-1, k])*dTerm
                    cube[i, j, k] -= change
                    cube[i, j-1, k] += change
                end

                if 1 <= j+1 && j+1 <= maxsize
                    change = (cube[i, j, k] - cube[i, j+1, k])*dTerm
                    cube[i, j, k] -= change
                    cube[i, j+1, k] += change
                end

                if 1 <= i-1 && i-1 <= maxsize
                    change = (cube[i, j, k] - cube[i-1, j, k])*dTerm
                    cube[i, j, k] -= change
                    cube[i-1, j, k] += change
                end

                if 1 <= i+1 && i+1 <= maxsize
                    change = (cube[i, j, k] - cube[i+1, j, k])*dTerm
                    cube[i, j, k] -= change
                    cube[i+1, j, k] += change
                end
            end
        end
    end

    #update
    global time += timestep
    sumVal = 0.0
    maxVal = cube[1, 1, 1]
    minVal = cube[1, 1, 1]
    for i = 1:maxsize
        for j = 1:maxsize
            for k = 1:maxsize
                maxVal = max(maxVal, cube[i, j, k]);
                minVal = min(minVal, cube[i, j, k]);
                sumVal += cube[i, j, k];
            end
        end
    end
    global ratio = minVal/maxVal;
    println(time, " ", ratio, " ", sumVal)
end
println("Box equilibrated in ", time, " seconds of simulated time")
