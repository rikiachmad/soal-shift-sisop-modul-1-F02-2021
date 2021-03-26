#!/bin/bash

awk -F '\t' '

(NR>1){
	rowID = $1;
	orderDate = $3;
	custName = $7;
	segment = $8;
	city = $10;
	region = $13;

	sales = $18;
	if(index(sales, ".")==0)
		salesFix = sales;
	else{
		salesDec = substr(sales, index(sales, ".")+1, length(sales));
		salesFix = sales * (10^(length(sales)-index(sales, "."))) + salesDec;
		salesFix = salesFix/(10^(length(sales)-index(sales, ".")));
		if(substr(sales,1,3)=="-0.")
			salesFix = 0-salesFix;
	}

	profit = $21;
	if(index(profit, ".")==0)
		profitFix = profit;
	else{
		profitDec = substr(profit, index(profit, ".")+1, length(profit));
		profitFix = profit * (10^(length(profit)-index(profit, ".")-1)) + profitDec;
		profitFix = profitFix/(10^(length(profit)-index(profit, ".")-1));
		if(substr(profit,1,3)=="-0.")
			profitFix = 0-profitFix;
	}
	profitPercentage = (profitFix/(salesFix-profitFix))*100;

	if(profitPercentage >= curMaxPP){
		maxID = rowID;
		curMaxPP = profitPercentage;
		print profitFix " " salesFix " " index(profit, ".");
	}

	if(city=="Albuquerque" && substr(orderDate, length(orderDate)-1, 2)=="17")
		cust[custName]++;

	segCount[segment]++;
	regCount[region] += profitFix;
}
END{
	print "Transaksi terakhir dengan profit percentage terbesar yaitu " maxID " dengan persentase " curMaxPP "%.\n";

	print "Daftar nama customer di Albuquerque pada tahun 2017 antara lain:"
	for(i in cust)
		print i;

	minSeg = 10000;
	for(i in segCount)
		if(segCount[i] < minSeg){
			minSeg = segCount[i];
			segType = i;
		}
	print "\nTipe segmen customer yang penjualannya paling sedikit adalah " segType " dengan " minSeg " transaksi.\n"
	
	minReg = 100000000;
	for(i in regCount)
		if(regCount[i] < minReg){
			minReg = regCount[i];
			regName = i;
		}
	print "\nWilayah bagian (region) yang memiliki total keuntungan (profit) yang paling sedikit adalah " regName " dengan total keuntungan " minReg "."
}' Laporan-TokoShiSop.tsv > hasil.txt
