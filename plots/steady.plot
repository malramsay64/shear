set terminal pdf enhanced

set output 'steady_state.pdf'
#set xrange [0:]
#set yrange [0:]

set key bottom right
set xlabel 'A'
set ylabel '{/Symbol D}/Q'
set style fill transparent solid 0.5 noborder
last(f) = system("awk 'END{print $8}' ".f)
infile = 'data.out'

c=1
f(A) = (a*A)/(1+b*A**c)

Qs = system("cut -d' ' -f5 ".infile." | sort -nu | tr '\n' ' '")
getFile(q) = system("awk '($5 == ".q."){print $0} ' ".infile)
#files = 'data_q01.out data_q1.out data_q5.out data_q100.out'
#titles = 'Q=0.1 Q=1 Q=5 Q=100'

fit f(x) "< echo '".getFile(word(Qs,words(Qs)))."'" using 6:($8/$5) via a,b

plot f(x) with line lc "black" lw 5 title sprintf("%.4fA/(1+%.4fA)", a,b,c) ,\
    for [q in Qs] "< echo '".getFile(q)."'" using 6:($8/$5) with points ps 1.5 title "Q=".q
