%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% SIMULATE A PANEL STARTING FROM INITIAL CONDITIONS                     %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear
clc

%% Load solution to aggregate problem
load('../Outputs/Path_Baseline_v1.mat', 'aa','hh', 'Transitions','h_choice_stat', 'k_choice_stat','h_choice', 'k_choice','parms', 'grid_parms', 'worldstate','i_choice', 'c_choice', 'wages', 'r', 'exostates','ALPHA','N')

%% Set Percentiles
pct = [10, 25, 50, 75, 90];
names = {'Path_Micro_10.mat','Path_Micro_25.mat','Path_Micro_50.mat','Path_Micro_75.mat','Path_Micro_90.mat'};

%% Simulate economy for each initial pctile
for i = 1:5
    simulateinitial_pct(ALPHA, Transitions, h_choice, k_choice, i_choice, c_choice, wages, r, aa, exostates, parms, grid_parms, worldstate, pct(i), names{i});
end

%% Set Groups
pct = [1,2,3,4];
names = {'Path_Micro_prof.mat','Path_Micro_inter.mat','Path_Micro_rout.mat','Path_Micro_nonemp.mat'};

%% Simulate economy for each initial group
for i = 1:4
    simulateinitial_grp(ALPHA, Transitions, h_choice, k_choice, i_choice, c_choice, wages, r, aa, exostates, parms, grid_parms, worldstate, pct(i), names{i});
end

%% Repeat with uncertainty only
clear
clc

%% Load solution to aggregate problem
load('../Outputs/Path_Baseline_v1.mat', 'aa','hh', 'Transitions','h_choice_stat', 'k_choice_stat','h_choice', 'k_choice','parms', 'grid_parms', 'worldstate','i_choice', 'c_choice', 'wages', 'r', 'exostates','ALPHA','N')
%% Simulate new worldstate

worldstate =[];
        T = 51; 
        N = 5000;
	rng(1001)
        worldstate = NaN(N,T);
        worldstate(:,1) = 4;
        d = rand(size(worldstate,1),T);
        for t = 1:T
           CT = [zeros(size(PandemicTransition,1),1)  cumsum(PandemicTransition(:,:),2)];
            for i= 1: size(worldstate,1)
                [~,~,worldstate(i,t+1)] = histcounts(d(i,t),CT(worldstate(i,t),:));
            end
        end
        worldstate = [5*ones(N,1),  worldstate(:,1:end-1)];

%% Set Percentiles
pct = [10, 25, 50, 75, 90];
names = {'Path_Micro_uncert_10.mat','Path_Micro_uncert_25.mat','Path_Micro_uncert_50.mat','Path_Micro_uncert_75.mat','Path_Micro_uncert_90.mat'};

%% Simulate economy for each initial pctile
for i = 1:5
    simulateinitial_pct(ALPHA, Transitions, h_choice, k_choice, i_choice, c_choice, wages, r, aa, exostates, parms, grid_parms, worldstate, pct(i), names{i});
end

%% Set Groups
pct = [1,2,3,4];
names = {'Path_Micro_uncert_prof.mat','Path_Micro_uncert_inter.mat','Path_Micro_uncert_rout.mat','Path_Micro_uncert_nonemp.mat'};

%% Simulate economy for each initial group
for i = 1:4
    simulateinitial_grp(ALPHA, Transitions, h_choice, k_choice, i_choice, c_choice, wages, r, aa, exostates, parms, grid_parms, worldstate, pct(i), names{i});
end

%% Repeat without consumption cap
clear
clc

%% Load solution to aggregate problem
load('../Outputs/Path_nocap_v1.mat', 'aa','hh', 'Transitions','h_choice_stat', 'k_choice_stat','h_choice', 'k_choice','parms', 'grid_parms', 'worldstate','i_choice', 'c_choice', 'wages', 'r', 'exostates','ALPHA','N')

%% Set Percentiles
pct = [10, 25, 50, 75, 90];
names = {'Path_Micro_nocap_10.mat','Path_Micro_nocap_25.mat','Path_Micro_nocap_50.mat','Path_Micro_nocap_75.mat','Path_Micro_nocap_90.mat'};

%% Simulate economy for each initial pctile
for i = 1:5
    simulateinitial_pct(ALPHA, Transitions, h_choice, k_choice, i_choice, c_choice, wages, r, aa, exostates, parms, grid_parms, worldstate, pct(i), names{i});
end

%% Set Groups
pct = [1,2,3,4];
names = {'Path_Micro_nocap_prof.mat','Path_Micro_nocap_inter.mat','Path_Micro_nocap_rout.mat','Path_Micro_nocap_nonemp.mat'};

%% Simulate economy for each initial group
for i = 1:4
    simulateinitial_grp(ALPHA, Transitions, h_choice, k_choice, i_choice, c_choice, wages, r, aa, exostates, parms, grid_parms, worldstate, pct(i), names{i});
end


%% Repeat with Surprise Shock

clear
clc

%% Load solution to aggregate problem
load('../Outputs/Path_Baseline_v1.mat','aa','hh','Transitions','h_choice_stat', 'k_choice_stat','h_choice', 'k_choice', 'grid_parms','parms', 'worldstate','i_choice','i_choice_stat', 'c_choice', 'c_choice_stat', 'wages', 'r', 'exostates','ALPHA','N', 'parms','Transition_Agg','b', 'b_stat','cap_C', 'cap_R1')

%% Solve for decision rules with surprise shock
[h_choice_surp, i_choice_surp, k_choice_surp, c_choice_surp] = SolveSurprise(parms, r, wages*.99, Transition_Agg, grid_parms, [cap_C,cap_R1], b);

h_choice(:,:,6:9) = h_choice_surp;
k_choice(:,:,6:9) = k_choice_surp;
c_choice(:,:,6:9) = c_choice_surp;
i_choice(:,:,6:9) = i_choice_surp;
wages(6:9,:) = wages(1:4,:)*.99;

worldstate(:,5)=worldstate(:,5)+5;

%% Set Percentiles
pct = [10, 25, 50, 75, 90];
names = {'Path_Micro_surprise_10.mat','Path_Micro_surprise_25.mat','Path_Micro_surprise_50.mat','Path_Micro_surprise_75.mat','Path_Micro_surprise_90.mat'};

%% Simulate economy for each initial pctile
for i = 1:5
    simulateinitial_pct(ALPHA, Transitions, h_choice, k_choice, i_choice, c_choice, wages, r, aa, exostates, parms, grid_parms, worldstate, pct(i), names{i});
end

%% Set Groups
pct = [1,2,3,4];
names = {'Path_Micro_surprise_prof.mat','Path_Micro_surprise_inter.mat','Path_Micro_surprise_rout.mat','Path_Micro_surprise_nonemp.mat'};

%% Simulate economy for each initial group
for i = 1:4
    simulateinitial_grp(ALPHA, Transitions, h_choice, k_choice, i_choice, c_choice, wages, r, aa, exostates, parms, grid_parms, worldstate, pct(i), names{i});
end

clear
clc
%% Compile data and save
Load_Microsimulations_Data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% END OF MAIN CODE %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%












