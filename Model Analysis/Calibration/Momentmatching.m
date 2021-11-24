%% This function solves the HH problem, simulates the stationary distribution and calculates
%% the deviation of the moments from their targets. Its output is the sum of squared errors which
%% is passed to the outer loop to perform the calibration.

function [Error] = Momentmatching(x)

%% Algorithm Control
        Convergence_Criterion = 10^-8; % for VF Convergence
        orderpoly = 7; % degree of polynominal for VF approximation

%% READ OUT PARAMETERS
        chi = [x(1), x(1), x(1), x(1)]; % the linear term in the health production function is the same across all socioeconomic groups
        theta_h = x(2); 
        tau(1) = 0.9624; % depreciation rate for healthy is standardised
        tau(2) = x(3);
        tau(3) = x(4);
    	phi = x(5); % share of health in utility (note in the paper this is eferred to as 1-phi)

   %% Standard Utility Parameters
        mu = (0.5+(1-phi))/(1-phi); % CRRA Coefficient
        beta =0.96; % Discount Rate

   %% Health Parameters
        n_groups = 3; % # of groups within each class
        B_h = repmat(repelem([chi],1,n_groups),1,3);

   %% Prices
        r = 0.0056; % Risk Free Interest Rate
    
   %% Building Grids for Endogenous Variables
        % Assets
        b_lim = x(6); % borrowing limit
        nkap = 100;
        kap = (b_lim+(20-b_lim)*linspace(0,1,nkap).^2);
        % Health
        nh = 25;
        h = (linspace(0.1,(1),nh));            
        indexsize = nh*nkap; % Total Number of Gridpoints
	    grid_parms = struct('nkap', nkap, 'kap', kap, 'nh', nh, 'h',h, 'blim', b_lim);

%% Exogenous Processes
        %% Employment States & Productivities
            Transition_Pre =[0.711503348000000,0.161290323000000,0.0438222760000000,0.0511259890000000,0.0133901400000000,0.0112598900000000,0.00213025000000000,0.000912964000000000,0.000912964000000000,0.00182592800000000,0.000608643000000000,0.00121728500000000;0.136965152000000,0.626819585000000,0.140273489000000,0.0500661670000000,0.0213939130000000,0.0119100130000000,0.00286722500000000,0.00154389100000000,0.00176444600000000,0.000882223000000000,0.000441112000000000,0.00507278300000000;0.0464423940000000,0.199464126000000,0.642453111000000,0.0133968440000000,0.0479309320000000,0.0288776420000000,0.00357249200000000,0.00357249200000000,0.00654956800000000,0.00119083100000000,0.00119083100000000,0.00535873800000000;0.0193726940000000,0.0277905900000000,0.00449723200000000,0.686692804000000,0.185078413000000,0.0525830260000000,0.00853321000000000,0.00438191900000000,0.00484317300000000,0.00196033200000000,0.00115313700000000,0.00311346900000000;0.00448082700000000,0.0110297290000000,0.0133563120000000,0.139250323000000,0.624558380000000,0.164325722000000,0.0121499350000000,0.0105988800000000,0.00801378700000000,0.00292977200000000,0.00318828100000000,0.00611805300000000;0.00338327700000000,0.00555824100000000,0.0144997580000000,0.0561865640000000,0.230425326000000,0.626993717000000,0.00579990300000000,0.0158289030000000,0.0180038670000000,0.00410826500000000,0.00628322900000000,0.0129289510000000;0.00305470700000000,0.00388780900000000,0.00444321000000000,0.0319355730000000,0.0458206050000000,0.0172174400000000,0.627325743000000,0.189947237000000,0.0455429050000000,0.00916412100000000,0.0113857260000000,0.0102749240000000;0.000209424000000000,0.00230366500000000,0.00397905800000000,0.00900523600000000,0.0351832460000000,0.0387434550000000,0.149319372000000,0.536544503000000,0.184502618000000,0.00879581200000000,0.0140314140000000,0.0173821990000000;0.000611247000000000,0.00275061100000000,0.00672371600000000,0.0122249390000000,0.0284229830000000,0.0595965770000000,0.0547066010000000,0.253361858000000,0.526894866000000,0.00611246900000000,0.0177261610000000,0.0308679710000000;0,0.00199700400000000,0.00199700400000000,0.00349475800000000,0.0239640540000000,0.0284573140000000,0.0179730400000000,0.0329505740000000,0.0119820270000000,0.561158263000000,0.250124813000000,0.0659011480000000;0.000333111000000000,0.000666223000000000,0.00133244500000000,0.00433044600000000,0.0143237840000000,0.0363091270000000,0.0139906730000000,0.0556295800000000,0.0379746840000000,0.167221852000000,0.500333111000000,0.167554963000000;0.00140252500000000,0.00374006500000000,0.00935016400000000,0.00841514700000000,0.0275829830000000,0.0645161290000000,0.0168302950000000,0.0500233750000000,0.0677886860000000,0.0677886860000000,0.240299205000000,0.442262740000000];
            Transition_Post  =[0.705555556000000,0.116666667000000,0.0611111110000000,0.0722222220000000,0.00555555600000000,0.0222222220000000,0.00555555600000000,0,0,0.0111111110000000,0,0;0.116731518000000,0.653696498000000,0.136186770000000,0.0466926070000000,0.0272373540000000,0.0116731520000000,0,0.00389105100000000,0.00389105100000000,0,0,0;0.0600000000000000,0.206666667000000,0.653333333000000,0.00666666700000000,0.0266666670000000,0.0200000000000000,0,0.00666666700000000,0.00666666700000000,0.00666666700000000,0,0.00666666700000000;0.0176678450000000,0.0176678450000000,0.00176678400000000,0.734982332000000,0.150176678000000,0.0530035340000000,0.00883392200000000,0,0.00353356900000000,0.00176678400000000,0.00530035300000000,0.00530035300000000;0.00870827300000000,0.00870827300000000,0.0101596520000000,0.126269956000000,0.648766328000000,0.142235123000000,0.0145137880000000,0.00725689400000000,0.0145137880000000,0.00435413600000000,0.00580551500000000,0.00870827300000000;0,0.00635593200000000,0.0127118640000000,0.0508474580000000,0.207627119000000,0.625000000000000,0.00635593200000000,0.0190677970000000,0.0254237290000000,0.0127118640000000,0.0148305080000000,0.0190677970000000;0,0,0,0.0218340610000000,0.0436681220000000,0.0262008730000000,0.624454148000000,0.183406114000000,0.0393013100000000,0.0349344980000000,0.0131004370000000,0.0131004370000000;0,0,0.00692041500000000,0,0.0346020760000000,0.0207612460000000,0.179930796000000,0.498269896000000,0.200692042000000,0.0138408300000000,0.0207612460000000,0.0242214530000000;0,0,0,0.0109489050000000,0.0218978100000000,0.0620437960000000,0.0583941610000000,0.164233577000000,0.616788321000000,0.00364963500000000,0.0328467150000000,0.0291970800000000;0,0.00194174800000000,0,0,0.00194174800000000,0.00776699000000000,0.0135922330000000,0.00776699000000000,0.00776699000000000,0.700970874000000,0.231067961000000,0.0271844660000000;0,0.00202839800000000,0,0,0.0121703850000000,0.0121703850000000,0,0.0162271810000000,0.0121703850000000,0.269776876000000,0.503042596000000,0.172413793000000;0,0,0.00349650300000000,0,0,0.0209790210000000,0.0139860140000000,0.0244755240000000,0.0314685310000000,0.101398601000000,0.293706294000000,0.510489510000000];
 	        wages_Normal =repmat([2.25153923300000;1.45145218300000;0.902928998000000;1.63457864600000;1.00168807100000;0.588697138000000;1.08790704100000;0.702977449000000;0.444859442000000;0.755734786000000;0.469591037000000;0.251809510000000],3,1);   % idiosyncratic productivity states            
            wages = (wages_Normal')/[1.03953360209967]; % standardising ensures that mean earnings are 1 in steady state
        
     
        %% Health Shocks
            ShockProb =  repelem([0.0101503400000000,0.00924064300000000,0.0115799800000000,0.0248253310000000],1,n_groups)';
            RecoveryProb = [0.0895];
            Health_Trans = [repmat(1-ShockProb,1,4*n_groups),repmat(ShockProb,1,4*n_groups), zeros(4*n_groups);...
                                   zeros(4*n_groups), zeros(4*n_groups), ones(4*n_groups);...
                               ones(4*n_groups)*RecoveryProb,      zeros(4*n_groups), 1-ones(4*n_groups)*RecoveryProb];
                           
            veta_h = [ones(size(Transition_Pre,1),1)*tau(1);ones(size(Transition_Pre,1),1)*tau(2);ones(size(Transition_Pre,1),1)*tau(3)];

        %% Expand Full Transition Matrix
            Transition_combined = repmat([Transition_Pre, Transition_Post,Transition_Post],3,1);
            Transition = [Transition_combined.*Health_Trans];
            exog = size(Transition,1); % Number of idiosyncratic productivity states x health states
            Transition_Pre = [];
            Transition_Post =[];

   %% Add Grids together & Vectorize
        kapx = repmat(1:size(kap,2),1, (indexsize/nkap));
        hx = repmat(repelem(1:size(h,2),1,nkap),1);

   %% Preallocation
        TV = zeros(indexsize, exog);     
      
%% VALUE FUNCTION ITERATION
        
    %% Make Initial Guess for Value Function assuming all income is consumed
        parfor i = 1:indexsize
            Value_Function(i,:) = (([((wages + (1+r)*kap(kapx(i))).^(1-phi)).*(h(hx(i))).^phi].^(1-mu)))/(1-mu);
        end
    %% Make Initial Guess for Policy Function assuming all income is consumed
        i_policy = zeros(indexsize,exog);
        k_policy = ones(indexsize,exog)*min(kap);
        h_choice = repmat(h(hx)',1,exog);
        k_choice = k_policy;

        
    %% Get Coefficients for VF Approximation    
       b = interpV(Value_Function,h(hx),kap(kapx),orderpoly);
       b_store = b;
       
    %% Begin VFI Loop
        vficrit = 1; % Initial Convergence Criterion
        vfi_iter = 1; % Initialize Iteration Counter
       
            while vficrit > Convergence_Criterion

                %% Howards Improvement Loop
                if vfi_iter > 2
                    howard_crit = 1;
                    t = 0;
                    while howard_crit > Convergence_Criterion*10^-2 && t<min(50, round(10*vfi_iter))   

                        parfor i = 1:indexsize
                                EV_how(i,:) = beta*[sum(Transition(1,:).*expectedvalue(h_choice(i,1),k_choice(i,1),b,orderpoly),2)      sum(Transition(2,:).*expectedvalue(h_choice(i,2),k_choice(i,2),b,orderpoly),2)      sum(Transition(3,:).*expectedvalue(h_choice(i,3),k_choice(i,3),b,orderpoly),2)      sum(Transition(4,:).*expectedvalue(h_choice(i,4),k_choice(i,4),b,orderpoly),2)      sum(Transition(5,:).*expectedvalue(h_choice(i,5),k_choice(i,5),b,orderpoly),2)      ...
                                                    sum(Transition(6,:).*expectedvalue(h_choice(i,6),k_choice(i,6),b,orderpoly),2)      sum(Transition(7,:).*expectedvalue(h_choice(i,7),k_choice(i,7),b,orderpoly),2)      sum(Transition(8,:).*expectedvalue(h_choice(i,8),k_choice(i,8),b,orderpoly),2)      sum(Transition(9,:).*expectedvalue(h_choice(i,9),k_choice(i,9),b,orderpoly),2)      sum(Transition(10,:).*expectedvalue(h_choice(i,10),k_choice(i,10),b,orderpoly),2)   ...
                                                    sum(Transition(11,:).*expectedvalue(h_choice(i,11),k_choice(i,11),b,orderpoly),2)   sum(Transition(12,:).*expectedvalue(h_choice(i,12),k_choice(i,12),b,orderpoly),2)   sum(Transition(13,:).*expectedvalue(h_choice(i,13),k_choice(i,13),b,orderpoly),2)   sum(Transition(14,:).*expectedvalue(h_choice(i,14),k_choice(i,14),b,orderpoly),2)   sum(Transition(15,:).*expectedvalue(h_choice(i,15),k_choice(i,15),b,orderpoly),2)   ... 
                                                    sum(Transition(16,:).*expectedvalue(h_choice(i,16),k_choice(i,16),b,orderpoly),2)   sum(Transition(17,:).*expectedvalue(h_choice(i,17),k_choice(i,17),b,orderpoly),2)   sum(Transition(18,:).*expectedvalue(h_choice(i,18),k_choice(i,18),b,orderpoly),2)   sum(Transition(19,:).*expectedvalue(h_choice(i,19),k_choice(i,19),b,orderpoly),2)   sum(Transition(20,:).*expectedvalue(h_choice(i,20),k_choice(i,20),b,orderpoly),2)   ... 
                                                    sum(Transition(21,:).*expectedvalue(h_choice(i,21),k_choice(i,21),b,orderpoly),2)   sum(Transition(22,:).*expectedvalue(h_choice(i,22),k_choice(i,22),b,orderpoly),2)   sum(Transition(23,:).*expectedvalue(h_choice(i,23),k_choice(i,23),b,orderpoly),2)   sum(Transition(24,:).*expectedvalue(h_choice(i,24),k_choice(i,24),b,orderpoly),2)   sum(Transition(25,:).*expectedvalue(h_choice(i,25),k_choice(i,25),b,orderpoly),2)   ...
                                                    sum(Transition(26,:).*expectedvalue(h_choice(i,26),k_choice(i,26),b,orderpoly),2)   sum(Transition(27,:).*expectedvalue(h_choice(i,27),k_choice(i,27),b,orderpoly),2)   sum(Transition(28,:).*expectedvalue(h_choice(i,28),k_choice(i,28),b,orderpoly),2)   sum(Transition(29,:).*expectedvalue(h_choice(i,29),k_choice(i,29),b,orderpoly),2)   sum(Transition(30,:).*expectedvalue(h_choice(i,30),k_choice(i,30),b,orderpoly),2)   ...
                                                    sum(Transition(31,:).*expectedvalue(h_choice(i,31),k_choice(i,31),b,orderpoly),2)   sum(Transition(32,:).*expectedvalue(h_choice(i,32),k_choice(i,32),b,orderpoly),2)   sum(Transition(33,:).*expectedvalue(h_choice(i,33),k_choice(i,33),b,orderpoly),2)   sum(Transition(34,:).*expectedvalue(h_choice(i,34),k_choice(i,34),b,orderpoly),2)   sum(Transition(35,:).*expectedvalue(h_choice(i,35),k_choice(i,35),b,orderpoly),2)   ...
                                                    sum(Transition(36,:).*expectedvalue(h_choice(i,36),k_choice(i,36),b,orderpoly),2)   ];
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
                        [BC(i,:),h_choice(i,:),i_choice(i,:),  k_choice(i,:), c_choice(i,:), income(i,:), util(i,:), TV(i,:)] = VFI_Interpolation_Grid( wages, r, b_lim, h(hx(i)), kap(kapx(i)),i_policy(i,:), k_policy(i,:), B_h, veta_h, theta_h, mu, phi, beta, Transition, b, orderpoly);
                end
                
		        vficrit = norm(Value_Function-TV,inf); % calculate vfi convergence
                Value_Function = TV;    % Update VF

                i_policy = i_choice; % Update Policy
                k_policy = k_choice; % Update Policy
                
                b = interpV(Value_Function,h(hx),kap(kapx),orderpoly); % Get Coefficients for VF Approximation    
                b_store=b; % Update Coefficients
                
                vfi_iter = vfi_iter+1; % increase counter

		        if vficrit>10^4 || vfi_iter >30 % make sure to abort if vfi explodes or gets stuck
			        vficrit =-Inf;
		        end

 
            end

	%% Simulate Distribution using Histogram Approach
if vficrit >-Inf
    %% set initial distribution to uniform
 	initdist = ones(nkap,nh,exog).*(1/(nkap*nh*exog));
   
    %% Simulate using histogramm method
        [OMEGA, ~, ~, nn] = nonstochsim_stat(initdist,Transition, h_choice, k_choice, grid_parms);
    
    %% Calculate Target Statistics
        health = (nn>12) + (nn>24) +1;
        for n = 1:3
            Mean_H_Health(n) = h_choice(health==n)'*OMEGA((health==n),end)/sum(OMEGA(:,end).*(health==n));
        end
        Share_HTM = sum(OMEGA(:,end).*(k_choice(:)<=10^-6));
        I_Ratio = (i_choice(:)'*OMEGA(:,end))/(c_choice(:)'*OMEGA(:,end));
        Var_H = var(h_choice(:)',OMEGA(:,end));
        OutputMoments = [Mean_H_Health, Var_H, I_Ratio, Share_HTM];
        TargetMoments = [0.688, 0.577, 0.603, 0.01398, 0.089, 0.19];
        Error = sum([abs(OutputMoments-TargetMoments)./TargetMoments].^2);

        %% Set output to 10^20 in case there has been an error
		    if abs(Error) == Inf
			    Error = 10^20;
		    elseif isnan(Error) 
			    Error = 10^20;
		    elseif ~isreal(Error)
			    Error = 10^20;
		    elseif ~isnumeric(Error)
			    Error = 10^20;
		    end	
else
	Error = 10^20;
end

end
