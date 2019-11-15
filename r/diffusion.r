#take user input
maxsize = 10.0
partition = 'n'

#initialize the room with zeros
cube = array(0e0, c(maxsize, maxsize, maxsize))

#create partition
if(partition == 'y')
{
    k = floor(maxsize*0.5)
    for(i in 1:maxsize)
    {
        for(j in ceiling(maxsize*0.25):maxsize)
        {
            cube[i, j, k] = -555.0
        }
    }
}

#setup constantscd
diffusionCoefficient = 0.175
roomDimension = 5.0
speed = 250.0
timestep = (roomDimension/speed)/maxsize
distance = roomDimension/maxsize
dTerm = diffusionCoefficient * timestep/(distance*distance)

#initialize first cell
cube[1, 1, 1] = 1.0e21;

#keep track of time
time = 0.0
ratio = 0.0

#until equilibrated
while(ratio < 0.99)
{
    for(i in 1:maxsize)
    {
        for(j in 1:maxsize)
        {
            for(k in 1:maxsize)
            {
                #check if partition
                if(identical(cube[i, j, k], -555.0)){next}

                #repeat this for each cell face
                if(0 < k-1)
                {
                    if(!identical(cube[i, j, k-1], -555.0))
                    {
                        change = (cube[i, j, k] - cube[i, j, k-1])*dTerm
                        cube[i, j, k] = (cube[i, j, k] - change)
                        cube[i, j, k-1] = (cube[i, j, k-1] + change)
                    }
                }

                if(k+1 <= maxsize)
                {
                    if(!identical(cube[i, j, k+1], -555.0))
                    {
                        change = (cube[i, j, k] - cube[i, j, k+1])*dTerm
                        cube[i, j, k] = (cube[i, j, k] - change)
                        cube[i, j, k+1] = (cube[i, j, k+1] + change)
                    }
                }

                if(0 < j-1)
                {
                    if(!identical(cube[i, j-1, k], -555.0))
                    {
                        change = (cube[i, j, k] - cube[i, j-1, k])*dTerm
                        cube[i, j, k] = (cube[i, j, k] - change)
                        cube[i, j-1, k] = (cube[i, j-1, k] + change)
                    }
                }

                if(j+1 <= maxsize)
                {
                    if(!identical(cube[i, j+1, k], -555.0))
                    {
                        change = (cube[i, j, k] - cube[i, j+1, k])*dTerm
                        cube[i, j, k] = (cube[i, j, k] - change)
                        cube[i, j+1, k] = (cube[i, j+1, k] + change)
                    }
                }

                if(0 < i-1)
                {
                    if(!identical(cube[i-1, j, k], -555.0))
                    {
                        change = (cube[i, j, k] - cube[i-1, j, k])*dTerm
                        cube[i, j, k] = (cube[i, j, k] - change)
                        cube[i-1, j, k] = (cube[i-1, j, k] + change)
                    }
                }

                if(i+1 <= maxsize)
                {
                    if(!identical(cube[i+1, j, k], -555.0))
                    {
                        change = (cube[i, j, k] - cube[i+1, j, k])*dTerm
                        cube[i, j, k] = (cube[i, j, k] - change)
                        cube[i+1, j, k] = (cube[i+1, j, k] + change)
                    }
                }
            }
        }
    }

    #update
    time = time + timestep
    sumVal = 0.0
    maxVal = cube[1, 1, 1]
    minVal = cube[1, 1, 1]
    for(i in 1:maxsize)
    {
        for(j in 1:maxsize)
        {
            for(k in 1:maxsize)
            {
                if(!identical(cube[i, j, k], -555.0))
                {
                    maxVal = max(maxVal, cube[i, j, k]);
                    minVal = min(minVal, cube[i, j, k]);
                    sumVal = sumVal + cube[i, j, k];
                }
            }
        }
    }

    ratio = minVal/maxVal;
    #cat(sprintf("%f %f %f\n", time, ratio ,sumVal))
}

cat(sprintf("Box equilibrated in %f seconds of simulated time\n", time))
