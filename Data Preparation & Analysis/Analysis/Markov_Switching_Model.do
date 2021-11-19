*** This DO FILE runs the Markov Switching Model to estimate disease outbreak probabilities ***
clear
cls
pwd

** Load Influenza UK data
import excel "..\Data\Historical Mortality\MS_Data.xlsx", sheet("UK") firstrow
qui: gen log_influenza = log(Influenza)

** Fit MS model
tsset Year
mswitch dr log_influenza, states(2) varswitch

** Calculate critical value for LR test
qui:mat def ll_2 = e(ll)
display "Calculating critical value"
rscv,q(0.99)
qui: eststo Influenza

** Fit MS model with 1 state for comparision
qui: mswitch dr log_influenza, states(1) 
qui:mat def ll_1 = e(ll)
qui:mat def test_statistic = 2*(ll_2-ll_1)
display "Value of Test statistic:" 
mat list test_statistic

	

