%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% SOLVE MODEL WITH AGGREGATE UNCERTAINTY, POLICY AND SIMULATE A PANEL   %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear
clc

%% Setup different policy experiments
replacement = [30, 50, 80, 30, 50, 80];
coverage = [0, 0, 0, 1, 1, 1];
names = {'Path_Policy_2_v3.mat','Path_Policy_2_v2.mat','Path_Policy_2_v1.mat','Path_Policy_1_v3.mat','Path_Policy_1_v2.mat','Path_Policy_1_v1.mat'};

%% Loop over different cases
for i = 1:6
    policysim(coverage(i),replacement(i),names{i});
end






