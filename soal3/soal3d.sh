#!/bin/bash

name=$(date +"%m%d%Y")
zip -r Koleksi.zip ./Kucing_* ./Kelinci_* -P "$name"
rm -r Kucing_* 
rm -r Kelinci_*

