#!/bin/bash

newfolder=$(date +"%d-%m-%Y")
mkdir "$newfolder"
bash /home/atenggen/sisop21/modul1/soal3a.sh
mv ./Koleksi_* "./$newfolder"
mv ./foto.log "./$newfolder"
