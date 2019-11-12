using System;

public class diffusion
{
    public static void Main(String[] args)
    {
        //take maxsize as console input
        Console.Write("Enter the value of maxsize: ");
        int maxsize = Int32.Parse(Console.ReadLine());

        //initialize the room with zeros
        double[, ,] cube = new double[maxsize, maxsize, maxsize];
        for(int i = 0; i < maxsize; i++)
        {
            for(int j = 0; j < maxsize; j++)
            {
                for(int k = 0; k < maxsize; k++)
                {
                    cube[i, j, k] = 0.0;
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
        cube[0, 0, 0] = 1.0e21;

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
                        //repeat this for each cell face
                        if(0 <= k-1 && k-1 < maxsize)
                        {
                            change = (cube[i, j, k] - cube[i, j, k-1])*dTerm;
                            cube[i, j, k] -= change;
                            cube[i, j, k-1] += change;
                        }

                        if(0 <= k+1 && k+1 < maxsize)
                        {
                            change = (cube[i, j, k] - cube[i, j, k+1])*dTerm;
                            cube[i, j, k] -= change;
                            cube[i, j, k+1] += change;
                        }

                        if(0 <= j-1 && j-1 < maxsize)
                        {
                            change = (cube[i, j, k] - cube[i, j-1, k])*dTerm;
                            cube[i, j, k] -= change;
                            cube[i, j-1, k] += change;
                        }

                        if(0 <= j+1 && j+1 < maxsize)
                        {
                            change = (cube[i, j, k] - cube[i, j+1, k])*dTerm;
                            cube[i, j, k] -= change;
                            cube[i, j+1, k] += change;
                        }

                        if(0 <= i-1 && i-1 < maxsize)
                        {
                            change = (cube[i, j, k] - cube[i-1, j, k])*dTerm;
                            cube[i, j, k] -= change;
                            cube[i-1, j, k] += change;
                        }

                        if(0 <= i+1 && i+1 < maxsize)
                        {
                            change = (cube[i, j, k] - cube[i+1, j, k])*dTerm;
                            cube[i, j, k] -= change;
                            cube[i+1, j, k] += change;
                        }
                    }
                }
            }

            //update
            time += timestep;
            double sumVal = 0.0;
            double maxVal = cube[0, 0, 0];
            double minVal = cube[0, 0, 0];
            for(int i = 0; i < maxsize; i++)
            {
                for(int j = 0; j < maxsize; j++)
                {
                    for(int k = 0; k < maxsize; k++)
                    {
                        maxVal = Math.Max(maxVal, cube[i, j, k]);
                        minVal = Math.Min(minVal, cube[i, j, k]);
                        sumVal += cube[i, j, k];
                    }
                }
            }

            ratio = minVal/maxVal;
            Console.WriteLine(String.Format("{0} {1} {2}", time, ratio, sumVal));
        }
        Console.WriteLine(String.Format("Box equilibrated in {0} seconds of simulated time", time));
    }
}
