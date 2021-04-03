#1a
grep -Po "[INFO|ERROR][^\n]*" syslog.log 
# -P berguna untuk melakukan filter dengan command Perl
# -o berguna untuk menampilkan text yg telah difilter
# regex berguna untuk memfilter baris yang punya kalimat INFO atau ERROR dimana baris tersebut akan diget hingga terdapat \n

#1bd
echo "Error,Count" > error_message.csv
grep -Zo "ERROR .* [^\(]*" syslog.log | cut -c 7- | sort | uniq -c | sort -snr | while read count word; do echo "$word, $count" >> error_message.csv; done
# echo adalah untuk menulis "Error,Count" ke dalam error_message.csv sekaligus membuat file tersebut
# Jan 31 03:05:35 ubuntu.local ticky: ERROR Timeout while retrieving information (ahmed.miller)
# -Z untuk melakukam filter dengan menampilkan regex dimana regexnya mencari pattern ERROR hinggga akhir baris namun tanda  [^\(]* berguna untuk membatasi hingga tanda "(".
# hasilnya ERROR Timeout while retrieving information 
# pada hasil kita ingin menhapus ERROR sehingga menggunakan perintah cut -c 7-, gunanya untuk menghapus 7 karakter awal
# hasilnya Timeout while retrieving information 
# sort untuk mengurutkan sesuai abjad
# uniq -c berguna untuk mengelompokkan sekaligus menghitung baris baris yang isinya sama
# sort -snr berguna untuk mengurutkan dari jumlah count paling sedikit, lalu di reverse dengan -r sehingga hasilnya urut dari count terbanyak
# 15 Timeout while retrieving information 
# while read count word  meloop hasil lalu variabel count berupa "15" lalu variabel word menampung kalimat "Timeout while retrieving information "
# variabel tersebut yaitu word dan count akan digabungkan ke dalam file error_message.csv

#1ce
error=$(grep -Po "(?<=ERROR ).*(?<=\))" syslog.log) #mendapatkan semua pesan yang bertipe error hingga akhir baris
info=$(grep -Po "(?<=INFO ).*(?<=\))" syslog.log) #mendapatkan semua pesan yang bertipe info hingga akhir baris
echo "Username,INFO,ERROR" > user_statistic.csv

grep -Po "(?<=\()(.*)(?=\))" syslog.log | sort | uniq | while read user; 
do
    all_info=$(grep "$user" <<< "$info" | wc -l); 
    #mendapatkan baris yang telah difilter dari variabel info dengan informasi yang ingin dicari adalah usernya, lalu menghitung total baris yg didapatkan
    all_error=$(grep "$user" <<< "$error" | wc -l); 
    #mendapatkan baris yang telah difilter dari variabel error dengan informasi yang ingin dicari adalah usernya, lalu menghitung total baris yg didapatkan
    echo "$user, $all_info, $all_error" >> user_statistic.csv;
done