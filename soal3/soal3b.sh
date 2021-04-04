#!/bin/bash

newfolder=$(date +"%d-%m-%Y")
mkdir "$newfolder"
bash ./soal3a.sh
mv ./Koleksi_* "./$newfolder"
mv ./foto.log "./$newfolder"
