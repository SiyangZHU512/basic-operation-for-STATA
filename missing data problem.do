/*delet*/
sysuse nlsw88.dta, clear
sum
dropmiss, any obs
/*fill*/
sysuse nlsw88.dta, clear
sum
misstable sum age wage hours ttl_exp tenure grade /*only by numerical variables*/

/*fill with mean*/
sysuse nlsw88.dta, clear
sum
replace grade = r(mean) if grade==.
replace hours = r(mean) if hours==.
replace tenure= r(mean) if tenure==.
/*fill with regression*/
sysuse nlsw88.dta, clear
reg wage grade hours
list wage hours if grade==.
replace grade = (wage[496]+_b[_cons] - _b[hours]*hours[496])/_b[grade] ///
          if (wage == wage[496]&grade==.&hours==hours[496])

replace grade = (wage[2210]+_b[_cons] - _b[hours]*hours[2210])/_b[grade] ///
          if (wage == wage[2210]&grade==.&hours==hours[2210])
reg wage hours grade
list wage grade if hours==.
replace hours = (wage[1108]+_b[_cons] - _b[grade]*grade[1108])/_b[hours] ///
          if (wage == wage[1108]&grade==grade[1108]&hours==.)
/*fill with previous value*/
sysuse nlsw88, clear
replace grade = grade[_n-1] if grade==.
replace hours = hours[_n-1] if hours==.
replace tenure = tenure[_n-1] if tenure==.
/*Multiple Imputation Approach */
/*one variable case*/
webuse mheart0, clear
describe
sum
logit attack smokes age bmi hsgrad female
misstable summarize
misstable patterns
mi set wide
mi register imputed bmi
mi impute regress bmi attack smokes age hsgrad female, add(20) rseed(2232)
mi estimate, dots:logit attack smokes age bmi hsgrad female
/*many varaibel*/
/*MVN*/
sysuse nlsw88.dta, clear
sum
misstable patterns
mi set wide
mi register imputed grade hours tenure
mi register regular age wage ttl_exp
mi misstable nested grade hours tenure
mi misstable patterns grade hours tenure
mi impute mvn grade hours tenure = age wage ttl_exp, replace nolog add(20)
mi estimate:regress grade hours tenure
mi estimate,vartable nocitable
/*MICE*/
clear all
sysuse nlsw88.dta, clear
sum
misstable patterns
mi set wide
mi register imputed grade hours tenure
mi register regular age wage ttl_exp
mi misstable nested grade hours tenure
mi misstable patterns grade hours tenure
mi impute chained (regress) grade hours tenure = age wage ttl_exp, replace add(20)
mi estimate:regress grade hours tenure
mi estimate,vartable nocitable
mi impute chained (poisson) grade hours tenure = age wage ttl_exp, replace add(20)
mi estimate:regress grade hours tenure
mi estimate,vartable nocitable