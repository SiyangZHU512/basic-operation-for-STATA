/*merge：horizontal direction*/
sysuse auto.dta,clear
keep if _n <=7

preserve
keep make price mpg
list, clean noobs
save d1.dta,replace 
restore 

preserve
keep make weight length
list, clean noobs
save d2.dta,replace 
restore

use d1.dta,clear
merge 1:1 make using d2.dta
keep if _merge==3  /*succeed*/
drop _merge   /*other fail*/
list,clean noobs

/*append: vertical*/
clear all
sysuse auto.dta,clear
keep if _n <=7

preserve
keep make price mpg
list, clean noobs
save d1.dta,replace 
restore 

preserve
keep make weight length
list, clean noobs
save d2.dta,replace 
restore

use d1.dta,clear
append using d2.dta
list,clean noobs

/*reclink*/
clear
input str13 name str14 city
      "Zhang ziye" "beijing"
	  "Fu xiangyu" "heilongjiang"
	  "Zhou jiacheng" "guangdong"
	  "He haoran"   "guangzhou"
	  end
	  gen id1=_n
	  save dat1.dta,replace
clear
input str14 name str10 city
      "Zhang ziye" "Beijing"
	  "Fu xiangyu" "Heilongjiang"
	  "Zhou jiacheng" "Guangdong"
	  "He,haoran"   "Guangzhou"
end
gen id2=_n
 save dat2.dta,replace
use dat1.dta
reclink name city using dat2.dta,idmaster(id1) idusing(id2) gen(match_score)
list,clean noobs