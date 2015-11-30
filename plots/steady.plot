set terminal pdf enhanced

set output 'steady_state.pdf'
#set xrange [0:]
#set yrange [0:]

set key bottom right
set xlabel 'A'
set ylabel '{/Symbol D}/Q'
set style fill transparent solid 0.5 noborder
last(f) = system("awk 'END{print $8}' ".f)

c=1
f(A) = (a*A)/(1+b*A**c)
fit f(x) "data_q100.out" using 6:($8/$5) via a,b

Qs = system("cut -f4 | sort -nu")
getFile(q) = system("awk '($4 == ".q."){print $0} ' data.out")
#files = 'data_q01.out data_q1.out data_q5.out data_q100.out'
#titles = 'Q=0.1 Q=1 Q=5 Q=100'
plot f(x) with line lc "black" lw 5 title sprintf("%.3fA/(1+%.3fA)", a,b,c) ,for [i=1:words(Qs)] getFile(word(Qs, i)) using 6:($8/$5) with points lc i title "Q=".word(Qs,i)
