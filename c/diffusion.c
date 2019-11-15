#include <stdio.h>
#include <math.h>

int main()
{
    //take console input
    int maxsize;
    char partition;
    printf("Enter the value of maxsize: ");
    scanf("%d", &maxsize);
    scanf("%c", &partition);
    printf("Partition? (y/n): ");
    scanf("%c", &partition);

    //initialize the room with zeros
    double cube[maxsize][maxsize][maxsize];
    for(int i = 0; i < maxsize; i++)
    {
        for(int j = 0; j < maxsize; j++)
        {
            for(int k = 0; k < maxsize; k++)
            {
                cube[i][j][k] = 0.0;
            }
        }
    }

    //create partition
    if(partition == 'y')
    {
        for(int i = 0; i < maxsize; i++)
        {
            for(int j = (int) (maxsize*0.25) + 1; j < maxsize; j++)
            {
                    cube[i][j][(int) (maxsize*0.5)] = -555.0;
            }
        }
    }

    //setup constants
    double diffusionCoefficient = 0.175;
    int roomDimension = 5;
    double speed = 250.0;
    double timestep = (roomDimension/speed)/((double) maxsize);
    double distance = roomDimension/((double) maxsize);
    double dTerm = diffusionCoefficient * timestep/(distance*distance);
    double change;

    //initialize first cell
    cube[0][0][0] = 1.0e21;

    //keep track of time
    double time = 0.0;
    double ratio = 0.0;

    //until equilibrated
    while(ratio < 0.99)
    {
        //main loop
        for(int i = 0; i < maxsize; i++)
        {
            for(int j = 0; j < maxsize; j++)
            {
                for(int k = 0; k < maxsize; k++)
                {
                    //check if partition
                    if(cube[i][j][k] == -555.0)
                    {
                        continue;
                    }

                    //repeat this for each cell face
                    if(0 <= k-1 && k-1 < maxsize)
                    {
                        if(cube[i][j][k-1] != -555.0)
                        {
                            change = (cube[i][j][k] - cube[i][j][k-1])*dTerm;
                            cube[i][j][k] -= change;
                            cube[i][j][k-1] += change;
                        }
                    }

                    if(0 <= k+1 && k+1 < maxsize)
                    {
                        if(cube[i][j][k+1] != -555.0)
                        {
                            change = (cube[i][j][k] - cube[i][j][k+1])*dTerm;
                            cube[i][j][k] -= change;
                            cube[i][j][k+1] += change;
                        }
                    }

                    if(0 <= j-1 && j-1 < maxsize)
                    {
                        if(cube[i][j-1][k] != -555.0)
                        {
                            change = (cube[i][j][k] - cube[i][j-1][k])*dTerm;
                            cube[i][j][k] -= change;
                            cube[i][j-1][k] += change;
                        }
                    }

                    if(0 <= j+1 && j+1 < maxsize)
                    {
                        if(cube[i][j+1][k] != -555.0)
                        {
                            change = (cube[i][j][k] - cube[i][j+1][k])*dTerm;
                            cube[i][j][k] -= change;
                            cube[i][j+1][k] += change;
                        }
                    }

                    if(0 <= i-1 && i-1 < maxsize)
                    {
                        if(cube[i-1][j][k] != -555.0)
                        {
                            change = (cube[i][j][k] - cube[i-1][j][k])*dTerm;
                            cube[i][j][k] -= change;
                            cube[i-1][j][k] += change;
                        }
                    }

                    if(0 <= i+1 && i+1 < maxsize)
                    {
                        if(cube[i+1][j][k] != -555.0)
                        {
                            change = (cube[i][j][k] - cube[i+1][j][k])*dTerm;
                            cube[i][j][k] -= change;
                            cube[i+1][j][k] += change;
                        }
                    }
                }
            }
        }

        //update
        time += timestep;
        double sumVal = 0.0;
        double maxVal = cube[0][0][0];
        double minVal = cube[0][0][0];
        for(int i = 0; i < maxsize; i++)
        {
            for(int j = 0; j < maxsize; j++)
            {
                for(int k = 0; k < maxsize; k++)
                {
                    if(cube[i][j][k] != -555.0)
                    {
                        maxVal = fmax(maxVal, cube[i][j][k]);
                        minVal = fmin(minVal, cube[i][j][k]);
                        sumVal += cube[i][j][k];
                    }
                }
            }
        }

        ratio = minVal/maxVal;
        //printf("%f %f %E\n", time, ratio, sumVal);
    }
    printf("Box equilibrated in %f seconds of simulated time\n", time);
    return 0;
}
