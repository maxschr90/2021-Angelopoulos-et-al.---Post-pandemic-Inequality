************************************************************************************************************************
************************************************************************************************************************
******************************* CLEANING *******************************************************************************
************************************************************************************************************************
************************************************************************************************************************
*** This .do file cleans the dataset and assembles it into a panel. It also creates*************************************
*** a number of household level variables.******************************************************************************
************************************************************************************************************************


clear 
cls

** change current file location
pwd

** Load Merged Data
use "..\Data\Use\longfile.dta", clear

** Merge in CPI Data
gen YEAR = intdaty_dv
merge m:1 YEAR using "..\Data\CPI\CPI.dta", nogenerat

** Identify household heads and spouses/partners
replace ppid =. if ppid<0
replace sppid = ppid if sppid<0 &ppid >0
sort hidp
gen hrp_aux=hrpid-pidp
gen hrp=0
replace  hrp=1 if hrp_aux==0
drop hrp_aux
replace sppid= . if sppid<0
gen hrsp_aux=sppid-hrpid
gen hrsp=0
replace  hrsp=1 if hrsp_aux==0
drop hrsp_aux
gen index=1 if hrp>0
bys hidp: egen nhoh=sum(index)
drop if nhoh==0
drop index nhoh
** keep only spouses/partners
keep if hrp ==1 | hrsp ==1

** Drop Observations with missing identification & information
drop if pidp ==.
drop if hidp ==.
drop if pno ==.
drop if hrpno ==.
drop if wave ==.
drop if sex == -9
drop if gor_dv <0
drop if jbnssec8_dv == -9
drop if sf12pcs_dv<0

keep if ivfho == 10

** Sample Selection
drop if jbstat <0 | jbstat ==7 | jbstat >8
replace jbnssec8_dv = -8 if jbstat==6| jbstat==8| inrange(jbstat,3,4) 
drop if jbnssec8_dv == -8 & inrange(jbstat,1,2)

** Create Individual Level Variables

** Generate Social Class
gen class =.
replace class  = 1 if inrange(jbnssec8_dv,1,2)
replace class  = 2 if inrange(jbnssec8_dv,3,5)
replace class  = 3 if inrange(jbnssec8_dv,6,8)
replace class  = 4 if jbnssec8_dv==-8

** Generate Income Variables
gen Y_ind_NL    =fimnlabnet_dv*12   //net labour income
gen Y_ind_GL    =fimnlabgrs_dv*12   //gross labour income
gen Y_ind_ms    =fimnmisc_dv*12     //miscellaneous income
gen Y_ind_ben   =fimnprben_dv*12      //private benefit income
gen Y_ind_inv   =fimninvnet_dv*12   //investment income
gen Y_ind_pen   =fimnpen_dv*12       //private pension income
gen Y_ind_sb    =fimnsben_dv*12   //social benefit income 

** Generate History of Health Events
do "HWI_Generate_Health_Histories.do"

** Generate Standardised Health Measure (PCS)
egen minPCS = min(sf12pcs_dv)
egen maxPCS = max(sf12pcs_dv)
gen PCS = ((sf12pcs_dv-minPCS)/(maxPCS-minPCS))*0.9+0.1

** Aggregate to HH
bysort hidp: egen HH_age = mean(age_dv) 
bysort hidp: egen HH_class =min(class)
bysort hidp: egen HH_earnings_pre = sum(Y_ind_NL) 
bysort hidp: egen HH_netincome = sum(Y_ind_NL+Y_ind_ms+Y_ind_ben+Y_ind_sb) 
bysort hidp: egen HH_netincome_pre = sum(Y_ind_NL+Y_ind_ms+Y_ind_ben+Y_ind_sb+Y_ind_inv+Y_ind_pen) 
bysort hidp: egen HH_grossincome = sum(Y_ind_GL+Y_ind_ms+Y_ind_ben+Y_ind_inv) 
bysort hidp: egen HH_PCS = mean(PCS)
bysort hidp: egen HH_healthshock = max(healthshock)
replace HH_netincome = ((HH_netincome/CPI)*100)  
replace HH_grossincome = ((HH_grossincome/CPI)*100)  

** keep only HH head in age range
keep if pno == hrpno
keep if inrange(age_dv,25,60)

** save cleaned data
save "..\Data\Use\HH_Panel.dta", replace



