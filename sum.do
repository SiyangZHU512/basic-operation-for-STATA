clear 
input x1 x2
       1  2
	   2  4
	   3  6
	   4  8
end
gen sum_x1=sum(x1)
gen sum_x2=sum(x2)
egen rsum_x=rsum(x1 x2)
egen rtotal_x=rowtotal(x1 x2)
list,clean noobs
/*sum by year*/
use lutkepohl2.dta, clear 
gen year = year(dofq(qtr)) 
list qtr inv inc consump in 1/4, clean noobs
collapse(sum) inv inc consump, by(year)
list year inv inc consump in 1/4, clean noobs

clear all
use lutkepohl2.dta, clear 
tscollap (sum) inv inc consump, to(y) //q、h、y，quater、half_year、year
list y_y inv inc consump in 1/4, clean noobs