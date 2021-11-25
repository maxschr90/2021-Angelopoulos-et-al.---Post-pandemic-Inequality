%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% SOLVE MODEL WITH AGGREGATE UNCERTAINTY AND SIMULATE A PANEL           %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear
clc

%% Setup all parameters and exogenous processes
fprintf('Setup Exogenous Processes and Parameters \n')
[Normal_Transition_Pre, Normal_Transition_Post, Shock_Transition_Pre, Shock_Transition_Post, wages,Normal_Health_Trans, Shock_Health_Trans, r,  T, N, PandemicTransition,  worldstate] = SetupExogenous();
[Transitions, Transition_Agg] = GenerateTransitionMatrices(Normal_Transition_Pre, Normal_Transition_Post, Normal_Health_Trans, Shock_Transition_Pre, Shock_Transition_Post, Shock_Health_Trans, PandemicTransition);
[parms] = SetupParameters();

%% Solve and simulate the economy pre-pandemic in order to get the initial distribution
fprintf('Solve Stationary Problem\n')
tic
[b_stat, Value_Function_stat, h_choice_stat, i_choice_stat, k_choice_stat, c_choice_stat, grid_parms, initdist] = SolveStationaryProblem(parms, repelem(0.0056,1,36), wages(4,:), Transitions(:,:,4));
fprintf('Stationary Problem has Converged in: %.5f seconds. \n',toc')

fprintf('Simulate Stationary Distribution\n')
tic
[ALPHA, aa, hh, nn] = nonstochsim_stat(initdist,Transitions(:,:,4), h_choice_stat, k_choice_stat, grid_parms);
fprintf('Simulation of Stationary Distribution completed in: %.5f seconds. \n',toc')
initdist = reshape(ALPHA, size(initdist)); % this is the distribution before the shock hits

%% Calculate SS distribution of Income to calibrate the consumption limit
Y = [wages(4,nn)'+aa*0.0056+(aa<0).*aa*0.01];
Y_80 = wprctile(Y,80, ALPHA,8);
C = c_choice_stat(:);
cap = wprctile(c_choice_stat(:),70,ALPHA(:),8);
cap_C = fzero(@(x) findcap(C(Y>=Y_80), ALPHA(Y>=Y_80), x, 0.75),cap);
cap_R1 = fzero(@(x) findcap(C(Y>=Y_80), ALPHA(Y>=Y_80), x, 0.875),cap);

%% Solve the households problem under aggregate uncertainty
fprintf('Solve Problem with Aggregate Uncertainty \n')
tic
[b, Value_Function, h_choice, i_choice, k_choice, c_choice] = SolveAggregateProblem(parms, r, wages, Transition_Agg, grid_parms, [cap_C,cap_R1]);
fprintf('Aggregate Problem has Completed in: %.5f seconds. \n',toc')

%% add the steady state decision rules to the set
h_choice(:,:,5) = h_choice_stat;
k_choice(:,:,5) = k_choice_stat;
c_choice(:,:,5) = c_choice_stat;
i_choice(:,:,5) = i_choice_stat;
wages(5,:) =wages(4,:);
exostates=nn;

%% Simulate forward, beginning from the pre-pandemic steady state
fprintf('Simulate Forward \n')

%% For memory usage reasons, this part of the code separates the simulation of the panel into more managable chucks and loops over them
%% Depending on your needs, and available resources, you might want to adapt this bit.
for nn=1:50
    tic
    nnn = (nn-1)*N/50+1;
    fprintf('Simulating Histories %d  to  %d \n', nnn, nnn+99)
    parfor n = nnn:nnn+99
        [OMEGA(:,:,n), ~,~,~] = nonstochsim_agg(initdist,Transitions, h_choice, k_choice, grid_parms, worldstate(n,:));
    end
    fprintf('Simulation has Completed in: %.5f seconds. \n',toc')
    tic
    parfor n = nnn:nnn+99
        [Share_Healthstatus(:,:,n), Share_Class(:,:,n), Share_HTM(:,:,n), Mean_K(:,:,n), Mean_H(:,:,n), Mean_C(:,:,n), Mean_E(:,:,n), Mean_Y(:,:,n), Mean_I(:,:,n),  GINI_H(:,:,n), GINI_K(:,:,n), Mean_H_Class(:,:,n), Mean_K_Class(:,:,n), Mean_C_Class(:,:,n),GINI_H_Class(:,:,n), GINI_K_Class(:,:,n), GINI_C_Class(:,:,n),  Share_HTM_Class(:,:,n), Wagstaffindex_K(:,:,n), Erregyersindex_K(:,:,n), Share_vulnerable_K(:,:,n), Share_vulnerable_C(:,:,n),Quintile_Share(:,:,n),Mean_K_Quint(:,:,n),Mean_H_Quint(:,:,n),Mean_C_Quint(:,:,n)]= SummaryStatistics(OMEGA(:,:,n), h_choice, k_choice, i_choice, c_choice, wages, r, aa, exostates, worldstate(n,:));
    end
    BETA = OMEGA(:,1:2,end);
    OMEGA = [];
    fprintf('Statistics have been calculated in: %.5f seconds. \n',toc')

save('..\Outputs\Path_Baseline_v1.mat')

end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% END OF MAIN CODE %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




  

