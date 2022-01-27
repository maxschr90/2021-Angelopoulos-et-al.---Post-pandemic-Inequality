************************************************************************************************************************
************************************************************************************************************************
******************************* ANALYSIS ****************************************************************************
************************************************************************************************************************
************************************************************************************************************************
*** This .do file performs the data analysis, creating all the information necessary to******************************** 
*** populate the tables and figures in the main paper and the appendix.************************************************* 
*** It also provides the exogenous processes necessary for the calibration of the model.********************************
************************************************************************************************************************

clear 
cls

** Change current file location
pwd

** Load Cleaned Data
use "..\Data\Use\HH_Panel.dta", clear

** Set panel dimensions
xtset pidp wave


*** EARNINGS RELATED ***
** Generate observables
gen age = HH_age
gen age_sq = HH_age^2
gen age_qu = HH_age^3
gen log_hhsize =log(hhsize)

** Trim the data
drop if HH_netincome <= 0
gen W = HH_netincome
egen pcth_W  = pctile(W) if W>0,  p(99.5) by(wave)
egen pctl_W  = pctile(W) if W>0,  p(0.5) by(wave)
drop if W   > pcth_W  
drop if W   < pctl_W			
drop pcth_W pctl_W
gen lw = log(HH_netincome)

gen dlw =d.lw
gen dHH_PCS =d.HH_PCS

*** Visual Presentation of Relationship
** Levels
twoway (scatter lw HH_PCS || lfit lw HH_PCS), ytitle(log(HH_netincome)) by(HH_posthealthshock, total) title(Healthstatus)
graph export "..\Outputs\Graph_Levels_1.png", replace
twoway (scatter lw HH_PCS || lfit lw HH_PCS), ytitle(log(HH_netincome)) by(HH_class, total) title( Socioeconomic Group)
graph export "..\Outputs\Graph_Levels_2.png", replace

** Differences

twoway (scatter dlw dHH_PCS || lfit dlw dHH_PCS), ytitle(dlog(HH_netincome)) by(HH_posthealthshock, total)  title( Healthstatus)
graph export "..\Outputs\Graph_Diff_1.png", replace

twoway (scatter dlw dHH_PCS || lfit dlw dHH_PCS), ytitle(dlog(HH_netincome)) by(HH_class, total) title( Socioeconomic Group)
graph export "..\Outputs\Graph_Diff_2.png", replace


*** Regression Analysis
** Levels
qui: reg lw HH_PCS , vce(cluster pidp) 
eststo Levels_1
qui: reg lw HH_PCS  if HH_posthealthshock ==0, vce(cluster pidp) 
eststo Levels_2
qui: reg lw HH_PCS if HH_posthealthshock ==1 , vce(cluster pidp) 
eststo Levels_3

qui: reg lw HH_PCS i.sex c.age c.age_sq c.age_qu i.intdaty_dv i.gor_dv  c.log_hhsize, vce(cluster pidp) 
eststo Levels_4
qui: reg lw HH_PCS i.sex c.age c.age_sq c.age_qu i.intdaty_dv i.gor_dv  c.log_hhsize if HH_posthealthshock ==0 , vce(cluster pidp) 
eststo Levels_5
qui: reg lw HH_PCS i.sex c.age c.age_sq c.age_qu i.intdaty_dv i.gor_dv  c.log_hhsize if HH_posthealthshock ==1 , vce(cluster pidp) 
eststo Levels_6

qui: reg lw HH_PCS i.sex c.age c.age_sq c.age_qu i.intdaty_dv i.gor_dv  c.log_hhsize i.HH_class , vce(cluster pidp) 
eststo Levels_7
qui: reg lw HH_PCS i.sex c.age c.age_sq c.age_qu i.intdaty_dv i.gor_dv  c.log_hhsize i.HH_class if HH_posthealthshock ==0 , vce(cluster pidp) 
eststo Levels_8
qui: reg lw HH_PCS i.sex c.age c.age_sq c.age_qu i.intdaty_dv i.gor_dv  c.log_hhsize i.HH_class if HH_posthealthshock ==1 , vce(cluster pidp) 
eststo Levels_9

esttab Levels_1 Levels_2 Levels_3 Levels_4 Levels_5 Levels_6  Levels_7 Levels_8 Levels_9 using "..\Outputs\Health_Earnings_Relationship.rtf" , keep(HH_PCS)  indicate( "Demographic Controls = age" "Socioeconomic Group Controls = *HH_class"   ) stats(  N, labels(  "N")) title("Relationship between income and health in levels") mtitle("Full Sample" "Healthy HH" "Sick HH" "Full Sample" "Healthy HH" "Sick HH" "Full Sample" "Healthy HH" "Sick HH") replace compress 

** Differences
qui: xtreg d.lw d.HH_PCS i.sex c.age c.age_sq c.age_qu i.intdaty_dv i.gor_dv  c.log_hhsize , vce(cluster pidp) 
eststo Differences_1
estadd local fixed "no" , replace

qui: xtreg d.lw d.HH_PCS i.sex c.age c.age_sq c.age_qu i.intdaty_dv i.gor_dv  c.log_hhsize if HH_posthealthshock ==0, vce(cluster pidp) 
eststo Differences_2
estadd local fixed "no" , replace

qui: xtreg d.lw d.HH_PCS i.sex c.age c.age_sq c.age_qu i.intdaty_dv i.gor_dv  c.log_hhsize  if HH_posthealthshock ==1, vce(cluster pidp) 
eststo Differences_3
estadd local fixed "no" , replace

qui: xtreg d.lw d.HH_PCS i.sex c.age c.age_sq c.age_qu i.intdaty_dv i.gor_dv  c.log_hhsize i.HH_class , vce(cluster pidp) 
eststo Differences_4
estadd local fixed "no" , replace

qui: xtreg d.lw d.HH_PCS i.sex c.age c.age_sq c.age_qu i.intdaty_dv i.gor_dv  c.log_hhsize i.HH_class if HH_posthealthshock ==0, vce(cluster pidp) 
eststo Differences_5
estadd local fixed "no" , replace

qui: xtreg d.lw d.HH_PCS i.sex c.age c.age_sq c.age_qu i.intdaty_dv i.gor_dv  c.log_hhsize i.HH_class  if HH_posthealthshock ==1, vce(cluster pidp) 
eststo Differences_6
estadd local fixed "no" , replace
qui: xtreg d.lw d.HH_PCS i.sex c.age c.age_sq c.age_qu i.intdaty_dv i.gor_dv  c.log_hhsize i.HH_class, vce(cluster pidp) fe
eststo Differences_7
estadd local fixed "yes" , replace
qui: xtreg d.lw d.HH_PCS i.sex c.age c.age_sq c.age_qu i.intdaty_dv i.gor_dv  c.log_hhsize i.HH_class if HH_posthealthshock ==0, vce(cluster pidp) fe
eststo Differences_8
estadd local fixed "yes" , replace
qui: xtreg d.lw d.HH_PCS i.sex c.age c.age_sq c.age_qu i.intdaty_dv i.gor_dv  c.log_hhsize i.HH_class if HH_posthealthshock ==1, vce(cluster pidp) fe
eststo Differences_9
estadd local fixed "yes" , replace
esttab Differences_1 Differences_2 Differences_3  Differences_4 Differences_5 Differences_6 Differences_7 Differences_8 Differences_9  using "..\Outputs\Health_Earnings_Relationship.rtf" , keep(*HH_PCS)  indicate("Demographic Controls = age" "Socioeconomic Group Controls = *HH_class"  )  title("Relationship between income and health in Differences") mtitle("Full Sample" "Healthy HH" "Sick HH" "Full Sample" "Healthy HH" "Sick HH" "Full Sample" "Healthy HH" "Sick HH") scal("fixed FE") append compress 
