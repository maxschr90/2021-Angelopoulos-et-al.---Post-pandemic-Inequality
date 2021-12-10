This folder contains the MATLAB code to replicate the modeling analysis in the paper.
This folder contains 7 folders:
	- The folder "Calibration" contains the codes to calibrate the model pre-COVID.
	- "Data" contains the calibrated parameters and the aggregate transition matrix.
	- "Dynamics - Aggregate" contains the codes to run the aggregate version of the model.
	- "Dynamics - Initial Conditions" contains the codes to run the version of the model where we condition on initial conditions.
	- "Dynamics - Policy" contains the codes to run the policy experiments.
	- "Figures" contains the codes to create all figures. 
	- "Outputs" is empty to begin with but will contain all outputs created by the codes.




Please note:
	1. The code includes two functions that were written by contributors to the mathworks community: i) wprctile and ii) gini.
	   We include these codes in line with the their usage policies, including the copyright notice and any further disclaimer 
	   with the function. We are grateful to the authors for providing us with their work.
	2. In all cases, the first period refers to the stationary equilibrium pre-COVID19.	
	3. Much of the code in this folder has dependencies on other parts of the analysis (i.e. you cannot run one part without the input 
	   created by another part of the code). Please check if you have created the relevant objects necessary for running the section of code
	   you intend to. Check the documentation in each case for clarification.