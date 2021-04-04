# Laporan Praktikum Modul 1 Sistem Operasi

Kelompok E12 :
<li>05111840000138 - Gema Adi Perwira
<li>05111940000006 - Daffa Tristan Firdaus
<li>05111940000211 - VICKY THIRDIAN

**Soal 1** 
<br>Ryujin baru saja diterima sebagai IT support di perusahaan Bukapedia. Dia diberikan tugas untuk membuat laporan harian untuk aplikasi internal perusahaan, ticky. Terdapat 2 laporan yang harus dia buat, yaitu laporan daftar peringkat pesan error terbanyak yang dibuat oleh ticky dan laporan penggunaan user pada aplikasi ticky. Untuk membuat laporan tersebut, Ryujin harus melakukan beberapa hal berikut:

<br>(a) Mengumpulkan informasi dari log aplikasi yang terdapat pada file syslog.log. Informasi yang diperlukan antara lain: jenis log (ERROR/INFO), pesan log, dan username pada setiap baris lognya. Karena Ryujin merasa kesulitan jika harus memeriksa satu per satu baris secara manual, dia menggunakan regex untuk mempermudah pekerjaannya. Bantulah Ryujin membuat regex tersebut.

<br>(b) Kemudian, Ryujin harus menampilkan semua pesan error yang muncul beserta jumlah kemunculannya.

<br>(c) Ryujin juga harus dapat menampilkan jumlah kemunculan log ERROR dan INFO untuk setiap user-nya.
Setelah semua informasi yang diperlukan telah disiapkan, kini saatnya Ryujin menuliskan semua informasi tersebut ke dalam laporan dengan format file csv.

<br>(d) Semua informasi yang didapatkan pada poin b dituliskan ke dalam file error_message.csv dengan header Error,Count yang kemudian diikuti oleh daftar pesan error dan jumlah kemunculannya diurutkan berdasarkan jumlah kemunculan pesan error dari yang terbanyak.
Contoh:
```
Error,Count
Permission denied,5
File not found,3
Failed to connect to DB,2
```

<br>(e) Semua informasi yang didapatkan pada poin c dituliskan ke dalam file user_statistic.csv dengan header Username,INFO,ERROR diurutkan berdasarkan username secara ascending.
Contoh:
```
Username,INFO,ERROR
kaori02,6,0
kousei01,2,2
ryujin.1203,1,3
```
Catatan :
Setiap baris pada file syslog.log mengikuti pola berikut:
```
 <time> <hostname> <app_name>: <log_type> <log_message> (<username>)
 ```
Tidak boleh menggunakan AWK

**Pembahasan**
**Soal 1**
<br>(a) Untuk soal ini, hal yang harus dilakukan adalah mengumpulkan informasi dari file syslog.log, namun soal memintanya untuk memfilter informasi yang diperlukan menjadi (ERROR/INFO), pesan log, dan username. Oleh karena itu kita memakai perintah grep. Grep berguna untuk mencari pola dari suatu file sesuai pattern yang diberikan. 
![Screenshot_1](https://user-images.githubusercontent.com/42856438/113093936-0aecde80-921b-11eb-9799-2e8f5d27e886.jpg)
Setelah itu, maka outputnya adalah sebagai berikut: 
![Screenshot_3](https://user-images.githubusercontent.com/42856438/113094446-e2b1af80-921b-11eb-8e8e-da991be00a9f.jpg)

<br>(b dan d) Untuk soal b dan soal d ini saling berhubungan. Langkah pertama yang dilakukan adalah menamplikan "Error,Count" dan menyimpannya di file error_message.csv sekaligus membuat file tersebut. Setelah itu, kita melakukan perintah grep dengan pattern seperti screenshot dibawah ini. Lalu terkahir, hasilnya ditambahkan dan disimpan di file error_message.csv
![Screenshot_2](https://user-images.githubusercontent.com/42856438/113095232-49839880-921d-11eb-81f9-04812e81a19d.jpg)
Dan berikut adalah hasil akhir file error_message.csv:
<br>![Screenshot_4](https://user-images.githubusercontent.com/42856438/113095424-98c9c900-921d-11eb-9449-852d85c8a5a6.jpg)

<br>(c dan e) Untuk soal c dan soal e ini juga saling berhubungan. Langkah pertama yang dilakukan adalah menampilkan "Username,INFO,ERROR" dan menyimpannya di file user_statistic.csv. Setelah itu, kita mengetikkan kode ```error=$(grep -Po "(?<=ERROR ).*(?<=\))" syslog.log)```. Tujuannya adalah mendapatkan semua pesan yang bertipe error hingga akhir baris lalu disimpan di variabel error. Lalu kita ketik kode ```info=$(grep -Po "(?<=INFO ).*(?<=\))" syslog.log)```. Tujuannya adalah mendapatkan semua pesan yang bertipe info hingga akhir baris. Lalu untuk mendapatkan pattern username yang urut secara ascending, ketik kode ```grep -Po "(?<=\()(.*)(?=\))" syslog.log | sort | uniq```. Setelah itu kita melakukan loop ketika membaca user maka akan didapatkan baris yang telah difilter dari variabel info dan error dengan informasi yang ingin dicari adalah usernya, lalu menghitung total baris yg didapatkan. Untuk kode lengkapnya adalah sebagai berikut
<br>![Screenshot_10](https://user-images.githubusercontent.com/42856438/113426044-139d0a80-93fd-11eb-8868-eb0325a8ad69.jpg)
<br>Dan hasilnya adalah sebagai berikut
<br>![image](https://user-images.githubusercontent.com/42856438/113426148-3b8c6e00-93fd-11eb-9ba4-c945d92bce92.png)

**Soal 2** 
<br>Steven dan Manis mendirikan sebuah startup bernama “TokoShiSop”. Sedangkan kamu dan Clemong adalah karyawan pertama dari TokoShiSop. Setelah tiga tahun bekerja, Clemong diangkat menjadi manajer penjualan TokoShiSop, sedangkan kamu menjadi kepala gudang yang mengatur keluar masuknya barang.

Tiap tahunnya, TokoShiSop mengadakan Rapat Kerja yang membahas bagaimana hasil penjualan dan strategi kedepannya yang akan diterapkan. Kamu sudah sangat menyiapkan sangat matang untuk raker tahun ini. Tetapi tiba-tiba, Steven, Manis, dan Clemong meminta kamu untuk mencari beberapa kesimpulan dari data penjualan “Laporan-TokoShiSop.tsv”.

<br>(a) Steven ingin mengapresiasi kinerja karyawannya selama ini dengan mengetahui __Row ID__ dan __profit percentage terbesar__ (jika hasil profit percentage terbesar lebih dari 1, maka ambil Row ID yang paling besar). Karena kamu bingung, Clemong memberikan definisi dari profit percentage, yaitu:

__Profit Percentage__ = (Profit Cost Price) 100

Cost Price didapatkan dari pengurangan Sales dengan Profit. (__Quantity diabaikan__).

<br>(b) Clemong memiliki rencana promosi di Albuquerque menggunakan metode MLM. Oleh karena itu, Clemong membutuhkan daftar __nama customer pada transaksi tahun 2017 di Albuquerque__.

<br>(c) TokoShiSop berfokus tiga segment customer, antara lain: Home Office, Customer, dan Corporate. Clemong ingin meningkatkan penjualan pada segmen customer yang paling sedikit. Oleh karena itu, Clemong membutuhkan __segment customer__ dan __jumlah transaksinya yang paling sedikit__.

<br>(d) TokoShiSop membagi wilayah bagian (region) penjualan menjadi empat bagian, antara lain: Central, East, South, dan West. Manis ingin mencari __wilayah bagian (region) yang memiliki total keuntungan (profit) paling sedikit__ dan __total keuntungan wilayah tersebut__.

<br>(e) Agar mudah dibaca oleh Manis, Clemong, dan Steven, kamu diharapkan bisa membuat sebuah script yang akan menghasilkan file “hasil.txt” yang memiliki format sebagai berikut:
```
Transaksi terakhir dengan profit percentage terbesar yaitu *ID Transaksi* dengan persentase *Profit Percentage*%.

Daftar nama customer di Albuquerque pada tahun 2017 antara lain:
*Nama Customer1*
*Nama Customer2* dst

Tipe segmen customer yang penjualannya paling sedikit adalah *Tipe Segment* dengan *Total Transaksi* transaksi.

Wilayah bagian (region) yang memiliki total keuntungan (profit) yang paling sedikit adalah *Nama Region* dengan total keuntungan *Total Keuntungan (Profit)*
```
<br>Catatan:
<li>Gunakan bash, AWK, dan command pendukung
<li>Script pada poin (e) memiliki nama file ‘soal2_generate_laporan_ihir_shisop.sh’

**Pembahasan**
**Soal 2**
<br>Untuk pengerjaan soal ini, kita harus mengetahui bentuk dari data yang akan kita kelola. Karena data berbentuk tabel, maka akan digunakan command `-F` untuk field seperator input data. Selain itu, program awk akan membaca baris data selain dari baris paling atas yang terdiri dari jenis data pada setiap kolomnya. Dengan begitu, masalah tersebut dapat diatasi dengan menggunakan command `FNR == 1 {next}` pada setiap program awk yang akan dijalankan.

<br>(a) Pada soal ini, kita disuruh mencari __Row ID__ dan __profit percentage__ terbesar dari data tersebut. Program yang dijalankan adalah sebagai berikut:
```
awk -F "\t" -v m=0 -v id=0 'FNR == 1 {next} {if (($21/($18-$21))*100>=m) {m=($21/($18-$21))*100 ; id=$1}} END {print "Transaksi terakhir dengan profit percentage terbesar yaitu " id, "dengan persentase " m "%."}' Laporan-TokoShiSop.tsv
```
Dengan begitu akan menghasilkan:
```
Transaksi terakhir dengan profit percentage terbesar yaitu 9952 dengan persentase 100%.
```
Program ini menggunakan statement if yang akan menghitung profit percentage tiap baris data dan membandingkannya dengan data sebelumnya (jika perhitungan data baris pertama, maka akan automatis tergantikan variabelnya). Jika data tersebut lebih besar dari data sebelumnya, maka program akan menarik data __Row ID__ dan __profit percentage__ kepada variabel yang telah ditentukan. Akhirnya, program akan print sebuah kalimat yang akan menyajikan data yang telah diproses.

<br>(b) Soal ini menuntut kita untuk mencari daftar __nama customer pada transaksi tahun 2017 di Albuquerque__. Program yang dijalankan adalah sebagai berikut:
```
awk -F "\t" 'FNR == 1 {next} BEGIN{print "\nDaftar nama customer di Albuquerque pada tahun 2017 antara lain:"} /Albuquerque/ && /2017/ {seen[$7]++} END{for(x in seen) {print x}}' Laporan-TokoShiSop.tsv
```
Dengan begitu akan menghasilkan:
```
Daftar nama customer di Albuquerque pada tahun 2017 antara lain:
Benjamin Farhat
Michelle Lonsdale
Susan Vittorini
David Wiener
```
Dengan menggunakan command `/Albuquerque/ && /2017/`, program akan mencari data yang memiliki string Albuquerque dan 2017. Kita dapat menggunakan command tersebut karena pada kolom __City__ dan __Order ID__ terdapat string yang mengidentifikasi bahwa transaksi tersebut terdapat pada Albuquerque di tahun 2017. Lalu, untuk setiap data kita akan mengambil __nama customer__ dan memasukkannya kedalam array untuk menghapus data yang duplikat. Akhirnya, menggunakan loop for untuk print data-data yang ada di array. Soal ini dapat dikerjakan juga dengan menggunakan command `uniq` dan `sort`, tetapi karena data perlu disimpan kedalam variabel maka digunakan cara diatas.

<br>(c) Soal ini menyuruh kita untuk mencari __segment customer__ dan __jumlah transaksinya yang paling sedikit__. Program yang dijalankan adalah sebagai berikut:
```
awk -F "\t" -v w=NR 'FNR == 1 {next} {seen[$8]++} END{for(x in seen) {if(seen[x]<w){w=seen[x] ; v=x}} ; print "\nTipe segmen customer yang penjualannya paling sedikit adalah " v, "dengan " w, "transaksi."}' Laporan-TokoShiSop.tsv
```
Dengan begitu akan menghasilkan:
```
Tipe segmen customer yang penjualannya paling sedikit adalah Home Office dengan 1783 transaksi.
```
Serupa dengan pengerjaan soal bagian a dan b, tetapi soal ini menanyakan jumlah transaksi data yang paling sedikit dan menghilangkan data duplikat dengan menggunakan array.  Pernyataan if pada loop for yang digunakan akan berjalan jika data array lebih kecil dengan array sebelumnya maka akan menyimpan data array pada suatu variabel, dengan v adalah __segment customer__ dan w adalah __jumlah transaksi__ segment tersebut. Diawal program dinyatakan bahwa `w=NR` supaya pada pernyatan if pertama w akan menyimpan __jumlah transaksi__ dan v akan menyimpan __segment customer__.

<br>(d) Soal ini menyuruh kita untuk mencari __wilayah bagian (region) yang memiliki total keuntungan (profit) paling sedikit__ dan __total keuntungan wilayah tersebut__. Program yang dijalankan adalah sebagai berikut:
```
awk -F "\t" -v w=NR 'FNR == 1 {next} {seen[$13] += $21} END{for(x in seen) {if(seen[x]<w){w=seen[x] ; v=x}} ; print "\nWilayah bagian (region) yang memiliki total keuntungan (profit) yang paling sedikit adalah " v, "dengan total keuntungan " w}' Laporan-TokoShiSop.tsv
```
Dengan begitu akan menghasilkan:
```
Wilayah bagian (region) yang memiliki total keuntungan (profit) yang paling sedikit adalah Central dengan total keuntungan 39706.4
```
Pengerjaan soal ini serupa dengan soal bagian c, dengan perbedaan kita akan menghitung total keuntungan wilayah bagian dibanding pada soal bagian c kita mencari total dari data tersebut. Pada setiap kolom __Region__ yang sama, maka akan menambahkan nilai profit pada array region tersebut. Diawal program dinyatakan bahwa `w=NR` supaya pada pernyatan if pertama w akan menyimpan __total keuntungan__ dan v akan menyimpan __wilayah bagian tersebut__.

<br>(e) Pada soal ini supaya lebih mudah untuk dibaca, praktikan disuruh untuk membuat script file yang akan menghasilkan file `hasil.txt`. Caraya dengan menambahkan `>> hasil.txt` di akhir setiap program dan menggabungkannya di shell script file `soal2_generate_laporan_ihir_shisop.sh` sebagai berikut:
```

#!/bin/bash

#soal2a
awk -F "\t" -v m=0 -v id=0 'FNR == 1 {next} {if (($21/($18-$21))*100>=m) {m=($21/($18-$21))*100 ; id=$1}} END {print "Transaksi terakhir dengan profit percentage terbesar yaitu " id, "dengan persentase " m "%."}' Laporan-TokoShiSop.tsv >> hasil.txt

#soal2b
awk -F "\t" 'FNR == 1 {next} BEGIN{print "\nDaftar nama customer di Albuquerque pada tahun 2017 antara lain:"} /Albuquerque/ && /2017/ {seen[$7]++} END{for(x in seen) {print x}}' Laporan-TokoShiSop.tsv >> hasil.txt

#soal2c
awk -F "\t" -v w=NR 'FNR == 1 {next} {seen[$8]++} END{for(x in seen) {if(seen[x]<w){w=seen[x] ; v=x}} ; print "\nTipe segmen customer yang penjualannya paling sedikit adalah " v, "dengan " w, "transaksi."}' Laporan-TokoShiSop.tsv >> hasil.txt

#soal2d
awk -F "\t" -v w=NR 'FNR == 1 {next} {seen[$13] += $21} END{for(x in seen) {if(seen[x]<w){w=seen[x] ; v=x}} ; print "\nWilayah bagian (region) yang memiliki total keuntungan (profit) yang paling sedikit adalah " v, "dengan total keuntungan " w}' Laporan-TokoShiSop.tsv >> hasil.txt
```
Dan akan menghasilkan text file `hasil.txt`:
```
Transaksi terakhir dengan profit percentage terbesar yaitu 9952 dengan persentase 100%.

Daftar nama customer di Albuquerque pada tahun 2017 antara lain:
Benjamin Farhat
Michelle Lonsdale
Susan Vittorini
David Wiener

Tipe segmen customer yang penjualannya paling sedikit adalah Home Office dengan 1783 transaksi.

Wilayah bagian (region) yang memiliki total keuntungan (profit) yang paling sedikit adalah Central dengan total keuntungan 39706.4
```
