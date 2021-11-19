/*****************************************************************************************
* CREATE THE DATA USED FOR THE HEALTH SHOCK RESPONSE GRAPH								 *
*****************************************************************************************/

** preserve data
preserve
xtset pidp wave

** standardize health to period before shock
egen Z= mean(HH_PCS) if  f1.HH_healthshock ==1 & HH_posthealthshock==0 
carryforward Z, replace
replace HH_PCS=HH_PCS/Z

** generate empty matrix
mat health =J(7,3,.)

** calculate mean and confidence interval
sum HH_PCS if  f1.HH_healthshock ==1 & HH_posthealthshock==0 
mat health[1,1] = r(mean)
mat health[1,2] = r(mean)-1.96*r(sd)/(r(N)^0.5)
mat health[1,3] = r(mean)+1.96*r(sd)/(r(N)^0.5)

sum HH_PCS if  HH_healthshock ==1
mat health[2,1] = r(mean)
mat health[2,2] = r(mean)-1.96*r(sd)/(r(N)^0.5)
mat health[2,3] = r(mean)+1.96*r(sd)/(r(N)^0.5)

sum HH_PCS if  l1.HH_healthshock ==1
mat health[3,1] = r(mean)
mat health[3,2] = r(mean)-1.96*r(sd)/(r(N)^0.5)
mat health[3,3] = r(mean)+1.96*r(sd)/(r(N)^0.5)

sum HH_PCS if  l2.HH_healthshock ==1
mat health[4,1] = r(mean)
mat health[4,2] = r(mean)-1.96*r(sd)/(r(N)^0.5)
mat health[4,3] = r(mean)+1.96*r(sd)/(r(N)^0.5)

sum HH_PCS if  l3.HH_healthshock ==1
mat health[5,1] = r(mean)
mat health[5,2] = r(mean)-1.96*r(sd)/(r(N)^0.5)
mat health[5,3] = r(mean)+1.96*r(sd)/(r(N)^0.5)

sum HH_PCS if  l4.HH_healthshock ==1
mat health[6,1] = r(mean)
mat health[6,2] = r(mean)-1.96*r(sd)/(r(N)^0.5)
mat health[6,3] = r(mean)+1.96*r(sd)/(r(N)^0.5)

sum HH_PCS if  l5.HH_healthshock ==1
mat health[7,1] = r(mean)
mat health[7,2] = r(mean)-1.96*r(sd)/(r(N)^0.5)
mat health[7,3] = r(mean)+1.96*r(sd)/(r(N)^0.5)

mat colnames health = Mean LB UB

** save output
putexcel set   "..\Outputs\Healthshockresponse.xlsx", sheet("Raw") replace
putexcel A1=matrix(health), 

** restore original data
restore, preserve

** repeat after health mincerian
xtset pidp wave
gen log_hhsize =log(hhsize)

** run health mincerian and predict residuals
reg HH_PCS log_hhsize HH_postasthma HH_postarthritis  HH_postangina  HH_posthyperthyroidism HH_posthypothyroidism  HH_postlivercondition HH_postdiabetes HH_postepilepsy HH_posthighbloodpressure  HH_postdeadfather HH_postdeadmother  c.HH_age##c.HH_age##c.HH_age i.sex i.gor_dv   
predict res_minc_all,r

** standardize recentred residuals 
egen MEANHHPCS =mean(HH_PCS)
replace HH_PCS = res_minc_all + MEANHHPCS  
egen Z= mean(HH_PCS) if  f1.HH_healthshock ==1 & HH_posthealthshock==0 
carryforward Z, replace
replace HH_PCS=HH_PCS/Z

** generate empty matrix
mat health =J(7,3,.)

** calculate mean and confidence interval
sum HH_PCS if  f1.HH_healthshock ==1 & HH_posthealthshock==0 
mat health[1,1] = r(mean)
mat health[1,2] = r(mean)-1.96*r(sd)/(r(N)^0.5)
mat health[1,3] = r(mean)+1.96*r(sd)/(r(N)^0.5)

sum HH_PCS if  HH_healthshock ==1
mat health[2,1] = r(mean)
mat health[2,2] = r(mean)-1.96*r(sd)/(r(N)^0.5)
mat health[2,3] = r(mean)+1.96*r(sd)/(r(N)^0.5)

sum HH_PCS if  l1.HH_healthshock ==1
mat health[3,1] = r(mean)
mat health[3,2] = r(mean)-1.96*r(sd)/(r(N)^0.5)
mat health[3,3] = r(mean)+1.96*r(sd)/(r(N)^0.5)

sum HH_PCS if  l2.HH_healthshock ==1
mat health[4,1] = r(mean)
mat health[4,2] = r(mean)-1.96*r(sd)/(r(N)^0.5)
mat health[4,3] = r(mean)+1.96*r(sd)/(r(N)^0.5)

sum HH_PCS if  l3.HH_healthshock ==1
mat health[5,1] = r(mean)
mat health[5,2] = r(mean)-1.96*r(sd)/(r(N)^0.5)
mat health[5,3] = r(mean)+1.96*r(sd)/(r(N)^0.5)

sum HH_PCS if  l4.HH_healthshock ==1
mat health[6,1] = r(mean)
mat health[6,2] = r(mean)-1.96*r(sd)/(r(N)^0.5)
mat health[6,3] = r(mean)+1.96*r(sd)/(r(N)^0.5)

sum HH_PCS if  l5.HH_healthshock ==1
mat health[7,1] = r(mean)
mat health[7,2] = r(mean)-1.96*r(sd)/(r(N)^0.5)
mat health[7,3] = r(mean)+1.96*r(sd)/(r(N)^0.5)

mat colnames health =  Mean LB UB

** save output
putexcel set  "..\Outputs\Healthshockresponse.xlsx", sheet("Mincerian") modify
putexcel A1=matrix(health), 

** restore original data
restore
