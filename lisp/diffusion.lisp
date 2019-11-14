#!/usr/bin/sbcl --script

;take maxsize as console input
(write-string "Enter the value of maxsize: ")
(defvar maxsize)
(setq maxsize (read))
(princ maxsize)
