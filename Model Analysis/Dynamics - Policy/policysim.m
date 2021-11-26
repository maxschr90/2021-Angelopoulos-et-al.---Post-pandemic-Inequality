%% Policy Simulation
%% This function solves the problem with policy and simulates the economy
function [] = policysim(coverage,rr,savename)
%% Load results from baseline
load('../Outputs/Path_Baseline_v1.mat', 'aa', 'Transitions','Transition_Agg','h_choice', 'k_choice','i_choice', 'c_choice','parms', 'grid_parms', 'worldstate','i_choice', 'c_choice', 'wages', 'r', 'exostates','ALPHA','N', 'cap_C', 'cap_R1')
cost = zeros(size(h_choice));
savename = strcat('../Outputs/',savename);

%% resolve the problem with policy
fprintf('Solve Problem with Aggregate Uncertainty and Policy \n')
tic
[b_pol, Value_Function_pol, h_choice_pol, i_choice_pol, k_choice_pol, c_choice_pol, cost_pol] = SolveStationaryProblem_Agg_pol(parms, r, wages, Transition_Agg, grid_parms, [cap_C,cap_R1], rr, coverage);
fprintf('Dynamic Problem has Completed in: %.5f seconds. \n',toc')

h_choice(:,:,6:9) = h_choice_pol;
k_choice(:,:,6:9) = k_choice_pol;
c_choice(:,:,6:9) = c_choice_pol;
i_choice(:,:,6:9) = i_choice_pol;
wages(6:9,:) =wages(1:4,:);
cost(:,:,6:9) = cost_pol;

%% Ensure policy applies after year 3
worldstate(:,4:end)=worldstate(:,4:end)+5;
initdist =  reshape(ALPHA, size(initdist));

fprintf('Simulate Forward \n')

%% For memory usage reasons, this part of the code separates the simulation of the panel into more managable chucks and loops over them
%% Depending on your needs, and available resources, you might want to adapt this bit.
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
        [Share_Healthstatus(:,:,n), Share_Class(:,:,n), Share_HTM(:,:,n), Mean_K(:,:,n), Mean_H(:,:,n), Mean_C(:,:,n),  Mean_I(:,:,n),  GINI_H(:,:,n), GINI_K(:,:,n), Mean_H_Class(:,:,n), Mean_K_Class(:,:,n), Mean_C_Class(:,:,n),GINI_H_Class(:,:,n), GINI_K_Class(:,:,n), GINI_C_Class(:,:,n),  Share_HTM_Class(:,:,n), Wagstaffindex_K(:,:,n), Erregyersindex_K(:,:,n), Share_vulnerable_K(:,:,n), Share_vulnerable_C(:,:,n),Quintile_Share(:,:,n),Mean_K_Quint(:,:,n),Mean_H_Quint(:,:,n),Mean_C_Quint(:,:,n), Total_Cost(:,:,n), Policy_Coverage(:,:,n)]= SummaryStatistics(OMEGA(:,:,n-nnn+1), h_choice, k_choice, i_choice, c_choice, wages,cost, r, aa, exostates, worldstate(n,:));
    end
    OMEGA = [];
    fprintf('Statistics have been calculated in: %.5f seconds. \n',toc')

save(savename)

end

end