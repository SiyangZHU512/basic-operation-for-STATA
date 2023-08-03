sysuse nlsw88.dta, clear
histogram wage,  ylabel(, angle(0)) xtitle("wage") name(fig1, replace)
winsor2 wage, cut(2.5 97.5) /*<2.5%and >97.5% replace those data by2.5% and 97.5% */
histogram wage_w,  ylabel(, angle(0)) xtitle("wage") name(fig2, replace)
graph combine fig1 fig2
reg wage    hours
eststo e1
reg wage_w hours
eststo e2
esttab e1 e2
/*delet*/
sysuse nlsw88.dta, clear
winsor2 wage, cut(2.5 97.5) trim
histogram wage,  ylabel(, angle(0)) xtitle("wage") name(fig1, replace)
histogram wage_tr,  ylabel(, angle(0)) xtitle("wage") name(fig2, replace)
graph combine fig1 fig2
reg wage    hours
eststo e1
reg wage_tr hours
eststo e2
esttab e1 e2

/*single side*/
sysuse nlsw88.dta, clear
winsor2 wage, cut(0 97.5) trim 
winsor2 wage, cut(0 97.5)     
histogram wage, ylabel(, angle(0)) xtitle("wage") name(fig1, replace)
histogram wage_tr, ylabel(, angle(0)) xtitle("wage_tr") name(fig2, replace)
histogram wage_w, ylabel(, angle(0)) xtitle("wage_w") name(fig3, replace)
graph combine fig1 fig2 fig3
/*multiple variables case*/
sysuse nlsw88.dta, clear
winsor2 wage hours race, cut(2.5, 97.5)  by(ind) /*deal with outlier within different ind*/