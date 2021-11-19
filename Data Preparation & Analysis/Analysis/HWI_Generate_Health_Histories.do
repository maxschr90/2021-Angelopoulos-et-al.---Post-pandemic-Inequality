/*****************************************************************************************
* GENERATE HISTORY OF HEALTH EVENTS FOR THE HOUSEHOLD							     	 *
*****************************************************************************************/

** Generate Severe Health Shock Variable
gen healthshock =.
replace healthshock =1 if (hcondn3==1 | hcondn4==1 | hcondn6==1 | hcondn7==1 | hcondn8==1| hcondn11 ==1| hcondn13==1) & wave >0 
replace healthshock = 0 if healthshock ==.

** Generate Detailed Health Condition Variables
gen asthma =.
replace asthma =1 if hcondn1 ==1 

gen arthritis =.
replace arthritis =1 if hcondn2 ==1 

gen heartfailure =.
replace heartfailure =1 if hcondn3 ==1 

gen heartdisease =.
replace heartdisease =1 if hcondn4 ==1 

gen angina =.
replace angina =1 if hcondn5 ==1 

gen heartattack =.
replace heartattack =1 if hcondn6 ==1 

gen stroke =.
replace stroke =1 if hcondn7 ==1 

gen emphysema =.
replace emphysema =1 if hcondn8 ==1 

gen hyperthyroidism =.
replace hyperthyroidism  =1 if hcondn9 ==1 

gen hypothyroidism  =.
replace hypothyroidism  =1 if hcondn10 ==1 

gen bronchitis  =.
replace bronchitis  =1 if hcondn11 ==1  

gen livercondition  =.
replace livercondition  =1 if hcondn12 ==1 

gen cancer  =.
replace cancer  =1 if hcondn13 ==1 

gen diabetes  =.
replace diabetes =1 if hcondn14 ==1 

gen epilepsy =.
replace epilepsy =1 if hcondn15 ==1 

gen highbloodpressure =.
replace highbloodpressure =1 if hcondn16 ==1 

gen longstandinghealthcondition =0
replace longstandinghealthcondition = 1 if health ==1

egen healthcond = rowmax( asthma arthritis  angina  hyperthyroidism hypothyroidism  livercondition diabetes epilepsy highbloodpressure  longstandinghealthcondition)

** Generate Family History
gen deadfather = 0
replace deadfather =1 if paju ==3
gen deadmother = 0
replace deadmother =1 if maju ==3

sort pidp wave
xtset pidp wave

*** Generate HH health histories
gen posthealthshock =.
replace posthealthshock =1 if healthshock ==1 
bysort pidp: carryforward posthealthshock , replace
replace posthealthshock = 0 if posthealthshock ==.
bysort hidp: egen HH_posthealthshock =max(posthealthshock)

gen postasthma =.
replace postasthma =1 if asthma ==1 
bysort pidp: carryforward postasthma , replace
replace postasthma = 0 if postasthma ==.
bysort hidp: egen HH_postasthma =max(postasthma)

gen postarthritis =.
replace postarthritis =1 if arthritis ==1 
bysort pidp: carryforward postarthritis , replace
replace postarthritis = 0 if postarthritis ==.
bysort hidp: egen HH_postarthritis =max(postarthritis)

gen postheartfailure =.
replace postheartfailure =1 if heartfailure ==1 
bysort pidp: carryforward postheartfailure , replace
replace postheartfailure = 0 if postheartfailure ==.
bysort hidp: egen HH_postheartfailure =max(postheartfailure)

gen postangina =.
replace postangina =1 if angina ==1 
bysort pidp: carryforward postangina , replace
replace postangina = 0 if postangina ==.
bysort hidp: egen HH_postangina =max(postangina)

gen postemphysema =.
replace postemphysema =1 if emphysema ==1 
bysort pidp: carryforward postemphysema , replace
replace postemphysema = 0 if postemphysema ==.
bysort hidp: egen HH_postemphysema =max(postemphysema)

gen posthyperthyroidism  =.
replace posthyperthyroidism =1 if hyperthyroidism  ==1 
bysort pidp: carryforward posthyperthyroidism , replace
replace posthyperthyroidism = 0 if posthyperthyroidism ==.
bysort hidp: egen HH_posthyperthyroidism =max(posthyperthyroidism)

gen posthypothyroidism   =.
replace posthypothyroidism =1 if hypothyroidism   ==1 
bysort pidp: carryforward posthypothyroidism , replace
replace posthypothyroidism = 0 if posthypothyroidism ==.
bysort hidp: egen HH_posthypothyroidism =max(posthypothyroidism)

gen postbronchitis   =.
replace postbronchitis =1 if bronchitis   ==1 
bysort pidp: carryforward postbronchitis , replace
replace postbronchitis = 0 if postbronchitis ==.
bysort hidp: egen HH_postbronchitis =max(postbronchitis)

gen postlivercondition   =.
replace postlivercondition =1 if livercondition   ==1 
bysort pidp: carryforward postlivercondition , replace
replace postlivercondition = 0 if postlivercondition ==.
bysort hidp: egen HH_postlivercondition =max(postlivercondition)

gen postdiabetes =.
replace postdiabetes =1 if diabetes ==1 
bysort pidp: carryforward postdiabetes , replace
replace postdiabetes = 0 if postdiabetes ==.
bysort hidp: egen HH_postdiabetes =max(postdiabetes)

gen postepilepsy =.
replace postepilepsy =1 if epilepsy ==1 
bysort pidp: carryforward postepilepsy , replace
replace postepilepsy = 0 if postepilepsy ==.
bysort hidp: egen HH_postepilepsy =max(postepilepsy)

gen posthighbloodpressure =.
replace posthighbloodpressure =1 if highbloodpressure ==1 
bysort pidp: carryforward posthighbloodpressure , replace
replace posthighbloodpressure = 0 if posthighbloodpressure ==.
bysort hidp: egen HH_posthighbloodpressure =max(posthighbloodpressure)

gen posthealthcond =.
replace posthealthcond =1 if healthcond ==1 
bysort pidp: carryforward posthealthcond , replace
replace posthealthcond = 0 if posthealthcond ==.
bysort hidp: egen HH_posthealthcond =max(posthealthcond)

gen postdeadfather =.
replace postdeadfather =1 if deadfather ==1 
bysort pidp: carryforward postdeadfather , replace
replace postdeadfather = 0 if postdeadfather ==.
bysort hidp: egen HH_postdeadfather =max(postdeadfather)

gen postdeadmother =.
replace postdeadmother =1 if deadmother ==1 
bysort pidp: carryforward postdeadmother , replace
replace postdeadmother = 0 if postdeadmother ==.
bysort hidp: egen HH_postdeadmother =max(postdeadmother)

gen postlongstandinghealthcondition =.
replace postlongstandinghealthcondition =1 if longstandinghealthcondition ==1 
bysort pidp: carryforward postlongstandinghealthcondition , replace
replace postlongstandinghealthcondition = 0 if postlongstandinghealthcondition ==.
bysort hidp: egen HH_postlongtermhcond =max(postlongstandinghealthcondition)

