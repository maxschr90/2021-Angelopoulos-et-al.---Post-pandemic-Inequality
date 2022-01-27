************************************************************************************************************************
************************************************************************************************************************
******************************* TABLES *********************************************************************************
************************************************************************************************************************
************************************************************************************************************************
************************************************************************************************************************
*** This .do file constructs table 1 in the main text and 2A in the appendix. ******************************************
************************************************************************************************************************


** preserve data
preserve

** Table 1
** tabulate outcomes by class
egen M = mean(HH_netincome)
replace HH_netincome = HH_netincome/M

tabstat HH_netincome, by(HH_class) save
tabstatmat C_1_alt

egen H = mean(HH_PCS)
replace HH_PCS = HH_PCS/H
tabstat HH_PCS, by(HH_class) save
tabstatmat C_3_alt
qui: ineqdeco HH_PCS, by(HH_class)
mat C_4_alt =J(5,1,.)
mat C_4_alt[1,1] = r(gini_1)
mat C_4_alt[2,1] = r(gini_2)
mat C_4_alt[3,1] = r(gini_3)
mat C_4_alt[4,1] = r(gini_4)
mat C_4_alt[5,1] = r(gini)

tabstat HH_healthshock, by(HH_class) save
tabstatmat C_5_alt

egen I = mean(HH_healthinvestment_1)
replace HH_healthinvestment_1=HH_healthinvestment_1/I

tabstat HH_healthinvestment_1, by(HH_class) save
tabstatmat C_6_alt

qui: ineqdeco HH_healthinvestment_1, by(HH_class)
mat C_7_alt =J(5,1,.)
mat C_7_alt[1,1] = r(gini_1)
mat C_7_alt[2,1] = r(gini_2)
mat C_7_alt[3,1] = r(gini_3)
mat C_7_alt[4,1] = r(gini_4)
mat C_7_alt[5,1] = r(gini)

mat def C_alt = [C_1_alt, C_3_alt, C_4_alt, C_6_alt, C_7_alt, C_5_alt]
mat rownames C_alt = Professionals Intermediate Routine Inactive Total
mat colnames C_alt = "Relative Mean Net Income" "Relative Mean Health" "Gini Health" "Relative Mean Health Investment" "Gini Health Investment" "Pct with severe health event" 

** save outputs
putexcel set   "..\Outputs\Tables.xlsx", sheet("Table 1") modify
putexcel A1=matrix(C_alt), names

** restore original data
restore, preserve
************************************************************************************************************************
** drop Northern Ireland from sample
drop if gor_dv ==12

** Appendix Table A2
** tabulate outcomes by class
egen M = mean(HH_netincome)
replace HH_netincome = HH_netincome/M

tabstat HH_netincome, by(HH_class) save
tabstatmat C_1_alt

egen H = mean(HH_PCS)
replace HH_PCS = HH_PCS/H
tabstat HH_PCS, by(HH_class) save
tabstatmat C_3_alt
qui: ineqdeco HH_PCS, by(HH_class)
mat C_4_alt =J(5,1,.)
mat C_4_alt[1,1] = r(gini_1)
mat C_4_alt[2,1] = r(gini_2)
mat C_4_alt[3,1] = r(gini_3)
mat C_4_alt[4,1] = r(gini_4)
mat C_4_alt[5,1] = r(gini)

tabstat HH_healthshock, by(HH_class) save
tabstatmat C_5_alt

egen I = mean(HH_healthinvestment_1)
replace HH_healthinvestment_1=HH_healthinvestment_1/I

tabstat HH_healthinvestment_1, by(HH_class) save
tabstatmat C_6_alt

qui: ineqdeco HH_healthinvestment_1, by(HH_class)
mat C_7_alt =J(5,1,.)
mat C_7_alt[1,1] = r(gini_1)
mat C_7_alt[2,1] = r(gini_2)
mat C_7_alt[3,1] = r(gini_3)
mat C_7_alt[4,1] = r(gini_4)
mat C_7_alt[5,1] = r(gini)

mat def C_alt = [C_1_alt, C_3_alt, C_4_alt, C_6_alt, C_7_alt, C_5_alt]
mat rownames C_alt = Professionals Intermediate Routine Inactive Total
mat colnames C_alt = "Relative Mean Net Income" "Relative Mean Health" "Gini Health" "Relative Mean Health Investment" "Gini Health Investment" "Pct with severe health event" 

** save outputs
putexcel set   "..\Outputs\Tables.xlsx", sheet("Appendix Table A2") modify
putexcel A1=matrix(C_alt), names
