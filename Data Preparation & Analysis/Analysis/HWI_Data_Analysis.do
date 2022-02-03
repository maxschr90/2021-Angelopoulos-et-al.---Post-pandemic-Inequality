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

*** HEALTH RELATED ***
** These will include some of the moments used to calibrate the model
** Generate Health Status Variable and tabulate health outcomes by status
gen healthstatus = 1
replace healthstatus = 2 if HH_healthshock == 1 & l.HH_posthealthshock == 0
replace healthstatus = 3 if HH_healthshock == 0 & HH_posthealthshock == 1
tabstat HH_PCS , by(healthstatus) stats(mean var) save
tabstatmat HealthMoments 
mat rownames HealthMoments = Healthy Sick Recovering Total

** Tabulate the conditional probability of receiving a large health shock
xtset pidp wave
tabstat HH_healthshock if l.HH_posthealthshock ==0, by(HH_class) save
tabstatmat HealthShocks
mat rownames HealthShocks = Professionals Intermediate Routine Inactive Total

************************************************************************************************************************

** Run some auxiliary .do-files to produce additional outputs 
do "HWI_Shockresponse"
do "HWI_Table_1" 

************************************************************************************************************************

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

** Calculate concentration indices
conindex HH_PCS , rank(HH_netincome) bounded lim(0.1,1) wag
by YEAR, sort: conindex HH_PCS , rank(HH_netincome) bounded lim(0.1,1) wag


** Run Mincerian Regression & Predict Residuals
reg lw i.HH_class i.sex c.age c.age_sq c.age_qu i.intdaty_dv i.gor_dv  c.log_hhsize 
predict res ,r
sort HH_class
by HH_class: egen mean_lw = mean(lw) 
gen wage_resid = -(mean_lw+res) // take the negative here to get correct ranking in next step

** Assign within social group rankings
egen group= xtile(wage_resid), by(HH_class wave) p(30 (40) 70)
sort HH_class group
egen panelid = group(HH_class group) // panelid is the variable indicating the Social Group X Productivity State combination 
replace wage_resid=-wage_resid // reverse 

** Tabulate Relative Mean Earnings by Social Group X Productivity State
gen y = exp(wage_resid) 
egen temp = mean(y)
replace y = y/temp
drop temp
tabstat y, by(panelid) save nototal
tabstatmat wage_residuals // These are the productivity states used in the model

** Tabluate Relative Mean Earnings by Class 
tabstat y, by(HH_class) save 
tabstatmat mean_wage_residuals_by_Class 
qui: ineqdeco y, by(HH_class)
mat gini_wage_residuals_by_Class =J(5,1,.)
mat gini_wage_residuals_by_Class[1,1] = r(gini_1)
mat gini_wage_residuals_by_Class[2,1] = r(gini_2)
mat gini_wage_residuals_by_Class[3,1] = r(gini_3)
mat gini_wage_residuals_by_Class[4,1] = r(gini_4)
mat gini_wage_residuals_by_Class[5,1] = r(gini)

gen logy=log(y)
tabstat logy, by(HH_class ) stats(var) save
tabstatmat varlog 

mat def wage_residuals_by_Class = [mean_wage_residuals_by_Class, gini_wage_residuals_by_Class, varlog]
mat rownames wage_residuals_by_Class = Professionals Intermediate Routine Inactive Total
mat colnames wage_residuals_by_Class = "Relative Mean" "Gini" "Var Log" // these will be used to assess the approximation fit of the earnings process

** Estimate Transition Matrices
xtset pidp wave
xttrans2 panelid if panelid[_n+1] !=. & HH_posthealthshock ==0, matcell(Trans_Pre) prob
xttrans2 panelid if panelid[_n+1] !=. & HH_posthealthshock ==1, matcell(Trans_Post) prob
xttrans2 HH_class if HH_class[_n+1] !=. & HH_posthealthshock ==0 , matcell(Trans_Class_Pre) prob
xttrans2 HH_class if HH_class[_n+1] !=. & HH_posthealthshock ==1, matcell(Trans_Class_Post) prob

** Health - Income Relationship
reg HH_PCS log_hhsize HH_postasthma HH_postarthritis  HH_postangina  HH_posthyperthyroidism HH_posthypothyroidism  HH_postlivercondition HH_postdiabetes HH_postepilepsy HH_posthighbloodpressure  HH_postdeadfather HH_postdeadmother  c.HH_age##c.HH_age##c.HH_age i.sex i.gor_dv   
predict res_minc_all,r

gen severe=0
replace severe=1 if HH_posthealthshock==1
bys pidp: egen indic=sum(severe)
bys pidp: egen indich=sum(indic)
drop if indich>0

gen dy = d.lw*100
gen lh = log(HH_PCS)
gen dh = d.lh*100
*twoway (scatter dy dh)
xtile dhq = dh, n(10)
xtile phq = dh, n(100)
tabstat  dy , by(dhq) stat(mean sem N) save nototal
tabstatmat health_income_1
tabstat  dy , by(phq) stat(mean sem N) save nototal
tabstatmat health_income_2
tabstat  dh , by(phq) stat(mean sem N) save nototal
tabstatmat health_income_3
tabstat  dh res_minc_all, by(dhq) stat(mean sem N) save nototal
tabstatmat health_income_4

** Save Outputs
putexcel set   "..\Outputs\ExogenousProcesses.xlsx", sheet("Productivities") replace
putexcel A1=matrix(wage_residuals)
putexcel set   "..\Outputs\ExogenousProcesses.xlsx", sheet("Transition Pre") modify
putexcel A1=matrix(Trans_Pre)
putexcel set   "..\Outputs\ExogenousProcesses.xlsx", sheet("Transition Post") modify
putexcel A1=matrix(Trans_Post)
putexcel set   "..\Outputs\ExogenousProcesses.xlsx", sheet("Transition Class Pre") modify
putexcel A1=matrix(Trans_Class_Pre)
putexcel set   "..\Outputs\ExogenousProcesses.xlsx", sheet("Transition Class Post") modify
putexcel A1=matrix(Trans_Class_Post)
putexcel set   "..\Outputs\Tables.xlsx", sheet("Table 2a") modify
putexcel A1=matrix(Trans_Class_Pre)
putexcel set   "..\Outputs\Tables.xlsx", sheet("Table 2b") modify
putexcel A1=matrix(Trans_Class_Post)
putexcel set   "..\Outputs\Tables.xlsx", sheet("Table V") modify
putexcel A1=matrix(wage_residuals_by_Class) , names
putexcel set   "..\Outputs\Data_Moments.xlsx", sheet("Health Moments") modify
putexcel A1=matrix(HealthMoments), names
putexcel set   "..\Outputs\ExogenousProcesses.xlsx", sheet("Health Shock Probabilities") modify
putexcel A1=matrix(HealthShocks), names
putexcel set   "..\Outputs\HealthIncomeHistogramm.xlsx", sheet("Deciles") replace
putexcel A1=matrix(health_income_1)
putexcel set   "..\Outputs\HealthIncomeHistogramm.xlsx", sheet("Percentiles") modify
putexcel A1=matrix(health_income_2)
putexcel set   "..\Outputs\HealthIncomeHistogramm.xlsx", sheet("Percentiles XAxis") modify
putexcel A1=matrix(health_income_3)
putexcel set   "..\Outputs\HealthIncomeHistogramm.xlsx", sheet("Deciles XAxis") modify
putexcel A1=matrix(health_income_4)
