/*****************************************************************************************
* MASTER FILE
*****************************************************************************************/
clear 
cls

** change current file location
pwd

** Execute DO-Files

** This do-file merges all separate waves of the UnSoc data
do "HWI_Generate_Panel"

** This do-file cleans the data
** it also calls "HWI_Generate_Health_Histories" in the process of its execution
do "HWI_Data_Cleaning"

** This do-file performs the analysis
** it also calls "HWI_Shockresponse" and "HWI_Tables" in the process of its execution
do "HWI_Data_Analysis"

** This do-file analysises the historical mortality data for patterns of recurrent disease outbreaks
do "Markov_Switching_Model"
