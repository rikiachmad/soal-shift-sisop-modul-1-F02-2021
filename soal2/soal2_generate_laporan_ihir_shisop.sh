#!/bin/bash

awk -F '\t' '

(NR>1){
	rowID = $1;

	sales = $18;
	salesDec = substr(sales, index(sales, ".")+1, length(sales));
	salesFix = sales * (10^(length(sales)-index(sales, "."))) + salesDec;
	salesFix = salesFix/(10^(length(sales)-index(sales, ".")));

	profit = $21;
	profitDec = substr(profit, index(profit, ".")+1, length(profit));
	profitFix = profit * (10^(length(profit)-index(profit, ".")-1)) + profitDec;
	profitFix = profitFix/(10^(length(profit)-index(profit, ".")-1));


	profitPercentage = (profitFix/(salesFix-profitFix))*100;

	if(profitPercentage >= curMaxPP){
		maxID = rowID;
		curMaxPP = profitPercentage;
		prf = profitFix;
		sls = salesFix;
	}
	print salesFix " " profitFix " " profitPercentage;
}
END{
	print maxID " " curMaxPP " " prf " " sls;
}' Laporan-TokoShiSop.tsv > hasil.txt
