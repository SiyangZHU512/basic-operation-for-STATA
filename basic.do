use 2.dta,clear
duplicates drop RD,force
duplicates list Year
keep RD GDPpre edu invest fin banking GDP 发明专利数量 City Year
drop if Year==.
reshape wide RD GDPpre edu invest fin banking GDP 发明专利数量 ,i(City) j(Year)
reshape long RD GDPpre edu invest fin banking GDP 发明专利数量 ,i(City) j(Year)
gather GDP GDPpre,variable(kinds) value(money)
spread kinds money
encode City,gen(City1)
egen mean_GDP=mean(GDP), by(City1 Year)
gen K=1 if GDP>=1345 | Year>=2015
replace K=0 if K==.
recode K(0=1)(1=2),gen(index)
tab K,m
sum GDP,d
tabstat GDP,by(K) statistics(mean sd p25 p50 p75 min max)


/**/
use 2.dta,clear
keep RD GDPpre edu invest fin banking GDP 发明专利数量 City Year
drop if Year==.
reshape wide RD GDPpre edu invest fin banking GDP 发明专利数量 ,i(City) j(Year)
gen GDPl=log(GDP2006)
gen edul=log(edu2006)
gen RDl=log(RD2006)
gen GDPprel=log(GDPpre2006)
set scheme white_tableau
biplot  GDPl edul RDl GDPprel, rowlabel(City) ///
	rowopts(name(City)) colopts(name(Attributes)) ///
	title(Attributes for different cities) ///
	alpha(1) stretch(10)