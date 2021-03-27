#!/bin/bash
bash ./no3.sh
folder=$(date +”%d-%m-%Y”)
mkdir “$folder”
mv ./Koleksi_*./Foto.log “./$folder/”
