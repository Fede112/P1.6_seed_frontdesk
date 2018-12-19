set terminal png size 1500,600 enhanced font "Helvetica,20"
set output 'stripe_test.png'
set multiplot layout 1, 2 title ""

red = "#FF0000"; green = "#00FF00"; blue = "#0000FF"; skyblue = "#87CEEB";
set yrange [0:55000]
set style data histogram
set style histogram cluster gap 1
set style fill solid
set boxwidth 0.9
set xtics format ""
set grid ytics

set title "READING LUSTRE"
plot "read.dat"  using 2:xtic(1) title "1 OST" linecolor rgb red, \
            		'' using 3 title "2 OST" linecolor rgb blue, \
            		'' using 4 title "4 OST" linecolor rgb green, \

set yrange [0:1200]
set title "WRITING LUSTRE"
plot "write.dat"  using 2:xtic(1) title "1 OST" linecolor rgb red, \
            		'' using 3 title "2 OST" linecolor rgb blue, \
            		'' using 4 title "4 OST" linecolor rgb green, \
