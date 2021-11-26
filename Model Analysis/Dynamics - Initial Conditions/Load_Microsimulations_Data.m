%% Load Microdata
%% This function loads the data from all the seperate simulations of initial conditions
clear
clc
load '../Outputs/Path_Micro_p10.mat'
Mean_K_pct(1,:) = mean(permute(Mean_K,[3,2,1]));
Mean_H_pct(1,:) = mean(permute(Mean_H,[3,2,1]));
Mean_C_pct(1,:) = mean(permute(Mean_C,[3,2,1]));
Mean_U_pct(1,:) = mean(permute(Mean_U,[3,2,1]));
Mean_K_ss_pct(1,:) = Mean_K_ss;
Mean_H_ss_pct(1,:) = Mean_H_ss;
Mean_C_ss_pct(1,:) = Mean_C_ss;
Mean_U_ss_pct(1,:) = Mean_U_ss;

load '../Outputs/Path_Micro_p25.mat'
Mean_K_pct(2,:) = mean(permute(Mean_K,[3,2,1]));
Mean_H_pct(2,:) = mean(permute(Mean_H,[3,2,1]));
Mean_C_pct(2,:) = mean(permute(Mean_C,[3,2,1]));
Mean_U_pct(2,:) = mean(permute(Mean_U,[3,2,1]));
Mean_K_ss_pct(2,:) = Mean_K_ss;
Mean_H_ss_pct(2,:) = Mean_H_ss;
Mean_C_ss_pct(2,:) = Mean_C_ss;
Mean_U_ss_pct(2,:) = Mean_U_ss;

load '../Outputs/Path_Micro_p50.mat'
Mean_K_pct(3,:) = mean(permute(Mean_K,[3,2,1]));
Mean_H_pct(3,:) = mean(permute(Mean_H,[3,2,1]));
Mean_C_pct(3,:) = mean(permute(Mean_C,[3,2,1]));
Mean_U_pct(3,:) = mean(permute(Mean_U,[3,2,1]));
Mean_K_ss_pct(3,:) = Mean_K_ss;
Mean_H_ss_pct(3,:) = Mean_H_ss;
Mean_C_ss_pct(3,:) = Mean_C_ss;
Mean_U_ss_pct(3,:) = Mean_U_ss;

load '../Outputs/Path_Micro_p75.mat'
Mean_K_pct(4,:) = mean(permute(Mean_K,[3,2,1]));
Mean_H_pct(4,:) = mean(permute(Mean_H,[3,2,1]));
Mean_C_pct(4,:) = mean(permute(Mean_C,[3,2,1]));
Mean_U_pct(4,:) = mean(permute(Mean_U,[3,2,1]));
Mean_K_ss_pct(4,:) = Mean_K_ss;
Mean_H_ss_pct(4,:) = Mean_H_ss;
Mean_C_ss_pct(4,:) = Mean_C_ss;
Mean_U_ss_pct(4,:) = Mean_U_ss;

load '../Outputs/Path_Micro_p90.mat'
Mean_K_pct(5,:) = mean(permute(Mean_K,[3,2,1]));
Mean_H_pct(5,:) = mean(permute(Mean_H,[3,2,1]));
Mean_C_pct(5,:) = mean(permute(Mean_C,[3,2,1]));
Mean_U_pct(5,:) = mean(permute(Mean_U,[3,2,1]));
Mean_K_ss_pct(5,:) = Mean_K_ss;
Mean_H_ss_pct(5,:) = Mean_H_ss;
Mean_C_ss_pct(5,:) = Mean_C_ss;
Mean_U_ss_pct(5,:) = Mean_U_ss;

load '../Outputs/Path_Micro_prof.mat'
Mean_K_grp(1,:) = mean(permute(Mean_K,[3,2,1]));
Mean_H_grp(1,:) = mean(permute(Mean_H,[3,2,1]));
Mean_C_grp(1,:) = mean(permute(Mean_C,[3,2,1]));
Mean_U_grp(1,:) = mean(permute(Mean_U,[3,2,1]));
Mean_K_ss_grp(1,:) = Mean_K_ss;
Mean_H_ss_grp(1,:) = Mean_H_ss;
Mean_C_ss_grp(1,:) = Mean_C_ss;
Mean_U_ss_grp(1,:) = Mean_U_ss;

load '../Outputs/Path_Micro_inter.mat'
Mean_K_grp(2,:) = mean(permute(Mean_K,[3,2,1]));
Mean_H_grp(2,:) = mean(permute(Mean_H,[3,2,1]));
Mean_C_grp(2,:) = mean(permute(Mean_C,[3,2,1]));
Mean_U_grp(2,:) = mean(permute(Mean_U,[3,2,1]));
Mean_K_ss_grp(2,:) = Mean_K_ss;
Mean_H_ss_grp(2,:) = Mean_H_ss;
Mean_C_ss_grp(2,:) = Mean_C_ss;

load '../Outputs/Path_Micro_rout.mat'
Mean_K_grp(3,:) = mean(permute(Mean_K,[3,2,1]));
Mean_H_grp(3,:) = mean(permute(Mean_H,[3,2,1]));
Mean_C_grp(3,:) = mean(permute(Mean_C,[3,2,1]));
Mean_U_grp(3,:) = mean(permute(Mean_U,[3,2,1]));
Mean_K_ss_grp(3,:) = Mean_K_ss;
Mean_H_ss_grp(3,:) = Mean_H_ss;
Mean_C_ss_grp(3,:) = Mean_C_ss;
Mean_U_ss_grp(3,:) = Mean_U_ss;

load '../Outputs/Path_Micro_nonemp.mat'
Mean_K_grp(4,:) = mean(permute(Mean_K,[3,2,1]));
Mean_H_grp(4,:) = mean(permute(Mean_H,[3,2,1]));
Mean_C_grp(4,:) = mean(permute(Mean_C,[3,2,1]));
Mean_U_grp(4,:) = mean(permute(Mean_U,[3,2,1]));
Mean_K_ss_grp(4,:) = Mean_K_ss;
Mean_H_ss_grp(4,:) = Mean_H_ss;
Mean_C_ss_grp(4,:) = Mean_C_ss;
Mean_U_ss_grp(4,:) = Mean_U_ss;

load '../Outputs/Path_Micro_nocap_p10.mat'
Mean_K_nocap_pct(1,:) = mean(permute(Mean_K,[3,2,1]));
Mean_H_nocap_pct(1,:) = mean(permute(Mean_H,[3,2,1]));
Mean_C_nocap_pct(1,:) = mean(permute(Mean_C,[3,2,1]));
Mean_K_ss_nocap_pct(1,:) = Mean_K_ss;
Mean_H_ss_nocap_pct(1,:) = Mean_H_ss;
Mean_C_ss_nocap_pct(1,:) = Mean_C_ss;

load '../Outputs/Path_Micro_nocap_p25.mat'
Mean_K_nocap_pct(2,:) = mean(permute(Mean_K,[3,2,1]));
Mean_H_nocap_pct(2,:) = mean(permute(Mean_H,[3,2,1]));
Mean_C_nocap_pct(2,:) = mean(permute(Mean_C,[3,2,1]));
Mean_K_ss_nocap_pct(2,:) = Mean_K_ss;
Mean_H_ss_nocap_pct(2,:) = Mean_H_ss;
Mean_C_ss_nocap_pct(2,:) = Mean_C_ss;

load '../Outputs/Path_Micro_nocap_p50.mat'
Mean_K_nocap_pct(3,:) = mean(permute(Mean_K,[3,2,1]));
Mean_H_nocap_pct(3,:) = mean(permute(Mean_H,[3,2,1]));
Mean_C_nocap_pct(3,:) = mean(permute(Mean_C,[3,2,1]));
Mean_K_ss_nocap_pct(3,:) = Mean_K_ss;
Mean_H_ss_nocap_pct(3,:) = Mean_H_ss;
Mean_C_ss_nocap_pct(3,:) = Mean_C_ss;

load '../Outputs/Path_Micro_nocap_p75.mat'
Mean_K_nocap_pct(4,:) = mean(permute(Mean_K,[3,2,1]));
Mean_H_nocap_pct(4,:) = mean(permute(Mean_H,[3,2,1]));
Mean_C_nocap_pct(4,:) = mean(permute(Mean_C,[3,2,1]));
Mean_K_ss_nocap_pct(4,:) = Mean_K_ss;
Mean_H_ss_nocap_pct(4,:) = Mean_H_ss;
Mean_C_ss_nocap_pct(4,:) = Mean_C_ss;

load '../Outputs/Path_Micro_nocap_p90.mat'
Mean_K_nocap_pct(5,:) = mean(permute(Mean_K,[3,2,1]));
Mean_H_nocap_pct(5,:) = mean(permute(Mean_H,[3,2,1]));
Mean_C_nocap_pct(5,:) = mean(permute(Mean_C,[3,2,1]));
Mean_K_ss_nocap_pct(5,:) = Mean_K_ss;
Mean_H_ss_nocap_pct(5,:) = Mean_H_ss;
Mean_C_ss_nocap_pct(5,:) = Mean_C_ss;

load '../Outputs/Path_Micro_nocap_prof.mat'
Mean_K_nocap_grp(1,:) = mean(permute(Mean_K,[3,2,1]));
Mean_H_nocap_grp(1,:) = mean(permute(Mean_H,[3,2,1]));
Mean_C_nocap_grp(1,:) = mean(permute(Mean_C,[3,2,1]));
Mean_K_ss_nocap_grp(1,:) = Mean_K_ss;
Mean_H_ss_nocap_grp(1,:) = Mean_H_ss;
Mean_C_ss_nocap_grp(1,:) = Mean_C_ss;

load '../Outputs/Path_Micro_nocap_inter.mat'
Mean_K_nocap_grp(2,:) = mean(permute(Mean_K,[3,2,1]));
Mean_H_nocap_grp(2,:) = mean(permute(Mean_H,[3,2,1]));
Mean_C_nocap_grp(2,:) = mean(permute(Mean_C,[3,2,1]));
Mean_K_ss_nocap_grp(2,:) = Mean_K_ss;
Mean_H_ss_nocap_grp(2,:) = Mean_H_ss;
Mean_C_ss_nocap_grp(2,:) = Mean_C_ss;

load '../Outputs/Path_Micro_nocap_rout.mat'
Mean_K_nocap_grp(3,:) = mean(permute(Mean_K,[3,2,1]));
Mean_H_nocap_grp(3,:) = mean(permute(Mean_H,[3,2,1]));
Mean_C_nocap_grp(3,:) = mean(permute(Mean_C,[3,2,1]));
Mean_K_ss_nocap_grp(3,:) = Mean_K_ss;
Mean_H_ss_nocap_grp(3,:) = Mean_H_ss;
Mean_C_ss_nocap_grp(3,:) = Mean_C_ss;

load '../Outputs/Path_Micro_nocap_nonemp.mat'
Mean_K_nocap_grp(4,:) = mean(permute(Mean_K,[3,2,1]));
Mean_H_nocap_grp(4,:) = mean(permute(Mean_H,[3,2,1]));
Mean_C_nocap_grp(4,:) = mean(permute(Mean_C,[3,2,1]));
Mean_K_ss_nocap_grp(4,:) = Mean_K_ss;
Mean_H_ss_nocap_grp(4,:) = Mean_H_ss;
Mean_C_ss_nocap_grp(4,:) = Mean_C_ss;

load '../Outputs/Path_Micro_uncert_p10.mat'
Mean_K_uncert_pct(1,:) = mean(permute(Mean_K,[3,2,1]));
Mean_H_uncert_pct(1,:) = mean(permute(Mean_H,[3,2,1]));
Mean_C_uncert_pct(1,:) = mean(permute(Mean_C,[3,2,1]));
Mean_K_ss_uncert_pct(1,:) = Mean_K_ss;
Mean_H_ss_uncert_pct(1,:) = Mean_H_ss;
Mean_C_ss_uncert_pct(1,:) = Mean_C_ss;

load '../Outputs/Path_Micro_uncert_p25.mat'
Mean_K_uncert_pct(2,:) = mean(permute(Mean_K,[3,2,1]));
Mean_H_uncert_pct(2,:) = mean(permute(Mean_H,[3,2,1]));
Mean_C_uncert_pct(2,:) = mean(permute(Mean_C,[3,2,1]));
Mean_K_ss_uncert_pct(2,:) = Mean_K_ss;
Mean_H_ss_uncert_pct(2,:) = Mean_H_ss;
Mean_C_ss_uncert_pct(2,:) = Mean_C_ss;

load '../Outputs/Path_Micro_uncert_p50.mat'
Mean_K_uncert_pct(3,:) = mean(permute(Mean_K,[3,2,1]));
Mean_H_uncert_pct(3,:) = mean(permute(Mean_H,[3,2,1]));
Mean_C_uncert_pct(3,:) = mean(permute(Mean_C,[3,2,1]));
Mean_K_ss_uncert_pct(3,:) = Mean_K_ss;
Mean_H_ss_uncert_pct(3,:) = Mean_H_ss;
Mean_C_ss_uncert_pct(3,:) = Mean_C_ss;

load '../Outputs/Path_Micro_uncert_p75.mat'
Mean_K_uncert_pct(4,:) = mean(permute(Mean_K,[3,2,1]));
Mean_H_uncert_pct(4,:) = mean(permute(Mean_H,[3,2,1]));
Mean_C_uncert_pct(4,:) = mean(permute(Mean_C,[3,2,1]));
Mean_K_ss_uncert_pct(4,:) = Mean_K_ss;
Mean_H_ss_uncert_pct(4,:) = Mean_H_ss;
Mean_C_ss_uncert_pct(4,:) = Mean_C_ss;

load '../Outputs/Path_Micro_uncert_p90.mat'
Mean_K_uncert_pct(5,:) = mean(permute(Mean_K,[3,2,1]));
Mean_H_uncert_pct(5,:) = mean(permute(Mean_H,[3,2,1]));
Mean_C_uncert_pct(5,:) = mean(permute(Mean_C,[3,2,1]));
Mean_K_ss_uncert_pct(5,:) = Mean_K_ss;
Mean_H_ss_uncert_pct(5,:) = Mean_H_ss;
Mean_C_ss_uncert_pct(5,:) = Mean_C_ss;

load '../Outputs/Path_Micro_uncert_prof.mat'
Mean_K_uncert_grp(1,:) = mean(permute(Mean_K,[3,2,1]));
Mean_H_uncert_grp(1,:) = mean(permute(Mean_H,[3,2,1]));
Mean_C_uncert_grp(1,:) = mean(permute(Mean_C,[3,2,1]));
Mean_K_ss_uncert_grp(1,:) = Mean_K_ss;
Mean_H_ss_uncert_grp(1,:) = Mean_H_ss;
Mean_C_ss_uncert_grp(1,:) = Mean_C_ss;

load '../Outputs/Path_Micro_uncert_inter.mat'
Mean_K_uncert_grp(2,:) = mean(permute(Mean_K,[3,2,1]));
Mean_H_uncert_grp(2,:) = mean(permute(Mean_H,[3,2,1]));
Mean_C_uncert_grp(2,:) = mean(permute(Mean_C,[3,2,1]));
Mean_K_ss_uncert_grp(2,:) = Mean_K_ss;
Mean_H_ss_uncert_grp(2,:) = Mean_H_ss;
Mean_C_ss_uncert_grp(2,:) = Mean_C_ss;

load '../Outputs/Path_Micro_uncert_rout.mat'
Mean_K_uncert_grp(3,:) = mean(permute(Mean_K,[3,2,1]));
Mean_H_uncert_grp(3,:) = mean(permute(Mean_H,[3,2,1]));
Mean_C_uncert_grp(3,:) = mean(permute(Mean_C,[3,2,1]));
Mean_K_ss_uncert_grp(3,:) = Mean_K_ss;
Mean_H_ss_uncert_grp(3,:) = Mean_H_ss;
Mean_C_ss_uncert_grp(3,:) = Mean_C_ss;

load '../Outputs/Path_Micro_uncert_nonemp.mat'
Mean_K_uncert_grp(4,:) = mean(permute(Mean_K,[3,2,1]));
Mean_H_uncert_grp(4,:) = mean(permute(Mean_H,[3,2,1]));
Mean_C_uncert_grp(4,:) = mean(permute(Mean_C,[3,2,1]));
Mean_K_ss_uncert_grp(4,:) = Mean_K_ss;
Mean_H_ss_uncert_grp(4,:) = Mean_H_ss;
Mean_C_ss_uncert_grp(4,:) = Mean_C_ss;


load '../Outputs/Path_Micro_surprise_p10.mat'
Mean_K_pct_surprise_1(1,:) = mean(permute(Mean_K,[3,2,1]));
Mean_H_pct_surprise_1(1,:) = mean(permute(Mean_H,[3,2,1]));
Mean_C_pct_surprise_1(1,:) = mean(permute(Mean_C,[3,2,1]));
Mean_U_pct_surprise_1(1,:) = mean(permute(Mean_U,[3,2,1]));

load '../Outputs/Path_Micro_surprise_p25.mat'
Mean_K_pct_surprise_1(2,:) = mean(permute(Mean_K,[3,2,1]));
Mean_H_pct_surprise_1(2,:) = mean(permute(Mean_H,[3,2,1]));
Mean_C_pct_surprise_1(2,:) = mean(permute(Mean_C,[3,2,1]));
Mean_U_pct_surprise_1(2,:) = mean(permute(Mean_U,[3,2,1]));

load '../Outputs/Path_Micro_surprise_p50.mat'
Mean_K_pct_surprise_1(3,:) = mean(permute(Mean_K,[3,2,1]));
Mean_H_pct_surprise_1(3,:) = mean(permute(Mean_H,[3,2,1]));
Mean_C_pct_surprise_1(3,:) = mean(permute(Mean_C,[3,2,1]));
Mean_U_pct_surprise_1(3,:) = mean(permute(Mean_U,[3,2,1]));

load '../Outputs/Path_Micro_surprise_p75.mat'
Mean_K_pct_surprise_1(4,:) = mean(permute(Mean_K,[3,2,1]));
Mean_H_pct_surprise_1(4,:) = mean(permute(Mean_H,[3,2,1]));
Mean_C_pct_surprise_1(4,:) = mean(permute(Mean_C,[3,2,1]));
Mean_U_pct_surprise_1(4,:) = mean(permute(Mean_U,[3,2,1]));

load '../Outputs/Path_Micro_surprise_p90.mat'
Mean_K_pct_surprise_1(5,:) = mean(permute(Mean_K,[3,2,1]));
Mean_H_pct_surprise_1(5,:) = mean(permute(Mean_H,[3,2,1]));
Mean_C_pct_surprise_1(5,:) = mean(permute(Mean_C,[3,2,1]));
Mean_U_pct_surprise_1(5,:) = mean(permute(Mean_U,[3,2,1]));

load '../Outputs/Path_Micro_surprise_prof.mat'
Mean_K_grp_surprise_1(1,:) = mean(permute(Mean_K,[3,2,1]));
Mean_H_grp_surprise_1(1,:) = mean(permute(Mean_H,[3,2,1]));
Mean_C_grp_surprise_1(1,:) = mean(permute(Mean_C,[3,2,1]));
Mean_U_grp_surprise_1(1,:) = mean(permute(Mean_U,[3,2,1]));

load '../Outputs/Path_Micro_surprise_inter.mat'
Mean_K_grp_surprise_1(2,:) = mean(permute(Mean_K,[3,2,1]));
Mean_H_grp_surprise_1(2,:) = mean(permute(Mean_H,[3,2,1]));
Mean_C_grp_surprise_1(2,:) = mean(permute(Mean_C,[3,2,1]));
Mean_U_grp_surprise_1(2,:) = mean(permute(Mean_U,[3,2,1]));

load '../Outputs/Path_Micro_surprise_rout.mat'
Mean_K_grp_surprise_1(3,:) = mean(permute(Mean_K,[3,2,1]));
Mean_H_grp_surprise_1(3,:) = mean(permute(Mean_H,[3,2,1]));
Mean_C_grp_surprise_1(3,:) = mean(permute(Mean_C,[3,2,1]));
Mean_U_grp_surprise_1(3,:) = mean(permute(Mean_U,[3,2,1]));

load '../Outputs/Path_Micro_surprise_nonemp.mat'
Mean_K_grp_surprise_1(4,:) = mean(permute(Mean_K,[3,2,1]));
Mean_H_grp_surprise_1(4,:) = mean(permute(Mean_H,[3,2,1]));
Mean_C_grp_surprise_1(4,:) = mean(permute(Mean_C,[3,2,1]));
Mean_U_grp_surprise_1(4,:) = mean(permute(Mean_U,[3,2,1]));

save('../Outputs/MicroOutputs_Data.mat')