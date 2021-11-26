%% Solve Surprise Response
%% This function solves the one period problem, for a surprise income shock
function [h_choice, i_choice, k_choice, c_choice] = SolveSurprise(parms, r, wages, Transition, grid_parms, cap, b)

    %% Algorithm Control
        orderpoly = 7; % Degree of polynominal for VF approximation 
        n_groups = 3;
    %% PARAMETERS
        chi = parms.chi;
        theta_h= parms.theta_h;
        tau = parms.tau;
        phi= parms.phi;
        mu = parms.mu; % CRRA Coefficient
        beta = parms.beta; % Discount Rate
        
    %% Human Calpital Parameters
        veta_h = repmat([ones(4*n_groups,1)*tau(1);ones(4*n_groups,1)*tau(2);ones(4*n_groups,1)*tau(3)],4,1);
        B_h = repmat(repmat(repelem(chi,1,n_groups),1,3),1,4);
    %% Building Grids for Endogenous Variables
        b_lim = parms.blim;
        nkap = grid_parms.nkap;
        kap = grid_parms.kap; % Capital 
        nh = grid_parms.nh;
        h = grid_parms.h;    
        indexsize = nh*nkap; % Total Number of Gridpoints
   %% Add Grids together & Vectorize
        kapx = repmat(1:size(kap,2),1, (indexsize/nkap));
        hx = repmat(repelem(1:size(h,2),1,nkap),1);
        exog = size(Transition,1); % Number of idiosyncratic productivity states x health states
        wages = [wages(1,:), wages(2,:), wages(3,:), wages(4,:)];
        cap = [ones(1,exog/4)*cap(1),ones(1,exog/4)*cap(2),ones(1,exog/4)*Inf,ones(1,exog/4)*Inf];


   %% Perform VFI with Interpolation
        i_policy = zeros(indexsize,exog);
        k_policy = ones(indexsize,exog)*min(kap);
        h_choice = repmat(h(hx)',1,exog);
        k_choice = k_policy;
        b = reshape(b,[],size(k_choice,2));

   %% Calculate VF + Choices at every Gridpoint
                parfor i = 1:indexsize
                        [BC(i,:),h_choice(i,:),i_choice(i,:),  k_choice(i,:), c_choice(i,:), income(i,:), util(i,:), TV(i,:)] = VFI_Interpolation_Grid( wages, r, b_lim, h(hx(i)), kap(kapx(i)),i_policy(i,:), k_policy(i,:), B_h, veta_h, theta_h, mu, phi, beta, Transition, b, orderpoly, cap, 0.01);
                end
                
               
%% reshape everything
    h_choice = reshape(h_choice,size(h_choice,1),[],4);
    i_choice = reshape(i_choice,size(i_choice,1),[],4);
    k_choice = reshape(k_choice,size(k_choice,1),[],4);
    c_choice = reshape(c_choice,size(c_choice,1),[],4);    

end
