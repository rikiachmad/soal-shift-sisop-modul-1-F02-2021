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
```
Untuk mengecek apakah terdapat yang sama atau tidak, kita dapat menggunakan perintah cmp. Jika gambar sama maka gambar tersebut akan terhapus menggunakan perintah rm dan program akan berhenti melakukan pengecekan ditandai dengan perintah break.
Kemudian, kita juga melakukan pengecekan apakah terdapat nama gambar yang tidak berurutan karena gambar yang sama telah dihapus. Oleh karena itu, kita akan merename file terakhir untuk mengisi urutan nomor yang hilang karena telah terhapus.
```
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
```
Langkah selanjutnya, kita perlu merename nama file koleksi 1-9 yang awalnya bernama Koleksi_1.jpg menjadi Koleksi_01.jpg. 
```
for((i=1; i<10; i++))
do
  if [ -f Koleksi_$i.jpg ]
  then
    mv Koleksi_$i.jpg Koleksi_0$i
  fi
done
```
Untuk mengubah nama file, dapat menggunakan perintah mv.

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
