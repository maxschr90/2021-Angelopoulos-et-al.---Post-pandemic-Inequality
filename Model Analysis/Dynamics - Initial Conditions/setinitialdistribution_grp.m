%% Set Initial Distribution
%% This function conditions the initial distribution on a specific socioeconomic group 
function [initdist] = setinitialdistribution_grp(ALPHA, group, nn, grid_parms)
        
    class =       ((nn<4)+  (nn>12 & nn<=15)+(nn>24 & nn<=27))...
                      + 2*((nn>3 & nn<=6)+  (nn>15 & nn<=18)+(nn>27 & nn<=30))...
                      + 3*((nn>6 & nn<=9)+  (nn>18 & nn<=21)+(nn>30 & nn<=33))...
                      + 4*((nn>9 & nn<=12)+ (nn>21 & nn<=24)+(nn>33 & nn<=36));    
    ALPHA(class~=group)=0;
    ALPHA =ALPHA/sum(ALPHA);
    initdist = reshape(ALPHA,grid_parms.nkap,grid_parms.nh,max(nn));
    
end
