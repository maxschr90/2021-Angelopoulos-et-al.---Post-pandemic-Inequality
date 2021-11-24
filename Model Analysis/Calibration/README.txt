The code in this folder executes the SMM procedure described in the appendix of the paper in order to calibrate 
a number of model parameters. The main function is "SS_Calibration", which evaluates the SMM criterion (provided by "Momentmatching")
repeatedly for a large number of parameter guesses using a global, non-derivative based solver.

Calibration is as much an art as a science, and can (and in the case of this model has) take a very long time and requires not just computational
resources, but also patience, understanding and human ingenuity.
The code in this section does therefore not reproduce exactly how the model parameters were calibrated, 
but rather how we could have calibrated them (i.e. by setting reasonable bounds on the parameters and waiting for the solver
to give us an arbitrarily good fit).

We therefore DO NOT recommend you try and calibrate the model yourself using the codes provided, but rather use the final output which is saved
in "../Data/Parameters.mat". 

If you want to check that the parameters do indeed give a good fit to the data, you might want to execute the function
	Momentmatching(y), using the calibrated parameters as inputs.

If your interest extends beyond this we suggest you begin by setting the upper and lower bounds for the algorithm described in 
"SS_Calibration" arbitrarily close to the parameters we provide and take it from there.

Good luck!
