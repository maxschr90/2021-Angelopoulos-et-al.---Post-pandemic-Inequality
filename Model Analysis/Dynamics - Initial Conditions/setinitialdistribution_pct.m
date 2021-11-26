%% Set Initial Distribution
%% This function conditions the initial distribution on a specific pctile of the pre-covid wealth distribution
function [initdist] = setinitialdistribution_pct(ALPHA, aa, kprctile, nn, grid_parms)
        
    kp = wprctile(aa,kprctile,ALPHA,8);
    ALPHA(aa~=kp)=0;
    ALPHA =ALPHA/sum(ALPHA);
    initdist = reshape(ALPHA,grid_parms.nkap,grid_parms.nh,max(nn));
    
end