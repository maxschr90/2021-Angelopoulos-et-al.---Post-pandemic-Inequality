********************************************************************************
***********************     Some preliminary cleaning        *******************
********************************************************************************
//in wave 3 there are some cases where we do not have info for their case number,
//i.e their household number. Moreover, in wave 4 there is one household which
//has mistakenly allocated the same household grid number to both members.

clear all

**need to customize this directory
local location "C:\Users\spyro\OneDrive - University of Glasgow\Corona_project\WAS" 

*************************************************************************************
*************************************************************************************
*************************************************************************************

use "`location'\\\Raw_Data\UKDA-7215-stata11_se\stata11_se\was_wave_5_person_eul_final.dta", clear

duplicates tag PersonW5 CASEw5,g(_t)

drop if _t>0

save "`location'\\\Raw_Data\UKDA-7215-stata11_se\stata11_se\WAS_wave_5_upd.dta", replace

use "`location'\\\Raw_Data\UKDA-7215-stata11_se\stata11_se\was_wave_4_person_eul_final.dta", clear

duplicates tag Personw4 CASEw4,g(_t)

replace Personw4=2 if P_FLAG4W4==4 & _t>0

save "`location'\\\Raw_Data\UKDA-7215-stata11_se\stata11_se\WAS_wave_4_upd.dta", replace

use "`location'\\\Raw_Data\UKDA-7215-stata11_se\stata11_se\was_wave_3_person_eul_26_04_17.dta", clear


*we drop the observations with no household id number (i.e CASEw3)
duplicates tag personW3 CASEw3,g(_t)

drop if _t>0

save "`location'\\\Raw_Data\UKDA-7215-stata11_se\stata11_se\WAS_wave_3_upd.dta", replace

use "`location'\\\Raw_Data\UKDA-7215-stata11_se\stata11_se\was_wave_2_person_eul.dta", clear

duplicates tag PersonW2 CASEW2,g(_t)

drop if _t>0

save "`location'\\\Raw_Data\UKDA-7215-stata11_se\stata11_se\WAS_wave_2_upd.dta", replace

use "`location'\\\Raw_Data\UKDA-7215-stata11_se\stata11_se\was_wave_1_person_eul.dta", clear

duplicates tag PersonW1 casew1,g(_t)

drop if _t>0

save "`location'\\\Raw_Data\UKDA-7215-stata11_se\stata11_se\WAS_wave_1_upd.dta", replace


*********************************************************
************      2_WAS_compile_all        **************
*********************************************************

use "`location'\\\Raw_Data\UKDA-7215-stata11_se\stata11_se\WAS_wave_5_upd.dta", clear
gen wave5=5

merge m:1  CASEw4 Personw4 using "`location'\\\Raw_Data\UKDA-7215-stata11_se\stata11_se\WAS_wave_4_upd.dta"
gen wave4=4 if _m==2 | _m==3
drop _m
rename PersonW3 personW3

merge m:1  CASEw3 personW3 using "`location'\\\Raw_Data\UKDA-7215-stata11_se\stata11_se\WAS_wave_3_upd.dta"
gen wave3=3 if _m==2 | _m==3
drop _m

merge m:1  CASEW2 PersonW2 using "`location'\\\Raw_Data\UKDA-7215-stata11_se\stata11_se\WAS_wave_2_upd.dta"
gen wave2=2 if _m==2 | _m==3
drop _m

merge m:1  casew1 PersonW1 using "`location'\\\Raw_Data\UKDA-7215-stata11_se\stata11_se\WAS_wave_1_upd.dta"
gen wave1=1 if _m==2 | _m==3
drop _m

save "`location'\\\Data\rawdata_WAS_all.dta", replace

use "`location'\\\Data\rawdata_WAS_all.dta", clear

rename dvagew3 agew3
rename DVAgeW4 agew4
rename DVAgeW5 agew5
gen agew2=agew3-2
gen agew1=agew3-4

gen long pid=100*CASEw4+Personw4

gen pno1=PersonW1
gen pno2=PersonW2
gen pno3=personW3
gen pno4=Personw4
gen pno5=PersonW5

gen nssec_five1=NSSEC5W1
gen nssec_five2=NSSEC5W2
gen nssec_five3=NSSEC5W3
gen nssec_five4=NSSEC5W4
gen nssec_five5=NSSEC5W5

gen nssec_three1=NSSEC3W1
gen nssec_three2=NSSEC3W2
gen nssec_three3=NSSEC3W3
gen nssec_three4=NSSEC3W4
gen nssec_three5=NSSEC3W5

gen nssec_eight1=NSSEC8W1
gen nssec_eight2=NSSEC8W2
gen nssec_eight3=NSSEC8W3
gen nssec_eight4=NSSEC8W4
gen nssec_eight5=NSSEC8W5

gen ind_soc1=SOC2010_2digitW1
gen ind_soc2=SOC2010_2digitW2
gen ind_soc3=SOC2010W3
destring SOC2010W4,g(SOC2010W4_aux)
gen ind_soc4=SOC2010W4_aux
destring SOC2010w5,g(SOC2010W5_aux)
gen ind_soc5=SOC2010W5_aux*10

gen ind_sic1=SIC2007DW1
gen ind_sic2=SIC2007DW2
gen ind_sic3=SICCODEW3
gen ind_sic4=SICCODEW4
gen ind_sic5=SICCODEw5


gen region1=GORW4
gen region2=GORW4
gen region3=GORW4
gen region4=GORW4
gen region5=GORW5


gen hoh1=1 if ISHRPW1==1
gen hoh2=1 if ISHRPW2==1
gen hoh3=1 if P_FLAG4W3==1 | P_FLAG4W3==3
gen hoh4=1 if P_FLAG4W4==1 | P_FLAG4W4==3
gen hoh5=1 if P_Flag4W5==1 | P_Flag4W5==3

gen partner1=1 if ISHRPPartW1==1
gen partner2=1 if ISHRPPARTW2==1
gen partner3=1 if ISHRPPartW3==1
gen partner4=1 if R01W4==1 | R01W4==2 | R01W4==20
gen partner5=1 if R01W5==1 | R01W5==2 | R01W5==20

replace DVSEGrsPAYW2=0 if DVSEGrsPAYW2<0
replace DVSEAmtW1=0 if DVSEAmtW1<0
replace DVGrsPayw3=0 if DVGrsPayw3<0
replace DVGrsPayW4=0 if DVGrsPayW4<0
replace DVGrsPayw5=0 if DVGrsPayw5<0

replace DVSeGRSPayw3=0 if DVSeGRSPayw3>= . & wave3==3
replace DVSeGRSPayw3=. if DVSEGRSPAYw3_iflag==1 & wave3==3

replace DVSeGRSPayW4=0 if DVSeGRSPayW4>= . & wave4==4
replace DVSeGRSPayW4=. if DVSEGrsPayw4_iflag==1 & wave4==4

replace DVSeGRSPayw5=0 if DVSeGRSPayw5>= . & wave5==5
replace DVSeGRSPayw5=. if DVSEGrsPayw5_iflag==1 & wave5==5

gen labour_share=0.7

gen main_annual_earn1=DVGrsPayW1+DVSEAmtW1   *labour_share
gen main_annual_earn2=DVGRspayW2+DVSEGrsPAYW2*labour_share
gen main_annual_earn3=DVGrsPayw3+DVSeGRSPayw3*labour_share
gen main_annual_earn4=DVGrsPayW4+DVSeGRSPayW4*labour_share
gen main_annual_earn5=DVGrsPayw5+DVSeGRSPayw5*labour_share


gen main_annual_earn_i1=DVGrsPayW1+DVSEAmtW1*labour_share
gen main_annual_earn_i2=DVGRspayW2+DVSEGrsPAYW2*labour_share
gen main_annual_earn_i3=dvgrspayw3_i+DVSeGRSPayw3_i*labour_share
gen main_annual_earn_i4=DVGrsPayW4+DVSeGRSPayW4_i*labour_share
gen main_annual_earn_i5=DVGrsPayw5+DVSeGRSPayw5_i*labour_share

replace DVGrsSESECJOBW2=0 if DVGrsSESECJOBW2<0

gen second_semp1=DVGrsSEJobW1*labour_share
gen second_semp2=DVGrsSESECJOBW2*labour_share
gen second_semp3=DVGRSSeSECJOBw3_i*labour_share
gen second_semp4=DVGRSSeSECJOBW4_i*labour_share
gen second_semp5=DVGRSSeSECJOBw5_i*labour_share

gen semp_i1=DVSEAmtW1*labour_share+DVGrsSEJobW1*labour_share
gen semp_i2=DVSEGrsPAYW2*labour_share+DVGrsSESECJOBW2*labour_share
gen semp_i3=DVSeGRSPayw3_i*labour_share+DVGRSSeSECJOBw3_i*labour_share
gen semp_i4=DVSeGRSPayW4_i*labour_share+DVGRSSeSECJOBW4_i*labour_share
gen semp_i5=DVSeGRSPayw5_i*labour_share+DVGRSSeSECJOBw5_i*labour_share

gen semp1=DVSEAmtW1*labour_share+DVGrsSEJobW1*labour_share
gen semp2=DVSEGrsPAYW2*labour_share+DVGrsSESECJOBW2*labour_share
gen semp3=DVSeGRSPayw3*labour_share+DVGRSSeSECJOBw3_i*labour_share
gen semp4=DVSeGRSPayW4*labour_share+DVGRSSeSECJOBW4_i*labour_share
gen semp5=DVSeGRSPayw5*labour_share+DVGRSSeSECJOBw5_i*labour_share

replace dvGrsempsecjobW2=0 if dvGrsempsecjobW2<0

gen second_annual_earn1=DVGrsJob2W1
gen second_annual_earn2=dvGrsempsecjobW2
gen second_annual_earn3=DVGRSEMPSECJOBw3_i
gen second_annual_earn4=DVGRSEMPSECJOBW4_i
gen second_annual_earn5=DVGRSEMPSECJOBw5_i

gen annual_earn1=DVGrsPayW1+second_annual_earn1
gen annual_earn2=DVGRspayW2+second_annual_earn2
gen annual_earn3=DVGrsPayw3+second_annual_earn3
gen annual_earn4=DVGrsPayW4+second_annual_earn4
gen annual_earn5=DVGrsPayw5+second_annual_earn5

gen annual_earn_i1=DVGrsPayW1+second_annual_earn1
gen annual_earn_i2=DVGRspayW2+second_annual_earn2
gen annual_earn_i3=dvgrspayw3_i+second_annual_earn3
gen annual_earn_i4=DVGrsPayW4+second_annual_earn4
gen annual_earn_i5=DVGrsPayw5+second_annual_earn5

replace BonAmtW1=0 if BonAmtW1<0
replace DVGrsBonAmtW2=0 if DVGrsBonAmtW2<0

gen bonus1=BonAmtW1
gen bonus2=DVGrsBonAmtW2
gen bonus3=DVGRSBONAMTw3_i
gen bonus4=DVGRSBONAMTw4_i
gen bonus5=DVGRSBONAMTw5_i

gen total_annual_earn1=main_annual_earn1+bonus1+second_annual_earn1+second_semp1
gen total_annual_earn2=main_annual_earn2+bonus2+second_annual_earn2+second_semp2
gen total_annual_earn3=main_annual_earn3+bonus3+second_annual_earn3+second_semp3
gen total_annual_earn4=main_annual_earn4+bonus4+second_annual_earn4+second_semp4
gen total_annual_earn5=main_annual_earn5+bonus5+second_annual_earn5+second_semp5

gen total_annual_earn_i1=main_annual_earn_i1+bonus1+second_annual_earn1+second_semp1
gen total_annual_earn_i2=main_annual_earn_i2+bonus2+second_annual_earn2+second_semp2
gen total_annual_earn_i3=main_annual_earn_i3+bonus3+second_annual_earn3+second_semp3
gen total_annual_earn_i4=main_annual_earn_i4+bonus4+second_annual_earn4+second_semp4
gen total_annual_earn_i5=main_annual_earn_i5+bonus5+second_annual_earn5+second_semp5

gen total_annual_earn_All1=DVGrsPayW1+DVSEAmtW1+bonus1+second_annual_earn1+DVGrsSEJobW1
gen total_annual_earn_All2=DVGRspayW2+DVSEGrsPAYW2+bonus2+second_annual_earn2+DVGrsSESECJOBW2
gen total_annual_earn_All3=dvgrspayw3_i+DVSeGRSPayw3_i+bonus3+second_annual_earn3+DVGRSSeSECJOBw3_i
gen total_annual_earn_All4=DVGrsPayW4+DVSeGRSPayW4_i+bonus4+second_annual_earn4+DVGRSSeSECJOBW4_i
gen total_annual_earn_All5=DVGrsPayw5+DVSeGRSPayw5_i+bonus5+second_annual_earn5+DVGRSSeSECJOBw5_i


gen earnings_flag1= .
gen earnings_flag2= .
gen earnings_flag3=dvgrspayw3_iflag
gen earnings_flag4=dvgrsbandw4_iflag
gen earnings_flag5=dvgrsbandw5_iflag

gen seearnings_flag1= .
gen seearnings_flag2= .
gen seearnings_flag3=DVSEGRSPAYw3_iflag
gen seearnings_flag4=DVSEGrsPayw4_iflag
gen seearnings_flag5=DVSEGrsPayw5_iflag


gen mastat1=DVMrDFW1
gen mastat2=DVMrDFW2
gen mastat3=DVMrDFW3
gen mastat4=DVMrDFW4
gen mastat5=DVMrDFW5

gen sex1=SexW1
gen sex2=SexW2
gen sex3=sexw3
gen sex4=SexW4
gen sex5=SexW5

gen W1W4_longwgtw1=W1W4_longwgt
gen W1W4_longwgtw2=W1W4_longwgt
gen W1W4_longwgtw3=W1W4_longwgt
gen W1W4_longwgtw4=W1W4_longwgt
gen W1W4_longwgtw5= .

gen W1W5_longwgtw1=w1w5wgt
gen W1W5_longwgtw2=w1w5wgt
gen W1W5_longwgtw3=w1w5wgt
gen W1W5_longwgtw4=w1w5wgt
gen W1W5_longwgtw5=w1w5wgt

gen  W1W2_longwgtw1=Longit_calwgtW2
gen  W1W2_longwgtw2=Longit_calwgtW2
gen  W1W2_longwgtw3= . 
gen  W1W2_longwgtw4= . 
gen  W1W2_longwgtw5= . 

gen  W2W3_longwgtw1= .
gen  W2W3_longwgtw2=w2w3wgt
gen  W2W3_longwgtw3=w2w3wgt 
gen  W2W3_longwgtw4= . 
gen  W2W3_longwgtw5= . 

gen  W3W4_longwgtw1= .
gen  W3W4_longwgtw2= .
gen  W3W4_longwgtw3=W3W4_longwgt 
gen  W3W4_longwgtw4=W3W4_longwgt 
gen  W3W4_longwgtw5= . 

gen  W4W5_longwgtw1= .
gen  W4W5_longwgtw2= .
gen  W4W5_longwgtw3= .
gen  W4W5_longwgtw4=W4W5_longwgt 
gen  W4W5_longwgtw5=W4W5_longwgt

gen  flag_wave4w1= .
gen  flag_wave4w2= .
gen  flag_wave4w3= .
gen  flag_wave4w4= TypeW4 
gen  flag_wave4w5= TypeW5 

drop Empstat1W3 empstat2w3 empstat2w2 empstat2w1

gen empstat1=ecactW1
gen empstat2=ecactW2
gen empstat3=ecactw3
gen empstat4=DVecactw4
gen empstat5=DVecactw5

gen status1= . 
/*
replace status1=1 if StatW1==1 & EmpNW1>2 &  EmpNW1<7 
replace status1=1 if StatW1==1 & EmpNW1>7 
replace status1=2 if StatW1==1 & EmpNW1==7 
replace status1=2 if StatW1==1 & EmpNW1<3 
replace status1=3 if StatW1==1 & SemNW1<0 
replace status1=4 if StatW1==1 & EmpNW1<3 
replace status1=2 if StatW1==1 & EmpNW1<3 
replace status1=2 if StatW1==1 & EmpNW1<3 
*/
gen status2=ES2000W2 
gen status3=ES2000W3 
gen status4=ES2000W4 
gen status5=ES2000W5 

gen Dage1=TEAW1
gen Dage2=TEAW2 
gen Dage3=TEAW3 
gen Dage4=TEAW4 
gen Dage5=TEAW5 

gen educ_att1=EdLevelW1
gen educ_att2=EdLevelW2
gen educ_att3=EdLevelW3
gen educ_att4=EdLevelW4
gen educ_att5=EdLevelW5

gen Renter_Owner1=.
gen Renter_Owner2=. 
gen Renter_Owner3=HhldrW3 
gen Renter_Owner4=HhldrW4 
gen Renter_Owner5=HhldrW5 

gen Joint_Renter_Owner1=.
gen Joint_Renter_Owner2=. 
gen Joint_Renter_Owner3=HiHNumW3 
gen Joint_Renter_Owner4=HiHNumW4 
gen Joint_Renter_Owner5=HiHNumW5 

gen long hid1=1000000*wave1+casew1
gen long hid2=1000000*wave2+CASEW2
gen long hid3=1000000*wave3+CASEw3
gen long hid4=1000000*wave4+CASEw4
gen long hid5=1000000*wave5+CASEw5

order hid1 hid2 hid3 hid4 hid5 casew1 CASEW2 CASEw3 CASEw4 CASEw5,first

rename DVAge17w4 DVAge17W4

keep pid hid* agew* Dage* W1W5_longwgtw* W1W4_longwgtw* W1W2_longwgtw* W2W3_longwgtw* W3W4_longwgtw* W4W5_longwgtw* flag_wave4w* nssec_five* nssec_three* nssec_eight* ind_soc* ind_sic* educ_att* sex* hoh* partner* mastat* empstat* pno* DVAge17W* main_annual_earn* main_annual_earn_i* second_semp* semp* second_annual_earn* annual_earn* bonus* total_annual_earn* total_annual_earn_All* status* earnings_flag* seearnings_flag* Renter_Owner* Joint_Renter_Owner* region*

save "`location'\\\Data\WAS_all.dta", replace

local location "C:\Users\spyro\OneDrive - University of Glasgow\Corona_project\WAS" 
use "`location'\\\Data\WAS_all.dta", clear

sort hid1  pno1 hid2  pno2 hid3  pno3 hid4  pno4 hid5  pno5

gen N=[_n]

drop sexw3 pid 

reshape  long  hid agew Dage W1W5_longwgtw W1W4_longwgtw W1W2_longwgtw W2W3_longwgtw W3W4_longwgtw W4W5_longwgtw flag_wave4w status nssec_five nssec_three nssec_eight ind_soc ind_sic educ_att hoh partner mastat sex empstat pno DVAge17W  main_annual_earn main_annual_earn_i second_semp semp semp_i second_annual_earn annual_earn annual_earn_i bonus total_annual_earn total_annual_earn_i total_annual_earn_All earnings_flag seearnings_flag Renter_Owner Joint_Renter_Owner region, i(N) j(wave)

rename N pid

drop if hid>= .

//---------------------------------------------------------------------------	
*****************  15: CLASSIFY HOUSEHOLDS AND FORM hoh_ind (AND SPOUSE) INDICATORS *********
//---------------------------------------------------------------------------	
gen marbin  = (mastat == 1) // 1 is married
gen coupbin = (mastat == 1 | mastat == 2 ) // 2 is living together as a couple

label define marlab  0 " " 1 "Married"
label define couplab 0 " " 1 "Coupled"
label values marbin marlab
label values coupbin couplab

bys hid: egen ncouple_h = sum(coupbin)
replace ncouple_h = ncouple_h / 2

gen jbhas=2
replace jbhas = 1 if empstat==1 | empstat==2

replace educ_att= 3 if educ_att==4
replace educ_att= . if educ_att <0

//---------------------------------------------------------------------------	
*****************  15: CLASSIFY HOUSEHOLDS AND FORM hoh_ind (AND SPOUSE) INDICATORS *********
//---------------------------------------------------------------------------	
gen kid=0
gen adult=0
replace kid=1 if DVAge17W<5
replace adult=1 if DVAge17W>4

bys hid: egen numkids=sum(kid)
bys hid: egen numadults=sum(adult)

// The OECD scale
generate hh_weights = 1

*one parent families
replace hh_weights = 1 + (numadults-1)*0.5 + numkids*0.3 if numadults >= 1
replace hh_weights = 1 + (numkids-1)*0.3 if numadults == 0 
//---------------------------------------------------------------------------	
*****************  15: CLASSIFY HOUSEHOLDS AND FORM hoh_ind (AND SPOUSE) INDICATORS *********
//---------------------------------------------------------------------------	

//	
gen sex_aux    =(sex == 1 & DVAge17W > 4)
bys wave hid: egen num_mat_men = sum(sex_aux)

gen work_men   = sex == 1 & jbhas == 1
bys wave hid: egen num_work_men = sum(work_men)

gen work_women =sex == 2 & jbhas == 1
bys wave hid: egen num_work_women = sum(work_women)

gen sex_aux_h = (sex == 1 & DVAge17W > 4)
bys wave hid: egen num_mat_men_h = sum(sex_aux_h)

gen work_men_h = sex == 1 & jbhas == 1
bys wave hid: egen num_work_men_h = sum(work_men_h)

gen work_women_h = sex == 2 & jbhas == 1
bys wave hid: egen num_work_women_h = sum(work_women_h)

gen hoh_ind = 0
gen spouse= 0

********** THIS IS NOT QUITE RIGHT YET, THE TREATMENT OF COUPLES IS WRONG ***********
* First do the married men, living as a couple

gsort hid sex - coupbin - DVAge17W
replace hoh_ind = 1 if hid[_n-1] != hid & sex == 1 & coupbin == 1 & ncouple_h >0
gsort hid - sex - coupbin - age pno
replace spouse = 1 if hid[_n-1] != hid & sex == 2 & coupbin == 1 & ncouple_h >0   // Need to check that the oldest female in a couple is actually married to the oldest male
cap drop done_hoh_ben
bys hid: egen done_hoh_ben = max(hoh_ind)


* Then do working men
gsort hid sex jbhas - DVAge17W pno
replace hoh_ind = 3 if done_hoh_ben == 0 & num_work_men_h >= 1 & hid[_n-1] != hid[_n] & sex == 1 & jbhas == 1 & ncouple_h >= 0
cap drop done_hoh_ben
bys hid: egen done_hoh_ben = max(hoh_ind)

* Then do working women, if there are no working men
gsort hid - sex jbhas - DVAge17W pno
replace hoh_ind = 4 if done_hoh_ben == 0 & num_work_men_h == 0 & hid[_n-1] != hid & sex == 2 & jbhas == 1 & ncouple_h >= 0
cap drop done_hoh_ben
bys hid: egen done_hoh_ben = max(hoh_ind)

* Then do oldest mature men, if there are no working people
gsort hid sex jbhas - DVAge17W pno
replace hoh_ind = 5 if done_hoh_ben == 0 & num_mat_men_h > 0 & num_work_men_h == 0 & num_work_women_h == 0 & hid[_n-1] != hid & sex == 1 & ncouple_h >= 0
cap drop done_hoh_ben
bys hid: egen done_hoh_ben = max(hoh_ind)

* Then do oldest person, if there are no adult men and no working people
gsort hid - DVAge17W pno
replace hoh_ind = 6 if done_hoh_ben == 0 & num_mat_men_h == 0 & num_work_men_h == 0 & num_work_women_h == 0 & hid[_n-1] != hid & ncouple_h >= 0
cap drop done_hoh_ben
bys hid: egen done_hoh_ben = max(hoh_ind)

label define hoh_label 1 couple 2 ss_couple 3 oldest_work_male 4 oldest_working_female 5 oldest_male 6 oldest_female
label values hoh_ind hoh_label
********************************************************************************************
*****************               Merge the household data              **********************
********************************************************************************************
sort hid pid

merge m:1 hid using "`location'\\\Data\household_wealth_data_long.dta"
keep if _m==3
drop _m
save "`location'\\\Data\auxiliary.dta", replace

********************************************************************************************
********************************************************************************************
********************************************************************************************

use "`location'\\\Data\auxiliary.dta", clear

drop N

bys pid: gen Nobs=[_N]

order hid pid wave pno DVAge17W agew sex  hoh partner Renter_Owner Joint_Renter_Owner total_annual_earn_i,first
replace Renter_Owner=10 if Renter_Owner<0

xtset pid wave 
gen age_check_aux=DVAge17W-l.DVAge17W
bys pid: egen age_check=sum(age_check_aux)
keep if age_check==0 | age_check==1 | age_check==2

gen index=0
replace index=1 if Renter_Owner==1 & wave>2
bys hid: egen index2=sum( index)
drop if index2==2
drop index index2

//Renter_Owner :  Whether owns or rents accomodation 
//1= This person alone  
//3= This person jointly  
//5= Not ownerrenter
//10= Not applicable

//Joint_Renter_Owner :  Joint householder with highest income
//1= Person 1 
//2= Person 2 
//3= Person 3 
//4= Person 4 
//5= Person 5 
//6= Person 6 
//7= Person 7 
//8= Person 8 
//17= Person outside the household
//-7= Not applicable

bys wave hid: egen max_age = max(agew)

gen hrp = 0
replace hrp = 1 if Renter_Owner==1 & wave>2
cap drop done_hrp
bys wave hid: egen done_hrp = max(hrp)

gsort hid Renter_Owner -agew sex pno
replace hrp = 1 if Renter_Owner==3 & done_hrp==0 & hid[_n-1] != hid[_n] & wave>2
cap drop done_hrp
bys wave hid: egen done_hrp = max(hrp)

gsort hid -agew sex pno total_annual_earn_i
replace hrp = 1 if done_hrp==0 & hid[_n-1] != hid[_n] & wave>2
cap drop done_hrp
bys wave hid: egen done_hrp = max(hrp)

gsort hid -DVAge17W sex pno
replace hrp = 1 if done_hrp==0 & hid[_n-1] != hid[_n] & wave<3
cap drop done_hrp
bys wave hid: egen done_hrp = max(hrp)

gsort hid -DVAge17W sex pno total_annual_earn_i
replace hrp = 1 if done_hrp==0 & hid[_n-1] != hid[_n] & wave<3
cap drop done_hrp
bys wave hid: egen done_hrp = max(hrp)

drop done_hrp

**** partner correction ****
gen partner_aux=partner-hrp
bys hid: egen check1=sum(partner)
bys hid: egen check2=sum(partner_aux)
gen check3=check1-check2
gen partner_new=0
replace partner_new=1 if partner==1 & check3==0
replace partner_new=1 if hoh==1 & check3==1

order hid pid wave pno DVAge17W agew sex hrp hoh partner Renter_Owner Joint_Renter_Owner total_annual_earn_i,first

//We define the head of household as the principal owner or renter of the property, and (where there is more than
//one) the eldest taking precedence. This emulates  procedure taken by the BHPS household reference person definition.

sort pid wave
*** DAge  "-9= Do not know " "-7= Not applicable" "-6= Error partial"  "96= Still in education" "97=No education " 
replace Dage= . if Dage<0

sort pid wave
xtset pid wave
gen educ_cortd=educ_att
replace educ_cortd= . if Dage>= . & wave==3 & Nobs>1 & (DVAge17W>4 & DVAge17W<14)

gen lll=l.educ_cortd
gen fff=f.educ_cortd

gen educ_cortd_aux=(lll+fff)/2
gen educ_cortd_Low=floor(educ_cortd_aux)
gen educ_cortd_Up=ceil(educ_cortd_aux)

replace educ_cortd=educ_cortd_Low if lll<fff & educ_cortd>= . & lll!= . & fff!= . & (DVAge17W>4 & DVAge17W<14) & wave==3
replace educ_cortd=educ_cortd_Up if lll>fff & educ_cortd>= . & lll!= . & fff!= . & (DVAge17W>4 & DVAge17W<14) & wave==3
replace educ_cortd=lll if lll==fff & educ_cortd>= . & lll!= . & fff!= . & (DVAge17W>4 & DVAge17W<14)  & wave==3
replace educ_cortd=lll if educ_cortd>= . & lll!= . & fff>= . & (DVAge17W>4 & DVAge17W<14) & wave==3
replace educ_cortd=fff if educ_cortd>= . & fff!= . & lll>= . & (DVAge17W>4 & DVAge17W<14) & wave==3

gen selection=educ_cortd-l.educ_cortd
gen index=1 if (selection==1 | selection==-1) & DVAge17W>5 & DVAge17W<14
bys pid: egen Educ_misreporting=sum(index) 
bys pid: egen correction=mean(educ_cortd)
replace correction=round(correction)
replace educ_cortd=correction if Educ_misreporting==2 & DVAge17W>5 & DVAge17W<14 & Nobs==5
drop Educ_misreporting selection index
gen selection=educ_cortd-l.educ_cortd
gen index=1 if selection==1 & DVAge17W>5 & DVAge17W<14
bys pid: egen Educ_misreporting=sum(index) 
replace educ_cortd=correction if Educ_misreporting==1 & DVAge17W>5 & DVAge17W<14 & Nobs>2
drop index selection Educ_misreporting
gen selection=educ_cortd-l.educ_cortd
gen index=1 if selection==1 & DVAge17W>5 & DVAge17W<14
bys pid: egen Educ_misreporting=sum(index) 
drop index selection

bys hid: egen Y_lab_i=sum(total_annual_earn_i)
bys hid: egen Y_lab=sum(total_annual_earn)

gen index=0
replace index=1 if earnings_flag==1 | seearnings_flag==1
bys hid: egen missing_index=sum(index)
replace Y_lab= . if missing_index>0
drop index

sort hid wave

duplicates tag hid pno,g(_t)
gen misreporting_aux=1 if _t==1
bys hid: egen misreporting=sum(misreporting_aux)
drop if misreporting>0
********************************************************************************************
********************************************************************************************
********************************************************************************************

gen sex_h_aux = sex if hrp==1
gen DVAge_h_aux = DVAge17W if hrp==1
gen educ_h_aux = educ_cortd if hrp==1
gen marstat_h_aux = mastat if hrp==1

gen sex_s_aux = sex if partner_new==1
gen DVAge_s_aux = DVAge17W if partner_new==1
gen educ_s_aux = educ_cortd if partner_new==1
********************************************************************************************
********************************************************************************************
********************************************************************************************

egen sex_h     = max(sex_h_aux), by(hid)
egen age_h     = max(DVAge_h_aux), by(hid)
egen educ_h    = max(educ_h_aux), by(hid)
egen marstat_h = max(marstat_h_aux), by(hid)

egen sex_s     = max(sex_s_aux), by(hid)
egen age_s     = max(DVAge_s_aux), by(hid)
egen educ_s    = max(educ_s_aux), by(hid)

********************************************************************************************
********************************************************************************************
********************************************************************************************
merge m:1 year using "`location'\\\Data\CPI.dta"
keep if _m==3
drop _m

gen price= cpi 

replace main_annual_earn 		=main_annual_earn/price
replace main_annual_earn_i 		=main_annual_earn_i/price
replace second_semp 			=second_semp/price
replace semp 					=semp/price
replace semp_i 					=semp_i/price
replace second_annual_earn 		=second_annual_earn/price
replace annual_earn          	=annual_earn/price
replace annual_earn_i        	=annual_earn_i/price
replace bonus 					=bonus/price
replace total_annual_earn		=total_annual_earn/price
replace total_annual_earn_i		=total_annual_earn_i/price

replace current_accounts=current_accounts/price
replace credit_current_accounts=credit_current_accounts/price
replace overdrawn_current_accounts =overdrawn_current_accounts/price
replace saving_accounts= saving_accounts/price
replace total_ISAs=total_ISAs/price
replace total_Insurance=total_Insurance/price
replace empl_shares =empl_shares/price
replace informal_assets =informal_assets/price
replace formal_assets =formal_assets/price
replace all_mortgages =all_mortgages/price
replace all_property_values =all_property_values/price
replace outstanding_credit_card =outstanding_credit_card/price
replace outstanding_store_card=outstanding_store_card/price
replace children_trust =children_trust/price
replace children_savings =children_savings/price
replace Gross_Fin_Wealth_excl =Gross_Fin_Wealth_excl/price
replace Total_Fin_liabilities =Total_Fin_liabilities/price
replace Gross_Fin_Wealth =Gross_Fin_Wealth/price
replace Net_Fin_Wealth =Net_Fin_Wealth/price
replace Total_hh_arrears =Total_hh_arrears/price
replace Total_Physical_Wealth =Total_Physical_Wealth/price
replace Total_Property_Wealth =Total_Property_Wealth/price
replace Total_Pension_Wealth =Total_Pension_Wealth/price
replace Total_Wealth =Total_Wealth/price
replace Net_annual_income =Net_annual_income/price
replace Gross_annual_income =Gross_annual_income/price
replace Gross_self_income =Gross_self_income/price
replace Gross_self_income =Gross_self_income
replace Gross_empl_income =0 if Gross_empl_income>= .
replace Gross_empl_income =Gross_empl_income/price
replace total_benefit_income =total_benefit_income/price
replace gross_royalties_income =gross_royalties_income/price
replace gross_other_income =gross_other_income/price
replace gross_maint_income =gross_maint_income/price
replace gross_outside_income =gross_outside_income/price
replace gross_educgrant_income =gross_educgrant_income/price
replace gross_govtrain_income =gross_govtrain_income/price
replace gross_redundancy_income=gross_redundancy_income/price
replace gross_private_pen_income = gross_private_pen_income/price
replace net_private_pen_income =net_private_pen_income/price
replace gross_overseas_pen_income =gross_overseas_pen_income/price
replace net_overseas_pen_income=net_overseas_pen_income/price


replace Y_lab=Y_lab/price
replace Y_lab_i=Y_lab_i/price

replace Net_self_income =Net_self_income/price
replace Net_self_income =Net_self_income
replace Net_empl_income =0 if Net_empl_income>= .
replace Net_empl_income =Net_empl_income/price
replace Net_outside_income =Net_outside_income/price
replace Net_educgrant_income =Net_educgrant_income/price
replace Net_govtrain_income =Net_govtrain_income/price
replace Net_redundancy_income=Net_redundancy_income/price

gen     gross_variable_income=Gross_self_income+Gross_empl_income+total_benefit_income+gross_outside_income+gross_educgrant_income+gross_govtrain_income+gross_redundancy_income
gen     net_variable_income=Net_self_income+Net_empl_income+total_benefit_income+Net_outside_income+Net_educgrant_income+Net_govtrain_income+Net_redundancy_income


gen net_worth=Net_Fin_Wealth+Total_Property_Wealth
gen Y_L=Gross_self_income+Gross_empl_income
gen Y_lab_eq=Y_lab/hh_weights
gen Y_lab_eq_i=Y_lab_i/hh_weights
gen Y_L_eq=Gross_self_income/hh_weights+Gross_empl_income/hh_weights
gen Net_annual_income_eq=Net_annual_income/hh_weights
gen Gross_annual_income_eq=Gross_annual_income/hh_weights
gen Gross_self_income_eq=Gross_self_income/hh_weights
gen Gross_empl_income_eq=Gross_empl_income/hh_weights
gen gross_variable_income_eq=gross_variable_income/hh_weights
gen net_variable_income_eq=net_variable_income/hh_weights

gen Y_L_eq_i=Y_L_eq
replace Y_L_eq= . if missing_index>0

gen Y_L_i=Y_L
replace Y_L= . if missing_index>0

****************************************************************************
****************************************************************************
****************************************************************************
****************************************************************************
****************************************************************************

label var empstat "Employment Status"
label define empstat 1 "Employee" 2 "Self-Employed" 3 "ILO Unemployed" 4 "Inactive Student " 5 "Inactive looking after the family/home" 6 "Inactive temporarily sick or injured " 7 "Inactive Long-term sick or disabled" 8 " Inactive Retired from paid work " 9 "Inactive - other or no reason given " 
label values empstat empstat

label var educ_att "Education level"
label define educ_att 1 "Degree level or above" 2 "Other level qualifications" 3 "No qualifications" 
label values educ_att educ_att

label var educ_cortd "Education level Corrected"
label define educ_cortd 1 "Degree level or above" 2 "Other level qualifications" 3 "No qualifications" 
label values educ_cortd educ_cortd

label var main_annual_earn      "Individual Annual Labour Income from main Job"
label var main_annual_earn_i    "Individual Annual Labour Income from main Job (incl. imputed values)"
label var second_semp           "Individual Annual Self Empl. Income from second Job"
label var semp                  "Total Individual Annual Self Empl. Income"
label var semp_i                "Total Individual Annual Self Empl. Income (incl. imputed values)"
label var second_annual_earn    "Individual Annual Employee Income from second Job"
label var annual_earn      		"Total Individual Annual Employee Income (incl. imputed values)"
label var annual_earn_i         "Total Individual Annual Employee Income (incl. imputed values)"
label var bonus                 "Individual Annual Income from Bonuses"
label var total_annual_earn     "Total Individual Annual Labour Income"
label var total_annual_earn_i   "Total Individual Annual Labour Income (incl. imputed values)"
 
label var Net_annual_income_eq      "Eq. Household Annual Net Income"
label var Gross_annual_income_eq    "Eq. Household Annual Gross  Income"
label var Gross_self_income_eq      "Eq. Household Annual Self Employment Income"
label var Gross_empl_income_eq      "Eq. Household Annual Employee Income"
label var gross_variable_income_eq  "Eq. Household Annual Earnings plus Benefits and Transfers Income"
label var Y_lab_eq    				"Derived Eq. Household Annual Earnings"
label var Y_lab_eq_i    			"Derived Eq. Household Annual Earnings (incl. imputed values)"
label var Y_L_eq       				"Eq. Household Annual Earnings"
label var Y_L_eq_i		         	"Eq. Household Annual Earnings (incl. imputed values)"

label var net_worth                 "Household Net Worth"
label var Total_Fin_liabilities     "Household Total Financial Liabilities"
label var Gross_Fin_Wealth   		"Household Gross Financial Wealth"
label var Net_Fin_Wealth   			"Household Net Financial Wealth"
label var all_mortgages   			"Household Values of all Mortgages and Amount Owed"
label var all_property_values   	"Household Sum of all Property Values" 
label var Total_Property_Wealth   	"Total property wealth"

****************************************************************************
****************************************************************************
****************************************************************************
****************************************************************************
****************************************************************************
# delimit ;
order pid hid pno wave year sex agew Dage Educ_misreporting DVAge17W  hrp hoh partner hoh_ind spouse sampl_weights W1W5_longwgtw W1W4_longwgtw W1W2_longwgtw W2W3_longwgtw W3W4_longwgtw W4W5_longwgtw flag_wave4w  educ_cortd educ_att head_educ status nssec_five nssec_three nssec_eight ind_soc ind_sic mastat empstat price marbin coupbin ncouple_h jbhas kid adult numkids
      numadults hh_weights  sex_h age_h educ_h marstat_h Nobs sex_s age_s educ_s region
	  current_accounts credit_current_accounts overdrawn_current_accounts saving_accounts total_ISAs total_Insurance empl_shares informal_assets formal_assets all_mortgages all_property_values 
	  outstanding_credit_card outstanding_store_card children_trust children_savings Gross_Fin_Wealth_excl Total_Fin_liabilities Gross_Fin_Wealth Net_Fin_Wealth Total_hh_arrears Total_Physical_Wealth Total_Property_Wealth Total_Pension_Wealth Total_Wealth net_worth
	  Net_annual_income Gross_annual_income Gross_self_income Gross_empl_income total_benefit_income gross_royalties_income gross_other_income gross_maint_income gross_outside_income gross_educgrant_income gross_govtrain_income gross_redundancy_income gross_investment_income  gross_private_pen_income net_private_pen_income gross_overseas_pen_income net_overseas_pen_income
	  Y_lab Y_lab_i Y_L Y_L_i missing_index gross_variable_income net_variable_income Y_lab_eq Y_L_eq Net_annual_income_eq Gross_annual_income_eq Gross_self_income_eq Gross_empl_income_eq gross_variable_income_eq net_variable_income_eq Y_lab_eq_i Y_L_eq_i main_annual_earn main_annual_earn_i second_semp semp_i semp second_annual_earn annual_earn annual_earn_i bonus total_annual_earn total_annual_earn_i total_annual_earn_All;
# delimit cr
keep pid-total_annual_earn_All
save "`location'\\\Data\all_wealth_data_long2.dta", replace
