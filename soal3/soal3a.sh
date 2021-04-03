#!/bin/bash

for((i=1; i<24; i++));
do
  wget -a Foto.log https://loremflicker.com/320/240/kitten -O "Koleksi_$i.jpg"
  for((k=1; k<i; k++));
  do
     if diff Koleksi_$k.jpg Koleksi_$i.jpg &> /dev/null;
     then
        rm Koleksi_$i.jpg
        break
     fi
  done
done

for((i=1; i<24; i++));
do
  if [ ! -f Koleksi_$i.jpg ];
  then
    for((k=23; k>1; k--))
    do
      if [ -f Koleksi_$k.jpg ];
      then
          mv Koleksi_$k.jpg Koleksi_$i.jpg
          break
      fi
    done
  fi
done

for((i=1; i<10; i++));
do
    mv Koleksi_$i.jpg Koleksi_0$i.jpg
done
