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

<br>(b dan d) Untuk soal b dan soal d ini saling berhubungan. Langkah pertama yang dilakukan adalah menulis "Error,Count" dan menyimpannya di file error_message.csv sekaligus membuat file tersebut. Setelah itu, kita melakukan perintah grep dengan pattern seperti screenshot dibawah ini. Lalu terkahir, hasilnya ditambahkan dan disimpan di file error_message.csv
![Screenshot_2](https://user-images.githubusercontent.com/42856438/113095232-49839880-921d-11eb-81f9-04812e81a19d.jpg)
Dan berikut adalah hasil akhir file error_message.csv
![Screenshot_4](https://user-images.githubusercontent.com/42856438/113095424-98c9c900-921d-11eb-9449-852d85c8a5a6.jpg)



