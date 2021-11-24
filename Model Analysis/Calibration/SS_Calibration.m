%% This function calibrates the remaining model parameters to match the selected data moments

%% The parameters to be calibrated are in order:
    %% 1 - the linear term in the health production function
    %% 2 - the nonlinear term in the health production function
    %% 3 - the rate of depreciation of health for sick HH
    %% 4 - the rate of depreciation of health for recovering HH
    %% 5 - the share of health in the utility function

     %% Set bounds on parameters
     lb = [0.0509    0.2595    0.4064    0.4803    0.1   -0.0089];
     ub = [0.1527    0.7785    0.9624   0.9624    0.7   0];
     %% set algorithm options
     options = optimoptions('surrogateopt','Display','iter','MaxFunctionEvaluations', 100000,'PlotFcn','surrogateoptplot','InitialPoints',trials_full,  'MaxTime', 3600*24*30);
     % we set a time limit of 30 days for the algorithm to run. However,
     % depending on circumstances the calibration might take a lot longer
     % or much shorter until a satisfactory level of convergence is
     % achieved

     %% Run Calibration
        tic
	    [y] = surrogateopt(@(x)Momentmatching(x),lb,ub,options);
        fprintf('Time needed for algorithm: %f \n', toc)
        fprintf('Saving iteration results. \n')
    
     %% Save output
	    save('..\Data\Parameters.mat')

    
   



