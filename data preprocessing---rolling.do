webuse grunfeld.dta,clear
xtset company year
rolling mean=r(mean) sd=r(mean) N=r(N),clear window(10):sum invest
webuse grunfeld.dta,clear
xtset company year
rolling r2=e(r2_a) F=e(F) N=e(N) rss=e(rss),clear window(10):reg mvalue invest 
webuse grunfeld.dta,clear
xtset company year
bysort company: asrol kstock,window (year 5) stat (count mean)
bysort company:asreg mvalue invest
webuse grunfeld.dta,clear
xtset company year
rangestat (count)  kstock (mean)  kstock , interval (year -3 0)  by (company)