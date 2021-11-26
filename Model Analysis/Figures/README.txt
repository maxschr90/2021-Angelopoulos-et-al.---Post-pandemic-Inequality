This folder contains the codes to create the figures presented in the main paper and the appendix.
To create the figures, make sure you have first run all simulations, by executing the codes in the other folders.
All relevant files should be saved in "Model Analysis\Outputs".

There are three distinct code files: Results_Figures.m, Appendix_Figures.m and Policy_Figures.m.
You can run each in turn. The figures will be saved in the "Outputs" folder.

To create Appendix Figure E2, do the following: go back to the function setinitialdistribution_pct.m in the folder 
Dynamics - Initial Conditions. Follow the instructions contained in the function to condition on both health and wealth.
Rerun lines 1-17 in "Initial_Conditions.m". Then rerun the lines that create Figure 4 in "Results_Figures.m".