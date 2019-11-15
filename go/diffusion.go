package main

import (
    "fmt"
    "math"
    )

func main(){
    //take console input
    fmt.Print("Enter the value of maxsize: ")
    var maxsize int
    _, err := fmt.Scanf("%d", &maxsize)
    fmt.Print("Partition? (y/n): ")
    var partition string
    _, err = fmt.Scanf("%s", &partition)
    _ = err

    //initialize the room with zeros
    cube := make([][][]float64, maxsize)
    for i := 0; i < maxsize; i++ {
        cube[i] = make([][]float64, maxsize)
        for j := 0; j < maxsize; j++ {
            cube[i][j] = make([]float64, maxsize)
            for k := 0; k < maxsize; k++ {
                cube[i][j][k] = 0.0
            }
        }
    }

    //create partition
    if partition == "y"{
        for i := 0; i < maxsize; i++ {
            for j := int(float64(maxsize)*0.25) + 1; j < maxsize; j++ {
                cube[i][j][int(float64(maxsize)*0.5)] = -555.0
            }
        }
    }

    //setup constants
    diffusionCoefficient := 0.175
    roomDimension := 5
    speed := 250.0
    timestep := (float64(roomDimension)/speed)/float64(maxsize)
    distance := float64(roomDimension)/float64(maxsize)
    dTerm := diffusionCoefficient * timestep/(distance*distance)

    //initialize first cell
    cube[0][0][0] = 1.0e21

    //keep track of time
    time := 0.0
    ratio := 0.0

    var change float64

    //until equilibrated
    for ratio < 0.99 {
        //main loop
        for i := 0; i < maxsize; i++ {
            for j := 0; j < maxsize; j++ {
                for k := 0; k < maxsize; k++ {
                    //check if partition
                    if cube[i][j][k] == -555.0 {
                        continue;
                    }

                    //repeat this for each cell face
                    if 0 <= k-1 && k-1 < maxsize {
                        if cube[i][j][k-1] != -555.0 {
                            change = (cube[i][j][k] - cube[i][j][k-1])*dTerm
                            cube[i][j][k] -= change
                            cube[i][j][k-1] += change
                        }
                    }

                    if 0 <= k+1 && k+1 < maxsize {
                        if cube[i][j][k+1] != -555.0 {
                            change = (cube[i][j][k] - cube[i][j][k+1])*dTerm
                            cube[i][j][k] -= change
                            cube[i][j][k+1] += change
                        }
                    }

                    if 0 <= j-1 && j-1 < maxsize {
                        if cube[i][j-1][k] != -555.0 {
                            change = (cube[i][j][k] - cube[i][j-1][k])*dTerm
                            cube[i][j][k] -= change
                            cube[i][j-1][k] += change
                        }
                    }

                    if 0 <= j+1 && j+1 < maxsize {
                        if cube[i][j+1][k] != -555.0 {
                            change = (cube[i][j][k] - cube[i][j+1][k])*dTerm
                            cube[i][j][k] -= change
                            cube[i][j+1][k] += change
                        }
                    }

                    if 0 <= i-1 && i-1 < maxsize {
                        if cube[i-1][j][k] != -555.0 {
                            change = (cube[i][j][k] - cube[i-1][j][k])*dTerm
                            cube[i][j][k] -= change
                            cube[i-1][j][k] += change
                        }
                    }

                    if 0 <= i+1 && i+1 < maxsize {
                        if cube[i+1][j][k] != -555.0 {
                            change = (cube[i][j][k] - cube[i+1][j][k])*dTerm
                            cube[i][j][k] -= change
                            cube[i+1][j][k] += change
                        }
                    }
                }
            }
        }

        //update
        time += timestep
        sumVal := 0.0
        maxVal := cube[0][0][0]
        minVal := cube[0][0][0]
        for i := 0; i < maxsize; i++ {
            for j := 0; j < maxsize; j++ {
                for k := 0; k < maxsize; k++ {
                    if cube[i][j][k] != -555.0 {
                        maxVal = math.Max(maxVal, cube[i][j][k]);
                        minVal = math.Min(minVal, cube[i][j][k]);
                        sumVal += cube[i][j][k];
                    }
                }
            }
        }
        ratio = minVal/maxVal;
        //fmt.Println(time, ratio, sumVal)
    }
    fmt.Println("Box equilibrated in", time, "seconds of simulated time")
}
