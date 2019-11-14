program diffusion
    !take maxsize as console input
    integer::maxsize, roomDimension
    real::diffusionCoefficient, speed, timestep, distance, dTerm, change, time, ratio
    print *, "Enter the value of maxsize: "
    read *, maxsize

    !initialize the room with zeros
    real, dimension(maxsize, maxsize, maxsize)::cube

    !setup constants
    roomDimension = 5
    diffusionCoefficient = 0.175
    speed = 250.0
    timestep = (roomDimension/speed)/maxsize
    distance = roomDimension/maxsize
    dTerm = diffusionCoefficient * timestep/(distance*distance)

    !initialize first cell

    !keep track of time
    time = 0.0
    ratio = 0.0

end program diffusion
