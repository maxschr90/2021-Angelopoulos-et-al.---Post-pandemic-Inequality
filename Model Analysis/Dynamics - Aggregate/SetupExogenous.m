%% Setup Exogenous Processes %%
%% This function sets up all exogenous processes used in the model
function [Normal_Transition_Pre, Normal_Transition_Post, Pandemic_Transition_Pre, Pandemic_Transition_Post, wages,Normal_Health_Trans, Pandemic_Health_Trans, r,  T, N, PandemicTransition,  worldstate] = SetupExogenous()
     
    %% Employment States & Productivities
          n_groups =3;
          Normal_Transition_Pre = [0.711503348000000,0.161290323000000,0.0438222760000000,0.0511259890000000,0.0133901400000000,0.0112598900000000,0.00213025000000000,0.000912964000000000,0.000912964000000000,0.00182592800000000,0.000608643000000000,0.00121728500000000;0.136965152000000,0.626819585000000,0.140273489000000,0.0500661670000000,0.0213939130000000,0.0119100130000000,0.00286722500000000,0.00154389100000000,0.00176444600000000,0.000882223000000000,0.000441112000000000,0.00507278300000000;0.0464423940000000,0.199464126000000,0.642453111000000,0.0133968440000000,0.0479309320000000,0.0288776420000000,0.00357249200000000,0.00357249200000000,0.00654956800000000,0.00119083100000000,0.00119083100000000,0.00535873800000000;0.0193726940000000,0.0277905900000000,0.00449723200000000,0.686692804000000,0.185078413000000,0.0525830260000000,0.00853321000000000,0.00438191900000000,0.00484317300000000,0.00196033200000000,0.00115313700000000,0.00311346900000000;0.00448082700000000,0.0110297290000000,0.0133563120000000,0.139250323000000,0.624558380000000,0.164325722000000,0.0121499350000000,0.0105988800000000,0.00801378700000000,0.00292977200000000,0.00318828100000000,0.00611805300000000;0.00338327700000000,0.00555824100000000,0.0144997580000000,0.0561865640000000,0.230425326000000,0.626993717000000,0.00579990300000000,0.0158289030000000,0.0180038670000000,0.00410826500000000,0.00628322900000000,0.0129289510000000;0.00305470700000000,0.00388780900000000,0.00444321000000000,0.0319355730000000,0.0458206050000000,0.0172174400000000,0.627325743000000,0.189947237000000,0.0455429050000000,0.00916412100000000,0.0113857260000000,0.0102749240000000;0.000209424000000000,0.00230366500000000,0.00397905800000000,0.00900523600000000,0.0351832460000000,0.0387434550000000,0.149319372000000,0.536544503000000,0.184502618000000,0.00879581200000000,0.0140314140000000,0.0173821990000000;0.000611247000000000,0.00275061100000000,0.00672371600000000,0.0122249390000000,0.0284229830000000,0.0595965770000000,0.0547066010000000,0.253361858000000,0.526894866000000,0.00611246900000000,0.0177261610000000,0.0308679710000000;0,0.00199700400000000,0.00199700400000000,0.00349475800000000,0.0239640540000000,0.0284573140000000,0.0179730400000000,0.0329505740000000,0.0119820270000000,0.561158263000000,0.250124813000000,0.0659011480000000;0.000333111000000000,0.000666223000000000,0.00133244500000000,0.00433044600000000,0.0143237840000000,0.0363091270000000,0.0139906730000000,0.0556295800000000,0.0379746840000000,0.167221852000000,0.500333111000000,0.167554963000000;0.00140252500000000,0.00374006500000000,0.00935016400000000,0.00841514700000000,0.0275829830000000,0.0645161290000000,0.0168302950000000,0.0500233750000000,0.0677886860000000,0.0677886860000000,0.240299205000000,0.442262740000000];
          Normal_Transition_Post  = [0.705555556000000,0.116666667000000,0.0611111110000000,0.0722222220000000,0.00555555600000000,0.0222222220000000,0.00555555600000000,0,0,0.0111111110000000,0,0;0.116731518000000,0.653696498000000,0.136186770000000,0.0466926070000000,0.0272373540000000,0.0116731520000000,0,0.00389105100000000,0.00389105100000000,0,0,0;0.0600000000000000,0.206666667000000,0.653333333000000,0.00666666700000000,0.0266666670000000,0.0200000000000000,0,0.00666666700000000,0.00666666700000000,0.00666666700000000,0,0.00666666700000000;0.0176678450000000,0.0176678450000000,0.00176678400000000,0.734982332000000,0.150176678000000,0.0530035340000000,0.00883392200000000,0,0.00353356900000000,0.00176678400000000,0.00530035300000000,0.00530035300000000;0.00870827300000000,0.00870827300000000,0.0101596520000000,0.126269956000000,0.648766328000000,0.142235123000000,0.0145137880000000,0.00725689400000000,0.0145137880000000,0.00435413600000000,0.00580551500000000,0.00870827300000000;0,0.00635593200000000,0.0127118640000000,0.0508474580000000,0.207627119000000,0.625000000000000,0.00635593200000000,0.0190677970000000,0.0254237290000000,0.0127118640000000,0.0148305080000000,0.0190677970000000;0,0,0,0.0218340610000000,0.0436681220000000,0.0262008730000000,0.624454148000000,0.183406114000000,0.0393013100000000,0.0349344980000000,0.0131004370000000,0.0131004370000000;0,0,0.00692041500000000,0,0.0346020760000000,0.0207612460000000,0.179930796000000,0.498269896000000,0.200692042000000,0.0138408300000000,0.0207612460000000,0.0242214530000000;0,0,0,0.0109489050000000,0.0218978100000000,0.0620437960000000,0.0583941610000000,0.164233577000000,0.616788321000000,0.00364963500000000,0.0328467150000000,0.0291970800000000;0,0.00194174800000000,0,0,0.00194174800000000,0.00776699000000000,0.0135922330000000,0.00776699000000000,0.00776699000000000,0.700970874000000,0.231067961000000,0.0271844660000000;0,0.00202839800000000,0,0,0.0121703850000000,0.0121703850000000,0,0.0162271810000000,0.0121703850000000,0.269776876000000,0.503042596000000,0.172413793000000;0,0,0.00349650300000000,0,0,0.0209790210000000,0.0139860140000000,0.0244755240000000,0.0314685310000000,0.101398601000000,0.293706294000000,0.510489510000000];
          Pandemic_Transition_Pre = Normal_Transition_Pre;
          Pandemic_Transition_Post = Normal_Transition_Post;                                
          wages_Normal = repmat([2.25153923300000;1.45145218300000;0.902928998000000;1.63457864600000;1.00168807100000;0.588697138000000;1.08790704100000;0.702977449000000;0.444859442000000;0.755734786000000;0.469591037000000;0.251809510000000],3,1);        % idiosyncratic productivity states      
          wages_Normal = (wages_Normal')/[1.03953360209967]; % standardize to ensure mean eranings are 1 in SS
    %% Productivities for all aggregate states
          wages(1,:) = [1.97794089262411	1.31042030794503	0.816765410900043	1.43595097022835	0.907842453418369	0.534567510625239	0.982199411306947	0.635894590004018	0.403955428246150	0.726994090882250	0.451732426976397	0.242233160612981	1.97794089262411	1.31042030794503	0.816765410900043	1.43595097022835	0.907842453418369	0.534567510625239	0.982199411306947	0.635894590004018	0.403955428246150	0.726994090882250	0.451732426976397	0.242233160612981	1.97794089262411	1.31042030794503	0.816765410900043	1.43595097022835	0.907842453418369	0.534567510625239	0.982199411306947	0.635894590004018	0.403955428246150	0.726994090882250	0.451732426976397	0.242233160612981];
          wages(2,:) = [2.07190892697392	1.35332858102095	0.842672995598527	1.50417014229675	0.935712767700540	0.550435174938940	1.01436045177606	0.656064999683442	0.415946110443821	0.726994090882250	0.451732426976397	0.242233160612981	2.07190892697392	1.35332858102095	0.842672995598527	1.50417014229675	0.935712767700540	0.550435174938940	1.01436045177606	0.656064999683442	0.415946110443821	0.726994090882250	0.451732426976397	0.242233160612981	2.07190892697392	1.35332858102095	0.842672995598527	1.50417014229675	0.935712767700540	0.550435174938940	1.01436045177606	0.656064999683442	0.415946110443821	0.726994090882250	0.451732426976397	0.242233160612981];
          wages(3,:) = wages_Normal;
          wages(4,:) = wages_Normal;

    %% Health Shocks
          Normal_ShockProb =  repelem([0.0101503400000000,0.00924064300000000,0.0115799800000000,0.0248253310000000],1,n_groups)';
          Normal_RecoveryProb = [0.0895];
          Normal_Health_Trans = [repmat(1-Normal_ShockProb,1,4*n_groups),repmat(Normal_ShockProb,1,4*n_groups), zeros(4*n_groups);...
                                   zeros(4*n_groups), zeros(4*n_groups), ones(4*n_groups);...
                                   ones(4*n_groups)*Normal_RecoveryProb,      zeros(4*n_groups), 1-ones(4*n_groups)*Normal_RecoveryProb];          
          Pandemic_ShockProb = Normal_ShockProb.*repelem([1.14711914062500	1.43389892578125	2.00745849609375	1.50000000000000],1,n_groups)';
          Pandemic_RecoveryProb = [0.0895];
          Pandemic_Health_Trans = [repmat(1-Pandemic_ShockProb,1,4*n_groups),repmat(Pandemic_ShockProb,1,4*n_groups), zeros(4*n_groups);...
                                   zeros(4*n_groups), zeros(4*n_groups), ones(4*n_groups);...
                                   ones(4*n_groups)*Pandemic_RecoveryProb,      zeros(4*n_groups), 1-ones(4*n_groups)*Pandemic_RecoveryProb];

    %% Time Series of Aggregate States
        load('..\Data\Pandemic_Transition_Narrative.mat'); % load aggregate transition matrix
        %% Find long run interest rate
        LongRunStat = PandemicTransition^10000;
        Er = @(y) [0, y/2, y/2, y]*LongRunStat(1,:)' -0.0056;
        z = fsolve(@(y) Er(y),0.0056);
        r = repelem([0, z/2, z/2, z],1,36);

    %% Simulate Panel of aggregate states
        T = 51; 
        N = 5000;
	    rng(1001) % for replicability
        worldstate = NaN(N,T);
        worldstate(:,1) = 1;
        d = rand(size(worldstate,1),T);
        for t = 1:T
           CT = [zeros(size(PandemicTransition,1),1)  cumsum(PandemicTransition(:,:),2)];
            for i= 1: size(worldstate,1)
                [~,~,worldstate(i,t+1)] = histcounts(d(i,t),CT(worldstate(i,t),:));
            end
        end
        worldstate = [5*ones(N,1),  worldstate(:,1:end-1)]; % set first period to pre-COVID
end 
 
