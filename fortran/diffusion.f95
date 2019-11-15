program diffusion
    integer::maxsize, roomDimension
    integer::i, j, k
    real::diffusionCoefficient, speed, timestep, distance, dTerm, change, time, ratio, sumVal, maxVal, minVal
    character::partition
    real::cube(10, 10, 10), wall

    !take console input
    ! print *, "Enter the value of maxsize: "
    ! read *, maxsize
    maxsize = 10
    partition = "y"

    !initialize the room with zeros
    do i = 1, maxsize
        do j = 1, maxsize
            do k = 1, maxsize
                cube(i, j, k) = 0
            end do
        end do
    end do

    !create partition
    wall = -555.0
    if (partition .eq. "y") then
        k = floor(maxsize*0.5)
        do i = 1, maxsize
            do j = ceiling(maxsize*0.25), maxsize
                cube(i, j, k) = wall
            end do
        end do
    end if

    !setup constants
    roomDimension = 5
    diffusionCoefficient = 0.1750
    speed = 250.0
    timestep = (real(roomDimension)/speed)/real(maxsize)
    distance = real(roomDimension)/real(maxsize)
    dTerm = diffusionCoefficient * timestep/real(distance*distance)
    print *, diffusionCoefficient, speed, timestep, distance, dTerm

    !initialize first cell
    cube(1, 1, 1) = 1e21

    !keep track of time
    time = 0.0
    ratio = 0.0

    !until equilibrated
    do while (ratio < 0.99)
        !main loop
        do i = 1, maxsize
            do j = 1, maxsize
                do k = 1, maxsize
                    !check if partition
                    if (cube(i, j, k) .eq. wall) cycle

                    !repeat this for each cell face
                    10 if (k-1 .lt. 1) goto 20
                    if (cube(i, j, k-1) .eq. wall) goto 20
                    change = (cube(i, j, k) - cube(i, j, k-1))*dTerm
                    cube(i, j, k) = cube(i, j, k) - change
                    cube(i, j, k-1) = cube(i, j, k-1) + change
                    goto 100

                    20 if (k+1 .gt. maxsize) goto 30
                    if (cube(i, j, k+1) .eq. wall) goto 30
                    change = (cube(i, j, k) - cube(i, j, k+1))*dTerm
                    cube(i, j, k) = cube(i, j, k) - change
                    cube(i, j, k+1) = cube(i, j, k+1) + change
                    goto 100

                    30 if (j-1 .lt. 1) goto 40
                    if (cube(i, j-1, k) .eq. wall) goto 40
                    change = (cube(i, j, k) - cube(i, j-1, k))*dTerm
                    cube(i, j, k) = cube(i, j, k) - change
                    cube(i, j-1, k) = cube(i, j-1, k) + change
                    goto 100

                    40 if (j+1 .gt. maxsize) goto 50
                    if (cube(i, j+1, k) .eq. wall) goto 50
                    change = (cube(i, j, k) - cube(i, j+1, k))*dTerm
                    cube(i, j, k) = cube(i, j, k) - change
                    cube(i, j+1, k) = cube(i, j+1, k) + change
                    goto 100

                    50 if (i-1 .lt. 1) goto 60
                    if (cube(i-1, j, k) .eq. wall) goto 60
                    change = (cube(i, j, k) - cube(i-1, j, k))*dTerm
                    cube(i, j, k) = cube(i, j, k) - change
                    cube(i-1, j, k) = cube(i-1, j, k) + change
                    goto 100

                    60 if (i+1 .gt. maxsize) goto 100
                    if (cube(i+1, j, k) .eq. wall) goto 100
                    change = (cube(i, j, k) - cube(i+1, j, k))*dTerm
                    cube(i, j, k) = cube(i, j, k) - change
                    cube(i+1, j, k) = cube(i+1, j, k) + change

                    100 continue
                end do
            end do
        end do

        !update
        time = time + timestep
        sumVal = 0.0
        maxVal = cube(1, 1, 1)
        print *, maxVal
        minVal = cube(1, 1, 1)
        do i = 1, maxsize
            do j = 1, maxsize
                do k = 1, maxsize
                    if (cube(i, j, k) .eq. wall) cycle

                    maxVal = max(maxVal, cube(i, j, k));
                    minVal = min(minVal, cube(i, j, k));
                    sumVal = sumVal + cube(i, j, k);
                end do
            end do
        end do

        ratio = minVal/maxVal
        !print *, time, ratio, sumVal, maxVal, minVal
    end do

end program diffusion
