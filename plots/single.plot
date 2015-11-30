set terminal pdf
if (!exists("fname")) fname="output.dat"

unset key 
set output fname.'.pdf'

plot fname.'.dat' using 1:2:3 with lines ls 1 lc palette
