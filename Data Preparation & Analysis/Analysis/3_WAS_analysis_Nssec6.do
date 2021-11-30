**********************************************************
************      3_WAS_analysis_all       **************
*********************************************************

clear all

**need to customize this directory
local location "C:\Users\lazaraki\OneDrive - Lancaster University\Corona_project\WAS"

use "`location'\\Data\all_wealth_data_long2.dta", clear


*keep if wave==3 | wave==4 | wave==5 
***keep the head of the households
keep if hrp==1 | partner==1

*NSSEC - 8 categories	
*Not applicable	
*1.1= Large employers and higher managerial and administrative occupations
*1.2= Higher professional occupations	
*2  = Lower managerial and professional occup	
*3  = Intermediate occupations	
*4  = Small employers and own account workers	
*5  = Lower supervisory and technical occupat	
*6  = Semi-routine occupations	
*7  = Routine occupations	
*8  =Never worked and long-term unemployed	
*97 = Not classified	

** Generate Social Class
gen nssec_3 =.
replace nssec_3  = 4 if nssec_eight<2 & nssec_eight>0
replace nssec_3  = 3 if inrange(nssec_eight,2,4)
replace nssec_3  = 2 if inrange(nssec_eight,5,7)
replace nssec_3  = 1 if inrange(nssec_eight,8,96)
replace nssec_3  = 1 if nssec_eight==-7 & empstat>3 & empstat!= .
replace nssec_3  = 1 if nssec_eight==97 & empstat>3 & empstat!= .

bys hid: egen max_nssec=max(nssec_3)
drop if max_nssec>= .
rename max_nssec nssec_six

***keep the households whose heads are between 25-59 years old
keep if hrp==1 
drop if (DVAge17W<6 | DVAge17W>12) & wave<3 
drop if (agew<25 | agew>60) & wave>2 
drop if educ_cortd>= . //

drop if empstat==4 //inactive students

gen col_ind=0
replace col_ind=1 if net_worth<3500

qui sum col_ind if wave == 5 [aw=sampl_weights], detail
gen pop_share5=r(mean)
di pop_share5

tab nssec_six 

***create some more variables

gen aug_net_worth=net_worth+Total_Physical_Wealth
gen eq_net_worth=net_worth/hh_weights


foreach sk in 1 2 3 4{
	
	qui sum net_worth if wave == 3 & net_worth<=0 & nssec_six==`sk' [aw=sampl_weights], detail
    scalar Dpop_share`sk'=r(sum_w)
	qui sum net_worth if wave == 3 & nssec_six==`sk' [aw=sampl_weights], detail
    scalar Tpop_share`sk'=r(sum_w)
	gen indebted`sk'=Dpop_share`sk'/Tpop_share`sk'
	}
	

di indebted1
di indebted2
di indebted3
di indebted4

drop indebted1 indebted2 indebted3 indebted4 

foreach yr in 1 2 3 4 5{
	
	qui sum net_worth if wave == `yr' & net_worth<=0 [aw=sampl_weights], detail
    scalar Dpop_share`yr'=r(sum_w)
	qui sum net_worth if wave == `yr' [aw=sampl_weights], detail
    scalar Tpop_share`yr'=r(sum_w)
	gen indebted`yr'=Dpop_share`yr'/Tpop_share`yr'
	}
gen indebted_pop_share=(indebted1+indebted2+ indebted3+indebted4+indebted5)/5
drop indebted1 indebted2 indebted3 indebted4 indebted5
di indebted_pop_share

*********************************************************************
*********************************************************************
*********************************************************************
*********************************************************************
*********************************************************************


gen nssec_six_t=5

cap postclose pfile
cap erase "`location'\\results\wealth_uni_hh_nssec6.dta"
# delimit ;
postfile pfile skill datayear var N mean sd p50 gini   
using "`location'\\results\wealth_uni_hh_nssec6.dta";
# delimit cr

local var_list = "net_worth Net_Fin_Wealth"

local skill = 1
while(`skill' <= 5){

local yr = 1
while(`yr' <= 5){
	display("`yr'")
	local var_num = 1
	foreach var of local var_list{
	
	qui sum `var' if wave == `yr' & (nssec_six==`skill' | nssec_six_t==`skill') [aw = sampl_weights], detail
		local mean       = r(mean)
		local sd         = r(sd)
		local p50     = r(p50)
		local N       = r(N)


*		Compute the gini for the raw variable				
	    qui ineqdec0(`var')  if wave == `yr' &  (nssec_six==`skill' | nssec_six_t==`skill')  [aw=sampl_weights]
		local gini = $S_gini
		
		post pfile (`skill') (`yr') (`var_num') (`N') (`mean') (`sd') (`p50') (`gini') 
			
		local var_num = `var_num' + 1		
	}
	local yr = `yr' + 1
}
	local skill = `skill' + 1
}
postclose pfile




use "`location'\\results\wealth_uni_hh_nssec6.dta", clear

#delimit ;
label define var_l2 1 net_worth 2 Net_Fin_Wealth;
label values var var_l2;
#delimit cr

gen skill2=5-skill if skill<5
replace skill=skill2 if skill<5



gen CV          = sd/mean
gen mean_over_median= mean/p50


keep skill datayear var N mean sd CV mean_over_median gini 

order skill datayear var N mean sd CV mean_over_median gini,first


save "`location'\\results\wealth_uni_hh_nssec6.dta", replace

use "`location'\\results\wealth_uni_hh_nssec6.dta", clear

collapse mean mean_over_median CV gini,by( var skill)


gen mvar_aux=mean if skill==5
gen cvvar_aux=CV if skill==5
gen gvar_aux=gini if skill==5

bys var: egen mvar=max(mvar_aux)
bys var: egen cvvar=max(cvvar_aux)
bys var: egen gvar=max(gvar_aux)

drop mvar_aux cvvar_aux gvar_aux

replace mvar=mean/mvar
replace cvvar=CV/cvvar
replace gvar=gini/gvar
