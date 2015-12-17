set terminal pdf enhanced

infiles=system('ls *.dat')
nLines(f) = system("grep -cvP '\\S' ".f)
getA(f) = system("echo ".f." | cut -d- -f6")

getHist(f) = "< hist.py ".f." | head -n -2"
getStats(f) = system("hist.py ".f." | tail -n 1")

binwidth=1e-5
binstart=-1e-3
bin(x,width)=width*floor(x/width)

set boxwidth binwidth 
set style fill solid 0.5

hist = 'u (binwidth*(floor(($1-binstart)/binwidth)+0.5)+binstart):(1.0) smooth freq w boxes'

#set yrange [0:0.06]
set xrange [-3e-4:3e-4]
set style fill transparent solid 0.2
set xlabel "Deviation from Mean"
set ylabel "Frequency"
set output "dists.pdf"
do for [inf in infiles] {
    print inf
    plot getHist(inf) @hist title "A=".getA(inf) 
    }

set output "stats.pdf"
stats = ''
do for [inf in infiles]{
    stats = stats.getA(inf)." ".getStats(inf)."\n"
}

unset yrange
unset xrange
unset key
set format y "%g"
set xlabel 'A'
set ylabel "Variance"
plot "< echo '".stats."'" using 1:3 ps 2 pt 2

set xlabel 'A'
set ylabel "Skewness"
plot "< echo '".stats."'" using 1:4 ps 2 pt 2

