/*for saving the number*/
local x 1
display `x'

local y 2+2
display `y'

local w=2+2
display `w'
 
local z 2+2
display "`z'"
/*for saving the name*/
local name 好好学习
dis "`name''"

/*save expression*/
local year 2021
dis `=`year'-1'

/*save variables list*/
sysuse auto, clear
local varlist price weight rep78 length
dis"`varlist'"
sum `varlist'
des `varlist'
/*variable label*/
local lab:var label foreign
dis "`lab'"
label var mpg "`lab'"
/*value label*/
local lab:value label foreign
dis "`lab'"
/*get data file*/
local dtas: dir "." files "*.dta"
dis `"`dtas'"'
/*dir "path"("."--for the path have set). files "*.dta" types of fies*/
/*for regression*/
sysuse auto, clear
local vari1 weight rep78 length mpg
dis"`vari1"
reg price `vari1'
/*foreach*/
local DC batman superman wonderwoman flash
dis "`DC'"
foreach DC in batman superman wonderwoman flash{
    dis"`DC'"
}
/*foreach for regression*/
sysuse auto, clear
local yvar mpg price displacement
foreach yvar in mpg price displacement{
    reg `yvar' foreign weight
}
