clear all

**need to customize this directory
local location "C:\Users\spyro\OneDrive - University of Glasgow\Corona_project\WAS\"

use "`location'\\Raw_Data\UKDA-7215-stata11_se\stata11_se\was_wave_5_hhold_eul_final.dta", clear
gen wave5=5

gen year1=YearW1
gen year2=YearW2
gen year3=YearW3
gen year4=Yearw4
gen year5=YearW5

merge m:1  CASEw4  using "`location'\\Raw_Data\UKDA-7215-stata11_se\stata11_se\was_wave_4_hhold_eul_final.dta"
gen wave4=4 if _m==2 | _m==3
drop _m
replace YearW1=.  if YearW1<0
replace YearW2=.  if YearW2<0
replace YearW3=.  if YearW3<0
replace Yearw4=.  if Yearw4<0

replace year1=YearW1 if year1>= . & YearW1!= .
replace year2=YearW2 if year2>= . & YearW2!= .
replace year3=YearW3 if year3>= . & YearW3!= .
replace year4=Yearw4 if year4>= . & Yearw4!= .

merge m:1  CASEw3  using "`location'\\Raw_Data\UKDA-7215-stata11_se\stata11_se\was_wave_3_hhold_eul_final.dta"
gen wave3=3 if _m==2 | _m==3
drop _m

merge m:1  CASEW2 using "`location'\\Raw_Data\UKDA-7215-stata11_se\stata11_se\was_wave_2_hhold_eul.dta"
gen wave2=2 if _m==2 | _m==3
drop _m

merge m:1  casew1 using "`location'\\Raw_Data\UKDA-7215-stata11_se\stata11_se\was_wave_1_hhold_eul.dta"
gen wave1=1 if _m==2 | _m==3
drop _m

# delimit ;
keep wave1 wave2 wave3 wave4 wave5 casew1 CASEW2 CASEw3 CASEw4 CASEw5 year1 year2 year3 year4 year5 w4xshhwgt w3xswgt XS_calwgtW2 XS_wgtW1 w5xshhwgt DVCAValw5_aggr DVCAValw4_aggr DVCAValW3_aggr DVCAValW2_aggr DVCAValW1_sum
HRPEdLevelW5 HRPEdLevelW4 HRPEdLevelW3 HRPEdLevelW2 HRPEdLevelW1  DVCaCrValw5_aggr DVCaCrValw4_aggr DVCaCrValW3_aggr DVCACrValW2_aggr DVCACrValW1_sum
DVCAOdValw5_aggr DVCAOdValw4_aggr DVCAOdValW3_aggr DVCAODValW2_aggr DVCAODValW1_sum DVSAValW1_sum DVSaValW2_aggr DVSaValW3_aggr DVSaValw4_aggr DVSaValw5_aggr
DVISAValw5_aggr DVISAValw4_aggr DVISAValw3_aggr DVISAValW2_aggr DVISAValW1_sum DVInsVw5_aggr DVInsVw4_aggr DVInsVw3_aggr DVInsVW2_aggr DVInsVW1_sum
DVFESHARESw5_aggr DVFESHARESw4_aggr DVFESHARESw3_aggr DVFESharesW2_aggr DVFESharesW1_sum DVFInfValw5_aggr DVFInfValw4_aggr DVFInfValw3_aggr DVFInfValW2_aggr DVFInfValW1_sum
DVFFAssetsw5_aggr DVFFAssetsw4_aggr DVFFAssetsW3_aggr DVFFAssetsW2_aggr DVFFAssetsW1_sum HMORTGw5 HMORTGW4 HMORTGW3 HMortgW2 HMortgW1
DVPropertyw5 DVPropertyW4 DVPropertyW3 DVPropertyW2 DVPropertyW1 TOTCCw5_aggr TOTCCw4_aggr TOTCCW3_aggr TOTCCW2_aggr TOTCCW1_sum
TOTSCw5_aggr TOTSCw4_aggr TOTSCW3_aggr TOTSCW2_aggr TOTSCW1_sum DVCACTvw5_aggr DVCACTvw4_aggr DVCACTvW3_aggr DVCACTVW2_aggr DVCACTVW1_sum
DVCASVVw5_aggr DVCASVVw4_aggr DVCASVVW3_aggr DVCASVVW2_aggr DVCASVVW1_sum HFINW_excENDWw5_aggr HFINW_excENDWw4_aggr HFINW_excENDWW3_aggr HFINW_excENDWW2_aggr HFINW_excendWW1_SUM
HFINLw5_aggr HFINLw4_aggr HFINLW3_aggr HFINLW2_aggr HFINLW1_SUM  HFINWw5_sum HFINWW4_sum HFINWW3_sum HFINWW2_sum HFINWW1_sum HFINWNTw5_sum HFINWNTW4_sum HFINWNTW3_sum HFINWNTW2_sum HFINWNTW1_sum
TotArr_excMortw5_aggr TotArr_excMortw4_aggr TotArr_excMortW3_aggr TotArr_excMortW2_aggr HPHYSWW5 HPHYSWW4 HPHYSWW3 HPHYSWW2 HPHYSWW1
HPROPWw5 HPROPWW4 HPROPWW3 HPROPWW2 HPROPWW1  TOTPENw5_aggr TOTPENw4_aggr TOTPENw3_aggr TOTPENW2_Aggr TotpenW1_Sum  TotWlthW5 TotWlthW4 TotWlthW3 TotWlthW2 TotWlthW1
DVTotNIRW5 DVTotNIRW4 DVTotNIRw3 DVTotGIRW5 DVTotGIRW4 DVTotGIRw3 DVGISEw5_AGGR DVGISEw4_AGGR DVGISEw3_AGGR DVNISEw5_aggr DVNISEW4_aggr DVNISEw3_aggr
DVGIEMPw5_AGGR DVGIEMPw4_AGGR DVGIEMPw3_AGGR  DVNIEMPw5_aggr DVNIEMPW4_aggr DVNIEMPw3_aggr DVBenefitAnnualw5_aggr DVBenefitAnnualW4_aggr DVTotAllBenAnnualw3_aggr
DVoiGroAnnualw5_aggr DVoiGroAnnualW4_aggr DVoiGroAnnualw3_aggr DVGIothRw5_aggr DVGIothRW4_aggr DVGIothRw3_aggr DVoiGmaAnnualw5_aggr DVoiGmaAnnualW4_aggr DVoiGmaAnnualw3_aggr
DVoiGfrAnnualw5_aggr DVoiGfrAnnualW4_aggr DVoiGfrAnnualw3_aggr DVoiNfrAnnualw5_aggr DVoiNfrAnnualW4_aggr DVoiNfrAnnualw3_aggr DVoiGegAnnualw5_aggr DVoiGegAnnualW4_aggr DVoiGegAnnualw3_aggr
DVoiNegAnnualw5_aggr DVoiNegAnnualW4_aggr DVoiNegAnnualw3_aggr DVoiGgtAnnualw5_aggr DVoiGgtAnnualW4_aggr DVoiGgtAnnualw3_aggr 
DVoiNgtAnnualw5_aggr DVoiNgtAnnualW4_aggr DVoiNgtAnnualw3_aggr DVoiGrrAnnualw5_aggr DVoiGrrAnnualW4_aggr DVoiGrrAnnualw3_aggr
DVoiNrrAnnualw5_aggr DVoiNrrAnnualW4_aggr DVoiNrrAnnualw3_aggr DVGIINVw5_aggr DVGIINVW4_aggr DVGIINVw3_aggr
DVGIPPENw3_AGGR DVNIPpenw3_aggr DVoiNopAnnualw3_aggr DVoiGopAnnualw3_aggr 
DVGIPPENw4_AGGR DVNIPpenW4_aggr DVoiNopAnnualW4_aggr DVoiGopAnnualW4_aggr
DVGIPPENw5_AGGR DVNIPpenw5_aggr DVoiNopAnnualw5_aggr DVoiGopAnnualw5_aggr;
# delimit cr

# delimit ;
order wave1 wave2 wave3 wave4 wave5  casew1 CASEW2 CASEw3 CASEw4 CASEw5 year1 year2 year3 year4 year5 w4xshhwgt w3xswgt XS_calwgtW2 XS_wgtW1 w5xshhwgt DVCAValw5_aggr DVCAValw4_aggr DVCAValW3_aggr DVCAValW2_aggr DVCAValW1_sum
HRPEdLevelW5 HRPEdLevelW4 HRPEdLevelW3 HRPEdLevelW2 HRPEdLevelW1  DVCaCrValw5_aggr DVCaCrValw4_aggr DVCaCrValW3_aggr DVCACrValW2_aggr DVCACrValW1_sum
DVCAOdValw5_aggr DVCAOdValw4_aggr DVCAOdValW3_aggr DVCAODValW2_aggr DVCAODValW1_sum DVSAValW1_sum DVSaValW2_aggr DVSaValW3_aggr DVSaValw4_aggr DVSaValw5_aggr
DVISAValw5_aggr DVISAValw4_aggr DVISAValw3_aggr DVISAValW2_aggr DVISAValW1_sum DVInsVw5_aggr DVInsVw4_aggr DVInsVw3_aggr DVInsVW2_aggr DVInsVW1_sum
DVFESHARESw5_aggr DVFESHARESw4_aggr DVFESHARESw3_aggr DVFESharesW2_aggr DVFESharesW1_sum DVFInfValw5_aggr DVFInfValw4_aggr DVFInfValw3_aggr DVFInfValW2_aggr DVFInfValW1_sum
DVFFAssetsw5_aggr DVFFAssetsw4_aggr DVFFAssetsW3_aggr DVFFAssetsW2_aggr DVFFAssetsW1_sum HMORTGw5 HMORTGW4 HMORTGW3 HMortgW2 HMortgW1
DVPropertyw5 DVPropertyW4 DVPropertyW3 DVPropertyW2 DVPropertyW1 TOTCCw5_aggr TOTCCw4_aggr TOTCCW3_aggr TOTCCW2_aggr TOTCCW1_sum
TOTSCw5_aggr TOTSCw4_aggr TOTSCW3_aggr TOTSCW2_aggr TOTSCW1_sum DVCACTvw5_aggr DVCACTvw4_aggr DVCACTvW3_aggr DVCACTVW2_aggr DVCACTVW1_sum
DVCASVVw5_aggr DVCASVVw4_aggr DVCASVVW3_aggr DVCASVVW2_aggr DVCASVVW1_sum HFINW_excENDWw5_aggr HFINW_excENDWw4_aggr HFINW_excENDWW3_aggr HFINW_excENDWW2_aggr HFINW_excendWW1_SUM
HFINLw5_aggr HFINLw4_aggr HFINLW3_aggr HFINLW2_aggr HFINLW1_SUM  HFINWw5_sum HFINWW4_sum HFINWW3_sum HFINWW2_sum HFINWW1_sum HFINWNTw5_sum HFINWNTW4_sum HFINWNTW3_sum HFINWNTW2_sum HFINWNTW1_sum
TotArr_excMortw5_aggr TotArr_excMortw4_aggr TotArr_excMortW3_aggr TotArr_excMortW2_aggr HPHYSWW5 HPHYSWW4 HPHYSWW3 HPHYSWW2 HPHYSWW1
HPROPWw5 HPROPWW4 HPROPWW3 HPROPWW2 HPROPWW1  TOTPENw5_aggr TOTPENw4_aggr TOTPENw3_aggr TOTPENW2_Aggr TotpenW1_Sum  TotWlthW5 TotWlthW4 TotWlthW3 TotWlthW2 TotWlthW1
DVTotNIRW5 DVTotNIRW4 DVTotNIRw3 DVTotGIRW5 DVTotGIRW4 DVTotGIRw3 DVGISEw5_AGGR DVGISEw4_AGGR DVGISEw3_AGGR DVNISEw5_aggr DVNISEW4_aggr DVNISEw3_aggr
DVGIEMPw5_AGGR DVGIEMPw4_AGGR DVGIEMPw3_AGGR  DVNIEMPw5_aggr DVNIEMPW4_aggr DVNIEMPw3_aggr DVBenefitAnnualw5_aggr DVBenefitAnnualW4_aggr DVTotAllBenAnnualw3_aggr
DVoiGroAnnualw5_aggr DVoiGroAnnualW4_aggr DVoiGroAnnualw3_aggr DVGIothRw5_aggr DVGIothRW4_aggr DVGIothRw3_aggr DVoiGmaAnnualw5_aggr DVoiGmaAnnualW4_aggr DVoiGmaAnnualw3_aggr
DVoiGfrAnnualw5_aggr DVoiGfrAnnualW4_aggr DVoiGfrAnnualw3_aggr DVoiNfrAnnualw5_aggr DVoiNfrAnnualW4_aggr DVoiNfrAnnualw3_aggr DVoiGegAnnualw5_aggr DVoiGegAnnualW4_aggr DVoiGegAnnualw3_aggr
DVoiNegAnnualw5_aggr DVoiNegAnnualW4_aggr DVoiNegAnnualw3_aggr DVoiGgtAnnualw5_aggr DVoiGgtAnnualW4_aggr DVoiGgtAnnualw3_aggr 
DVoiNgtAnnualw5_aggr DVoiNgtAnnualW4_aggr DVoiNgtAnnualw3_aggr DVoiGrrAnnualw5_aggr DVoiGrrAnnualW4_aggr DVoiGrrAnnualw3_aggr
DVoiNrrAnnualw5_aggr DVoiNrrAnnualW4_aggr DVoiNrrAnnualw3_aggr DVGIINVw5_aggr DVGIINVW4_aggr DVGIINVw3_aggr
DVGIPPENw3_AGGR DVNIPpenw3_aggr DVoiNopAnnualw3_aggr DVoiGopAnnualw3_aggr 
DVGIPPENw4_AGGR DVNIPpenW4_aggr DVoiNopAnnualW4_aggr DVoiGopAnnualW4_aggr
DVGIPPENw5_AGGR DVNIPpenw5_aggr DVoiNopAnnualw5_aggr DVoiGopAnnualw5_aggr;
# delimit cr

save "`location'\\Data\household_wealth_data.dta", replace


clear all

use "`location'\\Data\household_wealth_data.dta", clear

replace year4=year5-2 if year4>= . & year5!= .
replace year3=year5-4 if year3>= . & year5!= .
replace year2=year5-6 if year2>= . & year5!= .
replace year1=year5-8 if year1>= . & year5!= .

replace year5=year4+2 if year5>= . & year4!= .
replace year3=year4-2 if year3>= . & year4!= .
replace year2=year4-4 if year2>= . & year4!= .
replace year1=year4-6 if year1>= . & year4!= .

replace year5=year3+4 if year5>= . & year3!= .
replace year4=year3+2 if year4>= . & year3!= .
replace year2=year3-2 if year2>= . & year3!= .
replace year1=year3-4 if year1>= . & year3!= .

replace year1=2007 if year1>= .
replace year2=2009 if year2>= .
replace year3=2011 if year3>= .
replace year4=2013 if year4>= .
replace year5=2015 if year5>= .

replace  year1= . if casew1>= .
replace  year2= . if CASEW2>= .
replace  year3= . if CASEw3>= .
replace  year4= . if CASEw4>= .
replace  year5= . if CASEw5>= .

gen long hid1=1000000*wave1+casew1
gen long hid2=1000000*wave2+CASEW2
gen long hid3=1000000*wave3+CASEw3
gen long hid4=1000000*wave4+CASEw4
gen long hid5=1000000*wave5+CASEw5

drop casew1 CASEW2 CASEw3 CASEw4 CASEw5

gen sampl_weights1=XS_wgtW1
gen sampl_weights2=XS_calwgtW2
gen sampl_weights3=w3xswgt
gen sampl_weights4=w4xshhwgt
gen sampl_weights5=w5xshhwgt
   
drop w4xshhwgt w3xswgt XS_calwgtW2 XS_wgtW1 w5xshhwgt

gen current_accounts1=DVCAValW1_sum
gen current_accounts2=DVCAValW2_aggr
gen current_accounts3=DVCAValW3_aggr
gen current_accounts4=DVCAValw4_aggr
gen current_accounts5=DVCAValw5_aggr

drop DVCAValw5_aggr DVCAValw4_aggr DVCAValW3_aggr DVCAValW2_aggr DVCAValW1_sum

gen head_educ1=HRPEdLevelW1
gen head_educ2=HRPEdLevelW2
gen head_educ3=HRPEdLevelW3
gen head_educ4=HRPEdLevelW4
gen head_educ5=HRPEdLevelW5

drop HRPEdLevelW5 HRPEdLevelW4 HRPEdLevelW3 HRPEdLevelW2 HRPEdLevelW1

gen credit_current_accounts1=DVCACrValW1_sum
gen credit_current_accounts2=DVCACrValW2_aggr
gen credit_current_accounts3=DVCaCrValW3_aggr
gen credit_current_accounts4=DVCaCrValw4_aggr
gen credit_current_accounts5=DVCaCrValw5_aggr

drop DVCaCrValw5_aggr DVCaCrValw4_aggr DVCaCrValW3_aggr DVCACrValW2_aggr DVCACrValW1_sum

gen overdrawn_current_accounts1=DVCAODValW1_sum
gen overdrawn_current_accounts2=DVCAODValW2_aggr
gen overdrawn_current_accounts3=DVCAOdValW3_aggr
gen overdrawn_current_accounts4=DVCAOdValw4_aggr
gen overdrawn_current_accounts5=DVCAOdValw5_aggr

drop DVCAOdValw5_aggr DVCAOdValw4_aggr DVCAOdValW3_aggr DVCAODValW2_aggr DVCAODValW1_sum

gen saving_accounts1=DVSAValW1_sum
gen saving_accounts2=DVSaValW2_aggr
gen saving_accounts3=DVSaValW3_aggr
gen saving_accounts4=DVSaValw4_aggr
gen saving_accounts5=DVSaValw5_aggr

drop DVSAValW1_sum DVSaValW2_aggr DVSaValW3_aggr DVSaValw4_aggr DVSaValw5_aggr

gen total_ISAs1=DVISAValW1_sum
gen total_ISAs2=DVISAValW2_aggr
gen total_ISAs3=DVISAValw3_aggr
gen total_ISAs4=DVISAValw4_aggr
gen total_ISAs5=DVISAValw5_aggr

drop DVISAValw5_aggr DVISAValw4_aggr DVISAValw3_aggr DVISAValW2_aggr DVISAValW1_sum

gen total_Insurance1=DVInsVW1_sum
gen total_Insurance2=DVInsVW2_aggr
gen total_Insurance3=DVInsVw3_aggr
gen total_Insurance4=DVInsVw4_aggr
gen total_Insurance5=DVInsVw5_aggr

drop DVInsVw5_aggr DVInsVw4_aggr DVInsVw3_aggr DVInsVW2_aggr DVInsVW1_sum

gen empl_shares1=DVFESharesW1_sum
gen empl_shares2=DVFESharesW2_aggr
gen empl_shares3=DVFESHARESw3_aggr
gen empl_shares4=DVFESHARESw4_aggr
gen empl_shares5=DVFESHARESw5_aggr

drop DVFESHARESw5_aggr DVFESHARESw4_aggr DVFESHARESw3_aggr DVFESharesW2_aggr DVFESharesW1_sum

gen informal_assets1=DVFInfValW1_sum
gen informal_assets2=DVFInfValW2_aggr
gen informal_assets3=DVFInfValw3_aggr
gen informal_assets4=DVFInfValw4_aggr
gen informal_assets5=DVFInfValw5_aggr

drop DVFInfValw5_aggr DVFInfValw4_aggr DVFInfValw3_aggr DVFInfValW2_aggr DVFInfValW1_sum

gen formal_assets1=DVFFAssetsW1_sum
gen formal_assets2=DVFFAssetsW2_aggr
gen formal_assets3=DVFFAssetsW3_aggr
gen formal_assets4=DVFFAssetsw4_aggr
gen formal_assets5=DVFFAssetsw5_aggr

drop DVFFAssetsw5_aggr DVFFAssetsw4_aggr DVFFAssetsW3_aggr DVFFAssetsW2_aggr DVFFAssetsW1_sum

gen all_mortgages1=HMortgW1
gen all_mortgages2=HMortgW2
gen all_mortgages3=HMORTGW3
gen all_mortgages4=HMORTGW4
gen all_mortgages5=HMORTGw5

drop HMORTGw5 HMORTGW4 HMORTGW3 HMortgW2 HMortgW1

gen all_property_values1=DVPropertyW1
gen all_property_values2=DVPropertyW2
gen all_property_values3=DVPropertyW3
gen all_property_values4=DVPropertyW4
gen all_property_values5=DVPropertyw5

drop DVPropertyw5 DVPropertyW4 DVPropertyW3 DVPropertyW2 DVPropertyW1

gen outstanding_credit_card1=TOTCCW1_sum
gen outstanding_credit_card2=TOTCCW2_aggr
gen outstanding_credit_card3=TOTCCW3_aggr
gen outstanding_credit_card4=TOTCCw4_aggr
gen outstanding_credit_card5=TOTCCw5_aggr

drop TOTCCw5_aggr TOTCCw4_aggr TOTCCW3_aggr TOTCCW2_aggr TOTCCW1_sum

gen outstanding_store_card1=TOTSCW1_sum
gen outstanding_store_card2=TOTSCW2_aggr
gen outstanding_store_card3=TOTSCW3_aggr
gen outstanding_store_card4=TOTSCw4_aggr
gen outstanding_store_card5=TOTSCw5_aggr

drop TOTSCw5_aggr TOTSCw4_aggr TOTSCW3_aggr TOTSCW2_aggr TOTSCW1_sum

gen children_trust1=DVCACTVW1_sum
gen children_trust2=DVCACTVW2_aggr
gen children_trust3=DVCACTvW3_aggr
gen children_trust4=DVCACTvw4_aggr
gen children_trust5=DVCACTvw5_aggr

drop DVCACTvw5_aggr DVCACTvw4_aggr DVCACTvW3_aggr DVCACTVW2_aggr DVCACTVW1_sum

gen children_savings1=DVCASVVW1_sum
gen children_savings2=DVCASVVW2_aggr
gen children_savings3=DVCASVVW3_aggr
gen children_savings4=DVCASVVw4_aggr
gen children_savings5=DVCASVVw5_aggr

drop DVCASVVw5_aggr DVCASVVw4_aggr DVCASVVW3_aggr DVCASVVW2_aggr DVCASVVW1_sum

gen Gross_Fin_Wealth_excl1=HFINW_excendWW1_SUM
gen Gross_Fin_Wealth_excl2=HFINW_excENDWW2_aggr
gen Gross_Fin_Wealth_excl3=HFINW_excENDWW3_aggr
gen Gross_Fin_Wealth_excl4=HFINW_excENDWw4_aggr
gen Gross_Fin_Wealth_excl5=HFINW_excENDWw5_aggr

drop HFINW_excENDWw5_aggr HFINW_excENDWw4_aggr HFINW_excENDWW3_aggr HFINW_excENDWW2_aggr HFINW_excendWW1_SUM


gen Total_Fin_liabilities1=HFINLW1_SUM
gen Total_Fin_liabilities2=HFINLW2_aggr
gen Total_Fin_liabilities3=HFINLW3_aggr
gen Total_Fin_liabilities4=HFINLw4_aggr
gen Total_Fin_liabilities5=HFINLw5_aggr

drop HFINLw5_aggr HFINLw4_aggr HFINLW3_aggr HFINLW2_aggr HFINLW1_SUM

gen Gross_Fin_Wealth1=HFINWW1_sum
gen Gross_Fin_Wealth2=HFINWW2_sum
gen Gross_Fin_Wealth3=HFINWW3_sum
gen Gross_Fin_Wealth4=HFINWW4_sum
gen Gross_Fin_Wealth5=HFINWw5_sum

drop HFINWw5_sum HFINWW4_sum HFINWW3_sum HFINWW2_sum HFINWW1_sum

gen Net_Fin_Wealth1=HFINWNTW1_sum
gen Net_Fin_Wealth2=HFINWNTW2_sum
gen Net_Fin_Wealth3=HFINWNTW3_sum
gen Net_Fin_Wealth4=HFINWNTW4_sum
gen Net_Fin_Wealth5=HFINWNTw5_sum

drop HFINWNTw5_sum HFINWNTW4_sum HFINWNTW3_sum HFINWNTW2_sum HFINWNTW1_sum

gen Total_hh_arrears1= .
gen Total_hh_arrears2=TotArr_excMortW2_aggr
gen Total_hh_arrears3=TotArr_excMortW3_aggr
gen Total_hh_arrears4=TotArr_excMortw4_aggr
gen Total_hh_arrears5=TotArr_excMortw5_aggr

drop TotArr_excMortw5_aggr TotArr_excMortw4_aggr TotArr_excMortW3_aggr TotArr_excMortW2_aggr

gen Total_Physical_Wealth1=HPHYSWW1
gen Total_Physical_Wealth2=HPHYSWW2
gen Total_Physical_Wealth3=HPHYSWW3
gen Total_Physical_Wealth4=HPHYSWW4
gen Total_Physical_Wealth5=HPHYSWW5

drop HPHYSWW5 HPHYSWW4 HPHYSWW3 HPHYSWW2 HPHYSWW1

gen Total_Property_Wealth1=HPROPWW1
gen Total_Property_Wealth2=HPROPWW2
gen Total_Property_Wealth3=HPROPWW3
gen Total_Property_Wealth4=HPROPWW4
gen Total_Property_Wealth5=HPROPWw5

drop HPROPWw5 HPROPWW4 HPROPWW3 HPROPWW2 HPROPWW1

gen Total_Pension_Wealth1=TotpenW1_Sum
gen Total_Pension_Wealth2=TOTPENW2_Aggr
gen Total_Pension_Wealth3=TOTPENw3_aggr
gen Total_Pension_Wealth4=TOTPENw4_aggr
gen Total_Pension_Wealth5=TOTPENw5_aggr

drop TOTPENw5_aggr TOTPENw4_aggr TOTPENw3_aggr TOTPENW2_Aggr TotpenW1_Sum

gen Total_Wealth1=TotWlthW1
gen Total_Wealth2=TotWlthW2
gen Total_Wealth3=TotWlthW3
gen Total_Wealth4=TotWlthW4
gen Total_Wealth5=TotWlthW5

drop TotWlthW5 TotWlthW4 TotWlthW3 TotWlthW2 TotWlthW1

gen Net_annual_income1= .
gen Net_annual_income2= .
gen Net_annual_income3=DVTotNIRw3
gen Net_annual_income4=DVTotNIRW4
gen Net_annual_income5=DVTotNIRW5

drop DVTotNIRW5 DVTotNIRW4 DVTotNIRw3

gen Gross_annual_income1= .
gen Gross_annual_income2= .
gen Gross_annual_income3=DVTotGIRw3
gen Gross_annual_income4=DVTotGIRW4
gen Gross_annual_income5=DVTotGIRW5

drop DVTotGIRW5 DVTotGIRW4 DVTotGIRw3


gen Gross_self_income1= .
gen Gross_self_income2= .
gen Gross_self_income3=DVGISEw3_AGGR
gen Gross_self_income4=DVGISEw4_AGGR
gen Gross_self_income5=DVGISEw5_AGGR

drop DVGISEw5_AGGR DVGISEw4_AGGR DVGISEw3_AGGR

gen Net_self_income1= .
gen Net_self_income2= .
gen Net_self_income3=DVNISEw3_aggr
gen Net_self_income4=DVNISEW4_aggr
gen Net_self_income5=DVNISEw5_aggr

drop DVNISEw5_aggr DVNISEW4_aggr DVNISEw3_aggr

gen Gross_empl_income1= .
gen Gross_empl_income2= .
gen Gross_empl_income3=DVGIEMPw3_AGGR
gen Gross_empl_income4=DVGIEMPw4_AGGR
gen Gross_empl_income5=DVGIEMPw5_AGGR

drop DVGIEMPw5_AGGR DVGIEMPw4_AGGR DVGIEMPw3_AGGR

gen Net_empl_income1= .
gen Net_empl_income2= .
gen Net_empl_income3=DVNIEMPw3_aggr
gen Net_empl_income4=DVNIEMPW4_aggr
gen Net_empl_income5=DVNIEMPw5_aggr

drop DVNIEMPw5_aggr DVNIEMPW4_aggr DVNIEMPw3_aggr

gen total_benefit_income1= .
gen total_benefit_income2= .
gen total_benefit_income3=DVTotAllBenAnnualw3_aggr
gen total_benefit_income4=DVBenefitAnnualW4_aggr
gen total_benefit_income5=DVBenefitAnnualw5_aggr

drop DVBenefitAnnualw5_aggr DVBenefitAnnualW4_aggr DVTotAllBenAnnualw3_aggr

gen gross_royalties_income1= .
gen gross_royalties_income2= .
gen gross_royalties_income3=DVoiGroAnnualw3_aggr
gen gross_royalties_income4=DVoiGroAnnualW4_aggr
gen gross_royalties_income5=DVoiGroAnnualw5_aggr

drop DVoiGroAnnualw5_aggr DVoiGroAnnualW4_aggr DVoiGroAnnualw3_aggr

gen gross_other_income1= .
gen gross_other_income2= .
gen gross_other_income3=DVGIothRw3_aggr
gen gross_other_income4=DVGIothRW4_aggr
gen gross_other_income5=DVGIothRw5_aggr

drop DVGIothRw5_aggr DVGIothRW4_aggr DVGIothRw3_aggr

gen gross_maint_income1= .
gen gross_maint_income2= .
gen gross_maint_income3=DVoiGmaAnnualw3_aggr
gen gross_maint_income4=DVoiGmaAnnualW4_aggr
gen gross_maint_income5=DVoiGmaAnnualw5_aggr

drop DVoiGmaAnnualw5_aggr DVoiGmaAnnualW4_aggr DVoiGmaAnnualw3_aggr


gen gross_outside_income1= .
gen gross_outside_income2= .
gen gross_outside_income3=DVoiGfrAnnualw3_aggr
gen gross_outside_income4=DVoiGfrAnnualW4_aggr
gen gross_outside_income5=DVoiGfrAnnualw5_aggr

drop DVoiGfrAnnualw5_aggr DVoiGfrAnnualW4_aggr DVoiGfrAnnualw3_aggr

gen Net_outside_income1= .
gen Net_outside_income2= .
gen Net_outside_income3=DVoiNfrAnnualw3_aggr
gen Net_outside_income4=DVoiNfrAnnualW4_aggr
gen Net_outside_income5=DVoiNfrAnnualw5_aggr

drop DVoiNfrAnnualw5_aggr DVoiNfrAnnualW4_aggr DVoiNfrAnnualw3_aggr

gen gross_educgrant_income1= .
gen gross_educgrant_income2= .
gen gross_educgrant_income3=DVoiGegAnnualw3_aggr
gen gross_educgrant_income4=DVoiGegAnnualW4_aggr
gen gross_educgrant_income5=DVoiGegAnnualw5_aggr

drop DVoiGegAnnualw5_aggr DVoiGegAnnualW4_aggr DVoiGegAnnualw3_aggr

gen Net_educgrant_income1= .
gen Net_educgrant_income2= .
gen Net_educgrant_income3=DVoiNegAnnualw3_aggr
gen Net_educgrant_income4=DVoiNegAnnualW4_aggr
gen Net_educgrant_income5=DVoiNegAnnualw5_aggr

drop DVoiNegAnnualw5_aggr DVoiNegAnnualW4_aggr DVoiNegAnnualw3_aggr

gen gross_govtrain_income1= .
gen gross_govtrain_income2= .
gen gross_govtrain_income3=DVoiGgtAnnualw3_aggr
gen gross_govtrain_income4=DVoiGgtAnnualW4_aggr
gen gross_govtrain_income5=DVoiGgtAnnualw5_aggr

drop DVoiGgtAnnualw5_aggr DVoiGgtAnnualW4_aggr DVoiGgtAnnualw3_aggr

gen Net_govtrain_income1= .
gen Net_govtrain_income2= .
gen Net_govtrain_income3=DVoiNgtAnnualw3_aggr
gen Net_govtrain_income4=DVoiNgtAnnualW4_aggr
gen Net_govtrain_income5=DVoiNgtAnnualw5_aggr

drop DVoiNgtAnnualw5_aggr DVoiNgtAnnualW4_aggr DVoiNgtAnnualw3_aggr

gen gross_redundancy_income1= .
gen gross_redundancy_income2= .
gen gross_redundancy_income3=DVoiGrrAnnualw3_aggr
gen gross_redundancy_income4=DVoiGrrAnnualW4_aggr
gen gross_redundancy_income5=DVoiGrrAnnualw5_aggr

drop DVoiGrrAnnualw5_aggr DVoiGrrAnnualW4_aggr DVoiGrrAnnualw3_aggr

gen Net_redundancy_income1= .
gen Net_redundancy_income2= .
gen Net_redundancy_income3=DVoiNrrAnnualw3_aggr
gen Net_redundancy_income4=DVoiNrrAnnualW4_aggr
gen Net_redundancy_income5=DVoiNrrAnnualw5_aggr

drop DVoiNrrAnnualw5_aggr DVoiNrrAnnualW4_aggr DVoiNrrAnnualw3_aggr

gen gross_investment_income1= .
gen gross_investment_income2= .
gen gross_investment_income3=DVGIINVw3_aggr
gen gross_investment_income4=DVGIINVW4_aggr
gen gross_investment_income5=DVGIINVw5_aggr

drop DVGIINVw5_aggr DVGIINVW4_aggr DVGIINVw3_aggr

gen gross_private_pen_income1= .
gen gross_private_pen_income2= .
gen gross_private_pen_income3=DVGIPPENw3_AGGR
gen gross_private_pen_income4=DVGIPPENw4_AGGR
gen gross_private_pen_income5=DVGIPPENw5_AGGR

drop DVGIPPENw5_AGGR DVGIPPENw4_AGGR DVGIPPENw3_AGGR

gen net_private_pen_income1= .
gen net_private_pen_income2= .
gen net_private_pen_income3=DVNIPpenw3_aggr
gen net_private_pen_income4=DVNIPpenW4_aggr
gen net_private_pen_income5=DVNIPpenw5_aggr

drop DVNIPpenw5_aggr DVNIPpenW4_aggr DVNIPpenw3_aggr

gen gross_overseas_pen_income1= .
gen gross_overseas_pen_income2= .
gen gross_overseas_pen_income3=DVoiGopAnnualw3_aggr
gen gross_overseas_pen_income4=DVoiGopAnnualW4_aggr
gen gross_overseas_pen_income5=DVoiGopAnnualw5_aggr

drop DVoiGopAnnualw5_aggr DVoiGopAnnualW4_aggr DVoiGopAnnualw3_aggr

gen net_overseas_pen_income1= .
gen net_overseas_pen_income2= .
gen net_overseas_pen_income3=DVoiNopAnnualw3_aggr
gen net_overseas_pen_income4=DVoiNopAnnualW4_aggr
gen net_overseas_pen_income5=DVoiNopAnnualw5_aggr

drop DVoiNopAnnualw5_aggr DVoiNopAnnualW4_aggr DVoiNopAnnualw3_aggr

sort hid1 hid2 hid3 hid4 hid5

gen N=[_n]

reshape long hid year sampl_weights head_educ current_accounts credit_current_accounts overdrawn_current_accounts saving_accounts total_ISAs total_Insurance empl_shares informal_assets formal_assets outstanding_credit_card outstanding_store_card children_trust children_savings Gross_Fin_Wealth_excl Total_Fin_liabilities Gross_Fin_Wealth Net_Fin_Wealth Total_hh_arrears Total_Physical_Wealth Total_Property_Wealth Total_Pension_Wealth Total_Wealth Net_annual_income Gross_annual_income Gross_self_income Gross_empl_income total_benefit_income gross_royalties_income gross_other_income gross_maint_income gross_outside_income gross_educgrant_income gross_govtrain_income gross_redundancy_income gross_investment_income all_mortgages all_property_values Net_self_income Net_empl_income Net_outside_income Net_educgrant_income Net_govtrain_income Net_redundancy_income gross_private_pen_income  net_private_pen_income gross_overseas_pen_income net_overseas_pen_income, i(N) j(wave)

drop wave1 wave2 wave3 wave4 wave5
drop if hid>= .

duplicates drop hid,force

sort hid

save "`location'\\Data\household_wealth_data_long.dta", replace


