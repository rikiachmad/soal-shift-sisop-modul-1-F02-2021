#!/bin/bash

awk -F '\t' '

(NR>1){
	rowID = $1;

	sales = $18;
	salesDec = substr(sales, index(sales, ".")+1, length(sales));
	salesFix = sales * (10^(length(sales)-index(sales, "."))) + salesDec;
	salesFix = salesFix/(10^(length(sales)-index(sales, ".")));
	if(substr(sales,1,3)=="-0.")
		salesFix = 0-salesFix;

	profit = $21;
	profitDec = substr(profit, index(profit, ".")+1, length(profit));
	profitFix = profit * (10^(length(profit)-index(profit, ".")-1)) + profitDec;
	profitFix = profitFix/(10^(length(profit)-index(profit, ".")-1));
	if(substr(profit,1,3)=="-0.")
		profitFix = 0-profitFix;

	profitPercentage = (profitFix/(salesFix-profitFix))*100;

	if(profitPercentage >= curMaxPP){
		maxID = rowID;
		curMaxPP = profitPercentage;
	}
}
END{
	print maxID " " curMaxPP;
}' Laporan-TokoShiSop.tsv > hasil.txt
