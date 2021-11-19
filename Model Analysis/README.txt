This folder contains the MATLAB code to replicate the modeling analysis in the paper.
This folder contains two files:
	1. The file "HWI_Dynamic_Model_Time_Series" solves the model with aggregate uncertainty, and generates a long time series of one economy.
	2. The file "HWI_Dynamic_Model_Panel" solves the model with aggregate uncertainty, and short panel of many economies.
	3. The file "Parameters" contains the calibrated values.

	
Please note:
	1. The code includes two functions that were written by contributors to the mathworks community: i) wprctile and ii) gini.
	   We include these codes in line with the their usage policies, including the copyright notice and any further disclaimer 
	   with the function. We are grateful to the authors for providing us with their work.
	2. Although the functions used in both versions of the model solution algorithm are mostly identical, there are sme minor variations,
	   in the way that the summary statistics are calculated in each case. 
	3. In all cases, the first period refers to the stationary equilibrium pre-COVID19.	