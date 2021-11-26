%% Set Initial Distribution
%% This function conditions the initial distribution on a specific pctile of the pre-covid wealth distribution
function [initdist] = setinitialdistribution_pct(ALPHA, aa, kprctile, nn, grid_parms)
        
    kp = wprctile(aa,kprctile,ALPHA,8);
    ALPHA(aa~=kp)=0;
    ALPHA =ALPHA/sum(ALPHA);
    initdist = reshape(ALPHA,grid_parms.nkap,grid_parms.nh,max(nn));
    
end

% If you want to also condition, uncomment this code and commen out the bit
% above. Make sure to also pass the grid for health (hh) to the relevant
% functions.
% function [initdist] = setinitialdistribution(ALPHA, aa, hh, prctile, nn, grid_parms)
% 
%     hp = wprctile(hh,prctile,ALPHA,8);
%     kp = wprctile(aa,prctile,ALPHA,8);
%     ALPHA(aa~=kp|hh~=hp)=0;
%     ALPHA =ALPHA/sum(ALPHA);
%     initdist = reshape(ALPHA,grid_parms.nkap,grid_parms.nh,max(nn));
%     
% end
