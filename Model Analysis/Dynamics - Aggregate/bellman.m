%% Bellman Equation 
%% This Function Evaluates the (negative) Bellman Equation at given state-choice combination

function [V] = bellman(i,k_tt,c,h_t,veta_h, b,orderpoly,Transition,theta_h,B_h,beta,mu,phi)
    V = -((((((((c)^(1-phi))*(((h_t*veta_h+B_h*(i^theta_h)))^phi))).^(1-mu)))./(1-mu))+beta*expectedvalue(h_t*veta_h+B_h*(i^theta_h),k_tt,b,orderpoly)*Transition') ;
    % We use the negative of V so it can be passed to fmincon
end