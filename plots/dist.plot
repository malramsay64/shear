set terminal pdf enhanced

infiles=system('ls *.dat | head -n 8')
nLines(f) = system("grep -cvP '\\S' ".f)
getMean(f) = system("mean.py ".f." | tail -n 1")
getVar(f) = system("var.py ".f." | tail -n 1")
getA(f) = system("echo ".f." | cut -d- -f6")

getHist(f) = system("hist.py ".f." | head -n -2")
getStats(f) = system("hist.py ".f." | tail -n 1")

binwidth=1e-9
bin(x,width)=width*floor(x/width)

set yrange [0:0.06]
set xrange [-1e-7:1e-7]
set style fill transparent solid 0.2
set xlabel "Deviation from Mean"
set ylabel "Frequency"
set output "dists.pdf"
do for [i=1:words(infiles)] {
    plot "< echo '".getHist(word(infiles,i))."'" using (bin($1, binwidth)):(1.0/(20*200)) smooth freq with boxes title "A=".getA(word(infiles,i))
}

set output "stats.pdf"
stats = ''
do for [i=1:words(infiles)]{
    stats = stats.getA(word(infiles,i))." ".getStats(word(infiles,i))."\n"
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

