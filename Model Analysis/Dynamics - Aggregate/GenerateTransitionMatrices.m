%% Generate Exogenous Transition Matrices %%
%% This function constructs the big aggregate exogenous state transition matrices
function [Transitions, Transition_Agg] = GenerateTransitionMatrices(Normal_Transition_Pre, Normal_Transition_Post, Normal_Health_Trans, Shock_Transition_Pre, Shock_Transition_Post, Shock_Health_Trans, PandemicTransition)

    Stat_Transition_combined = repmat([Normal_Transition_Pre, Normal_Transition_Post,Normal_Transition_Post],3,1);%% Normal Transitions
    Shock_Transition_combined = repmat([Shock_Transition_Pre, Shock_Transition_Post,Shock_Transition_Post],3,1); %% Pandemic Transitions
    Recovery_Transition_combined =0.5*Stat_Transition_combined+0.5*Shock_Transition_combined; %% Recovery Transitions
    Recovery_Health_Trans =0.5*Normal_Health_Trans+0.5*Shock_Health_Trans;
    
    Boom_Transition_Pre = Normal_Transition_Pre;
    Boom_Transition_Post = Normal_Transition_Post;
    Boom_Transition_combined=repmat([Boom_Transition_Pre, Boom_Transition_Post,Boom_Transition_Post],3,1);
        
    Transitions(:,:,1) = Shock_Health_Trans.*Shock_Transition_combined;
    Transitions(:,:,2) = Recovery_Health_Trans.*Recovery_Transition_combined;
    Transitions(:,:,3) = Normal_Health_Trans.*Boom_Transition_combined;
    Transitions(:,:,4) = Normal_Health_Trans.*Stat_Transition_combined;

    Transition_Agg = [Transitions(:,:,1)*PandemicTransition(1,1), Transitions(:,:,2)*PandemicTransition(1,2),Transitions(:,:,3)*PandemicTransition(1,3),Transitions(:,:,4)*PandemicTransition(1,4);...
                      Transitions(:,:,1)*PandemicTransition(2,1), Transitions(:,:,2)*PandemicTransition(2,2),Transitions(:,:,3)*PandemicTransition(2,3),Transitions(:,:,4)*PandemicTransition(2,4);...
                      Transitions(:,:,1)*PandemicTransition(3,1), Transitions(:,:,2)*PandemicTransition(3,2),Transitions(:,:,3)*PandemicTransition(3,3),Transitions(:,:,4)*PandemicTransition(3,4);...
                      Transitions(:,:,1)*PandemicTransition(4,1), Transitions(:,:,2)*PandemicTransition(4,2),Transitions(:,:,3)*PandemicTransition(4,3),Transitions(:,:,4)*PandemicTransition(4,4);...
                      ];

end