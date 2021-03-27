#!/bin/bash

for((i=1; i<24; i++))
do
  wget -a Foto.log https://loremflicker.com/320/240/kitten -O "Koleksi_$i.jpg"
  for((k=1; k<i; k++))
  do
    check=$(cmp Koleksi_$i.jpg Koleksi_$i.jpg)
    sama=$?
     if [ $sama -eq 1 ]
     then
        rm Koleksi_$i.jpg
        i=$(($i-1))
        break
     fi
  done
done

for((i=1; i<24; i++))
do
  if [ ! -f Koleksi_$i.jpg ];
  then
    for((j=23; j>1; j--))
    do
      if [ -f Koleksi_$i.jpg ];
      then
          mv Koleksi_$j.jpg Koleksi_$i.jpg
          break
      fi
    done
  fi
done

for((i=1; i<10; i++))
do
  if [ -f Koleksi_$i.jpg ]
  then
    mv Koleksi_$i.jpg Koleksi_0$i
  fi
done
