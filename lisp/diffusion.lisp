#!/usr/bin/sbcl --script

;take maxsize as console input
(pprint "Enter the value of maxsize: ")
(setq maxsize (read))
(write maxsize)
