%% Simulate Initial Conditions
%% This functions simulates the evolution of the histogram for a specific subset of the total distribution
function [] = simulateinitial_pct(ALPHA, Transitions, h_choice, k_choice, i_choice, c_choice, wages, r, aa, exostates, parms, grid_parms, worldstate, pctile, savename)
%% Set Initial Distribution
[initdist] = setinitialdistribution_pct(ALPHA, aa,  pctile, exostates, grid_parms);
    tic
    fprintf('Simulating Steady State History')
    Transitions(:,:,5)=Transitions(:,:,4);
        [OMEGA(:,:,1), ~,~,~] = nonstochsim_agg(initdist,Transitions, h_choice, k_choice, grid_parms, 5*ones(1,52));
    
    fprintf('Simulation has Completed in: %.5f seconds. \n',toc')
    tic
        [Mean_K_ss(:,:,1), Mean_H_ss(:,:,1), Mean_C_ss(:,:,1),Mean_U_ss(:,:,1), Median_K_ss(:,:,1), Median_H_ss(:,:,1), Median_C_ss(:,:,1),Median_U_ss(:,:,1),P10_K_ss(:,:,1), P10_H_ss(:,:,1), P10_C_ss(:,:,1),P10_U_ss(:,:,1),P25_K_ss(:,:,1), P25_H_ss(:,:,1), P25_C_ss(:,:,1), P25_U_ss(:,:,1),P75_K_ss(:,:,1), P75_H_ss(:,:,1), P75_C_ss(:,:,1), P75_U_ss(:,:,1),P90_K_ss(:,:,1), P90_H_ss(:,:,1), P90_C_ss(:,:,1), P90_U_ss(:,:,1)] = SummaryStatistics(OMEGA(:,:,1), h_choice, k_choice, i_choice, c_choice, wages, r, aa, exostates,parms, 5*ones(1,52));
    
    OMEGA = [];
    fprintf('Statistics have been calculated in: %.5f seconds. \n',toc')

fprintf('Simulate Forward \n')

%% For memory usage reasons, this part of the code separates the simulation of the panel into more managable chucks and loops over them
%% Depending on your needs, and available resources, you might want to adapt this bit.
    savename = strcat('../Outputs/',savename);

for nn=1:50
    tic
    nnn = (nn-1)*N/50+1;
    fprintf('Simulating Histories %d  to  %d \n', nnn, nnn+99)

    for n = nnn:nnn+99
        [OMEGA(:,:,n-nnn+1), ~,~,~] = nonstochsim_agg(initdist,Transitions, h_choice, k_choice, grid_parms, worldstate(n,:));
    end
    fprintf('Simulation has Completed in: %.5f seconds. \n',toc')
    tic
    parfor n = nnn:nnn+99
        [Mean_K(:,:,n), Mean_H(:,:,n), Mean_C(:,:,n),Mean_U(:,:,n), Median_K(:,:,n), Median_H(:,:,n), Median_C(:,:,n),Median_U(:,:,n),P10_K(:,:,n), P10_H(:,:,n), P10_C(:,:,n),P10_U(:,:,n),P25_K(:,:,n), P25_H(:,:,n), P25_C(:,:,n),P25_U(:,:,n),P75_K(:,:,n), P75_H(:,:,n), P75_C(:,:,n),P75_U(:,:,n),P90_K(:,:,n), P90_H(:,:,n), P90_C(:,:,n),P90_U(:,:,n)] = SummaryStatistics(OMEGA(:,:,n-nnn+1), h_choice, k_choice, i_choice, c_choice, wages, r, aa, exostates,parms, worldstate(n,:));
    end
    BETA = OMEGA(:,1:2,end);
    OMEGA = [];
    fprintf('Statistics have been calculated in: %.5f seconds. \n',toc')
    save(savename)

end
end