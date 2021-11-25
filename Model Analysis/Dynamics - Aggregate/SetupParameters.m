%% Load and Setup Model Parameters %%
%% This function loads the calibrated parameters

function [parms] = SetupParameters()
    load('..\Data\Parameters.mat');
    parms = struct('blim', y(6), 'chi',[y(1) y(1) y(1) y(1)], 'theta_h',[y(2)], 'phi',[y(5)], 'tau',[0.9624	y(3) y(4)], 'beta', [0.96], 'mu',[(0.5+(1-y(5)))/(1-y(5))]);  
end