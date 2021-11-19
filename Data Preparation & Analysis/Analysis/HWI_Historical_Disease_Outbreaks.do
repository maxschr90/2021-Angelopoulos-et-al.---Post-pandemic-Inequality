/*****************************************************************************************
* ANALYSIS OF HISTORICAL PANDEMIC INCIDENCE										 *
*****************************************************************************************/
clear 
cls

** change current file location
cd 

** create global variable referring to your data folder
global data "C:\Users\maxsc\Documents\GitHub\HWI_Replication_File\Data Preparation & Analysis\Data"

** load data
use "$data\Historical Mortality\Glasgow_Resp_Mortality.dta", clear

** filter the data
tsset Year
tsfilter hp Residual = All_Resp, s(6.25)

** estimate MS model with state dependent error variance on full sample to see the two regimes
mswitch dr Residual , varswitch
predict P1  , smethod(smooth) pr
label var All_Resp "Resp Deaths"
label var Residual "Resp Deaths (hpfilter)"
label var P1 "Prob Regime 1"
replace P1=1-P1
tsline All_Resp Residual
twoway (tsline Residual, yaxis(1)) (tsline P1, yaxis(2))

** drop years after 1940
keep if Year<1941

** estimate MS model on remaining data
mswitch dr Residual , states(2)
predict P2  , smethod(smooth) pr
replace P2 =1-P2
label var P2 "Prob Outbreak"
twoway (tsline Residual, yaxis(1)) (tsline P2, yaxis(2))
gen Pandemic = 0
replace Pandemic =1 if P2>0.5 & Residual >1000
sum Pandemic if l.Pandemic==0
sum Pandemic if l.Pandemic==1
