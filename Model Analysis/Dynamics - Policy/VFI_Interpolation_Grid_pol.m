%% VFI 
%% This function solves the households problem, with policy when applicable
function [BC,h_choice,i_choice, k_choice, c_choice, y, util, TV, cost] = VFI_Interpolation_Grid_pol(wage, r, blim, h_t, k_t,i_tt, k_tt, B_h, veta_h, theta_h,  mu, phi, beta, Transition,  b, orderpoly, cap, riskpremium, coverage, rr)
    %% Calculate availabe resources
    if k_t<0
        r=riskpremium+r; % set interest higher for those in debt
    end
    %% Apply Policy
    cost = zeros(size(wage));
    if k_t<=0.2411*coverage
        [wage, cost] = calculatepolicy(wage, rr, []);
    end
        y = wage+(1+r).*k_t;

    %% For each productivity State find optimal choices and the value of the VF        
        options = optimoptions(@fmincon,'Display','off','OptimalityTolerance', 1e-06, 'StepTolerance', 1e-6','SpecifyObjectiveGradient',false, 'DerivativeCheck', 'off','Algorithm','sqp');
            parfor n = 1:size(wage,2)
                [z(:,n),fval(n)] = fmincon(@(x)bellman(x(1),x(2),x(3),h_t,veta_h(n), b,orderpoly,Transition(n,:),theta_h,B_h(n),beta,mu,phi), [i_tt(n),k_tt(n), min(cap(n),y(n)-i_tt(n)-k_tt(n))]',[1,1,1],y(n),[],[],[((max(0,0.1-veta_h(n)*h_t))/B_h(n))^(1/theta_h),blim,0]',[min(y(n)-blim,((1-veta_h(n)*h_t)/B_h(n))^(1/theta_h)),y(n)-blim,min(cap(n),y(n)-blim)]',[], options);
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