************************************************************************************************************************
************************************************************************************************************************
******************************* MASTER FILE ****************************************************************************
************************************************************************************************************************
************************************************************************************************************************
************************************************************************************************************************
*** This .do file calls all relevant .do-files in order to assemble the data, clean and construct***********************
*** the dataset and perform the data analysis, creating all the information necessary to******************************** 
*** populate the tables and figures in the main paper and the appendix.************************************************* 
*** It also provides the exogenous processes necessary for the calibration of the model.********************************
************************************************************************************************************************

clear 
cls

** change current file location
pwd

** Execute .do-files in order

** This do-file merges all separate waves of the UnSoc data 
do "HWI_Load_Data" 

** This do-file cleans the data
** it also calls "HWI_Generate_Health_Histories" in the process of its execution
do "HWI_Data_Cleaning"

** This do-file performs the analysis
** it also calls "HWI_Shockresponse" and "HWI_Table_1" in the process of its execution
do "HWI_Data_Analysis"

** This do-file analysises the historical mortality data for patterns of recurrent disease outbreaks
do "Markov_Switching_Model"
