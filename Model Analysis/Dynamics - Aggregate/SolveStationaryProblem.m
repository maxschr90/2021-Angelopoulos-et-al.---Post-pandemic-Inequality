%% Solve Stationary Problem %%

function [b, Value_Function, h_choice, i_choice, k_choice, c_choice, grid_parms, initdist] = SolveStationaryProblem(parms, r, wages, Transition)

    %% Algorithm Control
        Convergence_Criterion = 10^-8; % for VF Convergence
        orderpoly = 7; % Degree of polynominal for VF approximation
        n_groups = 3;
    %% PARAMETERS
        chi = parms.chi;
        theta_h= parms.theta_h;
        tau = parms.tau;
        phi= parms.phi;
        mu = parms.mu; % CRRA Coefficient
        beta = parms.beta; % Discount Rate

    %% HealthParameters
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
        cap = [ones(1,exog)*Inf]; % set consumption limit to never bind

    %% Preallocation
        TV = zeros(indexsize, exog);
   
%% VALUE FUNCTION ITERATION
        
    %% Make Initial Guess for Value Function assuming all income is consumed
        parfor i = 1:indexsize
            Value_Function(i,:) = (([(wages + (1+r).*kap(kapx(i))).^(1-phi).*(h(hx(i))).^phi].^(1-mu)))/(1-mu);
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
                        [BC(i,:),h_choice(i,:),i_choice(i,:),  k_choice(i,:), c_choice(i,:), income(i,:), util(i,:), TV(i,:)] = VFI_Interpolation_Grid( wages, r, b_lim, h(hx(i)), kap(kapx(i)),i_policy(i,:), k_policy(i,:), B_h, veta_h, theta_h, mu, phi, beta, Transition, b, orderpoly,  cap, 0.01);
                end
                
                vficrit = norm(Value_Function-TV,inf);
                Value_Function = TV;    % Update VF

                i_policy = i_choice; % Update Policy
                k_policy = k_choice; % Update Policy
                
                b = interpV(Value_Function,h(hx),kap(kapx),orderpoly); % Get Coefficients for VF Approximation    
                
                vfi_iter = vfi_iter+1; % increase counter

 
            end  
end