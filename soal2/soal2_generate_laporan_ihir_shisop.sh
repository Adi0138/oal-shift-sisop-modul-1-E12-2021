#!/bin/bash

#soal2a
awk -F "\t" -v m=0 -v id=0 'FNR == 1 {next} {if (($21/($18-$21))*100>=m) {m=($21/($18-$21))*100 ; id=$1}} END {print "Transaksi terakhir dengan profit percentage terbesar yaitu " id, "dengan persentase " m "%."}' Laporan-TokoShiSop.tsv >> hasil.txt

#soal2b
awk -F "\t" 'FNR == 1 {next} BEGIN{print "\nDaftar nama customer di Albuquerque pada tahun 2017 antara lain:"} /Albuquerque/ && /2017/ {seen[$7]++} END{for(x in seen) {print x}}' Laporan-TokoShiSop.tsv >> hasil.txt

#soal2c
awk -F "\t" -v w=NR 'FNR == 1 {next} {seen[$8]++} END{for(x in seen) {if(seen[x]<w){w=seen[x] ; v=x}} ; print "\nTipe segmen customer yang penjualannya paling sedikit adalah " v, "dengan " w, "transaksi."}' Laporan-TokoShiSop.tsv >> hasil.txt

#soal2d
awk -F "\t" -v w=NR 'FNR == 1 {next} {seen[$13] += $21} END{for(x in seen) {if(seen[x]<w){w=seen[x] ; v=x}} ; print "\nWilayah bagian (region) yang memiliki total keuntungan (profit) yang paling sedikit adalah " v, "dengan total keuntungan " w}' Laporan-TokoShiSop.tsv >> hasil.txt
