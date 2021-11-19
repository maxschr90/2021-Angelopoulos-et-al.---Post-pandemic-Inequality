/*****************************************************************************************
* GENERATE THE PANEL USED FOR FURTHER ANALYSIS											 *
*****************************************************************************************/
clear 
cls

// assign global macro to refer to Understanding Society data on your drive
global ukhls "D:\OneDrive - University of Glasgow\COVID 19 Project\HWI_WP\Data\Understanding Society (Waves 1-9)\UKDA-6614-stata\stata\stata11_se"
*cd "$ukhls"
// add the path where you will save the data
global data "D:\Documents\GitHub\HWI_Replication_File\Data Preparation & Analysis\Data"

//loop through each wave
foreach w in a b c d e f g h i  { // For fewer waves use only the wave prefix of the waves you need to merge
	
	// find the wave number
	local waveno=strpos("abcdefghijklmnopqrstuvwxyz","`w'")
	
	// open the individual level file
	if `waveno' == 1 {
		use pidp `w'_preason `w'_jbhas `w'_hiqual_dv `w'_istrtdaty `w'_sppid `w'_intdaty_dv `w'_jbseg_dv `w'_jbnssec*_dv `w'_fimnmisc_dv `w'_fimnnet_dv `w'_fimnsben_dv  `w'_fimnpen_dv `w'_fimninvnet_dv `w'_fimnprben_dv `w'_paygu_dv `w'_fimnlabnet_dv `w'_fimnlabgrs_dv `w'_fimngrs_dv  `w'_jbstat `w'_jbsat `w'_pno `w'_sf1 `w'_paju `w'_maju `w'_health `w'_sex `w'_hcond1 `w'_hcond2 `w'_hcond3 `w'_hcond4 `w'_hcond5 `w'_hcond6  `w'_hcond7 `w'_hcond8 `w'_hcond9 `w'_hcond10 `w'_hcond11 `w'_hcond12 `w'_hcond13 `w'_hcond14 `w'_hcond15 `w'_hcond16 `w'_hconds01 `w'_hconds02 `w'_hconds03 `w'_hconds04 `w'_hconds05 `w'_hconds06  `w'_hconds07 `w'_hconds08   `w'_jboffy `w'_jbsemp `w'_jbhrs `w'_jbot `w'_paygu_dv `w'_paynu_dv `w'_basrate `w'_age_dv `w'_gor_dv `w'_hidp `w'_sf12pcs_dv `w'_jbsoc00_cc `w'_jbsemp `w'_racel `w'_qfhigh  using "$ukhls/ukhls_w`waveno'/`w'_indresp", clear
		merge n:1 `w'_hidp   using "$ukhls/ukhls_w`waveno'/`w'_hhresp"
		
		rename a_hcond1 a_hcondn1
		rename a_hcond2 a_hcondn2
		rename a_hcond3 a_hcondn3
		rename a_hcond4 a_hcondn4
		rename a_hcond5 a_hcondn5
		rename a_hcond6 a_hcondn6
		rename a_hcond7 a_hcondn7
		rename a_hcond8 a_hcondn8
		rename a_hcond9 a_hcondn9
		rename a_hcond10 a_hcondn10
		rename a_hcond11 a_hcondn11
		rename a_hcond12 a_hcondn12
		rename a_hcond13 a_hcondn13
		rename a_hcond14 a_hcondn14
		rename a_hcond15 a_hcondn15
		rename a_hcond16 a_hcondn16
		rename a_hconds01 a_hcondns1
		rename a_hconds02 a_hcondns2
		rename a_hconds03 a_hcondns3
		rename a_hconds04 a_hcondns4
		rename a_hconds05 a_hcondns5
		rename a_hconds06 a_hcondns6
		rename a_hconds07 a_hcondns7
		rename a_hconds08 a_hcondns8

	}
	else{
	use  pidp `w'_preason `w'_ppno `w'_ppid `w'_jbhas `w'_hiqual_dv `w'_istrtdaty `w'_sppid `w'_intdaty_dv `w'_jbseg_dv `w'_jbnssec*_dv `w'_fimnmisc_dv `w'_fimnnet_dv `w'_fimnsben_dv `w'_fimnpen_dv `w'_fimninvnet_dv `w'_fimnprben_dv `w'_paygu_dv `w'_fimnlabnet_dv `w'_fimnlabgrs_dv `w'_fimngrs_dv `w'_jbstat `w'_jbsat `w'_pno `w'_sf1 `w'_paju `w'_maju `w'_health `w'_sex `w'_hcondn1 `w'_hcondn2 `w'_hcondn3 `w'_hcondn4 `w'_hcondn5  `w'_hcondn6 `w'_hcondn7  `w'_hcondn8  `w'_hcondn9  `w'_hcondn10  `w'_hcondn11  `w'_hcondn12 `w'_hcondn13 `w'_hcondn14 `w'_hcondn15 `w'_hcondn16 `w'_jboffy `w'_jbsemp `w'_jbhrs `w'_jbot `w'_paygu_dv `w'_paynu_dv `w'_basrate `w'_age_dv `w'_gor_dv `w'_hidp `w'_sf12pcs_dv `w'_jbsoc00_cc `w'_jbsemp `w'_racel `w'_qfhigh using "$ukhls/ukhls_w`waveno'/`w'_indresp", clear

	merge n:1 `w'_hidp   using "$ukhls/ukhls_w`waveno'/`w'_hhresp"
		}
	// drop the wave prefix from all variables
	rename `w'_* *
	
	// create a wave variable
	cap: gen wave=`waveno'
	
	// Create Individual Level Variables and aggregate to HH
	//do CreateHHVars
	// save one file for each wave
	save temp`w', replace
}

// open the file for the first wave (wave a_)
use tempa, clear

// loop through the remaining waves
foreach w in b c d e f g h i  {

	// append the files for the second wave onwards
	append using temp`w'
}

// check how many observations are available from each wave
tab wave

// save the long file
save "$data\Use\longfile.dta", replace

// erase temporary files
foreach w in a b c d e f g h i {
	erase temp`w'.dta
}
