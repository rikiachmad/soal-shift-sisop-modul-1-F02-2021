# soal-shift-sisop-modul-1-F02-2021
###### Anggota Kelompok:
- Fika Nur Aini (05111940000067) @FikaNA
- Riki Mi'roj Achmad (05111940000093) @rikiachmad
- Achmad Akbar Irwanda	(05111940000138) @Irwanda04

## Nomor 1
## Nomor 2
File pada Laporan-TokoShiSop.tsv setiap kolom dipisahkan oleh `\t`, sehingga dapat menggunakan awk untuk memisahkan setiap nilainya. Hasil dari pemisahan itu dimulai dari $1 sampai $21, jadi `rowID = $1`, `orderDate = $3` dst. Namun karena baris pertama berisi header, maka cukup hitung mulai baris ke-2 dengan `(NR>1)`.
Setelah itu, ubah nilai sales dan profit karena jika tidak, maka hanya akan terambil nilai depannya saja (sebelum titik).
```
if(index(sales, ".")==0)
  salesFix = sales;
  
if(index(profit, ".")==0)
  profitFix = profit;
```
Untuk memastikan jika sales tidak memiliki nilai desimal di belakang titik, maka itulah yang menjadi nilai sebenarnya. Sedangkan jika memiliki titik:
```
salesDec = substr(sales, index(sales, ".")+1, length(sales));
salesFix = sales * (10^(length(sales)-index(sales, "."))) + salesDec;
salesFix = salesFix/(10^(length(sales)-index(sales, ".")));
if(substr(sales,1,3)=="-0.")
  salesFix = 0-salesFix;
```
`salesDec` mengambil nilai desimalnya saja dari `sales`. `salesFix` mengalikan nilai `sales` (karena hanya diambil angka sebelum titik) dengan 10 pangkat banyaknya digit belakang titik dan ditambahkan `salesDec`. Setelah ditambahkan, bagi dengan 10 pangkat sehingga nilai seperti yang diinginkan. Pada proses ini tentu saja terdapat kesalahan, yaitu ketika nilai dari `sales` adalah -0.---, sehingga menyebabkan menjadi bilangan positifnya. Dengan menggunakan  `if` terakhir, maka nilai fix dari `sales` dapat diselesaikan.
Begitu juga dengan cara yang sama untuk `profit`:
```
profitDec = substr(profit, index(profit, ".")+1, length(profit));
profitFix = profit * (10^(length(profit)-index(profit, ".")-1)) + profitDec;
profitFix = profitFix/(10^(length(profit)-index(profit, ".")-1));
if(substr(profit,1,3)=="-0.")
  profitFix = 0-profitFix;
```
Hanya saja karena `profit` juga menyertakan `\n` (tidak seperti `sales`), maka banyaknya pangkat 10 juga harus dikurangi 1.
### sub-soal a
Untuk menemukan profit percentage terbesar maka perlu untuk menghitung nilainya dan membandingkannya dengan yang lainnya.
```
profitPercentage = (profitFix/(salesFix-profitFix))*100;
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
regCount[region] += profitFix;
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
