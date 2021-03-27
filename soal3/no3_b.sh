#!/bin/bash

newfolder=$(date +"%d-%m-%Y")
mkdir "$newfolder"
bash ./no3_a.sh
mv ./Koleksi_* "./$newfolder"
mv ./foto.log "./$newfolder"
