#!/bin/bash
bash ./no3.sh
folder=$(date +”%d-%m-%Y”)
mkdir “$folder”
mv *.jpg $folder
mv Foto.log $folder
