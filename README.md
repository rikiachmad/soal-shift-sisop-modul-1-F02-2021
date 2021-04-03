# soal-shift-sisop-modul-1-F02-2021
###### Anggota Kelompok:
- Fika Nur Aini (05111940000067) @FikaNA
- Riki Mi'roj Achmad (05111940000093) @rikiachmad
- Achmad Akbar Irwanda	(05111940000138) @Irwanda04

## Nomor 1
Ryujin baru saja diterima sebagai IT support di perusahaan Bukapedia. Dia diberikan tugas untuk membuat laporan harian untuk aplikasi internal perusahaan, ticky. Terdapat 2 laporan yang harus dia buat, yaitu laporan daftar peringkat pesan error terbanyak yang dibuat oleh ticky dan laporan penggunaan user pada aplikasi ticky. Untuk membuat laporan tersebut, Ryujin harus melakukan beberapa hal berikut:
(a) Mengumpulkan informasi dari log aplikasi yang terdapat pada file syslog.log. Informasi yang diperlukan antara lain: jenis log (ERROR/INFO), pesan log, dan username pada setiap baris lognya. Karena Ryujin merasa kesulitan jika harus memeriksa satu per satu baris secara manual, dia menggunakan regex untuk mempermudah pekerjaannya. Bantulah Ryujin membuat regex tersebut.
(b) Kemudian, Ryujin harus menampilkan semua pesan error yang muncul beserta jumlah kemunculannya.
(c) Ryujin juga harus dapat menampilkan jumlah kemunculan log ERROR dan INFO untuk setiap user-nya.

Setelah semua informasi yang diperlukan telah disiapkan, kini saatnya Ryujin menuliskan semua informasi tersebut ke dalam laporan dengan format file csv.

(d) Semua informasi yang didapatkan pada poin b dituliskan ke dalam file error_message.csv dengan header Error,Count yang kemudian diikuti oleh daftar pesan error dan jumlah kemunculannya diurutkan berdasarkan jumlah kemunculan pesan error dari yang terbanyak.
Contoh:
Error,Count
Permission denied,5
File not found,3
Failed to connect to DB,2

(e) Semua informasi yang didapatkan pada poin c dituliskan ke dalam file user_statistic.csv dengan header Username,INFO,ERROR diurutkan berdasarkan username secara ascending.
Contoh:
Username,INFO,ERROR
kaori02,6,0
kousei01,2,2
ryujin.1203,1,3
Catatan :
-	Setiap baris pada file syslog.log mengikuti pola berikut:
 <time> <hostname> <app_name>: <log_type> <log_message> (<username>)

-	Tidak boleh menggunakan AWK

### Jawaban nomor 1
### sub-soal a
untuk sub soal a kita dapat menggunakan command regex sebagai berikut
```bash
reg="(INFO |ERROR )(.*)((?=[\(])(.*))"
grep1="(?<=ERROR )(.*)(?=\ )"
grep2="(?<=[(])(.*)(?=[)])"
grep3="(?=[(])(.*)(?<=[)])"
input="syslog.log";
echo grep -oP "$reg" "$input"

```
### sub-soal b
untuk mendapatkan jumlah error dan pesan error kita dapat menggunakan command regex sebagai berikut:
```bash
error=$(grep -oP "$grep1" "$input" | sort)
echo ERROR_MESSAGE
echo $error | uniq -c | sort -nr
```
### sub-soal c
Untuk mendapatkan jumlah error dan info untuk tiap-tiap usernya kita dapat menggunakan command sebagai berikut:
```bash
error=$(grep -oP "ERROR.*" "$input")
echo ERROR :
grep -oP "$grep2" <<< "$error" | sort | uniq -c
info=$(grep -oP "INFO.*" "$input")
echo INFO :
grep -oP "$grep2" <<< "$info" | sort | uniq -c
```
### sub-soal d
Lalu untuk sub-soal d, kita dapat mendapatkan jumlah error beserta isi pesan errornya dengan menggunakan command
```bash
string="`grep -o 'ERROR.*' error.log | cut -f2- -d ' ' | sort | uniq -c | sort -nr`"
```
dan memasukkannya kedalam variabel string.
Setelah didapatkan jumlah error beserta isi pesannya, kita dapat memanipulasi string tersebut sehingga dapat menuliskannya ke dalam file error_message.csv sesuai dengan format yang diinginkan dengan cara sebagai berikut.
```bash
echo "Error,Count" > error_message.csv
sed 's,([^(]*$,,' syslog.log > error.log

arr=($string)
count="${arr[0]}"

for((i=1; i<${#arr[@]}; i++))
do
  if ! [[ "${arr[$i]}" =~ ^[0-9]+$ ]]; then
    echo -n "${arr[$i]}" >> error_message.csv;
  if ! [[ "${arr[$(($i+1))]}" =~ ^[0-9]+$ ]] && [ $i -ne $((${#arr[@]}-1)) ]; then
    echo -n  " " >> error_message.csv
  fi
  else echo -n -e ",$count\n" >> error_message.csv
    count=${arr[$i]}
  fi
done
echo ",$count" >> error_message.csv
```
![soal 1d](https://user-images.githubusercontent.com/74702068/113478883-da74a100-94b5-11eb-9b9f-57fe5901bf10.png)

### sub-soal e
Dan untuk sub-soal yang terakhir ini, kita dapat mendapatkan total jumlah user dengan menggunakan command
```bash
user=`grep -o "ERROR.*\|INFO.*" syslog.log | cut -f2- -d '(' | sed 's/)$//' | sort | uniq`
```
Lalu dilakukan loop sebanyak total user yang tersedia di dalam array dan untuk tiap usernya kita dapatkan jumlah INFO dan ERROR nya lalu menuliskannya ke dalam file user_statistic.csv.
```bash
echo "USERNAME,INFO,ERROR" > user_statistic.csv

##soal 1e
data=($user)
for ((i=0; i<${#data[@]}; i++))
do
  error=`grep -c "ERROR.*(${data[$i]})" syslog.log`
  info=`grep -c "INFO.*(${data[$i]})" syslog.log`
  echo -n  "${data[$i]}," >> user_statistic.csv
  echo -n "$info," >> user_statistic.csv
  echo "$error" >> user_statistic.csv
  echo "${data[$i]} "
  ##soal1c
  echo "info: $info"
  echo -e "error: $error\n"
done
```
![soal 1e](https://user-images.githubusercontent.com/74702068/113478892-e1031880-94b5-11eb-80f9-9ad7ebab83b5.png)

## Nomor 2
Steven dan Manis mendirikan sebuah startup bernama “TokoShiSop”. Sedangkan kamu dan Clemong adalah karyawan pertama dari TokoShiSop. Setelah tiga tahun bekerja, Clemong diangkat menjadi manajer penjualan TokoShiSop, sedangkan kamu menjadi kepala gudang yang mengatur keluar masuknya barang. 
Tiap tahunnya, TokoShiSop mengadakan Rapat Kerja yang membahas bagaimana hasil penjualan dan strategi kedepannya yang akan diterapkan. Kamu sudah sangat menyiapkan sangat matang untuk raker tahun ini. Tetapi tiba-tiba, Steven, Manis, dan Clemong meminta kamu untuk mencari beberapa kesimpulan dari data penjualan “Laporan-TokoShiSop.tsv”.

(a) Steven ingin mengapresiasi kinerja karyawannya selama ini dengan mengetahui Row ID dan profit percentage terbesar (jika hasil profit percentage terbesar lebih dari 1, maka ambil Row ID yang paling besar). Karena kamu bingung, Clemong memberikan definisi dari profit percentage, yaitu:

Profit Percentage = (Profit ÷Cost Price) ×100

Cost Price didapatkan dari pengurangan Sales dengan Profit. (Quantity diabaikan).
	
(b) Clemong memiliki rencana promosi di Albuquerque menggunakan metode MLM. Oleh karena itu, Clemong membutuhkan daftar nama customer pada transaksi tahun 2017 di Albuquerque.
(c) TokoShiSop berfokus tiga segment customer, antara lain: Home Office, Customer, dan Corporate. Clemong ingin meningkatkan penjualan pada segmen customer yang paling sedikit. Oleh karena itu, Clemong membutuhkan segment customer dan jumlah transaksinya yang paling sedikit.
(d) TokoShiSop membagi wilayah bagian (region) penjualan menjadi empat bagian, antara lain: Central, East, South, dan West. Manis ingin mencari wilayah bagian (region) yang memiliki total keuntungan (profit) paling sedikit dan total keuntungan wilayah tersebut.

Agar mudah dibaca oleh Manis, Clemong, dan Steven, (e) kamu diharapkan bisa membuat sebuah script yang akan menghasilkan file “hasil.txt” yang memiliki format sebagai berikut:

Transaksi terakhir dengan profit percentage terbesar yaitu *ID Transaksi* dengan persentase *Profit Percentage*%.

Daftar nama customer di Albuquerque pada tahun 2017 antara lain:
*Nama Customer1*
*Nama Customer2* dst

Tipe segmen customer yang penjualannya paling sedikit adalah *Tipe Segment* dengan *Total Transaksi* transaksi.

Wilayah bagian (region) yang memiliki total keuntungan (profit) yang paling sedikit adalah *Nama Region* dengan total keuntungan *Total Keuntungan (Profit)*

      Catatan :
	Gunakan bash, AWK, dan command pendukung
	Script pada poin (e) memiliki nama file ‘soal2_generate_laporan_ihir_shisop.sh’
### Jawaban nomor 2
File pada Laporan-TokoShiSop.tsv setiap kolom dipisahkan oleh `\t`, sehingga dapat menggunakan awk untuk memisahkan setiap nilainya. Hasil dari pemisahan itu dimulai dari $1 sampai $21, jadi `rowID = $1`, `orderDate = $3` dst. Namun karena baris pertama berisi header, maka cukup hitung mulai baris ke-2 dengan `(NR>1)`.
### sub-soal a
Untuk menemukan profit percentage terbesar maka perlu untuk menghitung nilainya dan membandingkannya dengan yang lainnya.
```
profitPercentage = (profit/(sales-profit))*100;
if(profitPercentage >= curMaxPP){
  maxID = rowID;
  curMaxPP = profitPercentage;
}
```
Seperti penjelasan pada soal bahwa `Profit Percentage = (profit/cost price)*100;`. Kemudian bandingkan dengan Profit Percentage terbesar dan simpan rowID dari record tersebut.
Setelah selesai, tulis pada hasil.txt.
```
Transaksi terakhir dengan profit percentage terbesar yaitu *maxID* dengan persentase *curMaxPP*%.
```
### sub-soal b
Untuk mendapatkan hasil yang dimaksud, filter kota untuk "Albuquerque" dan format pada `orderDate` menunjukkan bahwa 2 angka terakhir merupakan tahun dari pemesanan, sehingga untuk mendapatkan tahun 2017, cari tanggal dengan "17" sebagai 2 angka terakhir. Kemudian hasil tersebut dapat disimpan pada sebuah array dengan menggunakan nama customer sebagai index-nya.
```
if(city=="Albuquerque" && substr(orderDate, length(orderDate)-1, 2)=="17")
  cust[custName]++;
```
Simpan hasilnya pada hasil.txt dengan format:
```
Daftar nama customer di Albuquerque pada tahun 2017 antara lain:
*Nama Customer1*
*Nama Customer2* dst
```
Untuk mendapatkannya, gunakan print dan loop.
```
print "Daftar nama customer di Albuquerque pada tahun 2017 antara lain:"
for(i in cust)
  print i;
```
### sub-soal c
Untuk mendapatkan segment paling sedikit adalah dengan menghitung jumlah transaksi tiap segment, yaitu dengan
```
segCount[segment]++;
```
Kemudian bandingkan tiap segment untuk mendapatkan nilai minimal dan simpan juga tipe segment tersebut.
```
minSeg = 10000;
for(i in segCount)
  if(segCount[i] < minSeg){
    minSeg = segCount[i];
    segType = i;
  }
```
Setelah didapatkan, print dengan format
```
Tipe segmen customer yang penjualannya paling sedikit adalah *segType* dengan *minSeg* transaksi.
```
### sub-soal d
Penghasilan tiap region dapat disimpan pada array dan menjumlahkan setiap profit dari region tersebut.
```
regCount[region] += profit;
```
Kemudian bandingkan profit setiap region.
```
minReg = 100000000;
for(i in regCount)
  if(regCount[i] < minReg){
    minReg = regCount[i];
    regName = i;
  }
```
Cetak hasilnya pada hasil.txt dengan format:
```
Wilayah bagian (region) yang memiliki total keuntungan (profit) yang paling sedikit adalah *regName* dengan total keuntungan *minReg*
```
Ouput yang dihasilkan pada jawaban nomer 2 ditunjukkan pada gambar berikut:

<img width="398" alt="2praktikum1" src="https://user-images.githubusercontent.com/67305615/113475237-7eeae900-949e-11eb-8998-980ef1758146.PNG">

## Nomer 3
Kuuhaku adalah orang yang sangat suka mengoleksi foto-foto digital, namun Kuuhaku juga merupakan seorang yang pemalas sehingga ia tidak ingin repot-repot mencari foto, selain itu ia juga seorang pemalu, sehingga ia tidak ingin ada orang yang melihat koleksinya tersebut, sayangnya ia memiliki teman bernama Steven yang memiliki rasa kepo yang luar biasa. Kuuhaku pun memiliki ide agar Steven tidak bisa melihat koleksinya, serta untuk mempermudah hidupnya, yaitu dengan meminta bantuan kalian. Idenya adalah :

(a) Membuat script untuk mengunduh 23 gambar dari "https://loremflickr.com/320/240/kitten" serta menyimpan log-nya ke file "Foto.log". Karena gambar yang diunduh acak, ada kemungkinan gambar yang sama terunduh lebih dari sekali, oleh karena itu kalian harus menghapus gambar yang sama (tidak perlu mengunduh gambar lagi untuk menggantinya). Kemudian menyimpan gambar-gambar tersebut dengan nama "Koleksi_XX" dengan nomor yang berurutan tanpa ada nomor yang hilang (contoh : Koleksi_01, Koleksi_02, ...)
//mkdir Foto.log
wget https://loremflickr.com/320/240/kitten >> Foto.log

(b) Karena Kuuhaku malas untuk menjalankan script tersebut secara manual, ia juga meminta kalian untuk menjalankan script tersebut sehari sekali pada jam 8 malam untuk tanggal-tanggal tertentu setiap bulan, yaitu dari tanggal 1 tujuh hari sekali (1,8,...), serta dari tanggal 2 empat hari sekali(2,6,...). Supaya lebih rapi, gambar yang telah diunduh beserta log-nya, dipindahkan ke folder dengan nama tanggal unduhnya dengan format "DD-MM-YYYY" (contoh : "13-03-2023").

(c) Agar kuuhaku tidak bosan dengan gambar anak kucing, ia juga memintamu untuk mengunduh gambar kelinci dari "https://loremflickr.com/320/240/bunny". Kuuhaku memintamu mengunduh gambar kucing dan kelinci secara bergantian (yang pertama bebas. contoh : tanggal 30 kucing > tanggal 31 kelinci > tanggal 1 kucing > ... ). Untuk membedakan folder yang berisi gambar kucing dan gambar kelinci, nama folder diberi awalan "Kucing_" atau "Kelinci_" (contoh : "Kucing_13-03-2023").

(d) Untuk mengamankan koleksi Foto dari Steven, Kuuhaku memintamu untuk membuat script yang akan memindahkan seluruh folder ke zip yang diberi nama “Koleksi.zip” dan mengunci zip tersebut dengan password berupa tanggal saat ini dengan format "MMDDYYYY" (contoh : “03032003”).

(e) Karena kuuhaku hanya bertemu Steven pada saat kuliah saja, yaitu setiap hari kecuali sabtu dan minggu, dari jam 7 pagi sampai 6 sore, ia memintamu untuk membuat koleksinya ter-zip saat kuliah saja, selain dari waktu yang disebutkan, ia ingin koleksinya ter-unzip dan tidak ada file zip sama sekali.

Catatan :
-	Gunakan bash, AWK, dan command pendukung
-	Tuliskan semua cron yang kalian pakai ke file cron3[b/e].tab yang sesuai
### Jawaban nomer 3
### sub-soal a
Untuk mengunduh 23 gambar dari "https://loremflickr.com/320/240/kitten" serta menyimpan log-nya ke file "Foto.log" dapat menggunakan kode berikut:
```
for((i=1; i<24; i++))
do
  wget -a Foto.log https://loremflicker.com/320/240/kitten -O "Koleksi_$i.jpg"
```
wget -a Foto.log agar log hasil download dapat tersimpan pada File.log, kemudian wget -O kita gunakan untuk merename nama file yang telah diunduh menjadi Koleksi_1.jpg, Koleksi_2.jpg, dst.
Karena gambar yang diunduh acak dan ada kemungkinan gambar yang sama terunduh lebih dari sekali maka kita perlu untuk mengecek apakah terdapat gambar yang sama pada gambar yang kita unduh. Jika terdapat gambar yang sama maka kita perlu menghapus gambar tersebut.
```
for((k=1; k<i; k++));
  do
     if diff Koleksi_$k.jpg Koleksi_$i.jpg &> /dev/null;
     then
        rm Koleksi_$i.jpg
        break
     fi
  done
```
Untuk mengecek apakah terdapat yang sama atau tidak, kita dapat menggunakan perintah diff. Jika gambar sama maka gambar tersebut akan terhapus menggunakan perintah rm dan program akan berhenti melakukan pengecekan ditandai dengan perintah break.
Kemudian, kita juga melakukan pengecekan apakah terdapat nama gambar yang tidak berurutan karena gambar yang sama telah dihapus. Oleh karena itu, kita akan merename file terakhir untuk mengisi urutan nomor yang hilang karena telah terhapus.
```
for((i=1; i<24; i++))
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
```
Langkah selanjutnya, kita perlu merename nama file koleksi 1-9 yang awalnya bernama Koleksi_1.jpg menjadi Koleksi_01.jpg. 
```
for((i=1; i<10; i++))
do
    mv Koleksi_$i.jpg Koleksi_0$i.jpg
done
```
Untuk mengubah nama file, dapat menggunakan perintah mv.
Jika program dieksekusi akan terunduh foto seperti gambar berikut:

<img width="398" alt="3a" src="https://user-images.githubusercontent.com/67305615/113474876-bd7fa400-949c-11eb-962d-53b0d65c4dff.PNG">

### sub-soal b
Memindahkan gambar yang telah diunduh beserta log-nya ke dalam folder yang bernama tanggal unduhnya dengan format "DD-MM-YYYY".
```
#!/bin/bash

bash ./no3.sh
folder=$(date +"%d-%m-%Y")
mkdir "$folder"
mv *.jpg $folder
mv Foto.log $folder
```
Langkah pertama, kita jalankan program 3a lebih dulu. Setelah itu buat variabel folder dengan format nama tanggal hari itu "DD-MM-YYYY". Lalu, buat folder menggunakan perintah mkdir. Terakhir, kita pindahkan gambar-gambar yang telah diunduh beserta file Foto.log kedalam folder baru tersebut menggunakan perintah mv.
Karena script tersebut akan dijalankan sehari sekali pada jam 8 malam untuk tanggal-tanggal tertentu setiap bulan, yaitu dari tanggal 1 tujuh hari sekali (1,8,...), serta dari tanggal 2 empat hari sekali(2,6,...). Maka, kita dapat crontab seperti berikut:
```
0 20 1-31/7,2-31/4 * * cd /home/fika/Praktikum1/shift3 && bash no3b.sh
```
Script diatas bertujuan untuk menjalankan atau mengeksekusi script no3b.sh setiap sehari sekali pada jam 8 malam atau 20.00 untuk tanggal-tanggal tertentu setiap bulannya, yaitu dari tanggal 1 setiap tujuh hari sekali seperti tanggal 1,8,15,dst, serta dari tanggal 2 setiap empat hari sekali seperti 2,6,10,dst. Nantinya folder hasil eksekusi akan tersimpan dalam folder shift3.
Ketika sub-soal b dieksekusi akan terbentuk folder seperti gambar berikut:

<img width="398" alt="3b" src="https://user-images.githubusercontent.com/67305615/113427088-a4c0b100-93fe-11eb-9602-230a680fef66.PNG">

Adapun isi folder tersebut sebagi berikut:

<img width="397" alt="3b isi folder" src="https://user-images.githubusercontent.com/67305615/113427122-b43ffa00-93fe-11eb-9358-eaf430e4a4f1.PNG">

Jumlah foto sebanyak 21 menandakan bahwa terdapat 2 foto yang sama, sehingga 2 foto tersebut akan otomatis terhapus.

### sub-soal c
Untuk sub-soal c perintah nya hampir mirip dengan sub-soal a, jadi disini kita dapat menggunakan kembali source code pada soal a namun dimodifikasi agar dapat memenuhi permintaan soal.
Perintah untuk sub soal c ini adalah mengunduh gambar kelinci apabila telah diunduh gambar kucing, dan kembali mengunduh gambar kucing apabila telah mengunduh gambar kelinci.
Untuk penyelesaian soal ini dapat menggunakan metode sebagai berikut:
Langkah pertama adalah mengambil jumlah folder kucing dan kelinci dengan menggunakan command regex dan memasukkannya ke dalam variable
```bash
cekKucing=$(ls | grep -e "Kucing.*" | wc -l)
cekKelinci=$(ls | grep -e "Kelinci.*" | wc -l)
```
setelah didapatkan jumlah folder kelinci dan kucing, keduanya dibandingkan, apabila jumlah folder kucing sama dengan folder kelinci, maka yang akan di unduh adalah gambar kucing
```bash
if [[ $cekKucing -eq $cekKelinci ]] ; then 
for((i=1; i<24; i++))
do
  wget -O "Koleksi_$i.jpg" -a Foto.log https://loremflickr.com/320/240/kitten
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
    mv Koleksi_$i.jpg Koleksi_0$i.jpg
  fi
done

 folder=$(date +"%m-%d-%Y")
 mkdir "Kucing_$folder"
 mv ./Koleksi_* ./Foto.log "./Kucing_$folder/"
```
dan apabila jumlah folder kucing lebih banyak dari folder kelinci, maka yang diunduh selanjutnya adalah gambar kelinci
```bash
else
for((i=1; i<24; i++))
do
  wget -a Foto.log https://loremflickr.com/320/240/bunny -O "Koleksi_$i.jpg"
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
folder=$(date +"%m-%d-%Y")
 mkdir "Kelinci_$folder"
 mv ./Koleksi_* ./Foto.log "./Kelinci_$folder/"
fi
```
<img width="398" alt="3a" src="https://user-images.githubusercontent.com/74702068/113481681-0ba89d80-94c5-11eb-9c05-36b2dc0401d4.png">

dengan begitu, maka gambar kucing dan kelinci akan diunduh secara bergantian.
### sub-soal d
Untuk soal d diminta untuk memindahkan folder-folder yang telah diunduh dan di zip dengan password sesuai dengan tanggal saat ini.
```bash
name=$(date +"%m%d%Y")
zip -r Koleksi.zip ./Kucing_* ./Kelinci_* -P "$name"
rm -r Kucing_* 
rm -r Kelinci_*
```
<img width="398" alt="3a" src="https://user-images.githubusercontent.com/74702068/113481682-0f3c2480-94c5-11eb-8d6a-a83b6c232018.png">

### sub-soal e
Dan untuk sub soal yang terakhir ini, diminta untuk membuat crontab untuk melakukan zip pada saat jam kuliah dan unzip diluar jam kuliah sesuai perintah soal.
```bash
#saat kuliah
0 7 * * 1-5 cd /home/riki/Praktikum1/ && bash "soal3d.sh"

#unzip
0 18 * * 1-5 cd /home/riki/Praktikum1/ && unzip -P $(date +"\%m\%d\%Y") Koleksi.zip && rm "Koleksi.zip"
```
<img width="398" alt="3a" src="https://user-images.githubusercontent.com/74702068/113481685-12371500-94c5-11eb-887c-e4f8262727c3.png">
