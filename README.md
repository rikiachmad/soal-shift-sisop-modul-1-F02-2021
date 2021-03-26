# soal-shift-sisop-modul-1-F02-2021
###### Anggota Kelompok:
- Fika Nur Aini (05111940000067) @FikaNA
- Riki Mi'roj Achmad (05111940000093) @rikiachmad
- Achmad Akbar Irwanda	(05111940000138) @Irwanda04

## 1
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
Transaksi terakhir dengan profit percentage terbesar yaitu *ID Transaksi* dengan persentase *Profit Percentage*%.
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
