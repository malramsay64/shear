set terminal pdf 

set datafile missing "nan -nan"


infile = 'run.out'
totalTime(dt, n)="< awk '($3 == ".dt." && $1 == ".n." && $7 > -1){print $0}' ".infile
totalTimes(dt)="< awk '($3 == ".dt."){print $0}' ".infile

dts = "5e-07 1e-07"
sizes = "100 200 1000"
normalise(a, b, c) = a
set style fill transparent solid 0.5 noborder

set xlabel "{/Symbol D}t/{/Symbol D}x^2"
set ylabel "{/Symbol D}_{inf}"
set output 'dxdt.pdf'
#set logscale x
#set yrange[0:0.5]
plot for [t in dts] totalTimes(t) using ($2/$3**2):8 with points title "{/Symbol D}t=".t

#set yrange [-0.02:0.1]
unset xrange
set xlabel "total time"
set ylabel "{/Symbol D}"
#set logscale x
do for [s in sizes] {
    set output "stab-".s.".pdf"
    set title "N=".s.", {/Symbol D}x=1/".s.", A=0.5"
    #plot for [t in dts] totalTime(t, s) using 4:(normalise($7,$2,$3)):(normalise($9,$2,$3)) with filledcurves  notitle#,\
#        for [t in dts] totalTime(t,s) using 4:(normalise($8,$2,$3)) with lines lw 3 title "{/Symbol D}t = ".t
}
