set terminal pdf enhanced

set output 'velocity.pdf'
infile = "run.out"

A = system("awk '($6 >= 0){print $6}' ".infile." | sort -nu")
delta = system("awk '{print $8}' ".infile." | sort -nu")
deltaQ = system("awk '{print $8/$5}' ".infile." | sort -nu")
getA(d) = "< awk '($6 == ".d."){print $0} ' ".infile
getDelta(d) = "< awk '($8 == ".d."){print $0} ' ".infile." | sort -n -k 6"
#set xrange [0:]
#set yrange [0:]

set xlabel 'A'
set ylabel 'v'
set xrange [0:]
set key outside top right
plot for [i=1:words(delta)] getDelta(word(delta,i)) using 6:($12) with linespoints title "{/Symbol D}/Q=".word(deltaQ,i)

