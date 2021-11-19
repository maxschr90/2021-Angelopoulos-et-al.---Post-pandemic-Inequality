%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% SOLVE MODEL WITH AGGREGATE UNCERTAINTY AND SIMULATE A PANEL           %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear
clc

fprintf('Setup Exogenous Processes and Parameters \n')
[Normal_Transition_Pre, Normal_Transition_Post, Shock_Transition_Pre, Shock_Transition_Post, wages,Normal_Health_Trans, Shock_Health_Trans, r,  T, N, PandemicTransition,  worldstate] = SetupExogenous();
[Transitions, Transition_Agg] = GenerateTransitionMatrices(Normal_Transition_Pre, Normal_Transition_Post, Normal_Health_Trans, Shock_Transition_Pre, Shock_Transition_Post, Shock_Health_Trans, PandemicTransition);
[parms] = SetupParameters();

fprintf('Solve Stationary End Point Problem\n')
tic
[b_stat, Value_Function_stat, h_choice_stat, i_choice_stat, k_choice_stat, c_choice_stat, grid_parms, initdist] = SolveStationaryProblem(parms, r, wages(1,:), Transitions(:,:,1));
fprintf('Stationary Problem has Converged in: %.5f seconds. \n',toc')

fprintf('Simulate Stationary Distribution\n')
tic
[ALPHA, aa, hh, nn] = nonstochsim_stat(initdist,Transitions(:,:,1), h_choice_stat, k_choice_stat, grid_parms);
fprintf('Simulation of Stationary Distribution completed in: %.5f seconds. \n',toc')
initdist = reshape(ALPHA, size(initdist));
cap = wprctile(c_choice_stat(:),70,ALPHA(:),8);

fprintf('Solve Problem with Aggregate Uncertainty \n')
tic
[b, Value_Function, h_choice, i_choice, k_choice, c_choice] = SolveStationaryProblem_Agg(parms, r, wages, Transition_Agg, grid_parms, cap);
fprintf('Dynamic Problem has Completed in: %.5f seconds. \n',toc')
save('Path_AggUncertainty_Panel_v1.mat')

h_choice(:,:,4) = h_choice_stat;
k_choice(:,:,4) = k_choice_stat;
c_choice(:,:,4) = c_choice_stat;
i_choice(:,:,4) = i_choice_stat;
exostates=nn;
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
        [Share_Healthstatus(:,:,n), Share_Class(:,:,n), Share_HTM(:,:,n), Health_HTM(:,:,n), Mean_K(:,:,n), Mean_H(:,:,n), Mean_C(:,:,n), Mean_E(:,:,n), Mean_Y(:,:,n), Mean_I(:,:,n), Median_K(:,:,n), Median_H(:,:,n), Median_C(:,:,n), Median_E(:,:,n), Median_I(:,:,n), Var_K(:,:,n), Var_H(:,:,n), Var_C(:,:,n), Var_E(:,:,n), Var_I(:,:,n), GINI_H(:,:,n), GINI_K(:,:,n), GINI_C(:,:,n), GINI_E(:,:,n), GINI_Y(:,:,n), GINI_I(:,:,n), P10_K(:,:,n), P10_H(:,:,n), P10_C(:,:,n), P10_E(:,:,n), P10_I(:,:,n), P20_K(:,:,n), P20_H(:,:,n), P20_C(:,:,n), P20_E(:,:,n), P20_I(:,:,n), P50_K(:,:,n), P50_H(:,:,n), P50_C(:,:,n), P50_E(:,:,n), P50_I(:,:,n), P90_K(:,:,n), P90_H(:,:,n), P90_C(:,:,n), P90_E(:,:,n), P90_I(:,:,n), Mean_H_Class(:,:,n), Mean_K_Class(:,:,n), Mean_C_Class(:,:,n), Mean_E_Class(:,:,n), Mean_Y_Class(:,:,n), Mean_I_Class(:,:,n),Median_H_Class(:,:,n), Median_K_Class(:,:,n), Median_C_Class(:,:,n), Median_E_Class(:,:,n), Median_I_Class(:,:,n),Var_H_Class(:,:,n), Var_K_Class(:,:,n), Var_C_Class(:,:,n), Var_E_Class(:,:,n), Var_I_Class(:,:,n),P10_H_Class(:,:,n), P10_K_Class(:,:,n), P10_C_Class(:,:,n), P10_E_Class(:,:,n), P10_I_Class(:,:,n), P90_H_Class(:,:,n), P90_K_Class(:,:,n), P90_C_Class(:,:,n), P90_E_Class(:,:,n), P90_I_Class(:,:,n),GINI_H_Class(:,:,n), GINI_K_Class(:,:,n), GINI_C_Class(:,:,n), GINI_E_Class(:,:,n), GINI_Y_Class(:,:,n), GINI_I_Class(:,:,n), Quintile_Share(:,:,n), Share_HTM_Class(:,:,n), Wagstaffindex_E(:,:,n), Erregyersindex_E(:,:,n), Wagstaffindex_K(:,:,n), Erregyersindex_K(:,:,n)] = SummaryStatistics(OMEGA(:,:,n), h_choice, k_choice, i_choice, c_choice, wages, r, aa, exostates, worldstate(n,:));
    end
    
    OMEGA = [];
    fprintf('Statistics have been calculated in: %.5f seconds. \n',toc')

    save('Path_AggUncertainty_Panel_v4.mat')

end

save('Path_AggUncertainty_Panel_v4.mat')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% END OF MAIN CODE %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% DEFINE FUNCTIONS %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% FUNCTION I - Bellman Equation %%
function [V] = bellman(i,k_tt,c,h_t,veta_h, b,orderpoly,Transition,theta_h,B_h, beta,mu,phi)

    V = -((((((((c)^(1-phi))*(((h_t*veta_h+B_h*(i^theta_h)))^phi))).^(1-mu)))./(1-mu))+beta*expectedvalue((h_t*veta_h+B_h*(i^theta_h)),k_tt,b,orderpoly)*Transition') ;
    % We use the negative of V so it can be passed to fmincon

end

%% FUNCTION II - Expected Value %%
function [EV] = expectedvalue(hx,kapx,b,p)

%% Generate Polynominal Expansion of order p
    if p==1
        poly = [hx' kapx' hx'.*kapx'];
    elseif p==2
        poly = [hx' kapx' hx'.*kapx' hx'.^2 kapx'.^2 hx'.^2.*kapx' hx'.*kapx'.^2 (hx'.*kapx').^2];
    elseif p==3
        poly = [hx' kapx' hx'.*kapx' hx'.^2 kapx'.^2 hx'.^2.*kapx' hx'.*kapx'.^2 (hx'.*kapx').^2 hx'.^3 kapx'.^3 hx'.^3.*kapx' hx'.*kapx'.^3 hx'.^3.*kapx'.^2 hx'.^2.*kapx'.^3 (hx'.*kapx').^3];
    elseif p==4
        poly = [hx' kapx' hx'.*kapx' hx'.^2 kapx'.^2 hx'.^2.*kapx' hx'.*kapx'.^2 (hx'.*kapx').^2 hx'.^3 kapx'.^3 hx'.^3.*kapx' hx'.*kapx'.^3 hx'.^3.*kapx'.^2 hx'.^2.*kapx'.^3 (hx'.*kapx').^3 ...
                hx'.^4 kapx'.^4 hx'.^4.*kapx' hx'.*kapx'.^4 hx'.^4.*kapx'.^2 hx'.^2.*kapx'.^4 hx'.^4.*kapx'.^3 hx'.^3.*kapx'.^4 (hx'.*kapx').^4];
     elseif p==5
        poly = [hx' kapx' hx'.*kapx' hx'.^2 kapx'.^2 hx'.^2.*kapx' hx'.*kapx'.^2 (hx'.*kapx').^2 hx'.^3 kapx'.^3 hx'.^3.*kapx' hx'.*kapx'.^3 hx'.^3.*kapx'.^2 hx'.^2.*kapx'.^3 (hx'.*kapx').^3 ...
                hx'.^4 kapx'.^4 hx'.^4.*kapx' hx'.*kapx'.^4 hx'.^4.*kapx'.^2 hx'.^2.*kapx'.^4 hx'.^4.*kapx'.^3 hx'.^3.*kapx'.^4 (hx'.*kapx').^4 hx'.^5 kapx'.^5 hx'.^5.*kapx' hx'.*kapx'.^5 hx'.^5.*kapx'.^2 hx'.^2.*kapx'.^5 ...
                hx'.^5.*kapx'.^3 hx'.^3.*kapx'.^5  hx'.^5.*kapx'.^4 hx'.^4.*kapx'.^5  hx'.^5.*kapx'.^5];

    elseif p==7
        poly = [hx' kapx' hx'.*kapx' hx'.^2 kapx'.^2 hx'.^2.*kapx' hx'.*kapx'.^2 (hx'.*kapx').^2 hx'.^3 kapx'.^3 hx'.^3.*kapx' hx'.*kapx'.^3 hx'.^3.*kapx'.^2 hx'.^2.*kapx'.^3 (hx'.*kapx').^3 ...
                hx'.^4 kapx'.^4 hx'.^4.*kapx' hx'.*kapx'.^4 hx'.^4.*kapx'.^2 hx'.^2.*kapx'.^4 hx'.^4.*kapx'.^3 hx'.^3.*kapx'.^4 (hx'.*kapx').^4 ...
                hx'.^5 kapx'.^5 hx'.^5.*kapx' hx'.*kapx'.^5 hx'.^5.*kapx'.^2 hx'.^2.*kapx'.^5 hx'.^5.*kapx'.^3 hx'.^3.*kapx'.^5  hx'.^5.*kapx'.^4 hx'.^4.*kapx'.^5  hx'.^5.*kapx'.^5 ...
                hx'.^6 kapx'.^6 hx'.^6.*kapx' hx'.*kapx'.^6 hx'.^6.*kapx'.^2 hx'.^2.*kapx'.^6 hx'.^6.*kapx'.^3 hx'.^3.*kapx'.^6  hx'.^6.*kapx'.^4 hx'.^4.*kapx'.^6 hx'.^6.*kapx'.^5 hx'.^5.*kapx'.^6  hx'.^6.*kapx'.^6 ...
                hx'.^7 kapx'.^7 hx'.^7.*kapx' hx'.*kapx'.^7 hx'.^7.*kapx'.^2 hx'.^2.*kapx'.^7 hx'.^7.*kapx'.^3 hx'.^3.*kapx'.^7  hx'.^7.*kapx'.^4 hx'.^4.*kapx'.^7 hx'.^7.*kapx'.^5 hx'.^5.*kapx'.^7  hx'.^7.*kapx'.^6 hx'.^6.*kapx'.^7  hx'.^7.*kapx'.^7 ];

    end
      EV = ([ones(size(poly,1),1) poly]*b);
    
end

%% FUNCTION III - Generate Exogenous Transition Matrices %%

function [Transitions, Transition_Agg] = GenerateTransitionMatrices(Normal_Transition_Pre, Normal_Transition_Post, Normal_Health_Trans, Shock_Transition_Pre, Shock_Transition_Post, Shock_Health_Trans, PandemicTransition)

    Stat_Transition_combined = repmat([Normal_Transition_Pre, Normal_Transition_Post,Normal_Transition_Post],3,1);
    Shock_Transition_combined = repmat([Shock_Transition_Pre, Shock_Transition_Post,Shock_Transition_Post],3,1);
    Transitions(:,:,1) = Normal_Health_Trans.*Stat_Transition_combined;
    Transitions(:,:,2) = Shock_Health_Trans.*Shock_Transition_combined;
    Transitions(:,:,3) = Normal_Health_Trans.*Stat_Transition_combined;

    Transition_Agg = [Transitions(:,:,1)*PandemicTransition(1,1), Transitions(:,:,2)*PandemicTransition(1,2),Transitions(:,:,1)*PandemicTransition(1,3);...
                      Transitions(:,:,1)*PandemicTransition(2,1), Transitions(:,:,2)*PandemicTransition(2,2),Transitions(:,:,1)*PandemicTransition(2,3);...
                      Transitions(:,:,1)*PandemicTransition(3,1), Transitions(:,:,2)*PandemicTransition(3,2),Transitions(:,:,1)*PandemicTransition(3,3);...
                      ];

end

%% FUNCTION IV - Gini %%

function [ relpop,relz,g ] = gini( yy1,probst )
% %Modified Matlab function "Gini" by Yvan Lengwiler% Release: $1.0$% Date   : $2010-06-27$
% the current version handles negative values as well. 
%
% Copyright (c) 2010, Yvan Lengwiler
% All rights reserved.
%  The original file can be found here:
% https://uk.mathworks.com/matlabcentral/fileexchange/28080-gini-coefficient-and-the-lorentz-curve
% 
% Redistribution and use in source and binary forms, with or without
% modification, are permitted provided that the following conditions are met:
% 
% * Redistributions of source code must retain the above copyright notice, this
%   list of conditions and the following disclaimer.
% 
% * Redistributions in binary form must reproduce the above copyright notice,
%   this list of conditions and the following disclaimer in the documentation
%   and/or other materials provided with the distribution
% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
% AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
% IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
% DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE
% FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
% DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
% SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
% CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
% OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
% OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.




order_y=[probst yy1];
order_y=sortrows(order_y,2);

values=order_y(:,2);
prob=order_y(:,1);


z = values .* prob;
[~,ord] = sort(values);
prob    = prob(ord);     z    = z(ord);
prob    = cumsum(prob);  z    = cumsum(z);
relpop = prob/prob(end); 
relz = z/z(end);

g = 1 - sum((relz(1:end-1)+relz(2:end)) .* diff(relpop));

end

%% FUNCTION V - Interpolate the Value Function %%

function b = interpV(Value_Function, hx, kapx, n)

%% Generate Polynominal of order n    
    if n==1
        poly = [hx' kapx' hx'.*kapx'];
    elseif n==2
        poly = [hx' kapx' hx'.*kapx' hx'.^2 kapx'.^2 hx'.^2.*kapx' hx'.*kapx'.^2 (hx'.*kapx').^2];
    elseif n==3
        poly = [hx' kapx' hx'.*kapx' hx'.^2 kapx'.^2 hx'.^2.*kapx' hx'.*kapx'.^2 (hx'.*kapx').^2 hx'.^3 kapx'.^3 hx'.^3.*kapx' hx'.*kapx'.^3 hx'.^3.*kapx'.^2 hx'.^2.*kapx'.^3 (hx'.*kapx').^3];
    elseif n==4
        poly = [hx' kapx' hx'.*kapx' hx'.^2 kapx'.^2 hx'.^2.*kapx' hx'.*kapx'.^2 (hx'.*kapx').^2 hx'.^3 kapx'.^3 hx'.^3.*kapx' hx'.*kapx'.^3 hx'.^3.*kapx'.^2 hx'.^2.*kapx'.^3 (hx'.*kapx').^3 ...
                hx'.^4 kapx'.^4 hx'.^4.*kapx' hx'.*kapx'.^4 hx'.^4.*kapx'.^2 hx'.^2.*kapx'.^4 hx'.^4.*kapx'.^3 hx'.^3.*kapx'.^4 (hx'.*kapx').^4];
    elseif n==5
        poly = [hx' kapx' hx'.*kapx' hx'.^2 kapx'.^2 hx'.^2.*kapx' hx'.*kapx'.^2 (hx'.*kapx').^2 hx'.^3 kapx'.^3 hx'.^3.*kapx' hx'.*kapx'.^3 hx'.^3.*kapx'.^2 hx'.^2.*kapx'.^3 (hx'.*kapx').^3 ...
                hx'.^4 kapx'.^4 hx'.^4.*kapx' hx'.*kapx'.^4 hx'.^4.*kapx'.^2 hx'.^2.*kapx'.^4 hx'.^4.*kapx'.^3 hx'.^3.*kapx'.^4 (hx'.*kapx').^4 hx'.^5 kapx'.^5 hx'.^5.*kapx' hx'.*kapx'.^5 hx'.^5.*kapx'.^2 hx'.^2.*kapx'.^5 ...
                hx'.^5.*kapx'.^3 hx'.^3.*kapx'.^5  hx'.^5.*kapx'.^4 hx'.^4.*kapx'.^5  hx'.^5.*kapx'.^5];
    elseif n==7
        poly = [hx' kapx' hx'.*kapx' hx'.^2 kapx'.^2 hx'.^2.*kapx' hx'.*kapx'.^2 (hx'.*kapx').^2 hx'.^3 kapx'.^3 hx'.^3.*kapx' hx'.*kapx'.^3 hx'.^3.*kapx'.^2 hx'.^2.*kapx'.^3 (hx'.*kapx').^3 ...
                hx'.^4 kapx'.^4 hx'.^4.*kapx' hx'.*kapx'.^4 hx'.^4.*kapx'.^2 hx'.^2.*kapx'.^4 hx'.^4.*kapx'.^3 hx'.^3.*kapx'.^4 (hx'.*kapx').^4 ...
                hx'.^5 kapx'.^5 hx'.^5.*kapx' hx'.*kapx'.^5 hx'.^5.*kapx'.^2 hx'.^2.*kapx'.^5 hx'.^5.*kapx'.^3 hx'.^3.*kapx'.^5  hx'.^5.*kapx'.^4 hx'.^4.*kapx'.^5  hx'.^5.*kapx'.^5 ...
                hx'.^6 kapx'.^6 hx'.^6.*kapx' hx'.*kapx'.^6 hx'.^6.*kapx'.^2 hx'.^2.*kapx'.^6 hx'.^6.*kapx'.^3 hx'.^3.*kapx'.^6  hx'.^6.*kapx'.^4 hx'.^4.*kapx'.^6 hx'.^6.*kapx'.^5 hx'.^5.*kapx'.^6  hx'.^6.*kapx'.^6 ...
                hx'.^7 kapx'.^7 hx'.^7.*kapx' hx'.*kapx'.^7 hx'.^7.*kapx'.^2 hx'.^2.*kapx'.^7 hx'.^7.*kapx'.^3 hx'.^3.*kapx'.^7  hx'.^7.*kapx'.^4 hx'.^4.*kapx'.^7 hx'.^7.*kapx'.^5 hx'.^5.*kapx'.^7  hx'.^7.*kapx'.^6 hx'.^6.*kapx'.^7  hx'.^7.*kapx'.^7 ];

    end
%% Standardize Values to be mean 0 and std 1    
    s = var(poly).^0.5;
    m = mean(poly);
    poly = ((poly - m)./s);
%% Use Regression to find Coefficients
    b = [ones(size(hx,2),1) poly]\Value_Function;
    b(1,:) = b(1,:)-(m./s)*b(2:end,:);
    b(2:end,:) = b(2:end,:)./s';
    end

%% FUNCTION VI - Nonstochastic Simulation with aggregate uncertainty  %%
    
function [OMEGA, aa, hh, nn] = nonstochsim_agg(initdist,Transitions, h_choice, k_choice, grid_parms, worldstate)

nkap = grid_parms.nkap;
kap = grid_parms.kap; 
nh = grid_parms.nh;
h = grid_parms.h;

%% let us simulate the model economy 
N=size(Transitions,2);
[T] = size(worldstate,2);
amin=min(kap);
amax=max(kap);
OMEGA=[];


Omegat=initdist;
Omegatp=zeros(nkap,nh,N);

H1_grid(:,:,:,1) = reshape(h_choice(:,:,1),nkap, nh, N); 
K_grid(:,:,:,1) = reshape(k_choice(:,:,1),nkap, nh, N); 
K_grid(:,:,:,1)=amin.*(K_grid(:,:,:,1)<amin)+amax.*(K_grid(:,:,:,1)>amax)+K_grid(:,:,:,1).*(K_grid(:,:,:,1)>=amin & K_grid(:,:,:,1)<=amax);
H1_grid(:,:,:,1)=0.1.*(H1_grid(:,:,:,1)<0.1)+1.*(H1_grid(:,:,:,1)>1)+H1_grid(:,:,:,1).*(H1_grid(:,:,:,1)>=0.1 & H1_grid(:,:,:,1)<=1);

H1_grid(:,:,:,2) = reshape(h_choice(:,:,2),nkap, nh, N); 
K_grid(:,:,:,2) = reshape(k_choice(:,:,2),nkap, nh, N); 
K_grid(:,:,:,2)=amin.*(K_grid(:,:,:,2)<amin)+amax.*(K_grid(:,:,:,2)>amax)+K_grid(:,:,:,2).*(K_grid(:,:,:,2)>=amin & K_grid(:,:,:,2)<=amax);
H1_grid(:,:,:,2)=0.1.*(H1_grid(:,:,:,2)<0.1)+1.*(H1_grid(:,:,:,2)>1)+H1_grid(:,:,:,2).*(H1_grid(:,:,:,2)>=0.1 & H1_grid(:,:,:,2)<=1);

H1_grid(:,:,:,3) = reshape(h_choice(:,:,3),nkap, nh, N); 
K_grid(:,:,:,3) = reshape(k_choice(:,:,3),nkap, nh, N); 
K_grid(:,:,:,3)=amin.*(K_grid(:,:,:,3)<amin)+amax.*(K_grid(:,:,:,3)>amax)+K_grid(:,:,:,3).*(K_grid(:,:,:,3)>=amin & K_grid(:,:,:,3)<=amax);
H1_grid(:,:,:,3)=0.1.*(H1_grid(:,:,:,3)<0.1)+1.*(H1_grid(:,:,:,3)>1)+H1_grid(:,:,:,3).*(H1_grid(:,:,:,3)>=0.1 & H1_grid(:,:,:,3)<=1);
    
 
% Look-up index.

[hhg,aag]=meshgrid(h,kap);

aa=repmat(aag,1,1,N);
hh=repmat(hhg,1,1,N);
nn = ones(size(aa)).*reshape((1:1:N),1,1,N);


Im       = zeros([size(aa),2]);
Jm       = zeros([size(aa),2]);

for j=1:N
        % Linear interpolation of probabilities
   for ai = 1:nkap     
         for hi = 1:nh     
                Im(ai,hi,j,1) = find(K_grid(ai,hi,j,1)>=kap,1,'last');
                Jm(ai,hi,j,1) = find(H1_grid(ai,hi,j,1)>=h,1,'last');
                Im(ai,hi,j,1) = min(Im(ai,hi,j,1),nkap-1);
                Jm(ai,hi,j,1) = min(Jm(ai,hi,j,1),nh-1);
                
                Im(ai,hi,j,2) = find(K_grid(ai,hi,j,2)>=kap,1,'last');
                Jm(ai,hi,j,2) = find(H1_grid(ai,hi,j,2)>=h,1,'last');
                Im(ai,hi,j,2) = min(Im(ai,hi,j,2),nkap-1);
                Jm(ai,hi,j,2) = min(Jm(ai,hi,j,2),nh-1);

                Im(ai,hi,j,3) = find(K_grid(ai,hi,j,3)>=kap,1,'last');
                Jm(ai,hi,j,3) = find(H1_grid(ai,hi,j,3)>=h,1,'last');
                Im(ai,hi,j,3) = min(Im(ai,hi,j,3),nkap-1);
                Jm(ai,hi,j,3) = min(Jm(ai,hi,j,3),nh-1);

         end
   end
end

for t=1:T

    PI=Transitions(:,:,worldstate(t)+1); 
 for j=1:N
        % Linear interpolation of probabilities
   for ai = 1:nkap     
         for hi = 1:nh     
            for jp=1:N
                I =Im(ai,hi,j,worldstate(t)+1);
                J =Jm(ai,hi,j,worldstate(t)+1);
                
                rhok = (K_grid(ai,hi,j,worldstate(t)+1)-kap(I+1))./(kap(I)-kap(I+1));
                rhoh = (H1_grid(ai,hi,j,worldstate(t)+1)-h(J+1))./(h(J)-h(J+1));
                Omegatp(I,J,jp)   = Omegatp(I,J,jp)+Omegat(ai,hi,j)*PI(j,jp)*rhok*rhoh;
                Omegatp(I+1,J+1,jp) = Omegatp(I+1,J+1,jp)+Omegat(ai,hi,j)*PI(j,jp)*(1-rhok)*(1-rhoh);
                Omegatp(I+1,J,jp)   = Omegatp(I+1,J,jp)+Omegat(ai,hi,j)*PI(j,jp)*(1-rhok)*(rhoh);
                Omegatp(I,J+1,jp) = Omegatp(I,J+1,jp)+Omegat(ai,hi,j)*PI(j,jp)*(rhok)*(1-rhoh);
               
            end
         end
   end
end

   OMEGA=[OMEGA Omegat(:)];
  
    Omegat=Omegatp;
    Omegatp=zeros(nkap,nh,N);
end

aa = aa(:);
hh = hh(:);
nn = nn(:);
end

%% FUNCTION VII - Nonstochastic Simulation for stationary economy%%

function [OMEGA, aa, hh, nn] = nonstochsim_stat(initdist,Transitions, h_choice, k_choice, grid_parms)

nkap = grid_parms.nkap;
kap = grid_parms.kap; % Capital 
nh = grid_parms.nh;
h = grid_parms.h;            % Health
%% let us simulate the model economy 
N=size(Transitions,2);
amin=min(kap);
amax=max(kap);
OMEGA=[];


Omegat=initdist;
Omegatp=zeros(nkap,nh,N);
hist_crit = 1;
H1_grid = reshape(h_choice,nkap, nh, N); 
K_grid = reshape(k_choice,nkap, nh, N); 
K_grid=amin.*(K_grid<amin)+amax.*(K_grid>amax)+K_grid.*(K_grid>=amin & K_grid<=amax);
H1_grid=0.1.*(H1_grid<0.1)+1.*(H1_grid>1)+H1_grid.*(H1_grid>=0.1 & H1_grid<=1);
       
 
% Look-up index.

[hhg,aag]=meshgrid(h,kap);

aa=repmat(aag,1,1,N);
hh=repmat(hhg,1,1,N);
nn = ones(size(aa)).*reshape((1:1:N),1,1,N);


Im       = zeros(size(aa));
Jm       = zeros(size(aa));

for j=1:N
        % Linear interpolation of probabilities
   parfor ai = 1:nkap     
         for hi = 1:nh     
                Im(ai,hi,j) = find(K_grid(ai,hi,j)>=kap,1,'last');
                Jm(ai,hi,j) = find(H1_grid(ai,hi,j)>=h,1,'last');
                Im(ai,hi,j) = min(Im(ai,hi,j),nkap-1);
                Jm(ai,hi,j) = min(Jm(ai,hi,j),nh-1);
         end
   end
end

while hist_crit >10^-8    

    PI=squeeze(Transitions); 
 for j=1:N
        % Linear interpolation of probabilities
   for ai = 1:nkap     
         for hi = 1:nh     
            for jp=1:N
                I =Im(ai,hi,j);
                J =Jm(ai,hi,j);
                
                rhok = (K_grid(ai,hi,j)-kap(I+1))./(kap(I)-kap(I+1));
                rhoh = (H1_grid(ai,hi,j)-h(J+1))./(h(J)-h(J+1));
                Omegatp(I,J,jp)   = Omegatp(I,J,jp)+Omegat(ai,hi,j)*PI(j,jp)*rhok*rhoh;
                Omegatp(I+1,J+1,jp) = Omegatp(I+1,J+1,jp)+Omegat(ai,hi,j)*PI(j,jp)*(1-rhok)*(1-rhoh);
                Omegatp(I+1,J,jp)   = Omegatp(I+1,J,jp)+Omegat(ai,hi,j)*PI(j,jp)*(1-rhok)*(rhoh);
                Omegatp(I,J+1,jp) = Omegatp(I,J+1,jp)+Omegat(ai,hi,j)*PI(j,jp)*(rhok)*(1-rhoh);
               
            end
         end
   end
end

   OMEGA=[OMEGA Omegat(:)];
  
    hist_crit = norm(Omegat(:)-Omegatp(:),inf);
    Omegat=Omegatp;
    Omegatp=zeros(nkap,nh,N);
end

aa = aa(:);
hh = hh(:);
nn = nn(:);
OMEGA=OMEGA(:,end);
end

%% FUNCTION VIII - Setup Exogenous Processes %%

function [Normal_Transition_Pre, Normal_Transition_Post, Pandemic_Transition_Pre, Pandemic_Transition_Post, wages,Normal_Health_Trans, Pandemic_Health_Trans, r,  T, N, PandemicTransition,  worldstate] = SetupExogenous()
     %% Employment States & Productivities
          n_groups =3;
          Normal_Transition_Pre =[0.711503348000000,0.161290323000000,0.0438222760000000,0.0511259890000000,0.0133901400000000,0.0112598900000000,0.00213025000000000,0.000912964000000000,0.000912964000000000,0.00182592800000000,0.000608643000000000,0.00121728500000000;0.136965152000000,0.626819585000000,0.140273489000000,0.0500661670000000,0.0213939130000000,0.0119100130000000,0.00286722500000000,0.00154389100000000,0.00176444600000000,0.000882223000000000,0.000441112000000000,0.00507278300000000;0.0464423940000000,0.199464126000000,0.642453111000000,0.0133968440000000,0.0479309320000000,0.0288776420000000,0.00357249200000000,0.00357249200000000,0.00654956800000000,0.00119083100000000,0.00119083100000000,0.00535873800000000;0.0193726940000000,0.0277905900000000,0.00449723200000000,0.686692804000000,0.185078413000000,0.0525830260000000,0.00853321000000000,0.00438191900000000,0.00484317300000000,0.00196033200000000,0.00115313700000000,0.00311346900000000;0.00448082700000000,0.0110297290000000,0.0133563120000000,0.139250323000000,0.624558380000000,0.164325722000000,0.0121499350000000,0.0105988800000000,0.00801378700000000,0.00292977200000000,0.00318828100000000,0.00611805300000000;0.00338327700000000,0.00555824100000000,0.0144997580000000,0.0561865640000000,0.230425326000000,0.626993717000000,0.00579990300000000,0.0158289030000000,0.0180038670000000,0.00410826500000000,0.00628322900000000,0.0129289510000000;0.00305470700000000,0.00388780900000000,0.00444321000000000,0.0319355730000000,0.0458206050000000,0.0172174400000000,0.627325743000000,0.189947237000000,0.0455429050000000,0.00916412100000000,0.0113857260000000,0.0102749240000000;0.000209424000000000,0.00230366500000000,0.00397905800000000,0.00900523600000000,0.0351832460000000,0.0387434550000000,0.149319372000000,0.536544503000000,0.184502618000000,0.00879581200000000,0.0140314140000000,0.0173821990000000;0.000611247000000000,0.00275061100000000,0.00672371600000000,0.0122249390000000,0.0284229830000000,0.0595965770000000,0.0547066010000000,0.253361858000000,0.526894866000000,0.00611246900000000,0.0177261610000000,0.0308679710000000;0,0.00199700400000000,0.00199700400000000,0.00349475800000000,0.0239640540000000,0.0284573140000000,0.0179730400000000,0.0329505740000000,0.0119820270000000,0.561158263000000,0.250124813000000,0.0659011480000000;0.000333111000000000,0.000666223000000000,0.00133244500000000,0.00433044600000000,0.0143237840000000,0.0363091270000000,0.0139906730000000,0.0556295800000000,0.0379746840000000,0.167221852000000,0.500333111000000,0.167554963000000;0.00140252500000000,0.00374006500000000,0.00935016400000000,0.00841514700000000,0.0275829830000000,0.0645161290000000,0.0168302950000000,0.0500233750000000,0.0677886860000000,0.0677886860000000,0.240299205000000,0.442262740000000];
          Normal_Transition_Post  =[0.705555556000000,0.116666667000000,0.0611111110000000,0.0722222220000000,0.00555555600000000,0.0222222220000000,0.00555555600000000,0,0,0.0111111110000000,0,0;0.116731518000000,0.653696498000000,0.136186770000000,0.0466926070000000,0.0272373540000000,0.0116731520000000,0,0.00389105100000000,0.00389105100000000,0,0,0;0.0600000000000000,0.206666667000000,0.653333333000000,0.00666666700000000,0.0266666670000000,0.0200000000000000,0,0.00666666700000000,0.00666666700000000,0.00666666700000000,0,0.00666666700000000;0.0176678450000000,0.0176678450000000,0.00176678400000000,0.734982332000000,0.150176678000000,0.0530035340000000,0.00883392200000000,0,0.00353356900000000,0.00176678400000000,0.00530035300000000,0.00530035300000000;0.00870827300000000,0.00870827300000000,0.0101596520000000,0.126269956000000,0.648766328000000,0.142235123000000,0.0145137880000000,0.00725689400000000,0.0145137880000000,0.00435413600000000,0.00580551500000000,0.00870827300000000;0,0.00635593200000000,0.0127118640000000,0.0508474580000000,0.207627119000000,0.625000000000000,0.00635593200000000,0.0190677970000000,0.0254237290000000,0.0127118640000000,0.0148305080000000,0.0190677970000000;0,0,0,0.0218340610000000,0.0436681220000000,0.0262008730000000,0.624454148000000,0.183406114000000,0.0393013100000000,0.0349344980000000,0.0131004370000000,0.0131004370000000;0,0,0.00692041500000000,0,0.0346020760000000,0.0207612460000000,0.179930796000000,0.498269896000000,0.200692042000000,0.0138408300000000,0.0207612460000000,0.0242214530000000;0,0,0,0.0109489050000000,0.0218978100000000,0.0620437960000000,0.0583941610000000,0.164233577000000,0.616788321000000,0.00364963500000000,0.0328467150000000,0.0291970800000000;0,0.00194174800000000,0,0,0.00194174800000000,0.00776699000000000,0.0135922330000000,0.00776699000000000,0.00776699000000000,0.700970874000000,0.231067961000000,0.0271844660000000;0,0.00202839800000000,0,0,0.0121703850000000,0.0121703850000000,0,0.0162271810000000,0.0121703850000000,0.269776876000000,0.503042596000000,0.172413793000000;0,0,0.00349650300000000,0,0,0.0209790210000000,0.0139860140000000,0.0244755240000000,0.0314685310000000,0.101398601000000,0.293706294000000,0.510489510000000];
          Pandemic_Transition_Pre  = Normal_Transition_Pre;
          Pandemic_Transition_Post  = Normal_Transition_Post;
          PandemicTransitionAdjustmentMatrix =  0.9496*ones(12);
          PandemicTransitionAdjustmentMatrix(1:3,:) = 0;
          PandemicTransitionAdjustmentMatrix(:,10:12) = 0;
          ExtraUnemployment = 1-sum(Pandemic_Transition_Pre.*PandemicTransitionAdjustmentMatrix,2);
          ExtraUnemploymentShare = ExtraUnemployment.*Pandemic_Transition_Pre(:,end-2:end)./sum(Pandemic_Transition_Pre(:,end-2:end),2);
          Pandemic_Transition_Pre(4:12,1:9) = 0.9496*Pandemic_Transition_Pre(4:12,1:9);
          Pandemic_Transition_Pre(4:12,10:12)=ExtraUnemploymentShare(4:12,:);
          ExtraUnemployment = 1-sum(Pandemic_Transition_Post.*PandemicTransitionAdjustmentMatrix,2);
          ExtraUnemploymentShare = ExtraUnemployment.*Pandemic_Transition_Post(:,end-2:end)./sum(Pandemic_Transition_Post(:,end-2:end),2);
          Pandemic_Transition_Post(4:12,1:9) = 0.9496*Pandemic_Transition_Post(4:12,1:9);
          Pandemic_Transition_Post(4:12,10:12)=ExtraUnemploymentShare(4:12,:);                                     
          wages_Normal =repmat([2.25153923300000;1.45145218300000;0.902928998000000;1.63457864600000;1.00168807100000;0.588697138000000;1.08790704100000;0.702977449000000;0.444859442000000;0.755734786000000;0.469591037000000;0.251809510000000],3,1);              
          wages_Normal = (wages_Normal')/[1.03953360209967]; % idiosyncratic productivity states
        
                
      %% Health Shocks
          Normal_ShockProb =  repelem([0.0101503400000000,0.00924064300000000,0.0115799800000000,0.0248253310000000],1,n_groups)';
          Normal_RecoveryProb = [0.0895];
          Normal_Health_Trans = [repmat(1-Normal_ShockProb,1,4*n_groups),repmat(Normal_ShockProb,1,4*n_groups), zeros(4*n_groups);...
                               zeros(4*n_groups), zeros(4*n_groups), ones(4*n_groups);...
                               ones(4*n_groups)*Normal_RecoveryProb,      zeros(4*n_groups), 1-ones(4*n_groups)*Normal_RecoveryProb];          
          Pandemic_ShockProb = Normal_ShockProb*(1+0.25);
          Pandemic_RecoveryProb = [0.0895];
          Pandemic_Health_Trans = [repmat(1-Pandemic_ShockProb,1,4*n_groups),repmat(Pandemic_ShockProb,1,4*n_groups), zeros(4*n_groups);...
                               zeros(4*n_groups), zeros(4*n_groups), ones(4*n_groups);...
                               ones(4*n_groups)*Pandemic_RecoveryProb,      zeros(4*n_groups), 1-ones(4*n_groups)*Pandemic_RecoveryProb];

        %% Time Series of Aggregate States
        wages = repmat(wages_Normal,2,1);
        wages(2,:) = wages(2,:).*repmat((repelem([0.9625, 0.925, 0.8875,1],1,3)),1,3);
        wages(3,:) = wages(1,:);
        r = 0.0056;
        PandemicTransition = [ [0.307615900000000]  ,.6423841, 0.05  ;.9059094-0.05  ,1-.9059094, 0.05; 0, 1/80, 1-1/80 ];
        T = 150; 
        N = 5000;
        worldstate = NaN(N,T);
        worldstate(:,1) = 2;
        d = rand(size(worldstate,1),T);
        for t = 1:T
           CT = [zeros(size(PandemicTransition,1),1)  cumsum(PandemicTransition(:,:),2)];
            for i= 1: size(worldstate,1)
                [~,~,worldstate(i,t+1)] = histcounts(d(i,t),CT(worldstate(i,t),:));
            end
        end
        worldstate = worldstate-1;
end 
 
%% FUNCTION IX - Setup Model Parameters %%

function [parms] = SetupParameters()

    load('Parameters.mat');
    parms = struct('blim', y(6), 'chi',[y(1) y(1) y(1) y(1)], 'theta_h',[y(2)], 'phi',[y(5)], 'tau',[0.9624	y(3) y(4)], 'beta', [0.96], 'mu',[(0.5+(1-y(5)))/(1-y(5))]);  
    
end

%% FUNCTION X - Solve Stationary Problem %%

function [b, Value_Function, h_choice, i_choice, k_choice, c_choice, grid_parms, initdist] = SolveStationaryProblem(parms, r, wages, Transition)

    %% Algorithm Control
        Convergence_Criterion = 10^-8; % for VF Convergence
        orderpoly = 7; %Degree of polynominal for VF approximation (up to 3 (not recommended))
        n_groups =3;
    %% PARAMETERS
        chi = parms.chi;
        theta_h= parms.theta_h;
        tau = parms.tau;
        phi= parms.phi;
        mu = parms.mu; % CRRA Coefficient
        beta = parms.beta; % Discount Rate

    %% Human Calpital Parameters
        veta_h = [ones(4*n_groups,1)*tau(1);ones(4*n_groups,1)*tau(2);ones(4*n_groups,1)*tau(3)];
        B_h = repmat(repelem(chi,1,n_groups),1,3);
    %% Building Grids for Endogenous Variables
        b_lim = parms.blim;
        nkap = 100;
        kap = (b_lim+(20-b_lim)*linspace(0,1,nkap).^2);
        nh = 25;
        h = (linspace(0.1,(1),nh));            % Health
        indexsize = nh*nkap; % Total Number of Gridpoints
   %% Add Grids together & Vectorize
        kapx = repmat(1:size(kap,2),1, (indexsize/nkap));
        hx = repmat(repelem(1:size(h,2),1,nkap),1);
        
        exog = size(Transition,1); % Number of idiosyncratic productivity states x health states
        grid_parms = struct('nkap', nkap, 'kap', kap, 'nh', nh, 'h',h, 'blim', b_lim);
        initdist = ones(nkap,nh,exog).*(1/(nkap*nh*exog));
        cap = [ones(1,exog)*Inf];

    %% Preallocation
        TV = zeros(indexsize, exog);
   
%% VALUE FUNCTION ITERATION
        
    %% Make Initial Guess for Value Function assuming all income is consumed
        parfor i = 1:indexsize
            Value_Function(i,:) = (([(wages + (1+r)*kap(kapx(i))).^(1-phi).*(h(hx(i))).^phi].^(1-mu)))/(1-mu);
        end
    %% Make Initial Guess for Policy Function assuming all income is consumed
        i_policy = zeros(indexsize,exog);
        k_policy = ones(indexsize,exog)*min(kap);
        h_choice = repmat(h(hx)',1,exog);
        k_choice = k_policy;

        
    %% Get Coefficients for VF Approximation    
       b = interpV(Value_Function,h(hx),kap(kapx),orderpoly);
       
    %% Begin VFI Loop
        vfi_iter = 1; % Initialize Iteration Counter
        vficrit =1;

            while vficrit > Convergence_Criterion

                %% Howards Improvement Loop
                if vfi_iter > 2
                    howard_crit = 1;
                    t = 0;
                    while howard_crit > Convergence_Criterion*10^-2 && t<min(50, round(10*vfi_iter))   

                        %% Perform Howard Step
                        if size(wages,2) ==1
                            parfor i = 1:indexsize
                            EV_how(i,:) = beta*expectedvalue(h_choice(i,1),k_choice(i,1),b,orderpoly);
                            end
                        else
                            parfor i = 1:exog
                                EV_how(:,i) = beta*[sum(Transition(i,:).*expectedvalue(h_choice(:,i)',k_choice(:,i)',b,orderpoly),2)];
                            end
                        end
                        
                        V_how = util + EV_how; 
                        howard_crit = max(max(abs(V_how-Value_Function)));
                        
                        %% Update Value Function
                        Value_Function = V_how;
                        t = t+1;
                    
                        %% Interpolate Value Function    
                    	b = interpV(Value_Function,h(hx),kap(kapx),orderpoly); % Get Coefficients for VF Approximation    
                 
                    end
                else
                 %% Interpolate Value Function   
                 b = interpV(Value_Function,h(hx),kap(kapx),orderpoly); % Get Coefficients for VF Approximation    
                end

                %% Perform VFI with Interpolation
                % Calculate VF + Choices at every Gridpoint
                parfor i = 1:indexsize
                        [BC(i,:),h_choice(i,:),i_choice(i,:),  k_choice(i,:), c_choice(i,:), income(i,:), util(i,:), TV(i,:)] = VFI_Interpolation_Grid( wages, r, b_lim, h(hx(i)), kap(kapx(i)),i_policy(i,:), k_policy(i,:), B_h, veta_h, theta_h, mu, phi, beta, Transition, b, orderpoly,  cap);
                end
                
                vficrit = norm(Value_Function-TV,inf);
                Value_Function = TV;    % Update VF

                i_policy = i_choice; % Update Policy
                k_policy = k_choice; % Update Policy
                
                b = interpV(Value_Function,h(hx),kap(kapx),orderpoly); % Get Coefficients for VF Approximation    
                
                vfi_iter = vfi_iter+1; % increase counter

 
            end

       


end

%% FUNCTION XI - Solve Problem with Aggregate Uncertainty %%

function [b, Value_Function, h_choice, i_choice, k_choice, c_choice] = SolveStationaryProblem_Agg(parms, r, wages, Transition, grid_parms, cap)

    %% Algorithm Control
        Convergence_Criterion = 10^-8; % for VF Convergence
        orderpoly = 7; %Degree of polynominal for VF approximation (up to 3 (not recommended))
        n_groups =3;
    %% PARAMETERS
        chi = parms.chi;
        theta_h= parms.theta_h;
        tau = parms.tau;
        phi= parms.phi;
        mu = parms.mu; % CRRA Coefficient
        beta = parms.beta; % Discount Rate
        
    %% Human Calpital Parameters
        veta_h = repmat([ones(4*n_groups,1)*tau(1);ones(4*n_groups,1)*tau(2);ones(4*n_groups,1)*tau(3)],3,1);
        B_h = repmat(repmat(repelem(chi,1,n_groups),1,3),1,3);
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
        wages = [wages(1,:), wages(2,:), wages(3,:)];
        cap = [ones(1,exog/3)*Inf,ones(1,exog/3)*cap,ones(1,exog/3)*Inf];
      %% Preallocation
        TV = zeros(indexsize, exog);
   
%% VALUE FUNCTION ITERATION
        
    %% Make Initial Guess for Value Function assuming all income is consumed
        parfor i = 1:indexsize
            Value_Function(i,:) = (([(wages + (1+r)*kap(kapx(i))).^(1-phi).*(h(hx(i))).^phi].^(1-mu)))/(1-mu);
        end
    %% Make Initial Guess for Policy Function assuming all income is consumed
        i_policy = zeros(indexsize,exog);
        k_policy = ones(indexsize,exog)*min(kap);
        h_choice = repmat(h(hx)',1,exog);
        k_choice = k_policy;

        
    %% Get Coefficients for VF Approximation    
       b = interpV(Value_Function,h(hx),kap(kapx),orderpoly);
       
    %% Begin VFI Loop
        vfi_iter = 1; % Initialize Iteration Counter
        vficrit =1;

            while vficrit > Convergence_Criterion

                %% Howards Improvement Loop
                if vfi_iter > 2
                    howard_crit = 1;
                    t = 0;
                    while howard_crit > Convergence_Criterion*10^-2 && t<min(50, round(10*vfi_iter))   

                        %% Perform Howard Step
                        if size(wages,2) ==1
                            parfor i = 1:indexsize
                            EV_how(i,:) = beta*expectedvalue(h_choice(i,1),k_choice(i,1),b,orderpoly);
                            end
                        else
                            parfor i = 1:exog
                                EV_how(:,i) = beta*[sum(Transition(i,:).*expectedvalue(h_choice(:,i)',k_choice(:,i)',b,orderpoly),2)];
                            end
                        end
                        
                        V_how = util + EV_how; 
                        howard_crit = max(max(abs(V_how-Value_Function)));
                        
                        %% Update Value Function
                        Value_Function = V_how;
                        t = t+1;
                    
                        %% Interpolate Value Function    
                    	b = interpV(Value_Function,h(hx),kap(kapx),orderpoly); % Get Coefficients for VF Approximation    
                 
                    end
                else
                 %% Interpolate Value Function   
                 b = interpV(Value_Function,h(hx),kap(kapx),orderpoly); % Get Coefficients for VF Approximation    
                end

                %% Perform VFI with Interpolation
                % Calculate VF + Choices at every Gridpoint
                parfor i = 1:indexsize
                        [BC(i,:),h_choice(i,:),i_choice(i,:),  k_choice(i,:), c_choice(i,:), income(i,:), util(i,:), TV(i,:)] = VFI_Interpolation_Grid( wages, r, b_lim, h(hx(i)), kap(kapx(i)),i_policy(i,:), k_policy(i,:), B_h, veta_h, theta_h, mu, phi, beta, Transition, b, orderpoly, cap);
                end
                
                vficrit = norm(Value_Function-TV,inf);
                Value_Function = TV;    % Update VF

                i_policy = i_choice; % Update Policy
                k_policy = k_choice; % Update Policy
                
                b = interpV(Value_Function,h(hx),kap(kapx),orderpoly); % Get Coefficients for VF Approximation    
                
                vfi_iter = vfi_iter+1; % increase counter

 
            end
%%% reshape everything
    b = reshape(b,size(b,1),[],3);
    Value_Function = reshape(Value_Function,size(Value_Function,1),[],3);
    h_choice = reshape(h_choice,size(h_choice,1),[],3);
    i_choice = reshape(i_choice,size(i_choice,1),[],3);
    k_choice = reshape(k_choice,size(k_choice,1),[],3);
    c_choice = reshape(c_choice,size(c_choice,1),[],3);    

end

%% FUNCTION XII - Calculate Summary Statistics %% 

function [Share_Healthstatus, Share_Class, Share_HTM, Health_HTM, Mean_K, Mean_H, Mean_C, Mean_E, Mean_Y, Mean_I, Median_K, Median_H, Median_C, Median_E, Median_I, Var_K, Var_H, Var_C, Var_E, Var_I, GINI_H, GINI_K, GINI_C, GINI_E, GINI_Y, GINI_I, P10_K, P10_H, P10_C, P10_E, P10_I, P20_K, P20_H, P20_C, P20_E, P20_I, P50_K, P50_H, P50_C, P50_E, P50_I, P90_K, P90_H, P90_C, P90_E, P90_I, Mean_H_Class, Mean_K_Class, Mean_C_Class, Mean_E_Class, Mean_Y_Class, Mean_I_Class,Median_H_Class, Median_K_Class, Median_C_Class, Median_E_Class, Median_I_Class,Var_H_Class, Var_K_Class, Var_C_Class, Var_E_Class, Var_I_Class,P10_H_Class, P10_K_Class, P10_C_Class, P10_E_Class, P10_I_Class, P90_H_Class, P90_K_Class, P90_C_Class, P90_E_Class, P90_I_Class,GINI_H_Class, GINI_K_Class, GINI_C_Class, GINI_E_Class, GINI_Y_Class, GINI_I_Class, Quintile_Share, Share_HTM_Class, Wagstaffindex_E, Erregyersindex_E, Wagstaffindex_K, Erregyersindex_K] = SummaryStatistics(OMEGA, h_choice_agg, k_choice_agg, i_choice_agg, c_choice_agg, wages_agg, r, aa, nn,worldstate)

        [T] = size(OMEGA,2);
        worldstate = [3,worldstate];
            h_choice(:,1) = reshape(h_choice_agg(:,:,4),[],1);
            k_choice(:,1) = reshape(k_choice_agg(:,:,4),[],1);
            i_choice(:,1) = reshape(i_choice_agg(:,:,4),[],1);
            c_choice(:,1) = reshape(c_choice_agg(:,:,4),[],1);
            wages(1,:) =  wages_agg(1,:);

        parfor t=2:T
            h_choice(:,t) = reshape(h_choice_agg(:,:,worldstate(t)+1),[],1);
            k_choice(:,t) = reshape(k_choice_agg(:,:,worldstate(t)+1),[],1);
            i_choice(:,t) = reshape(i_choice_agg(:,:,worldstate(t)+1),[],1);
            c_choice(:,t) = reshape(c_choice_agg(:,:,worldstate(t)+1),[],1);
            wages(t,:) =  wages_agg(worldstate(t)+1,:);
        end

        health = (nn>12) + (nn>24) + 1;
        class =       ((nn<4)+  (nn>12 & nn<=15)+(nn>24 & nn<=27))...
                      + 2*((nn>3 & nn<=6)+  (nn>15 & nn<=18)+(nn>27 & nn<=30))...
                      + 3*((nn>6 & nn<=9)+  (nn>18 & nn<=21)+(nn>30 & nn<=33))...
                      + 4*((nn>9 & nn<=12)+ (nn>21 & nn<=24)+(nn>33 & nn<=36));
        Share_Healthstatus = [sum(OMEGA(health ==1,:)); sum(OMEGA(health ==2,:)); sum(OMEGA(health ==3,:))];
        Share_Class = [sum(OMEGA(class ==1,:)); sum(OMEGA(class ==2,:)); sum(OMEGA(class ==3,:)); sum(OMEGA(class ==4,:))];
        
        Mean_H = sum(OMEGA.*h_choice);
        Mean_K = sum(OMEGA.*k_choice);
        Mean_I = sum(OMEGA.*i_choice);
        Mean_C = sum(OMEGA.*c_choice);
        Mean_E = sum(wages(:,nn)'.*OMEGA);
        Mean_Y = sum(wages(:,nn)'.*OMEGA+r.*repmat(aa,1,T).*OMEGA);
                        

        
        parfor t=1:T
             Share_HTM(t) = sum(OMEGA(:,t).*(k_choice(:,t)<10^-6));
             Health_HTM(t) = sum(OMEGA(:,t).*(k_choice(:,t)<10^-6).*h_choice(:,t))./Share_HTM(t);
            [~,~, Erregyersindex_E(t), Wagstaffindex_E(t)] = concentrationindex(h_choice(:,t),wages(t,nn)',OMEGA(:,t),[0.1,1]);
            [~,~, Erregyersindex_K(t), Wagstaffindex_K(t)] = concentrationindex(h_choice(:,t),aa,OMEGA(:,t),[0.1,1]);

             Quintile_Share(:,t) = [sum(OMEGA(:,t).*k_choice(:,t).*(k_choice(:,t)<=wprctile(k_choice(:,t),20,OMEGA(:,t),8)));...
                                   sum(OMEGA(:,t).*k_choice(:,t).*((k_choice(:,t)>wprctile(k_choice(:,t),20,OMEGA(:,t),8))&(k_choice(:,t)<=wprctile(k_choice(:,t),40,OMEGA(:,t),8))));...
                                   sum(OMEGA(:,t).*k_choice(:,t).*((k_choice(:,t)>wprctile(k_choice(:,t),40,OMEGA(:,t),8))&(k_choice(:,t)<=wprctile(k_choice(:,t),60,OMEGA(:,t),8))));...
                                   sum(OMEGA(:,t).*k_choice(:,t).*((k_choice(:,t)>wprctile(k_choice(:,t),60,OMEGA(:,t),8))&(k_choice(:,t)<=wprctile(k_choice(:,t),80,OMEGA(:,t),8))));...
                                   sum(OMEGA(:,t).*k_choice(:,t).*((k_choice(:,t)>wprctile(k_choice(:,t),80,OMEGA(:,t),8))))]/Mean_K(t);
            [~,~,GINI_H(t)] =  gini( h_choice(:,t),OMEGA(:,t));
            [~,~,GINI_K(t)] =  gini( k_choice(:,t), OMEGA(:,t));
            [~,~,GINI_E(t)] = gini( wages(t,nn)',OMEGA(:,t));
            [~,~,GINI_Y(t)] = gini( (r*aa+wages(t,nn)'),OMEGA(:,t));
            [~,~,GINI_C(t)] =  gini( c_choice(:,t),OMEGA(:,t));
            [~,~,GINI_I(t)] =  gini( i_choice(:,t),OMEGA(:,t));
            
            Median_H(t) = wprctile(h_choice(:,t),50,OMEGA(:,t),8);
            Median_K(t) = wprctile(k_choice(:,t),50,OMEGA(:,t),8);
            Median_C(t) = wprctile(c_choice(:,t),50,OMEGA(:,t),8);
            Median_I(t) = wprctile(i_choice(:,t),50,OMEGA(:,t),8);
            Median_E(t) = wprctile(wages(t,nn)',50,OMEGA(:,t),8);
            
            P10_H(t) = sum(OMEGA((h_choice(:,t)<=wprctile(h_choice(:,t),10,OMEGA(:,t),8)),t).*h_choice((h_choice(:,t)<=wprctile(h_choice(:,t),10,OMEGA(:,t),8)),t))/ sum(OMEGA((h_choice(:,t)<=wprctile(h_choice(:,t),10,OMEGA(:,t),8)),t));
            P10_K(t) = sum(OMEGA((k_choice(:,t)<=wprctile(k_choice(:,t),10,OMEGA(:,t),8)),t).*k_choice((k_choice(:,t)<=wprctile(k_choice(:,t),10,OMEGA(:,t),8)),t))/ sum(OMEGA((k_choice(:,t)<=wprctile(k_choice(:,t),10,OMEGA(:,t),8)),t));
            P10_C(t) = sum(OMEGA((c_choice(:,t)<=wprctile(c_choice(:,t),10,OMEGA(:,t),8)),t).*c_choice((c_choice(:,t)<=wprctile(c_choice(:,t),10,OMEGA(:,t),8)),t))/ sum(OMEGA((c_choice(:,t)<=wprctile(c_choice(:,t),10,OMEGA(:,t),8)),t));
            P10_I(t) = sum(OMEGA((i_choice(:,t)<=wprctile(i_choice(:,t),10,OMEGA(:,t),8)),t).*i_choice((i_choice(:,t)<=wprctile(i_choice(:,t),10,OMEGA(:,t),8)),t))/ sum(OMEGA((i_choice(:,t)<=wprctile(i_choice(:,t),10,OMEGA(:,t),8)),t));
            P10_E(t) = sum(OMEGA(:,t).*(wages(t,nn)'<=wprctile(wages(t,nn)',10,OMEGA(:,t),8)).*wages(t,nn)')/ sum(OMEGA((wages(t,nn)'<=wprctile(wages(t,nn)',10,OMEGA(:,t),8)),t));

            P20_H(t) = sum(OMEGA((h_choice(:,t)<=wprctile(h_choice(:,t),20,OMEGA(:,t),8)),t).*h_choice((h_choice(:,t)<=wprctile(h_choice(:,t),20,OMEGA(:,t),8)),t))/ sum(OMEGA((h_choice(:,t)<=wprctile(h_choice(:,t),20,OMEGA(:,t),8)),t));
            P20_K(t) = sum(OMEGA((k_choice(:,t)<=wprctile(k_choice(:,t),20,OMEGA(:,t),8)),t).*k_choice((k_choice(:,t)<=wprctile(k_choice(:,t),20,OMEGA(:,t),8)),t))/ sum(OMEGA((k_choice(:,t)<=wprctile(k_choice(:,t),20,OMEGA(:,t),8)),t));
            P20_C(t) = sum(OMEGA((c_choice(:,t)<=wprctile(c_choice(:,t),20,OMEGA(:,t),8)),t).*c_choice((c_choice(:,t)<=wprctile(c_choice(:,t),20,OMEGA(:,t),8)),t))/ sum(OMEGA((c_choice(:,t)<=wprctile(c_choice(:,t),20,OMEGA(:,t),8)),t));
            P20_I(t) = sum(OMEGA((i_choice(:,t)<=wprctile(i_choice(:,t),20,OMEGA(:,t),8)),t).*i_choice((i_choice(:,t)<=wprctile(i_choice(:,t),20,OMEGA(:,t),8)),t))/ sum(OMEGA((i_choice(:,t)<=wprctile(i_choice(:,t),20,OMEGA(:,t),8)),t));
            P20_E(t) = sum(OMEGA(:,t).*(wages(t,nn)'<=wprctile(wages(t,nn)',20,OMEGA(:,t),8)).*wages(t,nn)')/ sum(OMEGA((wages(t,nn)'<=wprctile(wages(t,nn)',20,OMEGA(:,t),8)),t));

            P50_H(t) = sum(OMEGA((h_choice(:,t)<=wprctile(h_choice(:,t),50,OMEGA(:,t),8)),t).*h_choice((h_choice(:,t)<=wprctile(h_choice(:,t),50,OMEGA(:,t),8)),t))/ sum(OMEGA((h_choice(:,t)<=wprctile(h_choice(:,t),50,OMEGA(:,t),8)),t));
            P50_K(t) = sum(OMEGA((k_choice(:,t)<=wprctile(k_choice(:,t),50,OMEGA(:,t),8)),t).*k_choice((k_choice(:,t)<=wprctile(k_choice(:,t),50,OMEGA(:,t),8)),t))/ sum(OMEGA((k_choice(:,t)<=wprctile(k_choice(:,t),50,OMEGA(:,t),8)),t));
            P50_C(t) = sum(OMEGA((c_choice(:,t)<=wprctile(c_choice(:,t),50,OMEGA(:,t),8)),t).*c_choice((c_choice(:,t)<=wprctile(c_choice(:,t),50,OMEGA(:,t),8)),t))/ sum(OMEGA((c_choice(:,t)<=wprctile(c_choice(:,t),50,OMEGA(:,t),8)),t));
            P50_I(t) = sum(OMEGA((i_choice(:,t)<=wprctile(i_choice(:,t),50,OMEGA(:,t),8)),t).*i_choice((i_choice(:,t)<=wprctile(i_choice(:,t),50,OMEGA(:,t),8)),t))/ sum(OMEGA((i_choice(:,t)<=wprctile(i_choice(:,t),50,OMEGA(:,t),8)),t));
            P50_E(t) = sum(OMEGA(:,t).*(wages(t,nn)'<=wprctile(wages(t,nn)',50,OMEGA(:,t),8)).*wages(t,nn)')/ sum(OMEGA((wages(t,nn)'<=wprctile(wages(t,nn)',50,OMEGA(:,t),8)),t));
            
            
            P90_H(t) = sum(OMEGA((h_choice(:,t)>wprctile(h_choice(:,t),90,OMEGA(:,t),8)),t).*h_choice((h_choice(:,t)>wprctile(h_choice(:,t),90,OMEGA(:,t),8)),t))/ sum(OMEGA((h_choice(:,t)>wprctile(h_choice(:,t),90,OMEGA(:,t),8)),t));
            P90_K(t) = sum(OMEGA((k_choice(:,t)>wprctile(k_choice(:,t),90,OMEGA(:,t),8)),t).*k_choice((k_choice(:,t)>wprctile(k_choice(:,t),90,OMEGA(:,t),8)),t))/ sum(OMEGA((k_choice(:,t)>wprctile(k_choice(:,t),90,OMEGA(:,t),8)),t));
            P90_C(t) = sum(OMEGA((c_choice(:,t)>wprctile(c_choice(:,t),90,OMEGA(:,t),8)),t).*c_choice((c_choice(:,t)>wprctile(c_choice(:,t),90,OMEGA(:,t),8)),t))/ sum(OMEGA((c_choice(:,t)>wprctile(c_choice(:,t),90,OMEGA(:,t),8)),t));
            P90_I(t) = sum(OMEGA((i_choice(:,t)>wprctile(i_choice(:,t),90,OMEGA(:,t),8)),t).*i_choice((i_choice(:,t)>wprctile(i_choice(:,t),90,OMEGA(:,t),8)),t))/ sum(OMEGA((i_choice(:,t)>wprctile(i_choice(:,t),90,OMEGA(:,t),8)),t));
            P90_E(t) = sum(OMEGA(:,t).*(wages(t,nn)'>wprctile(wages(t,nn)',90,OMEGA(:,t),8)).*wages(t,nn)')/ sum(OMEGA((wages(t,nn)'>wprctile(wages(t,nn)',90,OMEGA(:,t),8)),t));

            
            Var_H(t) = var(h_choice(:,t),OMEGA(:,t));
            Var_K(t) = var(k_choice(:,t),OMEGA(:,t));
            Var_C(t) = var(c_choice(:,t),OMEGA(:,t));
            Var_I(t) = var(i_choice(:,t),OMEGA(:,t));
            Var_E(t) = var(wages(t,nn)',OMEGA(:,t));
            
            for n = 1:4
                
                Share_HTM_Class(n,t) = sum(OMEGA(class==n,t).*(k_choice(class==n,t)<10^-6))/ sum(OMEGA(class==n,t));

                Mean_H_Class(n,t) = h_choice(class==n,t)'*OMEGA(class==n,t)/sum(OMEGA(class==n,t));
                Mean_K_Class(n,t) = k_choice(class==n,t)'*OMEGA(class==n,t)/sum(OMEGA(class==n,t));
                Mean_C_Class(n,t) = c_choice(class==n,t)'*OMEGA(class==n,t)/sum(OMEGA(class==n,t));
                Mean_I_Class(n,t) = i_choice(class==n,t)'*OMEGA(class==n,t)/sum(OMEGA(class==n,t));
                Mean_E_Class(n,t) = wages(t,nn(class==n))*OMEGA((class==n),t)/sum(OMEGA(:,t).*(class==n));
                Mean_Y_Class(n,t) = wages(t,nn(class==n))*OMEGA((class==n),t)/sum(OMEGA(:,t).*(class==n)) + r*aa(class==n)'*OMEGA((class==n),t)/sum(OMEGA(:,t).*(class==n));
                
                Median_H_Class(n,t) = wprctile(h_choice(class==n,t),50, OMEGA(class==n,t),8);
                Median_K_Class(n,t) = wprctile(k_choice(class==n,t),50, OMEGA(class==n,t),8);
                Median_C_Class(n,t) = wprctile(c_choice(class==n,t),50, OMEGA(class==n,t),8);
                Median_I_Class(n,t) = wprctile(i_choice(class==n,t),50, OMEGA(class==n,t),8);
                Median_E_Class(n,t) = wprctile(wages(t,nn(class==n))',50, OMEGA(class==n,t),8);

                P10_H_Class(n,t) = wprctile(h_choice(class==n,t),10, OMEGA(class==n,t),8);
                P10_K_Class(n,t) = wprctile(k_choice(class==n,t),10, OMEGA(class==n,t),8);
                P10_C_Class(n,t) = wprctile(c_choice(class==n,t),10, OMEGA(class==n,t),8);
                P10_I_Class(n,t) = wprctile(i_choice(class==n,t),10, OMEGA(class==n,t),8);
                P10_E_Class(n,t) = wprctile(wages(t,nn(class==n))',10, OMEGA(class==n,t),8);

                P90_H_Class(n,t) = wprctile(h_choice(class==n,t),90, OMEGA(class==n,t),8);
                P90_K_Class(n,t) = wprctile(k_choice(class==n,t),90, OMEGA(class==n,t),8);
                P90_C_Class(n,t) = wprctile(c_choice(class==n,t),90, OMEGA(class==n,t),8);
                P90_I_Class(n,t) = wprctile(i_choice(class==n,t),90, OMEGA(class==n,t),8);
                P90_E_Class(n,t) = wprctile(wages(t,nn(class==n))',90, OMEGA(class==n,t),8);
                
                Var_H_Class(n,t) = var(h_choice(class==n,t),OMEGA(class==n,t));
                Var_K_Class(n,t) = var(k_choice(class==n,t),OMEGA(class==n,t));
                Var_C_Class(n,t) = var(c_choice(class==n,t),OMEGA(class==n,t));
                Var_I_Class(n,t) = var(i_choice(class==n,t),OMEGA(class==n,t));
                Var_E_Class(n,t) = var(wages(t,nn(class==n))',OMEGA(class==n,t));
                
                [~,~,GINI_H_Class(n,t)] = gini( h_choice(class==n,t),OMEGA((class==n),t));
                [~,~,GINI_K_Class(n,t)] = gini(  k_choice(class==n,t),OMEGA((class==n),t));
                [~,~,GINI_C_Class(n,t)] = gini( c_choice(class==n,t),OMEGA((class==n),t));
                [~,~,GINI_I_Class(n,t)] = gini( i_choice(class==n,t),OMEGA((class==n),t));
                [~,~,GINI_E_Class(n,t)] = gini( wages(t,nn(class==n))',OMEGA((class==n),t));
                [~,~,GINI_Y_Class(n,t)] = gini((r*aa(class==n)+wages(t,nn(class==n))'),OMEGA((class==n),t));
            end
        end

end

%% FUNCTION XIII - Solve the HH Problem %%
    
function [BC,h_choice,i_choice, k_choice, c_choice, y, util, TV] = VFI_Interpolation_Grid(wage, r, blim, h_t, k_t,i_tt, k_tt, B_h, veta_h, theta_h,  mu, phi, beta, Transition,  b, orderpoly, cap);
    %% Calculate availabe resources
    if k_t<0
        r=2*r; % set interest higher for those in debt
    end
        y = wage+(1+r)*k_t;

    %% For each productivity State find optimal choices and the value of the VF        
        options = optimoptions(@fmincon,'Display','off','OptimalityTolerance', 1e-06, 'StepTolerance', 1e-6','SpecifyObjectiveGradient',false, 'DerivativeCheck', 'off','Algorithm','sqp');
            parfor n = 1:size(wage,2)
                [z(:,n),fval(n)] = fmincon(@(x)bellman(x(1),x(2),x(3),h_t,veta_h(n), b,orderpoly,Transition(n,:),theta_h,B_h(n),beta,mu,phi), [i_tt(n),k_tt(n), min(cap(n),y(n)-i_tt(n)-k_tt(n))]',[1,1,1],y(n),[],[],[0,blim,0]',[min(y(n)-blim,((1-veta_h(n)*h_t)/B_h(n))^(1/theta_h)),y(n)-blim,min(cap(n),y(n)-blim)]',[], options);
            end
    %% Collect Choices & VF        
    h_choice = h_t'.*veta_h+B_h'.*z(1,:)'.^theta_h;   
    k_choice = z(2,:)';
    c_choice = z(3,:)';
    i_choice = z(1,:)';
    util = ((((c_choice.^(1-phi)).*((h_choice).^phi)).^(1-mu)))./(1-mu);
    TV = -fval;
    BC = y' - i_choice - c_choice - k_choice;
    
end

%% FUNCTION XIV - Calculate Percentiles %%

function y = wprctile(X,p,varargin)
%WPRCTILE  Returns weighted percentiles of a sample with six algorithms.
% The idea is to give more emphasis in some examples of data as compared to
% others by giving more weight. For example, we could give lower weights to
% the outliers. The motivation to write this function is to compute percentiles
% for Monte Carlo simulations where some simulations are very bad (in terms of
% goodness of fit between simulated and actual value) than the others and to 
% give the lower weights based on some goodness of fit criteria.
%
% USAGE:
%         y = WPRCTILE(X,p)
%         y = WPRCTILE(X,p,w)
%         y = WPRCTILE(X,p,w,type)
%                                             
% INPUT:
%    X -  vector or matrix of the sample data                                 
%    p -  scalar  or a vector of percent values between 0 and 100
%
%    w -  positive weight vector for the sample data. Length of w must be
%         equal to either number of rows or columns of X. If X is matrix, same
%         weight vector w is used for all columns (DIM=1)or for all rows
%         (DIM=2). If the weights are equal, then WPRCTILE is same as PRCTILE.
%
%  type - an integer between 4 and 9 selecting one of the 6 quantile algorithms. 
%         Type 4: p(k) = k/n. That is, linear interpolation of the empirical cdf. 
%         Type 5: p(k) = (k-0.5)/n. That is a piecewise linear function where
%                 the knots are the values midway through the steps of the 
%                 empirical cdf. This is popular amongst hydrologists. (default)
%                 PRCTILE also uses this formula.
%         Type 6: p(k) = k/(n+1). Thus p(k) = E[F(x[k])]. 
%                 This is used by Minitab and by SPSS. 
%         Type 7: p(k) = (k-1)/(n-1). In this case, p(k) = mode[F(x[k])]. 
%                 This is used by S. 
%         Type 8: p(k) = (k-1/3)/(n+1/3). Then p(k) =~ median[F(x[k])]. 
%                 The resulting quantile estimates are approximately 
%                 median-unbiased regardless of the distribution of x. 
%         Type 9: p(k) = (k-3/8)/(n+1/4). The resulting quantile estimates are 
%                 approximately unbiased for the expected order statistics 
%                 if x is normally distributed.
%         
%         Interpolating between the points pk and X(k) gives the sample
%         quantile. Here pk is plotting position and X(k) is order statistics of
%         x such that x(k)< x(k+1) < x(k+2)...
%                  
% OUTPUT:
%    y - percentiles of the values in X
%        When X is a vector, y is the same size as p, and y(i) contains the
%        P(i)-th percentile.
%        When X is a matrix, WPRCTILE calculates percentiles along dimension DIM
%        which is based on: if size(X,1) == length(w), DIM = 1;
%                       elseif size(X,2) == length(w), DIM = 2;
%                      
% EXAMPLES:
%    w = rand(1000,1);
%    y = wprctile(x,[2.5 25 50 75 97.5],w,5);
%    % here if the size of x is 1000-by-50, then y will be size of 6-by-50
%    % if x is 50-by-1000, then y will be of the size of 50-by-6
% 
% Please note that this version of WPRCTILE will not work with NaNs values and
% planned to update in near future to handle NaNs values as missing values.
%
% References: Rob J. Hyndman and Yanan Fan, 1996, Sample Quantiles in Statistical
%             Package, The American Statistician, 50, 4. 
%
% HISTORY:
% version 1.0.0, Release 2007/10/16: Initial release
% version 1.1.0, Release 2008/04/02: Implementation of other 5 algorithms and
%                                    other minor improvements of code
%
%
% I appreciate the bug reports and suggestions.
% See also: PRCTILE (Statistical Toolbox)

% Author: Durga Lal Shrestha
% UNESCO-IHE Institute for Water Education, Delft, The Netherlands
% eMail: durgals@hotmail.com
% Website: http://www.hi.ihe.nl/durgalal/index.htm
% Copyright 2004-2007 Durga Lal Shrestha.
% $First created: 16-Oct-2007
% $Revision: 1.1.0 $ $Date: 02-Apr-2008 13:40:29 $

% ***********************************************************************

%% Input arguments check

error(nargchk(2,4,nargin))
if ~isvector(p) || numel(p) == 0
    error('wprctile:BadPercents', ...
          'P must be a scalar or a non-empty vector.');
elseif any(p < 0 | p > 100) || ~isreal(p)
    error('wprctile:BadPercents', ...
          'P must take real values between 0 and 100');
end
if ndims(X)>2
   error('wprctile:InvalidNumberofDimensions','X Must be 2D.')
end


% Default weight vector
if isvector(X)
	w = ones(length(X),1);         
else
	w = ones(size(X,1),1);   % works as dimension 1
end
type = 5; 

if nargin > 2
	if ~isempty(varargin{1})
		w = varargin{1};          % weight vector
	end
	if  nargin >3
		type = varargin{2};   % type to compute quantile
	end
end

if ~isvector(w)|| any(w<0) 
	error('wprctile:InvalidWeight', ...
          'w must vecor and values should be greater than 0');
end

% Check if there are NaN in any of the input
nans = isnan(X);
if any(nans(:)) || any(isnan(p))|| any(isnan(w))
	error('wprctile:NaNsInput',['This version of WPRCTILE will not work with ' ...
	      'NaNs values in any input and planned to update in near future to ' ...
		   'handle NaNs values as missing values.']);
end
%% Figure out which dimension WPRCTILE will work along using weight vector w

n = length(w);
[nrows ncols] = size(X);
if nrows==n
	dim = 1;
elseif ncols==n
	dim = 2;
else
	error('wprctile:InvalidDimension', ...
          'length of w must be equal to either number of rows or columns of X');
end

%% Work along DIM = 1 i.e. columswise, convert back later if needed using tflag

tflag = false; % flag to note transpose
if dim==2     
   X = X';
   tflag = true;  
end
ncols = size(X,2);
np = length(p);
y = zeros(np,ncols);

% Change w to column vector
w = w(:);

% normalise weight vector such that sum of the weight vector equals to n
w = w*n/sum(w);

%% Work on each column separately because of weight vector

for i=1:ncols
	[sortedX ind] = sort(X(:,i));  % sort the data
	sortedW = w(ind);              % rearrange the weight according to ind
	k = cumsum(sortedW);           % cumulative weight
	switch type                    % different algorithm to compute percentile
		case 4
			pk = k/n;
		case 5
			pk = (k-sortedW/2)/n;
		case 6
			pk = k/(n+1);
		case 7
			pk = (k-sortedW)/(n-1);
		case 8
			pk = (k-sortedW/3)/(n+1/3);
		case 9
			pk = (k-sortedW*3/8)/(n+1/4);
		otherwise
			error('wprctile:InvalidType', ...
				'Integer to select one of the six quantile algorithm should be between 4 to 9.')
	end
	
	% to avoid NaN for outside the range, the minimum or maximum values in X are
	% assigned to percentiles for percent values outside that range.
	q = [0;pk;1];
	xx = [sortedX(1); sortedX; sortedX(end)];
	
	% Interpolation between q and xx for given value of p
	y(:,i) = interp1q(q,xx,p(:)./100);
end

%% Transpose data back for DIM = 2 to the orginal dimension of X
% if p is row vector and X is vector then return y as row vector 
if tflag || (min(size(X))==1 && size(p,1)==1)    
	y=y';
end
end

%% FUNCTION XV - Calcualate Concentration Indices %%  
    
function [CI, GCI, E, W] = concentrationindex(h,x,w,lim)
    %% This function calculates a number of concentration indices, based on Erregyers (2009) & Wagstaff et al. (1997)
    %% h is a bounded continuous indicator of health
    %% lim are the bounds of h
    %% x is a socioeconomic indicator variable that is used to rank the observations
    %% w are weights
    %% Keep only "existing" observations i.e. those with nonzero mass
    h = h(w>0);
    x = x(w>0);
    w = w(w>0);
    %% aggregate across xx using weighted mean of h within each cell of xx
    xx = unique(x);
    parfor i=1:size(xx,1)
        hh(i,1)=(h(xx(i)==x))'*w(xx(i)==x)/sum(w(xx(i)==x));
        ww(i,1) = sum(w(xx(i)==x));
    end
    %% calculate fractional Rank
    frank(1) = 0.5*ww(1,1);
    for i = 2:size(xx,1)
        frank(i,1) = sum(ww(1:i-1)) + 0.5*ww(i);
    end
%% compute concentraion indeces
    m=hh'*ww;
    n = size(xx,1);
    %% Concentration Index
    CI =  2*sum(ww.*hh.*frank)/m-1;
    %% Generalized Concentration Index
    GCI =  CI*m;
    %% Erregyes Index
    E = 4/(lim(2)-lim(1))*GCI;
    %% Wagstaff Index
    W = (lim(2)-lim(1))/((lim(2)-m)*(m-lim(1)))*GCI;
    
end



  

